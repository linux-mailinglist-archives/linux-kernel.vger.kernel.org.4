Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84761061D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiJ0XHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiJ0XHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:07:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9528FD5E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:07:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 192so3251973pfx.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7ZwQDjmVNpyM8eGvcKf07ueI+SDPbraRsgxG6I2tAA=;
        b=WisfFTtx21I3yqt1Nw+D22CSWrVOJmj7hFRDeeNpMuh+d9TYXw1VuJ49uIHY7FDFLf
         QwNjrKCjuMdoT0p+T6bSTq8jqPodRhe10wL6RwRkSS4M3+ewLLesWmMJnSd3teIhxL+N
         zDbAru2xMUit2cvozy+Ra1M8Srys3eY/J78hs7ltUjNshk31fVWeiNBctB4sD5s1A7xD
         D319ddMvV7NzwR0LxPDQR9gp7jBJQHiM+Hzb4odFWCvVOgn0tgYnv6o7UFMPVAEmwjcV
         6+9Cm28Nd3IeXH6kUDaNcHaKUdnt5WOV1rG7gig5Cdw2uZWmT28LRAIHHzz9fCgtXhbm
         bexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7ZwQDjmVNpyM8eGvcKf07ueI+SDPbraRsgxG6I2tAA=;
        b=0ycJvr9jjUpHZT4KBKvq9dyfdoz+BC3JatwvUPx3CxXh0fvjPB+YPoAh2WC/Rr6s2q
         Zn+5yRspATQiRTqfzHl30UC1Uvk5dY4untcVorTZUa1XVf83p4l76SlViuT9htSo4JYa
         RSE80SrDK/Nx4fGauJgnc4tK+Vs019yxEkeBDuokyBeth+fmY7Ave5W/4MxwA/a7bCDe
         ywiR1ICFdgn/no5SWPM/UX+MHSV9qpaszkYt46BbzYjZq3wDtUnAMGaD1VO5BMEIsA1+
         7g3cGrGJWM/HNyVUh+X6I9XvqXFBQSpIGasOnrpZ6HoCkkwkEpLc3Gx2LyNNMo7y8cDi
         mNOQ==
X-Gm-Message-State: ACrzQf3nNx7+KGr1mXKhOcbp7EJ+w02ct4MB5ZHv0OQUm+oMfzHBPng0
        KDYZvK0/UxbYAVJ5FG0JIZBRHQ==
X-Google-Smtp-Source: AMsMyM4lCRpo1/qoPrU+4TKGZmkjoDHiZs2bxqR+mCtLWFWFfk6AdJihtpcbgbgxmAwz131aJaiFcw==
X-Received: by 2002:a05:6a00:2342:b0:56b:e64c:e065 with SMTP id j2-20020a056a00234200b0056be64ce065mr21562480pfj.32.1666912044311;
        Thu, 27 Oct 2022 16:07:24 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id f4-20020a62db04000000b00560cdb3784bsm1665664pfg.60.2022.10.27.16.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:07:23 -0700 (PDT)
Date:   Thu, 27 Oct 2022 16:07:23 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Oct 2022 15:45:24 PDT (-0700)
Subject:     Re: [PATCH] Revert "clocksource/drivers/riscv: Events are stopped during CPU suspend"
In-Reply-To: <20221023185444.678573-1-conor@kernel.org>
CC:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        Conor Dooley <conor.dooley@microchip.com>, samuel@sholland.org,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, dmitriy@oss-tech.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-57a8ff91-b9b1-4667-96be-3f8fed25dcc6@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022 11:54:44 PDT (-0700), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> This reverts commit 232ccac1bd9b5bfe73895f527c08623e7fa0752d.
> If an AXI read to the PCIe controller on PolarFire SoC times out, the
> system will stall, with an expected:
> 	 io scheduler mq-deadline registered
> 	 io scheduler kyber registered
> 	 microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
> 	 microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: axi read request error
> 	 microchip-pcie 2000000000.pcie: axi read timeout
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 Freeing initrd memory: 7336K
> 	 mc_event_handler: 667402 callbacks suppressed
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 mc_event_handler: 666588 callbacks suppressed
> <truncated>
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	mc_event_handler: 666748 callbacks suppressed
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> 	rcu: 	0-...0: (1 GPs behind) idle=19f/1/0x4000000000000002 softirq=34/36 fqs=2626
> 		(detected by 1, t=5256 jiffies, g=-1151, q=1143 ncpus=4)
> 	Task dump for CPU 0:
> 	task:swapper/0       state:R  running task     stack:    0 pid:    1 ppid:     0 flags:0x00000008
> 	Call Trace:
> 	mc_event_handler: 666648 callbacks suppressed
>
>  With this patch applied, the system just locks up without RCU stalling:
> 	io scheduler mq-deadline registered
> 	io scheduler kyber registered
> 	microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
> 	microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: axi read request error
> 	microchip-pcie 2000000000.pcie: axi read timeout
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	Freeing initrd memory: 7332K
>
> Link: https://lore.kernel.org/linux-riscv/YzYTNQRxLr7Q9JR0@spud/
> Fixes: 232ccac1bd9b ("clocksource/drivers/riscv: Events are stopped during CPU suspend")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I don't really want to post a revert, but it's been nearly a month since
> I posted about my issue initially & 2 weeks without a reply to Palmer's
> comments.
> CC: samuel@sholland.org
> CC: aou@eecs.berkeley.edu
> CC: atishp@atishpatra.org
> CC: daniel.lezcano@linaro.org
> CC: dmitriy@oss-tech.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: palmer@dabbelt.com
> CC: paul.walmsley@sifive.com
> CC: tglx@linutronix.de
> ---
>  drivers/clocksource/timer-riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 969a552da8d2..a0d66fabf073 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -51,7 +51,7 @@ static int riscv_clock_next_event(unsigned long delta,
>  static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>  	.name			= "riscv_timer_clockevent",
> -	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
>  	.rating			= 100,
>  	.set_next_event		= riscv_clock_next_event,
>  };

There's some discussion on that linked patch and we don't really have a 
fix yet, but IMO we're better off reverting this as it breaks the common 
case and it's not clear this is even a sane way to fix the bug.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
