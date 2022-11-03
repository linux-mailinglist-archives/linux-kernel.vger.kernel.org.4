Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC961880C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKCS60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKCS6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:58:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC6C6E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:58:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g129so2459378pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgBlWniGTXEnPcASGuNFCxIZuwOSNaqHJ+Eb2HtkZ3A=;
        b=crtTNSDLBpNcvDSxofCENmrvtDvGgpUzGCkxI3/S4zR915QtnPiMfGmQ1bfa1+IphI
         JYKHG76keqoKUqskuvBrM1m0JyELxmvNXlZ4KiPUOKMYgaWfFysvap9RGXI963+2hoeq
         HHT/GX+S1XBR2PYehjOUxetwVpL78GGV9aYozWyKXyCWQQP6iGe8zgNPOME2bv1qjA9e
         apMslXORbm1rWkX1K/6OQ1RCG98VSwtHOf2J04nfLy9jITyFIIcn6ieZ9TY4AUm1gsGc
         eyQU7zbjJP0kGKm2zN/8wgEWv2C3dUA3cPXDwDYFGn1wLuJmRxozNVKQFEnfavfSL6Lx
         ZqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgBlWniGTXEnPcASGuNFCxIZuwOSNaqHJ+Eb2HtkZ3A=;
        b=XuvDt1Xm+ysrRP/7SkLDCVaj7/0J0W1s7mfjGBArB9rnZRGlFvaEj1a04YhHMLr9UK
         Aknmy3Jt4y/JchWur/09AcMB4LDGEMIbSd11+BnNmsoeqUZ/UL6WULRIY82NQnwA+hzl
         BT4tacNHGUvkaUDmJctyCV8tpTa1Lg3c5Pj7iBxiMuSyQRNdEdnaryGxsG2bq+5fJjUF
         oNohBR357hIYLQyPpZzm02LyRdqztCsBSdCrOYI2iifEsj54dgefn0oExqIHHBDX+D6d
         X7rYevGiNxKlnkgu0xk1totchpxP2ZfNqYTxj16lxwP/Oanp+tiBBcOHdWWhTpMIj4lJ
         ID8A==
X-Gm-Message-State: ACrzQf1h5Ziqn4CyIy4HqKXQaY3ANK4N3vYF9oeSGDhWQs+lOoBfj23C
        eWLRl3keU3i2nDWYbBEh/S08OA==
X-Google-Smtp-Source: AMsMyM7lUXjnrFRO+e+xTY8enXMXmh/YC+M/IqwbxJRPxqwsuhxb3fUJPK1b1MpOBO3HsUEvz+aKuA==
X-Received: by 2002:aa7:81cf:0:b0:561:7d72:73ef with SMTP id c15-20020aa781cf000000b005617d7273efmr31655060pfn.16.1667501900762;
        Thu, 03 Nov 2022 11:58:20 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c20-20020a17090ad91400b00209a12b3879sm309308pjv.37.2022.11.03.11.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:58:20 -0700 (PDT)
Date:   Thu, 3 Nov 2022 18:58:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
Subject: Re: [PATCH 33/44] KVM: x86: Do VMX/SVM support checks directly in
 vendor code
Message-ID: <Y2QPSK1/6esl61wQ@google.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-34-seanjc@google.com>
 <bfa98587-3b36-3834-a4b9-585a0e0aa56a@redhat.com>
 <Y2QJ2TuyZImbFFvi@google.com>
 <c29e7d40-ddb9-def0-f944-a921a05a4bb2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c29e7d40-ddb9-def0-f944-a921a05a4bb2@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022, Paolo Bonzini wrote:
> On 11/3/22 19:35, Sean Christopherson wrote:
> > It's technically required.  IA32_FEAT_CTL and thus KVM_INTEL depends on any of
> > CPU_SUP_{INTEL,CENATUR,ZHAOXIN}, but init_ia32_feat_ctl() is invoked if and only
> > if the actual CPU type matches one of the aforementioned CPU_SUP_*.
> > 
> > E.g. running a kernel built with
> > 
> >    CONFIG_CPU_SUP_INTEL=y
> >    CONFIG_CPU_SUP_AMD=y
> >    # CONFIG_CPU_SUP_HYGON is not set
> >    # CONFIG_CPU_SUP_CENTAUR is not set
> >    # CONFIG_CPU_SUP_ZHAOXIN is not set
> > 
> > on a Cenatur or Zhaoxin CPU will leave X86_FEATURE_VMX set but not set
> > X86_FEATURE_MSR_IA32_FEAT_CTL.  If VMX isn't enabled in MSR_IA32_FEAT_CTL, KVM
> > will get unexpected #UDs when trying to enable VMX.
> 
> Oh, I see.  Perhaps X86_FEATURE_VMX and X86_FEATURE_SGX should be moved to
> one of the software words instead of using cpuid.  Nothing that you should
> care about for this series though.

Or maybe something like this?

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..ebe617ab0b37 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -191,6 +191,8 @@ static void default_init(struct cpuinfo_x86 *c)
                        strcpy(c->x86_model_id, "386");
        }
 #endif
+
+       clear_cpu_cap(c, X86_FEATURE_MSR_IA32_FEAT_CTL);
 }
 
 static const struct cpu_dev default_cpu = {
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index c881bcafba7d..3a7ae67f5a5e 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -72,6 +72,8 @@ static const struct cpuid_dep cpuid_deps[] = {
        { X86_FEATURE_AVX512_FP16,              X86_FEATURE_AVX512BW  },
        { X86_FEATURE_ENQCMD,                   X86_FEATURE_XSAVES    },
        { X86_FEATURE_PER_THREAD_MBA,           X86_FEATURE_MBA       },
+       { X86_FEATURE_VMX,                      X86_FEATURE_MSR_IA32_FEAT_CTL         },
+       { X86_FEATURE_SGX,                      X86_FEATURE_MSR_IA32_FEAT_CTL         },
        { X86_FEATURE_SGX_LC,                   X86_FEATURE_SGX       },
        { X86_FEATURE_SGX1,                     X86_FEATURE_SGX       },
        { X86_FEATURE_SGX2,                     X86_FEATURE_SGX1      },

