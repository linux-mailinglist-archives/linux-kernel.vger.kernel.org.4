Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0139F72CBEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjFLQ5R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjFLQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:57:15 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDD619C;
        Mon, 12 Jun 2023 09:57:14 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f7364c2ed8so11397445e9.0;
        Mon, 12 Jun 2023 09:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589032; x=1689181032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fdthmW3uN8vm/z0fYcR0kZV9BTQdLtqnyjec8VowSA=;
        b=F8kPyM0WZj95oRzQx1yfLfDmF+pzHFQlKysPiMf6SUyd7ylmznWuLLqNNE7oj9susr
         OhEZBxV9uxpe2ZyrTFJDSKwx3iWcCX9akdoFvLHiO6gNyNEATb83eKqe+dAES3Sq9ztV
         JKyP2G+DYdhIGkJgWFYCbgTFPGop8TrkJDzKuqnUl5VolY4cKJo0kxtUcqCH8Ly3dro6
         YEiNpgpQCPnvhK/srnkkMH129ln2Xov4im+ecLuIjDxkNumLvlP+5N2ZWTCy+CYsbvze
         Q0gvukLUILEvqxw90/z1kuJfdkg+G3YNWxWMhYxD1Rhb3rwjYzVTAjCsq01EQV3ayDQu
         cqxw==
X-Gm-Message-State: AC+VfDxHHvKnNqkR4dYCr/CCoKgRx1la1K55NNtT5QXoYfY0q8JSIJCT
        N+f44BiRdvvna6sYrdtz0+WYJQwNeO5GQi+Ythu7+LVK
X-Google-Smtp-Source: ACHHUZ65gnKfYcpfpwnZX1IYq/N10F99bzWWdkwUBfUZkrTQoGAXV/b0lYyby/w6hqMeOnUSHUgbn4ezALjlh7MkLTM=
X-Received: by 2002:adf:e9d2:0:b0:30c:fdac:ef57 with SMTP id
 l18-20020adfe9d2000000b0030cfdacef57mr6152290wrn.0.1686589032388; Mon, 12 Jun
 2023 09:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230607034403.2885-1-james.liu@hpe.com> <CAJZ5v0hTsEzFKvRf-MHpUxyJdFDUqc2ZL63s6BkyJyFtEzxvhw@mail.gmail.com>
 <ZIGbBF+GxHAlTqGk@ILEIUN5Z4B.asiapacific.hpqcorp.net>
In-Reply-To: <ZIGbBF+GxHAlTqGk@ILEIUN5Z4B.asiapacific.hpqcorp.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 18:57:01 +0200
Message-ID: <CAJZ5v0iR+CAOwip0zPV1uug-0duJXFS4YMxwNWDntUnK6a+oQQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: reboot: Increase the delay to avoid racing after
 writing to ACPI RESET_REG on AMD Milan platforms.
To:     James Liu <james.liu@hpe.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mlangsdo@redhat.com, craig.lamparter@hpe.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 11:14 AM James Liu <james.liu@hpe.com> wrote:
>
> On Wed, Jun 07, 2023 at 01:19:42PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 7, 2023 at 5:44 AM James Liu <james.liu@hpe.com> wrote:
> > >
> > > For AMD Milan platforms, the delay of 15ms is insufficient to avoid racing
> > > of reboot mechanisms. That said, the AMD Milan processors don't reboot
> > > in 15ms after invoking acpi_reset().
> > >
> > > The proposed 50ms delay can effectively work around this issue.
> > > This extended delay aligns better with ACPI v6.4 (i.e., sec. 4.8.4.6),
> > > which indicates that ideally OSPM should execute spin loops on the CPUs
> > > in the system following a write to this register.
> > >
> > > Signed-off-by: James Liu <james.liu@hpe.com>
> >
> > Why do you want to affect everyone (including guest kernels running in
> > virtual machines AFAICS) in order to address a problem specific to one
> > platform?
>
> I hoped to address this issue for any platform requiring a longer delay to
> complete ACPI reset in time for any (maybe silicon-level) reasons. Some AMD Milan
> platforms were the cases that we've found so far.

Do you know about any other?

> Except that, since ACPI spec indicates there should be a spin loop (long enough)
> after the write instruction to Reset Register, I thought it should be no harms to
> the other systems which well consider this spin loop when they claim to support
> ACPI reboot.
>
> Btw, I am just curious, why is the virtual machine mentioned here?

The new delay would be over 3 times larger, so some users might be
surprised by it at least potentially.

> is the 50ms delay in acpi_reboot() for a guest OS on VM so long that some
> unexpected behavior might happen?
>
> > Wouldn't it be better to quirk that platform and document the quirk properly?
>
> Yeah, it could be. Actually we considered this, and we will consider it again.
>
> > > ---
> > >  drivers/acpi/reboot.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> > > index b79b7c99c237..002f7c7814a1 100644
> > > --- a/drivers/acpi/reboot.c
> > > +++ b/drivers/acpi/reboot.c
> > > @@ -78,5 +78,5 @@ void acpi_reboot(void)
> > >          * The 15ms delay has been found to be long enough for the system
> > >          * to reboot on the affected platforms.
> > >          */
> > > -       mdelay(15);
> > > +       mdelay(50);
> > >  }
> > > --
