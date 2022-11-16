Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1F62B826
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiKPK2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiKPK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:27:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620E03F045;
        Wed, 16 Nov 2022 02:23:55 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gv23so10205845ejb.3;
        Wed, 16 Nov 2022 02:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx8zMsCqJ/b5ENIL96HeAHIr3J2YawLRjwQyFl5N+RQ=;
        b=jPLN+BH98o/JEHL6iTFpp4qDwAWctKDajXMtaaU0/5+TPBFu9N0ksiE5QThbVxMFzq
         cBvhTUppolBlNowINNzIYSXJ4Fu884K1BlAf99XMwG55uQPGgbk27rutGYFd+guav8jc
         Mm+AAaY86NgxdJRCSyJxppnzzAetp09w+oXQVIQlyXyqGX+qmvtL0hOEcjWyBTcHligm
         FTVxksEohFRVNAmM7Uo+G1Fs+TAvTuYeDUo1H1FvxS5fKdRDnJ8NUiXH/nu0oPYSTyGI
         tRHqKLYY1SwGtatN0a/PE1JNQGvL7DXGCYY/lT6PHgoHwF2tLl9hZQ9ycBfU/Iey//dx
         pWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx8zMsCqJ/b5ENIL96HeAHIr3J2YawLRjwQyFl5N+RQ=;
        b=leRMOOLZlXp2bFJnqf1aiHxs2120+LL7VvfM4/6Nt+hYeq05DBSew3hia8Rw5++F1k
         /PZLJtOghVMOrHtEBAazJ53aIqHJpupa/XBInJTQGo5R6VO1VQMdsDSJw8SaG6VLGTDL
         s0f9vR8mlkp8i9EcxtZMmslaFZUQgM7hTtWKfBDOO0uF5OZe7zZVLcd7paexjxRbsLtd
         MdMz5Ou3141XkwBd1K2yWaf6TmVekbN5XqBFes7vqve0qZEaSem1G+duCAUCQN8grW/L
         2ifrNRYGSDJmz4ATMsedCdmBk4FEMv3N70BNxtTuMQwuUq/PhY59IYlF4MbX7Ng8IcGR
         yx0A==
X-Gm-Message-State: ANoB5pkd1lpYAXp14nsE8fjDCw7lm7N5N4luxyglUw7mAQRdf9N1ibQ/
        vOkQTQ1e1OaitH7Y53R+GHt75AeGAuA=
X-Google-Smtp-Source: AA0mqf6cW5MNv6KVaRLzN4SpGw31D3kQqzuQfbSTzfslBdRMvqZB/AB7e6dlr3tsr0H1J1qcDVgeFA==
X-Received: by 2002:a17:907:20c2:b0:7ae:967a:50bb with SMTP id qq2-20020a17090720c200b007ae967a50bbmr17188059ejb.383.1668594233480;
        Wed, 16 Nov 2022 02:23:53 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i9-20020aa7c709000000b004588ef795easm7361126edq.34.2022.11.16.02.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:23:52 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:23:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Brian Masney <bmasney@redhat.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        psodagud@quicinc.com, quic_shazhuss@quicinc.com,
        quic_ppareek@quicinc.com, ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
Message-ID: <Y3S6NyPwN8wbwJDI@orome>
References: <20221114202943.2389489-1-bmasney@redhat.com>
 <7420da17-d6d6-10e6-c87e-d3dc37d17ffb@linaro.org>
 <CAKXuJqgckbmikXwFi0g3P3Db5jvyst+xhQBcPoV7mA2XStVVzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sDjlB8ktuswCuIRX"
Content-Disposition: inline
In-Reply-To: <CAKXuJqgckbmikXwFi0g3P3Db5jvyst+xhQBcPoV7mA2XStVVzA@mail.gmail.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sDjlB8ktuswCuIRX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 15, 2022 at 04:02:38PM -0600, Steev Klimaszewski wrote:
> Hi,
>=20
> Others in the thread pointed to Thierry's patch, but on the Lenovo
> Thinkpad X13s, that patch did *not* fix the issue, and with it
> applied, the X13s still immediately reboots as soon as exiting EFI
> services.  With this patch applied, the X13s does *not* reboot after
> exiting EFI services, so thank you for this patch.
>=20
> Tested-by: Steev Klimaszewski <steev@kali.org> #Lenovo Thinkpad X13s

Do you happen to know what driver the X13s is using? As mentioned in
another email, I don't think overriding gc->fwnode at this point is the
right thing to do, so I suspect this field might be used unexpectedly in
some other place, so I'd like to take a closer look at that.

Thierry

--sDjlB8ktuswCuIRX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN0ujYACgkQ3SOs138+
s6Ekeg//fsV8Vbkdcv+e3uObyH4LDXM7h9VfB1Faav6WkstVescdfRFUNkrMOUL4
Nihw+XJQPHhacVnR12e1smY2zHeMeMHK1AgzHxQZIhuFIKrDNJ1ygehsKwMWPsSO
wBjpeViQ7LujjK7URvYmzv0mV2ElHDetWwHleY6RmFWuZujrUB895EBPBlyfcYPx
FSsuHc4ll6mVq0JRQBlcSWwaQy1+5svJTeIBv4BFJhDVXH8M5W/sKDT7r6xNfIuI
ciBHrR7J6K1fKKBpJMqFnrxVv247KM7KStmr+CqaL2+SRTeQQgqqlzHhBRxX/MbC
PgsmIV22A8CSrK7QTce8YTdZSYOPNVNEGiD15WhIliLtZ6SiZl7V4u63iEIx6xbF
tca7tdifI5EErHNb32liEmcig8FH7ulkTkZ//glZMR/jFnSzzYozUCa27rT29kvs
g+IMTMxwSfPEONuo00yWPqgRYqE5jJFYxNAEXy59igVe/Vf+GznoIuYT/uoqZqzc
D28ruTziw82/Q2+V1aeE/GdT3G2IBr/ClCoHJP5s9kXuZvRZxjHY7D0T1KkiigXw
47xGGjoS6eY5Ws4JbKNFpLoYLIuhSJ2Zu7K8JO7kHs2t5p3kxvhh8miARVUHLYfg
DDj95W/w4KgFl67HAKGP66FeKrtbjj6s3mNnlZBsEkQuP1cO46w=
=sbMU
-----END PGP SIGNATURE-----

--sDjlB8ktuswCuIRX--
