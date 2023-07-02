Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A555744D44
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjGBKbp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Jul 2023 06:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBKbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:31:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924821B0;
        Sun,  2 Jul 2023 03:31:41 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv4z21BGgz67M3D;
        Sun,  2 Jul 2023 18:28:46 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 11:31:37 +0100
Date:   Sun, 2 Jul 2023 18:31:33 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: st_sensors: Remove some redundant includes in
 st_sensors.h
Message-ID: <20230702183133.00007c8d@Huawei.com>
In-Reply-To: <1d367f33-3ed2-63d0-093a-7d1f561cca10@wanadoo.fr>
References: <045ca726a9108325a3eaace807a264170895686c.1686600780.git.christophe.jaillet@wanadoo.fr>
        <bd7fa0b07c85172ecba384e239cb0ecf0780766a.1686600780.git.christophe.jaillet@wanadoo.fr>
        <20230617194911.7963bd6d@jic23-huawei>
        <1d367f33-3ed2-63d0-093a-7d1f561cca10@wanadoo.fr>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Mon, 19 Jun 2023 22:02:37 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 17/06/2023 à 20:49, Jonathan Cameron a écrit :
> > On Mon, 12 Jun 2023 22:13:37 +0200
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >   
> >> There is no need to include i2c.h and spi/spi.h in st_sensors.h.
> >> Should it be needed, st_sensors_(i2c|spi).h should be used.  
> > Agreed these should be dropped from here.
> > 
> > But I don't agree with statement that i2c.h and spi/spi.h should
> > be gotten implicitly from st_sensors_i2c.h / st_sensors_spi.h
> > If they are needed the should be included directly in the files
> > where they are needed.
> > 
> > Jonathan  
> 
> Another option I thought about was to:
>     - keep the includes in st_sensors.h
> 
>     - move function declaration in st_sensors.h
> int st_sensors_spi_configure(struct iio_dev *indio_dev,
> 			     struct spi_device *spi);
> and
> int st_sensors_i2c_configure(struct iio_dev *indio_dev,
> 			     struct i2c_client *client);
> 
>     - remove st_sensors_spi.h and st_sensors_i2c.h
> 
> At least, it would simplify things a remove 2 mostly useless .h file.
> 
> It would not give the benefit of removing some include for files that do 
> not require spi.h or i2c.h, but as these includes are already there, it 
> wouldn't make things worst :)
> 
> What do you think of this approach?

Gut feeling is not worth bothering...  Having separate _i2c.h and _spi.h
seems fine to me.  I'm fine with this patch, just not the description.

Jonathan

> 
> CJ
> 
> >   
> >>
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >> Based on one of my script, this reduces the number of included files from
> >> 573 files to 515 files when compiling drivers/iio/accel/st_accel_buffer.c
> >> ---
> >>   include/linux/iio/common/st_sensors.h | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> >> index 607c3a89a647..a1d3d57d6d6e 100644
> >> --- a/include/linux/iio/common/st_sensors.h
> >> +++ b/include/linux/iio/common/st_sensors.h
> >> @@ -10,8 +10,6 @@
> >>   #ifndef ST_SENSORS_H
> >>   #define ST_SENSORS_H
> >>   
> >> -#include <linux/i2c.h>
> >> -#include <linux/spi/spi.h>
> >>   #include <linux/irqreturn.h>
> >>   #include <linux/iio/iio.h>
> >>   #include <linux/iio/trigger.h>  
> > 
> >   
> 

