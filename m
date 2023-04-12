Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01DA6DFD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDLSZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379AE40F1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681323881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CyeR5RuvAdcpT8sCaq1Ccw1gPj5ByFBqx39UJ21e/KI=;
        b=IXU4uvirc4G6b7686X1FtV4hHccHnqznbWZSON/b+1R9G7l52C8VDXoewI6bWDU26g37E3
        SikgbJGzbETZFvwY0rS1/Akwi8HZ/543HzCtped41WrFDiLJxEDRDLFFJYB1GtpKnIX9Vp
        zh22jgLGOERVpIvle0oeuIfB6h0ez/A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-ksSEqJiXMVSKH16d-upZpQ-1; Wed, 12 Apr 2023 14:24:40 -0400
X-MC-Unique: ksSEqJiXMVSKH16d-upZpQ-1
Received: by mail-ej1-f71.google.com with SMTP id s14-20020a17090699ce00b0093994122eddso4431794ejn.17
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323879; x=1683915879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyeR5RuvAdcpT8sCaq1Ccw1gPj5ByFBqx39UJ21e/KI=;
        b=Q+X9An6aWejH5RB5WpEsJrne/ASwYOe91sjLzXibNxwGz8sZfsflVW1HvcaZpS89Lq
         rbsBLyynq1GMJ+CB1Yz60+f3qYa/ewf5EWlYUhU9Zv7Y3No1LUsnvMQqsJ6fc+m9nJGA
         9OCXNhN8C+PJJVkDdtddqUcnDovh1l1hmSNlMl7/vKUrFEh1xA+b1VR561irIYlwkytT
         mjXzYwaxYUSGLO4HClL7w6XQkdQJKQpnMsW3K8zqpe/NcVERGVIqffaigH1oqINw3vpF
         IZg4or1LBDwgL8+2B5uJy/QRuegtNI5sbOMpi7UxR1LcCSIMXRmFXZSnRQnRuuJ5issi
         xD5A==
X-Gm-Message-State: AAQBX9dazmfPtggwnab1AVKgTR0KAqTjMM9a7XjbsNQ5VA9nYHkivXXp
        fdEDzqd5KxKpI6IdYzXPYABJHEk9+sSCnf6Jo5m/xt1mcW7JCmG2xrQ/4ZJJi0W1k1W7ORr6MbH
        rBp6Stqq59Sj1JAJW5/ddtLm1oJne/cBD/vUaVj/n
X-Received: by 2002:a17:906:65d7:b0:94a:469e:3558 with SMTP id z23-20020a17090665d700b0094a469e3558mr1746616ejn.13.1681323878894;
        Wed, 12 Apr 2023 11:24:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350YtycYXdsARuwibYKrLFJGATPqceVAlVOPYbZUKIRIWpL/xOi+w1ggZ81zpJrWnJCnwqM5MCAdGI1JA4J52kKk=
X-Received: by 2002:a17:906:65d7:b0:94a:469e:3558 with SMTP id
 z23-20020a17090665d700b0094a469e3558mr1746607ejn.13.1681323878636; Wed, 12
 Apr 2023 11:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230412150225.3757223-1-javierm@redhat.com> <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
 <87jzyhror0.fsf@minerva.mail-host-address-is-not-set> <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
In-Reply-To: <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Date:   Wed, 12 Apr 2023 20:24:27 +0200
Message-ID: <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is calculated
To:     Pierre Asselin <pa@panix.com>
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 8:12=E2=80=AFPM Pierre Asselin <pa@panix.com> wrote=
:
>
>
> > Interesting. So you don't have the simplefb output that you had before =
?
>
> I do now, after a 'make clean' and "make bzImage'.
>
> In between, I had tried CONFIG_SYSFB_SIMPLEFB=3Dn .  That "works", by
> falling back to vesafb in every case.  I restored the .config before
> testing the patch, but there must have been leftover dregs in the
> build tree.  1024x768x32 is garbled, others are good whether simplefb

And can you share the "linelength=3D" print out from simplefb ?

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

