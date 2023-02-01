Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3AB6864C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjBAKxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjBAKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B648448A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675248778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxaZ2Gw7LqOcL0Mlhbpw1+6NsEEwQcG6K+vDjNiXi54=;
        b=YK8xe6eTw1NlKh3WtKXQy76VsEK34bknkMqk5nalsXSLjPh/Q/OCBfEkE+6oqc+u7MmZWc
        NrPORA7otqc4tJDe22N/xZXHKL0hswjr55uRGD4kooRf0N6eYTnJvgVllGfZ6MxstC/fxj
        MgCH5zJWBxqIpi34nmmNIVrP6tPp6Tc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-X8is7NI2PvGaXPdqz_idCw-1; Wed, 01 Feb 2023 05:52:53 -0500
X-MC-Unique: X8is7NI2PvGaXPdqz_idCw-1
Received: by mail-qt1-f197.google.com with SMTP id a24-20020ac84d98000000b003b9a4958f0cso3213324qtw.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxaZ2Gw7LqOcL0Mlhbpw1+6NsEEwQcG6K+vDjNiXi54=;
        b=PfWdguDX/fsgDns7BRkIOHfs8EUm2izMmSCrbDDWK5vrNMR1YNKqXTd9dIJ/GlBgLH
         NoarEsrPKuukqRkoay/q8wuF4GJpYB3wx/9wmPU3+HN65NIReGv3ENqPAFXNvTZInEXh
         ld34fkA22jyTq8E4TFG2VRhrhriXHhzGZ6gLBnbHFJ6uCIrRMjDycRtLhhlGKm5j1iV+
         t6VH5PKfztjn2xdXcU03FzrEYFcqKYsJXYQhQ67rMslGBVBIaJ4EsPePP7dyqmD3fVvY
         wjnLP4eD5eCzsNiro1AXp0kZzBjDRjOMzF0Zx0G2yuFnG32dhDc9Gatj0OYpbOSYoO59
         kmNg==
X-Gm-Message-State: AO0yUKXjzFqCnNH/nzpsbPhsX70QCsL6M21ylrv6G/8g26RCA0UPCUHn
        OCLkikv297d4hZsOckzIMZUT49Dp5LdZYk667RFqWoXdUKokg5Qaec8aDcffdPiTCqFhpr8uW06
        QIDPPSAdpn0BwXK/ekdNa2EiH
X-Received: by 2002:ac8:57d6:0:b0:3b8:6cd5:eda with SMTP id w22-20020ac857d6000000b003b86cd50edamr3711182qta.47.1675248772333;
        Wed, 01 Feb 2023 02:52:52 -0800 (PST)
X-Google-Smtp-Source: AK7set/drD//ZJUkASaW2AJ7dvlHfEv8Ltk9VImlZM2Rmw+zdeHqF7KRTO2LYhNhXuwERejbr/hCxg==
X-Received: by 2002:ac8:57d6:0:b0:3b8:6cd5:eda with SMTP id w22-20020ac857d6000000b003b86cd50edamr3711139qta.47.1675248772009;
        Wed, 01 Feb 2023 02:52:52 -0800 (PST)
Received: from smtpclient.apple (82-65-201-253.subs.proxad.net. [82.65.201.253])
        by smtp.gmail.com with ESMTPSA id l7-20020ae9f007000000b00706b6ce386fsm11900504qkg.70.2023.02.01.02.52.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2023 02:52:51 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: Linux guest kernel threat model for Confidential Computing
From:   Christophe de Dinechin Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20230131123033-mutt-send-email-mst@kernel.org>
Date:   Wed, 1 Feb 2023 11:52:27 +0100
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
Message-Id: <6BCC3285-ACA3-4E38-8811-1A91C9F03852@redhat.com>
References: <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9JyW5bUqV7gWmU8@unreal>
 <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
 <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
 <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
 <DM8PR11MB575074D3BCBD02F3DD677A57E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
 <261bc99edc43990eecb1aac4fe8005cedc495c20.camel@linux.ibm.com>
 <m2h6w6k5on.fsf@redhat.com> <20230131123033-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 31 Jan 2023, at 18:39, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Jan 31, 2023 at 04:14:29PM +0100, Christophe de Dinechin =
wrote:
>> Finally, security considerations that apply irrespective of whether =
the
>> platform is confidential or not are also outside of the scope of this
>> document. This includes topics ranging from timing attacks to social
>> engineering.
>=20
> Why are timing attacks by hypervisor on the guest out of scope?

Good point.

I was thinking that mitigation against timing attacks is the same
irrespective of the source of the attack. However, because the HV
controls CPU time allocation, there are presumably attacks that
are made much easier through the HV. Those should be listed.

>=20
>> </doc>
>>=20
>> Feel free to comment and reword at will ;-)
>>=20
>>=20
>> 3/ PCI-as-a-threat: where does that come from
>>=20
>> Isn't there a fundamental difference, from a threat model =
perspective,
>> between a bad actor, say a rogue sysadmin dumping the guest memory =
(which CC
>> should defeat) and compromised software feeding us bad data? I think =
there
>> is: at leats inside the TCB, we can detect bad software using =
measurements,
>> and prevent it from running using attestation.  In other words, we =
first
>> check what we will run, then we run it. The security there is that we =
know
>> what we are running. The trust we have in the software is from =
testing,
>> reviewing or using it.
>>=20
>> This relies on a key aspect provided by TDX and SEV, which is that =
the
>> software being measured is largely tamper-resistant thanks to memory
>> encryption. In other words, after you have measured your guest =
software
>> stack, the host or hypervisor cannot willy-nilly change it.
>>=20
>> So this brings me to the next question: is there any way we could =
offer the
>> same kind of service for KVM and qemu? The measurement part seems =
relatively
>> easy. Thetamper-resistant part, on the other hand, seems quite =
difficult to
>> me. But maybe someone else will have a brilliant idea?
>>=20
>> So I'm asking the question, because if you could somehow prove to the =
guest
>> not only that it's running the right guest stack (as we can do today) =
but
>> also a known host/KVM/hypervisor stack, we would also switch the =
potential
>> issues with PCI, MSRs and the like from "malicious" to merely =
"bogus", and
>> this is something which is evidently easier to deal with.
>=20
> Agree absolutely that's much easier.
>=20
>> I briefly discussed this with James, and he pointed out two =
interesting
>> aspects of that question:
>>=20
>> 1/ In the CC world, we don't really care about *virtual* PCI devices. =
We
>>   care about either virtio devices, or physical ones being passed =
through
>>   to the guest. Let's assume physical ones can be trusted, see above.
>>   That leaves virtio devices. How much damage can a malicious virtio =
device
>>   do to the guest kernel, and can this lead to secrets being leaked?
>>=20
>> 2/ He was not as negative as I anticipated on the possibility of =
somehow
>>   being able to prevent tampering of the guest. One example he =
mentioned is
>>   a research paper [1] about running the hypervisor itself inside an
>>   "outer" TCB, using VMPLs on AMD. Maybe something similar can be =
achieved
>>   with TDX using secure enclaves or some other mechanism?
>=20
> Or even just secureboot based root of trust?

You mean host secureboot? Or guest?

If it=E2=80=99s host, then the problem is detecting malicious tampering =
with
host code (whether it=E2=80=99s kernel or hypervisor).

If it=E2=80=99s guest, at the moment at least, the measurements do not =
extend
beyond the TCB.

>=20
> --=20
> MST
>=20

