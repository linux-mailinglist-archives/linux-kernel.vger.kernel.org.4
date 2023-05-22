Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3608A70B8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjEVJLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjEVJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:11:11 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33088F4;
        Mon, 22 May 2023 02:11:09 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 79B275FD20;
        Mon, 22 May 2023 12:11:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684746667;
        bh=zVtsb8/IpfOflzKneBoHCNZkPgVYeTAynqHCimRg6Zs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Qqpl2fGstOPR5yP2D7xIJPharKg10EKjauqRJshSylHQizy3pY7spZivq10NC84oR
         /mYd2zuaJnEwVbQvMlNSNIYIgscFinAFReG2FuO8C9k/qP1N0ZkM1PyarwX0q1gfYq
         32UnFZMbMlT9H70jf/dTYgD0UBthuah1Y5mBi85rszMe1QjPmhkMkWQsY8jvWflC1Y
         OH8FFtibZoS88IMdNPprSXJqW/BfOD/lJhb9k8eh9mA7kfN68Ambc4qq85VOjhHfOC
         iRToOkuZUsc0Mfs21cS+dG6v3H4IMVKA2C/RyzKOey2e+IKbUk3VoFq84qzfRxNV0j
         DQ3792PjlvvEw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 22 May 2023 12:11:06 +0300 (MSK)
Date:   Mon, 22 May 2023 12:11:06 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "=?utf-8?B?0KHRgtCw0YDQuiDQk9C10L7RgNCz0LjQuSDQndC40LrQvtC70LDQtdCy0Lg=?=
        =?utf-8?B?0Yc=?=" <GNStark@sberdevices.ru>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
Message-ID: <20230522091106.rgqirwd3vupgpl6o@CAB-WSD-L081021>
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
 <f0966e95-43c7-e6f6-8aeb-05f27691cec3@sberdevices.ru>
 <20230520164618.08f26fd9@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230520164618.08f26fd9@jic23-huawei>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/22 04:49:00 #21364689
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

Thank you very much for the review!

On Sat, May 20, 2023 at 04:46:18PM +0100, Jonathan Cameron wrote:
> On Wed, 17 May 2023 16:47:59 +0000
> Старк Георгий Николаевич <GNStark@sberdevices.ru> wrote:
> 
> > On 5/16/23 22:08, Martin Blumenstingl wrote:
> > > Hi George,
> > >
> > > thank you for this patch!
> > >
> > > On Mon, May 15, 2023 at 11:06 PM George Stark <gnstark@sberdevices.ru> wrote:  
> > >> From: George Stark <GNStark@sberdevices.ru>
> > >>
> > >> According to datasheets of supported meson SOCs
> > >> length of ADC_CLK_DIV field is 6 bits long  
> > > I have a question about this sentence which doesn't affect this patch
> > > - it's only about managing expectations:
> > > Which SoC are you referring to?
> > > This divider is only relevant on older SoCs that predate GXBB (S905).
> > > To my knowledge all SoCs from GXBB onwards place the divider in the
> > > main or AO clock controller, so this bitmask is irrelevant there.  
> > 
> > Hello Martin
> > 
> > I've checked datasheets of all chips listed in meson_sar_adc_of_match array in meson_saradc.c and everywhere this field is 6 bits long. According to driver code and existing dts files this patch affects all supported chips except meson8.
> 
> On that note, do we want to add any clarifying text on the scope to the
> commit message?

To begin with, we will conduct all experiments that Martin mentioned in
another message within this thread. Once completed, we will share the
results in this current thread. If the changes are still relevant, we
will prepare a new patch set with a detailed commit message.

[...]

-- 
Thank you,
Dmitry
