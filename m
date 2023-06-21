Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2758B738C53
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjFUQvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjFUQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:51:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDBEE9;
        Wed, 21 Jun 2023 09:51:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6685421cdb3so2972253b3a.1;
        Wed, 21 Jun 2023 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687366300; x=1689958300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU8FTn/iVcg+ffmvipIhzRVqOFXdIt6phQ9/bO8XkYw=;
        b=DVlPUxaHKtrCjGveDjsHWv1JdRyofew/0AkVMPIeSQ0oc74T/OQiZS3wfq9LF8HpMl
         QkakG8EwC5zx3C5PSt5l5caGBOWa6Yxt8kWQuQcIj9DD0XY2zMpNoO3nALANtpek8hVV
         1MsPP25qG29buK36kgreNtVbTCv5U49N/yUbXmwr29v6dYEhrS91dQsr5TyNw+gKSdp4
         M7ipDPgVb+jP9GH7EsavneBdHBtwVWjQSW1KN9wvZwwPpKg0KoeJ2hFuu1GXCR+P5732
         bjlSRrJTXdoJZl5H0+g0X3eV/7eAwi0bdSH5Y0qWkqypZbqsiRcSYYcq/7WWmg4kpdiC
         Dyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366300; x=1689958300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sU8FTn/iVcg+ffmvipIhzRVqOFXdIt6phQ9/bO8XkYw=;
        b=CgAboVtchCktij9FbbNfmK75g25yRyl5mTXXOK+Bx/RaS9Als04BbXu5KzOehlg3uW
         Q6SpZy6wxmtXr8asmDcyu/syNJwwkbjmZUPe7xqe4g9xvIW1oVLyXw9XdL1jXW//I38G
         BL+k7nB0dUpggt8/XND+vd3VRT5dAE2p7Wnudkr62sMCaZIeIwlq4bUwxadyZ8soBZuT
         S4JA1nsM4+Q4kC8crG03G3hDlA5qM5MKXred5sxEKM/0dPmip5uB8HaaaKDgYfC4D/2d
         PPwFpc14dN1oQ+nicEOOwqcLWTvCt+673lgfzGgco2w+uVsvsyx9t7u5bfPV/WKzggbN
         bUvg==
X-Gm-Message-State: AC+VfDzNaRlhP6mysavSDUPk9JRoa0JJFAr6hbeEEXpGeNVlKf3qJp9o
        rCBK0F3VgADDvyHIRwNEUtIKMQP0XWo=
X-Google-Smtp-Source: ACHHUZ7F1cfGzMYwNMZcRoVkjqtDDyS9YrKcKfwTGNi2T0bbBnpoHB0+OAb73+1RsiePa0TKeSKoFQ==
X-Received: by 2002:a05:6a20:430c:b0:117:3c00:77ea with SMTP id h12-20020a056a20430c00b001173c0077eamr22503678pzk.0.1687366300339;
        Wed, 21 Jun 2023 09:51:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b0065992d334f4sm2533367pfc.177.2023.06.21.09.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 09:51:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Jun 2023 09:51:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ata: octeon: Add compile test support
Message-ID: <23325977-ba37-4360-afb5-4ab38a66107e@roeck-us.net>
References: <20230614173633.2430653-1-robh@kernel.org>
 <20230614173633.2430653-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614173633.2430653-2-robh@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:36:33AM -0600, Rob Herring wrote:
> Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
> allyesconfig/allmodconfig builds. There's a dependency on MIPS headers,
> so other arches can't be enabled.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Tested on allmodconfig build. Not sure if there's other MIPS configs 
> where this doesn't work. We'll see what 0-day says.

Odd, in next-20230621 I get:

Building mips:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: "__udivdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
ERROR: modpost: "octeon_get_io_clock_rate" [drivers/ata/pata_octeon_cf.ko] undefined!
ERROR: modpost: "__tracepoint_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
ERROR: modpost: "__traceiter_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
ERROR: modpost: "__divdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
make[2]: [scripts/Makefile.modpost:144: Module.symvers] Error 1 (ignored)
make[2]: *** No rule to make target 'kernel/locking/locktorture.ko', needed by '__modfinal'.  Stop.
make[1]: [Makefile:1933: modules] Error 2 (ignored)

Guenter
