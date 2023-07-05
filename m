Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41C87480D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGEJ2z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGEJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:28:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748721713;
        Wed,  5 Jul 2023 02:28:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QwvQw6C9Cz67Jb4;
        Wed,  5 Jul 2023 17:25:44 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 5 Jul
 2023 10:28:39 +0100
Date:   Wed, 5 Jul 2023 17:28:34 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 2/2] iio: adc: max14001: New driver
Message-ID: <20230705172834.00001853@Huawei.com>
In-Reply-To: <CAHp75VfGFXtX2UCV+EzSMGaRMc5=WUpUJpRFB_K6NMJO2+iszg@mail.gmail.com>
References: <20230622143227.30147-1-kimseer.paller@analog.com>
        <20230622143227.30147-2-kimseer.paller@analog.com>
        <20230702180315.00003dbe@Huawei.com>
        <fcf6daf6afec48b096df14d8b5308db0@analog.com>
        <20230705155530.00002074@Huawei.com>
        <CAHp75VfGFXtX2UCV+EzSMGaRMc5=WUpUJpRFB_K6NMJO2+iszg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Wed, 5 Jul 2023 11:53:17 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jul 5, 2023 at 10:55 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > > Sent: Sunday, July 2, 2023 6:04 PM
> > > > On Thu, 22 Jun 2023 22:32:27 +0800
> > > > Kim Seer Paller <kimseer.paller@analog.com> wrote:  
> 
> ...
> 
> > > > > + /*
> > > > > +  * Convert transmit buffer to big-endian format and reverse transmit
> > > > > +  * buffer to align with the LSB-first input on SDI port.
> > > > > +  */
> > > > > + st->spi_tx_buffer =  
> > > > cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_ADDR_MASK,  
> > > > > +                                                         reg_addr)));
> > > > > +
> > > > > + ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > > > > + if (ret)
> > > > > +         return ret;
> > > > > +
> > > > > + /*
> > > > > +  * Align received data from the receive buffer, reversing and reordering
> > > > > +  * it to match the expected MSB-first format.
> > > > > +  */
> > > > > + *data = (__force u16)(be16_to_cpu(bitrev16(st->spi_rx_buffer))) &
> > > > > +  
> > > >     MAX14001_DATA_MASK;  
> > > > > +  
> > > > These sequences still confuse me a lot because I'd expect the values in tx
> > > > to have the opposite operations applied to those for rx and that's not the
> > > > case.
> > > >
> > > > Let's take a le system.
> > > > tx = cpu_to_be16(bitrev16(x))
> > > >    = cpu_to_be16((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8));
> > > >    = __bitrev8(x & 0xff) | (__bitrev8(x >> 8) << 8)
> > > > or swap all the bits in each byte, but don't swap the bytes.
> > > >
> > > > rx = cpu_to_be16(bitrev16(x))
> > > >    = be16_to_cpu(((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)_
> > > >    = __bitrev8(x & 0xff) | __bitrev(x >> 8)
> > > >
> > > > also swap all the bits in each byte, but don't swap the bytes.
> > > >
> > > > So it is the reverse because the bytes swaps unwind themselves somewhat.
> > > > For a be system cpu_to_be16 etc are noop.
> > > > tx = (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)
> > > > rx = (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)
> > > >
> > > > So in this case swap all 16 bits.
> > > >
> > > > Now, given I'd expected them to be reversed for the tx vs rx case.
> > > > E.g.
> > > > tx = cpu_to_be16(bitrev16(x))
> > > > As above.
> > > > For rx, le host
> > > > rx = bitrev16(be16_to_cpu(x))
> > > >    = __bitrev8((x >> 8) & 0xff) << 8) |  __bitrev8((((x & 0xff) << 8) >> 8)
> > > > same as above (if you swap the two terms I think.
> > > >
> > > > For be the be16_to_cpu is a noop again, so it's just bitrev16(x) as expected.
> > > >
> > > > Hence if I've understood this correctly you could reverse the terms so that
> > > > it was 'obvious' you were doing the opposite for the tx term vs the rx one
> > > > without making the slightest bit of difference....
> > > >
> > > > hmm. Might be worth doing simply to avoid questions.  
> > >
> > > Thank you for your feedback. I have tested the modifications based on your
> > > suggestions, taking the le system into account, and it appears that the code is
> > > functioning correctly. Before sending the new patch version, I would like to
> > > confirm if this aligns with your comments.  
> 
> > Yes. This looks good to me.  
> 
> I think the implementation is still incorrect. See below.
> 
> > > static int max14001_read(void *context, unsigned int reg_addr, unsigned int *data)
> > > {
> > >       struct max14001_state *st = context;
> > >       int ret;
> > >
> > >       struct spi_transfer xfers[] = {
> > >               {
> > >                       .tx_buf = &st->spi_tx_buffer,
> > >                       .len = sizeof(st->spi_tx_buffer),
> > >                       .cs_change = 1,
> > >               }, {
> > >                       .rx_buf = &st->spi_rx_buffer,
> > >                       .len = sizeof(st->spi_rx_buffer),
> > >               },
> > >       };  
> 
> > >       st->spi_tx_buffer = cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_ADDR_MASK, reg_addr)));  
> 
> Here we got bits in CPU order, reversed them and converted to BE16.
> 
> > >       ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > >       if (ret)
> > >               return ret;  
> 
> > >       *data = cpu_to_be16(bitrev16(st->spi_rx_buffer));  
> 
> Here we take __be16 response, reverse them and convert to BE16?!
> This is weird. You should have be16_to_cpu() somewhere, not the opposite.
Good point - though functionally they end up the same (and the bitrev
is making mess of type markings anyway). It is more logical
to ensure the direction is reversed as you suggest.

> 
> > >       return 0;
> > > }  
> 
> Isn't, btw, the reinvented spi_...write_then_read() (or what is it
> called?) call?

I think the cs_change = 1 prevents using that.

Jonathan


> 
> > > static int max14001_write(void *context, unsigned int reg_addr, unsigned int data)
> > > {
> > >       struct max14001_state *st = context;
> > >
> > >       st->spi_tx_buffer = cpu_to_be16(bitrev16(
> > >                               FIELD_PREP(MAX14001_ADDR_MASK, reg_addr) |
> > >                               FIELD_PREP(MAX14001_SET_WRITE_BIT, 1) |
> > >                               FIELD_PREP(MAX14001_DATA_MASK, data)));
> > >
> > >       return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_buffer));
> > > }  
> 

