Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637145FA375
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJJSkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJJSkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:40:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1811457
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:40:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i6so11496557pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wS9XNmL9PTvlp9VISpiDKDxyfVk83qtMmZiT+IPGHIg=;
        b=JxKohsaUtCTHITn6Y1acxAvmnClFADK4dR5OZ7ZyXuykcvKRbmQFQ/1TH6IoylwOGe
         uKI0p0MKNau02ZcSN9efCZi2tAc5xOkmAiAaSd5DCGuMfyiYlRM6qa1kz2PQWW55eplG
         TdZXiM22oNth5hg9jKBp0jIP6owdSRtRrQdWM8WnIKp7jV02OMFW2DnK0xQINgqGIfPi
         8JTNYOTb16oBISqekFaQ4vtwDFv5q1TlYml5doodUhXld8RAlLwlGuw4ozoRQdc5ehcy
         M9Jpnn2KIT3b7XH+o4RcuaZgPd2tHbC0me9GvctljTqq3iozugubkiY1g3PR9WU9OlAM
         Glew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS9XNmL9PTvlp9VISpiDKDxyfVk83qtMmZiT+IPGHIg=;
        b=Fr5JrrqLAbNPqM8ZwcKAbcF1lEh6s2Nca2l4k/gMd84QZ/7crSV0XuS32mAQuwb1MV
         6YEATEplejisdEtDxAasnktvUHN094VXdghUH2uyNIeOLF43YldGz1qWi9IOqADIF2QF
         IWxWPfw2PMTBiMXDhejtwl3roxyGrB6e7jXu36SKpffoPP5Iu9kwl0vCVGaNcQLr2VPo
         lt/lhiijuLTNokk+TrbwF+sSEa4bLR+Bs2J8TTOn3VS8ijBZllJs7rckrkE5r3kBku2q
         33UZSbAz3u8UT79IeFvlvaBub8DjZASdhvPeNSkwGTDA02xOSCP0VRHmywKxCP9QU6Yh
         U8qw==
X-Gm-Message-State: ACrzQf3hCCu7MR+wR5dIshHMVAAGC6QBLu+8mvLUoDKRvdgjADm1W9H9
        PijrLsGawvy7tim4yX/qg1kFMA==
X-Google-Smtp-Source: AMsMyM6Fjr00dxHFttyasVAvYKQe05ojYvDgqzANBhfrAVWkl8cqNxmnfRDPwxovzjem1EuKn8+Hew==
X-Received: by 2002:a65:62c7:0:b0:463:9c67:5fe2 with SMTP id m7-20020a6562c7000000b004639c675fe2mr2368898pgv.443.1665427202557;
        Mon, 10 Oct 2022 11:40:02 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p13-20020aa79e8d000000b005627470944dsm7248057pfq.189.2022.10.10.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:40:01 -0700 (PDT)
Date:   Mon, 10 Oct 2022 18:39:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Oliver Upton <oupton@google.com>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [kbuild] arch/x86/kvm/x86.c:4988 kvm_arch_tsc_set_attr() warn:
 check for integer overflow 'offset'
Message-ID: <Y0Rm/Y5flhd734NX@google.com>
References: <202210102159.8nYEC0Hl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210102159.8nYEC0Hl-lkp@intel.com>
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

On Mon, Oct 10, 2022, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git   master
> head:   493ffd6605b2d3d4dc7008ab927dba319f36671f
> commit: 828ca89628bfcb1b8f27535025f69dd00eb55207 KVM: x86: Expose TSC offset controls to userspace
> config: x86_64-randconfig-m001-20221010
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> arch/x86/kvm/x86.c:4988 kvm_arch_tsc_set_attr() warn: check for integer overflow 'offset'
> 
> vim +/offset +4988 arch/x86/kvm/x86.c
> 
> 828ca89628bfcb Oliver Upton 2021-09-16  4962  static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
> 828ca89628bfcb Oliver Upton 2021-09-16  4963  				 struct kvm_device_attr *attr)
> 828ca89628bfcb Oliver Upton 2021-09-16  4964  {
> 828ca89628bfcb Oliver Upton 2021-09-16  4965  	u64 __user *uaddr = (u64 __user *)(unsigned long)attr->addr;
> 828ca89628bfcb Oliver Upton 2021-09-16  4966  	struct kvm *kvm = vcpu->kvm;
> 828ca89628bfcb Oliver Upton 2021-09-16  4967  	int r;
> 828ca89628bfcb Oliver Upton 2021-09-16  4968  
> 828ca89628bfcb Oliver Upton 2021-09-16  4969  	if ((u64)(unsigned long)uaddr != attr->addr)
> 828ca89628bfcb Oliver Upton 2021-09-16  4970  		return -EFAULT;
> 828ca89628bfcb Oliver Upton 2021-09-16  4971  
> 828ca89628bfcb Oliver Upton 2021-09-16  4972  	switch (attr->attr) {
> 828ca89628bfcb Oliver Upton 2021-09-16  4973  	case KVM_VCPU_TSC_OFFSET: {
> 828ca89628bfcb Oliver Upton 2021-09-16  4974  		u64 offset, tsc, ns;
> 828ca89628bfcb Oliver Upton 2021-09-16  4975  		unsigned long flags;
> 828ca89628bfcb Oliver Upton 2021-09-16  4976  		bool matched;
> 828ca89628bfcb Oliver Upton 2021-09-16  4977  
> 828ca89628bfcb Oliver Upton 2021-09-16  4978  		r = -EFAULT;
> 828ca89628bfcb Oliver Upton 2021-09-16  4979  		if (get_user(offset, uaddr))
> 828ca89628bfcb Oliver Upton 2021-09-16  4980  			break;
> 828ca89628bfcb Oliver Upton 2021-09-16  4981  
> 828ca89628bfcb Oliver Upton 2021-09-16  4982  		raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> 828ca89628bfcb Oliver Upton 2021-09-16  4983  
> 828ca89628bfcb Oliver Upton 2021-09-16  4984  		matched = (vcpu->arch.virtual_tsc_khz &&
> 828ca89628bfcb Oliver Upton 2021-09-16  4985  			   kvm->arch.last_tsc_khz == vcpu->arch.virtual_tsc_khz &&
> 828ca89628bfcb Oliver Upton 2021-09-16  4986  			   kvm->arch.last_tsc_offset == offset);
> 828ca89628bfcb Oliver Upton 2021-09-16  4987  
> 828ca89628bfcb Oliver Upton 2021-09-16 @4988  		tsc = kvm_scale_tsc(vcpu, rdtsc(), vcpu->arch.l1_tsc_scaling_ratio) + offset;
> 
> Smatch hates obvious user triggerable integer overflows...  No checking
> on offset.

This is ok, and even necessary, e.g. if the host TSC > guest TSC.  Is there anything
we can do in KVM to help Smatch avoid false positives?  Or do you/Smatch already
maintain a list of known false positives?
