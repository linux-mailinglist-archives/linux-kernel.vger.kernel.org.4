Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216816C57DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjCVUmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCVUmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:42:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB64848DB;
        Wed, 22 Mar 2023 13:34:28 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id e71so22574429ybc.0;
        Wed, 22 Mar 2023 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679517268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiCmR8SN+GLyUIUi6qfPNaqR2nTEBZHOI1Achc59hqY=;
        b=GYzbYtSRXmK3Ib4jq8P5EgFEy/9nL4KPrIy4QfUsI6ofktsoYPdRWrkN171WmTJiUP
         iskkjLojIgwXTZcToFnONt83DU8a8UUd9/zfRgChVJ1k4yvmbYK9As+yhGQvYcqSRc7n
         kuF+kdIuxuKHrLXi9ta2Gn8SBRMOnGeIU/lFZ/rleSjifKLWwaxetRHqHvFfEKrsSEi5
         b6vmFkHnQyKbzlcgBraFVcqoiYFO4strpoDG0WZVzKcDtclN76oRvLzmTciKzkrHeCFR
         q18hq7QoHCpGIDfC/xNeplcjJIaJEAT1jUfr3iqK2FWOYnOVGfcMKKO5j7SDubcoHHob
         eh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679517268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiCmR8SN+GLyUIUi6qfPNaqR2nTEBZHOI1Achc59hqY=;
        b=drr0N+gcqJ6Nmz7DzLbaozlARjariWO6A2sSB2MZqHLVt97idP6stmkngAGGAjSNK1
         SN6wTIYwY7dLtLaVzzI1GzEH8uv3y/uutlRsMFE5j4XOOSNNVvfA6WFKJl6Eb41AdJL/
         oxK7h5k+290vDiYFlDQ/KASw09vHru0G7cpfp0a5gwZeu5t3QDlk2/Utk/lGG/qIin2K
         TgPQyOg/RISDoHoco/MWUVPX/6cm5O2A4K/OY7blCDVZo8dDQkyaqKb1iFforKcru0FI
         sDGdQ5+BDXmmSZwmuQNcRRgHDK5vFtFSXi1SM4EgUxbGrqME7vHHsLaqB/CT5z15LLD8
         Nk6A==
X-Gm-Message-State: AAQBX9fzq9bQrxvlk9RVxIS5TfEqzt34EwKr+/wmjJpCSktqbAqtik43
        tGmh6Pd8OIg+ok9qZLxwaC7c2THk7jfi+upge5njMQ4tyEmcrQ==
X-Google-Smtp-Source: AKy350barmhAn2AE7ZHYIUsODj2m0RDoHWh0vsLit55+EPuL9XTzx/ZG5/S2fMbnhO9vXdsk3BCjKg46pWwSAoCj18U=
X-Received: by 2002:a25:8712:0:b0:b6a:2590:6c7f with SMTP id
 a18-20020a258712000000b00b6a25906c7fmr626401ybl.2.1679517267591; Wed, 22 Mar
 2023 13:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230320212012.12704-1-ubizjak@gmail.com> <CAJZ5v0jAysMPb180tMMmoGBEewENKn-fW7bwzGyMVv4wUrX=LA@mail.gmail.com>
 <18431bad-8595-143b-e8af-14e448af871c@intel.com>
In-Reply-To: <18431bad-8595-143b-e8af-14e448af871c@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 22 Mar 2023 21:34:16 +0100
Message-ID: <CAFULd4YF7L2puma8O9m_hodjRP9tOyBDixpY-=ShPHjdbX8cGA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/ACPI/boot: Improve __acpi_acquire_global_lock
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 7:34=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 3/22/23 11:24, Rafael J. Wysocki wrote:
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > or please let me know if you want me to pick this up (in which case it
> > will require an ACK from one of the x86 maintainers).
>
> I'll pull it into x86/acpi.  I'm kinda shocked the compiler is so
> clueless, but this makes the C code more readable anyway.  Win/win, I gue=
ss.

Please note that the return form __acpi_{acquire,release}_global_lock
is actually used as bool:

acenv.h:

int __acpi_acquire_global_lock(unsigned int *lock);
int __acpi_release_global_lock(unsigned int *lock);

#define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq) \
((Acq) =3D __acpi_acquire_global_lock(&facs->global_lock))

#define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq) \
((Acq) =3D __acpi_release_global_lock(&facs->global_lock))

evglock.c:

acpi_status acpi_ev_acquire_global_lock(u16 timeout)
{
    ...
    u8 acquired =3D FALSE;
    ...
    ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
    if (acquired) ...
}

acpi_status acpi_ev_release_global_lock(void)
{
    u8 pending =3D FALSE;
    ...
   ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_FACS, pending);
   if (pending) ...
}

These functions are also defined for ia64, so I didn't want to change
the return value. But ia64 is going to be retired, and this opens the
optimization opportunity.

Uros.
