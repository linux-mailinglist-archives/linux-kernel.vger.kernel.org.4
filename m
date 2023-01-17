Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F149566E423
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAQQyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjAQQyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:54:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5729976AF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:54:02 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so11323763pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z0QAQ5blPGWd/OiR8xsaSSAM6FxsJXPFCoPODEYCH9E=;
        b=VfUIDycf0fuXkf43PrB52d+v/goUrGO8gMEpKxmX7uOvhsTNfXhKcfPP+ecOuMQwz6
         tHYwUyNu6Bx0mPdhkGzOAFjYq30AUsmqhq3cg6nkStVBD56ZeXr/6y4huVXbKhyfoROl
         ER5L45UwxHznNFAG0SzaqMKKv2YHJDs5m+kqCHlkzIvQk0HUn5ly8QWA20ioFPZQ57f2
         9vXDVLAp5geu2kuMGSefXWhvd82ACieP3xx/AlkZ8b13pQHzqXrZbwy0WngqV1Xyq0cY
         0XfQrzJRMRl6E8uyBv3cjcfm9zRQl/zC3DAlzI1CYwOflZsSlOTqoDixYGVkIni/L0Sj
         mMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0QAQ5blPGWd/OiR8xsaSSAM6FxsJXPFCoPODEYCH9E=;
        b=xGA5GUsus/6Y2IJ4m54GWc8egMGrbQ9kVEMblgAiU6w4I6bQpqEFyW1/xmY+UlYzBy
         5oYGpF9M31yMaktevX6cdeYNJ3W04dcqbl7Tf9Uw4M0gpOwN/PgR71L0A6h69jJ4ggMt
         v84tlzi59YedcYIpkuOn8jOb+bcehA/6FH9MOVTWhlJ6COlbQKXmmXuO0FZdRq6yXXis
         mUsBmX6b1hPoc7Ba7OXjuQr9MvXtLWaWRdwMRUbQDVLPfWYU2KtVvmp/IKWFU3VXRAOe
         rvLuvM/IK+4TobV36ws4ij0A0oqYhq/cX27zvB6PBT/9yV2gAEWhmGsSU9v6z6Zzi8mt
         vclw==
X-Gm-Message-State: AFqh2kqecrepfmznTosFLrnyt6ZLm44jvwM8hozIpGBk1s7vZAsENkQW
        OEC2st1J/zevM9WPhZZQLMCjVA==
X-Google-Smtp-Source: AMrXdXvbAEA/z+pbxa6vx3GwOqs2HAO5r7H5fxiuaV+0mLY0Af1+dkf1LH5lGWVr1IfeqQtrslBYNg==
X-Received: by 2002:a05:6a20:93a4:b0:b8:e33c:f160 with SMTP id x36-20020a056a2093a400b000b8e33cf160mr73083pzh.0.1673974441713;
        Tue, 17 Jan 2023 08:54:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a4d0a00b00226a71bd3a6sm18801123pjg.13.2023.01.17.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:54:01 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:53:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Shahar, Sagi" <sagis@google.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "dmatlack@google.com" <dmatlack@google.com>
Subject: Re: [PATCH v11 055/113] KVM: x86/VMX: introduce vmx tlb_remote_flush
 and tlb_remote_flush_with_range
Message-ID: <Y8bSpdplnlRus3lx@google.com>
References: <cover.1673539699.git.isaku.yamahata@intel.com>
 <d69b281c23131254ae6fdea67e384ef931dbba8e.1673539699.git.isaku.yamahata@intel.com>
 <d98561f16056d919626a46f0d078b774e2d56445.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d98561f16056d919626a46f0d078b774e2d56445.camel@intel.com>
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

On Tue, Jan 17, 2023, Huang, Kai wrote:
> On Thu, 2023-01-12 at 08:32 -0800, isaku.yamahata@intel.com wrote:
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -244,7 +244,7 @@ static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
> >  {
> >  	int ret = -ENOTSUPP;
> >  
> > -	if (range && kvm_x86_ops.tlb_remote_flush_with_range)
> > +	if (range && kvm_available_flush_tlb_with_range())
> >  		ret = static_call(kvm_x86_tlb_remote_flush_with_range)(kvm, range);
> 
> Again, IMHO this code change doesn't make code any clearer.  With the new code,
> I need to go into the kvm_available_flush_tlb_with_range() to see what's going
> on, but with the old code I don't.

Agreed.  Though I think this patch as a whole can be replaced with a more
straightforward solution.

hv_remote_flush_tlb() is used when KVM is running as a Hyper-V guest, whereas
TDX requires running KVM on bare metal.  KVM should simply disallow TDX when a
hypervisor is detected, then there's no need for vmx_tlb_remote_flush_with_range().
