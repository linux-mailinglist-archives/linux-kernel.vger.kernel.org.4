Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0C5B38A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIINJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiIINIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE77465C7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4113D61FDD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C5EC433C1;
        Fri,  9 Sep 2022 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662728870;
        bh=b1MPtaMvM1L/buh0iIgAugb7UJAFs0mTGZzDORsAF50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IFoYbPTuJ6FtM0p/1M9xheFP73eQ6HODTq5Ps//iuLyRcXWpldmvAek0p+yVuGDsx
         i7qQAUE5g8qJc9/9yeUxo4aI8Cg35o4Rhlmee8s0isVtkFLzW9hGleMx/h1nvTS2Ho
         ErKz2vnxPsQAUYIiO67MWx5YYldURHHeQUeHEZT6uiY9xSabSnaHigNioLyCD37sJm
         ybgDxJHqe/x/oRFwwScB6fQKjOkpIaLNnLMLByVhFfmhmoWmgX3eOUHkkPlgaT10ge
         uXgBP5a4Mx80hzIlXfMykVV5zBSv9rl0W49g34WiKKHOR/eEJ2J3hVAfhidROQ61fT
         aYpIPYJwCKsxg==
Date:   Fri, 9 Sep 2022 22:07:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Li Qiang <liq3ea@163.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        liq3ea@gmail.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kprobe: reverse kp->flags when arm_kprobe failed
Message-Id: <20220909220746.a7826cb2fb9da02171b38237@kernel.org>
In-Reply-To: <20220902155820.34755-1-liq3ea@163.com>
References: <20220902155820.34755-1-liq3ea@163.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Sep 2022 08:58:20 -0700
Li Qiang <liq3ea@163.com> wrote:

> In aggregate kprobe case, when arm_kprobe failed,
> we need set the kp->flags with KPROBE_FLAG_DISABLED again.
> If not, the 'kp' kprobe will been considered as enabled
> but it actually not enabled.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/kprobes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 08350e35a..333454df5 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2424,8 +2424,11 @@ int enable_kprobe(struct kprobe *kp)
>  	if (!kprobes_all_disarmed && kprobe_disabled(p)) {
>  		p->flags &= ~KPROBE_FLAG_DISABLED;
>  		ret = arm_kprobe(p);
> -		if (ret)
> +		if (ret) {
>  			p->flags |= KPROBE_FLAG_DISABLED;
> +			if (p != kp)
> +				kp->flags |= KPROBE_FLAG_DISABLED;
> +		}
>  	}
>  out:
>  	mutex_unlock(&kprobe_mutex);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
