Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2981174BE13
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGHPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjGHPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF391E6E;
        Sat,  8 Jul 2023 08:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 591BD60DBB;
        Sat,  8 Jul 2023 15:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA226C433C8;
        Sat,  8 Jul 2023 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688829205;
        bh=PGb+TbPa49Jn+kBTUBve6wQ+i1RaCVvcOqYhJBYQmL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fBI/smWUT3SbZuWE4Qe2gNY1E4DNWKS7VF2VbCM5kWSMXjDsdOnFYOyZ+np1NOaoF
         MQgOu5NGb4vwgbJbkJF21ofifQxWzoysM22vldkwgZbqpHHMn6eW3V1ALX83Av7GCJ
         iUoQxzG+2rz4ofY8aK+42DGlnTKzdIRiXv/PFeIyfZ3FQNYq3HbxqZTv9dcXgiuWgk
         sjSlpnYlYp3rszkNIlLZO/FHfxeW1DThWMiuGQs89a6PzXvt62W7wAINUGizTtB5wy
         rxUWQ+rrmRjoZjj1jxRNgxhEojhrljDqYhy1sgbGrOUXzVjnmiPw8BDpuTqoGQtYIF
         ipfh6BI3n9V0w==
Date:   Sat, 8 Jul 2023 16:13:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 00/11] iio: adc: Add support for QCOM SPMI PMIC5 Gen3
 ADC
Message-ID: <20230708161314.68143cda@jic23-huawei>
In-Reply-To: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 12:58:24 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS. The major difference is
> that the register interface used here is that of an SDAM present on
> PMK8550, rather than a dedicated ADC peripheral. There may be more than one
> SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
> be used for either immediate reads (same functionality as previous PMIC5 and
> PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
> Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
> combined into the same driver.
> 
> Patches 1-5 update the name of the previous generation of PMIC5 ADC peripherals
> from ADC7 to ADC5 Gen2, as this is the correct name and it makes more sense now
> to update it, with the addition of the latest ADC5 Gen3 peripheral support.
> 
> Patches 6 and 7 add bindings and driver support respectively for ADC5 Gen3.
> 
> Patches 8-11 are for an additional change, where the QCOM ADC dt-bindings files
> are moved from dt-bindings/iio to dt-bindings/iio/adc folder, as they are
> specifically for ADC devices.
> 
This crossed with Dmitry's set...

https://patchwork.kernel.org/project/linux-iio/patch/20230707123027.1510723-2-dmitry.baryshkov@linaro.org/
which changes a bunch of the includes you are going to rename.

I don't mind which order these land (if both go forward) so will leave
it up to the two of you to figure that out and tell me ;)

Jonathan
