Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2176720FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjARPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjARPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:18:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978BC5085A;
        Wed, 18 Jan 2023 07:13:01 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nxq4g0XTrz6J9W6;
        Wed, 18 Jan 2023 23:12:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 15:12:58 +0000
Date:   Wed, 18 Jan 2023 15:12:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: frequency: ad9832: Replace macro
 AD9832_PHASE() with function
Message-ID: <20230118151257.0000663a@Huawei.com>
In-Reply-To: <20230118150306.16448-1-bpappas@pappasbrent.com>
References: <20230118150306.16448-1-bpappas@pappasbrent.com>
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

On Wed, 18 Jan 2023 10:03:06 -0500
Brent Pappas <bpappas@pappasbrent.com> wrote:

> Replace the macro AD9832_PHASE() with a static function to comply with
> Linux coding style standards.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>

Hi Brent,

I'd rather see this changed to FIELD_GET() / FIELD_PREP() along
with all other similar cases in this driver.

That would mean defining just the field masks then using those
to mask relevant bits out and put in the new value.

Thanks

Jonathan


> ---
>  drivers/staging/iio/frequency/ad9832.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 6f9eebd6c7ee..537825534a28 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -59,7 +59,9 @@
>  #define AD9832_CMD_SLEEPRESCLR	0xC
>  
>  #define AD9832_FREQ		BIT(11)
> -#define AD9832_PHASE(x)		(((x) & 3) << 9)
> +
> +static unsigned short ad9832_phase(int x) { return (x & 3) << 9; }
> +
>  #define AD9832_SYNC		BIT(13)
>  #define AD9832_SELSRC		BIT(12)
>  #define AD9832_SLEEP		BIT(13)
> @@ -221,8 +223,8 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  			break;
>  		}
>  
> -		st->ctrl_fp &= ~AD9832_PHASE(3);
> -		st->ctrl_fp |= AD9832_PHASE(val);
> +		st->ctrl_fp &= ~ad9832_phase(3);
> +		st->ctrl_fp |= ad9832_phase(val);
>  
>  		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
>  					st->ctrl_fp);

