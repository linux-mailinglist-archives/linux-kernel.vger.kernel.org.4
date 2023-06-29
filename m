Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D8B742F61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjF2VRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjF2VRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:17:06 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A651CA2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:17:05 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4007b5bafceso27781cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688073424; x=1690665424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9QgpyZtEqZsVI1wel0QxxMtg/ImPrZn0pSFmPj7TqY=;
        b=i+fXCRXqoonLzaJlMJPBNfPKqupDRkY/fTWaf+YUw9O/vT/TtCi+zNt2yQYqw0OQ27
         ZOTRaJx082vwySAsb8DaVM+XgLl07S2LVyJ+lezRdTop5/+hulSpeaxES4fmfhIkobs8
         CJy5ygg43INLmfyPGF3rjeLU9qYgy/3Kbk6npBeBnMNSqRSXx5HbiQI/cS4iCnFsW+n3
         DHHPV8OMEmH394H3DjWJIuqScRMqRdfBaMkVzgcR9skD8IHaUZyOpycI1pnBRXgmscWL
         Doo+LgiuFf3dtMKeD6vg5HYzYXIv4PLD+QBtjrb/1KiKES3CNyBHDbLfF8pSMxcu7Nbr
         B7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688073424; x=1690665424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9QgpyZtEqZsVI1wel0QxxMtg/ImPrZn0pSFmPj7TqY=;
        b=HqqgLDTfhmIKrjwc4CgwPt0aG4zGmMC8f1f/V5EJJ9XKAbI8aJobVUBejH05GJlQkP
         Sq/a/x2Ze7H1D4PKq6/UJqOxDzEF0OINIy+drG6YvlbpE6BX0mRc4XEF3iLaZPEFAFYn
         WhVriTel57xQkEjQIjPCsbxxCO8toCwL9XM2lEoq2AhFxi2FPQFLZqvHLKEtx9kQB8tl
         hqqKzAcrEZW7kEKhjE3nejFgHJMSRB9EQUS6xLCOSq6Aj3h4ZbbSDR+xhkySY2hAKB8M
         qdigkE+LfkKviZqT545AwEjjXSh3rlagGrlM1XchMUS068PkB38On0E/6lcNOFUfwXpt
         YQAg==
X-Gm-Message-State: AC+VfDyyZPcnrBYlDs3siBD4S0Y4hsVUwnqkWBE5JiIJjfLp0f09sBul
        Rj6qZ0zNuJX1xQblIeqzVto2flsWZ3bKjuAIjnQh0w==
X-Google-Smtp-Source: ACHHUZ618sn0IJKESOcga0FN8MSV0AQbJD2b3s/6C/JNYw27A8mDjGbGlf3fvrXVjzvb3nz9A15eXzEA0ZJIFUQhN1Y=
X-Received: by 2002:ac8:5843:0:b0:3f9:a986:f3a4 with SMTP id
 h3-20020ac85843000000b003f9a986f3a4mr589397qth.25.1688073424559; Thu, 29 Jun
 2023 14:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230504120042.785651-1-rkagan@amazon.de> <ZH6DJ8aFq/LM6Bk9@google.com>
In-Reply-To: <ZH6DJ8aFq/LM6Bk9@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 29 Jun 2023 14:16:53 -0700
Message-ID: <CALMp9eS3F08cwUJbKjTRAEL0KyZ=MC==YSH+DW-qsFkNfMpqEQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: vPMU: truncate counter value to allowed width
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eric Hankland <ehankland@google.com>
Cc:     Roman Kagan <rkagan@amazon.de>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Like Xu <likexu@tencent.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 5:51=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, May 04, 2023, Roman Kagan wrote:
> > diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> > index 5c7bbf03b599..6a91e1afef5a 100644
> > --- a/arch/x86/kvm/pmu.h
> > +++ b/arch/x86/kvm/pmu.h
> > @@ -60,6 +60,12 @@ static inline u64 pmc_read_counter(struct kvm_pmc *p=
mc)
> >       return counter & pmc_bitmask(pmc);
> >  }
> >
> > +static inline void pmc_set_counter(struct kvm_pmc *pmc, u64 val)
> > +{
> > +     pmc->counter +=3D val - pmc_read_counter(pmc);
>
> Ugh, not your code, but I don't see how the current code can possibly be =
correct.
>
> The above unpacks to
>
>         counter =3D pmc->counter;
>         if (pmc->perf_event && !pmc->is_paused)
>                 counter +=3D perf_event_read_value(pmc->perf_event,
>                                                  &enabled, &running);
>         pmc->counter +=3D val - (counter & pmc_bitmask(pmc));
>
> which distills down to
>
>         counter =3D 0;
>         if (pmc->perf_event && !pmc->is_paused)
>                 counter +=3D perf_event_read_value(pmc->perf_event,
>                                                  &enabled, &running);
>         pmc->counter =3D val - (counter & pmc_bitmask(pmc));
>
> or more succinctly
>
>         if (pmc->perf_event && !pmc->is_paused)
>                 val -=3D perf_event_read_value(pmc->perf_event, &enabled,=
 &running);
>
>         pmc->counter =3D val;
>
> which is obviously wrong.  E.g. if the guest writes '0' to an active coun=
ter, the
> adjustment will cause pmc->counter to be loaded with a large (in unsigned=
 terms)
> value, and thus quickly overflow after a write of '0'.

This weird construct goes all the way back to commit f5132b01386b
("KVM: Expose a version 2 architectural PMU to a guests"). Paolo
killed it in commit 2924b52117b2 ("KVM: x86/pmu: do not mask the value
that is written to fixed PMUs"), perhaps by accident. Eric then
resurrected it in commit 4400cf546b4b ("KVM: x86: Fix perfctr WRMSR
for running counters").

It makes no sense to me. WRMSR should just set the new value of the
counter, regardless of the old value or whether or not it is running.

> I assume the intent it to purge any accumulated counts that occurred sinc=
e the
> last read, but *before* the write, but then shouldn't this just be:
>
>         /* Purge any events that were acculumated before the write. */
>         if (pmc->perf_event && !pmc->is_paused)
>                 (void)perf_event_read_value(pmc->perf_event, &enabled, &r=
unning);
>
>         pmc->counter =3D val & pmc_bitmask(pmc);
>
> Am I missing something?
>
> I'd like to get this sorted out before applying this patch, because I rea=
lly want
> to document what on earth this new helper is doing.  Seeing a bizarre par=
tial
> RMW operation in a helper with "set" as the verb is super weird.
