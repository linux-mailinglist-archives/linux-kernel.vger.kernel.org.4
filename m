Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DEF6A2AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 17:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBYQ5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 11:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 11:57:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0F6144AA;
        Sat, 25 Feb 2023 08:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F1CAB80B11;
        Sat, 25 Feb 2023 16:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0257C433D2;
        Sat, 25 Feb 2023 16:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677344235;
        bh=GaP3GmqpIGvwQRgNp6Fh+7v2avVXBPkK30VsFZF0gTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uaQy0+whyVWyoOYXjCZXCzEsN37ULGzrA3CcTasx9m2PHeXMsA5wWpzf/vVV/90Fc
         HWvV8UBxERryAn9R5N7oNKhULg98XIJVhIl4JePKDPLk3S/lQQNeJUsuYKEFiL7AMi
         Qsuq++qA2AjNx0bqGC7GoV3Efx0TBKvKPaUilDgrlcfdPrZqxkw8G+Igjn0e3Cbcg8
         sAHfgsyT8a/lIAx/v9x90zfww86VXTDwjqhaDKEaeRA2xN9v9xFJoCdfT68uAzE6sS
         gbMA9fmKyuuF58KnGNph25jGhlF7A7zWeUPRPME1pNX/k9IjMoezwepO8uXYfipjWm
         KyboSAQ/jctRA==
Date:   Sat, 25 Feb 2023 17:11:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] adding support for Microchip PAC193X Power
 Monitor
Message-ID: <20230225171139.65238b62@jic23-huawei>
In-Reply-To: <20230220123232.413029-1-marius.cristea@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 14:32:30 +0200
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> Adding support for Microchip PAC193X series of Power Monitor with
> Accumulator chip family.

This device is at the messy boundary between IIO and HWMON. Perhaps call out
the reasons you think IIO is more appropriate in this cover letter.
+ Often a good idea for these borderline parts to cc both mailing lists and
maintainers.

Often the conclusion is that it is fine to have these in IIO because we can
bridge to hwmon anyway with the iio-hwmon driver.

> 
> Differences related to previous patch:
> 
> v1:
> - first version comitted to review
> 
> 
> Marius Cristea (2):
>   dt-bindings: iio: adc: adding dt-bindings for PAC193X
>   iio: adc: adding support for pac193x
> 
>  .../bindings/iio/adc/microchip,pac193x.yaml   |  122 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   12 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/pac193x.c                     | 2072 +++++++++++++++++
>  5 files changed, 2214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
>  create mode 100644 drivers/iio/adc/pac193x.c
> 

