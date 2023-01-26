Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5C67CD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjAZN7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjAZN7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48159988
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674741488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0NzERiZZJGCAkZaTLp1domqOWjoThIpg30kpPJKWMo=;
        b=Z8Nlk8xkTiVK8PlFmH/lNeVCWqPYfd2d12xIQvmBTLrf3o0kMkPW3nS1Ptjg6Jc6qLXRCd
        y73sh7ImMmlGxypRMoweYcshAbf2Q98rUH5C6pbbTBKMv4w5KFx+ZfgDsusvuwlFapjWyM
        H0+BUckQ042Kva579iuOQWJD8IzACdo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-277-OrogVH02MJyLBpTjWf-1kQ-1; Thu, 26 Jan 2023 08:58:06 -0500
X-MC-Unique: OrogVH02MJyLBpTjWf-1kQ-1
Received: by mail-wm1-f71.google.com with SMTP id ay38-20020a05600c1e2600b003da7c41fafcso2849943wmb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0NzERiZZJGCAkZaTLp1domqOWjoThIpg30kpPJKWMo=;
        b=z7dr7p5OAskP5fF5UyGKCeMyJMLMd0gTE7yFh5FLRse+3gjY69FWqsJt7M5wmixenS
         Je0oiY4ZfBVRGNNwWIvVP2+S1N5kXhcmUU1/hSzZOUGgJJhsLC84FYFrVR89xupCwlKN
         V4tz87tVMTj6cl6NgViOeUkCIiIOU+cz7MJbT7hOXPvZ05ylVfshR6iRAas0XqfDEp2d
         u4Jxq9TSFXgAVJgVONKWezcMk34PqPKIfQ+CLD19ko4Kg5RG+pKPKH2YA342Fjary0JI
         Tp8aQUq+1jV6DrFrAGHMlCiqBvYL/t6RNtHcOfDpJZXPktoPY2iTJ48ubhQL4PlS81VL
         CVsQ==
X-Gm-Message-State: AFqh2kqlsmvDPl045SsVOf3b04TH2tDaZiw0GmvM5DOdHc9cHYYMA7F5
        lyCz2aIPjjIlMDHhbmph0z7+GuH4Rj6EOA0XzBeH4qRkHmgimaF3IlkSmVaUpJlYAxbPiYdnme3
        CAVrDecmrOy7aR7M5xBDCZCdb
X-Received: by 2002:a05:6000:1b83:b0:2be:34f5:ac05 with SMTP id r3-20020a0560001b8300b002be34f5ac05mr25116502wru.0.1674741485529;
        Thu, 26 Jan 2023 05:58:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtlfKk39QIucgkeq56V++rcPtefVDWtus3l9sNA/xIhsBFjF2sEE7lcJeosUhyIVDqk2W2mNg==
X-Received: by 2002:a05:6000:1b83:b0:2be:34f5:ac05 with SMTP id r3-20020a0560001b8300b002be34f5ac05mr25116492wru.0.1674741485326;
        Thu, 26 Jan 2023 05:58:05 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d6d8f000000b002bfb37497a8sm1591489wrs.31.2023.01.26.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:58:04 -0800 (PST)
Date:   Thu, 26 Jan 2023 13:58:02 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <Y9KG6g0CHlnKwuW+@work-vm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
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

* Reshetova, Elena (elena.reshetova@intel.com) wrote:
> > On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena wrote:
> > > Replying only to the not-so-far addressed points.
> > >
> > > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > > > Hi Greg,
> > 
> > <...>
> > 
> > > > > 3) All the tools are open-source and everyone can start using them right
> > away
> > > > even
> > > > > without any special HW (readme has description of what is needed).
> > > > > Tools and documentation is here:
> > > > > https://github.com/intel/ccc-linux-guest-hardening
> > > >
> > > > Again, as our documentation states, when you submit patches based on
> > > > these tools, you HAVE TO document that.  Otherwise we think you all are
> > > > crazy and will get your patches rejected.  You all know this, why ignore
> > > > it?
> > >
> > > Sorry, I didn’t know that for every bug that is found in linux kernel when
> > > we are submitting a fix that we have to list the way how it has been found.
> > > We will fix this in the future submissions, but some bugs we have are found by
> > > plain code audit, so 'human' is the tool.
> > 
> > My problem with that statement is that by applying different threat
> > model you "invent" bugs which didn't exist in a first place.
> > 
> > For example, in this [1] latest submission, authors labeled correct
> > behaviour as "bug".
> > 
> > [1] https://lore.kernel.org/all/20230119170633.40944-1-
> > alexander.shishkin@linux.intel.com/
> 
> Hm.. Does everyone think that when kernel dies with unhandled page fault 
> (such as in that case) or detection of a KASAN out of bounds violation (as it is in some
> other cases we already have fixes or investigating) it represents a correct behavior even if
> you expect that all your pci HW devices are trusted? What about an error in two 
> consequent pci reads? What about just some failure that results in erroneous input? 

I'm not sure you'll get general agreement on those answers for all
devices and situations; I think for most devices for non-CoCo
situations, then people are generally OK with a misbehaving PCI device
causing a kernel crash, since most people are running without IOMMU
anyway, a misbehaving device can cause otherwise undetectable chaos.

I'd say:
  a) For CoCo, a guest (guaranteed) crash isn't a problem - CoCo doesn't
  guarantee forward progress or stop the hypervisor doing something
  truly stupid.

  b) For CoCo, information disclosure, or corruption IS a problem

  c) For non-CoCo some people might care about robustness of the kernel
  against a failing PCI device, but generally I think they worry about
  a fairly clean failure, even in the unexpected-hot unplug case.

  d) It's not clear to me what 'trust' means in terms of CoCo for a PCIe
  device; if it's a device that attests OK and we trust it is the device
  it says it is, do we give it freedom or are we still wary?

Dave


> Best Regards,
> Elena.
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

