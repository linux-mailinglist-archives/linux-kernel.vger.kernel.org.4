Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2256C3932
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCUSaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCUSaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:30:14 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157224391C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:30:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w133so11845202oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679423412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR2L5ssyoNX1DS+2yU8J8y2e0fQMhmy1KklHHGVtM9M=;
        b=K/XNWG9WcsCbmZOpWg1P5w1gPHOqenS564JrNPjrLscyh889UAuoYHbY1sP2/9PWSD
         j4yaur5EY5ET3sargDhiDzN43OXEUZAretK+X8xWcn2RRrrDg+4O4OnG64h0LCFHMIVy
         LeV4mAW2YXTaoyCneeS7SDQZlSkx0MPHg0Ws2cT9C8Uyl3oC6CXYqG3CFHwi8yNl1/uz
         0Ik7zGJ8YA5GH4SE6/hGslnhtc3jrvS3yu14GmuNtjGSmBKnkCwvnFIlYOpefzUyn+UX
         4DHn4X6SryoD8+Ql2SeoctJolx7AzTFaiGsikxs139GFHhtoKTZFCkjOFUjoEXdAAdis
         kYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uR2L5ssyoNX1DS+2yU8J8y2e0fQMhmy1KklHHGVtM9M=;
        b=p7xrto8bMM1p7F54WMbkEQ96/z5nxdBT0/yuIQQbEsR3F7cGYb23tqfWFfEkcAH4V9
         nV4F2zUTqQ1rghm+1JZB8hlWe6VNsTkSm9OFeJC+Np8H4sT36tBWJS5aHUneB0gWuxUC
         2RwILwH6XEbodKoGM4TJVhVjk2Zo+YBdTPR6//fZ5CUoA+JANO8BDsD9JbBA23zUBbZ0
         WVBwbNRkTpJB8le+rkBYGqFxW9OEsZ3rcDSVxZ+vEVHFcw4rHtr9B82YpXtp183Yv9DY
         76S+OMs2Xm7UPXzJJV+Oz1DNBZDLjX8Gubxk2ZVZvKo+rnYgQ7Rj74LwWSA+XOlkCJ/o
         B8ZA==
X-Gm-Message-State: AO0yUKUaLlBOF8ArA7naMdFFk5l7VwApKPseHqGJ/fxtCN8YVade03+h
        quDKzNv3rGSQ3VzR3hEvEmxgn7H/j8Gz862Qp/J8gg==
X-Google-Smtp-Source: AK7set/MD1mENLDDCQxgddxuXO7UKTS/6BUQ6ohGmiWWxM9gCmTwfU0AU5sWF8J7iw6SAvGy56nVqJizhbTthK5jpQ8=
X-Received: by 2002:a54:400a:0:b0:384:27f0:bd0a with SMTP id
 x10-20020a54400a000000b0038427f0bd0amr33142oie.9.1679423412200; Tue, 21 Mar
 2023 11:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230201132905.549148-1-eesposit@redhat.com> <CALMp9eTt3xzAEoQ038bJQ9LN0ZOXrSWsN7xnNUD+0SS=WwF7Pg@mail.gmail.com>
 <CABgObfYKrn86hteXV0Cc_CDuMC170nuynCM9zW_QvtvKsOh8nw@mail.gmail.com>
In-Reply-To: <CABgObfYKrn86hteXV0Cc_CDuMC170nuynCM9zW_QvtvKsOh8nw@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 21 Mar 2023 11:30:01 -0700
Message-ID: <CALMp9eQ+U3SLt=KOti=xF2cXCV0oJSpMOGXfj9uhe7m=_57R+Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: support the cpu feature FLUSH_L1D
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org, Ben Serebrin <serebrin@google.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 21, 2023 at 2:43=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Mon, Mar 20, 2023 at 5:52=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> > > Patch 1 and 2 are just taken and refactored from Jim Mattison's serie=
 that it
> > > seems was lost a while ago:
> > > https://patchwork.kernel.org/project/kvm/patch/20180814173049.21756-1=
-jmattson@google.com/
> > >
> > > I thought it was worth re-posting them.
> >
> > What has changed since the patches were originally posted, and Konrad
> > dissed them?
>
> What has changed is that the reporting of mmio_stale_data now
> piggybacks on flush_l1d as well.
>
>         if ((ia32_cap & ARCH_CAP_FB_CLEAR) ||
>             (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
>              boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
>              !(ia32_cap & ARCH_CAP_MDS_NO)))
>                 mmio_mitigation =3D MMIO_MITIGATION_VERW;
>         else
>                 mmio_mitigation =3D MMIO_MITIGATION_UCODE_NEEDED;
>
> Maybe Intel only defines CPUID bits after a firstborn has been
> sacriificed to the microcode gods?
>
> Paolo
>

Ha!

As I wrote way back when, "It is more forward-thinking to provide this
capability than it is not to."

I feel vindicated. :)
