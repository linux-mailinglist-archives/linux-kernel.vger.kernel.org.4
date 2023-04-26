Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3906EF7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbjDZPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbjDZPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:51:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AEF768F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:51:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b992ab82e0dso12171396276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682524305; x=1685116305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt+i8LH5Ee/86XlD/GvhwF0Xorz3qEvFe+jrqA/tbnw=;
        b=KYaLgMgIofy8doMOGV3T40pfYWfxJfZz7xSUexzlDW3/yaWyswvKdf9Lsi3GNP3hJe
         Lrp3OhRkwWOeEaZqL974ldY2IAFZy7lN/U0gxhjB5EO7Ff0hzzMaiYU0eaCRz6gYvgU5
         khtGGStFIyXsmhns30fYSspDeRZ1M7k8Z+9TSf06a1lhx8gmAqBN71rRlOM66h7Q29pB
         D2ba1COpwIBEvnOanwA2uE2zjMDNPrfzaD9BnmwP30xWp+ZnvqaSlyzOlz6nf6Zi0TzT
         Xd0EIX+GFL+fvfTbWasDcf4aVPSoWnkqQvtAeZc1rjnBN5NjzDZ7IdU01oieF0/BKefk
         DpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682524305; x=1685116305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt+i8LH5Ee/86XlD/GvhwF0Xorz3qEvFe+jrqA/tbnw=;
        b=DNy791X6OY16RHzxZM1KQwU2NRvHkpw+GgA0E1hTBG4Y7pYagGnP8BXhwrzWX79Fx6
         31oQJHctCMV2K4NwWsSdxI675Pbojxvx2HZDi8SLu5zoWHTxxiw683FjzClPrR2clHbQ
         KuEhVI6fLzFjPXGN7wEkhcJc2IXtMP8c8JO4vRcqbteehejrD2oUGm2Ztj0QTA8n+Zhd
         pB9sQmxIES64sD7wNmzZMhLg1j1s1ArJYITNQhz+rpFpuRqE86sc4sEzCRRF55eQd/nc
         KgzKdlcwIO2QkyzKf76fMJZL9kKOuL7dGpNoUT04DAgHsNprE2ewgJ681ri+i/VWrT2W
         Pr+w==
X-Gm-Message-State: AAQBX9fRTaEG/OlvUmh7H933zA4RzqRw/w5rxHVlH4QmoevaNdMlJLU0
        RG4OjJwmPRyKyvgRFu82xYKaeByDEHM=
X-Google-Smtp-Source: AKy350bQSeEbGxa0I13OrG6lpC28tD4qzwkMsf1H0dHqDSg/uj/Z/ljDULCojGtmgxGygRFPk/cD4OhUlps=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c905:0:b0:b8f:6b3b:8a0a with SMTP id
 z5-20020a25c905000000b00b8f6b3b8a0amr12067601ybf.6.1682524305065; Wed, 26 Apr
 2023 08:51:45 -0700 (PDT)
Date:   Wed, 26 Apr 2023 08:51:43 -0700
In-Reply-To: <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com>
Mime-Version: 1.0
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com> <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com>
Message-ID: <ZElIjw7Ca6N2mYHe@google.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat model
From:   Sean Christopherson <seanjc@google.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023, Carlos Bilbao wrote:
> Hello Sean,
> 
> On 4/26/23 8:32 AM, Reshetova, Elena wrote:
> >  Hi Sean, 
> > 
> > Thank you for your review! Please see my comments inline. 
> > 
> >> On Mon, Mar 27, 2023, Carlos Bilbao wrote:

...

> >>> More details on the x86-specific solutions can be
> >>> +found in
> >>> +:doc:`Intel Trust Domain Extensions (TDX) </x86/tdx>` and
> >>> +:doc:`AMD Memory Encryption </x86/amd-memory-encryption>`.
> >>
> >> So by the above definition, vanilla SEV and SEV-ES can't be considered CoCo.  SEV
> >> doesn't provide anything besides increased confidentiality of guest memory, and
> >> SEV-ES doesn't provide integrity or validation of physical page assignment.
> >>
> > 
> > Same
> >
> 
> Personally, I think it's reasonable to mention SEV/SEV-ES in the context of
> confidential computing and acknowledge their relevance in this area.
> 
> But there is no mention to SEV or SEV-ES in this draft. And the document we
> reference there covers AMD-SNP, which provides integrity.

...

> >>> +While the traditional hypervisor has unlimited access to guest data and
> >>> +can leverage this access to attack the guest, the CoCo systems mitigate
> >>> +such attacks by adding security features like guest data confidentiality
> >>> +and integrity protection. This threat model assumes that those features
> >>> +are available and intact.
> >>
> >> Again, if you're claiming integrity is a key tenant, then SEV and SEV-ES can't be
> >> considered CoCo.
> 
> Again, nobody mentioned SEV/SEV-ES here.

Yes, somebody did.  Unless your dictionary has a wildly different definition for
"all".

 : +Overview and terminology
 : +========================
 : +
 : +Confidential Cloud Computing (CoCo) refers to a set of HW and SW
 : +virtualization technologies that allow Cloud Service Providers (CSPs) to
 : +provide stronger security guarantees to their clients (usually referred to
 : +as tenants) by excluding all the CSP's infrastructure and SW out of the
 : +tenant's Trusted Computing Base (TCB).
 : +
 : +While the concrete implementation details differ between technologies, all
                                                                           ^^^
 : +of these mechanisms provide increased confidentiality and integrity of CoCo
 : +guest memory and execution state (vCPU registers), more tightly controlled
 : +guest interrupt injection, as well as some additional mechanisms to control
 : +guest-host page mapping. More details on the x86-specific solutions can be
 : +found in

This document is named confidential-computing.rst, not tdx-and-snp.rst.  Not
explicitly mentioning SEV doesn't magically warp reality to make descriptions like
this one from security/secrets/coco.rst disappear:

  Introduction                                                                    
  ============                                                                    
                                                                                
  Confidential Computing (coco) hardware such as AMD SEV (Secure Encrypted        
  Virtualization) allows guest owners to inject secrets into the VMs              
  memory without the host/hypervisor being able to read them.

My complaint about this document being too Intel/AMD centric isn't that it doesn't
mention other implementations, it's that the doc describes CoCo purely from the
narrow viewpoint of Intel TDX and AMD SNP, and to be blunt, reads like a press
release and not an objective overview of CoCo.
