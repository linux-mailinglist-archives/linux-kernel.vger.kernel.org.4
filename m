Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83091623CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiKJHqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiKJHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55099275DB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668066322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CbKM6HsuEr9pYKeniaYinGN0vDbKCsNwgUB4Y3gV0g=;
        b=IpFPt/ZhA0wd3lF7RL3ILHbiGtRqbE6arEc2+keAuMpSseAIoLSe/rIzHbv42jhvN8CWYg
        b5XnHWUWBMSknPFX+ZIZpbGokoW7RJi11Qc1oUkLzd7WYBIbNG92Xr/dM4sn+gSfbUgujv
        WnuBqHjqDdFXaXaG5El+tlnhfwv379U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-CwtkIRkIOCScnYBni9CQ8w-1; Thu, 10 Nov 2022 02:45:21 -0500
X-MC-Unique: CwtkIRkIOCScnYBni9CQ8w-1
Received: by mail-pj1-f71.google.com with SMTP id lx3-20020a17090b4b0300b002137705324eso3484786pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 23:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CbKM6HsuEr9pYKeniaYinGN0vDbKCsNwgUB4Y3gV0g=;
        b=aBW7TBcKT5KniUuL2F5WI48sLp01RCdH2xDUZsZWjXy77CmECeM/LdZdwY0GElB83x
         oMYyH8rCzAHoDATAS1IrbXDw7Ed+L64Vr573g18rMySdTCSrEO/02qbRFmplnq5GpCBz
         ru6/f4QQce3s6NUhmgbzdBerpcdNu9Ud346Qq+/vL2ckmRP7Ni1YA2BlPEKUBhXGhH0g
         3UrKXbvJ0mwaM6pn22QrDtdoD+g0T6Xscbep1w7cdrwHshv2yyqnh58dry8mmWWqQg0O
         ScOwnPrFbQkoIZeC/KpLwitSHlfBpNf08azHkxzb6avIUJfpYk46Mdyv7/spKl6Vf2/w
         NHWQ==
X-Gm-Message-State: ACrzQf3QliEMJ//i6AMxxfDdQl73+FReUH0dNl6PxLyhmRM140FThljm
        jedydRNDoq4oKaLp+oAERIGE/0001ag9CCEhW5mXkgvjQTum40OI7zViMvcKV45csKNJ7wgmoG3
        RnUXPxGpK4FJBBX/wxXjDKIFJ
X-Received: by 2002:a17:903:40c9:b0:186:e377:f4e2 with SMTP id t9-20020a17090340c900b00186e377f4e2mr64292933pld.101.1668066319958;
        Wed, 09 Nov 2022 23:45:19 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6BcN41FSquID3RiTHggs6vP9vQa0wjTDtKj5QCNr9/SM6biXcv0t6Nzu8zDUOms+/f5iS6KQ==
X-Received: by 2002:a17:903:40c9:b0:186:e377:f4e2 with SMTP id t9-20020a17090340c900b00186e377f4e2mr64292921pld.101.1668066319667;
        Wed, 09 Nov 2022 23:45:19 -0800 (PST)
Received: from [10.33.192.232] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id e63-20020a621e42000000b005385e2e86eesm9833578pfe.18.2022.11.09.23.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 23:45:18 -0800 (PST)
Message-ID: <060d927e-59f0-1e10-06ac-ed323b2a5433@redhat.com>
Date:   Thu, 10 Nov 2022 08:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 0/3] Use TAP in some more KVM selftests
Content-Language: en-US
To:     David Matlack <dmatlack@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221004093131.40392-1-thuth@redhat.com>
 <Y0nOv6fqTe2NnPuu@google.com> <Y2mrh7h1jrZSPU5l@google.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <Y2mrh7h1jrZSPU5l@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 02.06, David Matlack wrote:
> On Fri, Oct 14, 2022 at 09:03:59PM +0000, Sean Christopherson wrote:
>> On Tue, Oct 04, 2022, Thomas Huth wrote:
>>> Many KVM selftests are completely silent. This has the disadvantage
>>> for the users that they do not know what's going on here. For example,
>>> some time ago, a tester asked me how to know whether a certain new
>>> sub-test has been added to one of the s390x test binaries or not (which
>>> he didn't compile on his own), which is hard to judge when there is no
>>> output. So I finally went ahead and implemented TAP output in the
>>> s390x-specific tests some months ago.
>>>
>>> Now I wonder whether that could be a good strategy for the x86 and
>>> generic tests, too?
>>
>> Taking Andrew's thoughts a step further, I'm in favor of adding TAP output, but
>> only if we implement it in such a way that it reduces the burden on writing new
>> tests.  I _really_ like that sync_regs_test's subtests are split into consumable
>> chunks, but I worry that the amount of boilerplate needed will deter test writes
>> and increase the maintenance cost.
>>
>> And my experience with KVM-unit-tests is that letting test writers specify strings
>> for test names is a bad idea, e.g. using an arbitrary string creates a disconnect
>> between what the user sees and what code is running, and makes it unnecessarily
>> difficult to connect a failure back to code.  And if we ever support running
>> specific testcases by name (I'm still not sure this is a net positive), arbitrary
>> strings get really annoying because inevitably an arbitrary string will contain
>> characters that need to be escaped in the shell.
>>
>> Adding a macro or three to let tests define and run testscases with minimal effort
>> would more or less eliminate the boilerplate.  And in theory providing semi-rigid
>> macros would help force simple tests to conform to standard patterns, which should
>> reduce the cost of someone new understanding the test, and would likely let us do
>> more automagic things in the future.
>>
>> E.g. something like this in the test:
>>
>> 	KVM_RUN_TESTCASES(vcpu,
>> 		test_clear_kvm_dirty_regs_bits,
>> 		test_set_invalid,
>> 		test_req_and_verify_all_valid_regs,
>> 		test_set_and_verify_various_reg_values,
>> 		test_clear_kvm_dirty_regs_bits,
>> 	);
> 
> There is an existing framework in
> tools/testing/selftests/kselftest_harness.h that provides macros for
> setting up and running tests cases. I converted sync_regs_test to use it
> below as an example [1].
> 
> The harness runs each subtest in a child process, so sharing a VM/VCPU
> across test cases is not possible. This means setting up and tearing
> down a VM for every test case, but the harness makes this pretty easy
> with FIXTURE_{SETUP,TEARDOWN}(). With this harness, we can keep using
> TEST_ASSERT() as-is, and still run all test cases even if one fails.
> Plus no need for the hard-coded ksft_*() calls in main().

  Hi!

Sorry for not getting back to this earlier - I'm pretty much busy with other 
stuff right now. But your suggestion looks really cool, I like it - so if 
you've got some spare time to work on the conversion, please go ahead (I 
won't have much time to work on this in the next weeks, I think)!

  Thomas

