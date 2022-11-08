Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37421621AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiKHRku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiKHRkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:40:39 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7DA528B3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:40:37 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id e123so13936578ybh.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0pEFENNnYPCzo/HA8HAcobUswxlB4sH3bwnAUXJdnmc=;
        b=L+o7B57z8N1w+FGZgs9tFm9SQ2vS6AajEJXJ0wxuQOrY214HHpcysobwIuPNofDBLD
         Z+aq3/u2+84ZSqJ90xy6PFc7XWrKcUhyP8syDeJ6X2gl2l74Zsjf/SxvNPKp+sCAl+I1
         dFCPnjVyidM95nmRzd+MH1K6cmRD5IIihyXRCf2jAON8f+AKJKQ77TKO4HA/+JCsV+E5
         Bu2GFucBVVmj0wM0pk0/t8PSZxRwnxtwi4KnXM+zf5/OY+YXHXDSufR1qo+gm8EYxbXF
         jzd0ytFDznJYTh0TfZwSVnXc0C6dwyYFOwQduL1TQsmRDqN9HYlOrofECHWNuMtPSLvV
         Vzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pEFENNnYPCzo/HA8HAcobUswxlB4sH3bwnAUXJdnmc=;
        b=XQNwBFJdDPFjFDKQ4tD85DwRzwtzd8pfrOAmX22nLMqEVSsMtAe0WpGgIsIY7D4Ffm
         Qp2plB5/AeGycsromXT/d5z8HdQecHUFeb6aTTH4xw8x4yRq4qJR7K8ha2nCkjtG9rBJ
         BLRvrDgxTeNVAgLIWzMl7gMLJRdXsjpGTJyBIH/uf3kPWyEW7VsWQmG65WwRiuQWKeTI
         c8gVu/g9O/ufWK7Sw6ivfre2ihSzrCUqYi3jyri3gZ5UuVBfhGnROuYCeWvnhJiVjQFr
         0RIuz6XMk5bpe8N7+EoVkzG4pdfPc3M6NiR4EfWTmjAa5Qj+kvtOzzXsnOw0JDHiYykE
         tLLA==
X-Gm-Message-State: ACrzQf1UPvf0+lSyUaidZ2yzhwSiINAOFy+tHClTHS5TmFj+XgNjvRW9
        rzWNrnVQqQNyimXN37b5fp6l9MsYY8cAlUJ7Tgg6+g==
X-Google-Smtp-Source: AMsMyM630slUuwA2yHI+5rrzisOZS6FXFWCgSpSU9LF0QRHhGi2OWrBHDhkUlz/mi1RtxLC9qc3tSdn4j4mxidhkaFU=
X-Received: by 2002:a25:fb07:0:b0:6d1:a9c:3580 with SMTP id
 j7-20020a25fb07000000b006d10a9c3580mr30897999ybe.191.1667929236877; Tue, 08
 Nov 2022 09:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20221105045704.2315186-1-vipinsh@google.com> <20221105045704.2315186-6-vipinsh@google.com>
 <Y2lO1HQtaMBCGpcZ@google.com> <CAHVum0c2QVyuxQxOQHOxmU2csgE1RHtJ7nLBWCHt6=ywuB-Tmw@mail.gmail.com>
In-Reply-To: <CAHVum0c2QVyuxQxOQHOxmU2csgE1RHtJ7nLBWCHt6=ywuB-Tmw@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 8 Nov 2022 09:40:09 -0800
Message-ID: <CALzav=cS+WAiG63g=YCev5oKi-3MAe2HxDHrjRTk-6aOpzE-ag@mail.gmail.com>
Subject: Re: [PATCH 5/6] KVM: selftests: Move hypercall() to hyper.h
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 5:49 PM Vipin Sharma <vipinsh@google.com> wrote:
>
> On Mon, Nov 7, 2022 at 10:30 AM David Matlack <dmatlack@google.com> wrote:
> >
> > On Fri, Nov 04, 2022 at 09:57:03PM -0700, Vipin Sharma wrote:
> > > hypercall() can be used by other hyperv tests, move it to hyperv.h.
> > >
> > > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > > ---
> > >  .../selftests/kvm/include/x86_64/hyperv.h       | 17 +++++++++++++++++
> > >  .../selftests/kvm/x86_64/hyperv_features.c      | 17 -----------------
> > >  2 files changed, 17 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> > > index 9d8c325af1d9..87d8d9e444f7 100644
> > > --- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> > > +++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> > > @@ -199,4 +199,21 @@ static inline uint64_t hv_linux_guest_id(void)
> > >              ((uint64_t)LINUX_VERSION_CODE << 16);
> > >  }
> > >
> > > +static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
> > > +                             vm_vaddr_t output_address, uint64_t *hv_status)
> > > +{
> > > +     uint8_t vector;
> > > +
> > > +     /* Note both the hypercall and the "asm safe" clobber r9-r11. */
> > > +     asm volatile("mov %[output_address], %%r8\n\t"
> > > +                  KVM_ASM_SAFE("vmcall")
> > > +                  : "=a" (*hv_status),
> > > +                    "+c" (control), "+d" (input_address),
> > > +                    KVM_ASM_SAFE_OUTPUTS(vector)
> > > +                  : [output_address] "r"(output_address),
> > > +                    "a" (-EFAULT)
> > > +                  : "cc", "memory", "r8", KVM_ASM_SAFE_CLOBBERS);
> > > +     return vector;
> > > +}
> >
> > Since this function is Hyper-V specific it probably makes sense to
> > rename it to hyperv_hypercall() as part of moving it to library, e.g. to
> > differentiate it from kvm_hypercall().
> >
>
> Sounds good. Does it keeping it in header file "hyperv.h" seems fine
> or should I create a new "hyperv.c" lib file and move function
> definition there?

I think it's fine to keep in hyperv.h. It seems like the type of
function we'd want to be inlined anyway, and the implementation is
short.
