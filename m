Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B872A659201
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiL2VHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiL2VHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:07:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43191269
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672347989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=it+B1PS32dTGPCypZI1aX6Ei43ZO2hTLVkDexUvu2GQ=;
        b=ac7MxG5VAy52JNbTCyvMGWawtJF0Rzfztc+8H+AMQ1HQ0Zo/43H5VVSKVMguKx8fvS77OJ
        3q/9XbFVd7ed3ycE4os6JoY8yG11RlXZxsOcKrVpzIDVWpYwbFBsHVaoMbex0BicGGPcSZ
        CwDSI/WJGxw64znkuO1JQU1BIYYdsVk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-4_qHrhPoO5aLsJXV9_KFrw-1; Thu, 29 Dec 2022 16:06:27 -0500
X-MC-Unique: 4_qHrhPoO5aLsJXV9_KFrw-1
Received: by mail-ed1-f70.google.com with SMTP id f15-20020a056402354f00b00485864db618so7069716edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=it+B1PS32dTGPCypZI1aX6Ei43ZO2hTLVkDexUvu2GQ=;
        b=qz1rsD7VgKN8Ufw69lJ/kl6qbNWC5gQyrz1fyMWF1PMHx0mBh5CJq/Ss8ZZXwUSpNX
         gzZgAlJtkLXg1rUb1TeRr4jXFgNKOk5762V6/YpPDTx4JyBlGoMkDn991IuCws0YFQyo
         CEAMqAFhCUo74Ubb1btThj3yeEcityjnqDcdbd+v3Car7wJlxrdub8tdwjvhV/5KSNP7
         ShaBMYYguTg4xN4IWjXVkcMzTbYazeqIeP1Gi8p2j0oMpTd9tZmk1PwK3rKiModARYSM
         iX+dfqn/Gzu88PrHxQUKrj0btkA/TsKU15kirhtTj7xpJjI7GsTUY8/BNLl+bv7tSKdH
         02Xw==
X-Gm-Message-State: AFqh2kpM7h6tk+atn72khbFytSbWpyRgZeA7QyMW8zSoKclDC6anhZdr
        xzrD29DURg0vS4+jez4W6Toc/eYbhI14dEWqBgSFmsKrwMhRcMABObSx/DeAFtn+KxnwkbKvy6E
        AkEU7KeZxAjQ6t3QkYKcUuvO7
X-Received: by 2002:a17:907:8c0a:b0:7c4:edee:28c0 with SMTP id ta10-20020a1709078c0a00b007c4edee28c0mr33927889ejc.24.1672347986712;
        Thu, 29 Dec 2022 13:06:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvQL7mNzDT9TfcU620OIPHvZr6KsbN//Mw8YFdfU0TCUvExqxFpww9gz67fGiOGe/8ra1uDMQ==
X-Received: by 2002:a17:907:8c0a:b0:7c4:edee:28c0 with SMTP id ta10-20020a1709078c0a00b007c4edee28c0mr33927879ejc.24.1672347986450;
        Thu, 29 Dec 2022 13:06:26 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312::529? ([2001:b07:6468:f312::529])
        by smtp.googlemail.com with ESMTPSA id c10-20020a17090618aa00b00846734faa9asm8878423ejf.164.2022.12.29.13.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 13:06:25 -0800 (PST)
Message-ID: <49636b4c-10e1-8cec-efdf-e2bd4b832a9e@redhat.com>
Date:   Thu, 29 Dec 2022 22:06:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 5/5] KVM: x86/mmu: Move kvm_tdp_mmu_map()'s prolog and
 epilog to its caller
Content-Language: en-US
To:     David Matlack <dmatlack@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Hoo <robert.hu@linux.intel.com>,
        Greg Thelen <gthelen@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
References: <20221213033030.83345-1-seanjc@google.com>
 <20221213033030.83345-6-seanjc@google.com> <Y6H2o2ADCALDA2oL@google.com>
 <Y6NRJTboZnjKbAL7@google.com> <Y63v0UnlI+wrrXfa@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y63v0UnlI+wrrXfa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/22 20:51, David Matlack wrote:
> Your proposal (below) to split out the "lower half" of the page fault
> handling routine works now because that's where all the divergence is.
> But with the common MMU there's also going to be divergence in the fast
> page fault handler. So I prefer to just keep the routines separate to
> avoid thrashing down the road.

Can you put the changes at the beginning of the common MMU series? 
Large parts of the whole common MMU refactoring can be merged piece by 
piece, so they can be taken as soon as they're ready.

Paolo

