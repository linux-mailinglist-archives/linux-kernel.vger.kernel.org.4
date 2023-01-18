Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845D96722E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjARQWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjARQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:22:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98960233C9;
        Wed, 18 Jan 2023 08:19:23 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NxrT96t04z67ZTx;
        Thu, 19 Jan 2023 00:15:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 16:19:21 +0000
Date:   Wed, 18 Jan 2023 16:19:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <phone-devel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/5] iio: core: Point users of extend_name field
 to read_label callback
Message-ID: <20230118161920.0000207c@Huawei.com>
In-Reply-To: <20230116220909.196926-2-marijn.suijten@somainline.org>
References: <20230116220909.196926-1-marijn.suijten@somainline.org>
        <20230116220909.196926-2-marijn.suijten@somainline.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Mon, 16 Jan 2023 23:09:05 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> As mentioned and discussed in [1] extend_name should not be used for
> full channel labels (and most drivers seem to only use it to express a
> short type of a channel) as this affects sysfs filenames, while the
> label name is supposed to be extracted from the *_label sysfs file
> instead.  This appears to have been unclear to some drivers as
> extend_name is also used when read_label is unset, achieving an initial
> goal of providing sensible names in *_label sysfs files without noticing
> that sysfs filenames are (negatively and likely unintentionally)
> affected as well.
> 
> Point readers of iio_chan_spec::extend_name to iio_info::read_label by
> mentioning deprecation and side-effects of this field.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221221223432.si2aasbleiicayfl@SoMainline.org/
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  include/linux/iio/iio.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 81413cd3a3e7..36c89f238fb9 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -221,6 +221,9 @@ struct iio_event_spec {
>   * @extend_name:	Allows labeling of channel attributes with an
>   *			informative name. Note this has no effect codes etc,
>   *			unlike modifiers.
> + *			This field is deprecated in favour of overriding read_label
> + *			in iio_info, which unlike @extend_name does not affect sysfs
> + *			filenames.
Perhaps reword as

This field is deprecated in favour of overriding the default label
by providing a read_label() callback in iio_info, which unlike
@extend_name does not affect sysfs filenames.
?
>   * @datasheet_name:	A name used in in-kernel mapping of channels. It should
>   *			correspond to the first name that the channel is referred
>   *			to by in the datasheet (e.g. IND), or the nearest

