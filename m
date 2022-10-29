Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15E6122CC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJ2MNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2MNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:13:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7735367064;
        Sat, 29 Oct 2022 05:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24929B80B56;
        Sat, 29 Oct 2022 12:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0071EC433D6;
        Sat, 29 Oct 2022 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667045594;
        bh=F3qWBTI+yvIFheV5lenosl5Dyx+Cl97Zk158NxZTZ/g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UclWApWNPCxfDoKVkcoa4XflI/vUYnKxTT1fbLdnmjB2ehJPZOv0lf2w91DylPDfU
         MFORaH47F4cc6Te0mq+bXt5sz2AOKKKhDK9BW7cvlwm2SKzrDdudBpcetdgjtNjyVD
         +5dYsCLcdK1+7Q1TKE/Wpa8HJV25TniMmtXkRbyaV3Wucb/Ow/A5lvyKf+6GXacSd6
         NataCr77AHA5g7ZvVISstolsCCJAiC/js0Ttms5fdurqv1+TrdobOwe/vLyVIrUiti
         e69RZhcUOkzzAvngcV4lGl0pJLnA/TP/CkKn9gjfVaNki8S/kd+2n9wHeoiE+/0DK4
         471wAKUoK1T/A==
Date:   Sat, 29 Oct 2022 13:25:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ihkose@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com
Subject: Re: [PATCH v3] dt-bindings: iio: dac: Change the I2C slave address
 for ds4422/4424 to its correct value
Message-ID: <20221029132508.515ad955@jic23-huawei>
In-Reply-To: <3197497f-26ce-372f-6fb9-33e576cc786e@linaro.org>
References: <20221024175008.196714-1-rajat.khandelwal@linux.intel.com>
        <3197497f-26ce-372f-6fb9-33e576cc786e@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022 19:23:09 -0400
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 24/10/2022 13:50, Rajat Khandelwal wrote:
> > The datasheet states that the slave address for the device is 0x20
> > when the pins A0 and A1 are ground. The DT binding has been using
> > 0x10 as the value and I think it should be 0x20 as per datasheet.
> > 
> > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > ---  
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

hmm. This is curious. So the datasheet indeed provides a table saying
grounding both pins sets the address to 0x20, however take a look at
Figure 2 which says the address is
A1 | A0 | 1 | 0 | 0 | 0 | 0

or 0x10 as per the example.  My guess is someone forgot that i2c addresses
are 7 bits and the lowest bit of the first byte is used for R/W control.

So unless we have this verified on hardware (implying that the address table
is correct in this sense) I'm not keen to take this.
I doubt that is the case given it has 8 bit addresses (0xe0) and i2c addresses
are 7 bits.

Jonathan


> Best regards,
> Krzysztof
> 

