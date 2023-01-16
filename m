Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F7B66C677
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjAPQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjAPQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:20:09 -0500
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3332FCCC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:10:47 -0800 (PST)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140] helo=srivatsab3MD6R.vmware.com)
        by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1pHS49-00Ec49-Pd;
        Mon, 16 Jan 2023 11:10:33 -0500
Subject: Re: [PATCH] x86/paravirt: merge activate_mm and dup_mmap callbacks
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
References: <20230112152132.4399-1-jgross@suse.com>
 <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
 <27d08d32-1a17-0959-203f-39e769f555d1@suse.com>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <6a8e25eb-758d-8ad6-23c1-5fea7dab3b09@csail.mit.edu>
Date:   Mon, 16 Jan 2023 08:10:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <27d08d32-1a17-0959-203f-39e769f555d1@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/23 10:43 PM, Juergen Gross wrote:
> On 16.01.23 05:27, Srivatsa S. Bhat wrote:
>>
>> Hi Juergen,
>>
>> On 1/12/23 7:21 AM, Juergen Gross wrote:
>>> The two paravirt callbacks .mmu.activate_mm and .mmu.dup_mmap are
>>> sharing the same implementations in all cases: for Xen PV guests they
>>> are pinning the PGD of the new mm_struct, and for all other cases
>>> they are a NOP.
>>>
>>
>> I was expecting that the duplicated functions xen_activate_mm() and
>> xen_dup_mmap() would be merged into a common one, and that both
>> .mmu.activate_mm and .mmu.dup_mmap callbacks would be mapped to that
>> common implementation for Xen PV.
>>
>>> So merge them to a common callback .mmu.enter_mmap (in contrast to the
>>> corresponding already existing .mmu.exit_mmap).
>>>
>>
>> Instead, this patch seems to be merging the callbacks themselves...
>>
>> I see that's not an issue right now since there is no other actual
>> user for these callbacks. But are we sure that merging the callbacks
>> just because the current user (Xen PV) has the same implementation for
>> both is a good idea? The callbacks are invoked at distinct points from
>> fork/exec, so wouldn't it be valuable to retain that distinction in
>> semantics in the callbacks as well?
>>
>> However, if you believe that two separate callbacks are not really
>> required here (because there is no significant difference in what they
>> mean, rather than because their callback implementations happen to be
>> the same right now), then could you please expand on this and call it
>> out in the commit message, please?
> 
> Would you be fine with:
> 
>   In the end both callbacks are meant to register an address space with the
>   underlying hypervisor, so there needs to be only a single callback for that
>   purpose.
> 

Sure, that looks good. Thank you!
 
Regards,
Srivatsa
VMware Photon OS
