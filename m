Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5D7199C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjFAKbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjFAKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:31:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7E2D185;
        Thu,  1 Jun 2023 03:31:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F4044169C;
        Thu,  1 Jun 2023 03:32:19 -0700 (PDT)
Received: from [10.57.84.85] (unknown [10.57.84.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C79D73F663;
        Thu,  1 Jun 2023 03:31:32 -0700 (PDT)
Message-ID: <1751a3c4-a6b0-0a8c-cd1b-c05d25d30380@arm.com>
Date:   Thu, 1 Jun 2023 11:31:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] acpi: Fix header declaration of acpi_arch_dma_setup() w/o
 CONFIG_ACPI
To:     Hanjun Guo <guohanjun@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, lpieralisi@kernel.org,
        sudeep.holla@arm.com
Cc:     kernel test robot <lkp@intel.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <168477156440.3873520.6153672647621739139.stgit@djiang5-mobl3>
 <0953941a-ad4e-ba7e-4f4e-64c47de71f0b@huawei.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0953941a-ad4e-ba7e-4f4e-64c47de71f0b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-01 02:48, Hanjun Guo wrote:
> Hi Dave,
> 
> Sorry for the late reply, I have some comments inline.
> 
> On 2023/5/23 0:06, Dave Jiang wrote:
>> arm64 build can be done without CONFIG_ACPI. The ifdef bits for
>> acpi_arch_dma_setup() is placed inside CONFIG_ACPI. When CONFIG_ACPI is
>> not set, this causes warning reported by kernel test bot. Move the
>> prototype declaration for acpi_arch_dma_setup() outside of CONFIG_ACPI.
> 
> ...
> 
>>
>>>> drivers/acpi/arm64/dma.c:7:6: warning: no previous prototype for 
>>>> function 'acpi_arch_dma_setup' [-Wmissing-prototypes]
>>     void acpi_arch_dma_setup(struct device *dev)
>>          ^
>>     drivers/acpi/arm64/dma.c:7:1: note: declare 'static' if the 
>> function is not intended to be used outside of this translation unit
>>     void acpi_arch_dma_setup(struct device *dev)
>>     ^
>>     static
>>     1 warning generated.
> 
> drivers/acpi can only be compiled with CONFIG_ACPI=y, so
> drivers/acpi/arm64/ will be the same, not sure how to trigger
> this compile warning.
> 
> I disable CONFIG_ACPI on my ARM64 machine, but didn't get the
> warning you reported.

Looking at the linked LKP report, it seems it's it's explicitly trying 
to build drivers/acpi/arm64/ despite the config:

         mkdir build_dir && cp config build_dir/.config
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 
O=build_dir ARCH=arm64 olddefconfig
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 
O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/arm64/

So I guess it's a problem with the LKP setup? In general, trying to 
build arbitrary parts of the kernel which are configured out can never 
be expected to work.

Thanks,
Robin.
