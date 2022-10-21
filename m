Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC0607BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJUQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJUQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:09:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2132A707
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:09:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w189so1540725pfw.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=atEq6XUnsLTgZQ8a4NCS/ZdYKRgZxn+iMuufQefZZ+0=;
        b=eGudQkg8P8RMl4BgAU2RN15mrO604mY8d7L9SluZ5vfEphfK8FH7nibeyrpuqFY5sf
         p7JoTrF3vkT3pQQ687p5uCVlz3hBZEZqDF7RvVriqwzkJn0l68SrwwL0sTpsyeSvwfgX
         H6AQVmtqTCd9U/brN7SMkNnXhT6I6I6nc7s9UZcrXbiKy7HQt/ZuOevcfvLNcNy3mBQZ
         X2gn4sOn/1WY7ZQQi9ZN2vhhgBY34o4uyF9JFme6c3IbpUFKVHB8gsMTJDQF9a0ktwth
         Xh28UFr5CJOxRW05+fJb0BIrZRFmq7OO8QmW9LWD85TqgpJN4qPxYQ+sBDBsVLXhi8XH
         H32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atEq6XUnsLTgZQ8a4NCS/ZdYKRgZxn+iMuufQefZZ+0=;
        b=vLuFa1eoP07C8xws/pys5zMpGjcbnyvntgZOQj86lIAxzFlv4BBylbQVrnIahiWRJY
         vyO6nm2fVf65wI6R0cXDkZvKh/F1dHA50aBL4R9DXmzJ9Qt4W819d/RENcmms2bsLuEa
         1myzDXfNUM1kn6XugmU29DCFdqG54hVxLzVjrRV1ooh++6wmQI3FuLLr4a27DUgtTiY4
         PE9AVM92ABYK1W5VpJWSoRn3M1fLgJp297ggmjC4gqe5fuS3OjUzDeUdv6vIA6Bn96yA
         ND+0OtYRSOHb/uUhw58EJUUdVDbc3SYTu/cGK6B10yVpY+P6cC/EGzLWIfVYo+gTVXfF
         OR+Q==
X-Gm-Message-State: ACrzQf04lmLp0vL/2HcGMwpPe9ZwFyMbUyNSi+R6gQ9JVCVfNqeX1b44
        FCuWHrAbM8srB/WevEYOqntWog==
X-Google-Smtp-Source: AMsMyM5VbR5/UAQSg+UhJJqI6jBw64vdS9WWCcLNP6Vn9WaGw+m23DD/2YTSRI+OcSJmG9D5iEXQMA==
X-Received: by 2002:a63:1a46:0:b0:464:3966:54b9 with SMTP id a6-20020a631a46000000b00464396654b9mr17052629pgm.390.1666368575536;
        Fri, 21 Oct 2022 09:09:35 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g17-20020aa79dd1000000b0053e5daf1a25sm15379550pfq.45.2022.10.21.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:09:35 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:09:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 16/46] KVM: x86: hyper-v: Don't use
 sparse_set_to_vcpu_mask() in kvm_hv_send_ipi()
Message-ID: <Y1LEO49pDvZ1yrNV@google.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <20221004123956.188909-17-vkuznets@redhat.com>
 <Y1BahCzO4jxFC9Ey@google.com>
 <87czalczo6.fsf@redhat.com>
 <877d0tcpsg.fsf@ovpn-192-65.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d0tcpsg.fsf@ovpn-192-65.brq.redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
> > Sean Christopherson <seanjc@google.com> writes:
> >> Mostly because it's somewhat arbitrary that earlier code ensures valid_bank_mask
> >> is set in the all_cpus=true case, e.g. arguably KVM doesn't need to do the var_cnt
> >> sanity check in the all_cpus case:
> >>
> >> 		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
> >> 		if (all_cpus)
> >> 			goto check_and_send_ipi;
> >>
> >> 		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
> >> 		if (hc->var_cnt != hweight64(valid_bank_mask))
> >> 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> >>
> >> 		if (!hc->var_cnt)
> >> 			goto ret_success;
> >>
> >
> > I think 'var_cnt' (== hweight64(valid_bank_mask)) has to be checked in
> > 'all_cpus' case, especially in kvm_hv_flush_tlb(): the code which reads
> > TLB flush entries will read them from the wrong offset (data_offset/
> > consumed_xmm_halves) otherwise. The problem is less severe in
> > kvm_hv_send_ipi() as there's no data after CPU banks. 
> >
> > At the bare minimum, "KVM: x86: hyper-v: Handle
> > HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently" patch from this
> > series will have to be adjusted. I *think* mandating var_cnt==0 in 'all_cpus'
> > is OK but I don't recall such requirement from TLFS, maybe it's safer to
> > just adjust 'data_offset'/'consumed_xmm_halves' even in 'all_cpus' case.
> >
> > Let me do some tests... 
> 
> "We can neither confirm nor deny the existence of the problem". Windows
> guests seem to be smart enough to avoid using *_EX hypercalls altogether
> for "all cpus" case (as non-ex versions are good enough). Let's keep
> allowing non-zero var_cnt for 'all cpus' case for now

Sounds good.

> and think about hardening it later...

Eh, no need to add more work for ourselves.  I wasn't thinking about hardening so
much as slightly simplifying KVM code.
