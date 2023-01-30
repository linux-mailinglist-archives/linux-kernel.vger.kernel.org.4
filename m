Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED368064D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbjA3GyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjA3GyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:54:05 -0500
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com [67.231.157.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A5214227;
        Sun, 29 Jan 2023 22:54:04 -0800 (PST)
Received: from pps.filterd (m0048206.ppops.net [127.0.0.1])
        by m0048206.ppops.net-00176a03. (8.17.1.19/8.17.1.19) with ESMTP id 30U4gqFf015753;
        Mon, 30 Jan 2023 01:54:03 -0500
Date:   Mon, 30 Jan 2023 08:53:59 +0200
From:   Ian Ray <ian.ray@ge.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: EXT: Re: [PATCH] drivers: iio: adc: ltc2497: fix LSB shift
Message-ID: <20230130065359.GA21081@zoo6.em.health.ge.com>
References: <20230127125714.44608-1-ian.ray@ge.com>
 <20230127174756.00007299@Huawei.com>
 <20230128180032.2905cee7@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128180032.2905cee7@jic23-huawei>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: N6zcZv5kl4eDebs8WHqBMCtrhehwvaeY
X-Proofpoint-GUID: N6zcZv5kl4eDebs8WHqBMCtrhehwvaeY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300065
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 06:00:32PM +0000, Jonathan Cameron wrote:
> 
> On Fri, 27 Jan 2023 17:47:56 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Fri, 27 Jan 2023 14:57:14 +0200
> > Ian Ray <ian.ray@ge.com> wrote:
> > 
> > > Correct the "sub_lsb" shift for both ltc2497 and ltc2499.  
> 
> I dropped the ltc2499 mention here as that one seems to be unaffected
> by this patch (beyond as a simplification)

Makes sense.


> 
> > 
> > Hi Iain, Thanks for the patch.
> > 
> > > 
> > > An earlier version of the code shifted by 14 but this was a consequence
> > > of reading three bytes into a __be32 buffer and using be32_to_cpu(), so
> > > eight extra bits needed to be skipped.  Now we use get_unaligned_be24()
> > > and thus the additional skip is wrong.
> > > 
> > > Fixes 2187cfe ("drivers: iio: adc: ltc2497: LTC2499 support")  
> > 
> > This isn't in standard Fixes tag format.  If nothing else comes
> > up I'll fix up whilst applying.
> > 
> > > Signed-off-by: Ian Ray <ian.ray@ge.com>
> 
> Fix looks good to me.  (I noted my reasoning below on basis someone might
> find it useful) 
> 
> Applied to the fixes-togreg branch of iio.git with fixes tag fixed and
> marked for stable.
> 
> Please take a look at:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=6327a930ab7bfa1ab33bcdffd5f5f4b1e7131504
> to check I didn't mess anything up.

lgtm

Many thanks!


> 
> Thanks,
> 
> Jonathan
> 
> 
> > > ---
> > >  drivers/iio/adc/ltc2497.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > > index 17370c5..ec198c6 100644
> > > --- a/drivers/iio/adc/ltc2497.c
> > > +++ b/drivers/iio/adc/ltc2497.c
> > > @@ -28,7 +28,6 @@ struct ltc2497_driverdata {
> > >  	struct ltc2497core_driverdata common_ddata;
> > >  	struct i2c_client *client;
> > >  	u32 recv_size;
> > > -	u32 sub_lsb;
> > >  	/*
> > >  	 * DMA (thus cache coherency maintenance) may require the
> > >  	 * transfer buffers to live in their own cache lines.
> > > @@ -65,10 +64,10 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
> > >  		 * equivalent to a sign extension.
> > >  		 */
> > >  		if (st->recv_size == 3) {
> > > -			*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
> > > +			*val = (get_unaligned_be24(st->data.d8) >> 6)
> Prior to the buggy patch.
> 
> 1) Read into top 3 bytes of BE32 which corresponds to 8 bits high.
> 2) Shift by 14.
> 
> Before this patch
> 1) Read only 3 bytes
> 2) shift by  (31 - (resolution + 1) where resolution is 16 so shift by 14.
> Indeed bug.
> 
> After this patch.
> 1) Read 3 bytes
> 2) shift by 6 
> 
> Matches original behaviour - fix is correct.
> 
> 
> > >  				- BIT(ddata->chip_info->resolution + 1);
> > >  		} else {
> > > -			*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
> > > +			*val = (be32_to_cpu(st->data.d32) >> 6)
> 
> Prior to this patch
> sub_lsb = 31 - (resolution + 1) where in this case resolution is 24
> 31 - 25 = 6 so this change is a noop change, so this is good.
> 
> > >  				- BIT(ddata->chip_info->resolution + 1);
> > >  		}
> > >  
> > > @@ -122,7 +121,6 @@ static int ltc2497_probe(struct i2c_client *client)
> > >  	st->common_ddata.chip_info = chip_info;
> > >  
> > >  	resolution = chip_info->resolution;
> > > -	st->sub_lsb = 31 - (resolution + 1);
> > >  	st->recv_size = BITS_TO_BYTES(resolution) + 1;
> > >  
> > >  	return ltc2497core_probe(dev, indio_dev);  
> > 
> 
> 
