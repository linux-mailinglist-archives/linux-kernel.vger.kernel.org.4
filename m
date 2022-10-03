Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F25F2E06
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJCJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJCJ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:29:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E3553D23;
        Mon,  3 Oct 2022 02:27:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c11so6007000qtw.8;
        Mon, 03 Oct 2022 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Yfsi/AGFVq9lMy2xlrpaeIIHTsRKifHh6klZq85Xypg=;
        b=G88CZIoY5HgbeaRNhHCrdL7Sz4aXBPVFgxdqhTSuBcABcBFGHmVfI/KwpbCR2zTYyN
         RBhnc/zF0mk43Xm95haEK7sQUNckYZBD+kZpNjk0pyHVA1BvvY1gliZxwiXTtTqoygjI
         qDZ/XMPNZnBSn6Hfwifs3ZafhOpOQcStmvLesP25NsOlWnNaMNaJtxNVTwT+ObUwG2tn
         h1lfG/1Yo4koe4ulEDrKPQZqsjx6lNJ3B5jCWWgbIsel4n/wtPvU90w1WaISwWPEKstK
         4gkCsZ9hhNw6v+8O8KPMQkkeMfjHm5pZz8ytLycVZtWz8SyUzpScPRIEW60jfcRKknwA
         N+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Yfsi/AGFVq9lMy2xlrpaeIIHTsRKifHh6klZq85Xypg=;
        b=Ol1CznoXUFrJYFEaAqEL0XcUi9zTlZ3j6E4CVHlEdmjI5HET/ujmB3zIN0MFRO17bx
         0Ko+KSNcYAVleIfJZSyqJz2B5GY4dHgE8Hq3xxJv1b2P1aycdWcDgT64CxP8z837y2UM
         8MUKTQbczgZtD2x5s+NKoE6df0KJ2EEIb/VfqDWhQ6MsruXK20pPo+/AqCxBjG1pseWm
         sA+Gi5fbXk8xAhszX6hFdmFS1X13bUaSbu6SuA8oJWRFtaVyXXwIw7+ig2/PbFFpn38j
         vrNI7wBypEoo3U6qPSF/NKAr3unLW++gIx1YzocjQD3bFOIff3e2H7lV2MPAf7Q4VwHL
         jeXw==
X-Gm-Message-State: ACrzQf0g4LdMrSukl1QecGMaKd7I/ybHEziIM4hCQT9Kv50XIU3PTYS1
        1n9S6QJnmtcbOsIQJMK1Kmfz2UfaJxt+KwQpNLQ=
X-Google-Smtp-Source: AMsMyM7jk43Kfgt286DP3f4IMvWzyljl4n/WAwK48BJjejvzs8aYQ3SnB3Jjei0sqL6y21KuFkNx9yWu+HxG7QoIbb0=
X-Received: by 2002:a05:622a:1701:b0:35b:b3bb:7c4e with SMTP id
 h1-20020a05622a170100b0035bb3bb7c4emr14800250qtk.195.1664789247473; Mon, 03
 Oct 2022 02:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com> <20221001061507.3508603-4-kumaravel.thiagarajan@microchip.com>
In-Reply-To: <20221001061507.3508603-4-kumaravel.thiagarajan@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Oct 2022 12:26:51 +0300
Message-ID: <CAHp75VdEJvG=BQvS2KVNY8BnjfHyOCO6ww0S4_gxVZNuhXaURg@mail.gmail.com>
Subject: Re: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, u.kleine-koenig@pengutronix.de,
        johan@kernel.org, wander@redhat.com,
        etremblay@distech-controls.com, macro@orcam.me.uk,
        geert+renesas@glider.be, jk@ozlabs.org, phil.edworthy@renesas.com,
        lukas@wunner.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, UNGLinuxDriver@microchip.com
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

On Sat, Oct 1, 2022 at 9:15 AM Kumaravel Thiagarajan
<kumaravel.thiagarajan@microchip.com> wrote:
>
> pci1xxxx's quad-uart function has the capability to wake up the host from
> suspend state. Enable wakeup before entering into suspend and disable
> wakeup on resume.

...

> +       port->suspended == 0

How is this check race-protected?

...

> +static void pci1xxxx_port_resume(int line)
> +{

> +       if (port->suspended == 0) {

Ditto.

> +       }
> +}

...

If you have similarities with 8250_pci, probably you need to split it
to 8250_pcilib.c and share. (See how 8250_dw /8250_lpss are done in
that sense.)

--
With Best Regards,
Andy Shevchenko
