Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34867DE25
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjA0HC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjA0HCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:02:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E11E1D2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:02:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m7so4064275wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HxGtUHBeTmKLxMYYWaiGw2aHRBHP369koztMrMyiwA=;
        b=1vOE67AhAR9Wo70Q4blgMafsiy27P9P0INmEpVCMXsPf4nopeuS9PoJw3fHsyuiWqy
         3I0HRLM1CO0JRy8oXWqjVU4jCGT3a8JorOWM3j9jZxIbgB11V5V0T/LRMNXiZ+x4zAx0
         eBmJQ6k5fep/VBOfrEuTZn0vlRBnMETt9Ut/7Wj/X6OpA0kc44ymfUwY0pBt2yyS1Ttf
         cJQAfj3ITgSGBFJh7UHio91JkFPL/DlPil95KHb60f+WphUgF3KRYAn5Hq6S3f/KDdoJ
         b6uKzVW0M2RAJVXz96ahpAzDn4na76CzLjRsFAirKqyOpt7T62+p2VF1f7+5oFauQWXf
         fAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HxGtUHBeTmKLxMYYWaiGw2aHRBHP369koztMrMyiwA=;
        b=HVQDnZC8PfaIYkoysA3MJIGmEGm71gQVDpMO4mfxqFAGf7HL9XH9RbR0dMNK/L4K8A
         1NT1gVRB5GiqKlJTd0xIW++OYocR9iHR1iu4mOLhIaSL+zkvNDu9k6K+dljW+mK2M0zY
         oXR4DAH6pkvgdqP1UUctPwE6sef+hRgcjsg1Z0YD7J/n0+/zRXY07PuSHqB9F0ya76io
         lqF/ncU0x3g06wL8GhG3FdSaf28rONoDWwdpgQ2nGoFR5Zjn4pNZETtqkZ/aZaprpETx
         nY27YDoIznWapq0bfYk4oOFQDNvJNPIuh8Hq6W5eDdl12yPPq8Y4o1Qx6jUTHgJTKDnA
         xkwA==
X-Gm-Message-State: AO0yUKWvFqJYmN39YD8M27v4kCAHiSG2cW9/nj5BGzN02nfQhrltvyHh
        Y3GkfcOEHq5CWT73p1X+mCsduw==
X-Google-Smtp-Source: AK7set/yG7eIZMrhBqHR2aFSoxHMlaYJfh+r3x8BhUulxgeFR3o8g0ofaas4ktkgxbll+A+ZGmrE/w==
X-Received: by 2002:adf:a181:0:b0:2bf:ae42:9879 with SMTP id u1-20020adfa181000000b002bfae429879mr10453541wru.32.1674802940065;
        Thu, 26 Jan 2023 23:02:20 -0800 (PST)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d66c4000000b002bdc19f8e8asm3223843wrw.79.2023.01.26.23.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 23:02:19 -0800 (PST)
Date:   Fri, 27 Jan 2023 08:02:16 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9N2+Bsm0xLbLg5q@vermeer>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <20230125215333.GA18160@wunner.de>
 <CAGXJix9-cXNW7EwJf0PVzj_Qmt5fmQvBX1KvXfRX5NAeEpnMvw@mail.gmail.com>
 <20230126105847.00001b97@Huawei.com>
 <Y9J82eutqDkusRIq@vermeer>
 <20230126160729.00006843@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126160729.00006843@Huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 04:07:29PM +0000, Jonathan Cameron wrote:
> On Thu, 26 Jan 2023 14:15:05 +0100
> Samuel Ortiz <sameo@rivosinc.com> wrote:
> 
> > On Thu, Jan 26, 2023 at 10:58:47AM +0000, Jonathan Cameron wrote:
> > > On Thu, 26 Jan 2023 10:24:32 +0100
> > > Samuel Ortiz <sameo@rivosinc.com> wrote:
> > >   
> > > > Hi Lukas,
> > > > 
> > > > On Wed, Jan 25, 2023 at 11:03 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > >   
> > > > > [cc += Jonathan Cameron, linux-pci]
> > > > >
> > > > > On Wed, Jan 25, 2023 at 02:57:40PM +0000, Dr. David Alan Gilbert wrote:    
> > > > > > Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:    
> > > > > > > Great, so why not have hardware attestation also for your devices you
> > > > > > > wish to talk to?  Why not use that as well?  Then you don't have to
> > > > > > > worry about anything in the guest.    
> > > > > >
> > > > > > There were some talks at Plumbers where PCIe is working on adding that;
> > > > > > it's not there yet though.  I think that's PCIe 'Integrity and Data
> > > > > > Encryption' (IDE - sigh), and PCIe 'Security Prtocol and Data Model' -
> > > > > > SPDM.   I don't know much of the detail of those, just that they're far
> > > > > > enough off that people aren't depending on them yet.    
> > > > >
> > > > > CMA/SPDM (PCIe r6.0 sec 6.31) is in active development on this branch:
> > > > >
> > > > > https://github.com/l1k/linux/commits/doe    
> > > > 
> > > > Nice, thanks a lot for that.
> > > > 
> > > > 
> > > >   
> > > > > The device authentication service afforded here is generic.
> > > > > It is up to users and vendors to decide how to employ it,
> > > > > be it for "confidential computing" or something else.
> > > > >
> > > > > Trusted root certificates to validate device certificates can be
> > > > > installed into a kernel keyring using the familiar keyctl(1) utility,
> > > > > but platform-specific roots of trust (such as a HSM) could be
> > > > > supported as well.
> > > > >    
> > > > 
> > > > This may have been discussed at LPC, but are there any plans to also
> > > > support confidential computing flows where the host kernel is not part
> > > > of the TCB and would not be trusted for validating the device cert chain
> > > > nor for running the SPDM challenge?  
> > > 
> > > There are lots of possible models for this. One simple option if the assigned
> > > VF supports it is a CMA instance per VF. That will let the guest
> > > do full attestation including measurement of whether the device is
> > > appropriately locked down so the hypervisor can't mess with
> > > configuration that affects the guest (without a reset anyway and that
> > > is guest visible).   
> > 
> > So the VF would be directly assigned to the guest, and the guest kernel
> > would create a CMA instance for the VF, and do the SPDM authentication
> > (based on a guest provided trusted root certificate). I think one
> > security concern with that approach is assigning the VF to the
> > (potentially confidential) guest address space without the guest being
> > able to attest of the device trustworthiness first. That's what TDISP is
> > aiming at fixing (establish a secure SPDM between the confidential guest
> > and the device, lock the device from the guest, attest and then enable
> > DMA). 
> 
> Agreed, TDISP is more comprehensive, but also much more complex with
> more moving parts that we don't really have yet.
> 
> Depending on your IOMMU design (+ related stuff) and interaction with
> the secure guest, you might be able to block any rogue DMA until
> after attestation / lock down checks even if the Hypervisor was letting
> it through.

Provided that the guest or, in the TDX and AP-TEE cases, the TSM have
protected access to the IOMMU, yes. But then the implementation becomes
platform specific.

Cheers,
Samuel.
