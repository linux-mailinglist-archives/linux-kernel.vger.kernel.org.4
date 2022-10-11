Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFED55FB2D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJKNCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJKNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0677C74D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665493361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+RSYC+k/OWxpKuGSB/M2u+MIvH9NER8nS0m/WSb4Vg=;
        b=JECat/W3pljBpvtcktPP+ICpfnaY8spwo8NWowntlDMMr3XXCgur8+DQNPk/KQWcAL0rXl
        BalCZ0h6TNGcoZ7bUYwW7TOctVuvsRFERFYlJtcGbn7azQ48kzLmfKUqKFg4fF8JOOdIcw
        D3Hx1h0WGMIquEfYf6IW7Ukf2R6WGpM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-GALGiG3sMOiJRkZxjylYjA-1; Tue, 11 Oct 2022 09:02:31 -0400
X-MC-Unique: GALGiG3sMOiJRkZxjylYjA-1
Received: by mail-ed1-f71.google.com with SMTP id c17-20020a05640227d100b0045c91f982a1so540994ede.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+RSYC+k/OWxpKuGSB/M2u+MIvH9NER8nS0m/WSb4Vg=;
        b=STBXe+gQkU/vslxQI9D9vAAPFU6u2UCrdzYuoI7eKtkmcv3kJxLt7RkjAZQouPojMj
         AwTn7anyrr0zRVaPnpIeAgEgZhvNm6oeHsPjFrTQSFZBC9C0+wClrVcjo3NWunDX5RAl
         yERtcjfwmqCBXFs77woEAJmkaoLNw+RVuR9NCoiqbm43GcBAYS6oIdgZmc1t2vk8X7TV
         rr2DEDtI11gL4MY4WEA9962e2OBMTilAtA5ltAkF7+GqNoCx8ufX7xYpZ+X57v97ObxC
         Oy3+05JNNuC7RjCcrxUp+di3/3WrIF6YAm9LeZXmt8IqbO0Ie+WQauGywQ28jt1ZMZIS
         rtpA==
X-Gm-Message-State: ACrzQf3tbGVkKrGj4nHzANYuB6ozdKLBYoRKbJxUiNVqimUxOeyKaSYy
        pI4Eihw2p8PfFo/oFEt1655Zd47BOqwDret845dg+30X52QDVWTtuyPQ2qJIkwLwN/QyEGd+4Ex
        sQbCjLe4pV5mG2QD0SwvEEjhw
X-Received: by 2002:aa7:d306:0:b0:459:6e9:6284 with SMTP id p6-20020aa7d306000000b0045906e96284mr22559092edq.70.1665493349977;
        Tue, 11 Oct 2022 06:02:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7CESgK3LtgFmBOJFmJzhxnzqE5zCHO0g2rqJHfAdkcarexhL70XY7a39u0QzOdWL7Gub9ZMw==
X-Received: by 2002:aa7:d306:0:b0:459:6e9:6284 with SMTP id p6-20020aa7d306000000b0045906e96284mr22559073edq.70.1665493349728;
        Tue, 11 Oct 2022 06:02:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id c8-20020a056402100800b0045bccd8ab83sm283693edu.1.2022.10.11.06.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:02:29 -0700 (PDT)
Message-ID: <2c36799c-af38-fed5-3f31-a8bde25368d7@redhat.com>
Date:   Tue, 11 Oct 2022 15:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [kbuild] arch/x86/kvm/x86.c:4988 kvm_arch_tsc_set_attr() warn:
 check for integer overflow 'offset'
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Oliver Upton <oupton@google.com>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202210102159.8nYEC0Hl-lkp@intel.com>
 <Y0Rm/Y5flhd734NX@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y0Rm/Y5flhd734NX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 20:39, Sean Christopherson wrote:
>> 828ca89628bfcb Oliver Upton 2021-09-16 @4988  		tsc = kvm_scale_tsc(vcpu, rdtsc(), vcpu->arch.l1_tsc_scaling_ratio) + offset;
>>
>> Smatch hates obvious user triggerable integer overflows...  No checking
>> on offset.
>
> This is ok, and even necessary, e.g. if the host TSC > guest TSC.

(which in fact is the common case).  Also this is unsigned which is fine 
according to the C standard, though I understand that static analyzers 
want to be stricter.

> Is there anything
> we can do in KVM to help Smatch avoid false positives?  Or do you/Smatch already
> maintain a list of known false positives?

Seconded.

Paolo

