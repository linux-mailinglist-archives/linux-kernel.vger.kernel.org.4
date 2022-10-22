Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75F608D07
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJVLx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJVLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B846171D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666439632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPmvOeY7znrhinzMDTYzlhkvZyG6kRL1anJ+HPXl5ug=;
        b=c6Q0QRQH9Gbgpy1FBP2YThMxMevi7cDePYsL8rTpNaoejVbhhs+vv87JE5Gl+p6r1Qlmlw
        DUBcqrpCh47yxGE1xDg/8nnEoHznH6iq1ie4j4b095bPJZxCxy5+RegyCHdBK3mvGH0h4o
        fupYSZFuH3z0o9ZQaHCXq0smqHbP2Pg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-82cbFq9aNyuRfMGWbrTXMw-1; Sat, 22 Oct 2022 07:53:47 -0400
X-MC-Unique: 82cbFq9aNyuRfMGWbrTXMw-1
Received: by mail-ed1-f70.google.com with SMTP id h13-20020a056402280d00b0045cb282161cso5156734ede.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPmvOeY7znrhinzMDTYzlhkvZyG6kRL1anJ+HPXl5ug=;
        b=x7jr4lHqxGFhDnaV6JOfmtZhgHhllkYn9EbrtnADYlnrK++7UzzDbQ+rdxVg7NutM/
         QrHKwDNaBx+dpFYBL4UsphUYguy6OiskQAtuXC3UeTzRQ1ilusj5INt9jXk3AT/+l9Q+
         rhIaEarZAfmg5jsnXGREHmf3dSia8aupDr1jIhnM5x3bTE5hd01w39w7Appf2Jr64QyV
         xvntPZoEbZv3WtyNx86DuY2a4PVIkPbeYAkg1eVIhJt4LeGSbqh0YFGeEWOayLvWdJsu
         9tnBsktWRjffJKJ4SZMaS+CxGUZVVKd67TnGFn0GcZuZ0vIi8ra5aOLvcWTgMMVa0t/4
         vwaA==
X-Gm-Message-State: ACrzQf2Xz+MqBcFfA258YkX05YHwGhawg5JWrDDp2mj/yzlJJPnl9D0R
        XN43DwAjHUPCpPvbmPoEwyQ1pB4QUYDNV9NzuO9iuJB+gvT9Fhpkb9msxZbHNjqjdNyfnIB9Z/6
        3Gmtr2Ik7a2/z3b3RTFW2MSJk
X-Received: by 2002:a17:907:16a7:b0:79e:9eed:8f6 with SMTP id hc39-20020a17090716a700b0079e9eed08f6mr4603474ejc.731.1666439626787;
        Sat, 22 Oct 2022 04:53:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7L4myOJ/0NIdAr5ZVQ+QtDR8RDZxDn9M+eafRx+6P9t9XZmCfx8weClDwmUUZOtYPytHfyTw==
X-Received: by 2002:a17:907:16a7:b0:79e:9eed:8f6 with SMTP id hc39-20020a17090716a700b0079e9eed08f6mr4603462ejc.731.1666439626502;
        Sat, 22 Oct 2022 04:53:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056402171000b0044e937ddcabsm18323edu.77.2022.10.22.04.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 04:53:46 -0700 (PDT)
Message-ID: <e436fc94-6bd7-989d-a1bb-5cd08a7d10c3@redhat.com>
Date:   Sat, 22 Oct 2022 13:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] tools: include: sync include/api/linux/kvm.h
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20221022114423.1741799-1-pbonzini@redhat.com>
 <87bkq4gjwc.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87bkq4gjwc.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/22 13:47, Marc Zyngier wrote:
>> Provide a definition of KVM_CAP_DIRTY_LOG_RING_ACQ_REL.
>>
>> Fixes: 4b3402f1f4d9 ("KVM: selftests: dirty-log: Use KVM_CAP_DIRTY_LOG_RING_ACQ_REL if available")
>> Cc: Marc Zyngier<maz@kernel.org>
>> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
>> ---
>>   tools/include/uapi/linux/kvm.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
>> index eed0315a77a6..0d5d4419139a 100644
>> --- a/tools/include/uapi/linux/kvm.h
>> +++ b/tools/include/uapi/linux/kvm.h
>> @@ -1177,6 +1177,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_VM_DISABLE_NX_HUGE_PAGES 220
>>   #define KVM_CAP_S390_ZPCI_OP 221
>>   #define KVM_CAP_S390_CPU_TOPOLOGY 222
>> +#define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>   
> Huh, I wonder how I missed that one, as the test were compiling here.
> 
> Acked-by: Marc Zyngier<maz@kernel.org>

5 minutes later -- The tests do not use that file, they use usr/include/ 
in the build tree.  So the right Fixes tag is 17601bfed909 ("KVM: Add 
KVM_CAP_DIRTY_LOG_RING_ACQ_REL capability and config option").

Paolo

