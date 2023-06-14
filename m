Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5E27308DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjFNT53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjFNT50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:57:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82562101;
        Wed, 14 Jun 2023 12:57:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51640b9ed95so11989846a12.2;
        Wed, 14 Jun 2023 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686772643; x=1689364643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLPwTDo5gV4mqPvwKixQb840PKI9upvdKNQ9cbYW6Q8=;
        b=W2ov78I2fLzdyXFyjae1BbXmaJ7z/RMkaXP6zaB5hIFrlBcHlW7BTNBSt0QXWBZeA+
         FvjbNDAiNe8OJ3AdGVfCE83tlA3oQNReMQuYRr2V7TpYf6KPAIZcbf3ArQt0Qf0/tr1l
         amIBTKFg2Oi0uwX4lGLakw97Lprl8rBVx6iDuoSJoPAKgi7Ego/T91c5XUYZjPbowZlb
         L0pjIH3s9iCc0ol2fEzUAkFW6zM6AtKS7TbEEhOqCbzWyqxyujC09hyFgTgcTCAdT+jv
         VZ6lvf86Hyx0YhVji+W0UvoxYEK5QqXxP0SREU2e31HkPc75jS+vrpdYWTku1SVy/rFG
         IXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686772643; x=1689364643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLPwTDo5gV4mqPvwKixQb840PKI9upvdKNQ9cbYW6Q8=;
        b=iekvgzvVEcuCi8D9UAi8C/JsE27e02OXPKrNPRfhoTo5b3RXN5Uc9xNWxrCan50Oei
         Qsna1HJK0YvY6JYFEC8EfwsznKJLHYGmhsFvedlpxQjAIkiyyudG3vqAHYvcN4omCh1A
         k+KD9dKO2eZmmrkFnBZDdvmSArzZa++NI+hvdeQIq26j4Thxvy+RlgQwvkn5GTsZsHGc
         Ypu0GlecJ8bj6Qem3xBSjfzLZIFXGFgPBtUP2kRDxwujHd+F3T5EePOEEYlkSHDJ320t
         8LRZgiFM3k6CecMSQ7Z365+bCIafgdyZLDnDwsY95ip06kE1DKEvXseLRkwE6Ky1uA3Q
         DNcA==
X-Gm-Message-State: AC+VfDzLO9VGC4mRrBr5w54AVWevFeecIGXIpFxDG7nLHLfCp4UGyARs
        GhohKGvE6QGF63ueToONufR1tCZola84KC5irrk=
X-Google-Smtp-Source: ACHHUZ4oTxUd1zwcNKSxEXWe/7DXGacs3lHbk1VkUT+4f2hzAvNapDLX1fEpElzJYAchKAT6G391OLBoYz2yHVDnOho=
X-Received: by 2002:a05:6402:34c:b0:50d:1e11:eb9 with SMTP id
 r12-20020a056402034c00b0050d1e110eb9mr10572574edw.1.1686772643127; Wed, 14
 Jun 2023 12:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221121102113.41893-1-roger.pau@citrix.com> <20221121102113.41893-3-roger.pau@citrix.com>
 <bac0ed0f-6772-450b-663c-fc0614efa100@suse.com> <Y3uTTAWxe/676t3q@Air-de-Roger>
In-Reply-To: <Y3uTTAWxe/676t3q@Air-de-Roger>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Wed, 14 Jun 2023 15:57:11 -0400
Message-ID: <CAKf6xptcWkdqELORESF1V9eeb-DFHS0UMumQbLYL1-Fgg0LhXg@mail.gmail.com>
Subject: Re: [PATCH 2/3] acpi/processor: sanitize _PDC buffer bits when
 running as Xen dom0
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xenproject.org,
        jgross@suse.com, stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roger,

On Mon, Nov 21, 2022 at 10:04=E2=80=AFAM Roger Pau Monn=C3=A9 <roger.pau@ci=
trix.com> wrote:
>
> On Mon, Nov 21, 2022 at 03:10:36PM +0100, Jan Beulich wrote:
> > On 21.11.2022 11:21, Roger Pau Monne wrote:
> > > --- a/drivers/acpi/processor_pdc.c
> > > +++ b/drivers/acpi/processor_pdc.c
> > > @@ -137,6 +137,14 @@ acpi_processor_eval_pdc(acpi_handle handle, stru=
ct acpi_object_list *pdc_in)
> > >             buffer[2] &=3D ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH)=
;
> > >
> > >     }
> > > +   if (xen_initial_domain())
> > > +           /*
> > > +            * When Linux is running as Xen dom0 it's the hypervisor =
the
> > > +            * entity in charge of the processor power management, an=
d so
> > > +            * Xen needs to check the OS capabilities reported in the=
 _PDC
> > > +            * buffer matches what the hypervisor driver supports.
> > > +            */
> > > +           xen_sanitize_pdc((uint32_t *)pdc_in->pointer->buffer.poin=
ter);
> > >     status =3D acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
> >
> > Again looking at our old XenoLinux forward port we had this inside the
> > earlier if(), as an _alternative_ to the &=3D (I don't think it's valid
> > to apply both the kernel's and Xen's adjustments). That would also let
> > you use "buffer" rather than re-calculating it via yet another (risky
> > from an abstract pov) cast.
>
> Hm, I've wondered this and decided it wasn't worth to short-circuit
> the boot_option_idle_override conditional because ACPI_PDC_C_C2C3_FFH
> and ACPI_PDC_C_C1_FFH will be set anyway by Xen in
> arch_acpi_set_pdc_bits() as part of ACPI_PDC_C_CAPABILITY_SMP.
>
> I could re-use some of the code in there, but didn't want to make it
> more difficult to read just for the benefit of reusing buffer.
>
> > It was the very nature of requiring Xen-specific conditionals which I
> > understand was the reason why so far no attempt was made to get this
> > (incl the corresponding logic for patch 1) into any upstream kernel.
>
> Yes, well, it's all kind of ugly.  Hence my suggestion to simply avoid
> doing any ACPI Processor object handling in Linux with the native code
> and handle it all in a Xen specific driver.  That requires the Xen
> driver being able to fetch more data itself form the ACPI Processor
> methods, but also unties it from the dependency on the data being
> filled by the generic code, and the 'tricks' is plays into fooling
> generic code to think certain processors are online.

Are you working on this patch anymore?  My Xen HWP patches need a
Linux patch like this one to set bit 12 in the PDC.  I had an affected
user test with this patch and it worked, serving as an equivalent of
Linux commit a21211672c9a ("ACPI / processor: Request native thermal
interrupt handling via _OSC").

Another idea is to use Linux's arch_acpi_set_pdc_bits() to make the
hypercall to Xen.  It occurs earlier:
acpi_processor_set_pdc()
    acpi_processor_alloc_pdc()
        acpi_set_pdc_bits()
            arch_acpi_set_pdc_bits()
    acpi_processor_eval_pdc()

So the IDLE_NOMWAIT masking in acpi_processor_eval_pdc() would still
apply.  arch_acpi_set_pdc_bits() is provided the buffer, so it's a
little cleaner in that respect.

Thanks,
Jason
