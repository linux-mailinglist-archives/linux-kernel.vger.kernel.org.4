Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF393683410
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjAaRku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjAaRks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189C93D3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675186796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsCyJ6wih57A5GjVGHDZm3qG6/Eq1d91lr2fpDgzdcg=;
        b=YMe9ioUQrw8UxhyffKrJCHeCBDLaAR78FqXNuODFcrr4Cwlbp9KQxYZcIL3Fv3b6Ps9kxJ
        K3G2j3KDBqA/KRwJsPnC7DSuWxf2s5LfIvbtojcPE/9xJWTex82U+svI4M8BzRXbhvOf4j
        1wDfT4EzSHBL0f9Q4NHwgF3iHLco0Xw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-RoLOdRQVOLGwdjK3BbJPbw-1; Tue, 31 Jan 2023 12:39:54 -0500
X-MC-Unique: RoLOdRQVOLGwdjK3BbJPbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5294638173D2;
        Tue, 31 Jan 2023 17:39:53 +0000 (UTC)
Received: from ptitbras (unknown [10.39.194.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBBF3112132C;
        Tue, 31 Jan 2023 17:39:47 +0000 (UTC)
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <m2pmaw5jv4.fsf@redhat.com>
 <DM8PR11MB57504761DE92CE1213549C27E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
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
Date:   Tue, 31 Jan 2023 17:52:57 +0100
In-reply-to: <DM8PR11MB57504761DE92CE1213549C27E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
Message-ID: <m2cz6uk3h9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-01-31 at 10:06 UTC, "Reshetova, Elena" <elena.reshetova@intel.com> wrote...
> Hi Dinechin,

Nit: My first name is actually Christophe ;-)

[snip]

>> "The implementation of the #VE handler is simple and does not require an
>> in-depth security audit or fuzzing since it is not the actual consumer of
>> the host/VMM supplied untrusted data": The assumption there seems to be that
>> the host will never be able to supply data (e.g. through a bounce buffer)
>> that it can trick the guest into executing. If that is indeed the
>> assumption, it is worth mentioning explicitly. I suspect it is a bit weak,
>> since many earlier attacks were based on executing the wrong code. Notably,
>> it is worth pointing out that I/O buffers are _not_ encrypted with the CPU
>> key (as opposed to any device key e.g. for PCI encryption) in either
>> TDX or SEV. Is there for example anything that precludes TDX or SEV from
>> executing code in the bounce buffers?
>
> This was already replied by Kirill, any code execution out of shared memory generates
> a #GP.

Apologies for my wording. Everyone interpreted "executing" as "executing
directly on the bounce buffer page", when what I meant is "consuming data
fetched from the bounce buffers as code" (not necessarily directly).

For example, in the diagram in your document, the guest kernel is a
monolithic piece. In reality, there are dynamically loaded components. In
the original SEV implementation, with pre-attestation, the measurement could
only apply before loading any DLKM (I believe, not really sure). As another
example, SEVerity (CVE-2020-12967 [1]) worked by injecting a payload
directly into the guest kernel using virtio-based network I/O. That is what
I referred to when I wrote "many earlier attacks were based on executing the
wrong code".

The fact that I/O buffers are not encrypted matters here, because it gives
the host ample latitude to observe or even corrupt all I/Os, as many others
have pointed out. Notably, disk crypto may not be designed to resist to a
host that can see and possibly change the I/Os.

So let me rephrase my vague question as a few more precise ones:

1) What are the effects of semi-random kernel code injection?

   If the host knows that a given bounce buffer happens to be used later to
   execute some kernel code, it can start flipping bits in it to try and
   trigger arbitrary code paths in the guest. My understanding is that
   crypto alone (i.e. without additional layers like dm-integrity) will
   happily decrypt that into a code stream with pseudo-random instructions
   in it, not vehemently error out.

   So, while TDX precludes the host from writing into guest memory directly,
   since the bounce buffers are shared, TDX will not prevent the host from
   flipping bits there. It's then just a matter of guessing where the bits
   will go, and hoping that some bits execute at guest PL0. Of course, this
   can be mitigated by either only using static configs, or using
   dm-verity/dm-integrity, or maybe some other mechanisms.

   Shouldn't that be part of your document?  To be clear: you mention under
   "Storage protection" that you use dm-crypt and dm-integrity, so I believe
   *you* know, but your readers may not figure out why dm-integrity is
   integral to the process, notably after you write "Users could use other
   encryption schemes".

2) What are the effects of random user code injection?

   It's the same as above, except that now you can target a much wider range
   of input data, including shell scripts, etc. So the attack surface is
   much larger.

3) What is the effect of data poisoning?

   You don't necessarily need to corrupt code. Being able to corrupt a
   system configuration file for example can be largely sufficient.

4) Are there I/O-based replay attacks that would work pre-attestation?

   My current mental model is that you load a "base" software stack into the
   TCB and then measure a relevant part of it. What you measure is somewhat
   implementation-dependent, but in the end, if the system is attested, you
   respond to a cryptographic challenge based on what was measured, and you
   then get relevant secrets, e.g. a disk decryption key, that let you make
   forward progress. However, what happens if every time you boot, the host
   feeds you bogus disk data just to try to steer the boot sequence along
   some specific path?

   I believe that the short answer is: the guest either:

   a) reaches attestation, but with bad in-memory data, so it fails the
      crypto exchange, and secrets are not leaked.

   b) does not reach attestation, so never gets the secrets, and therefore
      still fulfils the CC promise of not leaking secrets.

   So I personally feel this is OK, but it's worth writing up in your doc.


Back to the #VE handler, if I can find a way to inject malicious code into
my guest, what you wrote in that paragraph as a justification for no
in-depth security still seems like "not exactly defense in depth". I would
just remove the sentence, audit and fuzz that code with the same energy as
for anything else that could face bad input.


[1]: https://www.sec.in.tum.de/i20/student-work/code-execution-attacks-against-encrypted-virtual-machines



--
Cheers,
Christophe de Dinechin (https://c3d.github.io)
Theory of Incomplete Measurements (https://c3d.github.io/TIM)

