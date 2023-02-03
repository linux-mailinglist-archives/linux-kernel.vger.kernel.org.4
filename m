Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D19689756
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBCKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBCKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:55:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B355721C3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675421699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RP8qXabbbkVFHjkXGB3iPT4qiggJHLCmrxY/0vUZBsk=;
        b=fIAtTLXkMvSZgrgJlnZO2xWmcxGbTRgSmDTDXSGjjEeGuogbIV2CiKulhV1mpRQ1aYBe/R
        cwDgfRPT5+06L2PwRWlqxIJBknrFIepCO3vTzzjatb+bZ2BJ4+ZZ97Eyohj++VscTQtD4T
        S6D/b20+1Nm/eOtQq604yfMPzID00bE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-eRpUt_OyOASrlC0Z6263DQ-1; Fri, 03 Feb 2023 05:54:58 -0500
X-MC-Unique: eRpUt_OyOASrlC0Z6263DQ-1
Received: by mail-qv1-f72.google.com with SMTP id ib5-20020a0562141c8500b0053c23b938a0so2528731qvb.17
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RP8qXabbbkVFHjkXGB3iPT4qiggJHLCmrxY/0vUZBsk=;
        b=AygxlpbcGnFok78j0J6bez9aIC4zFTEm2zUMEGqCNWDZCuu711pMYZgShbq+M8PcVI
         QB6thpkeG8IWxCnoKpp3UbD+XF0N70wv/a/YyWCzaeOCH3QUvoDU+3JgkQIJJ/lFbrGw
         An2ODlZvHfDIxepjTb7yqJ7f7jvprYhF8Q2x89Zp7hwvXeRay49FVQn4FstKsHyfQzP3
         ZRlbFKgta9l7UVvv39kmHzjN7QJkDbOn/3lzvRusCkuvkUQQbB2Y0GE/Mq5KoCCDXBN9
         ZIkLdgioyZ0GQ6Bq+WRlnBtGeO41vQmX0DF0+swgvc6vVRa8BJAXyv1tWN7N2x5z2LY1
         wo/Q==
X-Gm-Message-State: AO0yUKVO0kyGAr7OBCMm9Bpd/0SmCZWd4t+Wk4OCTr/db5689T+A0FGp
        uUlWfEP9Qo6/xRLv5fmTHNEn3fOKqKOjC10TUnpQT7mklnyyywcCDRYEkR5v+MdVhRF9AbwAD8Z
        BlMOH/GsxuQebKZzkfte/trCF
X-Received: by 2002:ac8:7d04:0:b0:3b6:3787:679d with SMTP id g4-20020ac87d04000000b003b63787679dmr18376057qtb.8.1675421697840;
        Fri, 03 Feb 2023 02:54:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8N+04AaVpEWJqlRLC4f+pcB8NjgkYdMQcrG47rLW4TpdktzPu1UTGGOpRxuhVJPJmt51StNw==
X-Received: by 2002:ac8:7d04:0:b0:3b6:3787:679d with SMTP id g4-20020ac87d04000000b003b63787679dmr18376027qtb.8.1675421697468;
        Fri, 03 Feb 2023 02:54:57 -0800 (PST)
Received: from [192.168.0.2] (ip-109-43-179-40.web.vodafone.de. [109.43.179.40])
        by smtp.gmail.com with ESMTPSA id o11-20020ac87c4b000000b003b9a426d626sm1405276qtv.22.2023.02.03.02.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 02:54:56 -0800 (PST)
Message-ID: <2c37f524-593f-a155-a01f-57a68b2e362c@redhat.com>
Date:   Fri, 3 Feb 2023 11:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/7] KVM: Move KVM_GET_NR_MMU_PAGES into the deprecation
 section
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        James Morse <james.morse@arm.com>,
        kvm-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20230203094230.266952-1-thuth@redhat.com>
 <20230203094230.266952-4-thuth@redhat.com> <CQ8UM1FTPEUZ.3F2RONR3AJ5YP@bobo>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <CQ8UM1FTPEUZ.3F2RONR3AJ5YP@bobo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 11.16, Nicholas Piggin wrote:
> On Fri Feb 3, 2023 at 7:42 PM AEST, Thomas Huth wrote:
>> The KVM_GET_NR_MMU_PAGES ioctl is quite questionable on 64-bit hosts
>> since it fails to return the full 64 bits of the value that can be
>> set with the corresponding KVM_SET_NR_MMU_PAGES call. This ioctl
>> likely has also never really been used by userspace applications
>> (at least not by QEMU and kvmtool which I checked), so it's better
>> to move it to the deprecation section in kvm.h to make it clear for
>> developers that this also should not be used in new code in the
>> future anymore.
> 
> Did this get included in the series inadvertently?

No, it's here on purpose, as a second step to patch 2/7 (and a follow up 
from the discussion last year, see 
https://lore.kernel.org/kvm/YpZu6%2Fk+8EydfBKf@google.com/ ) ... sorry, I 
should have elaborated on this in the cover letter, too.

  Thomas

