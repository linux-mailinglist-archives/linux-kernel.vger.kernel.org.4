Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C595B6B35
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiIMJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiIMJxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C7558534
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663062782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+b3p8jJeOUzB9Y7KKCEYhhWbXEO9sDNunqO8TSV3bM=;
        b=Kq0H5eCQPbIcpbdpdrvGqffzOJZ3ZH+DwUPGKDg4U6ZQ0pZQ+aUioJsOk+Cl90Ksoj+SUV
        cnBu+S8Bb5SqSxxnxMoc2Y2BZXfj1RkYbLUzPONxANnkQRFK4WCmj3CD3JTCZ5JbJDukFt
        MOjijPd5vQuc3ljCCCoVcJOTMnEdh6w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-577-aSoRrUuYM_-Olc-HCYNghw-1; Tue, 13 Sep 2022 05:52:57 -0400
X-MC-Unique: aSoRrUuYM_-Olc-HCYNghw-1
Received: by mail-wr1-f70.google.com with SMTP id i29-20020adfa51d000000b00228fa8325c0so2986771wrb.15
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=H+b3p8jJeOUzB9Y7KKCEYhhWbXEO9sDNunqO8TSV3bM=;
        b=TF1A9n8mmM0V0px7pNeQ0O/tAT/6lGwIp2RI4ucyt1zwKf4EaMcPet8vaKep4EReXU
         Y9lud4s+gUOSNsAXlGqwWDqFhdb6EC4tABIN6h/nwjJjZJxKZPkQA0qz7v8/UJqUe5Rl
         JbF75AJVPNSOhJJXEfq/K0VWi/Fzo9D7t4dPv0ISWLr/to/lrH9g3UTemFfAlxg5bMjj
         uYIiCy3rctXoaFQVNrPp+tG97CFNyntS9L71s1SLKaqOIAdn9K88+EEuNMyPDYUl1ymy
         YW+Ypp0dyBFaZTofB8qZiZIqHA6bLzBeF7mTEZxbDCD8+iuuR5o4gMyHRia8xZad1V3V
         xXnw==
X-Gm-Message-State: ACgBeo2qeDO3sF+RZyrZOT2kab3y19bACVWQ36XeZvjgyfNlgpCvdE6J
        Y5VzTgZAVyJJ/Z0fkCZydVgz3s3OyC9oT2K+QOnavtZ4PSmeNFKlp/KosRFhwuZkCg6W/DxABTM
        8pJf6W4I+qaAetuTUNu/9nUmDA0d7wFePiHBvcpJilkmz9+cXBE0GLGBANT8yoysCZb0rffYIKd
        53
X-Received: by 2002:a7b:cbd2:0:b0:3b4:33d1:d938 with SMTP id n18-20020a7bcbd2000000b003b433d1d938mr1688006wmi.123.1663062776016;
        Tue, 13 Sep 2022 02:52:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zvkBVGOCRYEBRc8uffdd7P4Et7K4jKKL5qQNyq1mHNhsM3qay0zjBhaFU0U/N0i61OSqVEA==
X-Received: by 2002:a7b:cbd2:0:b0:3b4:33d1:d938 with SMTP id n18-20020a7bcbd2000000b003b433d1d938mr1687990wmi.123.1663062775806;
        Tue, 13 Sep 2022 02:52:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b002285f73f11dsm12303111wrq.81.2022.09.13.02.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 02:52:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: selftests: Rename 'msr->availble' to
 'msr->should_not_gp' in hyperv_features test
In-Reply-To: <Yx87WXMXGzLxrT0f@google.com>
References: <20220831085009.1627523-1-vkuznets@redhat.com>
 <20220831085009.1627523-3-vkuznets@redhat.com>
 <Yx87WXMXGzLxrT0f@google.com>
Date:   Tue, 13 Sep 2022 11:52:54 +0200
Message-ID: <874jxbr47d.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Aug 31, 2022, Vitaly Kuznetsov wrote:
>> It may not be clear what 'msr->availble' means. The test actually
>> checks that accessing the particular MSR doesn't cause #GP, rename
>> the varialble accordingly.
>> 
>> Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  .../selftests/kvm/x86_64/hyperv_features.c    | 92 +++++++++----------
>>  1 file changed, 46 insertions(+), 46 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> index 79ab0152d281..4ec4776662a4 100644
>> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> @@ -33,7 +33,7 @@ static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
>>  
>>  struct msr_data {
>>  	uint32_t idx;
>> -	bool available;
>> +	bool should_not_gp;
>
> I agree that "available" is a bit inscrutable, but "should_not_gp" is also odd.
>

I think Max suggested it to reduce the code churn and I silently agreed.

> What about inverting it to?
>
> 	bool gp_expected;
>
> or maybe even just
>
> 	bool fault_expected;
>
> and letting the assert define which vector is expected.
>

This also works, will change.

-- 
Vitaly

