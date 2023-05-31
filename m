Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8A718EDA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjEaW5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEaW5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D411F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685573815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gU7okdlfkVwmPcwkDj5oqdnzKrfl+prUCwg8Q6OmDEA=;
        b=W+ducoJ/r6r58yTNMegTTOz55s6xTyj9WlBVA0fUVozRN6+RssQ3o7OVkLejORMkW01sfG
        QgiGwPgzlT1j8UHhf5xOemW/UfT3yi/KWZ//zMktHtH84dkbXBzcBEP3WSUDsSeSs1tAbC
        P0YO+JiQvrCk8MbF0K7DbDE+Enr+rI0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-n9RVhzc1MHiP0XlpWnmZMg-1; Wed, 31 May 2023 18:56:54 -0400
X-MC-Unique: n9RVhzc1MHiP0XlpWnmZMg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5eee6742285so4355626d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685573813; x=1688165813;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gU7okdlfkVwmPcwkDj5oqdnzKrfl+prUCwg8Q6OmDEA=;
        b=dLN2UeN9bbUdGqqP7I4+SLWfSORgcRXDMyWnMTsP7w1XWta9nb1R06VIcEhLxKUlUB
         9+LmcDbpR65hGP5gNySalxf0aa+L31ypmeqgcm3Lo+z9kl7cIoiEn4YvKbPxM0Wu2TCT
         CyiO3hlcTYeUzZohtDjxNR6RBJ7Zqok80QgjPKYBu0FvHU73fWrar7FAYDjlkoEskunA
         sRr1wtzEj04wrDSYTVaA8ljzb3EWwJfO3OwRDYTMwRhX3nolURE6s1Ie4tdEv5nhD76m
         qGOsdxMZpBJgOordvMzgn5LbEBbakivqOGN+S0Ti56syVxbrabVLZ3B4QknzHUZO3Ez+
         U7IQ==
X-Gm-Message-State: AC+VfDz1m2L0vN9xQ+znRlzcmqzcywmnJca6+1w3ajt084yWgzRScuEe
        XMcneSemz68ZY9c9eTR/d2z5A2HbR3Ac7jvaGXn4/7ld14Qgb2e3uUttxyvg+WVQ92zjk1tHR2V
        RCOlTNf2xEpsSHSXUt3ge3f/69qZIn2y6
X-Received: by 2002:a05:6214:5087:b0:626:ff6:f489 with SMTP id kk7-20020a056214508700b006260ff6f489mr7844054qvb.17.1685573813522;
        Wed, 31 May 2023 15:56:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kYeUkbtPl69AANx5lrymKdtQgkWsvLGPj6wk96eFqtzn+gwnAv59a6KelEFFULQic/XidUg==
X-Received: by 2002:a05:6214:5087:b0:626:ff6:f489 with SMTP id kk7-20020a056214508700b006260ff6f489mr7844040qvb.17.1685573813320;
        Wed, 31 May 2023 15:56:53 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id a26-20020ac84d9a000000b003f6aa9d7883sm6599951qtw.13.2023.05.31.15.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:56:52 -0700 (PDT)
Message-ID: <8506b66679e7b21e2d78785b87aa1486a5dd7e4d.camel@redhat.com>
Subject: Re: [RFC PATCH 1/5] irq: Always enable parent interrupt tracking
From:   Radu Rendec <rrendec@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>
Date:   Wed, 31 May 2023 18:56:51 -0400
In-Reply-To: <874jnshcix.ffs@tglx>
References: <20230530214550.864894-1-rrendec@redhat.com>
         <20230530214550.864894-2-rrendec@redhat.com> <874jnshcix.ffs@tglx>
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

On Wed, 2023-05-31 at 15:10 +0200, Thomas Gleixner wrote:
> Please read and follow:
>=20
> =C2=A0=C2=A0=C2=A0 https://www.kernel.org/doc/html/latest/process/maintai=
ner-tip.html
>=20
> Especially the section about change logs.

Duly noted. Thanks for pointing me to the relevant documentation!

Best regards,
Radu

