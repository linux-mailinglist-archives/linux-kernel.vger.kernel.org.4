Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B056DC815
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjDJOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjDJOvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:51:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C049FE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:51:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id bv15so3043965ybb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681138304; x=1683730304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DS7lM4UvPhdsZz3QUAdTpEwkc1b3jnb1BvSC4K65hcs=;
        b=h4PKEDoQDsUC8mBNp4HscgecqV8REYXFA4+CGebmmkkxZHAcvh8QzKzPunfvUg1f7D
         XQxJ4UlJYaDda52CWHtesoL6yEj9FEd+v36Cb23Q3O/ZZSdP3BP8HDP31Y6F0MNjCuUm
         c4C9bz7CFAVetMIDjiG6MLoCbV6EDSkvj1RYohr8XR8kcpC4tjPKrBlNYt+iQ7X5n3Jl
         9ieHIIVOYIIxhUakdQBdjOYyMTN4HWirWtHYwLf4+fCTpZKkL49B+UlYdauym46uHKcx
         FetahX5cSGNxhoT8lewBl96h4Al2UKEKhbjeenkJhODxO1ruO361k2gSa1Mxl3OJpjfv
         zRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681138304; x=1683730304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DS7lM4UvPhdsZz3QUAdTpEwkc1b3jnb1BvSC4K65hcs=;
        b=gXgJjUnK+fwoznbVbLvwZKE4f+RbCQGBpKYaPTXgQU2Wdqfu6AsTOMuKCwxs8FYbhU
         ljAEtV8jPkdRJxAVjVBqrJ+g3TnCdrAOQxDAviutCwwgm8NyQJNLQOGHlW2rY4/6XfB3
         EokEelkvCROkmccXAIUUP3D72QI879WX64vF8L+/rnucWuZtsmBHr4NnispWSxp5AqmS
         yHLdBNNHH9Hnsd0McweM6dxeTdEDZVuVC7GyTx5NPz1R/ovIUpPf80k1SNVTGSkV9Zjz
         Sml2k1pnKkMblxhS7jLZpJ07KkEwVcawIAfR82xKjNw0cVJ9dxogjDlAPm/EqO3K2+r8
         xmWQ==
X-Gm-Message-State: AAQBX9d5cAziHHYGVQO8NkVkdg4TUf7XqiJbPfap0BGcnOSG1RVTgFJZ
        04oPBMZKE68+10lTnbxatdgTUw==
X-Google-Smtp-Source: AKy350Z7iUPXJT7xvEHCirYFplhyypqwYmvgJbb+dWAEndGof6Ml++KCOMzYUg1jEW374gcAxVHVcg==
X-Received: by 2002:a25:dc88:0:b0:b8e:d098:26ee with SMTP id y130-20020a25dc88000000b00b8ed09826eemr5621383ybe.29.1681138304298;
        Mon, 10 Apr 2023 07:51:44 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i13-20020a056902068d00b00b7767ca749fsm2956110ybt.60.2023.04.10.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 07:51:43 -0700 (PDT)
Date:   Mon, 10 Apr 2023 10:51:42 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fred Eckert <Frede@cmslaser.com>
Subject: Re: [PATCH] watchdog: ebc-c384_wdt: Remove support
Message-ID: <ZDQifl7EB33dh/eu@fedora>
References: <20230410143101.182563-1-william.gray@linaro.org>
 <7b0fbd06-73d0-7fa9-3f03-e788f1df4631@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kXGntYyXbZjGn7a2"
Content-Disposition: inline
In-Reply-To: <7b0fbd06-73d0-7fa9-3f03-e788f1df4631@roeck-us.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kXGntYyXbZjGn7a2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 07:43:37AM -0700, Guenter Roeck wrote:
> On 4/10/23 07:31, William Breathitt Gray wrote:
> > The current maintainer no longer has access to the device for testing,
> > the original user of this driver indicates that they have moved on to
> > another device, and the manufacturer WINSYSTEMS does not appear
> > interested in taking over support for this code.
> >=20
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> A bit harsh, maybe. Just mark it as orphan for the time being.
>=20
> I see there are other Winsystems drivers. What are you going to do
> with those ?
>=20
> Guenter

Oops, I didn't mean for that commit message to sound so harsh but merely
log some brief reasons for the support removal for posterity. However, I
adjust this to orphan status rather than dropping; what is the process
to mark a driver as orphaned?

As for the other Winsystems drivers, I'm still able to test those so I
can continue maintainance of those -- although I'm always open if
WINSYSTEMS would like to join as a supporter, or a user co-maintainer
comes along. ;-)

William Breathitt Gray

--kXGntYyXbZjGn7a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZDQifgAKCRC1SFbKvhIj
K4PZAP9vBvzOzd8mRW35dKX/XGo7maxqBvWwRcgTzfvwb7iMygD9HKov1wQXvkqZ
MZsaSR0i1y6OmR4CUb2u/g3GRE0L/QI=
=Uzif
-----END PGP SIGNATURE-----

--kXGntYyXbZjGn7a2--
