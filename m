Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D36659387
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 01:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiL3AFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 19:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiL3AFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 19:05:10 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F717422
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 16:05:08 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 186so22124963ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 16:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY80IPGOHseZwU3jy+X7Hc+4WbY+tpWCLdGp5MHIF9A=;
        b=aIOb2r56Q9IgfEdqFJ4U45V4/U5Cztm9EvswQML3beHvxgG1s62Cp6vzoIHvGs9JBT
         mFPVdCMKxTm/IgNdsLIFVS34mK5r5NhVVZAU5B6WuSMQSvjQst3chNrtTIH08QiECsGS
         7ETUxJoEh5gPAIGzzOCOMYg9umV5rKvnwAcP2NjlMMYb19NygfafJ+4NTt/t0JCc/E6w
         VjzBRlZWPT0CiXVAW1sf2mOhCPzCwT6gvFpikugKp1a6Xayd2HpZrfSvqW2o8IdCKBhS
         Bz8Z4rn9YU07UXrf3e4jGlMyyC5IKRcS6oeMpeNoBWrGpiIKYADkrcNbNSllusDZvjEt
         qHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MY80IPGOHseZwU3jy+X7Hc+4WbY+tpWCLdGp5MHIF9A=;
        b=l68Qe1Yz1CWUTyoospPQeEC4rlbp37CIpPTakJ9Ei5EEWp/XNjOIkVU0pzmLes89hJ
         7DTLckBJcDwoTTsVx/giHlNubsI4NxGVPux7teqNEAWQcM7jIrrp7IbvymWAPx2lNGl1
         JA7aLmIkWq6K33d2ylB92gQ/jpFlotOiqOIjCtA52pa+LoiSxbKk0yAL7DywbaQ9Hx5h
         0vX6eyTL+3WNR0aWojKat8+w1knralH7DV1xdC2ZWgm+Hu2i1gDPXsSqB1kfbpwvAG3L
         NazthASqb9V5aMfE9EGuTaCNhLy/esxCFo5a3Ni9vaIOT1TmxrKDLWImmwKbQYcWzQRJ
         gRUw==
X-Gm-Message-State: AFqh2kqt9TLzLiR3zUsQ846WVsijh7v48U32jLsXA1xOPcKLXrtmIEHy
        KbFKRQwZ49BbMRsf435c8WUftgaoIVW0GYSx8Yffeg==
X-Google-Smtp-Source: AMrXdXvisxeUm2wDlk1Wc9TMuVtv8tKBjUNnUkygl38Ahh3hHkBerjlTb6G21N1oQ/DuqDdF8av3nzdjidbHLJv0Mkw=
X-Received: by 2002:a05:6902:13cc:b0:75f:65da:a046 with SMTP id
 y12-20020a05690213cc00b0075f65daa046mr3289405ybu.357.1672358707981; Thu, 29
 Dec 2022 16:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20221221200513.676744-1-nfrayer@baylibre.com> <66ef2f70-9405-fe09-7927-143084286d1b@gmail.com>
In-Reply-To: <66ef2f70-9405-fe09-7927-143084286d1b@gmail.com>
From:   Nicolas Frayer <nfrayer@baylibre.com>
Date:   Fri, 30 Dec 2022 01:04:57 +0100
Message-ID: <CANyCTtR-6ooPBPyNdnDe+qUMDUHVUyrHc=2sk8noXzmcurbqag@mail.gmail.com>
Subject: Re: [PATCH] soc: ti: k3-ringacc: Add try_module_get() to k3_dmaring_request_dual_ring()
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Cc:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com,
        khilman@baylibre.com, mkorpershoek@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 24 d=C3=A9c. 2022 =C3=A0 23:01, P=C3=A9ter Ujfalusi
<peter.ujfalusi@gmail.com> a =C3=A9crit :
>
> Hi Nicolas,
>
> On 21/12/2022 22:05, Nicolas Frayer wrote:
> > When the k3 ring accelerator driver has been modified to add module bui=
ld
> > support, try_module_get() and module_put() have been added to update th=
e
> > module refcnt. One code path has not been updated and it has introduced
> > an issue where the refcnt is decremented by module_put() in
> > k3_ringacc_ring_free() without being incremented previously.
> > Adding try_module_get() to k3_dmaring_request_dual_ring() ensures the
> > refcnt is kept up to date.
>
> Good catch!
> I had never had my hands on a device with DMSS (BCDMA/PKDMA) and the
> original module support was developed and tested on devices with UDMA.
>
> can you add the fixes tag along with my reviewed by tag?
>
> Fixes: c07f216a8b72 ("soc: ti: k3-ringacc: Allow the driver to be built a=
s module")
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
>
> >
> > Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> > ---
> >   drivers/soc/ti/k3-ringacc.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> > index e01e4d815230a..8f131368a7586 100644
> > --- a/drivers/soc/ti/k3-ringacc.c
> > +++ b/drivers/soc/ti/k3-ringacc.c
> > @@ -406,6 +406,11 @@ static int k3_dmaring_request_dual_ring(struct k3_=
ringacc *ringacc, int fwd_id,
> >
> >       mutex_lock(&ringacc->req_lock);
> >
> > +     if (!try_module_get(ringacc->dev->driver->owner)) {
> > +             ret =3D -EINVAL;
> > +             goto err_module_get;
> > +     }
> > +
> >       if (test_bit(fwd_id, ringacc->rings_inuse)) {
> >               ret =3D -EBUSY;
> >               goto error;
> > @@ -421,6 +426,8 @@ static int k3_dmaring_request_dual_ring(struct k3_r=
ingacc *ringacc, int fwd_id,
> >       return 0;
> >
> >   error:
> > +     module_put(ringacc->dev->driver->owner);
> > +err_module_get:
> >       mutex_unlock(&ringacc->req_lock);
> >       return ret;
> >   }
>
> --
> P=C3=A9ter
Thanks Peter, I'll send a v2 with the tags.
