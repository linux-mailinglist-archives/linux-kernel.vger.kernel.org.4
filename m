Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131736D067B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjC3NYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjC3NYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:24:09 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A79B2;
        Thu, 30 Mar 2023 06:24:06 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17997ccf711so19720798fac.0;
        Thu, 30 Mar 2023 06:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4O6ptW8FC1twDFPrgTGFy4o+XCv7mfWBX2HQc2Vl6w=;
        b=upgWykZyPnj93MygVpVC7ULndI0ijhLBnaa6Ce0lwkZO3+i6GDUpm+b14W9FIygnYq
         fFkDKjU/97KrDM33b31RWtziqxI2j/bQf/rWAn+dHTRA6FvKlygHjmnJBPyC+GrGqLCu
         xs1aBNAuECxaSSNwsbHlrElh1tg2MBwVUdOMTfn0hEjE5G+wkIRKBqjTdeJWMSNNxKfR
         8U1Z6k9IBTbKB715Q11tM0fljEGpztI4UZ9g09RqYeu+tYS9a6ORmcFGZjuAEdSsYJnR
         fUa3cw7gTZdzfszXJdNPpzrjw6wH9+5Hsl0Vic2KpV2hlL+diVNwrsXz2Ysx1YcEKDX7
         ybzQ==
X-Gm-Message-State: AAQBX9dpPEeFKQgI55qfvUe45vAtg6uvnAy08ANxa3q9zvcSLzjJmjSg
        QJSwZYixZ2emfDKQ+ljhQUmQQyQumw==
X-Google-Smtp-Source: AKy350YAsIqse17BcOxR/9AaOp189fBun9Jx72PRABkn09nrRspeoN7LJ9+LlXCVTX1hmu+zO87WVg==
X-Received: by 2002:a05:6870:56a6:b0:177:b2fa:3740 with SMTP id p38-20020a05687056a600b00177b2fa3740mr3186551oao.23.1680182645741;
        Thu, 30 Mar 2023 06:24:05 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id tk6-20020a05687189c600b0017703cd8ff6sm12755790oab.7.2023.03.30.06.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:24:05 -0700 (PDT)
Received: (nullmailer pid 1868179 invoked by uid 1000);
        Thu, 30 Mar 2023 13:24:04 -0000
Date:   Thu, 30 Mar 2023 08:24:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 0/3] Move Loongson1 PWM timer to clocksource framework
Message-ID: <20230330132404.GA1865737-robh@kernel.org>
References: <20230330110512.549704-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330110512.549704-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:05:09PM +0800, Keguang Zhang wrote:
> Move Loongson1 PWM timer to clocksource framework
> and update the Kconfig/Makefile options accordingly.

Why?

What does this have to do with the binding? Did the h/w change? No.

> 
> Changelog
> V2 -> V3: Remove the reference to regs-pwm.h
> V1 -> V2: Delete the obsolete header file regs-pwm.h
> 
> Keguang Zhang (3):
>   MIPS: Loongson32: Remove deprecated PWM timer clocksource
>   dt-bindings: timer: Add Loongson-1 clocksource
>   clocksource: loongson1: Move PWM timer to clocksource framework
> 
>  .../timer/loongson,ls1x-pwmtimer.yaml         |  48 ++++
>  .../include/asm/mach-loongson32/loongson1.h   |   1 -
>  .../include/asm/mach-loongson32/regs-pwm.h    |  25 --
>  arch/mips/loongson32/Kconfig                  |  37 ---
>  arch/mips/loongson32/common/time.c            | 210 ----------------
>  drivers/clocksource/Kconfig                   |   9 +
>  drivers/clocksource/Makefile                  |   1 +
>  drivers/clocksource/timer-loongson1-pwm.c     | 236 ++++++++++++++++++
>  8 files changed, 294 insertions(+), 273 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-pwm.h
>  create mode 100644 drivers/clocksource/timer-loongson1-pwm.c
> 
> 
> base-commit: f7b5a248213f0976c7944925f3f3ab7ff199e581
> -- 
> 2.34.1
> 
