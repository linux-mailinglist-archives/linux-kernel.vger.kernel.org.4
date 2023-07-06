Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8C87494BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjGFEkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFEkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:40:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D61172B;
        Wed,  5 Jul 2023 21:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B7C61756;
        Thu,  6 Jul 2023 04:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549DDC433C7;
        Thu,  6 Jul 2023 04:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688618439;
        bh=y5GCuqAioT/34dPap7dnGb1XGksA8JQvvySNxxTyRYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=URs2daytwSoqsYwHakqZPZ55HNhwOTy6C9ji3/eQJPtk/E1gTSZdv4AIl0PuABD6P
         xuFwXu9aWyCGx7lNVQE8Rwr0eIoEpm0iyUtkeS/X6kXrqaGg0/HRd1o0E1yunbv3vx
         ieVFsx0iaHkADCg/Uo60i/tH185tozX+VZstv2nvkEqJ0agdKv8VrIf4/b4riVIBaT
         a69km68ZeF1SpDW2tRW+ZpjC0dkMyt9sc350PUJxRM6rmlLqVaMjsH6U8xcE+JbNHA
         oeQWcGpZ0ukFEiRNDfrZnoIC93svXaz7omM3BvFZ7aiQxYKQSMtLyK1v9wuE69uNiO
         u4LvWOeRFhWuQ==
Date:   Thu, 6 Jul 2023 13:40:36 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tracing/probes: Fix return value when "(fault)" is
 injected
Message-Id: <20230706134036.5c074aa5fc6a55cdb5038660@kernel.org>
In-Reply-To: <20230705224956.1c5213e6@gandalf.local.home>
References: <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
        <168830925534.2278819.7237772177111801959.stgit@mhiramat.roam.corp.google.com>
        <20230705224956.1c5213e6@gandalf.local.home>
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

On Wed, 5 Jul 2023 22:49:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun,  2 Jul 2023 23:47:35 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > When the "(fault)" is injected, the return value of fetch_store_string*()
> > should be the length of the "(fault)", but an error code is returned.
> > Fix it to return the correct length and update the data_loc according the
> > updated length.
> > This needs to update a ftracetest test case, which expects trace output
> > to appear as '(fault)' instead of '"(fault)"'.
> > 
> 
> Ah, because of patch 2, the ret < 0 makes it return without printing the
> "fault"?

No, actually set_data_loc() updates the 'ret' argument, but it is just
disposed... (not returned to the caller)

-static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
+static nokprobe_inline int set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
 {
-	if (ret >= 0) {
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-	} else {
+	if (ret < 0) {
 		strscpy(__dest, FAULT_STRING, len);
 		ret = strlen(__dest) + 1;
 	}
+
+	*(u32 *)dest = make_data_loc(ret, __dest - base);
+	return ret;
 }

So this returns updated 'ret', and also update data_loc to use the
updated 'ret' value (which is the length of the stored data).

> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you!

> 
> -- Steve
> 
> 
> > Fixes: 2e9906f84fc7 ("tracing: Add "(fault)" name injection to kernel probes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
