Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4619866BC2C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjAPKt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAPKtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:49:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A55419695;
        Mon, 16 Jan 2023 02:49:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E8CFAD7;
        Mon, 16 Jan 2023 02:50:29 -0800 (PST)
Received: from [10.57.89.182] (unknown [10.57.89.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 124423F71A;
        Mon, 16 Jan 2023 02:49:44 -0800 (PST)
Message-ID: <98971687-90c4-85f3-da23-4286751c2c2a@arm.com>
Date:   Mon, 16 Jan 2023 10:49:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v16 0/2] Add support for UltraSoc System Memory Buffer
To:     Junhao He <hejunhao3@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        lpieralisi@kernel.org, linuxarm@huawei.com, yangyicong@huawei.com,
        liuqi6124@gmail.com, f.fangjian@huawei.com, shenyang39@huawei.com,
        prime.zeng@hisilicon.com
References: <20230114101302.62320-1-hejunhao3@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230114101302.62320-1-hejunhao3@huawei.com>
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

On 14/01/2023 10:13, Junhao He wrote:
> Add support for UltraSoc System Memory Buffer.
> 
> Change since v15:
> - Modify document based on Bagas and Suzuki's comments.
> - Link: https://lore.kernel.org/lkml/20221220092945.30722-1-hejunhao3@huawei.com/
> 
> Change since v14:
> - Add some helpers to the buffer and simplify dumping data according to Jonathan's comment.
> - Link: https://lore.kernel.org/lkml/20221123123823.27973-1-hejunhao3@huawei.com/
> 
> Change since v13:
> - Modify document and the patches description according to Bagas's comment.
> - Add dependency on config ACPI, drop redundant enable hw in smb_update_buffer(),
>    Modify smb_purge_data() description according to Suzuki's comment.
> - Link: https://lore.kernel.org/lkml/20221114090316.63157-1-hejunhao3@huawei.com/
> 
> Change since v12:
> - Modify the code style and add "#ifdef CONFIG_ACPI" according to Jonathan's comment.
> - Address the comments from Yicong, included drop "buf_base"__iomem attribute,
>    modify the "reading" type to bool and fix FIELD_PREP.
> - Link: https://lore.kernel.org/lkml/20221109135008.9485-1-hejunhao3@huawei.com/
> 
> Change since v11:
> - Modify the code style and rename the macro according to Jonathan's comment.
> - Link: https://lore.kernel.org/lkml/20221107130624.59886-1-hejunhao3@huawei.com/
> 
> Change since v10:
> - Rebase onto v6.1-rc4, included similar sysfs register accessors (as same as James's patch)
> - Link: https://lore.kernel.org/lkml/20221022115929.7503-1-hejunhao3@huawei.com/
> 
> Change since v9:
> - Update the Contact tag in SMB document.
> - Replace the spinlock with mutex.
> - Do some clean-ups in "smb_enable()" and "smb_release()".
> - Use classic memory mapped interface.
> - Link: https://lore.kernel.org/linux-arm-kernel/20220818132231.28240-1-hejunhao3@huawei.com/
> 
> Change since v8:
> - Insert a blank line at the end of the config tag in Kconfig according to Randy's comment.
> - Link: https://lore.kernel.org/linux-arm-kernel/20220816131634.38195-1-hejunhao3@huawei.com/
> 
> Change since v7:
> - Use the macros for register bit flags and numbers of resource.
> - Cleanup punctuation.
> - Update the Date tag and the KernelVersion tag in the document.
> - Link: https://lore.kernel.org/lkml/20220712091353.34540-1-hejunhao3@huawei.com/
> 
> Change since v6:
> - Modify the code style and driver description according to Suzuki's comment.
> - Modify configuration of "drvdata->reading", to void problems in open/read
>    concurrency scenario.
> - Rename the macro of "SMB_FLOW_MASK".
> - Use the "handle->head" to determine the page number and offset.
> - Link: https://lore.kernel.org/linux-arm-kernel/20220606130223.57354-1-liuqi115@huawei.com/
> 
>    Change since v5:
> - Address the comments from Suzuki, add some comments in SMB document, and modify
>    configuration of "drvdata->reading", to void problems in multi-core concurrency scenario
> - Link: https://lore.kernel.org/linux-arm-kernel/20220416083953.52610-1-liuqi115@huawei.com/
> 
> Change since v4:
> - Add a simple document of SMB driver according to Suzuki's comment.
> - Address the comments from Suzuki.
> - Link: https://lore.kernel.org/linux-arm-kernel/20220128061755.31909-1-liuqi115@huawei.com/
> 
> Change since v3:
> - Modify the file header according to community specifications.
> - Address the comments from Mathieu.
> - Link: https://lore.kernel.org/linux-arm-kernel/20211118110016.40398-1-liuqi115@huawei.com/
> 
> Change since v2:
> - Move ultrasoc driver to drivers/hwtracing/coresight by Mathieu's comment.
> - Link: https://lists.linaro.org/pipermail/coresight/2021-November/007310.html
> 
> Change since v1:
> - Drop the document of UltraSoc according to Mathieu's comment.
> - Add comments to explain some private hardware settings.
> - Address the comments from Mathieu.
> - Link: https://lists.linaro.org/pipermail/coresight/2021-August/006842.html
> 
> Change since RFC:
> - Move driver to drivers/hwtracing/coresight/ultrasoc.
> - Remove ultrasoc-axi-com.c, as AXI-COM doesn't need to be configured in
>    basic tracing function.
> - Remove ultrasoc.c as SMB does not need to register with the ultrasoc core.
> - Address the comments from Mathieu and Suzuki.
> - Link: https://lists.linaro.org/pipermail/coresight/2021-June/006535.html
> 
> Qi Liu (2):
>    drivers/coresight: Add UltraSoc System Memory Buffer driver
>    Documentation: Add document for UltraSoc SMB driver


Queued to coresight next tree

https://git.kernel.org/coresight/c/06f5c2926aaa
https://git.kernel.org/coresight/c/2d4103ae31aa

Thanks for the patches

Suzuki
