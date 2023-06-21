Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD3738635
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFUOHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFUOHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D01BD2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687356394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRSWaBirIMbqr4Co8ZfFUyVMNp/zcwwuITsVAzHUNt4=;
        b=QWbncE91uNqaW0KJVtHAWsY+AtWZofLaQ4TmeKBKF97H2jKJxvSqqzuu0I5moHGQsF5g0l
        fiuz4wLmuu1QpEepVpuXGHNWMAzYLyo0kcYXU1OzJniEEdhS3aP6Ly4yCjn+tPgUKSxCcC
        8uFjNILDCONFC09T3t6Y+r54hzJABvs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-ikba25pFPVynWnHAEkub2Q-1; Wed, 21 Jun 2023 10:06:00 -0400
X-MC-Unique: ikba25pFPVynWnHAEkub2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B7811C16D88;
        Wed, 21 Jun 2023 14:02:03 +0000 (UTC)
Received: from [10.22.17.140] (unknown [10.22.17.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3617F41CE;
        Wed, 21 Jun 2023 14:02:02 +0000 (UTC)
Message-ID: <2cdb371d-7435-ff4f-c9c0-991371833ad1@redhat.com>
Date:   Wed, 21 Jun 2023 10:02:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/5] x86/speculation: Provide a debugfs file to dump
 SPEC_CTRL MSRs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-2-longman@redhat.com>
 <20230621074105.GE2046280@hirez.programming.kicks-ass.net>
 <20230621082442.GCZJKzyjqRPMAnsWKZ@fat_crate.local>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230621082442.GCZJKzyjqRPMAnsWKZ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/23 04:24, Borislav Petkov wrote:
> On Wed, Jun 21, 2023 at 09:41:05AM +0200, Peter Zijlstra wrote:
>> On Tue, Jun 20, 2023 at 10:06:21AM -0400, Waiman Long wrote:
>>> Sometimes it is useful to know the states the SPEC_CTRL MSRs to see what
>>> mitigations are enabled at run time. Provide a new x86/spec_ctrl_msrs
>>> debugfs file to dump the cached versions of the current SPEC_CTRL MSRs.
>>>
>> Pff, clearly I can't even read email anymore..
>>
>> We don't do this for any of the other MSRs, so why start now?
> Hell no.
>
> There's /sys/devices/system/cpu/vulnerabilities/ for that.
>
> We are abstracting MSRs away from APIs - not do the backwards thing.
>
OK, as I have said. This is not central to the main purpose of this 
patch series. It is mostly there for verification purpose. I can 
certainly take this out.

Cheers,
Longman

