Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79F74AB6B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjGGGzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGGzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3EC130;
        Thu,  6 Jul 2023 23:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55478617AF;
        Fri,  7 Jul 2023 06:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B475DC433C8;
        Fri,  7 Jul 2023 06:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688712900;
        bh=InXyUWtqFrBQuH6612+y4sxM0GiKAB/YG+tM8Ire5QI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gQwS3GvLCWjhWaa+EK/zx6BAomvZG0Ct8xlSevrE5+39vWutLn+VOjZuFSI3YLCtJ
         p2fUsrHHY/R1LEqpBKC6iDHY5OUxdgDyWkUovI+EGpxPmF0xjj3dIuDmTxvBUlJ8Pd
         tG5lWHqlvM5kaU3RcFalPX12dXJ5l4Va5XkT0AZwwWorAz6PuMRbBq4jZYHuE2X9Ka
         fE9tjLnyeGUfv1A/fhmdiBBLVKyGeVLrPWv1gFGjKu67kng9RuVMtzkA2gWf6cmHKe
         nHpwbWbdOBRcpy4GXmQRcJherDo9+QScpkTFdEWc4W8By7iSGRu3M6o+MmWXriQFiT
         8XBAGz3jk/B7g==
Date:   Fri, 7 Jul 2023 15:54:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tracing/probes: Fix return value when "(fault)" is
 injected
Message-Id: <20230707155457.1ec90d8b14e66fe0efbb3699@kernel.org>
In-Reply-To: <20230706230642.3793a593@rorschach.local.home>
References: <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
        <168830925534.2278819.7237772177111801959.stgit@mhiramat.roam.corp.google.com>
        <20230705224956.1c5213e6@gandalf.local.home>
        <20230706134036.5c074aa5fc6a55cdb5038660@kernel.org>
        <20230706095039.1cb9c9d1@gandalf.local.home>
        <20230707110210.06e81e182c775454ce86280d@kernel.org>
        <20230706222020.6e5c8e89@rorschach.local.home>
        <20230707115128.80b6acf06f4bfa996d9d0808@kernel.org>
        <20230706230642.3793a593@rorschach.local.home>
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

On Thu, 6 Jul 2023 23:06:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Jul 2023 11:51:28 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Ah, I meant that your commit 2e9906f84fc7 ("tracing: Add "(fault)" name injection
> >  to kernel probes") tries to make it '"(fault)"', So it makes 
> > 
> >        trace-cmd-4688    [000] ...1. 466968.015879: myopen: (syscalls.sys_enter_openat) file="(fault)"
> > 
> > Keeping it current '(fault)' makes easy to identify which one is failed to fetch,
> > but it may require user to parse both "some string" and (fault). I thought that
> > was the reason why you added that commit.
> 
> Hmm, That commit didn't explicitly add the double quotes. That may just
> have been a side effect of passing back the string?
> 
> But I agree, just (fault) instead of "(fault)" is more explicit that it
> faulted.

OK, let me revert that commit and clarify what the data_loc data should be
with fault case.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
