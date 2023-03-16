Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DBD6BCF05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCPMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCPMIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E1C97EE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678968455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSMHsj3qGaFVd90X1pJchslesPn8WvjooBJnnMqEy6E=;
        b=TEWIx1sVq/R0bnNMRdVW436dRcATa1L1X5+QenqQoRhcyn4Cg+WMr0MUU1mlcfBjBL3V29
        54k0mjsRT0BqLyVFHIRtKH5GOiiH9FQ+XZ/GIysD+NzRNjxt4zbqfwKMzSo0lALwugFr47
        j3817aEybhnnimVVmNZEqNK+GKPAu7E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107--ls4bNP_N-ak8HtLXz7yXA-1; Thu, 16 Mar 2023 08:07:34 -0400
X-MC-Unique: -ls4bNP_N-ak8HtLXz7yXA-1
Received: by mail-wm1-f69.google.com with SMTP id s18-20020a7bc392000000b003deaf780ab6so569201wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678968452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSMHsj3qGaFVd90X1pJchslesPn8WvjooBJnnMqEy6E=;
        b=uWK8ntWBr2V532LXlyrAUsH6SQsmRPrpE4+7/q4QJYnX/vbrlOugl6oC+VtIX7FP4k
         7ZnqufGJ2r2MlffiOpuPPz6n/RqcRoGccaUwIlmbWXvkMyhH+DxNHXawZl2vztgJVSIQ
         Utf0L3Bnc36t+bop+L0SY/MZlwE+U4zN/kbQlKhoJbV6uSmr6jznDx6+ozku+wQoRHXm
         qUobESj99TYxFAmG4vpECF9NrAc/jEg5BJM2KcBW0LjDGE213iiMamyjZhrxh1Ww8j/7
         KVrjzMzIMKupJ16v8ogn420mFkeerG+BOmZT6G+lJOhAqMqG3lBxkzlP2E9r04BUK8Q1
         tNiQ==
X-Gm-Message-State: AO0yUKVI4NLnibMOLzRztHF0k21z1PwCUyp1v/yXVoNjPY9h1+P7DYVd
        +1sHrNWpguQE34+P9IAFLwgLzRn6pxP/rG3RTetBN/OvIT6prMH+1Tk/ldVa7/oi9xZPMFxtLsg
        8ldGZ14dHDRuwzgmLmPbvv8FqIAHQWCkB
X-Received: by 2002:a05:600c:3151:b0:3dd:af7a:53db with SMTP id h17-20020a05600c315100b003ddaf7a53dbmr21342586wmo.11.1678968452545;
        Thu, 16 Mar 2023 05:07:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set/afxErwVL8z+xD9jApgCP1zJ/+aex1HwtpcOEyBvugRBe8uSsjcLzaxegihFPY/qncNXdI2g==
X-Received: by 2002:a05:600c:3151:b0:3dd:af7a:53db with SMTP id h17-20020a05600c315100b003ddaf7a53dbmr21342574wmo.11.1678968452293;
        Thu, 16 Mar 2023 05:07:32 -0700 (PDT)
Received: from [192.168.149.90] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b003b47b80cec3sm4828584wmq.42.2023.03.16.05.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 05:07:31 -0700 (PDT)
Message-ID: <b98945f0-09ef-158a-9348-e518469ec7e3@redhat.com>
Date:   Thu, 16 Mar 2023 13:07:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] KVM: x86: Fix kvm/queue breakage on clang
Content-Language: de-CH
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315191128.1407655-1-seanjc@google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230315191128.1407655-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
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



Am 15/03/2023 um 20:11 schrieb Sean Christopherson:
> Fix clang build errors for patches sitting kvm/queue.  Ideally, these
> fixes will be squashed before the buggy commits make their way to kvm/next.
> If you do fixup kvm/queue, the VMX commit also has a bad SOB chain; Jim
> either needs to be listed as the author or his SOB needs to be deleted.
> 
> Sean Christopherson (2):
>   KVM: VMX: Drop unprotected-by-braces variable declaration in
>     case-statement
>   KVM: SVM: Drop unprotected-by-braces variable declaration in
>     case-statement
> 
>  arch/x86/kvm/svm/svm.c | 5 ++---
>  arch/x86/kvm/vmx/vmx.c | 4 +---
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 95b9779c1758f03cf494e8550d6249a40089ed1c

Note to self: compile patches also with clang, since gcc didn't complain
about missing brackets in a switch case.

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

