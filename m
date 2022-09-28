Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0102E5EDA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiI1KiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiI1KiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:38:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42AD195E4A;
        Wed, 28 Sep 2022 03:38:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 123F41595;
        Wed, 28 Sep 2022 03:38:25 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EB9C3F792;
        Wed, 28 Sep 2022 03:38:16 -0700 (PDT)
Message-ID: <ebb55252-f78b-e988-8a35-c41e6b6d7cda@arm.com>
Date:   Wed, 28 Sep 2022 11:37:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH-next v1] arm64: dts: rockchip: Enable NVM Express PCIe
 controller on rock3a
Content-Language: en-GB
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     linux.amoon@gmail.com, heiko@sntech.de, robh+dt@kernel.org,
        michael.riesch@wolfvision.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <e75cc292-ff7a-0daa-e2f9-fde376b5e26e@arm.com>
 <20220928100520.3886-1-amadeus@jmu.edu.cn>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220928100520.3886-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-28 11:05, Chukun Pan wrote:
> Hi,
> 
> On 27-09-22, 18:47, Robin Murphy wrote:
> 
>> (as a side note, is pcie2x1's vpcie3v3-supply as queued in -next
>> actually correct? AFAICS the other socket is effectively powered
>> straight from VCC3V3_SYS so shouldn't have needed VCC3V3_PCIE,
>> but at least it's there now ready for this one)
> 
> Thanks for the correction, I didn't notice this before. You are right,
> the supply of pcie2x1 comes from VCC3V3_SYS. But if we change supply
> of pcie2x1 to VCC3V3_SYS, it will cause pcie30phy to fail to initialize
> normally. The error is the same as the following:
> 
>> phy phy-fe8c0000.phy.4: rockchip_p3phy_rk3568_init: lock
>> failed 0x6890000, check input refclk and power supply
>> phy phy-fe8c0000.phy.4: phy init failed --> -110
>> rockchip-dw-pcie: probe of 3c0800000.pcie failed with error -110
> 
> If both vpcie3v3-supply of pcie2x1 and pcie3x2 use VCC3V3_PCIE like
> the vendor kernel, they can initialized normally.

Presumably that only works because you happen to be probing pcie2x1 
first, so it's not robust if that is disabled or probes later.

Looking again, it seems the answer was right there in the error message 
all along - the PCIe 3.0 phy wants its external reference clock 
describing correctly, and it's *that* clock which depends on 
VCC3V3_PI6C_03, which happens to be turned on in parallel with VCC3V3_PCIE.

Cheers,
Robin.
