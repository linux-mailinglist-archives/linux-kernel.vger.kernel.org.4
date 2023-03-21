Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA36C2CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCUIm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCUImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62F924C80
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679388066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrZUszRAkIR7jRT9XRyW8BoS4vhzOXVnojjI03jNGwI=;
        b=b2J5ex95cgn+0C+Ie/uFX3sQyhEEtVGvMWwVFyR8wUpSd2JdyrTMCOu72kXrE/AgXGPOUv
        3hRDjfYXl/iCNc6hOcvhoTgFiSO9v+FuOPJcsd0kGD2zCXp6hs8JXKHeu6KoXLOHJ9Fbpa
        Ukn/R+YVw4hPkJoBeVdI2i7bcolI3MM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-cYjQ0kRcNJmsu1dteiO-RQ-1; Tue, 21 Mar 2023 04:41:05 -0400
X-MC-Unique: cYjQ0kRcNJmsu1dteiO-RQ-1
Received: by mail-qv1-f71.google.com with SMTP id px9-20020a056214050900b005d510cdfc41so20377qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679388065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrZUszRAkIR7jRT9XRyW8BoS4vhzOXVnojjI03jNGwI=;
        b=3xZ1W6ih7x8vL2CVXoLwkcv77ZQhe/8xNkhoex8lpiI7qV3/U3OiWDWswgLjGImYEC
         9UZ0MwFpnB3YBdm6lO0bLbv1G6PTFxZ0RSfn8iOxxpZLzV0lH8i0rGyzWck71PQ6nnrL
         o/IXmBm8ObPfAxKsWZ+620my5zTGUnNBCoSJI0MkS0/mnMbPkAUIKax2O18CQBDuXM0C
         Xese9BmhtfM5ihPnUU2sUNu/sznNhLcR0NqbqkHB4jm3iQqeSXfnnkrM1fvu6m0XV/S/
         SKvtMb/UlL+QKFBa+52D2RDSPqM0oqDr1HXHn+iSSYkpB6Hg4H34IaEF98Kke0oea2Xl
         wpWg==
X-Gm-Message-State: AO0yUKV+1Brc98AMNS960NunRnglagZmBytbNCoQhs4HySgzk1tjBUpj
        ZWiS57RbMwzTdJpZpzD4EaqIDl8FSnevHYDXjk3eVAAlg/oN+moY1j56ott+fjopnI0gDe0o0lF
        14J4/1gzw7xYLz3tjw4wDB7FY
X-Received: by 2002:a05:6214:1c0d:b0:56e:bff1:83a7 with SMTP id u13-20020a0562141c0d00b0056ebff183a7mr2493953qvc.18.1679388065172;
        Tue, 21 Mar 2023 01:41:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set80Mc4WMUXVAditkQkfF49VzFGUh1Am+pL4ZneetO0OMWrGtOq6LmDAM3/EBamu/DO49jCZvw==
X-Received: by 2002:a05:6214:1c0d:b0:56e:bff1:83a7 with SMTP id u13-20020a0562141c0d00b0056ebff183a7mr2493941qvc.18.1679388064895;
        Tue, 21 Mar 2023 01:41:04 -0700 (PDT)
Received: from [192.168.149.90] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b00746476405bbsm8881825qkp.122.2023.03.21.01.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:41:04 -0700 (PDT)
Message-ID: <03df0429-9fb2-5326-9bf8-47367818fd49@redhat.com>
Date:   Tue, 21 Mar 2023 09:40:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] KVM: support the cpu feature FLUSH_L1D
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, Ben Serebrin <serebrin@google.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20230201132905.549148-1-eesposit@redhat.com>
 <CALMp9eTt3xzAEoQ038bJQ9LN0ZOXrSWsN7xnNUD+0SS=WwF7Pg@mail.gmail.com>
Content-Language: de-CH
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <CALMp9eTt3xzAEoQ038bJQ9LN0ZOXrSWsN7xnNUD+0SS=WwF7Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20/03/2023 um 17:52 schrieb Jim Mattson:
> On Wed, Feb 1, 2023 at 5:29 AM Emanuele Giuseppe Esposito
> <eesposit@redhat.com> wrote:
>>
>> As the title suggest, if the host cpu supports flush_l1d flag and
>> QEMU/userspace wants to boot a VM with the same flag (or emulate same
>> host features), KVM should be able to do so.
>>
>> Patch 3 is the main fix, because if flush_l1d is not advertised by
>> KVM, a linux VM will erroneously mark
>> /sys/devices/system/cpu/vulnerabilities/mmio_stale_data
>> as vulnerable, even though it isn't since the host has the feature
>> and takes care of this. Not sure what would happen in the nested case though.
>>
>> Patch 1 and 2 are just taken and refactored from Jim Mattison's serie that it
>> seems was lost a while ago:
>> https://patchwork.kernel.org/project/kvm/patch/20180814173049.21756-1-jmattson@google.com/
>>
>> I thought it was worth re-posting them.
> 
> What has changed since the patches were originally posted, and Konrad
> dissed them?
> 

From the upstream conversation, I honestly didn't really catch that
Konrad dissed them. Or at least, I didn't read a valid reason for doing
so, contrary to what Sean instead provided. I thought it was just forgotten.

My bad, next time I will be more careful when trying to resume old
patches :)

Thank you,
Emanuele

