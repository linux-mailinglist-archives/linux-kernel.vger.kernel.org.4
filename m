Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6A680C25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjA3Lnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjA3Lni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:43:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3FA2BF11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675078968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9Hg0TbdjCWbFmrRsJTCwS8aIGYfDhQHhp2E2ViuLn0=;
        b=ZOSAgwhYK8l+PmoDecOwjIdGP/GNTycSBGSVbYovAzuiwY80bguDLGCZsnYR7q4P3gp3e4
        s2R+SwAudRuBWWT2qkLeI6jf5LDhs5D1DHSG7uzTr0RoQnLTnvt4AbYbTQ+dMtcT6sRn3W
        FqtlywcxARf58bS7+i7JJgGWf+UOu6E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-KNAt9Q__PRiXwg4J8RrNlg-1; Mon, 30 Jan 2023 06:42:45 -0500
X-MC-Unique: KNAt9Q__PRiXwg4J8RrNlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5285A3C0F42B;
        Mon, 30 Jan 2023 11:42:44 +0000 (UTC)
Received: from ptitbras (unknown [10.39.195.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B38B3140EBF5;
        Mon, 30 Jan 2023 11:42:40 +0000 (UTC)
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
User-agent: mu4e 1.8.0; emacs 28.2
From:   Christophe de Dinechin <dinechin@redhat.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Date:   Mon, 30 Jan 2023 12:36:34 +0100
In-reply-to: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
Message-ID: <m2pmaw5jv4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elena,

On 2023-01-25 at 12:28 UTC, "Reshetova, Elena" <elena.reshetova@intel.com> =
wrote...
> Hi Greg,
>
> You mentioned couple of times (last time in this recent thread:
> https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we ought to=
 start
> discussing the updated threat model for kernel, so this email is a start =
in this direction.
>
> (Note: I tried to include relevant people from different companies, as we=
ll as linux-coco
> mailing list, but I hope everyone can help by including additional people=
 as needed).
>
> As we have shared before in various lkml threads/conference presentations
> ([1], [2], [3] and many others), for the Confidential Computing guest ker=
nel, we have a
> change in the threat model where guest kernel doesn=E2=80=99t anymore tru=
st the hypervisor.
> This is a big change in the threat model and requires both careful assess=
ment of the
> new (hypervisor <-> guest kernel) attack surface, as well as careful desi=
gn of mitigations
> and security validation techniques. This is the activity that we have sta=
rted back at Intel
> and the current status can be found in
>
> 1) Threat model and potential mitigations:
> https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html

I only looked at this one so far. Here are a few quick notes:

DoS attacks are out of scope. What about timing attacks, which were the
basis of some of the most successful attacks in the past years? My
understanding is that TDX relies on existing mitigations, and does not
introduce anythign new in that space. Worth mentioning in that "out of
scope" section IMO.

Why are TDVMCALL hypercalls listed as an "existing" communication interface?
That seems to exclude the TDX module from the TCB. Also, "shared memory for
I/Os" seems unnecessarily restrictive, since it excludes interrupts, timing
attacks, network or storage attacks, or devices passed through to the guest.
The latter category seems important to list, since there are separate
efforts to provide confidential computing capabilities e.g. to PCI devices,
which were discussed elsewhere in this thread.

I suspect that my question above is due to ambiguous wording. What I
initially read as "this is out of scope for TDX" morphs in the next
paragraph into "we are going to explain how to mitigate attacks through
TDVMCALLS and shared memory for I/O". Consider rewording to clarify the
intent of these paragraphs.

Nit: I suggest adding bullets to the items below "between host/VMM and the
guest"

You could count the "unique code locations" that can consume malicious input
in drivers, why not in core kernel? I think you write elsewhere that the
drivers account for the vast majority, so I suspect you have the numbers.

"The implementation of the #VE handler is simple and does not require an
in-depth security audit or fuzzing since it is not the actual consumer of
the host/VMM supplied untrusted data": The assumption there seems to be that
the host will never be able to supply data (e.g. through a bounce buffer)
that it can trick the guest into executing. If that is indeed the
assumption, it is worth mentioning explicitly. I suspect it is a bit weak,
since many earlier attacks were based on executing the wrong code. Notably,
it is worth pointing out that I/O buffers are _not_ encrypted with the CPU
key (as opposed to any device key e.g. for PCI encryption) in either
TDX or SEV. Is there for example anything that precludes TDX or SEV from
executing code in the bounce buffers?

"We only care about users that read from MMIO": Why? My guess is that this
is the only way bad data could be fed to the guest. But what if a bad MMIO
write due to poisoned data injected earlier was a necessary step to open the
door to a successful attack?


>
> 2) One of the described in the above doc mitigations is "hardening of the=
 enabled
> code". What we mean by this, as well as techniques that are being used are
> described in this document:
> https://intel.github.io/ccc-linux-guest-hardening-docs/tdx-guest-hardenin=
g.html
>
> 3) All the tools are open-source and everyone can start using them right =
away even
> without any special HW (readme has description of what is needed).
> Tools and documentation is here:
> https://github.com/intel/ccc-linux-guest-hardening
>
> 4) all not yet upstreamed linux patches (that we are slowly submitting) c=
an be found
> here: https://github.com/intel/tdx/commits/guest-next
>
> So, my main question before we start to argue about the threat model, mit=
igations, etc,
> is what is the good way to get this reviewed to make sure everyone is ali=
gned?
> There are a lot of angles and details, so what is the most efficient meth=
od?
> Should I split the threat model from https://intel.github.io/ccc-linux-gu=
est-hardening-docs/security-spec.html
> into logical pieces and start submitting it to mailing list for discussio=
n one by one?
> Any other methods?
>
> The original plan we had in mind is to start discussing the relevant piec=
es when submitting the code,
> i.e. when submitting the device filter patches, we will include problem s=
tatement, threat model link,
> data, alternatives considered, etc.
>
> Best Regards,
> Elena.
>
> [1] https://lore.kernel.org/all/20210804174322.2898409-1-sathyanarayanan.=
kuppuswamy@linux.intel.com/
> [2] https://lpc.events/event/16/contributions/1328/
> [3] https://events.linuxfoundation.org/archive/2022/linux-security-summit=
-north-america/program/schedule/


--
Cheers,
Christophe de Dinechin (https://c3d.github.io)
Theory of Incomplete Measurements (https://c3d.github.io/TIM)

