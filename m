Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFD6367D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbiKWR4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiKWR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:56:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33806AEDA;
        Wed, 23 Nov 2022 09:56:42 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHTMn6RqPz67QRR;
        Thu, 24 Nov 2022 01:56:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 18:56:40 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 17:56:39 +0000
Date:   Wed, 23 Nov 2022 17:56:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add ti tmag5273 driver
Message-ID: <20221123175639.00000ede@Huawei.com>
In-Reply-To: <Y34irZRlkpdqLrll@smile.fi.intel.com>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
        <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
        <Y3uFWH5GV/x7UDcP@smile.fi.intel.com>
        <f3fbf861-37c6-3bcf-615b-2f55261fbf90@wolfvision.net>
        <Y34irZRlkpdqLrll@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 15:39:57 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Nov 23, 2022 at 10:58:47AM +0100, Gerald Loacker wrote:
> > Am 21.11.2022 um 15:04 schrieb Andy Shevchenko:  
> > > On Mon, Nov 21, 2022 at 01:35:42PM +0100, Gerald Loacker wrote:  
> 
> ...
> 
> > >> +static const struct {
> > >> +	unsigned int scale_int;
> > >> +	unsigned int scale_micro;  
> > > 
> > > Can we have a separate patch to define this one eventually in the (one of) IIO
> > > generic headers? It's a bit pity that every new driver seems to reinvent the
> > > wheel.
> > >   
> > >> +} tmag5273_scale_table[4][2] = {
> > >> +	{ { 0, 0 }, { 0, 0 } },
> > >> +	{ { 0, 12200 }, { 0, 24400 } },
> > >> +	{ { 0, 40600 }, { 0, 81200 } },
> > >> +	{ { 0, 0 }, { 0, 0 } },
> > >> +};  
> > >   
> > 
> > I'm thinking of defining structs for all similar types of IIO output
> > formats in iio.h like this:
> > 
> > 
> > struct iio_val_int_plus_micro {
> > 	int val_int;
> > 	int val_micro;
> > };
> > 
> > struct iio_val_int_plus_nano {
> > 	int val_int;
> > 	int val_nano;
> > };
> > 
> > struct iio_val_int_plus_micro_db {
> > 	int val_int;
> > 	int val_micro_db;
> > };  
> 
> ...
> 
> > struct iio_val_fractional {
> > 	int dividend;
> > 	int divisor;
> > };  
> 
> This one...
> 
> > struct iio_val_fractional_log2 {
> > 	int dividend;
> > 	int divisor;
> > };  
> 
> ...and this one repeat struct s32_fract (or u32_fract, whatever suits better).
> 
> > Do you agree?  
> 
> Me, yes, but you need a blessing by maintainers of IIO.

I'm not 100% convinced it matters, particularly as one of the two typical
use paths has to cast them to an int * anyway (as it can take any of the
above, or a 1D array of ints).  However, if it makes drivers a little
easier to read then fair enough.  I'm not keen to see a brute force
set of patches updating existing drivers that treat them as simple array
of ints though.  Fine to convert any drivers with a local equivalent of these
structures defined.

Jonathan


