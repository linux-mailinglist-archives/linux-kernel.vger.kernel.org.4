Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00447152E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjE3BRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjE3BRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:17:37 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F447DB;
        Mon, 29 May 2023 18:17:34 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5122:716f:f7f7:9d52:5f22] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 34U1F5td003739-34U1F5te003739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 30 May 2023 09:15:06 +0800
Message-ID: <680d83a5-22fa-4851-b82d-ca59b67c5ad2@hust.edu.cn>
Date:   Tue, 30 May 2023 09:11:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] media: atomisp: move the sanity checks before variable
 dereferences
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230529152136.11719-1-dzm91@hust.edu.cn>
 <ef8e411b-c326-9d24-c4f0-96cd183a9d1f@redhat.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <ef8e411b-c326-9d24-c4f0-96cd183a9d1f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/23 23:46, Hans de Goede wrote:
> Hi,
> 
> On 5/29/23 17:21, Dongliang Mu wrote:
>> Smatch reports:
>>
>> sh_css_load_firmware() warn: variable dereferenced before check 'fw_data'
>>
>> The variable fw_data can be NULL in sh_css_load_firmware, resulting in
>> NULL pointer dereference.
>>
>> Fix this by moving the sanity checks before variable dereferences.
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> Thank you for your patch, but the same patch has already been submitted
> and merged into my media-atomisp branch about a week ago:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/commit/?h=media-atomisp&id=c09907049eea9f12e959fb88c02a483a4c5eee89

I see. Thanks for your reply.

> 
>> ---
>>   drivers/staging/media/atomisp/pci/sh_css_firmware.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/media/atomisp/pci/sh_css_firmware.c b/drivers/staging/media/atomisp/pci/sh_css_firmware.c
>> index e7ef578db8ab..38b757c3df0a 100644
>> --- a/drivers/staging/media/atomisp/pci/sh_css_firmware.c
>> +++ b/drivers/staging/media/atomisp/pci/sh_css_firmware.c
>> @@ -229,6 +229,10 @@ sh_css_load_firmware(struct device *dev, const char *fw_data,
>>   	struct sh_css_fw_bi_file_h *file_header;
>>   	int ret;
>>   
>> +	/* some sanity checks */
>> +	if (!fw_data || fw_size < sizeof(struct sh_css_fw_bi_file_h))
>> +		return -EINVAL;
>> +
>>   	firmware_header = (struct firmware_header *)fw_data;
>>   	file_header = &firmware_header->file_header;
>>   	binaries = &firmware_header->binary_header;
>> @@ -243,10 +247,6 @@ sh_css_load_firmware(struct device *dev, const char *fw_data,
>>   		IA_CSS_LOG("successfully load firmware version %s", release_version);
>>   	}
>>   
>> -	/* some sanity checks */
>> -	if (!fw_data || fw_size < sizeof(struct sh_css_fw_bi_file_h))
>> -		return -EINVAL;
>> -
>>   	if (file_header->h_size != sizeof(struct sh_css_fw_bi_file_h))
>>   		return -EINVAL;
>>   
