Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7B6C2E26
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjCUJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCUJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533352F06C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679391819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCfFOoa6hae9cECKuPk2jis1MBGDH/oETlXS6Dyew04=;
        b=YhCgz/K1dIbjLeqT2K19sCt5puI8Gp9/JeUimP8CRrynER9FJ81AnFPuQ+PS001Vdj2j+d
        xwGOKP6YrUS7BkVtCVEzvutsVNF5rtv7IfKIFBQ0WNVsgDjDZ8glzNTf5jUrjntAyIZHOu
        DtdmHtNAmfAuNMxAmrfLi28xYrGcJio=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-a8bKnRpzOj6iZC_tuiLWTg-1; Tue, 21 Mar 2023 05:43:36 -0400
X-MC-Unique: a8bKnRpzOj6iZC_tuiLWTg-1
Received: by mail-ua1-f72.google.com with SMTP id az28-20020a056130039c00b00760f945d47bso4306301uab.16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679391816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCfFOoa6hae9cECKuPk2jis1MBGDH/oETlXS6Dyew04=;
        b=KcDGpzPn8VdZtNP/XAEzs5pUf+/azq4wzfqNtAhNHh2GCtonoVfMUqZx8eu5Jjl0FP
         4lz5k+8yvdAyTEtk8GjE9krjV2dnOXjzGrKC/7C6ozP3Rb7tqVz+0GvoVe4LZTBhKImV
         D8jh4zNuuOAeqC51dIdoTResVg7IOfK8vJ94wCxxntnHNIT0Dnzoc0oMIIWm32UMUidP
         n5SNeoI00CIrKJM389BrycjEIkfQ8cNichRn2K/t7fcg8FhCHsazF6of5xm9FQPKru7B
         kItSQFJsoIxR1wabDIkt6ra83q5n/6zcagN4vKFgbZhdLNMtTuDdr37TUycwrl6tbs0m
         G7WA==
X-Gm-Message-State: AO0yUKUxQApzhQsldjfQa1bCpnJox7YPAlfet0QjVMrWcSCqlRRWinVX
        0JjMhOnlf/bcpoW9G3LcEg0I7QXFg52D7YobVMbAyNjXI1Jfs5QOTtg2eakuo6fIC0bVIuMGaSf
        I8rucnJXPn4XRPKilBPQbHhAOfVyjcZklKdrF8rGZ
X-Received: by 2002:a67:c813:0:b0:425:d4de:718a with SMTP id u19-20020a67c813000000b00425d4de718amr1052813vsk.1.1679391815859;
        Tue, 21 Mar 2023 02:43:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set9YVepBaAvHnATyATuViDgQjSN7+zvT2xoWVk8h4GuJZVFtQvIJcDTesuTfuZ05XfH1yDGOBDRZzr0ICTE64K4=
X-Received: by 2002:a67:c813:0:b0:425:d4de:718a with SMTP id
 u19-20020a67c813000000b00425d4de718amr1052801vsk.1.1679391815565; Tue, 21 Mar
 2023 02:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230201132905.549148-1-eesposit@redhat.com> <CALMp9eTt3xzAEoQ038bJQ9LN0ZOXrSWsN7xnNUD+0SS=WwF7Pg@mail.gmail.com>
In-Reply-To: <CALMp9eTt3xzAEoQ038bJQ9LN0ZOXrSWsN7xnNUD+0SS=WwF7Pg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 21 Mar 2023 10:43:24 +0100
Message-ID: <CABgObfYKrn86hteXV0Cc_CDuMC170nuynCM9zW_QvtvKsOh8nw@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: support the cpu feature FLUSH_L1D
To:     Jim Mattson <jmattson@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 5:52=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
> > Patch 1 and 2 are just taken and refactored from Jim Mattison's serie t=
hat it
> > seems was lost a while ago:
> > https://patchwork.kernel.org/project/kvm/patch/20180814173049.21756-1-j=
mattson@google.com/
> >
> > I thought it was worth re-posting them.
>
> What has changed since the patches were originally posted, and Konrad
> dissed them?

What has changed is that the reporting of mmio_stale_data now
piggybacks on flush_l1d as well.

        if ((ia32_cap & ARCH_CAP_FB_CLEAR) ||
            (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
             boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
             !(ia32_cap & ARCH_CAP_MDS_NO)))
                mmio_mitigation =3D MMIO_MITIGATION_VERW;
        else
                mmio_mitigation =3D MMIO_MITIGATION_UCODE_NEEDED;

Maybe Intel only defines CPUID bits after a firstborn has been
sacriificed to the microcode gods?

Paolo

