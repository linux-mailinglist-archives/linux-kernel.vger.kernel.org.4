Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23FD6724B8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjARRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjARRUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:20:25 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71F84A1CA;
        Wed, 18 Jan 2023 09:20:19 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NxsvY0ZFxz67JwR;
        Thu, 19 Jan 2023 01:19:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 17:20:16 +0000
Date:   Wed, 18 Jan 2023 17:20:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <phone-devel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/5] iio: core: Point users of extend_name field
 to read_label callback
Message-ID: <20230118172015.00003aa6@Huawei.com>
In-Reply-To: <20230118163525.hh6woxq5q74pmcmq@SoMainline.org>
References: <20230116220909.196926-1-marijn.suijten@somainline.org>
        <20230116220909.196926-2-marijn.suijten@somainline.org>
        <20230118161920.0000207c@Huawei.com>
        <20230118163525.hh6woxq5q74pmcmq@SoMainline.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Wed, 18 Jan 2023 17:35:25 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> On 2023-01-18 16:19:20, Jonathan Cameron wrote:
> > On Mon, 16 Jan 2023 23:09:05 +0100
> > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> >   
> > > As mentioned and discussed in [1] extend_name should not be used for
> > > full channel labels (and most drivers seem to only use it to express a
> > > short type of a channel) as this affects sysfs filenames, while the
> > > label name is supposed to be extracted from the *_label sysfs file
> > > instead.  This appears to have been unclear to some drivers as
> > > extend_name is also used when read_label is unset, achieving an initial
> > > goal of providing sensible names in *_label sysfs files without noticing
> > > that sysfs filenames are (negatively and likely unintentionally)
> > > affected as well.
> > > 
> > > Point readers of iio_chan_spec::extend_name to iio_info::read_label by
> > > mentioning deprecation and side-effects of this field.
> > > 
> > > [1]: https://lore.kernel.org/linux-arm-msm/20221221223432.si2aasbleiicayfl@SoMainline.org/
> > > 
> > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > ---
> > >  include/linux/iio/iio.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index 81413cd3a3e7..36c89f238fb9 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -221,6 +221,9 @@ struct iio_event_spec {
> > >   * @extend_name:	Allows labeling of channel attributes with an
> > >   *			informative name. Note this has no effect codes etc,
> > >   *			unlike modifiers.
> > > + *			This field is deprecated in favour of overriding read_label
> > > + *			in iio_info, which unlike @extend_name does not affect sysfs
> > > + *			filenames.  
> > Perhaps reword as
> > 
> > This field is deprecated in favour of overriding the default label
> > by providing a read_label() callback in iio_info, which unlike
> > @extend_name does not affect sysfs filenames.
> > ?  
> 
> Agreed, explicitly stating "the default label by" makes this much more
> clear.  Though, maybe swap that around into "in favour of providing
> read_label() in iio_info to override the label"?  Otherwise this could
> be interpreted as "overriding the default label" is preferred to setting
> extend_name... which one would do to override the default label.

Sure that works.
> 
> I can queue this up for v3 unless you'll fix it up while applying,
> presuming no other changes have to be made (aside from dropping patch
> 3/5).
I haven't looked closely enough at the rest, but if this is all that
needs updating I'll change it whilst applying.

> 
> Will read_label() turn into a link?  And is the @extend_name reference
> proper?  Is there something to link to iio_info, perhaps a hashtag - or
> maybe fully qualify `#iio_info::read_label()` for linking purposes?
> /me jumps over to kerneldoc documentation :)
> 
> - Marijn
> 
> > >   * @datasheet_name:	A name used in in-kernel mapping of channels. It should
> > >   *			correspond to the first name that the channel is referred
> > >   *			to by in the datasheet (e.g. IND), or the nearest  
> >   
> 

