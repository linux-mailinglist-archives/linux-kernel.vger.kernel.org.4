Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A9464505E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLGAdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLGAdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:33:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000AA44B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670373158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bx3BXv2xaG+1EbHubRbeDcJNx5uekjE2mo+oSlv4S6s=;
        b=DQf6dzsD1agHUbtZuAiFwcLzOAFkDZ03nInWtn3qE6c6pG97bha+L0w++27gA9LFuk72Bz
        WYjVaKgQYf7KidNqdZQnkjRZtCsNeDQkM4jCmVt86lCq9+rgMlriWe4ETkD38qm7role87
        4jP0ThuMc2Hv/MHCaVMO3rG+Qn9o8Wk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-576-YbRtQQMOPUq86KF7r3EPtA-1; Tue, 06 Dec 2022 19:32:37 -0500
X-MC-Unique: YbRtQQMOPUq86KF7r3EPtA-1
Received: by mail-ed1-f70.google.com with SMTP id t4-20020a056402524400b004620845ba7bso8862436edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx3BXv2xaG+1EbHubRbeDcJNx5uekjE2mo+oSlv4S6s=;
        b=MrdszhiUBJxe7pNFoE22BSmJVzKGXCrYfa+mxcS7ySic+zGhq96lMTGWwrGgEwXQEx
         CDfb9iip2NEB6R2K4/7QlmbCWV2eYrRt0pQfToW3NWaqpofzrlQXAJ7n4xfkmtZv7e4K
         mQ13RS3RIpZCiTA69myt4dEn1KFJQ+1ek2dtFQeBvbtHJ9y3Tmv2TkXHvnVE3APYBnQe
         rNkRXftmfrDxSfwmGE7Au2UuK1iY+i5RPCSHOwc5LKCIeYchxNgTmx2BxOKfrNC7NI48
         Zyf2FovtpVCztJRNF9KVk4wsjdOBAri5ao574yJB/K9LPROEHZ1m9eZGY/Dqxz0fRbTp
         S+yg==
X-Gm-Message-State: ANoB5plLWWUy/94JliVNYEWx6VbVeIDtL/TlmiY7cquNAGGn8iadUGL/
        pniO0Zoa9GUfoctNs/ZquqB/MT248u0lKENt2AxQZJw5vBEhYEsRlZd8m6QNx52yJWOMM7onQvU
        1ujBwngsG/XFgj8yREr1CgVqo
X-Received: by 2002:a17:906:c358:b0:7c1:15ff:ce80 with SMTP id ci24-20020a170906c35800b007c115ffce80mr2620652ejb.172.1670373155577;
        Tue, 06 Dec 2022 16:32:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Oxf+wCsuYpvkjV1axw2D5khlwYSyP4XXkZLxf8xeI771oZdd9N0RssiIxK8XsowEBoPe0XQ==
X-Received: by 2002:a17:906:c358:b0:7c1:15ff:ce80 with SMTP id ci24-20020a170906c35800b007c115ffce80mr2620637ejb.172.1670373155280;
        Tue, 06 Dec 2022 16:32:35 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id bv19-20020a170906b1d300b0077016f4c6d4sm7869812ejb.55.2022.12.06.16.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 16:32:34 -0800 (PST)
Message-ID: <16b5bdd0-ac8c-640f-579e-1335d1286d80@redhat.com>
Date:   Wed, 7 Dec 2022 01:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] KVM: x86: Add proper ReST tables for userspace MSR
 exits/flags
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221207000959.2035098-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221207000959.2035098-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 01:09, Sean Christopherson wrote:
> Add ReST formatting to the set of userspace MSR exits/flags so that the
> resulting HTML docs generate a table instead of malformed gunk.  This
> also fixes a warning that was introduced by a recent cleanup of the
> relevant documentation (yay copy+paste).
> 
>   >> Documentation/virt/kvm/api.rst:7287: WARNING: Block quote ends
>      without a blank line; unexpected unindent.

Queued, thanks.

Paolo

> Fixes: 1ae099540e8c ("KVM: x86: Allow deflecting unknown MSR accesses to user space")
> Fixes: 1f158147181b ("KVM: x86: Clean up KVM_CAP_X86_USER_SPACE_MSR documentation")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   Documentation/virt/kvm/api.rst | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index c618fae44ad7..778c6460d1de 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6455,9 +6455,11 @@ The "reason" field specifies why the MSR interception occurred. Userspace will
>   only receive MSR exits when a particular reason was requested during through
>   ENABLE_CAP. Currently valid exit reasons are:
>   
> -	KVM_MSR_EXIT_REASON_UNKNOWN - access to MSR that is unknown to KVM
> -	KVM_MSR_EXIT_REASON_INVAL - access to invalid MSRs or reserved bits
> -	KVM_MSR_EXIT_REASON_FILTER - access blocked by KVM_X86_SET_MSR_FILTER
> +============================ ========================================
> + KVM_MSR_EXIT_REASON_UNKNOWN access to MSR that is unknown to KVM
> + KVM_MSR_EXIT_REASON_INVAL   access to invalid MSRs or reserved bits
> + KVM_MSR_EXIT_REASON_FILTER  access blocked by KVM_X86_SET_MSR_FILTER
> +============================ ========================================
>   
>   For KVM_EXIT_X86_RDMSR, the "index" field tells userspace which MSR the guest
>   wants to read. To respond to this request with a successful read, userspace
> @@ -7256,11 +7258,13 @@ to inform a user that an MSR was not emulated/virtualized by KVM.
>   
>   The valid mask flags are:
>   
> -	KVM_MSR_EXIT_REASON_UNKNOWN - intercept accesses to unknown (to KVM) MSRs
> -	KVM_MSR_EXIT_REASON_INVAL   - intercept accesses that are architecturally
> -                                invalid according to the vCPU model and/or mode
> -	KVM_MSR_EXIT_REASON_FILTER  - intercept accesses that are denied by userspace
> -                                via KVM_X86_SET_MSR_FILTER
> +============================ ===============================================
> + KVM_MSR_EXIT_REASON_UNKNOWN intercept accesses to unknown (to KVM) MSRs
> + KVM_MSR_EXIT_REASON_INVAL   intercept accesses that are architecturally
> +                             invalid according to the vCPU model and/or mode
> + KVM_MSR_EXIT_REASON_FILTER  intercept accesses that are denied by userspace
> +                             via KVM_X86_SET_MSR_FILTER
> +============================ ===============================================
>   
>   7.22 KVM_CAP_X86_BUS_LOCK_EXIT
>   -------------------------------
> 
> base-commit: 3d7af7c5e000c68581429d533ed63414e4a48e6d

