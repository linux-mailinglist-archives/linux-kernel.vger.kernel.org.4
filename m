Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB86A41C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjB0Mgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0Mgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:36:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5DEA242
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:36:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 800581FD63;
        Mon, 27 Feb 2023 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677501389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ur0xuE289IvT32hM1jRHvfg306XPYDDVj+3mEqu+Hp0=;
        b=o5Nxk5tYYjoEsGEyDQg6YKeVSqNlkPcsD92UyeCGPiP5M44rK62b8ppzFggIOfDubFnMD5
        vT+Cjjuq0QrFgC9iWi8BS4R4BDGRLBqxorG3VJDvzOdjN4lkjnWmWJ7j8amM2eZpf+mk7N
        lEf5HUeHYDGeChLig5yo+MMN5vh/srU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677501389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ur0xuE289IvT32hM1jRHvfg306XPYDDVj+3mEqu+Hp0=;
        b=wsfOT9gIpGiUml+Gf3hPKD49Nta2JOvsKQNkW3LPiwZpoAriE+o3DCyqD/p2VWglU6+5Xs
        aRbT0Pwtkc/fhgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34C4113A43;
        Mon, 27 Feb 2023 12:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8IElC82j/GOFRgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 27 Feb 2023 12:36:29 +0000
Date:   Mon, 27 Feb 2023 13:36:28 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>, kernel@pengutronix.de,
        Evgeniy Polyakov <zbr@ioremap.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] w1: ds2482: Convert to i2c's .probe_new()
Message-ID: <20230227133628.403bc581@endymion.delvare>
In-Reply-To: <20230224120600.1681685-5-u.kleine-koenig@pengutronix.de>
References: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
        <20230224120600.1681685-5-u.kleine-koenig@pengutronix.de>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 13:05:55 +0100, Uwe Kleine-K=C3=B6nig wrote:
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Link: https://lore.kernel.org/lkml/20221118224540.619276-596-uwe@kleine-k=
oenig.org
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/w1/masters/ds2482.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
> index 62c44616d8a9..3d8b51316bef 100644
> --- a/drivers/w1/masters/ds2482.c
> +++ b/drivers/w1/masters/ds2482.c
> @@ -442,8 +442,7 @@ static u8 ds2482_w1_set_pullup(void *data, int delay)
>  }
> =20
> =20
> -static int ds2482_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int ds2482_probe(struct i2c_client *client)
>  {
>  	struct ds2482_data *data;
>  	int err =3D -ENODEV;
> @@ -553,7 +552,7 @@ static struct i2c_driver ds2482_driver =3D {
>  	.driver =3D {
>  		.name	=3D "ds2482",
>  	},
> -	.probe		=3D ds2482_probe,
> +	.probe_new	=3D ds2482_probe,
>  	.remove		=3D ds2482_remove,
>  	.id_table	=3D ds2482_id,
>  };

Reviewed-by: Jean Delvare <jdelvare@suse.de>

--=20
Jean Delvare
SUSE L3 Support
