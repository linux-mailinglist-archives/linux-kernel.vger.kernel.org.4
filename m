Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75964718ED3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEaWzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaWzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DEE95
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685573655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HREIG2MBPLjnLa1+3TecqEIgNm7GNuAK97wz33u5zLA=;
        b=YXxGDo3JuyXBSSnied7fSXskzQkFHGx4cLbUCu/vXvYunB+6sk+QJVr0fqwhbaiYtGDn8I
        EmbT4nZCePJpZ9t35WeyGWMaXd0GHVUBwQAxQx23GqzRdbWuTsfs1KiL1hXV2k4iCUz6Uz
        l7u+UbFq6DTcqXHhZcPhqb/lnC9+ySs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-N4ytsdvYOdSXtYswW2zSMg-1; Wed, 31 May 2023 18:54:14 -0400
X-MC-Unique: N4ytsdvYOdSXtYswW2zSMg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62609400a6fso4011526d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685573654; x=1688165654;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HREIG2MBPLjnLa1+3TecqEIgNm7GNuAK97wz33u5zLA=;
        b=SdIBqZ5cczaBqbBPFeL9a3IB9I82zY3gXfAlcsv17EoYAJHGJzvc0a8Kx9KNBFXOSs
         h86JAAuC2fXwMPr/Kw6e7DT29rJVUkZuhXHF0EljSxCOlwQxXRqRQFTn++uvL2DFOjgN
         fQodDo05YSbSzHyTXLBdKrqQbgJY0nta+t5ur5Flc79Unxnm3mW5FPq3QCBmD0GcmEBf
         aiKD407UipDDlAnTv2BE2qEnEuRtSHVglijsUrNQWHtTNPDqzgjGdwdWrCqBu32nMypQ
         kn4xqkB3QfzdNR1Ld+xZQjcUOLA4tJNvZvaDtF8MKQ9xEss5hz7/SSVoAfPupQo7nkZq
         cmZQ==
X-Gm-Message-State: AC+VfDw+QLGzGQNmmN2E59B0vibjc413UP8ay75u2ZSpQhBrTV+RKFMy
        b1q6tGPhyoksJeHCkTk0HNHBLNJKMXwOsiWalFSgtGtpLjEM8Yw+apuMInafM1mI3AqJxnCYnNT
        le+jSGww/l+X2+z5j+N4HvXoCpskYbYMr
X-Received: by 2002:a05:6214:e43:b0:616:4b40:5ea9 with SMTP id o3-20020a0562140e4300b006164b405ea9mr8345500qvc.40.1685573653755;
        Wed, 31 May 2023 15:54:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Q8h/VErsu2HxdJ/FTBkYCVOqJCzxUq7Sc6EkbJ/+UJZdOIVIicNKzLA7WEdqGSriY8BYwdw==
X-Received: by 2002:a05:6214:e43:b0:616:4b40:5ea9 with SMTP id o3-20020a0562140e4300b006164b405ea9mr8345485qvc.40.1685573653458;
        Wed, 31 May 2023 15:54:13 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id mg8-20020a056214560800b00623813aa1d5sm295226qvb.89.2023.05.31.15.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:54:13 -0700 (PDT)
Message-ID: <b3105ace22a8f5f3a56adceffd28dec6b522ecca.camel@redhat.com>
Subject: Re: [RFC PATCH 0/5] irq: sysfs interface improvements for SMP
 affinity control
From:   Radu Rendec <rrendec@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>
Date:   Wed, 31 May 2023 18:54:11 -0400
In-Reply-To: <877csohcll.ffs@tglx>
References: <877csohcll.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-31 at 15:09 +0200, Thomas Gleixner wrote:
> From a conceptual POV I understand why this is required, which makes me
> hate this chained mechanism even more.
>=20
> [cut]
>=20
> AFAICT, there is no real technical reason at least not for the vast
> majority of usage sites why the demultiplex handler cannot run inside a
> regular interrupt handler context.

Thanks for taking the time to explain everything in such detail.
Much appreciated!

> So I personally would prefer to get rid of this chained oddball and just
> have consistent mechanisms for dealing with interrupts, which would just
> avoid exposing the affinity files in two different places.

Does this mean that if I came across a chained driver that lacked
affinity support, then changing it to use regular interrupts via
request_irq() would be a viable solution to enable affinity support
and you would consider accepting such a patch?

Taking a step back, in the case of hierarchical domains where *no*
multiplexing is involved, do you consider setting .irq_set_affinity()
to irq_chip_set_affinity_parent() a good way to enable affinity support
(assuming, of course, the driver lacks such support originally)?

At the end of the day, what I'm trying to do is find a way to enable
affinity support for a few specific drivers where it's lacking. My
initial impression, after reading Marc's message[1], was that the fix
lay at the system level, at least for multiplexing drivers. Hence my
naive attempt at a system-level fix. It is now becoming clear that the
fix will have to be evaluated/addressed at the driver level, on a case
by case basis.

As a side note, one thing I particularly like about your approach is
that it doesn't require any changes to irqbalance.

> Providing information about child/parent relationship is an orthogonal
> issue.

Agreed. Do you see any value in doing that? And, if yes, is reusing
(struct irq_desc).parent_irq and irq_set_parent() a good way of doing
it? FWIW, a multiplexing driver could do that regardless of how it
registers a handler for the parent interrupt (chained/regular).

> If there is some good reason (aside of the chained muck) to have sysfs
> based affinity management, then I'm not objecting as long as the
> functionality is the same, i.e. effective affinity needs be exposed too.

I can't think of any other reason. AFAICT, chained interrupts are the
only interrupts that are active but not visible in procfs. For any
other purpose, the procfs interface is good as it is.

Thanks,
Radu

[1] https://lore.kernel.org/all/87fslr7ygl.wl-maz@kernel.org/

