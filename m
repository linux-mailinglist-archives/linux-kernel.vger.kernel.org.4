Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9562C723F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjFFKag convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 06:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjFFKaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:30:16 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A90A10C4;
        Tue,  6 Jun 2023 03:30:14 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bacfc573647so6610996276.1;
        Tue, 06 Jun 2023 03:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047414; x=1688639414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M37GgvWJac+ezE60S1jjJkXuBuA94LzOcGnWhPva6Xo=;
        b=c7fb746mWD+9lG95gEIrNQIDHsgBK3tdVZLMRyFMKQoTTFPt7XkHgTuZ57iaW5LJ+h
         ZiSif0UO6Bcnh76TY2outzXQbztNfLlMPU6cf7WQzP8C/tpsqJpttyDbFRGxjf0JeTyP
         GZz+G6or0wYLqn1lLqA3R072JWhzMuvJeDUNKTTHt2uMRWyZ2iJ3jnNzH/UaiMHUbSMj
         e0oDN06b1ppO2hCxm3LVAww7wsqrxYM7f4BrzCjCAA8nLaOMgPprYUPndGP972OKvyCE
         0/w0GcDmFIowvE8iogxpFLHxmxQaUaoVOxiAyUth6vIHl1TOC6WF61YgZgRhuGYTuDsT
         csfQ==
X-Gm-Message-State: AC+VfDzxjrhyAAFDNW4hVnKb3ttnu+DgS93pedrA2ZBhYonqntp4sGFW
        ++NruZdzFT2ifTU/d2Ckoi2zFU9jO3LUKw==
X-Google-Smtp-Source: ACHHUZ4VIRTe2RtHNxMHWgdDLyBjdwB+R7JihWfg0hnFU2BZYxaSmgeEDhhLZlyP/Vyool5sa9mSCg==
X-Received: by 2002:a5b:6cb:0:b0:b9e:8a8b:b073 with SMTP id r11-20020a5b06cb000000b00b9e8a8bb073mr1508479ybq.39.1686047413986;
        Tue, 06 Jun 2023 03:30:13 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 194-20020a2503cb000000b00ba8c2f3e1a4sm3144590ybd.56.2023.06.06.03.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:30:11 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-566586b180fso64494187b3.0;
        Tue, 06 Jun 2023 03:30:11 -0700 (PDT)
X-Received: by 2002:a81:8484:0:b0:568:bd5c:2f6b with SMTP id
 u126-20020a818484000000b00568bd5c2f6bmr1809215ywf.39.1686047410733; Tue, 06
 Jun 2023 03:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230111212241.7456-1-pauk.denis@gmail.com>
In-Reply-To: <20230111212241.7456-1-pauk.denis@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Jun 2023 12:29:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXGO17cKKvwA5sZQ+WBPzdMvghZkvv1gWvQ00X-N+EF9A@mail.gmail.com>
Message-ID: <CAMuHMdXGO17cKKvwA5sZQ+WBPzdMvghZkvv1gWvQ00X-N+EF9A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hwmon: (nct6775) Directly call ASUS ACPI WMI method
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     ahmad@khalifa.ws, chunkeey@gmail.com, greg@krypto.org,
        hubert.banas@gmail.com, igor@svelig.com, jaap.dehaan@freenet.de,
        jdelvare@suse.com, jeroen@beerstra.org, jonfarr87@gmail.com,
        jwp@redhat.com, kdudka@redhat.com, kernel@melin.net,
        kpietrzak@disroot.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, me@rebtoor.com,
        metalcaedes@gmail.com, michael@theoddone.net,
        mikhail.v.gavrilov@gmail.com, mundanedefoliation@gmail.com,
        nephartyz@gmail.com, oleksandr@natalenko.name, pehlm@pekholm.org,
        renedis@hotmail.com, robert@swiecki.net,
        sahan.h.fernando@gmail.com, sebastian.arnhold@posteo.de,
        sst@poczta.fm, to.eivind@gmail.com, torvic9@mailbox.org,
        linux-riscv <linux-riscv@lists.infradead.org>
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

Hi Denis,

On Wed, Jan 11, 2023 at 10:24 PM Denis Pauk <pauk.denis@gmail.com> wrote:
> New ASUS B650/B660/X670 boards firmware have not exposed WMI monitoring
> GUID  and entrypoint method WMBD could be implemented for different device
> UID.
>
> Implement the direct call to entrypoint method for monitoring the device
> UID of B550/X570 boards.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Ahmad Khalifa <ahmad@khalifa.ws>
> Signed-off-by: Ahmad Khalifa <ahmad@khalifa.ws>

Thanks for your patch, which is now commit c3b3747d02f571da ("hwmon:
(nct6775) Directly call ASUS ACPI WMI method") in  v6.3-rc1.

> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1516,7 +1516,7 @@ config SENSORS_NCT6775_CORE
>  config SENSORS_NCT6775
>         tristate "Platform driver for Nuvoton NCT6775F and compatibles"
>         depends on !PPC
> -       depends on ACPI_WMI || ACPI_WMI=n
> +       depends on ACPI || ACPI=n
>         select HWMON_VID
>         select SENSORS_NCT6775_CORE
>         help

The recent patches to add support for ACPI on RISC-V caused me to
see a question about this driver again when running "make oldconfig",
and I had a closer look at the driver...
Unless I am missing something, this is a really dangerous driver which
just bangs blindly into I/O space without doing any platform checks,
which could cause a crash or system lock-up?

Does the SENSORS_NCT6775 symbol need a better platform dependenc
than !PPC?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
