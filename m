Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93EF62A081
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiKORjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKORiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9442F3B1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668533882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCQ4pMfZCOZ5jMpOJsoLzuHaICjEUdTEXR6Q3zx1EEY=;
        b=cado30NiPXa/d8wk7TPzWwXc5fT542fcUJePUbzViiBVeOW6L63Zi+3tgut2l80C6kklTN
        uNRDMCP40QyNFZPH6L7xJIblsgJBY3Czt/zBUdZDvmWEQSoirbVCudmj2NUb4O/MTjGN0+
        SGwwxILjPjTIRN4zauNyqCSewPLhPZs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-ZlKCM5FOOMmzn-gkzU_tgg-1; Tue, 15 Nov 2022 12:38:00 -0500
X-MC-Unique: ZlKCM5FOOMmzn-gkzU_tgg-1
Received: by mail-ej1-f71.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso7686009ejb.14
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCQ4pMfZCOZ5jMpOJsoLzuHaICjEUdTEXR6Q3zx1EEY=;
        b=3AQpWt2U8vVRYyzLDlUNyuN3M4uvSlxI2VktgBUyGt+491Ow3ioarlRhQoaAUzNQ7k
         1ISyO6ECpr46fcIVy1X/C+895Aq3PwhULF2NYyC25UY75rMFiTesrVhDPHZ74QvyB3Yq
         xU+vwfMk54I+Jxg9LKdhrecmOstbjvLkTc/b7nzz5dEKAHjWe8xdaEafHrAfDbR4wLVw
         yRrjUF1z0xqAfeO6jq3NMrcC4vbfIQtaFFWc4jDNr6VE1MR4bA5NjxIDZfZgbw8ULYTz
         aIlxGT/9j1CTED3iPOxJwtZ/x8y0FPCQRA+gTUGq19rm5xFJoz0mzUbR650qB8onDiXr
         C08w==
X-Gm-Message-State: ANoB5pllSlurosW2GqlpV8T29j8ubx2KahzfiCz5qjbAdAw7/Q1dCXAC
        7+Lh5yznp/tZt6456BHmNhS0lcbTzQvJ77TY6wByc/BFt5NK8DHkvooN7iQX6/Ye/eY01oS4WVU
        /i/C4JL5m+cgTSSwo7BItRdC5
X-Received: by 2002:a17:906:6b02:b0:7a5:f8a5:6f80 with SMTP id q2-20020a1709066b0200b007a5f8a56f80mr15729537ejr.202.1668533879754;
        Tue, 15 Nov 2022 09:37:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5IwpWZHIj8mnq8C9lxBnDSKXKaXz3PjdyKm7Lb9V1W5H/CrRTh9RaKvgSuEpkkt16OYKskmQ==
X-Received: by 2002:a17:906:6b02:b0:7a5:f8a5:6f80 with SMTP id q2-20020a1709066b0200b007a5f8a56f80mr15729523ejr.202.1668533879544;
        Tue, 15 Nov 2022 09:37:59 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id f10-20020a170906c08a00b0078c47463277sm5819739ejz.96.2022.11.15.09.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:37:58 -0800 (PST)
Message-ID: <b81f9af0-28a0-fe23-37df-64a785bfe52a@redhat.com>
Date:   Tue, 15 Nov 2022 18:37:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH linux-next] KVM: replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>, guo.ziliang@zte.com.cn
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202211150858513761518@zte.com.cn> <Y3PM4euxrCFhZnCc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y3PM4euxrCFhZnCc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 18:31, Sean Christopherson wrote:
> On Tue, Nov 15, 2022, guo.ziliang@zte.com.cn wrote:
>> From: guo ziliang <guo.ziliang@zte.com.cn>
>> Fix the following coccicheck warning:
>> /virt/kvm/kvm_main.c: 3849: 0-23: WARNING: vcpu_get_pid_fops
>> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>
>> Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
>> ---
>> virt/kvm/kvm_main.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 2719e10..6e58aec 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -3846,7 +3846,7 @@ static int vcpu_get_pid(void *data, u64 *val)
>> return 0;
>> }
>>
>> -DEFINE_SIMPLE_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
>> ++DEFINE_DEBUGFS_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
> 
> NAK, third time is not a charm.
> 
> https://lore.kernel.org/all/20221101072506.7307-1-liubo03@inspur.com
> https://lore.kernel.org/all/20220815031228.64126-1-ye.xingchen@zte.com.cn

Screw it, I'm going to send a pull request just to delete that file.

Paolo

