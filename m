Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9391C69D75D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjBTX6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjBTX6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:58:15 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F21976F;
        Mon, 20 Feb 2023 15:58:13 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id c2-20020a9d6842000000b0068bc93e7e34so492346oto.4;
        Mon, 20 Feb 2023 15:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCgRQJTBlWi1Yd4fnNx2Zag8znO/0MFpz2KultT2Nms=;
        b=Pr5oi2cZ5IhzT4qHrwCN6FjL3FQOpq2W1TMBC7TM4YOTwNfmK1Za7eOdvHdFIExqRD
         7/scO9OCk1zTLK64nM8QcHklNaEx/JU4O/xw6ZrGJ/o7UsYaEsw/+lPtO89gYsyE3OIN
         wjsjF9hrhvcQuYTNUTDzxpXGnZ1dQUhltFBIQmvoBCehDgiL7LFgU/kB+0snyjCxtX0T
         jDJZui03c8QSj9jUQKsK0SEH/EXipWSue0qejOZcKdUS3J4Bbh2WCDbS8EaUDnjkVqgr
         bE12knN/0Aes3AELrMMWd5bbtY9c61TF/eIlQiMOFFIL0DIz+3wm9QbA0nrGDsjEvAos
         vMHQ==
X-Gm-Message-State: AO0yUKVJ0vKvTTla+lPBAv2dq2hfHhZr0PH4ClUr74RLmlFQKN5x4Xhc
        P4OZxiXmuARrchLvYSU1pg==
X-Google-Smtp-Source: AK7set/ebZ6kCRAGQAD+8rbgMi+1rZ7DLJecjwosBYMsBWpui1bnG4ZpMGNH6QRcvJB8UsnAjVoalA==
X-Received: by 2002:a05:6830:34a:b0:690:d50a:9b48 with SMTP id h10-20020a056830034a00b00690d50a9b48mr1156987ote.11.1676937492989;
        Mon, 20 Feb 2023 15:58:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q19-20020a9d6313000000b0068bcd200247sm5380338otk.75.2023.02.20.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 15:58:12 -0800 (PST)
Received: (nullmailer pid 637656 invoked by uid 1000);
        Mon, 20 Feb 2023 23:58:11 -0000
Date:   Mon, 20 Feb 2023 17:58:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mingming Su <Mingming.Su@mediatek.com>,
        linux-crypto@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwrng: add driver for MediaTek TRNG SMC
Message-ID: <20230220235811.GA618419-robh@kernel.org>
References: <89865515728cb937b6591160ad9c30b4bcc8dd41.1676467500.git.daniel@makrotopia.org>
 <84de90f5-da77-d3f2-c14a-d2e5c53bbf1c@collabora.com>
 <0d5d5d00-8569-a642-cca7-798c8d24a986@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d5d5d00-8569-a642-cca7-798c8d24a986@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 12:32:10PM +0100, Matthias Brugger wrote:
> 
> 
> On 16/02/2023 11:03, AngeloGioacchino Del Regno wrote:
> > Il 15/02/23 14:27, Daniel Golle ha scritto:
> > > Add driver providing kernel-side support for the Random Number
> > > Generator hardware found on Mediatek SoCs which have a driver in ARM
> > > TrustedFirmware-A allowing Linux to read random numbers using a
> > > non-standard vendor-defined Secure Monitor Call.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > 
> > Hello Daniel,
> > 
> > incidentally, I've also done some research on this one some months ago, when
> > I was deep in adding support for the Helio X10 SoC (MT6795) on Xperia M5.
> > 
> > The rng-v2 is simply the same rng but hypervised by the TF-A... and the only
> > difference is, well, as you're also pointing out, that we're using secure
> > monitor calls instead of direct MMIO handling.
> > 
> > There's also not much more than what you've implemented here and the only kind
> > of addition that we will ever see on this one will be about changing the SIP
> > command (as some older SoCs use a different one)... so...
> > 
> > ...I don't think that adding an entirely new driver is worth the noise, hence
> > I propose to simply add handling for the Secure RNG to mtk-rng.c instead: it's
> > shorter and we would only need to address one if branch on that probe function
> > to set a different callback.
> > 
> > The clock should then be optional for *some* of those "v2 handling" devices,
> > as if I recall correctly, some do need the clock to be handled from Linux
> > anyway... otherwise this v2 driver will be "soon" looking bloody similar to
> > the "v1", adding a bit of code duplication around.
> > 
> > What do you think?
> > 
> 
> That was exactly what I was thinking as well when I had a look at the
> driver. I propose to add it to mtk-rng.c. I don't see any value having a
> second driver for this.

Or fix the firmware to use the already defined SMC TRNG interface...

In any case, like the SMC TRNG, you don't need a DT binding. The 
firmware interface is discoverable. Try the SMC call and if it succeeds, 
you have a TRNG.

Rob

> 
> Regards,
> Matthias
> 
> > Regards,
> > Angelo
> > 
> > > ---
> > >   MAINTAINERS                         |  1 +
> > >   drivers/char/hw_random/Kconfig      | 16 +++++++
> > >   drivers/char/hw_random/Makefile     |  1 +
> > >   drivers/char/hw_random/mtk-rng-v2.c | 74 +++++++++++++++++++++++++++++
> > >   4 files changed, 92 insertions(+)
> > >   create mode 100644 drivers/char/hw_random/mtk-rng-v2.c
> > > 
> > 
