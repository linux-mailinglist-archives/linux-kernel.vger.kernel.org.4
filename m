Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F7E6C406F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCVChq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCVChm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:37:42 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8795A6C8;
        Tue, 21 Mar 2023 19:37:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VeOo7uX_1679452656;
Received: from 30.240.114.229(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VeOo7uX_1679452656)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 10:37:38 +0800
Message-ID: <78481cfe-ce74-58c4-20ab-caf6de0c4125@linux.alibaba.com>
Date:   Wed, 22 Mar 2023 10:37:34 +0800
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
 <93bbc216-9ae5-c22f-b6a8-f6591aa92c2a@linux.alibaba.com>
 <SJ1PR11MB6083C029A3C014DD5D09A30BFC819@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB6083C029A3C014DD5D09A30BFC819@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/22 AM12:09, Luck, Tony wrote:
>> Actually, firmware will do some platform dependent sanity checks and returns
>> different error codes. In this case, user injects to a invalid device, platform
>> returns "Invalid Access". And user is expected to see:
>>
>> 	# select a invalid core or device to inject
>> 	# echo 1 > error_inject
>> 	echo: write error: Invalid argument
>>
>> Then user is expected to check his injection argument first.
> 
> Thanks. This makes sense. You want EINVAL when the user chose
> bad arguments, and some other code for problem in BIOS.

Yes, exactly.

> 
> If the BIOS has an issue, is it possible, or likely, that it is a temporary
> problem? If so, EBUSY may be OK. The message " Device or resource busy"
> might encourage the user to wait and try again.
> 
> If it is not going to get better by itself, then one of:
> 
> #define EIO              5      /* I/O error */
> #define ENXIO            6      /* No such device or address */
> 
> might be a better choice.

Yes, BIOS may temporarily not complete error injection (ACPI_EINJ_EXECUTE_OPERATION)
on time, in which case, kernel return EIO.

	for (;;) {
		rc = apei_exec_run(&ctx, ACPI_EINJ_CHECK_BUSY_STATUS);
		if (rc)
			return rc;
		val = apei_exec_ctx_get_output(&ctx);
		if (!(val & EINJ_OP_BUSY))
			break;
		if (einj_timedout(&timeout))
			return -EIO;

In summary, you are asking that:

- report -EINVAL for "Invalid Access" case
- keeps reporting -EBUSY for "Unknown Failure" case unchanged.
- and keeps EIO for temporarily time out unchanged.

right? (This patch is doing so)

> 
> -Tony

Thanks.

Best Regards,
Shuai

