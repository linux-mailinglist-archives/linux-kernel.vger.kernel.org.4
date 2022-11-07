Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB53961F495
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiKGNnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKGNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:43:42 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2462BD6B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:43:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VUF-Nrn_1667828611;
Received: from 127.0.0.1(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VUF-Nrn_1667828611)
          by smtp.aliyun-inc.com;
          Mon, 07 Nov 2022 21:43:36 +0800
Message-ID: <0cd8601b-aa74-ee9a-cfb5-bb69445acc4c@linux.alibaba.com>
Date:   Mon, 7 Nov 2022 21:43:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] x86/tdx: Do not allow #VE due to EPT violation on the
 private memory
To:     Dave Hansen <dave.hansen@intel.com>,
        kirill.shutemov@linux.intel.com
Cc:     ak@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
        david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        x86@kernel.org
References: <20221028141220.29217-3-kirill.shutemov@linux.intel.com>
 <b5d04a6c-79b4-bbdc-b613-6958d9f75d53@linux.alibaba.com>
 <4bfcd256-b926-9b1c-601c-efcff0d16605@intel.com>
 <c2b60735-84a8-649e-536c-877c790eb101@linux.alibaba.com>
 <3cdb5bf8-7f26-0416-46d2-a5640dd27f22@intel.com>
From:   Guorui Yu <GuoRui.Yu@linux.alibaba.com>
In-Reply-To: <3cdb5bf8-7f26-0416-46d2-a5640dd27f22@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/7 21:31, Dave Hansen 写道:
> On 11/6/22 21:10, Guorui Yu wrote:
>>> Without ATTR_SEPT_VE_DISABLE, a #VE can occur on basically any
>>> instruction.  We call those kinds of exceptions "paranoid entry" points.
>>>    They need special handling like the NMI or #MC handlers.
>>>
>>> I'd be happy to look at a patch that does the MMIO path check *and*
>>> turns the #VE handler into a robust entry point.
>>>
>>> Bonus points if you can do ~5 lines of C like the approach in this
>>> thread.
>>
>> Yes, there is a fix to satify your requirement and get the bouns points 😄
>>
>> Please refer to
>> https://github.com/intel/tdx/commit/f045b0d52a5f7d8bf66cd4410307d05a90523f10
>>
>> case EXIT_REASON_EPT_VIOLATION:
>> + if (!(ve->gpa & tdx_shared_mask())) {
>> + panic("#VE due to access to unaccepted memory. "
>> + "GPA: %#llx\n", ve->gpa);
>> + }
>> +
>> /* original from Kirill and Kuppuswamy */
>>
>> It's already there, but it just didn't get into the main branch.
> 
> Could you explain how that prevents the #VE from occurring in the
> "syscall gap" or in a place where the kernel is running with the user
> GSBASE value?
> 
Thank you for explaining the "paranoid entry" points with there examples 
to me, now I understand why the SEPT_VE_DISABLE is necessary for TD.

> It doesn't as far as I can tell.  You need the SEPT_VE_DISABLE check for
> that.
