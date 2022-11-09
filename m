Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F145622895
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKIKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKIKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3029D1A202
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667990146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXh9xRxeOqiCgGAyIslxozC+WKA3WlHvk2TQ5NzdIts=;
        b=b8b6TfX/Esa8rV7V2Ibv4YktQ4h2/YPI2Pw6nNNXFj/Rhq1Lxvzhu/k+1DH8qASF0G3a1O
        BpmBr8ZEn4ELypRD2PJApMpPQKxBBFEFj8zhdbKCqG24vgaXjp4/3JPE9iVsHVaQMvGHRr
        k1Lm5mTSYWra7EQwKBwCPXOt7qjIGU0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-62-tBj-lUyxPya-UsHYmMy0ww-1; Wed, 09 Nov 2022 05:35:45 -0500
X-MC-Unique: tBj-lUyxPya-UsHYmMy0ww-1
Received: by mail-wm1-f72.google.com with SMTP id ay19-20020a05600c1e1300b003cf758f1617so823480wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXh9xRxeOqiCgGAyIslxozC+WKA3WlHvk2TQ5NzdIts=;
        b=BMr3JqV5fUWRU+hzQWPBRx5mEX2USkUUu9jp/a1X/D+zTCAUfHAqTDkeIP9Xr84Tj0
         cgcMXSH2q0QU3AjOOrGl40w9oOqV0YRgyJpJSwxC4VtvB3UfHUsvK0NNxgjYMoaGoRTu
         nAsGnsoL7ZhKHGjndnwQmXIjm0Hi48rTTaWkRxNh3DZ73KH3J9fP909qHuke/Y/Tu6PS
         oBl/Ikb899mnMJIMf/K7zWaTKde9EmTKR0QFuMscoZQfMbZg2Ly289NpTBVqBZRB+iyp
         XzZd1XPK6IW5Tzp7mGYEtJ4bzj4nUchsMkSPjhWyoX5ChWUZGrJ/1FEK7a0N9Pg5bz4S
         unAw==
X-Gm-Message-State: ACrzQf0sNYDphIK6eKs8X6njdSvcj4GtxIXVJIDCwao1QpDkhdEiFxND
        LiUYlkqIaNcSN7PDs/6PXx0zOLzw7pa196qJSv3NkPqyK8cUA2BBHQ7FmVECCtvoreZrLAFsn3u
        7JKEeqbq9OT/RJ7zHRavBP8Gb
X-Received: by 2002:a05:600c:54d1:b0:3cf:a39f:eafe with SMTP id iw17-20020a05600c54d100b003cfa39feafemr14003396wmb.159.1667990143966;
        Wed, 09 Nov 2022 02:35:43 -0800 (PST)
X-Google-Smtp-Source: AMsMyM67vMbZOxyO9HdRP++/quRqreMLNQgI0Z3kPqtanXbNCYKYQhOFA99t07LzkKg+TdBKcSIorg==
X-Received: by 2002:a05:600c:54d1:b0:3cf:a39f:eafe with SMTP id iw17-20020a05600c54d100b003cfa39feafemr14003389wmb.159.1667990143748;
        Wed, 09 Nov 2022 02:35:43 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id x15-20020adfdd8f000000b002365921c9aesm13026740wrl.77.2022.11.09.02.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 02:35:43 -0800 (PST)
Message-ID: <1fc523b0-da9c-64a0-7459-e8cf9fe3b819@redhat.com>
Date:   Wed, 9 Nov 2022 11:35:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/8] KVM: SVM: replace regs argument of __svm_vcpu_run
 with vcpu_svm
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        nathan@kernel.org, thomas.lendacky@amd.com,
        andrew.cooper3@citrix.com, peterz@infradead.org,
        jmattson@google.com, stable@vger.kernel.org
References: <20221108151532.1377783-1-pbonzini@redhat.com>
 <20221108151532.1377783-3-pbonzini@redhat.com> <Y2rCIWtAsmEF1UuM@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y2rCIWtAsmEF1UuM@google.com>
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

On 11/8/22 21:54, Sean Christopherson wrote:
> On Tue, Nov 08, 2022, Paolo Bonzini wrote:
>> Since registers are reachable through vcpu_svm, and we will
>> need to access more fields of that struct, pass it instead
>> of the regs[] array.
>>
>> No functional change intended.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: f14eec0a3203 ("KVM: SVM: move more vmentry code to assembly")
> 
> I don't think a Fixes: tag for a pure nop patch is fair to the original commit.

That's for the sake of correct tracking in stable@, still it's not the 
right commit to point at:

- f14eec0a3203 did not move the RSB stuffing before the GSBASE restore, 
the code before was:

	vmexit_fill_RSB();
  #ifdef CONFIG_X86_64
  	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
  #else

- anyway it wasn't really buggy at the time: it's only in -next that 
FILL_RETURN_BUFFER uses percpu data, because alternatives take care of 
the X86_FEATURE_* checks

The real reason to do all this is to access the percpu host spec_ctrl, 
which in turn is needed for retbleed.  I'll point the Fixes tag to 
a149180fbcf3 ("x86: Add magic AMD return-thunk") instead, again just for 
the sake of tracking releases that need the change to full fix retbleed.

Paolo

