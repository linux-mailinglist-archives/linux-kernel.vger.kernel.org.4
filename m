Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14216622A93
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKILaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKILan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:30:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC1561CFF5;
        Wed,  9 Nov 2022 03:30:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 445581FB;
        Wed,  9 Nov 2022 03:30:47 -0800 (PST)
Received: from [10.1.36.52] (FVFF763DQ05P.cambridge.arm.com [10.1.36.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60D5A3F534;
        Wed,  9 Nov 2022 03:30:39 -0800 (PST)
Message-ID: <8f6d3424-2650-8e8b-61f7-1431aec4633b@arm.com>
Date:   Wed, 9 Nov 2022 11:30:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH V5 2/7] arm64/perf: Update struct arm_pmu for BRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-3-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221107062514.2851047-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 06:25, Anshuman Khandual wrote:
> Although BRBE is an armv8 speciifc HW feature, abstracting out its various
> function callbacks at the struct arm_pmu level is preferred, as it cleaner
> , easier to follow and maintain.
> 
> Besides some helpers i.e brbe_supported(), brbe_probe() and brbe_reset()
> might not fit seamlessly, when tried to be embedded via existing arm_pmu
> helpers in the armv8 implementation.
> 
> Updates the struct arm_pmu to include all required helpers that will drive
> BRBE functionality for a given PMU implementation. These are the following.
> 
> - brbe_filter	: Convert perf event filters into BRBE HW filters
> - brbe_probe	: Probe BRBE HW and capture its attributes
> - brbe_enable	: Enable BRBE HW with a given config
> - brbe_disable	: Disable BRBE HW
> - brbe_read	: Read BRBE buffer for captured branch records
> - brbe_reset	: Reset BRBE buffer
> - brbe_supported: Whether BRBE is supported or not
> 
> A BRBE driver implementation needs to provide these functionalities.

Could these not be hidden from the generic arm_pmu and kept in the
arm64 pmu backend  ? It looks like they are quite easy to simply
move these to the corresponding hooks in arm64 pmu.

Suzuki

