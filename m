Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B3768340F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjAaRks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjAaRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:40:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F2144B8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675186798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w3FPeGg7hItnWxgo62PHoYeVD78xpshA0pZcr5VAtYY=;
        b=TdOId4JThv9XdKVDoVRTUxuptBnfY/OBvQNKpDm20uFS4xR/oubdvkt70ogVfa1rG85wf6
        okEZmPXA8u6dw65qqcXNZNZZwTLRw9lJCS5FWJFmzr/f9n9eDbcWeNmwNUGAGPFV9Xau9A
        GZVwLsSSNquySTGTAV2qL6qP824P9s4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-OiNtO8KzM2CnQ596OMrOFw-1; Tue, 31 Jan 2023 12:39:57 -0500
X-MC-Unique: OiNtO8KzM2CnQ596OMrOFw-1
Received: by mail-ed1-f69.google.com with SMTP id s3-20020a50ab03000000b0049ec3a108beso11051909edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3FPeGg7hItnWxgo62PHoYeVD78xpshA0pZcr5VAtYY=;
        b=NMCcEPogHQuTSrcFr1iGgiKBPgOjLrM89bjj8BPhsO4sRVoE6yfAjtkl8BWj4PF3Xi
         2n8etCPKlmPof7I8xwUGGFk7nayXxEEWbuoc22DG6f0r4CJxWD+gtansc3fdiLic/FVJ
         OhFwhebbXU/e0lV5HK5mC9MFSH11Pi4QSR2Gmx4EZrcvxyw6u5T8kPP+X/esz0zaXSlH
         q6pve0BXZ+PKzJg8lDq+t+BPodiN88ePOJkAyMMHgUJpp9mh6+CxnT9dzneKG2/ZJztf
         sKZfFPb5G7z6uw23TyvmgkdYQG6buw8FOpgOZkOpMpt2Psb2Y3U60hj+t59pwrUULN0W
         4TVg==
X-Gm-Message-State: AO0yUKXT4Q9E4T/wd9qIKuVVghNrVphK9DLknSddYVB0ZWeeZ9B31oGh
        xx6eSNghVh+dfd7v12NVfvakwPMd37BMRTm7BWc3eXrYdDgNwZopzZUEbTyursfDbCNxaIGnRpq
        5BBb98xLlyYQB7cj5mO17oxQ6
X-Received: by 2002:a05:6402:35c6:b0:46f:d386:117d with SMTP id z6-20020a05640235c600b0046fd386117dmr5019314edc.33.1675186796142;
        Tue, 31 Jan 2023 09:39:56 -0800 (PST)
X-Google-Smtp-Source: AK7set9ZPgbwWWTJbgUH+vDerGoDBXBQ/8n25BR+kRZY16ejwePSwXUQ1VHiheonNGFC8dalJpBx8Q==
X-Received: by 2002:a05:6402:35c6:b0:46f:d386:117d with SMTP id z6-20020a05640235c600b0046fd386117dmr5019279edc.33.1675186795943;
        Tue, 31 Jan 2023 09:39:55 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id ed10-20020a056402294a00b004a236384909sm4304467edb.10.2023.01.31.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:39:55 -0800 (PST)
Date:   Tue, 31 Jan 2023 12:39:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe de Dinechin <dinechin@redhat.com>
Cc:     jejb@linux.ibm.com, "Reshetova, Elena" <elena.reshetova@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20230131123033-mutt-send-email-mst@kernel.org>
References: <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9JyW5bUqV7gWmU8@unreal>
 <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
 <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
 <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
 <DM8PR11MB575074D3BCBD02F3DD677A57E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
 <261bc99edc43990eecb1aac4fe8005cedc495c20.camel@linux.ibm.com>
 <m2h6w6k5on.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2h6w6k5on.fsf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 04:14:29PM +0100, Christophe de Dinechin wrote:
> Finally, security considerations that apply irrespective of whether the
> platform is confidential or not are also outside of the scope of this
> document. This includes topics ranging from timing attacks to social
> engineering.

Why are timing attacks by hypervisor on the guest out of scope?

> </doc>
> 
> Feel free to comment and reword at will ;-)
> 
> 
> 3/ PCI-as-a-threat: where does that come from
> 
> Isn't there a fundamental difference, from a threat model perspective,
> between a bad actor, say a rogue sysadmin dumping the guest memory (which CC
> should defeat) and compromised software feeding us bad data? I think there
> is: at leats inside the TCB, we can detect bad software using measurements,
> and prevent it from running using attestation.  In other words, we first
> check what we will run, then we run it. The security there is that we know
> what we are running. The trust we have in the software is from testing,
> reviewing or using it.
> 
> This relies on a key aspect provided by TDX and SEV, which is that the
> software being measured is largely tamper-resistant thanks to memory
> encryption. In other words, after you have measured your guest software
> stack, the host or hypervisor cannot willy-nilly change it.
> 
> So this brings me to the next question: is there any way we could offer the
> same kind of service for KVM and qemu? The measurement part seems relatively
> easy. Thetamper-resistant part, on the other hand, seems quite difficult to
> me. But maybe someone else will have a brilliant idea?
> 
> So I'm asking the question, because if you could somehow prove to the guest
> not only that it's running the right guest stack (as we can do today) but
> also a known host/KVM/hypervisor stack, we would also switch the potential
> issues with PCI, MSRs and the like from "malicious" to merely "bogus", and
> this is something which is evidently easier to deal with.

Agree absolutely that's much easier.

> I briefly discussed this with James, and he pointed out two interesting
> aspects of that question:
> 
> 1/ In the CC world, we don't really care about *virtual* PCI devices. We
>    care about either virtio devices, or physical ones being passed through
>    to the guest. Let's assume physical ones can be trusted, see above.
>    That leaves virtio devices. How much damage can a malicious virtio device
>    do to the guest kernel, and can this lead to secrets being leaked?
> 
> 2/ He was not as negative as I anticipated on the possibility of somehow
>    being able to prevent tampering of the guest. One example he mentioned is
>    a research paper [1] about running the hypervisor itself inside an
>    "outer" TCB, using VMPLs on AMD. Maybe something similar can be achieved
>    with TDX using secure enclaves or some other mechanism?

Or even just secureboot based root of trust?

-- 
MST

