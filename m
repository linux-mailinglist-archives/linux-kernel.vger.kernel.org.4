Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A336A462F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjB0PiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjB0PiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:38:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8842D8A65;
        Mon, 27 Feb 2023 07:38:00 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t15so6679420wrz.7;
        Mon, 27 Feb 2023 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iPi5X24QTXkkpCSlIjxJGTxpv+NcI0Pnun45yeLmXE=;
        b=JO352TRl2K8+Hym1qiP/MLj7LZc8IblPvaQ/6ojC/1cd0ZOHuhweFYbR2yiUnjFjtr
         fS9SsCW/xfUTtoE3vcDxo9T7mtaDfImSJfSIPGj+uG1ru76KA1SD4A1+I2Z1m4jStAqy
         1GErc96ncs9MAp4BUaKAXxFs994GWp0Ljd6o8aQ7ZHg8RddPb0v87loajDATtz2jHFZh
         g69FYaR8wWAlFF2Kv5jYzNmZ7XW2E+nx5EcBMSxMVerVZsbim9Cnnf6sMZkM8ubu3mnz
         dt2++KHUwqWUeRCQXmHe6HXbqXwCuoVDfnDcaWhNOO+Wwm8Fv++Od2ZnoJdBT/J6Y9JB
         wBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iPi5X24QTXkkpCSlIjxJGTxpv+NcI0Pnun45yeLmXE=;
        b=PRL3Z9OCRzLaWCF2xMmSN/CEJE5yRoK7zuDEQjDdn6kD0wXRg+ICQDRAvvuFL+iLUe
         tsoETMQ7scDZyCPMSKmUKTy2IPcwEhpm4abtjgtaP2pyc/P3HFOh7GHW/xrFCFrDDLOM
         8EFdVlMQCHDuO5ZgI3ZZwOPgEcSRHjU4HN9QwPlpOZBX/xdTMUm3ejSxSNYmBLGYAx9O
         1NCfb5+jtploOVz5G6xNLGHQHPj8eSTKoOmgOQjvmTQdDRS/e/I0S74JbhEQQL1yK8Zs
         wQtbtFRW1QUaOKIx1bCZ0sq755SLGyZ1Kl4ryAnx2es036fDrqPLyrApq/15fn80LdPE
         RzEg==
X-Gm-Message-State: AO0yUKV+oQa1/2a2JGNMrottVhEWetTkArPQvPewTbEksy7fSzKtjzK1
        A/tYBAg3JBmCyQD7pMaTAgEkYkzaxlg=
X-Google-Smtp-Source: AK7set+gzfKP7nIhtlLHVfD/hwBndJB2UaNuHF+7c4cyFENoyzpEL44waBdq7UQclvB5/RiKpgrjZQ==
X-Received: by 2002:adf:f3ca:0:b0:2c7:832:8fc0 with SMTP id g10-20020adff3ca000000b002c708328fc0mr15915768wrp.3.1677512278977;
        Mon, 27 Feb 2023 07:37:58 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe892000000b002c707b336c9sm7433562wrm.36.2023.02.27.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:37:57 -0800 (PST)
Date:   Mon, 27 Feb 2023 16:37:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as co-maintainer for DRM Panels
 drivers
Message-ID: <Y/zOU8cu29hOi9hk@orome>
References: <20230216-topic-drm-panel-upstream-maintainance-v1-1-ae1cf9268217@linaro.org>
 <Y+9awrqcQIOQNeaX@ravnborg.org>
 <45387999-a930-c03f-1acd-a02b9b4b3b3b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yUOMNC0qfpAxvPUR"
Content-Disposition: inline
In-Reply-To: <45387999-a930-c03f-1acd-a02b9b4b3b3b@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yUOMNC0qfpAxvPUR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 09:22:02AM +0100, Neil Armstrong wrote:
> Hi Sam !
>=20
> On 17/02/2023 11:45, Sam Ravnborg wrote:
> > On Fri, Feb 17, 2023 at 10:58:15AM +0100, Neil Armstrong wrote:
> > > Add myself as co-maintainer for DRM Panel Drivers in order to help
> > > reviewing and getting new panels drivers merged.
> > >=20
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >=20
> > Thanks for stepping up!
> >=20
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> Thanks for you trust!
>=20
> Is there anybody else willing to ack ? Thierry ?

While at it, perhaps you want to remove me from the entry? I haven't
had much time to look at these drivers for a while now and Sam has been
doing a much better job than I ever have, so looks all in good hands.

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--yUOMNC0qfpAxvPUR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP8zlEACgkQ3SOs138+
s6EoXQ//fx/b2TspW3plTFqmmm7ZdxDRNWPShZgH07yU4Us9KxNmsCABmuwxZxeT
uyL05JiX1xlPGeRxnZHW9PywXPPAIJlFGjYW2zrepjYRhdvVhfirNlMhw5YQuce3
ASnfcYx68BbOLfeTJma0+5/ZxkWklBn/Fbqki/b/cL8oSUCinUBEgVHGVrp2CyRi
dWiny3jHQWDUdySpVBCZAJfOboi7V8IGfviRKz/PrJ0rMlNyGuISNCpsMF4P/ChO
G9CKmN/qQlY3WE0S80TaBBBK420h7Ie7C31XgIkU/Ca6jXD3GilzeVQfjdfLiiQF
MI379JWCwjP4S9urZgamJpukXR2ebEf/nZqz05hws7rRXjnbs+Ao78NnFyt6WfLs
NIPCOsnzLu1nQiNgmNIqP0AFvm8NvWPz8hXTN3Z55/kKd0T8ukuNde+S8ET1jY02
HnrMBdqWHfdMbaGFfuT7dYdB64/pcMJOyrXArYthwYj2xyh2stjZSFsvMPSSAr7L
a8kEDl0299OP6HnYVFfRDNv04VY4lLe31Og2zfP+9q7+d5MCP35+7tjn2BvYEXP0
tJuZcSlFXYWTxBTESFFheoWBKoWDhuH8MfFXOADXyyGhIv9m+HraWXLCGUTs2vPi
wI1QUZxVsJSLZ4AQyxAZhxQJbSJolCIRHoDqiXFaGpSE6liRV2s=
=h4Q5
-----END PGP SIGNATURE-----

--yUOMNC0qfpAxvPUR--
