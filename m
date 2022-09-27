Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54B5EC742
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiI0PKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiI0PJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:09:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011255FB4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:09:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47CC91063;
        Tue, 27 Sep 2022 08:09:52 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22CC83F792;
        Tue, 27 Sep 2022 08:09:44 -0700 (PDT)
Message-ID: <9db42ab0-da49-95fd-3fea-eb505af0867e@arm.com>
Date:   Tue, 27 Sep 2022 16:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] iommu/io-pgtable: Make IOMMU_IO_PGTABLE_DART invisible
Content-Language: en-GB
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <b0981cb5a97452af73b9dd0dd0eb03c5002f7af4.1664285626.git.geert+renesas@glider.be>
 <fe2b1f48-e18a-b1d9-0c62-ddddf9e6515f@arm.com>
 <CAMuHMdVFAwqVtrRFf-_jSODWeJuGAzbpoyk65HDOqj9h6AUt2A@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMuHMdVFAwqVtrRFf-_jSODWeJuGAzbpoyk65HDOqj9h6AUt2A@mail.gmail.com>
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

On 2022-09-27 15:48, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Tue, Sep 27, 2022 at 4:15 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2022-09-27 14:36, Geert Uytterhoeven wrote:
>>> There is no point in asking the user about both "Apple DART Formats" and
>>> "Apple DART IOMMU Support", as the former is useless without the latter,
>>> and the latter auto-selects the former.
>>>
>>> Fixes: 745ef1092bcfcf3b ("iommu/io-pgtable: Move Apple DART support to its own file")
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> Should IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S be made
>>> invisible, too?
>>> Are there users that do not select them?
>>
>> The aim was for formats to be independently selectable for COMPILE_TEST
>> coverage. The Arm formats are manually selectable for the sake of their
>> runtime self-tests, which are self-contained, but since DART format
>> doesn't do anything by itself I'd agree there's no need to prompt when
>> !COMPILE_TEST here.
> 
> IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S are
> selected by other symbols that can be enabled when compile-testing, so
> the tests can still be enabled in those cases, too

Sure, but when you want to compile-test a thing, what would you rather 
do: enable the thing, or go hunting to find some other thing that 
happens to select the thing you actually want, then potentially have to 
figure out *that* thing's dependencies, and so on?

Coverage isn't solely about whether it's technically possible to ever 
reach somewhere at all, it's just as much about how easily and/or often 
you can get there in practice. I don't see who benefits from making 
COMPILE_TEST harder to use :/

Thanks,
Robin.
