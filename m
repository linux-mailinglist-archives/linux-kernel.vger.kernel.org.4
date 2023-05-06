Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01C76F930E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEFQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F56E93;
        Sat,  6 May 2023 09:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A91360C16;
        Sat,  6 May 2023 16:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F102C433D2;
        Sat,  6 May 2023 16:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683390084;
        bh=+k1S10i117djIlhf8QUdyde1OoPmwl3xkOsRBHZ2gfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sgKrVytoOguA7OmEf0TQsM/HIDA/LJhJUAfvA385tawwGB42/Gy/CM7OWCNvg7jF6
         +0QizKxt7BJhCOl5VCtb023kmZ+sg7ce/7av0n8N9FJNrNKAKDXbHCmx+kR8J9eRJ5
         Pudh17983rKGw3ANZQu+as0vi15ddqYdOWYOh5ty9ie0v+ssEvhoS1h03jGvkmyxOU
         yWiA65DObTeHVJ8G/blTAtd9tNkexHoO8f8UFClJvApdqnks3hXwlrJe1zgmrfoKlx
         JDYLMWSNp8mwOfza4MboH9N86urd0tfHtmTUsUdxZknyit8IipFFCJKAtZWMVWb90V
         mueymIy8b0MFQ==
Date:   Sat, 6 May 2023 17:37:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <jmaneyrol@invensense.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v3 0/2] Add support for the ICM 20600 IMU
Message-ID: <20230506173717.11d0d311@jic23-huawei>
In-Reply-To: <20230505054853.2155326-1-chenhuiz@axis.com>
References: <20230505054853.2155326-1-chenhuiz@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 13:48:51 +0800
Hermes Zhang <chenhuiz@axis.com> wrote:

> The Invensense ICM-20600 is a 6-axis MotionTracking device that combines a
> 3-axis gyroscope and an 3-axis accelerometer. It is very similar to the
> ICM20602 imu which is already supported by the mpu6050 driver. The main
> difference is that the ICM-20600 has a different WHOAMI value.
> 
> Notes:
>     v2: require specifying "invensense,icm20602" as a fallback compatible
>         in the binding, as suggested
>     v3: reorder "invensense,icm20602" entry before icm20608 and add
>         Reviewed-by tag from Krzysztof

Looks good to me.  I want to leave a little more time for Jean-Baptiste to take
a look.  If it looks like I've forgotten this in 2 weeks, feel free to give me
a poke.

Thanks,

Jonathan


> 
> Hermes Zhang (2):
>   dt-bindings: iio: imu: mpu6050: Add icm20600 bindings to mpu6050
>   iio: imu: mpu6050: Add support for the ICM 20600 IMU
> 
>  .../bindings/iio/imu/invensense,mpu6050.yaml           |  3 +++
>  drivers/iio/imu/inv_mpu6050/Kconfig                    |  4 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c             | 10 ++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c              |  6 ++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h              |  2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c              |  5 +++++
>  6 files changed, 28 insertions(+), 2 deletions(-)
> 

