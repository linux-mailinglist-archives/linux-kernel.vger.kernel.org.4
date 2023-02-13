Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73B4693EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBMHMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMHMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:12:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA22C14F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:12:10 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso10567310wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aw4PcE7AXZGFYnNiks7LnHK1opJ2bmin378kSJGcwKg=;
        b=S/FJ6VGvt+lfzn6AJsBdcBAgkbjqojoYMV3M1+2x0McgXrazwaYlQnKeBfn+0iNIwy
         SP7YJyzh4EnexS+uX17fU5D37GQy6x390cnBx0HGlC+IEwHOjt8a3TOe+TUxHV8GMPUw
         Q0YEK03dL13JBGHE1yxLjFu4q4xK5IyEnGKz2SdtuDzgslHs64/k97aB0iImtu+TUojd
         44Pm8sWj6Bn9YepL4YFT5Us7LO+DUr5VAZF9hMUjZCJbKgQ7u6wS02EbBlziZYM2/vMg
         dX5Edc8av6whjKrPagth0ty4s+O4zPCVx0EfdszbHo6r5baPEoITxD84MLvNgg+QC3e1
         lsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aw4PcE7AXZGFYnNiks7LnHK1opJ2bmin378kSJGcwKg=;
        b=bOXJaODc8+C50rfQXV1FoU+1MQykiF4jVFFoLham4cTXfy0qJqQwYrtUvo7aUBWK33
         kNdSg1APXWxN3YoAmblxPRIKXppxH1YFHyQrdto2KCP44+CK2izfcowkCw9u+b+xiaE4
         erT0ehJ66M7Io7HS2KUm7erS3IsAz2qd19LpYJMrMdYNT8+9Cslg4gjcEeNhSbOLNPgf
         ylHwWm2C7qQXhgVDJukSQxDrcPHRwQvetcSE+bhuj7ir35axm/pqvtdOUSbxlldyDjQj
         xV4ysTBwDTkrC//AsCU3FBfRzojNiHfiJmXfXlzj1jQY6mqiUr8M3glGphT5k1LyUzo1
         15gw==
X-Gm-Message-State: AO0yUKXXQmjUN4y2dY0ZvcNLAFQXXsjTPNdhPBFVKbCKK41FtIVw1yb/
        DVvO/pGk73DOFRp5hpIDmdg=
X-Google-Smtp-Source: AK7set/pIhC9eIY8sTKlhzTdbtPE5LOB62qafN3fdglVAE3eLNnHyhoea9waTlBORtYBTS1ktbQypA==
X-Received: by 2002:a05:600c:9a2:b0:3dd:393c:20b5 with SMTP id w34-20020a05600c09a200b003dd393c20b5mr18400124wmp.35.1676272329430;
        Sun, 12 Feb 2023 23:12:09 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003daf681d05dsm13841463wms.26.2023.02.12.23.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 23:12:08 -0800 (PST)
Message-ID: <78b980a9e913cb6d98fd7f99218ccb815926c9f3.camel@gmail.com>
Subject: Re: [PATCH] driver: core: Prevent NULL pointer dereference in
 device name functions
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 08:12:08 +0100
In-Reply-To: <Y+nhnauiUDspXwNM@kroah.com>
References: <20230212220441.258258-1-alexander.sverdlin@gmail.com>
         <Y+nhnauiUDspXwNM@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 2023-02-13 at 08:07 +0100, Greg Kroah-Hartman wrote:
> > Prevent similar scenarios:
> >=20
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
00038
> > ...
> > PC is at dev_driver_string+0x0/0x38
>=20
> How did this "scenario" happen?=C2=A0 What in-tree code caused this?
>=20

such in-tree code is not known to me, I stubled upon this putting dev_info(=
)
all over the code in the platform we currently convert to DT (cirrus ep93xx=
).

> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > ---
> > =C2=A0 drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 3 +++
> > =C2=A0 include/linux/device.h | 5 +++++
> > =C2=A0 2 files changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index a3e14143ec0c..4ff2ddea7c9b 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2174,6 +2174,9 @@ const char *dev_driver_string(const struct device=
 *dev)
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_driver *d=
rv;
> > =C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!dev)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return "<null>";
> > +
>=20
> None of these functions should be called with a NULL pointer as the
> reference should have been properly gotten on them before calling these
> functions.=C2=A0 So let's fix up the callers please, something is really
> wrong with them.=C2=A0 Again, what in-tree code is causing this to happen=
?

Thanks for the explanation!

--=20
Alexander Sverdlin.

