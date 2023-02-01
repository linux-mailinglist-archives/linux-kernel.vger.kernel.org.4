Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB2686D63
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBARs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjBARsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7901E2B7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675273651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRePCpDJBO/M8Zq3CNN7A6fVA0vNSETNMdWmUr+Atgo=;
        b=QX1lhfRmrZuNdh7U+LDuzaterW0R/MuQE0x5bqXPJJASUS8qYuOo2Whdt39Syf438Xez+u
        7KmvMal6+UurWRaacWeGH4Ckawvxyx7ig0gLWch1LxQrmmDLXsJ8vcfwDmLxLcA+ae8HWA
        MVU37Pj+ZMFbCekugHEcWlF6hmYaQ8U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-XXCDyiTNPQae3Ivdo5qQ7A-1; Wed, 01 Feb 2023 12:47:29 -0500
X-MC-Unique: XXCDyiTNPQae3Ivdo5qQ7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAFE93C1068E;
        Wed,  1 Feb 2023 17:47:23 +0000 (UTC)
Received: from ptitbras (unknown [10.39.194.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AC652166B33;
        Wed,  1 Feb 2023 17:47:18 +0000 (UTC)
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
 <20230201105305-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.8.0; emacs 28.2
From:   Christophe de Dinechin <dinechin@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
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
Date:   Wed, 01 Feb 2023 18:13:22 +0100
In-reply-to: <20230201105305-mutt-send-email-mst@kernel.org>
Message-ID: <m2zg9xi8gr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-02-01 at 11:02 -05, "Michael S. Tsirkin" <mst@redhat.com> wrote...
> On Wed, Feb 01, 2023 at 02:15:10PM +0100, Christophe de Dinechin Dupont d=
e Dinechin wrote:
>>
>>
>> > On 1 Feb 2023, at 12:01, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >
>> > On Wed, Feb 01, 2023 at 11:52:27AM +0100, Christophe de Dinechin Dupon=
t de Dinechin wrote:
>> >>
>> >>
>> >>> On 31 Jan 2023, at 18:39, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >>>
>> >>> On Tue, Jan 31, 2023 at 04:14:29PM +0100, Christophe de Dinechin wro=
te:
>> >>>> Finally, security considerations that apply irrespective of whether=
 the
>> >>>> platform is confidential or not are also outside of the scope of th=
is
>> >>>> document. This includes topics ranging from timing attacks to social
>> >>>> engineering.
>> >>>
>> >>> Why are timing attacks by hypervisor on the guest out of scope?
>> >>
>> >> Good point.
>> >>
>> >> I was thinking that mitigation against timing attacks is the same
>> >> irrespective of the source of the attack. However, because the HV
>> >> controls CPU time allocation, there are presumably attacks that
>> >> are made much easier through the HV. Those should be listed.
>> >
>> > Not just that, also because it can and does emulate some devices.
>> > For example, are disk encryption systems protected against timing of
>> > disk accesses?
>> > This is why some people keep saying "forget about emulated devices, re=
quire
>> > passthrough, include devices in the trust zone".
>> >
>> >>>
>> >>>> </doc>
>> >>>>
>> >>>> Feel free to comment and reword at will ;-)
>> >>>>
>> >>>>
>> >>>> 3/ PCI-as-a-threat: where does that come from
>> >>>>
>> >>>> Isn't there a fundamental difference, from a threat model perspecti=
ve,
>> >>>> between a bad actor, say a rogue sysadmin dumping the guest memory =
(which CC
>> >>>> should defeat) and compromised software feeding us bad data? I thin=
k there
>> >>>> is: at leats inside the TCB, we can detect bad software using measu=
rements,
>> >>>> and prevent it from running using attestation.  In other words, we =
first
>> >>>> check what we will run, then we run it. The security there is that =
we know
>> >>>> what we are running. The trust we have in the software is from test=
ing,
>> >>>> reviewing or using it.
>> >>>>
>> >>>> This relies on a key aspect provided by TDX and SEV, which is that =
the
>> >>>> software being measured is largely tamper-resistant thanks to memory
>> >>>> encryption. In other words, after you have measured your guest soft=
ware
>> >>>> stack, the host or hypervisor cannot willy-nilly change it.
>> >>>>
>> >>>> So this brings me to the next question: is there any way we could o=
ffer the
>> >>>> same kind of service for KVM and qemu? The measurement part seems r=
elatively
>> >>>> easy. Thetamper-resistant part, on the other hand, seems quite diff=
icult to
>> >>>> me. But maybe someone else will have a brilliant idea?
>> >>>>
>> >>>> So I'm asking the question, because if you could somehow prove to t=
he guest
>> >>>> not only that it's running the right guest stack (as we can do toda=
y) but
>> >>>> also a known host/KVM/hypervisor stack, we would also switch the po=
tential
>> >>>> issues with PCI, MSRs and the like from "malicious" to merely "bogu=
s", and
>> >>>> this is something which is evidently easier to deal with.
>> >>>
>> >>> Agree absolutely that's much easier.
>> >>>
>> >>>> I briefly discussed this with James, and he pointed out two interes=
ting
>> >>>> aspects of that question:
>> >>>>
>> >>>> 1/ In the CC world, we don't really care about *virtual* PCI device=
s. We
>> >>>>  care about either virtio devices, or physical ones being passed th=
rough
>> >>>>  to the guest. Let's assume physical ones can be trusted, see above.
>> >>>>  That leaves virtio devices. How much damage can a malicious virtio=
 device
>> >>>>  do to the guest kernel, and can this lead to secrets being leaked?
>> >>>>
>> >>>> 2/ He was not as negative as I anticipated on the possibility of so=
mehow
>> >>>>  being able to prevent tampering of the guest. One example he menti=
oned is
>> >>>>  a research paper [1] about running the hypervisor itself inside an
>> >>>>  "outer" TCB, using VMPLs on AMD. Maybe something similar can be ac=
hieved
>> >>>>  with TDX using secure enclaves or some other mechanism?
>> >>>
>> >>> Or even just secureboot based root of trust?
>> >>
>> >> You mean host secureboot? Or guest?
>> >>
>> >> If it=E2=80=99s host, then the problem is detecting malicious tamperi=
ng with
>> >> host code (whether it=E2=80=99s kernel or hypervisor).
>> >
>> > Host.  Lots of existing systems do this.  As an extreme boot a RO disk,
>> > limit which packages are allowed.
>>
>> Is that provable to the guest?
>>
>> Consider a cloud provider doing that: how do they prove to their guest:
>>
>> a) What firmware, kernel and kvm they run
>>
>> b) That what they booted cannot be maliciouly modified, e.g. by a rogue
>>    device driver installed by a rogue sysadmin
>>
>> My understanding is that SecureBoot is only intended to prevent non-veri=
fied
>> operating systems from booting. So the proof is given to the cloud provi=
der,
>> and the proof is that the system boots successfully.
>
> I think I should have said measured boot not secure boot.

The problem again is how you prove to the guest that you are not lying?

We know how to do that from a guest [1], but you will note that in the
normal process, a trusted hardware component (e.g. the PSP for AMD SEV)
proves the validity of the measurements of the TCB by encrypting it with an
attestation signing key derived from some chip-unique secret. For AMD, this
is called the VCEK, and TDX has something similar. In the case of SEV, this
goes through firmware, and you have to tell the firmware each time you
insert data in the original TCB (using SNP_LAUNCH_UPDATE). This is all tied
to a VM execution context. I do not believe there is any provision to do the
same thing to measure host data. And again, it would be somewhat pointless
if there isn't also a mechanism to ensure the host data is not changed after
the measurement.

Now, I don't think it would be super-difficult to add a firmware service
that would let the host do some kind of equivalent to PVALIDATE, setting
some physical pages aside that then get measured and become inaccessible to
the host. The PSP or similar could then integrate these measurements as part
of the TCB, and the fact that the pages were "transferred" to this special
invariant block would ensure the guests that the code will not change after
being measured.

I am not aware that such a mechanism exists on any of the existing CC
platforms. Please feel free to enlighten me if I'm wrong.

[1] https://www.redhat.com/en/blog/understanding-confidential-containers-at=
testation-flow
>
>>
>> After that, I think all bets are off. SecureBoot does little AFAICT
>> to prevent malicious modifications of the running system by someone with
>> root access, including deliberately loading a malicious kvm-zilog.ko
>
> So disable module loading then or don't allow root access?

Who would do that?

The problem is that we have a host and a tenant, and the tenant does not
trust the host in principle. So it is not sufficient for the host to disable
module loading or carefully control root access. It is also necessary to
prove to the tenant(s) that this was done.

>
>>
>> It does not mean it cannot be done, just that I don=E2=80=99t think we
>> have the tools at the moment.
>
> Phones, chromebooks do this all the time ...

Indeed, but there, this is to prove to the phone's real owner (which,
surprise, is not the naive person who thought they'd get some kind of
ownership by buying the phone) that the software running on the phone has
not been replaced by some horribly jailbreaked goo.

In other words, the user of the phone gets no proof whatsoever of anything,
except that the phone appears to work. This is somewhat the situation in the
cloud today: the owners of the hardware get all sorts of useful checks, from
SecureBoot to error-correction for memory or I/O devices. However, someone
running in a VM on the cloud gets none of that, just like the user of your
phone.

--
Cheers,
Christophe de Dinechin (https://c3d.github.io)
Theory of Incomplete Measurements (https://c3d.github.io/TIM)

