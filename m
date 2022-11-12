Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7579626C39
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 23:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiKLW5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 17:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 17:57:49 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3A15FE8;
        Sat, 12 Nov 2022 14:57:47 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n12so20146723eja.11;
        Sat, 12 Nov 2022 14:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aces7d3gh1cNZ1+1J7wsg1lJ0vNlC5CU2OQmcL8yCkw=;
        b=gfw+fakuaAtqewolwJkRZapmehXpcSd8l/JmGIId64ZI/VruTHo7XGGyPg6PbMbhRM
         lwHrB5JAJwJB2grGQ88zeS8g4jjqNwVznoiG/vsyYtcnSRlHUyER8YJ8OwnST3WqifIs
         2SqeMr40gzLjARJ6Fgq5aiQs5CoySgHV/qoWBxoWnhUKEdSc76uAgaezwO8JUffiks2I
         2etRqJzrp9IxwHH4qdf6jKZdUDq8ZeM5j/lvtq0zrhbtzmT0l6ywhuHtvm4mHwAcMP0A
         X2O90q7XE2BT1KF/dchGlhk+5miuVkXDlgxRwlTe4FNcZp8Sb+qykZeUFCsbYfdB7p34
         1CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aces7d3gh1cNZ1+1J7wsg1lJ0vNlC5CU2OQmcL8yCkw=;
        b=sa5EAlsXGqwI76LJngEhPgv/xTxip+WkbLqa+pgyyvj5kQtmicUrmzcMKgmc5cSBmz
         7YbJuWTVarw0q2cLjCnTL6yHMRUVZ+ZlGgISVFqGgFj/ipChdJ3bYChX3mPSPc4DFpLO
         XlRD0pq+O0GPxuLJbSqCQXTcTmZuG0L5Btt9JPJVxCOruZ68LMnqyAfxXHGUoikY3YrE
         xJS0vVWXKbAa1BKE1wrhDc0gUTaSLTFohUOwFNif/rdDwQqI06sRYNXUKiOk/31L41c4
         a6utBtRQfPAE1qb0x4aKHImZVuyCue/bBCmLGplpwMq6AjMaTbeXfYmZ/TUUemuGAJZX
         soDg==
X-Gm-Message-State: ANoB5pkmBMDGdxKP/u8sEHRRSag/CONye5H0qCQSi/jWTlB3LgKdJVFT
        l4eM1BiYKJliO+x6eZTg3k83z+IWFEtfEdEbyidd8ymCvc0=
X-Google-Smtp-Source: AA0mqf5t2EnEEHg3FiYq5ObDCWWH3FWyQ2f6sbmAwIpOq3JsEuJMFGlEqg5Gx/0fUxcJmvofAN9+ffcQTWi3Q6KAwN4=
X-Received: by 2002:a17:906:e246:b0:7aa:ffd0:b738 with SMTP id
 gq6-20020a170906e24600b007aaffd0b738mr6454936ejb.122.1668293866048; Sat, 12
 Nov 2022 14:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20221110150035.2824580-1-adeep@lexina.in> <20221110150035.2824580-2-adeep@lexina.in>
In-Reply-To: <20221110150035.2824580-2-adeep@lexina.in>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 12 Nov 2022 23:57:35 +0100
Message-ID: <CAFBinCAQb1BXUp_Tou-UoS5AHFFE76cwv6mynoDUZp0ySwPeeQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: amlogic: mmc: meson-gx: Add core, tx, rx
 eMMC/SD/SDIO phase clock settings from devicetree data
To:     Vyacheslav Bocharov <adeep@lexina.in>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vyacheslav,

On Thu, Nov 10, 2022 at 4:01 PM Vyacheslav Bocharov <adeep@lexina.in> wrote:
>
> The mmc driver has the same phase values for all meson platforms. However,
> some platforms (and even some boards) require different values.
Could you please elaborate which phases are per platform and which are
per board?
In this series you're only managing the core phase differently for all
AXG boards. IMO this can be achieved by extending struct
meson_mmc_data with the desired core clock phase


Best regards,
Martin
