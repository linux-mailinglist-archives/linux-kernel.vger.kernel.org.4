Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE865521B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiLWPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiLWPdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2214016
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671809578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAWf/uAUkuR8KOA6MkRsDGb5B+jlGcp93Bu+BwII344=;
        b=Ez0NBP6RnvoxcZGMm4EFSVccOfaZbbqiH11yv9+d1BhtTJ/BPTEEtEOFpVxIDBYuREKSwu
        5TuLK27gh7vc2dm5+GeXrW3Vjn+4qLuQMRPhuVulfCp3kJBzpf998wFj/30SNL6eKMr+vP
        k1tLj0AvZi5qJvU7c9s0LcRKx7Qp1Lw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-jihGGe6MPTSoLOH33Obs-w-1; Fri, 23 Dec 2022 10:32:56 -0500
X-MC-Unique: jihGGe6MPTSoLOH33Obs-w-1
Received: by mail-ej1-f72.google.com with SMTP id oz11-20020a1709077d8b00b007c0dd8018b6so3633007ejc.17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAWf/uAUkuR8KOA6MkRsDGb5B+jlGcp93Bu+BwII344=;
        b=uxxdOhdmokgnNEQkHdjq8hW5G7pWCwSYkGxCjop04IoxVhKcLWuI5l0z3CljzJeUzf
         fWFV+GIp81mLvEC1Kzb0cp2eLEx2BtToFOXgH5FEeIWn2lvDRyPMbTfhzb96vyV1esqW
         yY4S4UzSde4/s4aFNHhPkk0J9edRtzgjTZQZFkyXW+zNMbysQz151qkNIZxLLo64M20K
         PjJyJr/d8QYNBF//0uSUnB7yGcBhlIFb6Hv8HCQz8TROKAmLPsUpPH+5MuTv1nVqR6L6
         +HWJ0ghD93QvKk8k5pY4bB+MdgyZlzQvFA0+bmH3y130MaCxyUKgRPHI67mbyvvEo0hv
         xprw==
X-Gm-Message-State: AFqh2krywQd0gW3v5SrmkZabCrA9xpfmsC6wMiWLMtZ+ZTgfKaCPwSmZ
        +SrhqaoDOOJkUQcQc5F4VrEaNgXYaWnSVv+DzVR90CHQP+Juiys5ZeTV2Sz0V8lrKAyxWq6nThh
        WmV3hr+Ogdzo8UZksCZSd6aio
X-Received: by 2002:a17:906:7747:b0:840:604:1da1 with SMTP id o7-20020a170906774700b0084006041da1mr7526698ejn.61.1671809575546;
        Fri, 23 Dec 2022 07:32:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt/bOjpsLGhaCMrfWpYO8ZpKea4TRbng87rTSh1nXe7d6x/Rt5Pkn/M/TVOA9/HSqRBQXsZMw==
X-Received: by 2002:a17:906:7747:b0:840:604:1da1 with SMTP id o7-20020a170906774700b0084006041da1mr7526688ejn.61.1671809575352;
        Fri, 23 Dec 2022 07:32:55 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id s18-20020a170906bc5200b007c0b4387d2asm1508950ejv.8.2022.12.23.07.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 07:32:54 -0800 (PST)
Message-ID: <365fe273-ba11-eb12-4d80-a2e6a17bf0fa@redhat.com>
Date:   Fri, 23 Dec 2022 16:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] KVM: use unified srcu interface function
Content-Language: en-US
To:     Hao Peng <flyingpenghao@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAPm50aJTh7optC=gBXfj+1HKVu+9U0165mYH0sjj3Jqgf8Aivg@mail.gmail.com>
 <Y5KNvgzakT1Vvxy4@google.com>
 <CAPm50aJv2_6321BgLXB6SWH1CcoYM4733fsovtB_5zhoP_7x+Q@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAPm50aJv2_6321BgLXB6SWH1CcoYM4733fsovtB_5zhoP_7x+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/22 08:47, Hao Peng wrote:
>>> +       old = srcu_dereference_check(kvm->irq_routing, &kvm->irq_srcu,
>>> +                                       lockdep_is_held(&kvm->irq_lock));
>> Readers of irq_routing are protected via kvm->irq_srcu, but this writer is never
>> called with kvm->irq_srcu held.  I do like the of replacing '1' with
>> lockdep_is_held(&kvm->irq_lock) to document the protection, so what about just
>> doing that?  I.e.
>>
> Sorry for the long delay in replying. Although kvm->irq_srcu is not required
> to protect irq_routing here, this interface function srcu_dereference_check
> indicates that irq_routing is protected by kvm->irq_srcu in the kvm subsystem.
> Thanks.
> 

I agree, the last two arguments basically are alternative conditions to 
satisfy the check:

#define srcu_dereference_check(p, ssp, c) \
         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
                                 (c) || srcu_read_lock_held(ssp), __rcu)

The idea is to share the code between readers and writers, so what do 
you think of adding a

#define kvm_get_irq_routing(kvm) srcu_dereference_check(...)

macro at the top of virt/kvm/irqchip.c?

Thanks,

Paolo

