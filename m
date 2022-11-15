Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B7E629345
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiKOIby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKOIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:31:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDEF631F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:31:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5A26157B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACEBC433C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668501110;
        bh=HhcFH+cadi57qTWbydHQdoKaz29QoMHUVpKX9PxEtsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A5CiupwYH8+BO8Nd/6yw0kQBMp/4zN7GL7KoQGLo6/9Vq1+tNz97T0oheaEAN2FDd
         WGBKiD0XS9Prx729B8lwDT31wLVTdOmrSmLfX+rmPj1qg31K+SBVoGzeJxLjaa7mNJ
         qlsTlGjpROnYtTA7XNPdDweRHP0Bp427g3+vk6pwZnXtHgTPNVTzMSJ/NGA2N/aR9T
         YruKv0ZSYd3gl6WWDM3qS3cNJYBPxfn+9oTpJcszdyOaQOAipU7BPumPjgSR/5pQvc
         Ut75Wy1hKHP0RN6M1mFuMKyFryvRaNTJvFJBOoz3FpeXt671+GAK6Nu3/pFkEE6fwx
         5/PD0m5HM0JVA==
Received: by mail-ed1-f50.google.com with SMTP id s5so4608945edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:31:50 -0800 (PST)
X-Gm-Message-State: ANoB5pkW4jE6yX+vIY1Lj/NOQA0GFGRHNZsNWDxuAct/fCCPjdrF/jVM
        MfVX4NPkwC9s+hT+PzDemS+qDHGRnqbjCh6uJ+M=
X-Google-Smtp-Source: AA0mqf48zfzMA14DyPoh+Ghu+RUlJPZcKfa5azAGVTnXzRlBdVSZuqAE7DFsi2PIRKckonj7bDwcYXCWZ8wwqZTKgY8=
X-Received: by 2002:a05:6402:3715:b0:462:32bf:613a with SMTP id
 ek21-20020a056402371500b0046232bf613amr13628347edb.78.1668501108788; Tue, 15
 Nov 2022 00:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20221115025527.13382-1-zhangqing@loongson.cn> <20221115025527.13382-10-zhangqing@loongson.cn>
In-Reply-To: <20221115025527.13382-10-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 15 Nov 2022 16:31:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5YnpRu=mcdmHy=x9MstTmfFgHU=WV4ZBd49PBkeeZjAA@mail.gmail.com>
Message-ID: <CAAhV-H5YnpRu=mcdmHy=x9MstTmfFgHU=WV4ZBd49PBkeeZjAA@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] LoongArch: Enable CONFIG_KALLSYMS_ALL and CONFIG_DEBUG_FS
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing,

I suggest not enabling debug mechanisms in the default config file,
distribution configs can make their own decisions.

Huacai

On Tue, Nov 15, 2022 at 10:55 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> Defaults enable CONFIG_KALLSYMS_ALL and CONFIG_DEBUG_FS to convenient
> ftrace tests.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/configs/loongson3_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> index 2d4678e6189a..0bbab17609b0 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -34,6 +34,7 @@ CONFIG_SYSFS_DEPRECATED=y
>  CONFIG_RELAY=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> +CONFIG_KALLSYMS_ALL=y
>  CONFIG_USERFAULTFD=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_COMPAT_BRK is not set
> @@ -845,6 +846,7 @@ CONFIG_CRYPTO_DEV_VIRTIO=m
>  CONFIG_PRINTK_TIME=y
>  CONFIG_STRIP_ASM_SYMS=y
>  CONFIG_MAGIC_SYSRQ=y
> +CONFIG_DEBUG_FS=y
>  # CONFIG_SCHED_DEBUG is not set
>  CONFIG_SCHEDSTATS=y
>  # CONFIG_DEBUG_PREEMPT is not set
> --
> 2.36.0
>
>
