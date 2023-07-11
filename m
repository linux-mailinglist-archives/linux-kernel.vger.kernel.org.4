Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269B074E26F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGKAFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGKAFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD21A7;
        Mon, 10 Jul 2023 17:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB3D6125B;
        Tue, 11 Jul 2023 00:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093E2C433C8;
        Tue, 11 Jul 2023 00:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689033917;
        bh=fpEx1KzBsxh6Eprg+XyKsXA/QDGBs37oTsG42veMOSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jVIrs9dfJuWAZ5tenB/x/LPN6h9AJ5PmX+BO6311IFNx2S8I24FShwrZ3apiTPraz
         6qEAx7dSZjUJTP+6TGkk0HaAQS2ZyS8zY99hN2ydFKaMSOKCYIeTxPNo8BPY7YskkT
         nqZ+iW96AX8dRikGlk4P55tv9AFW90xL9A+RsVRWbAJHJnJKGfsipgClqBhzot4kpj
         W4yrX4awGpVnDugQJUxD9/O79mhw7LEuWNZlLjjf15P7f3xk2VV1cQaRZBenolkQbz
         JsC4BnFXxVqxdmJ08cVWnu154PJ3SIoIm7uhPDrk9Wqb1Y19ZJn6o3RtxUsH0O/EUQ
         Ajokjf9fAg0Aw==
Date:   Tue, 11 Jul 2023 09:05:15 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] tracing/probes: Fix to record 0-length data_loc
 in fetch_store_string*() if fails
Message-Id: <20230711090515.3b86f4be7b530200865efd51@kernel.org>
In-Reply-To: <20230710181601.438b79a8@gandalf.local.home>
References: <168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com>
        <168878453829.2721251.15110493517953858343.stgit@mhiramat.roam.corp.google.com>
        <20230710181601.438b79a8@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 18:16:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat,  8 Jul 2023 11:48:58 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > --- a/kernel/trace/trace_probe_kernel.h
> > +++ b/kernel/trace/trace_probe_kernel.h
> > @@ -55,8 +55,7 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
> >  	__dest = get_loc_data(dest, base);
> >  
> >  	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
> > -	if (ret >= 0)
> > -		*(u32 *)dest = make_data_loc(ret, __dest - base);
> > +	*(u32 *)dest = make_data_loc((ret >= 0) ? ret : 0, __dest - base);
> >  
> >  	return ret;
> >  }
> > @@ -87,8 +86,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
> >  	 * probing.
> >  	 */
> >  	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
> > -	if (ret >= 0)
> > -		*(u32 *)dest = make_data_loc(ret, __dest - base);
> > +	*(u32 *)dest = make_data_loc((ret >= 0) ? ret : 0, __dest - base);
> 
> The above is a complex line, and not something that I think should be cut
> and pasted between two different locations.
> 
> I know you took out the set_data_loc() helper, but really it should have
> stayed, and have used that to update this code in the two places it
> affected, instead of making the changes in those two locations.
> 
> That is, patch 3 could have had kept.
> 
> static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
> {
> 	if (ret >= 0)
> 		*(u32 *)dest = make_data_loc(ret, __dest - base);
> }

To avoid confusion, I would like to revert the set_data_loc() at the 3rd patch
and add it again in 4th patch.

> 
> And this patch could have been:
> 
> static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
> {
> 	*(u32 *)dest = make_data_loc(ret, __dest - base);
> }

and introduce it. I also want to put the ternary operator into set_data_loc() too
for simplicity.

static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
{
	if (ret < 0)
		ret = 0;
	*(u32 *)dest = make_data_loc(ret, __dest - base);
}

Thanks,

> 
> That would keep the complexity down in this changes set.
> 
> -- Steve
> 
> 
> >  
> >  	return ret;
> >  }


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
