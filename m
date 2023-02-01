Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B229B686B10
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjBAQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjBAQDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:03:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB05A3AB8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675267354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EElzE8+e1kmP7S3k+GEUsksfz7cKl253GIZfZ0NLa3M=;
        b=P2PvdQzXU42h35TEZPRKXdiC9qCdiDdWESF9t06RjLkprIH4szTdPuHg4o951klU35nvvA
        jKLqQ9cDgLfXuOSeTk0VDX90vWET1O2xFOm7idSoGM9xbQNf9m9SoyysysWlzXaB++X9F7
        yL/KEPTLi0JworrIebBriHH5C7Cw1Ag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-td_2H3-_N8qgviyfdjloWw-1; Wed, 01 Feb 2023 11:02:18 -0500
X-MC-Unique: td_2H3-_N8qgviyfdjloWw-1
Received: by mail-wm1-f70.google.com with SMTP id l19-20020a7bc353000000b003dc554c8263so5757290wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 08:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EElzE8+e1kmP7S3k+GEUsksfz7cKl253GIZfZ0NLa3M=;
        b=HgKLuiLTB8y81U+60sErvaPqud5M/24zlbscges+/sdSNHEMRRW+dfUgRLWxozFZKp
         T5SqVFvrMp52RuFjnJyLeG6eZ+jjLCa4HgJ06PgrKyVqX2U9ZgA/DUaXtyUti8yx9MbG
         ZdKLfkDFdSLoqLbvSBa5Gtn1irSbceCcRuqVrDcEtaQ8KoIKOas49vvGgjVncTxtWIPW
         u4pcub1TZ0cBVRn0gQQXWdzgZqeGxrPAF489SjPjTl3VtAttOdgGkDmaWsd70yDFptrw
         u74i2+LFj0fvIQlZgHKGoR2UZTYibFdbnAZhYNZ2wpmXuhpUNpqqsNJGyoFpNF5T/NSl
         6xkQ==
X-Gm-Message-State: AO0yUKU86MccQmPENutl0dy7Lf1CxAX1ZUeYijJHKgeKzX+bdpYyPhhi
        JmReLRmwsP29N1tIc5HoZ8buY1s3F59vG8qgt+7r1jspf3G8ehqnGnH7ZfrHVBRPZs8dZIkOali
        NbMT7yiitJ68yFRT/kj82uvE3
X-Received: by 2002:adf:fd88:0:b0:2bf:5dc0:56c8 with SMTP id d8-20020adffd88000000b002bf5dc056c8mr2253282wrr.51.1675267336905;
        Wed, 01 Feb 2023 08:02:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/cViVu8qXP79IJNXkXkroLfOIDkTqq67u9Yp+KKjFvc+/ficndq3vQOcHptFk86I0MldWauA==
X-Received: by 2002:adf:fd88:0:b0:2bf:5dc0:56c8 with SMTP id d8-20020adffd88000000b002bf5dc056c8mr2253258wrr.51.1675267336661;
        Wed, 01 Feb 2023 08:02:16 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id r25-20020adfa159000000b00297dcfdc90fsm18127882wrr.24.2023.02.01.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:02:15 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:02:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe de Dinechin Dupont de Dinechin <cdupontd@redhat.com>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <20230201105305-mutt-send-email-mst@kernel.org>
References: <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
 <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
 <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
 <DM8PR11MB575074D3BCBD02F3DD677A57E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
 <261bc99edc43990eecb1aac4fe8005cedc495c20.camel@linux.ibm.com>
 <m2h6w6k5on.fsf@redhat.com>
 <20230131123033-mutt-send-email-mst@kernel.org>
 <6BCC3285-ACA3-4E38-8811-1A91C9F03852@redhat.com>
 <20230201055412-mutt-send-email-mst@kernel.org>
 <4B78D161-2712-434A-8E6F-9D8BA468BB3A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4B78D161-2712-434A-8E6F-9D8BA468BB3A@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:15:10PM +0100, Christophe de Dinechin Dupont de Dinechin wrote:
> 
> 
> > On 1 Feb 2023, at 12:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Wed, Feb 01, 2023 at 11:52:27AM +0100, Christophe de Dinechin Dupont de Dinechin wrote:
> >> 
> >> 
> >>> On 31 Jan 2023, at 18:39, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> 
> >>> On Tue, Jan 31, 2023 at 04:14:29PM +0100, Christophe de Dinechin wrote:
> >>>> Finally, security considerations that apply irrespective of whether the
> >>>> platform is confidential or not are also outside of the scope of this
> >>>> document. This includes topics ranging from timing attacks to social
> >>>> engineering.
> >>> 
> >>> Why are timing attacks by hypervisor on the guest out of scope?
> >> 
> >> Good point.
> >> 
> >> I was thinking that mitigation against timing attacks is the same
> >> irrespective of the source of the attack. However, because the HV
> >> controls CPU time allocation, there are presumably attacks that
> >> are made much easier through the HV. Those should be listed.
> > 
> > Not just that, also because it can and does emulate some devices.
> > For example, are disk encryption systems protected against timing of
> > disk accesses?
> > This is why some people keep saying "forget about emulated devices, require
> > passthrough, include devices in the trust zone".
> > 
> >>> 
> >>>> </doc>
> >>>> 
> >>>> Feel free to comment and reword at will ;-)
> >>>> 
> >>>> 
> >>>> 3/ PCI-as-a-threat: where does that come from
> >>>> 
> >>>> Isn't there a fundamental difference, from a threat model perspective,
> >>>> between a bad actor, say a rogue sysadmin dumping the guest memory (which CC
> >>>> should defeat) and compromised software feeding us bad data? I think there
> >>>> is: at leats inside the TCB, we can detect bad software using measurements,
> >>>> and prevent it from running using attestation.  In other words, we first
> >>>> check what we will run, then we run it. The security there is that we know
> >>>> what we are running. The trust we have in the software is from testing,
> >>>> reviewing or using it.
> >>>> 
> >>>> This relies on a key aspect provided by TDX and SEV, which is that the
> >>>> software being measured is largely tamper-resistant thanks to memory
> >>>> encryption. In other words, after you have measured your guest software
> >>>> stack, the host or hypervisor cannot willy-nilly change it.
> >>>> 
> >>>> So this brings me to the next question: is there any way we could offer the
> >>>> same kind of service for KVM and qemu? The measurement part seems relatively
> >>>> easy. Thetamper-resistant part, on the other hand, seems quite difficult to
> >>>> me. But maybe someone else will have a brilliant idea?
> >>>> 
> >>>> So I'm asking the question, because if you could somehow prove to the guest
> >>>> not only that it's running the right guest stack (as we can do today) but
> >>>> also a known host/KVM/hypervisor stack, we would also switch the potential
> >>>> issues with PCI, MSRs and the like from "malicious" to merely "bogus", and
> >>>> this is something which is evidently easier to deal with.
> >>> 
> >>> Agree absolutely that's much easier.
> >>> 
> >>>> I briefly discussed this with James, and he pointed out two interesting
> >>>> aspects of that question:
> >>>> 
> >>>> 1/ In the CC world, we don't really care about *virtual* PCI devices. We
> >>>>  care about either virtio devices, or physical ones being passed through
> >>>>  to the guest. Let's assume physical ones can be trusted, see above.
> >>>>  That leaves virtio devices. How much damage can a malicious virtio device
> >>>>  do to the guest kernel, and can this lead to secrets being leaked?
> >>>> 
> >>>> 2/ He was not as negative as I anticipated on the possibility of somehow
> >>>>  being able to prevent tampering of the guest. One example he mentioned is
> >>>>  a research paper [1] about running the hypervisor itself inside an
> >>>>  "outer" TCB, using VMPLs on AMD. Maybe something similar can be achieved
> >>>>  with TDX using secure enclaves or some other mechanism?
> >>> 
> >>> Or even just secureboot based root of trust?
> >> 
> >> You mean host secureboot? Or guest?
> >> 
> >> If it’s host, then the problem is detecting malicious tampering with
> >> host code (whether it’s kernel or hypervisor).
> > 
> > Host.  Lots of existing systems do this.  As an extreme boot a RO disk,
> > limit which packages are allowed.
> 
> Is that provable to the guest?
> 
> Consider a cloud provider doing that: how do they prove to their guest:
> 
> a) What firmware, kernel and kvm they run
> 
> b) That what they booted cannot be maliciouly modified, e.g. by a rogue
>    device driver installed by a rogue sysadmin
> 
> My understanding is that SecureBoot is only intended to prevent non-verified
> operating systems from booting. So the proof is given to the cloud provider,
> and the proof is that the system boots successfully.

I think I should have said measured boot not secure boot.

> 
> After that, I think all bets are off. SecureBoot does little AFAICT
> to prevent malicious modifications of the running system by someone with
> root access, including deliberately loading a malicious kvm-zilog.ko

So disable module loading then or don't allow root access?

> 
> It does not mean it cannot be done, just that I don’t think we
> have the tools at the moment.

Phones, chromebooks do this all the time ...

> > 
> >> If it’s guest, at the moment at least, the measurements do not extend
> >> beyond the TCB.
> >> 
> >>> 
> >>> -- 
> >>> MST
> 

