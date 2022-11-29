Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA62463BFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiK2MML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiK2MLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:11:38 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE70B7E;
        Tue, 29 Nov 2022 04:11:23 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ozzSB-0001us-0x; Tue, 29 Nov 2022 13:11:11 +0100
Date:   Tue, 29 Nov 2022 12:11:08 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Henry Yen =?utf-8?B?KOmhj+S/rua6qyk=?= <Henry.Yen@mediatek.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= 
        <steven.liu@mediatek.com>,
        Xing Fang =?utf-8?B?KOaWueWFtCk=?= <Xing.Fang@mediatek.com>
Subject: Re: [PATCH 1/2] thermal: mediatek: add support for MT7986 and MT7981
Message-ID: <Y4X23BWjsxzzXH/H@makrotopia.org>
References: <20221031230748.xRL1SJX5PchbqyD2hxlXVi5XiA2L39VKuLCwNxdN6uc@z>
 <997af7f23e4cf174b6fed34abfed9c972c50ff77.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <997af7f23e4cf174b6fed34abfed9c972c50ff77.camel@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:53:58AM +0000, Henry Yen (顏修溫) wrote:
> On Mon, 2022-10-31 at 23:07 +0000, Daniel Golle wrote:
> > diff --git a/drivers/thermal/mtk_thermal.c
> > b/drivers/thermal/mtk_thermal.c
> > 
> > +static int raw_to_mcelsius_v3(struct mtk_thermal *mt, int sensno,
> > s32 raw)
> > +{
> > +	s32 tmp;
> > +
> > +	if (raw == 0)
> > +		return 0;
> > +
> > +	raw &= 0xfff;
> > +	tmp = 100000 * 15 / 16 * 10000;
> > +	tmp /= 4096 - 512 + mt->adc_ge;
> > +	tmp /= 1490;
> > +	tmp *= raw - mt->vts[sensno] - 2900 - mt->adc_oe + 512;
> 
> Hi Daniel,
> 
> Regarding the conversion formula, I would suggest following the
> original one, i.e., discarding "adc_oe" parameter as shown in [1].

Ok, I see. According to the commit description it looked to me more
like adc_oe has been dropped by accident, it doesn't sound like it
happened on purpose:
"Refactor MT7986 thermal temperature calculation formula to
prevent loss of floating-point accuracy."

Hence it made sense to be to keep the parameter and really only
use the updated formula to not loose precision. Maybe you can inquire
with the original author if dropping adc_oe was intentional, despite
being unmentioned in the commit message.


> This equation is derived based on hardware-specific theory, so any
> arbitrary change could possibly lead to incorrect temperature output.
> Thanks.

On my BPi-R3 board I found the value 512 burned into the efuse, so in
practise the resulting calculated temperature is exactly the same on
this board.

If other MT7986 or MT7981 boards will have arbitrary values stored in
adc_oe field in the efuse because this value isn't even used during
the manufacturer's calibration process, then of course, there is no
choice other than dropping it here as well.

> 
> [1]
> 
> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/baf36c7eef477aae1f8f2653b6c29e2caf48475b%5E%21/#F0
> 
> 
> Henry
> 
> > +
> > +	return mt->degc_cali * 500 - tmp;
> > +}
> > +
> >  /**
> >   * mtk_thermal_get_bank - get bank
> >   * @bank:	The bank
