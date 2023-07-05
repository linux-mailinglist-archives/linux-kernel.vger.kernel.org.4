Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A61A747EF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjGEIEc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjGEIEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:04:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2084110DD;
        Wed,  5 Jul 2023 01:04:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QwsYb1fRBz67L8m;
        Wed,  5 Jul 2023 16:01:23 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 5 Jul
 2023 09:04:17 +0100
Date:   Wed, 5 Jul 2023 16:04:13 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     George Stark <gnstark@sberdevices.ru>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v3 5/5] meson saradc: support reading from channel 7 mux
 inputs
Message-ID: <20230705160413.000062e7@Huawei.com>
In-Reply-To: <6ee38b3a-8e2f-15d6-f7bd-06ef567d2b68@sberdevices.ru>
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
        <20230627224017.1724097-6-gnstark@sberdevices.ru>
        <20230702172116.00006f33@Huawei.com>
        <CAFBinCCLt-o_QX0izmtzs8MA=ETMAhEib3KDr-6Z66n__GVkyA@mail.gmail.com>
        <6ee38b3a-8e2f-15d6-f7bd-06ef567d2b68@sberdevices.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 04:59:51 +0300
George Stark <gnstark@sberdevices.ru> wrote:

> Hello Martin, Jonathan
> 
> On 7/3/23 22:39, Martin Blumenstingl wrote:
> > Hi Jonathan,
> >
> > On Sun, Jul 2, 2023 at 11:21 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com>  wrote:
> > [...]  
> >>> @@ -235,6 +249,27 @@ enum meson_sar_adc_channel_index {
> >>>        NUM_CHAN_7,
> >>>        NUM_CHAN_TEMP,
> >>>        NUM_CHAN_SOFT_TIMESTAMP,  
> >> Silly question... Why does this device have timestamp channels?
> >> It has no buffer support so they don't 'do anything'.
> >> If it had then putting other channels after that might have broken
> >> things if not done very carefully (hence I went looking)  
> > This question is probably for me (not George).
> > The answer is simple: when I wrote the Meson SAR ADC driver I looked
> > at various other drivers (but can't recall which ones exactly). One of
> > them probably used a soft timestamp channel so I also added that to
> > meson_saradc. Since "it didn't break anything" I thought it would be
> > fine.
> >
> > Newer SAR ADC IP blocks have buffer support, but that's not
> > implemented in the driver (yet).
> > So if I understand you correctly we can drop the soft timestamp
> > channel (with a dedicated patch in this series)?  
yes. I think dropping it would be sensible.
> 
> One short comment: newly-added channels probably won't support buffering 
> because physically they all are read thru channel7. We'll be able to add 
> buffering only to base old channels and they are still defined before
> CHAN_SOFT_TIMESTAMP (if this is you're wary about).
> 

That is a common situation.  If adding buffering support any channels that
are not suitable for buffered access are given scan_index = -1 at which
point they are sysfs / polled in kernel access only.

Jonathan

> > Best regards,
> > Martin  
> 

