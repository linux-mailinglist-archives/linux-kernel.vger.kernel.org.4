Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F4749E22
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjGFNup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjGFNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964FE1990;
        Thu,  6 Jul 2023 06:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2687561962;
        Thu,  6 Jul 2023 13:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA9DC433C7;
        Thu,  6 Jul 2023 13:50:40 +0000 (UTC)
Date:   Thu, 6 Jul 2023 09:50:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tracing/probes: Fix return value when "(fault)" is
 injected
Message-ID: <20230706095039.1cb9c9d1@gandalf.local.home>
In-Reply-To: <20230706134036.5c074aa5fc6a55cdb5038660@kernel.org>
References: <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
        <168830925534.2278819.7237772177111801959.stgit@mhiramat.roam.corp.google.com>
        <20230705224956.1c5213e6@gandalf.local.home>
        <20230706134036.5c074aa5fc6a55cdb5038660@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 13:40:36 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 5 Jul 2023 22:49:56 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sun,  2 Jul 2023 23:47:35 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >   
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > When the "(fault)" is injected, the return value of fetch_store_string*()
> > > should be the length of the "(fault)", but an error code is returned.
> > > Fix it to return the correct length and update the data_loc according the
> > > updated length.
> > > This needs to update a ftracetest test case, which expects trace output
> > > to appear as '(fault)' instead of '"(fault)"'.
> > >   
> > 
> > Ah, because of patch 2, the ret < 0 makes it return without printing the
> > "fault"?  
> 
> No, actually set_data_loc() updates the 'ret' argument, but it is just
> disposed... (not returned to the caller)

That's not what I was talking about.

We have:

process_fetch_insn_bottom() {
	[..]
	case FETCH_OP_ST_STRING:
		loc = *(u32 *)dest;
		ret = fetch_store_string(val + code->offset, dest, base);
		break;
	[..]

// And from patch 2 we have:

@@ -193,6 +193,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	default:
 		return -EILSEQ;
 	}
+	if (ret < 0)
+		return ret;
 	code++;

And now that the return value of fetch_store_string() is being checked, and
if it returns negative, it ends the function before being processed
further. And if there's a fault, it happens to return negative!

This patch now changes fetch_store_string() and fetch_store_string_user()
to not return negative if there's a fault. As this patch has:

@@ -107,9 +106,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * probing.
 	 */
 	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
-
-	return ret;
+	return set_data_loc(ret, dest, __dest, base, maxlen);
 }

But to do that, you needed to update set_data_loc() to return a value.

*that's* what I meant by 

'Ah, because of patch 2, the ret < 0 makes it return without printing the "fault"?'


-- Steve

> 
> -static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
> +static nokprobe_inline int set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
>  {
> -	if (ret >= 0) {
> -		*(u32 *)dest = make_data_loc(ret, __dest - base);
> -	} else {
> +	if (ret < 0) {
>  		strscpy(__dest, FAULT_STRING, len);
>  		ret = strlen(__dest) + 1;
>  	}
> +
> +	*(u32 *)dest = make_data_loc(ret, __dest - base);
> +	return ret;
>  }
> 
> So this returns updated 'ret', and also update data_loc to use the
> updated 'ret' value (which is the length of the stored data).
> 
> > 
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Thank you!
> 
> > 
> > -- Steve
> > 
> >   
> > > Fixes: 2e9906f84fc7 ("tracing: Add "(fault)" name injection to kernel probes")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---  
> 
> 

