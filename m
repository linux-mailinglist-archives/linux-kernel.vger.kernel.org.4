Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0FB5EDEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiI1OU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiI1OUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:20:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5F6BCFC;
        Wed, 28 Sep 2022 07:20:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l14so27467171eja.7;
        Wed, 28 Sep 2022 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dO6EU/sCZoP8P76kIzTpKEObyY6TokbzHiI0Sd9UPo8=;
        b=fJFVH3EOPpW9ZmVTmUfKrArrjpLd7w5+9P9LjdxcJniF5nsxOrJ5rHHs4L6s0FQYSj
         nUj5x4BHFjhQovfO1mHQ2JWBKZTQplm+pvqJzRJxz7iSUyO6bFenasugZ4RNuOzffgCh
         jT4UzjhiM4e/kpAxFJeBtMPTHzFU2tKLEeU/H/agFGI1Jg2iTRgOEf523eCJ8OYiUqW2
         5A9tXhxs/SPNUthR0vJ42UBB66rQvte9iEpExrtbRCXjSdSTqjdsHIwAiilLElvOI4BT
         RtouUxNW5zfdXBXexgvAsyn8i7A7mvaUaMDPw1SnzCqMCMQhfJ89BSgiPNkpc87IpXex
         qDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dO6EU/sCZoP8P76kIzTpKEObyY6TokbzHiI0Sd9UPo8=;
        b=EbMyQ1oo8L4Zrjg2iWYLmF+UOSuszIit5JqxUe3ohB1t5fkRwJVJW4oXtx2r71AXmJ
         ov7Lk0tRdE12udvgVud3tXMHeiz1O9q+U/SsaAct9t+CjjwV4c3w+w9XRQvXt3hsjxW+
         BpxuNmHg735mntL763TMiM7FiDOGU0t/vI38WS6GnDOrN1jrpopN6JKBwLWEwcpNupwu
         kWCpnT1wUI2PkF/pMGdVXo1Fc+bXJgZdwSQtmRRZLOMyPxTzxSNiThwWXBqtIhGXO+Yt
         9kcIKTycXPkkIAxaR4Mzu+1KsjwF1xGZKFfztbNilbP7GFQwGZC5Lbl3IW/GBVVEoC2f
         7hRA==
X-Gm-Message-State: ACrzQf344V6yX1wRMfLHP13xKWjGXTZGSv6DeCRunaH5+UxCipnWrT76
        5Sv/n7+GhbIQB9Kpgy/vyvo=
X-Google-Smtp-Source: AMsMyM4WfWjOTlzntsU5LvFaX6LEn4hxjfg1SM0DKoA8Slw+LeUiGfs+TjyrkWj4eVc2OzGxZtbaDg==
X-Received: by 2002:a17:907:ea6:b0:782:1ace:9d5b with SMTP id ho38-20020a1709070ea600b007821ace9d5bmr26050189ejc.770.1664374848982;
        Wed, 28 Sep 2022 07:20:48 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906409000b0077a1dd3e7b7sm2463087ejj.102.2022.09.28.07.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:20:47 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:20:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] pwm: lpss: Make use of bits.h macros for all masks
Message-ID: <YzRYPvzWFBXijIBQ@orome>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
 <20220927162421.11052-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Of0utHWYLxmGvNA0"
Content-Disposition: inline
In-Reply-To: <20220927162421.11052-7-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Of0utHWYLxmGvNA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2022 at 07:24:20PM +0300, Andy Shevchenko wrote:
> Make use of the GENMASK() (far less error-prone, far more concise).

Very subjective.

Thierry

--Of0utHWYLxmGvNA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0WDsACgkQ3SOs138+
s6HSDBAApQJpRvhMyjfrK1Opz91jbffoEgFz5yCY3DcMStc4BJFsj47bvmzaDDL8
IBvEVPbYlkELWwjgNgt5FICgPNuwao3yoSiwSMXYPahq+eBkGCuWYemOq7gjNwLr
IpMWR+pyy2NBrijq+dswlrcpLgcEcF5PJMTgjo8FOo0pFxWZGQ/HnWRY0xPlV9oX
zmlgkPmA9zCWLR+b6MwZyZzXZEqPQi2GBL5u3/irXOPJBriGVnOhYfu19O7+INjW
1Wyu+oStQfgf5KlcemCN/yyTpQfOONc2MRS0vwbxtvLBerlQTP+GmH+robdB1cmP
F8zDPwqWr3aLdJneTqAyV3h9faCduJi/bwb0in0OYaHF0xGtoLOrCbxwu3Or0uO6
+sir5QGU8b6hJRz43HyH2boEtGYpC29rQq2F54tNpK/ZwkoX37wlzE8bmhpRgRBP
nsPYqblZEw2VsxNY8IAc9fRWmWZ8+dLnE2tj6sntxI6w/wme0JJfEZx5SNEj4lpy
UDx4oosL3BO4ynsN5BISX/IRymUMa6ZvZRuD2xhjB9t0FSAERrm4utZqF6aecIrt
gtT1NkHgCrRmokXZDXR+igLedAtMYsdl+A3wk64YZBMuE4gitgh+vrrLcBJV0oL7
dcFM0nX5Pk+MzJixLP48iPJ9aukVrvTDJiwXvYnTdV5XV/x9pLg=
=0EUc
-----END PGP SIGNATURE-----

--Of0utHWYLxmGvNA0--
