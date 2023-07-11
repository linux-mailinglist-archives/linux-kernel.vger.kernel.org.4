Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465574F9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGKVdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGKVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:33:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C725D127
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:33:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2637ab3d8efso3263504a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689111222; x=1691703222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvuSShR5Lja/sWLhqEJ8f1sBqVSHXJXfUNvifDwCXKk=;
        b=q5d5g2PHO9Z0ndm5GlEnM8SoepKi3YqfogzE5ma4LWhxSalITcdq+OV7UEtJvsxNnf
         XWN0VcZx8qGPjb5JFeVcHUUt/UPpazxX+T1pECug8WIGkHa5j5YcMSZjqJxNmhHaMI0F
         W7mJupotsDGMeBb2mx6DQRXBReodL6/dtETJkL1VlWcVjHpcn8MFBP6K/Gi8Ro0TJZvp
         OeGZ2Dj0DZiE1CpkQMAb6FZFBT/t967ODT5gjKcLOwhH+v0/q2FjfXvG7SLki1kREeqd
         mWsueKBaQGHuLxWolznTe8vmVGfvsjx493ClQRjO9KKjCNyo6EgNJa8gEHznIXIwhjKg
         bCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689111222; x=1691703222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvuSShR5Lja/sWLhqEJ8f1sBqVSHXJXfUNvifDwCXKk=;
        b=IfleAfi3jL23wJcvGE8CWSzmIsQsrjnoB/VT1ypQVKK8d20sWGichDdp2C6HWbUfAo
         MVsQEsQeLHJleUbydK7NgjuoPKLBF6u++uLyo/IHEXqKq9pd5fbtteXN15fA6QNAk4hs
         UkgcqxL+sYJk/J89F7DhWSTgO23Jkvu/3vXpfl2Rxxc11cJASA03uVeWe3eoZhIOMwO2
         UJfIJqdVU+eBvj38i65xG4qDnl1tM6/hHiuvW41diWaFTMfaMAVKkW6T5pGXfztZt5My
         gHzDyF/+BmE4QESYSGkGtnzCi4RPoOpub7bEoWZ8CJM3hW2Pboeu1gOyp4Ut3lj0UlFg
         WiVQ==
X-Gm-Message-State: ABy/qLYKBzRcc7NbBlunXR0flNlR2bzy1M20XhIQ7CsiNlqqE4uCxUUQ
        wV09TadgAQz9J1b5H1li0218KBvtABQpvg==
X-Google-Smtp-Source: APBJJlEDPtfLOWkhs5DGx7xtqLSjPS7MqQIMc5/gxhm2FBgLH2GdfDRNSGwi6SOMWLiWvlV7uxuucg==
X-Received: by 2002:a17:90a:8b82:b0:256:2fd4:e238 with SMTP id z2-20020a17090a8b8200b002562fd4e238mr12910280pjn.38.1689111221959;
        Tue, 11 Jul 2023 14:33:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9374])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a68c900b0024e4f169931sm8597894pjj.2.2023.07.11.14.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:33:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Jul 2023 11:33:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix cpu_intensive_thresh_us name in help text
Message-ID: <ZK3Ks3gkO7XykGYY@slm.duckdns.org>
References: <5fc042e1d3c5d63b9367a1e1587dcf6b548087ff.1689071768.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc042e1d3c5d63b9367a1e1587dcf6b548087ff.1689071768.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:38:20PM +0200, Geert Uytterhoeven wrote:
> There exists no parameter called "cpu_intensive_threshold_us".
> The actual parameter name is "cpu_intensive_thresh_us".
> 
> Fixes: 6363845005202148 ("workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c8371502b4b2e678..5da00849edebafdd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1200,7 +1200,7 @@ config WQ_CPU_INTENSIVE_REPORT
>  	help
>  	  Say Y here to enable reporting of concurrency-managed per-cpu work
>  	  items that hog CPUs for longer than
> -	  workqueue.cpu_intensive_threshold_us. Workqueue automatically
> +	  workqueue.cpu_intensive_thresh_us. Workqueue automatically
>  	  detects and excludes them from concurrency management to prevent
>  	  them from stalling other per-cpu work items. Occassional
>  	  triggering may not necessarily indicate a problem. Repeated

Applied to wq/for-6.5-fixes.

Thanks.

-- 
tejun
