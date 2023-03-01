Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319066A709A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCAQNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCAQNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:13:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F42033C1D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:13:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B59D92F4;
        Wed,  1 Mar 2023 08:13:49 -0800 (PST)
Received: from [10.57.78.237] (unknown [10.57.78.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40EA63F67D;
        Wed,  1 Mar 2023 08:13:05 -0800 (PST)
Message-ID: <410c8561-a7e3-6a3f-b634-08adaa806111@arm.com>
Date:   Wed, 1 Mar 2023 16:12:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] irqchip/gic-v3: Claim iomem resources
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>, Tim Harvey <tharvey@gateworks.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <c534c2a458a3bf94ccdae8abc6edc3d45a689c30.1649777295.git.robin.murphy@arm.com>
 <CAJ+vNU3+rz50MRQQsz39Jfbspy2ig9tqzb_yg1RFooxGutCM+g@mail.gmail.com>
 <86lekhl6i6.wl-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <86lekhl6i6.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-28 23:22, Marc Zyngier wrote:
> On Tue, 28 Feb 2023 23:11:15 +0000,
> Tim Harvey <tharvey@gateworks.com> wrote:
>>
>> I have bisected a kernel issue where octeontx (CN803x) will hang on
>> reboot caused by commit c0db06fd0993 ("mmc: core: Disable card detect
>> during shutdown"). This commit made it into 5.16 and stable kernels.
>> I've found that the patch here which is commit 2b2cd74a06c3 resolves
>> this hang but I'm not entirely clear why.
>>
>> Does anyone have a good explanation of why the hang occurs in the
>> first place and why this resolves it? I would like to get the proper
>> fix into the affected stable branches.
> 
> Wild guess: the reservation prevents some other driver from probing
> because the firmware describes overlapping ranges, and that driver is
> what is causing your above hang.

Indeed, according to [1], the GIC appears to overlap one of the "PCIe" 
windows of &ecam0, which conveniently appears to be the parent of the 
MMC controller as well.

Robin.

[1] 
https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/cn81xx-linux.dtsi
