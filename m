Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5C6BDDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCQBMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQBMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:12:50 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C71676049;
        Thu, 16 Mar 2023 18:12:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Ve0pgfd_1679015562;
Received: from 30.240.112.205(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Ve0pgfd_1679015562)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 09:12:43 +0800
Message-ID: <e38a84f2-6b8f-27a5-2898-98e637dca025@linux.alibaba.com>
Date:   Fri, 17 Mar 2023 09:12:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "lvying6@huawei.com" <lvying6@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cuibixuan@linux.alibaba.com" <cuibixuan@linux.alibaba.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230227050315.5670-2-xueshuai@linux.alibaba.com>
 <20230316072031.GA354196@hori.linux.bs1.fc.nec.co.jp>
 <c1040a40-239b-f8c1-13b3-37b40a90ddee@linux.alibaba.com>
 <SJ1PR11MB608394E7F78D116D09CAC26CFCBC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB608394E7F78D116D09CAC26CFCBC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/17 AM12:45, Luck, Tony wrote:
>> On x86 platform with MCA, patrol scrub errors are asynchronous error, which are
>> by default signaled with MCE. It is possible to downgrade the patrol scrub SRAO
>> to UCNA or other correctable error in the logging/signaling behavior and signal
>> CMCI only.
>>
>> As far as I know, on X86 platform, MCE is handled in do_machche_check() and only
>> asynchronous error is notified through HEST. Can we safely drop ACPI_HEST_NOTIFY_MCE
>> and only consider ACPI_HEST_NOTIFY_SEA as synchronous notification?
>>
>> Tony, do you have any comments on this? Please point out if I am wrong. Thank you.
> 
> You are correct. On x86 the HEST notifications are always asynchronous. The only
> synchronous events are machine check with IA32_MCi_STATUS.AR == 1 (patrol
> scrub and cache eviction machine checks are async and do not set this bit).
> 
> -Tony

Thank you for confirmation. I will drop ACPI_HEST_NOTIFY_MCE in is_hest_sync_notify().

Best Regards.
Shuai
