Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988AA67E856
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjA0Odr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjA0Odp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBF313DC0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674829978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiteAAyoqy6B4ia/ir952V9ZLvHxG4HoXe39f/WCgz8=;
        b=hErFva8sn1zlOYl+cUVcB5MrqxtstSiJ1ZXCZDDarHKsmZcfizBmMiil5p9fedjDmxHM+2
        d4jsdoOEeEMT6hlsfL+I6q+tX+lYFwSQH27CeQDjhOEMrLXmjyyFfIpWsZhiMyHAoYPQBS
        3UTSCxn+gUPvFujeq4rovaSR+zJGwjw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-119--G_RjjU9PW-gJrj3xXQkKQ-1; Fri, 27 Jan 2023 09:32:56 -0500
X-MC-Unique: -G_RjjU9PW-gJrj3xXQkKQ-1
Received: by mail-wm1-f72.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso2871500wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiteAAyoqy6B4ia/ir952V9ZLvHxG4HoXe39f/WCgz8=;
        b=d51VVzSZrjg5RrHZjLhNo28M/iumz8fzN4FvfuhTPBe4QlJ5Ld3O1a0KJpEyfpoQ9K
         BeThR73RVMpEhc8bTTuo1unxlB7LRewihe42LjEBBeYHjtSwH5sRGxu9Kw3iqxKaiJd1
         AFRnoK/+GIXgCtZEXtFaVYTgBLlW+ghg/N6DYTYcXMIQT61lBRYd44UhL8tcSCQzgUby
         EwrjRbmbVnTVs5oE5kufhniTNwQ276ggRlZ08TD4Q2FkRhkz6OtNhWmaXgaUtCvAFzuB
         u9GOcrrejh+VLUCcM3iN0fcaoQiyQBEi+TP5sivAMAFz5yMSFwc3eXXgtbYTZ+mZSYLP
         yNnA==
X-Gm-Message-State: AO0yUKWNoP1ZebutGOJSFBinZUGeE3btCrDPYeCb1hJrPtlVuzPr/WYP
        Buw2HyVXzCdy1L+h8KE8S0EplYqJ3GXBgiyBMknYV9lGbvUko7qcxd6JfILpOXUQn3Ss+Sai9vi
        ueIVreVCN5FNy6EUlhJIjzwy3
X-Received: by 2002:adf:f286:0:b0:2bf:b5ea:8d66 with SMTP id k6-20020adff286000000b002bfb5ea8d66mr10337090wro.16.1674829975030;
        Fri, 27 Jan 2023 06:32:55 -0800 (PST)
X-Google-Smtp-Source: AK7set9kCnrVbQx6w9vIuIil/TAg2GquVBNkZQMzfOP10T7nbBDZHBAiZ6L43hHXRzeYqeZGjrrtnQ==
X-Received: by 2002:adf:f286:0:b0:2bf:b5ea:8d66 with SMTP id k6-20020adff286000000b002bfb5ea8d66mr10337081wro.16.1674829974746;
        Fri, 27 Jan 2023 06:32:54 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b002bc7f64efa3sm4043995wrr.29.2023.01.27.06.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:32:53 -0800 (PST)
Date:   Fri, 27 Jan 2023 09:32:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Message-ID: <20230127090526-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20230126105618-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750678B5F639F6C2848FC3CE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20230127044508-mutt-send-email-mst@kernel.org>
 <DM8PR11MB57501BD39CC1E88206E6CD5FE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB57501BD39CC1E88206E6CD5FE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:25:09PM +0000, Reshetova, Elena wrote:
> 
> > On Fri, Jan 27, 2023 at 08:52:22AM +0000, Reshetova, Elena wrote:
> > > > On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena wrote:
> > > > > And this is a very special aspect of 'hardening' since it is about hardening a
> > > > kernel
> > > > > under different threat model/assumptions.
> > > >
> > > > I am not sure it's that special in that hardening IMHO is not a specific
> > > > threat model or a set of assumptions. IIUC it's just something that
> > > > helps reduce severity of vulnerabilities.  Similarly, one can use the CC
> > > > hardware in a variety of ways I guess. And one way is just that -
> > > > hardening linux such that ability to corrupt guest memory does not
> > > > automatically escalate into guest code execution.
> > >
> > > I am not sure if I fully follow you on this. I do agree that it is in principle
> > > the same 'hardening' that we have been doing in Linux for decades just
> > > applied to a new attack surface, host <-> guest, vs userspace <->kernel.
> > 
> > Sorry about being unclear this is not the type of hardening I meant
> > really.  The "hardening" you meant is preventing kernel vulnerabilities,
> > right? This is what we've been doing for decades.
> > But I meant slightly newer things like e.g. KASLR or indeed ASLR generally -
> > we are trying to reduce a chance a vulnerability causes random
> > code execution as opposed to a DOS. To think in these terms you do not
> > need to think about attack surfaces - in the system including
> > a hypervisor, guest supervisor and guest userspace hiding
> > one component from others is helpful even if they share
> > a privelege level.
> 
> Do you mean that the fact that CoCo guest has memory encrypted
> can help even in non-CoCo scenarios?

Yes.

> I am sorry, I still seem not to be able
> to grasp your idea fully. When the privilege level is shared, there is no
> incentive to perform privilege escalation attacks across components,
> so why hide them from each other?

Because limiting horisontal movement between components is still valuable.

> Data protection? But I don’t think you
> are talking about this? I do agree that KASLR is stronger when you remove
> the possibility to read the memory (make sure kernel code is execute only)
> you are trying to attack, but again not sure if you mean this. 

It's an example. If kernel was 100% secure we won't need KASLR. Nothing
ever is though.

> > 
> > 
> > 
> > > Interfaces have changed, but the types of vulnerabilities, etc are the same.
> > > The attacker model is somewhat different because we have
> > > different expectations on what host/hypervisor should be able to do
> > > to the guest (following business reasons and use-cases), versus what we
> > > expect normal userspace being able to "do" towards kernel. The host and
> > > hypervisor still has a lot of control over the guest (ability to start/stop it,
> > > manage its resources, etc). But the reasons behind this doesn’t come
> > > from the fact that security CoCo HW not being able to support this stricter
> > > security model (it cannot now indeed, but this is a design decision), but
> > > from the fact that it is important for Cloud service providers to retain that
> > > level of control over their infrastructure.
> > 
> > Surely they need ability to control resource usage, not ability to execute DOS
> > attacks. Current hardware just does not have ability to allow the former
> > without the later.
> 
> I don’t see why it cannot be added to HW if requirement comes. However, I think 
> in cloud provider world being able to control resources equals to being able
> to deny these resources when required, so being able to denial of service its clients
> is kind of build-in expectation that everyone just agrees on.  
> 
> > 
> > > >
> > > > If you put it this way, you get to participate in a well understood
> > > > problem space instead of constantly saying "yes but CC is special".  And
> > > > further, you will now talk about features as opposed to fixing bugs.
> > > > Which will stop annoying people who currently seem annoyed by the
> > > > implication that their code is buggy simply because it does not cache in
> > > > memory all data read from hardware. Finally, you then don't really need
> > > > to explain why e.g. DoS is not a problem but info leak is a problem - when
> > > > for many users it's actually the reverse - the reason is not that it's
> > > > not part of a threat model - which then makes you work hard to define
> > > > the threat model - but simply that CC hardware does not support this
> > > > kind of hardening.
> > >
> > > But this won't be correct statement, because it is not limitation of HW, but the
> > > threat and business model that Confidential Computing exists in. I am not
> > > aware of a single cloud provider who would be willing to use the HW that
> > > takes the full control of their infrastructure and running confidential guests,
> > > leaving them with no mechanisms to control the load balancing, enforce
> > > resource usage, etc. So, given that nobody needs/willing to use such HW,
> > > such HW simply doesn’t exist.
> > >
> > > So, I would still say that the model we operate in CoCo usecases is somewhat
> > > special, but I do agree that given that we list a couple of these special
> > assumptions
> > > (over which ones we have no control or ability to influence, none of us are
> > business
> > > people), then the rest becomes just careful enumeration of attack surface
> > interfaces
> > > and break up of potential mitigations.
> > >
> > > Best Regards,
> > > Elena.
> > >
> > 
> > I'd say each business has a slightly different business model, no?
> > Finding common ground is what helps us share code ...
> 
> Fully agree, and a good discussion with everyone willing to listen and cooperate
> can go a long way into defining the best implementation. 
> 
> Best Regards,
> Elena. 

Right. My point was that trying to show how CC usecases are similar to other
existing ones will be more helpful for everyone than just focusing on how they
are different. I hope I was able to show some similarities.

-- 
MST

