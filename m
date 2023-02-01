Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F086866A0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBANQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjBANQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339432ED66
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675257332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWfFEZdhE1A/cXIjzxKCqMf/WvuYInwDL2AiiiAEKfw=;
        b=WOEDg7fQa2l0dRBx0YHBEI8Mu6wvNBoi7sgBI+7BILyg4h1LeKkx7v0utO860gI45a/v7T
        ojGQYkbfYA3ZwCzx/wHHYt63/NYGgtCv+FPCQ8zxI/IOhhwIOzUdsBKG9ZWXqAis3mcOJX
        A0EQnPFUSeXf6bZm5x0fRfJVwgeRIMY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-138-r6vyA524MQyngbwJFtn2kg-1; Wed, 01 Feb 2023 08:15:31 -0500
X-MC-Unique: r6vyA524MQyngbwJFtn2kg-1
Received: by mail-qt1-f197.google.com with SMTP id z12-20020ac8710c000000b003b829a0eda2so6468783qto.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 05:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWfFEZdhE1A/cXIjzxKCqMf/WvuYInwDL2AiiiAEKfw=;
        b=AAIWzwa1Vmph3jMptgb70qfmU4WNqFmXnpmxPX5aQim0UaJJGpK7gq0VoSVh1S8q//
         4TV47jV/TizG61PXyBf12AkaiJnjU0MliplH/mDeqx4muF+LTNiDu6npSUh+kCjV+6R0
         wchcCO3qK9O4lm+WYuZzAKPjz6AGhcAlh+PwICfgTeXGWXem4Qp/Qakv61oiWakzthVU
         6ttVdw4iKWZvJHVnElBYUD7RSVF6ifnzkZbvCKZMz5nEUaeCXLBcOSQTkgBS6/Ht5VwU
         YHmUDRvb7sRrA6Tf0QunYx2ykoh7a32Bc28vu46eqx0JyD37XokIroGqUZCwCQ0oq369
         0zeQ==
X-Gm-Message-State: AO0yUKUTBqtK20RyKnsUErLK7xBVqFNVAWHjNED9S4cOb6cJRIY1U46R
        dlgGgbPNL+9n4eLpj4FW2b56EaXfZpNjB5NrdY+N6fWOI+NPBYyiyKjnPB6vwD626Tnd4DaG5um
        xb7+u10oURVM9hf0C5/0Bwr8R
X-Received: by 2002:ac8:7f01:0:b0:3b8:6075:5d12 with SMTP id f1-20020ac87f01000000b003b860755d12mr3455285qtk.54.1675257330365;
        Wed, 01 Feb 2023 05:15:30 -0800 (PST)
X-Google-Smtp-Source: AK7set94pnyu+kUA+PTDrBbulJQp2GPpV3LzoZv6tfk4SJuG8C8yQkpTLZ4AVVgewlJKPQv+LTI/1w==
X-Received: by 2002:ac8:7f01:0:b0:3b8:6075:5d12 with SMTP id f1-20020ac87f01000000b003b860755d12mr3455215qtk.54.1675257329912;
        Wed, 01 Feb 2023 05:15:29 -0800 (PST)
Received: from smtpclient.apple (82-65-201-253.subs.proxad.net. [82.65.201.253])
        by smtp.gmail.com with ESMTPSA id a26-20020ac8001a000000b003b68ea3d5c8sm4093853qtg.41.2023.02.01.05.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:15:29 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: Linux guest kernel threat model for Confidential Computing
From:   Christophe de Dinechin Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20230201055412-mutt-send-email-mst@kernel.org>
Date:   Wed, 1 Feb 2023 14:15:10 +0100
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B78D161-2712-434A-8E6F-9D8BA468BB3A@redhat.com>
References: <Y9JyW5bUqV7gWmU8@unreal>
 <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
 <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
 <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
 <DM8PR11MB575074D3BCBD02F3DD677A57E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
 <261bc99edc43990eecb1aac4fe8005cedc495c20.camel@linux.ibm.com>
 <m2h6w6k5on.fsf@redhat.com> <20230131123033-mutt-send-email-mst@kernel.org>
 <6BCC3285-ACA3-4E38-8811-1A91C9F03852@redhat.com>
 <20230201055412-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 1 Feb 2023, at 12:01, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Feb 01, 2023 at 11:52:27AM +0100, Christophe de Dinechin =
Dupont de Dinechin wrote:
>>=20
>>=20
>>> On 31 Jan 2023, at 18:39, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>=20
>>> On Tue, Jan 31, 2023 at 04:14:29PM +0100, Christophe de Dinechin =
wrote:
>>>> Finally, security considerations that apply irrespective of whether =
the
>>>> platform is confidential or not are also outside of the scope of =
this
>>>> document. This includes topics ranging from timing attacks to =
social
>>>> engineering.
>>>=20
>>> Why are timing attacks by hypervisor on the guest out of scope?
>>=20
>> Good point.
>>=20
>> I was thinking that mitigation against timing attacks is the same
>> irrespective of the source of the attack. However, because the HV
>> controls CPU time allocation, there are presumably attacks that
>> are made much easier through the HV. Those should be listed.
>=20
> Not just that, also because it can and does emulate some devices.
> For example, are disk encryption systems protected against timing of
> disk accesses?
> This is why some people keep saying "forget about emulated devices, =
require
> passthrough, include devices in the trust zone".
>=20
>>>=20
>>>> </doc>
>>>>=20
>>>> Feel free to comment and reword at will ;-)
>>>>=20
>>>>=20
>>>> 3/ PCI-as-a-threat: where does that come from
>>>>=20
>>>> Isn't there a fundamental difference, from a threat model =
perspective,
>>>> between a bad actor, say a rogue sysadmin dumping the guest memory =
(which CC
>>>> should defeat) and compromised software feeding us bad data? I =
think there
>>>> is: at leats inside the TCB, we can detect bad software using =
measurements,
>>>> and prevent it from running using attestation.  In other words, we =
first
>>>> check what we will run, then we run it. The security there is that =
we know
>>>> what we are running. The trust we have in the software is from =
testing,
>>>> reviewing or using it.
>>>>=20
>>>> This relies on a key aspect provided by TDX and SEV, which is that =
the
>>>> software being measured is largely tamper-resistant thanks to =
memory
>>>> encryption. In other words, after you have measured your guest =
software
>>>> stack, the host or hypervisor cannot willy-nilly change it.
>>>>=20
>>>> So this brings me to the next question: is there any way we could =
offer the
>>>> same kind of service for KVM and qemu? The measurement part seems =
relatively
>>>> easy. Thetamper-resistant part, on the other hand, seems quite =
difficult to
>>>> me. But maybe someone else will have a brilliant idea?
>>>>=20
>>>> So I'm asking the question, because if you could somehow prove to =
the guest
>>>> not only that it's running the right guest stack (as we can do =
today) but
>>>> also a known host/KVM/hypervisor stack, we would also switch the =
potential
>>>> issues with PCI, MSRs and the like from "malicious" to merely =
"bogus", and
>>>> this is something which is evidently easier to deal with.
>>>=20
>>> Agree absolutely that's much easier.
>>>=20
>>>> I briefly discussed this with James, and he pointed out two =
interesting
>>>> aspects of that question:
>>>>=20
>>>> 1/ In the CC world, we don't really care about *virtual* PCI =
devices. We
>>>>  care about either virtio devices, or physical ones being passed =
through
>>>>  to the guest. Let's assume physical ones can be trusted, see =
above.
>>>>  That leaves virtio devices. How much damage can a malicious virtio =
device
>>>>  do to the guest kernel, and can this lead to secrets being leaked?
>>>>=20
>>>> 2/ He was not as negative as I anticipated on the possibility of =
somehow
>>>>  being able to prevent tampering of the guest. One example he =
mentioned is
>>>>  a research paper [1] about running the hypervisor itself inside an
>>>>  "outer" TCB, using VMPLs on AMD. Maybe something similar can be =
achieved
>>>>  with TDX using secure enclaves or some other mechanism?
>>>=20
>>> Or even just secureboot based root of trust?
>>=20
>> You mean host secureboot? Or guest?
>>=20
>> If it=E2=80=99s host, then the problem is detecting malicious =
tampering with
>> host code (whether it=E2=80=99s kernel or hypervisor).
>=20
> Host.  Lots of existing systems do this.  As an extreme boot a RO =
disk,
> limit which packages are allowed.

Is that provable to the guest?

Consider a cloud provider doing that: how do they prove to their guest:

a) What firmware, kernel and kvm they run

b) That what they booted cannot be maliciouly modified, e.g. by a rogue
   device driver installed by a rogue sysadmin

My understanding is that SecureBoot is only intended to prevent =
non-verified
operating systems from booting. So the proof is given to the cloud =
provider,
and the proof is that the system boots successfully.

After that, I think all bets are off. SecureBoot does little AFAICT
to prevent malicious modifications of the running system by someone with
root access, including deliberately loading a malicious kvm-zilog.ko

It does not mean it cannot be done, just that I don=E2=80=99t think we
have the tools at the moment.

>=20
>> If it=E2=80=99s guest, at the moment at least, the measurements do =
not extend
>> beyond the TCB.
>>=20
>>>=20
>>> --=20
>>> MST


