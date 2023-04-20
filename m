Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE046E97B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjDTOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjDTOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:52:13 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32614C02
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:51:51 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-51b121871ecso640061a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682002311; x=1684594311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cenhvMgRBJVEyO+DQ1Yk7EeAnoD+Mx3QDGrPvs6dp/U=;
        b=ozdQf66WPw8ShRBluz+LMQljss+d3T0PBYjA3jmNDdv//pVrmGXx6L9uusb7fIhJSL
         LymgWp9X3FbkLAAxceftLeQZn0/6M8JdZmIbsV9oONQVhJAe+e9OODUteXA7bMLvWkmz
         5ayRkEY6NENxUYGlnGZFkZBlmyRHMXNIOgoLHCbFX3aaDwjuintlWNx5LkJKfs2Sd6PE
         Ya8JLH6D3Xz61J6mffVksjDGSWXvO9yhMWIRSY/rzCnaTg7svns1MKliwXodcMA+7eb1
         u30LO7+8+pIMTa1eXTgGdK8wfjlZ/7y7DufflgYGy0ae6b3znNofgHpeyL7dnXNOKs4z
         yrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002311; x=1684594311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cenhvMgRBJVEyO+DQ1Yk7EeAnoD+Mx3QDGrPvs6dp/U=;
        b=D50lHkj/UNx/Npfmg87/5cjYl6rIoJtdgP2EaQf1FEbB7UznlZ0ho56AQzIYrEcM58
         F3gZ483Dk5ANxRtTWpwxO+IsawYUfR3bv9W/aScHOWUrqWF31TXZd2W08PiHgpp/eGVm
         grv+HRJwJagnvFY1+mUnJe1+BC5vlCdRcvBWcsVMerAvHxJeihxrHp9VJRoCfbQmaavR
         6PxJCzhmDW343/o/7s/vFL1Y9Tj3J7Oz8JObfTsIHn6NVD83NVdjInLKoDf+nLsKNOdo
         HJ3M/9ieeMcBZkTuhAf/luKY5vWscqmYQ1MpdjM3fV0GfrYIdXKnXWhM0LuOblN1LOAz
         ix/Q==
X-Gm-Message-State: AAQBX9doJSXoQFyqALd8CKflGoeb40RlVP8wcbiqGsDCnPDahrRZfLI/
        4tFZsj9Y1PG0Ewqr2UQghoS6UGOaqiM=
X-Google-Smtp-Source: AKy350YZDYx9Ka0U+LJTenQgM1KG3UW2Yutu07LdZ7q6GZTzBdJRqMrlgBJSIie+uzUyI4FO9iSrYEblhR4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f807:b0:1a6:3a2e:b731 with SMTP id
 ix7-20020a170902f80700b001a63a2eb731mr623230plb.1.1682002311424; Thu, 20 Apr
 2023 07:51:51 -0700 (PDT)
Date:   Thu, 20 Apr 2023 07:51:49 -0700
In-Reply-To: <87y1mm3iqz.ffs@tglx>
Mime-Version: 1.0
References: <87r0sh4m7a.ffs@tglx> <8592a301-9933-1cad-bd61-8d97e7c7493b@molgen.mpg.de>
 <87a5z443g2.ffs@tglx> <877cu83v45.ffs@tglx> <874jpc3s3r.ffs@tglx>
 <0f5463fd-9c4a-6361-adbb-dd89dbb9138d@citrix.com> <c2aaa4fb-a5ba-d5bf-634a-dcf4fd8ad246@citrix.com>
 <871qkf3qek.ffs@tglx> <26d385da-2ede-5d73-2959-84c8f7d89e03@citrix.com> <87y1mm3iqz.ffs@tglx>
Message-ID: <ZEFRhXua6Jxvit1R@google.com>
Subject: Re: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        "=?iso-8859-1?Q?J=FCrgen_Gro=DF?=" <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E. J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023, Thomas Gleixner wrote:
> On Thu, Apr 20 2023 at 10:23, Andrew Cooper wrote:
> > On 20/04/2023 9:32 am, Thomas Gleixner wrote:
> > > On Wed, Apr 19, 2023, Andrew Cooper wrote:
> > > > This was changed in x2APIC, which made the x2APIC_ID immutable.
>
> >> I'm pondering to simply deny parallel mode if x2APIC is not there.
> >
> > I'm not sure if that will help much.
> 
> Spoilsport.

LOL, well let me pile on then.  x2APIC IDs aren't immutable on AMD hardware.  The
ID is read-only when the CPU is in x2APIC mode, but any changes made to the ID
while the CPU is in xAPIC mode survive the transition to x2APIC.  From the APM:

  A value previously written by software to the 8-bit APIC_ID register (MMIO offset
  30h) is converted by hardware into the appropriate format and reflected into the
  32-bit x2APIC_ID register (MSR 802h).

FWIW, my observations from testing on bare metal are that the xAPIC ID is effectively
read-only (writes are dropped) on Intel CPUs as far back as Haswell, while the above
behavior described in the APM holds true on at least Rome and Milan.

My guess is that Intel's uArch specific behavior of the xAPIC ID being read-only
was introduced when x2APIC came along, but I didn't test farther back than Haswell.
