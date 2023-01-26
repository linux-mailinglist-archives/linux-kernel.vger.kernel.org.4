Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B12C67D3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjAZSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjAZSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:16:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587135D123
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674756874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5S/IPLvFZLK6QG2ma4MFBOIajGhBXPdcBBlNU5N+t1g=;
        b=IgShnDGkuN6xxryNcdyX8kXrVtrde9EsLYFgFC4ey4fyQPU61gAT1ZXPCCfcb/fCS0d9fW
        kk7UDL/FFGVSCJT/7+XO3G5fujKn5SkkbyTVtRI1PUnlk6VRXdNld7iz7reJUBjG00fk4u
        fBdrWVw9PKAIAB6ztVfwcn6ZeR4qkh8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-JX81jp1UN52zmD0kwnwEPg-1; Thu, 26 Jan 2023 13:14:32 -0500
X-MC-Unique: JX81jp1UN52zmD0kwnwEPg-1
Received: by mail-wm1-f71.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso1439113wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5S/IPLvFZLK6QG2ma4MFBOIajGhBXPdcBBlNU5N+t1g=;
        b=IoH9drl4lZLWDxzmUMpYKDzRn9Dp85VHGOydAj2UKdUREpAM9UKEpw6bEt4NILnPBd
         bxGmyrH37Jr5oZRSXGXpzU9/6EIMSjg0zQ+K3jOZnr3jOcv1Qh1NnEgjA6I22QcADzVO
         eIgfggseHODmI1Rc8EScn28JukF5WXl8LaTJmowp3FXhgmr7WKr5ym+u8dsb2oTURPub
         Uz6KC9w7IjUziY49Nm0l+ipPt7gurqEZWgN7uuxn62YGKHollwC1NFhRMgtrB4uNe1OP
         4gYG1pxbBfrtZE109L+/7po9Jz1hs/CGgatjK0K2q7WzXmDwwoh3Ud8L4iu+/jrmtHp6
         Dnkw==
X-Gm-Message-State: AO0yUKV5FAyt+Zq/7V5TenF7ib0wA/hYAe2Awy/Xnq23WBkOaNQg4vdl
        setHwCQJ384T8iK0JhHXuqnpZCCghBzPYZYBoEoTF8b74jBtUgR+2c97/rBEEcUH8aQJWrv9THL
        EBNyUayDNCYGmKcCDk4uOJydq
X-Received: by 2002:adf:ea08:0:b0:2bf:c403:c485 with SMTP id q8-20020adfea08000000b002bfc403c485mr3235697wrm.22.1674756871769;
        Thu, 26 Jan 2023 10:14:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/v0QimrbymbFXNOuSiw5JWllqKT6tFjROtZrYqeP4lNCZp9Va24F1ABNqqf5dKg+eSvg7yxg==
X-Received: by 2002:adf:ea08:0:b0:2bf:c403:c485 with SMTP id q8-20020adfea08000000b002bfc403c485mr3235680wrm.22.1674756871526;
        Thu, 26 Jan 2023 10:14:31 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id e38-20020a05600c4ba600b003db11dfc687sm2058340wmp.36.2023.01.26.10.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 10:14:31 -0800 (PST)
Date:   Thu, 26 Jan 2023 18:14:28 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
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
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9LDBKXMwoGrACLZ@work-vm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9KG6g0CHlnKwuW+@work-vm>
 <DM8PR11MB57509016CEF6C939DCBD718FE7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9LBInM4uBNCSMDT@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9LBInM4uBNCSMDT@unreal>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Leon Romanovsky (leon@kernel.org) wrote:
> On Thu, Jan 26, 2023 at 05:48:33PM +0000, Reshetova, Elena wrote:
> > 
> > > * Reshetova, Elena (elena.reshetova@intel.com) wrote:
> > > > > On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena wrote:
> > > > > > Replying only to the not-so-far addressed points.
> > > > > >
> > > > > > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > > > > > > Hi Greg,
> > > > >
> > > > > <...>
> > > > >
> > > > > > > > 3) All the tools are open-source and everyone can start using them right
> > > > > away
> > > > > > > even
> > > > > > > > without any special HW (readme has description of what is needed).
> > > > > > > > Tools and documentation is here:
> > > > > > > > https://github.com/intel/ccc-linux-guest-hardening
> > > > > > >
> > > > > > > Again, as our documentation states, when you submit patches based on
> > > > > > > these tools, you HAVE TO document that.  Otherwise we think you all are
> > > > > > > crazy and will get your patches rejected.  You all know this, why ignore
> > > > > > > it?
> > > > > >
> > > > > > Sorry, I didn’t know that for every bug that is found in linux kernel when
> > > > > > we are submitting a fix that we have to list the way how it has been found.
> > > > > > We will fix this in the future submissions, but some bugs we have are found
> > > by
> > > > > > plain code audit, so 'human' is the tool.
> > > > >
> > > > > My problem with that statement is that by applying different threat
> > > > > model you "invent" bugs which didn't exist in a first place.
> > > > >
> > > > > For example, in this [1] latest submission, authors labeled correct
> > > > > behaviour as "bug".
> > > > >
> > > > > [1] https://lore.kernel.org/all/20230119170633.40944-1-
> > > > > alexander.shishkin@linux.intel.com/
> > > >
> > > > Hm.. Does everyone think that when kernel dies with unhandled page fault
> > > > (such as in that case) or detection of a KASAN out of bounds violation (as it is in
> > > some
> > > > other cases we already have fixes or investigating) it represents a correct
> > > behavior even if
> > > > you expect that all your pci HW devices are trusted? What about an error in
> > > two
> > > > consequent pci reads? What about just some failure that results in erroneous
> > > input?
> > > 
> > > I'm not sure you'll get general agreement on those answers for all
> > > devices and situations; I think for most devices for non-CoCo
> > > situations, then people are generally OK with a misbehaving PCI device
> > > causing a kernel crash, since most people are running without IOMMU
> > > anyway, a misbehaving device can cause otherwise undetectable chaos.
> > 
> > Ok, if this is a consensus within the kernel community, then we can consider
> > the fixes strictly from the CoCo threat model point of view. 
> > 
> > > 
> > > I'd say:
> > >   a) For CoCo, a guest (guaranteed) crash isn't a problem - CoCo doesn't
> > >   guarantee forward progress or stop the hypervisor doing something
> > >   truly stupid.
> > 
> > Yes, denial of service is out of scope but I would not pile all crashes as
> > 'safe' automatically. Depending on the crash, it can be used as a
> > primitive to launch further attacks: privilege escalation, information
> > disclosure and corruption. It is especially true for memory corruption
> > issues. 
> > 
> > >   b) For CoCo, information disclosure, or corruption IS a problem
> > 
> > Agreed, but the path to this can incorporate a number of attack 
> > primitives, as well as bug chaining. So, if the bug is detected, and
> > fix is easy, instead of thinking about possible implications and its 
> > potential usage in exploit writing, safer to fix it.
> > 
> > > 
> > >   c) For non-CoCo some people might care about robustness of the kernel
> > >   against a failing PCI device, but generally I think they worry about
> > >   a fairly clean failure, even in the unexpected-hot unplug case.
> > 
> > Ok.
> 
> With my other hat as a representative of hardware vendor (at least for
> NIC part), who cares about quality of our devices, we don't want to hide
> ANY crash related to our devices, especially if it is related to misbehaving
> PCI HW logic. Any uncontrolled "robustness" hides real issues and makes
> QA/customer support much harder.

Yeh if you're adding new code to be more careful, you want the code to
fail/log the problem, not hide it.
(Although heck, I suspect there are a million apparently working PCI
cards out there that break some spec somewhere).

Dave

> Thanks
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

