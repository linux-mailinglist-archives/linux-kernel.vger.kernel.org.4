Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079D737114
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjFTP7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFTP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1480E6E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687276701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/tE3ev0g8e1y9g4CsJ2+r9XXgqalzuXCzQEqqZs90A=;
        b=B1e5wlFYJ6b9F5kUZiDkYVTv5zI7UOQ/IsjAtrMm0vYt8TFIfrP7iZoh4w6uL1OUBIWvJv
        5d1TeeDXgQZzJhbkpIvAjZBCgV8eVx6mTQZcv1kYD/fnP9jT8uuIoVqAdwARmyLhEo1nHJ
        9uPVXkwcysTdqdl3MQtjvamGVGw+uUs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-dwj8_-0aPG256_Bhd1W0Eg-1; Tue, 20 Jun 2023 11:58:18 -0400
X-MC-Unique: dwj8_-0aPG256_Bhd1W0Eg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ff28b6fd0eso16091361cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687276693; x=1689868693;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/tE3ev0g8e1y9g4CsJ2+r9XXgqalzuXCzQEqqZs90A=;
        b=XQEoNekUfWpf1L52LKXcQbefbfJOcyb3HYHSKF36wCmA3waUIut1K/V1tzFZZIIklO
         XldbsLkXSjSd3nNxWEqmzJ3neDO7fS6V0n2FTGtRLYTPFaVFhIbrRPIK4gndxwo9l5MK
         CGilig5r4+LVqaNiropEmPmfh5qNQNJDZajQA3WHHlo3Gn2wDodwcDiMx9OaDH9+jMaZ
         Rwp7IdH/FLvmAl3vT9EWG+IsAqCGfMFiSpYLzTyjANRuuepTMCd5SrLq1Su3PqtZ9JtE
         1fs95uMjAVhmKM7MZsmEVmcwWpIs4L6549dEdKiQ++AzGtnmSMWfVBC4XhmFwMlCNbbv
         UATw==
X-Gm-Message-State: AC+VfDzl8KC4UI26OrJdm2qzUWLpWatLr6fwOGv5i3qATZYlIvDZTqBC
        5CwiC4J4KHrDz46Y2gW67V22MnXuZGYuu7oo+1ROAzRj49nhWSAKiiONzhBHt01sfxrCJdtH8nu
        +xqVCcrLqczT7uoKxax+aFA3I
X-Received: by 2002:a05:622a:104c:b0:3f0:b4ee:6f4c with SMTP id f12-20020a05622a104c00b003f0b4ee6f4cmr15454281qte.41.1687276693222;
        Tue, 20 Jun 2023 08:58:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4v7nDdm/Fl9QsKaBHbSk10XuUkG24jlQPgUrA06r/yP8u5YCHeSWdvjTANvV8r7QI9/V489Q==
X-Received: by 2002:a05:622a:104c:b0:3f0:b4ee:6f4c with SMTP id f12-20020a05622a104c00b003f0b4ee6f4cmr15454264qte.41.1687276692928;
        Tue, 20 Jun 2023 08:58:12 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id z21-20020ac875d5000000b003f6be5256d5sm1251984qtq.19.2023.06.20.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:58:12 -0700 (PDT)
Message-ID: <d3b32b23c79f78ea99316bae77fab2064833d8e7.camel@redhat.com>
Subject: Re: [RFC PATCH 0/5] irq: sysfs interface improvements for SMP
 affinity control
From:   Radu Rendec <rrendec@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 20 Jun 2023 11:58:11 -0400
In-Reply-To: <877csohcll.ffs@tglx>
References: <877csohcll.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-31 at 15:09 +0200, Thomas Gleixner wrote:
> On Tue, May 30 2023 at 17:45, Radu Rendec wrote:
> > Note: I still need to update the Documentation/ directory for the new
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs interface, and I will address that=
 in a future version.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 At this point, I just want to get feedba=
ck about the current
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 approach.
>=20
> From a conceptual POV I understand why this is required, which makes me
> hate this chained mechanism even more.
>=20
> Aside of having no visibility (counters, affinity, etc) the worst thing
> about these chained hidden interrupts is:
>=20
> =C2=A0 There is no control of runaway interrupts as they circumvent the c=
ore,
> =C2=A0 which has caused hard to diagnose system hangups in the past. See
> =C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 ba714a9c1dea ("pinctrl/amd: Use regular interrupt inst=
ead of chained")
>=20
> =C2=A0 for demonstration.
>=20
> The argument I heard for this chained interrupt muck is that it's so
> much more performant than using regular interrupt handlers via
> request_irq(). It's obviously less overhead, but whether it matters and
> most importantly whether it justifies the downsides is a different
> question.
>=20
> There is also the argument about double accounting. Right now the
> chained handler is not accounted and only the childs are.
>=20
> Though that is inconsistent with other demultiplex handlers which _must_
> use regular interrupt handlers (threaded) to demultiplex interrupt chips
> which sit behind SPI/I2C...
>=20
> The sum of child interrupts is also not necessarily the number of parent
> interrupts, unless there is always exactly only one child handler to
> invoke.
>=20
> Quite some of those demux handlers are also not RT compatible.
>=20
> AFAICT, there is no real technical reason at least not for the vast
> majority of usage sites why the demultiplex handler cannot run inside a
> regular interrupt handler context.

I was about to send an RFC patch that converts a multiplexing IRQ chip
driver from chained to regular interrupts, when I realized I had come
full circle. Marc rejected a similar patch in the past [1] and the main
argument was that exposing the parent interrupt in procfs is backwards
incompatible. Quote:

 The problem of changing affinities for chained (or multiplexing)
 interrupts is, to make it short, that it breaks the existing userspace
 ABI that a change in affinity affects only the interrupt userspace
 acts upon, and no other. Which is why we don't expose any affinity
 setting for such an interrupt, as by definition changing its affinity
 affects all the interrupts that are muxed onto it.

So, there are two contradictory arguments here:
 * Chained interrupts are "muck", mainly because they circumvent the
   interrupt core and prevent the interrupt storm detector from kicking
   in when hardware misbehaves (and for other reasons as well).
 * Exposing the parent interrupt affinity control in procfs breaks the
   userspace ABI because all child interrupts inherently share the same
   affinity settings. This implies regular interrupts cannot be used.

Meanwhile, both interrupt storms and the lack of affinity control
support for multiplexing drivers are real problems, and my team and I
came across both. FWIW, the interrupt storm is the one we found more
recently, and it's the reason why I wanted to send that RFC patch I
mentioned before.

Is Marc's argument still relevant? Perhaps with both arguments in the
same email it becomes clearer that there needs to be some alignment at
the maintainer level. I would be more than happy to send patches and
help fix both issues. But I think that's not possible until you come up
with a strategy that you *both* agree to.

[1] https://lore.kernel.org/all/874k0bf7f7.wl-maz@kernel.org/

Thanks,
Radu

> So I personally would prefer to get rid of this chained oddball and just
> have consistent mechanisms for dealing with interrupts, which would just
> avoid exposing the affinity files in two different places.
>=20
> Providing information about child/parent relationship is an orthogonal
> issue.
>=20
> If there is some good reason (aside of the chained muck) to have sysfs
> based affinity management, then I'm not objecting as long as the
> functionality is the same, i.e. effective affinity needs be exposed too.
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx

