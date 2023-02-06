Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283B368B5CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBFGwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBFGwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:52:44 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FADFEB48;
        Sun,  5 Feb 2023 22:52:41 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VaylKZS_1675666353;
Received: from 30.221.133.155(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VaylKZS_1675666353)
          by smtp.aliyun-inc.com;
          Mon, 06 Feb 2023 14:52:39 +0800
Message-ID: <fd49c9f8-3132-c47c-5948-9aee3b1fd625@linux.alibaba.com>
Date:   Mon, 6 Feb 2023 14:52:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] ACPICA: PCI: Undefined ACPI_ADR_SPACE_PCI_CONFIG when
 CONFIG_PCI is unset
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        jkchen@linux.alibaba.com, xueshuai@linux.alibaba.com
References: <20230202034821.25123-1-tianruidong@linux.alibaba.com>
 <CAJZ5v0i=2f+NFHbyYNgL8vqkcf8ST=14-uqHqOUmL0JPVhmiBw@mail.gmail.com>
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <CAJZ5v0i=2f+NFHbyYNgL8vqkcf8ST=14-uqHqOUmL0JPVhmiBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depends on kernel-specific ACPICA configuration, can I submit 
it to ACPICA

projects?

On 2023/2/2 17:31, Rafael J. Wysocki wrote:
> On Thu, Feb 2, 2023 at 4:48 AM Ruidong Tian
> <tianruidong@linux.alibaba.com> wrote:
>> ACPI core subsystem initialization will fail when Kernel disabled PCI but
>> ACPI tables still have PCI config address spaces.
>>
>> Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces
>> only when ACPI_PCI_CONFIGURED is defined.
>>
>> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> As an ACPICA change, this should first be submitted (as a pull
> request) to the upstream ACPICA project on GitHub.
>
> Having done that, please resubmit the patch with a Link tag pointing
> to the corresponding upstream pull request.
>
> Thanks!
>
>> ---
>>   drivers/acpi/acpica/evhandler.c | 2 ++
>>   include/acpi/acconfig.h         | 4 ++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
>> index be9a05498adc..86057e39df8c 100644
>> --- a/drivers/acpi/acpica/evhandler.c
>> +++ b/drivers/acpi/acpica/evhandler.c
>> @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
>>   u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
>>          ACPI_ADR_SPACE_SYSTEM_MEMORY,
>>          ACPI_ADR_SPACE_SYSTEM_IO,
>> +#ifdef ACPI_PCI_CONFIGURED
>>          ACPI_ADR_SPACE_PCI_CONFIG,
>> +#endif
>>          ACPI_ADR_SPACE_DATA_TABLE
>>   };
>>
>> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
>> index 151e40385673..28456120529f 100644
>> --- a/include/acpi/acconfig.h
>> +++ b/include/acpi/acconfig.h
>> @@ -162,7 +162,11 @@
>>   /* Maximum space_ids for Operation Regions */
>>
>>   #define ACPI_MAX_ADDRESS_SPACE          255
>> +#ifdef ACPI_PCI_CONFIGURED
>>   #define ACPI_NUM_DEFAULT_SPACES         4
>> +#else
>> +#define ACPI_NUM_DEFAULT_SPACES         3
>> +#endif
>>
>>   /* Array sizes.  Used for range checking also */
>>
>> --
>> 2.33.1
>>
