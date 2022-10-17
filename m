Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6571601C39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJQWTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJQWT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281816303
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666045163;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J22Buvx1QUdA1KfjsZHS/HHBKp3etxDqB4gvS2Hya9U=;
        b=O+me5aXZAUwfF0EBuoP0aDI6LZ287QvXv5Yb3Pxr909O9dY/wKXeDJO41G2X8PQQZ+eCoO
        lByTu8lxWrxBkj3f4nxTrlUxyeUWXdCUiQMG/RIhi1uI069UB2h9OIB2bHyAJL518i2oSe
        yJWRtrp8Nq+U4DaO1eBfPfRM8wl4LSs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-6odBANwtM_CYot3N0g1dxg-1; Mon, 17 Oct 2022 18:19:18 -0400
X-MC-Unique: 6odBANwtM_CYot3N0g1dxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11E3A1C1436E;
        Mon, 17 Oct 2022 22:19:02 +0000 (UTC)
Received: from [10.64.54.70] (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7C2640C206B;
        Mon, 17 Oct 2022 22:18:41 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 3/6] KVM: selftests: memslot_perf_test: Probe memory slots
 for once
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ajones@ventanamicro.com, pbonzini@redhat.com, maz@kernel.org,
        shuah@kernel.org, oliver.upton@linux.dev, seanjc@google.com,
        peterx@redhat.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
References: <20221014071914.227134-1-gshan@redhat.com>
 <20221014071914.227134-4-gshan@redhat.com>
 <fb3926da-a683-2811-71a4-31fe36a9cb50@maciej.szmigiero.name>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <b720dbad-4b8b-a617-f782-7f95bcdb3d54@redhat.com>
Date:   Tue, 18 Oct 2022 06:18:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fb3926da-a683-2811-71a4-31fe36a9cb50@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 1:34 AM, Maciej S. Szmigiero wrote:
> On 14.10.2022 09:19, Gavin Shan wrote:
>> prepare_vm() is called in every iteration and run. The allowed memory
>> slots (KVM_CAP_NR_MEMSLOTS) are probed for multiple times. It's not
>> free and unnecessary.
>>
>> Move the probing logic for the allowed memory slots to parse_args()
>> for once, which is upper layer of prepare_vm().
>>
>> No functional change intended.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   .../testing/selftests/kvm/memslot_perf_test.c | 29 ++++++++++---------
>>   1 file changed, 16 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
>> index dcb492b3f27b..d5aa9148f96f 100644
>> --- a/tools/testing/selftests/kvm/memslot_perf_test.c
>> +++ b/tools/testing/selftests/kvm/memslot_perf_test.c
>> @@ -245,27 +245,17 @@ static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
>>                  void *guest_code, uint64_t mempages,
>>                  struct timespec *slot_runtime)
>>   {
>> -    uint32_t max_mem_slots;
>>       uint64_t rempages;
>>       uint64_t guest_addr;
>>       uint32_t slot;
>>       struct timespec tstart;
>>       struct sync_area *sync;
>> -    max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
>> -    TEST_ASSERT(max_mem_slots > 1,
>> -            "KVM_CAP_NR_MEMSLOTS should be greater than 1");
>> -    TEST_ASSERT(nslots > 1 || nslots == -1,
>> -            "Slot count cap should be greater than 1");
>> -    if (nslots != -1)
>> -        max_mem_slots = min(max_mem_slots, (uint32_t)nslots);
>> -    pr_info_v("Allowed number of memory slots: %"PRIu32"\n", max_mem_slots);
>> -
>>       TEST_ASSERT(mempages > 1,
>>               "Can't test without any memory");
>>       data->npages = mempages;
>> -    data->nslots = max_mem_slots - 1;
>> +    data->nslots = nslots;
>>       data->pages_per_slot = mempages / data->nslots;
>>       if (!data->pages_per_slot) {
>>           *maxslots = mempages + 1;
>> @@ -885,8 +875,8 @@ static bool parse_args(int argc, char *argv[],
>>               break;
>>           case 's':
>>               targs->nslots = atoi(optarg);
>> -            if (targs->nslots <= 0 && targs->nslots != -1) {
>> -                pr_info("Slot count cap has to be positive or -1 for no cap\n");
>> +            if (targs->nslots <= 1 && targs->nslots != -1) {
>> +                pr_info("Slot count cap must be larger than 1 or -1 for no cap\n");
>>                   return false;
>>               }
>>               break;
>> @@ -932,6 +922,19 @@ static bool parse_args(int argc, char *argv[],
>>           return false;
>>       }
>> +    /* Memory slot 0 is reserved */
>> +    if (targs->nslots == -1) {
>> +        targs->nslots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS) - 1;
>> +        if (targs->nslots < 1) {
>> +            pr_info("KVM_CAP_NR_MEMSLOTS should be greater than 1\n");
>> +            return false;
>> +        }
>> +    } else {
>> +        targs->nslots--;
>> +    }
>> +
>> +    pr_info_v("Number of memory slots: %d\n", targs->nslots);
>> +
> 
> Can't see any capping of the command line provided slot count to
> KVM_CAP_NR_MEMSLOTS value, like the old code did.
> 

Indeed. I wanted to avoid extra variable @max_mem_slots and the
capping is missed. I will fix it up in next revision.

>>       return true;
>>   }

Thanks,
Gavin

