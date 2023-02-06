Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEC368B88C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjBFJWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBFJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:22:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5741112F11
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:22:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12D74B80DF3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60A1C433EF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675675361;
        bh=7PrGYOD6xg7vSTpvZLbU3eDXKYf+pDe9POo0NSmV+U4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JbEHlfAABoEOIkTYn6YiTjI3sWCVAWISckWkvLBgG8ADK6aI4qZw+HoIXj7dXcLLe
         O8nxbqaUv3u1uO0VtxcydDamth8jli8fsHCPhK5dw6FsWiApOf3S0LUY6vobSzMn5m
         BHxqFejET5honKqxGmFZ9f1V0X4aFui+SeXVEKn8bMIQGGnGv//O1RVGU6E1dCy0d+
         +jr+iFXPodWJaMLqYBgkPlLsyLXnkKhcwGul6Af3sqjFbOuht4WnRFw82F2Pq8ZYjh
         g/hxgUIN5BZXWPJHNUKOopbegQEPnHal5KtYVdom7c5kl9kiMcwL/GW6tLhO+6A+su
         Gf/RpmHXNOpvw==
Received: by mail-lf1-f48.google.com with SMTP id x40so16679544lfu.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:22:41 -0800 (PST)
X-Gm-Message-State: AO0yUKWnAear+KIgLfYxSMFxrZJi0s1BMgQAViY8OpE6pOql7T8VcytB
        Aztprp2m5dbNLnGZDf0G/WIv2QBWeybSENVtVeE=
X-Google-Smtp-Source: AK7set8RUKkCifTx+QWKZojhUbSff35Y1mC2hz03OOEeve3hG34a/hSduZA7c4piP89I6tqa7137BHVFCzssHP0XVMk=
X-Received: by 2002:a05:6512:114f:b0:4ca:f9e3:c324 with SMTP id
 m15-20020a056512114f00b004caf9e3c324mr3282697lfg.190.1675675359711; Mon, 06
 Feb 2023 01:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
 <Y9zFzW2yj7uMI0XR@jade> <CAFA6WYOp-NQxvqOmemiW2D5Au549f-u4LJA7XEK2aJgMiXRUYg@mail.gmail.com>
 <Y9zoMJcbrKIvbDdh@jade> <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>
In-Reply-To: <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Feb 2023 10:22:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGg3wwhJFRjAGEP2fDLcbHpiuHuiaW2y+oVgjwULqVTZg@mail.gmail.com>
Message-ID: <CAMj1kXGg3wwhJFRjAGEP2fDLcbHpiuHuiaW2y+oVgjwULqVTZg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023 at 07:44, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 3 Feb 2023 at 16:25, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
..
> > StMM uses the MM protocol. It was originially using raw SMCs as a
> > conduit, but with the need for OP-TEE accessing RPMB that's not usable.
> > So instead we use OP-TEE MSG as a conduit. Seen from that perspective
> > we're only resuing something established instead of inventing something
> > new.
>
> Aren't we already adding PTA_STMM?
>
> Isn't the StMM specific to Arm as you already mentioned it was
> designed to specifically use raw SMCs? So if in future AMD TEE wants
> to implement EFI services, can we suggest they reuse the MM interface?
>
> I am not sure why we need to redirect EFI variables via MM interface
> communication buffers rather than directly using the TEE shared memory
> approach.
>
> Ard,
>
> Since you have better insights into how EFI runtime services have to
> be implemented, can you share your opinion here? It may be something I
> am missing here.
>

Hello Sumit,

I'm not sure I understand what you are asking me here. Allow me to
reiterate, apologies if I am stating the obvious:

The EFI spec describes how the OS should expose the EFI runtime
services, but this is difficult to implement when access to the
underlying storage requires arbitration between accesses by the OS
itself and accesses made by the firmware.

On systems where this issue is absent, the EFI runtime service
implementation for the variable services are very thin wrappers around
calls into standalone MM, which are not standardized, but are also not
ARM specific (standalone MM is being used on other architectures as
well, and 'classic' SMM uses the same protocol but dispatches the call
into the secure/SMM world in a different way)

On systems where arbitration is needed, the standalone MM payload
needs to call back up into the OS to request access to the flash
storage. OP-TEE is a suitable vehicle for this, as it already does the
same thing for other reasons, and is already set up to dispatch SMC
calls that are taken to S-EL1.

All of his is uncharted territory as far as the EFI spec is concerned,
as it occurs inside the StMM pseudo-API call, which itself normally
occurs inside the EFI runtime service call. Given that we cannot use
the latter (as the firmware does not provide a working get/setvariable
at OS runtime [0]), we need to provide some plumbing to call the StMM
pseudo-API directly, and expose it as an alternative efivars
implementation. (Note that this should mean that other implementations
of the StMM pseudo-API that do not require this arbitration may
potentially be accessed in the same way, although I don't see a reason
to use it like that.)

If I am understanding you correctly, your question is whether OP-TEE
should expose the StMM pseudo-API in the usual way as well, and make
the OS rely on the usual discovery mechanisms etc to bind to it?

If that is indeed your question: what purpose would that serve,
exactly? In principle, the OS piece that implements efivars on top of
the StMM pseudo-API should not be specific to any TEE implementation
or API, and I think the fact that OP-TEE is the provider in this case
is an implementation detail.

If you feel that OP-TEE should not expose this interface directly to
begin with, and rely on some marshalling layer to expose the StMM
pseudo-API on top of its ordinary exposed API, that is really an
OP-TEE internal matter (which I think is what you discussed with Jens
up in the thread?) Since StMM calls are defined in terms of SMC
instructions + arguments, this would require more code inside OP-TEE
to translate access to an API that it already exposes directly as
well, so I'm not sure what the gain would be.

The thing to remember is that, even though the wrappers are very thin,
it is fundamentally the StMM API that is being exposed, not the EFI
runtime services API, and so whether or not a use case may materialize
that wants to expose a different API via efivars is out of scope here,
even if they are roughly shaped like get/setvariable.



-- 
Ard.


[0] It is permitted for implementations of, e.g., Get/SetTime or
ResetSystem to use Get/SetVariable internally, and this is quite
clearly broken if the EFI variable services cannot be used. However,
firmware implementations would presumably avoid that situation.
