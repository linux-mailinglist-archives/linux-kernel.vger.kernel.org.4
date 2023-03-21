Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFE6C27B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCUCAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCUCAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:00:36 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC98919C42;
        Mon, 20 Mar 2023 19:00:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VeL2IlV_1679364028;
Received: from 30.240.114.229(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VeL2IlV_1679364028)
          by smtp.aliyun-inc.com;
          Tue, 21 Mar 2023 10:00:29 +0800
Message-ID: <93bbc216-9ae5-c22f-b6a8-f6591aa92c2a@linux.alibaba.com>
Date:   Tue, 21 Mar 2023 10:00:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
 <SJ1PR11MB60836145DD10108B1FE13A4FFCBD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <91796ce2-2f63-4b07-3e44-dc2a2a98615e@linux.alibaba.com>
 <SJ1PR11MB60831F4A66DB77095B4314FDFC809@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB60831F4A66DB77095B4314FDFC809@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/21 AM12:32, Luck, Tony wrote:
>>> I don't see how reporting -EBUSY for the "Unknown Failure" case is
>>> actually better.
>>
>> Tony, did you misunderstand this patch?
>>
>> The original code report -EBUSY for both "Unknown Failure" and
>> "Invalid Access" cases.
> 
> I mixed up what was already in the kernel with what the patch was changing.
> 
>> This patch intends to report -EINVAL for "Invalid Access" case
>> and keeps reporting -EBUSY for "Unknown Failure" case unchanged.
>> Although -EBUSY for "Unknown Failure" case is not a good choice.
>> Will -EIO for "Unknown failure" case be better?
> 
> Is this for some real use case?
> 
> Do you have a BIOS EINJ implementation that is returning these different codes?

Yes, our BIOS tester complains that EINJ always reports EBUSY, and he has no idea
about it. It can not help him determine whether it is a BIOS bug or an injection
operation error.

> What will the user do differently if they see these different error strings?
> 
>   # echo 1 > error_inject
>   ... different error messages here ...

For example, with original code:

	# select a invalid core or device to inject
	# echo 1 > error_inject
	echo: write error: Device or resource busy

When tester sees that, he will submit a bug to BIOS developer.

Actually, firmware will do some platform dependent sanity checks and returns
different error codes. In this case, user injects to a invalid device, platform
returns "Invalid Access". And user is expected to see:

	# select a invalid core or device to inject
	# echo 1 > error_inject
	echo: write error: Invalid argument

Then user is expected to check his injection argument first.


> 
> -Tony
> 

Best Regards,
Shuai
