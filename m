Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2607289CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjFHVCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjFHVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:02:23 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BA9E61;
        Thu,  8 Jun 2023 14:02:17 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 760265FD86;
        Fri,  9 Jun 2023 00:02:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686258127;
        bh=vrZ3H0ukAoi+VYXR7MBptafkDYF/rLST6i3lyJzo2AI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=IibROKZuitdC5NsKSmnXmx77ZgjUr0lEgo+syJpM7jlszcAazwwiCsNFLC25+tOIX
         r5IcZ2fjhnurB78RF/hbzob7Od6RPjQ6H44tztKGyOIA0Pduvs9sXdfJ7WOHpvYglm
         EvMhQUswG8wa7PR8A10u+H56zu1YYC9rYKCKBaH7MWPNaaYz26QzeAr6Sqvg9og93I
         8WT24Kkl05DgNj6kxAyy2intOaS/LExZzriDl6xi/EnuTpq/tOGM6vNX2A1XqckvI8
         FtggNcvAC+TTgEvPpO9Za9IvGWHeotYqDgr90vWA1XhJYtDFzsp5wGsAWtlAz87ci5
         cHxH3JWpLooWA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  9 Jun 2023 00:02:06 +0300 (MSK)
Date:   Fri, 9 Jun 2023 00:02:05 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     Yu Tu <yu.tu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <kelvin.zhang@amlogic.com>, <qi.duan@amlogic.com>
Subject: Re: [PATCH V9 3/4] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Message-ID: <20230608210205.hsmmhwngrbfydawp@CAB-WSD-L081021>
References: <20230517070215.28463-1-yu.tu@amlogic.com>
 <20230517070215.28463-4-yu.tu@amlogic.com>
 <1j5y804q7u.fsf@starbuckisacylon.baylibre.com>
 <73acf297-3f60-1ce1-2f05-af048aa37199@amlogic.com>
 <1jttvi9vnq.fsf@starbuckisacylon.baylibre.com>
 <20230608113244.jvf7w4flwjy5soud@CAB-WSD-L081021>
 <1jh6ri9kwb.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jh6ri9kwb.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/08 15:54:00 #21461059
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 02:46:54PM +0200, Jerome Brunet wrote:
> 
> On Thu 08 Jun 2023 at 14:32, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> >> 
> >> Neil is currently dealing with the dt-bindings, please
> >> * Adjust your patchset accordingly
> >> * Wait for his v2 to land, you'll need it.
> >> 
> >
> > I saw Neil patch series with merging 'private' and 'public' clock
> > bindings parts. Should I send the same patchset for a1 clocks after v6.5
> > landed?
> >
> 
> I think Neil's patchset is already dealing with the a1.
> 
> We'll see if it can be part of this cycle PR. I don't want to rush
> anything and rc6 is coming this monday. It may have to wait for the next cycle.

Alright, I understand. Please let me know if and when you need
assistance, as I am ready to help.

-- 
Thank you,
Dmitry
