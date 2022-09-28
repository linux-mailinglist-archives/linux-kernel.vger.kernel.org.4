Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7745ED998
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiI1J5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiI1J4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41C1EEEB1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664358927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gb2cJ+qaMdaxmKIGMGEE3usUOdY7PjedRhOx/d0j24w=;
        b=Wjx652WRlQHb/sHed7F6GFWgB/pVqXenjbotKSahsRMMSocjPiwsl+Q3CCnKCslCL0GEZV
        maNCRZlEAT/saDP1Cg2fJU/kB4bPUNwSGYyPvQLvAB28kgNobyDURKGLDLUm/vYMNdUdKH
        kPGVVDCUfDZZ+5/yjGqN4mi9TNhiuBw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-194-1qBRVf_8NQy3hVMSf8SjzQ-1; Wed, 28 Sep 2022 05:55:26 -0400
X-MC-Unique: 1qBRVf_8NQy3hVMSf8SjzQ-1
Received: by mail-ej1-f69.google.com with SMTP id hq17-20020a1709073f1100b00782f9d252f4so4579682ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Gb2cJ+qaMdaxmKIGMGEE3usUOdY7PjedRhOx/d0j24w=;
        b=Om5JCIOJSkdhY9/lnoauPfwSspJXni7fjFM7jai4mcFEwkMTAJtyy/jvuvReAE19xb
         swguHyr7WtnSOZAFiJOO8voyp6aJ8vi+rVR7FZGaNBkbcjPrgXI/wAfwFvl/6DEBwrN0
         JyOEUSroV0LXglE5CFHCIL2tkDYN+SeOPI0osgMEEXoGXQ0HFoX7/26pJXrhc4Rbt0F9
         u3v4Ej6fa/JVs/lxsEi1t8G2uvKKp8v5IPf/+mI10xSB3nf/xCwtSSj8ekMzGfBZNl8U
         hRWzysZPKr9xbrFhF4/p5Bo1Pf8SlZRblM1nluwwM/8gccceXvfz+lh8yTHr/xwTKMYQ
         Kucg==
X-Gm-Message-State: ACrzQf12zGPmVmAm9fahSgo1xCiNzaKFliFzjg7k+uAzaoFEDRiAftxv
        Kisovq3SxDs9FG8jo2/KW32v14CQkJ/MFfZk8JXkYDfbaAN1RXRfuXas1OErLQaLFnJu6Nw9jC/
        U5vTDxFclr7MtezrkcaEr161E
X-Received: by 2002:a05:6402:5489:b0:43b:b935:db37 with SMTP id fg9-20020a056402548900b0043bb935db37mr33111978edb.347.1664358925448;
        Wed, 28 Sep 2022 02:55:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5aoT98C15jrHtWaJSl4x7zl5R0lQTFlQ8XfjPs33lQ63BHlo5MahvDX4rUtn3EeusKpVq9kQ==
X-Received: by 2002:a05:6402:5489:b0:43b:b935:db37 with SMTP id fg9-20020a056402548900b0043bb935db37mr33111963edb.347.1664358925220;
        Wed, 28 Sep 2022 02:55:25 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id j2-20020a17090623e200b0078015cebd8csm2140882ejg.117.2022.09.28.02.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 02:55:24 -0700 (PDT)
Message-ID: <15291c3f-d55c-a206-9261-253a1a33dce1@redhat.com>
Date:   Wed, 28 Sep 2022 11:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] KVM: x86: disable on 32-bit unless CONFIG_BROKEN
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220926165112.603078-1-pbonzini@redhat.com>
 <YzMt24/14n1BVdnI@google.com>
 <ed74c9a9d6a0d2fd2ad8bd98214ad36e97c243a0.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ed74c9a9d6a0d2fd2ad8bd98214ad36e97c243a0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 09:10, Maxim Levitsky wrote:
> I also think that outside KVM developers nobody should be using KVM on 32 bit host.
> 
> However for_developement_  I think that 32 bit KVM support is very useful, as it
> allows to smoke test the support for 32 bit nested hypervisors, which I do once in a while,
> and can even probably be useful to some users (e.g running some legacy stuff in a VM,
> which includes a hypervisor, especially to run really legacy OSes / custom bare metal software,
> using an old hypervisor) - or in other words, 32 bit nested KVM is mostly useless, but
> other 32 bit nested hypervisors can be useful.
> 
> Yes, I can always use an older 32 bit kernel in a guest with KVM support, but as long
> as current kernel works, it is useful to use the same kernel on host and guest.

Yeah, I would use older 32 bit kernels just like I use RHEL4 to test PIT 
reinjection. :)  But really the ultimate solution to this would be to 
improve kvm-unit-tests so that we can compile vmx.c and svm.c for 32-bit.

Paolo

