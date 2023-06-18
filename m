Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B7B734678
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFRN6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 09:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjFRN6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 09:58:06 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671211BF;
        Sun, 18 Jun 2023 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1687096683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFvP7ex7sh59x2Zu10sumdOcBtAoUqyi0bcCYgQlGWg=;
        b=oeomZ+Lh4LsIYrRa1ueU6sp5sjcBeRBkiVFe96qQ2aTd4+WbMBrxDdDMo8cSC5L1zO3WJr
        R8mbbMaWOOFJpjmdqGrYLhPV4wZzvpBR8jpineG40OwyjgB7QSINuDpOXIEKiY0GOh2ozK
        98VCgkq/wLOkOaR8tFHJ+6mmUggrQq4=
Message-ID: <5511fba10119cdc08a18ea2cca98fed343f9cd33.camel@crapouillou.net>
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   Paul Cercueil <paul@crapouillou.net>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Boddie <paul@boddie.org.uk>,
        Paul Burton <paulburton@kernel.org>,
        Christophe Branchereau <cbranchereau@gmail.com>
Date:   Sun, 18 Jun 2023 15:58:01 +0200
In-Reply-To: <ebf776a8fb8dee045e7661daaca4564fe39917a6.camel@crapouillou.net>
References: <20230615084006.79194526F801@goldelico.com>
         <C1924536-FA97-4E75-9D22-99E5AF24EE5B@goldelico.com>
         <A8EBCBA4-D9BA-4C2F-9C91-38128D06EDBA@goldelico.com>
         <AA802E24-A97B-42B6-90A4-5ECB1E4D9294@goldelico.com>
         <5EF6B0D2-2B84-4C98-B799-88062E035EC1@goldelico.com>
         <43DCEEA5-C013-44BE-85C7-D61A980B0EA5@goldelico.com>
         <ebf776a8fb8dee045e7661daaca4564fe39917a6.camel@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

[...]

> Looking at the JZ4780_DS.PDF file, the SoC actually wants 1.1V so the
> DT is not wrong - in theory. But in practice it does not work, as you
> experienced yourself. However, if the ACT8600 defaults to 1.2V, or if
> the bootloader configures it to 1.2V, I would think that this is
> actually a voltage that the SoC can handle - otherwise the SoC would
> be
> overvolted until the kernel starts, and the board design would be
> flawed.
>=20
> I measured that the old 3.x kernel keeps the SoC voltage at 1.2V, so
> it
> sounds like a better default. Therefore the fix here would be to
> raise
> the DCDC1 regulator to 1.2V.
>=20
> I'll send a patch later today.

After a talk with Christophe (Cc'd), I changed my mind.

A +100 mV overvolt is a *huge* step up, and although the SoC doesn't
burst into flames, it could very well reduce its life span.

I used to have huge stability issues (kernel not booting to userspace
half the times, or just plain reboots after a few minutes of uptime)
and I now realize it's because I was running the core at 1.1V, because
these issues disappeared the moment I switched to 1.2V.

However, I am now running at 1.125 volts, which is just 25mV above the
nominal voltage - and it's been extremely stable so far.

Nikolaus: could you test at 1.125 volts? If it's stable for you as
well, I'd suggest to use this as the new default.

Paul (Burton): As you wrote most of the drivers (and uboot?) for the
board, do you know why VDDCORE was set to 1.2V?

Cheers,
-Paul
