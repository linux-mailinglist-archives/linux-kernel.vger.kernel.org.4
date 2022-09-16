Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149F05BAFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiIPPMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIPPLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:11:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D39AA344;
        Fri, 16 Sep 2022 08:11:45 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MTcvn54vnz67XcG;
        Fri, 16 Sep 2022 23:10:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 17:11:42 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 16:11:42 +0100
Date:   Fri, 16 Sep 2022 16:11:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <cmo@melexis.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 0/3] iio: temperature: mlx90632: Add powermanagement
Message-ID: <20220916161141.000069f5@huawei.com>
In-Reply-To: <cover.1663324968.git.cmo@melexis.com>
References: <cover.1663324968.git.cmo@melexis.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Fri, 16 Sep 2022 12:45:49 +0200
cmo@melexis.com wrote:

> From: Crt Mori <cmo@melexis.com>
> 
> As discussed previously on the group under the
> "Controlling device power management from terminal" thread the mlx90632
> sensor provides measurement capabilities under sleep_step mode. This
> series runtime suspends the unused chip to sleep step mode to save power
> but in case of continuous sequential reading it switches to continuous
> mode for faster readouts. This value is hardcoded to
> MLX90632_MEAS_MAX_TIME (with some buffer) and not user configurable.
> 
> The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
> hardcoded to 3 times as much as MEAS_MAX_TIME.
> 
> Changes in v4 (per review comments from Jonathan Cameron):
> 
>  - Migrate back to devm_pm_runtime_enable and remove the pm_disable function
>  - Remove pm stuff from remove and also sleep, since when iio device is
>    not registered also sleep makes no sense.

Not sure the bit about sleep making no sense.  We normally try and
leave a device in as low power a state as possible when we unbind (just general
being nice to the environment etc!)

We might have cut the power to the device, but disabling the regulator
might not have that affect (fixed regulator for example) so it's normal
to put devices into a low power state before cutting the power (in case
it's not cut!)

Right now, this series may give someone a power regression...

Jonathan


>  - Replace use EOPNOTSUPP as per checkpatch suggestion although some drivers
>    still use ENOTSUPP.
>  - Change the style of read frequency
> 
> Changes in v3 (per review comments from Jonathan Cameron):
> 
>  - Change the "available" attribute presentation to more recent way
>    suggested
>  - Replace devm_pm_runtime_enable with enable and devm_add_action_or_reset
>  - When suspending device also put it to lower power mode in case there is
>    dummy regulator
>  - Use more switch cases instead of if/else
> 
> Changes in v2:
> 
>  - apply review comments from Andy Shevchenko
> 
> Crt Mori (3):
>   iio: temperature: mlx90632 Add runtime powermanagement modes
>   iio: temperature: mlx90632 Read sampling frequency
>   iio: temperature: mlx90632 Change return value of sensor measurement
>     channel
> 
>  drivers/iio/temperature/mlx90632.c | 402 +++++++++++++++++++++++++----
>  1 file changed, 347 insertions(+), 55 deletions(-)
> 

