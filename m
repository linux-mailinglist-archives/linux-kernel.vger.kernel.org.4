Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFFD717C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjEaJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjEaJom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BDBE2;
        Wed, 31 May 2023 02:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0AB9628FA;
        Wed, 31 May 2023 09:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E363C433D2;
        Wed, 31 May 2023 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685526278;
        bh=gXpZQt0fiMNuulQi+USO5kyFDwAyiy8/7Or+1AC5GE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U0PGCKlkt8+cOC9kO/FI3GYayjP9ZEKsXFEI3idqCsujVwIOjfQ/Wg0fU4yH5QSuW
         XlEFnem7/UC5W0+8g0kpUxHspMOLRsbd0mpu02K55PoEMelvOY3bKwXj72kj68ysSb
         /HOT0ViaRy7czmP5Icn3fCPm8Q2D1H6R0vZEkhDTb/qSXQiQRdwGEOUnogiiaLtHDu
         J1MmYFUtiSARnJelNGW8bitE+YqYro9ASn3dXEy+Kk/wMb1liYGlGihjLzouxpNQp1
         +9djjek8wZlGG/RgTTCK1FbMNMAgGuJ7BdcCzqFuMJUhQfHwYngT9VBaOBgZl0gew0
         KXZCDHnSBlDIA==
Date:   Wed, 31 May 2023 18:44:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobe: use preempt_{disable, enable}_notrace in
 kprobe_busy_{begin, end}
Message-Id: <20230531184434.1bbc15d8ed2f192581560e4f@kernel.org>
In-Reply-To: <20230513090548.376522-1-zegao@tencent.com>
References: <20230513090548.376522-1-zegao@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 13 May 2023 17:05:48 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Replacing preempt_{disable, enable} with its corresponding notrace
> version in kprobe_busy_{begin, end} because they are called by
> fprobe_kprobe_handler. Such changes would resolve the potential
> stack recursion or overflow problem introduced by preempt_count
> _{add, sub} when these functions themselves accidentally traced
> by fprobe+rethook, and does not break the original semantics.

As I explained below;

https://lore.kernel.org/all/20230517010311.f46db3f78b11cf9d92193527@kernel.org/

we don't need this for kprobes because kprobes already prohibits
probing on preempt_count_{add,sub}, and we don't want to miss
tracing the preempt-off period by kprobes itself.

Thank you,

> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  kernel/kprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 00e177de91cc..94d01b5d0646 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1242,7 +1242,7 @@ void kprobe_busy_begin(void)
>  {
>  	struct kprobe_ctlblk *kcb;
>  
> -	preempt_disable();
> +	preempt_disable_notrace();
>  	__this_cpu_write(current_kprobe, &kprobe_busy);
>  	kcb = get_kprobe_ctlblk();
>  	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> @@ -1251,7 +1251,7 @@ void kprobe_busy_begin(void)
>  void kprobe_busy_end(void)
>  {
>  	__this_cpu_write(current_kprobe, NULL);
> -	preempt_enable();
> +	preempt_enable_notrace();
>  }
>  
>  /* Add the new probe to 'ap->list'. */
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
