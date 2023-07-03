Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3667D745844
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGCJVV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 05:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjGCJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:21:20 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D038196;
        Mon,  3 Jul 2023 02:21:16 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5703cb4bcb4so43711467b3.3;
        Mon, 03 Jul 2023 02:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376075; x=1690968075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPwypF39ZCUKsLagUyYf4fjfP/lAX8+xFUXsEK1JeIU=;
        b=SJNxUilm8rar14BE6daSm5XbJdR6JEoOS/bny9ZEGqJO8ZvgvVWCCoZKedy5FiLJHt
         gXhJ19DobiBr71SF4gSuz2USRDLX4p1KLgyy+551pM5fQXPfica+MeYbhSyuImPRcpBT
         Gempj+ef0YxIaDlTHeSrzvq6JPP5s6WN+MbQrdO1zfCsJvF/dLOUGXJ7X6+ICWdOQRTh
         6ePtdM+DOdkEA94LNznwA276ff+5ArNY5BAlUmBKgfQj6eX24PwIW+kdBS/5+Df4WG4a
         bU2OddbvmhwWyI3kKHasjYPPgzjf6oZMQFaaCUiuQaXLc4rtjBw68FB+moZ532NehIGb
         6pyA==
X-Gm-Message-State: ABy/qLYBF8qGmco4XgYWIb/fBqOraBjDfUoIsHvq5NjBE3xF4BGQUx3V
        od97aR8UEL6ekIJQ5fedaxsE2UNWGXumZA==
X-Google-Smtp-Source: APBJJlHAFZZvauOgB7BlsTbDRdz5OAxQcXKlfy/YzEwFGSxXbVYx0GqNORraEXssx82UQSnQ2LWNYQ==
X-Received: by 2002:a81:8302:0:b0:570:7df7:e401 with SMTP id t2-20020a818302000000b005707df7e401mr10750858ywf.29.1688376075196;
        Mon, 03 Jul 2023 02:21:15 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id d196-20020a814fcd000000b00569eb609458sm4980211ywb.81.2023.07.03.02.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 02:21:14 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so1961353276.3;
        Mon, 03 Jul 2023 02:21:14 -0700 (PDT)
X-Received: by 2002:a25:1983:0:b0:c12:16f7:6ecb with SMTP id
 125-20020a251983000000b00c1216f76ecbmr8112240ybz.55.1688376074483; Mon, 03
 Jul 2023 02:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685983270.git.robin.murphy@arm.com> <9d126711c7498b199b3e6f5cf48ca60ffb9df54c.1685983270.git.robin.murphy@arm.com>
In-Reply-To: <9d126711c7498b199b3e6f5cf48ca60ffb9df54c.1685983270.git.robin.murphy@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jul 2023 11:21:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7kiGni_T1mRU7EC-8sQn8EjhND1-POc2h2V4V8Oeuqg@mail.gmail.com>
Message-ID: <CAMuHMdU7kiGni_T1mRU7EC-8sQn8EjhND1-POc2h2V4V8Oeuqg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf/arm_cspmu: Clean up ACPI dependency
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, Jun 5, 2023 at 7:05 PM Robin Murphy <robin.murphy@arm.com> wrote:
> Build-wise, the ACPI dependency consists of only a couple of things
> which could probably stand being factored out into ACPI helpers anyway.
> However for the immediate concern of working towards Devicetree support
> here, it's easy enough to make a few tweaks to contain the affected code
> locally, such that we can relax the Kconfig dependency.
>
> Reviewed-and-Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks for your patch, which is now commit f9bd34e3753ea8f1
("perf/arm_cspmu: Clean up ACPI dependency") upstream.

> --- a/drivers/perf/arm_cspmu/Kconfig
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -4,8 +4,7 @@
>
>  config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>         tristate "ARM Coresight Architecture PMU"
> -       depends on ARM64 && ACPI
> -       depends on ACPI_APMT || COMPILE_TEST
> +       depends on ARM64 || COMPILE_TEST

From looking at the code, the "arm-cs-arch-pmu" platform device can
be instantiated only through ACPI.  So I think it is a bit premature to
relax the dependency, and expose this question to people configuring
an ARM64 kernel without ACPI/APMT support.

Am I missing something?
Thanks!

>         help
>           Provides support for performance monitoring unit (PMU) devices
>           based on ARM CoreSight PMU architecture. Note that this PMU

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
