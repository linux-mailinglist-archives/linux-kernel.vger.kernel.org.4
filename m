Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CD967E104
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjA0KF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjA0KFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:05:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7254FEF9E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674813860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7k+0JyRd7Jj4+JGuTlvRsODVs1VUz6inKc9+6lWrs4=;
        b=S02KutXOhJyybZ/MQoKOtcQ3L1VZPYAwCi/qtORzyb0ZxWRRaMTIT794M634VKr3Lbmlsy
        mPJnDJeZmny0qoQJkxw3o1EXDsZIIWHqUyCL2MWk4uhAvxwcywBsHFuVGlmCLdYCZ1mQ8b
        3Jka5EV1P1tAadWqS9cf256g9jmZb5w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-Y7-cBElBNG6dnVxx0kk99g-1; Fri, 27 Jan 2023 05:04:19 -0500
X-MC-Unique: Y7-cBElBNG6dnVxx0kk99g-1
Received: by mail-wm1-f69.google.com with SMTP id h2-20020a1ccc02000000b003db1ded176dso1209629wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7k+0JyRd7Jj4+JGuTlvRsODVs1VUz6inKc9+6lWrs4=;
        b=o0F6DkKDWHxwMKz+76pgppnvWEE7p67NwPfp65ByV++9AlMeP3VG/xSf/Ousp17qbB
         mdCQBgxAi+NEPVW/+i47JcE2GCFm12+eWP9nWVBqbxT8UlWp71eoJlCxe1pZffnpiCoE
         dB31RF7muDQh/H+9ehGrjB+S9zkbqz1ypu0smqK123Bn2aONfGJzCjFCtNApwYXar5ud
         4NggoW9ZBg1BinS3TmiT2K7ylHtaYBzDu9PlLZRrai1snM9OZGrxrG8tzIgNG4E49mNN
         wEVxdV0eVbPQ6VMUke0l3YfknyGnzD4y00eDJffGtYMic6tBplPbYa2bw8z/4fWVxSV5
         bVeA==
X-Gm-Message-State: AFqh2kpI0JoT1vSjLGqQuz/uQRqxfvSnT/No312FBdJ8j1RV5B5ztWAx
        1CzJYDmpexjQkIh8vR2IPThpqlfFyEBf977+hojYalJfQzxAn2kWPSm66lEJ6AaImkIAS4ouGb+
        IVxdBPN8mMU/Fe1m+iPuZ/e/m
X-Received: by 2002:a05:600c:a52:b0:3db:122c:1638 with SMTP id c18-20020a05600c0a5200b003db122c1638mr34649460wmq.27.1674813858158;
        Fri, 27 Jan 2023 02:04:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvJqy11IfUQQTbG2B8vHqiaJJ8gQRORP7iVkIPKkozNg7BhdJTGN3sIDmVxrNgk1mSSJzu9FA==
X-Received: by 2002:a05:600c:a52:b0:3db:122c:1638 with SMTP id c18-20020a05600c0a5200b003db122c1638mr34649436wmq.27.1674813857820;
        Fri, 27 Jan 2023 02:04:17 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003daf7721bb3sm6790156wmi.12.2023.01.27.02.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:04:17 -0800 (PST)
Date:   Fri, 27 Jan 2023 05:04:12 -0500
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
Message-ID: <20230127044508-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20230126105618-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750678B5F639F6C2848FC3CE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB5750678B5F639F6C2848FC3CE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:52:22AM +0000, Reshetova, Elena wrote:
> > On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena wrote:
> > > And this is a very special aspect of 'hardening' since it is about hardening a
> > kernel
> > > under different threat model/assumptions.
> > 
> > I am not sure it's that special in that hardening IMHO is not a specific
> > threat model or a set of assumptions. IIUC it's just something that
> > helps reduce severity of vulnerabilities.  Similarly, one can use the CC
> > hardware in a variety of ways I guess. And one way is just that -
> > hardening linux such that ability to corrupt guest memory does not
> > automatically escalate into guest code execution.
> 
> I am not sure if I fully follow you on this. I do agree that it is in principle
> the same 'hardening' that we have been doing in Linux for decades just
> applied to a new attack surface, host <-> guest, vs userspace <->kernel.

Sorry about being unclear this is not the type of hardening I meant
really.  The "hardening" you meant is preventing kernel vulnerabilities,
right? This is what we've been doing for decades.
But I meant slightly newer things like e.g. KASLR or indeed ASLR generally -
we are trying to reduce a chance a vulnerability causes random
code execution as opposed to a DOS. To think in these terms you do not
need to think about attack surfaces - in the system including
a hypervisor, guest supervisor and guest userspace hiding
one component from others is helpful even if they share
a privelege level.



> Interfaces have changed, but the types of vulnerabilities, etc are the same.
> The attacker model is somewhat different because we have 
> different expectations on what host/hypervisor should be able to do
> to the guest (following business reasons and use-cases), versus what we
> expect normal userspace being able to "do" towards kernel. The host and
> hypervisor still has a lot of control over the guest (ability to start/stop it, 
> manage its resources, etc). But the reasons behind this doesn’t come
> from the fact that security CoCo HW not being able to support this stricter
> security model (it cannot now indeed, but this is a design decision), but
> from the fact that it is important for Cloud service providers to retain that
> level of control over their infrastructure. 

Surely they need ability to control resource usage, not ability to execute DOS
attacks. Current hardware just does not have ability to allow the former
without the later.

> > 
> > If you put it this way, you get to participate in a well understood
> > problem space instead of constantly saying "yes but CC is special".  And
> > further, you will now talk about features as opposed to fixing bugs.
> > Which will stop annoying people who currently seem annoyed by the
> > implication that their code is buggy simply because it does not cache in
> > memory all data read from hardware. Finally, you then don't really need
> > to explain why e.g. DoS is not a problem but info leak is a problem - when
> > for many users it's actually the reverse - the reason is not that it's
> > not part of a threat model - which then makes you work hard to define
> > the threat model - but simply that CC hardware does not support this
> > kind of hardening.
> 
> But this won't be correct statement, because it is not limitation of HW, but the
> threat and business model that Confidential Computing exists in. I am not 
> aware of a single cloud provider who would be willing to use the HW that
> takes the full control of their infrastructure and running confidential guests,
> leaving them with no mechanisms to control the load balancing, enforce
> resource usage, etc. So, given that nobody needs/willing to use such HW, 
> such HW simply doesn’t exist. 
> 
> So, I would still say that the model we operate in CoCo usecases is somewhat
> special, but I do agree that given that we list a couple of these special assumptions
> (over which ones we have no control or ability to influence, none of us are business
> people), then the rest becomes just careful enumeration of attack surface interfaces
> and break up of potential mitigations. 
> 
> Best Regards,
> Elena.
> 

I'd say each business has a slightly different business model, no?
Finding common ground is what helps us share code ...

-- 
MST

