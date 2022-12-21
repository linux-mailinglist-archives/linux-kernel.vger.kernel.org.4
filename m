Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4116652B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiLUCoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiLUCoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:44:14 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D30A1D0EE;
        Tue, 20 Dec 2022 18:44:13 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id l4so2893422pld.13;
        Tue, 20 Dec 2022 18:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/RXyzLEOjOd19EjSvWsrGGKWPgbNTJbgOMFPprH9ag=;
        b=HXveTWymAztH91B55Q7BBiyOM/Au4FIKsUxCSj7BLah1DbQqaY+zVDl3D548Qg9sDM
         HGc2Y0k1NTT08755C/3N6JRYZ34gtpAA09c6atZLpU/w6xioXg3WUBM4MlAU3vVhipaM
         /SQe1e7KcSI7xa6lM3F1QRVDB+8Vpg58pfUZbfYergofs0B8yLFDGFRqEtXl4F79Qhxg
         eGcbch8KKQn/rlidmhJJVJmHNLIbI5sa0SnRBHQlQapHmU9zwdQWeUuHwspUlC8+P55Z
         BtNzG5fZCFSjGOByViqPOt+ZFy+LZVJMafF4kSBugFQCji28qzuBDAnzmjZ9rrl1rlP8
         SsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/RXyzLEOjOd19EjSvWsrGGKWPgbNTJbgOMFPprH9ag=;
        b=GWjqtKan8iOMw1w2Iidv4DIU1VLskKCO21MX+7zUQ3SDa3vyC1a242cJfB6g9XKQBS
         SMISDQgg1+wFIyY6wQ/UZAKmNOz5nc4fu9UcLXzC+/hrR5kbIeZVyAAbyvZ12Z4Xoh8n
         R7nRvgKYpQHk39YtLn9iNCByq1NkWaoq+i2GsyHmUCbXONOfmZnqFkMVNpSmzccEEfU0
         /Y6CxPNZTwYMiHfcTOrDuNLFT54WW1Lhz5FK2bmS9SxWyIfAVW7u0VsMrH9qoz6HEy4G
         YeTyIUqnW1b1vTmCDlT1l5mF+slOLhkIaLN9i/G/4ClcVafaTbOxaL6oBJsRP+7NfzPZ
         QpfA==
X-Gm-Message-State: AFqh2kr7zFi7UAL3QjGRRAGTKxIbmpG2FBvE079EwH0hwqlSnNp+Bo/M
        ypGo2ULbxfdS+Icdv6PsDwDC5ld4qAs=
X-Google-Smtp-Source: AMrXdXuhVNnNrM0S9tDiL4YW351ngONGWMku/LFmjAT+yDN1mxln0zia6ID/jhIXxJo9ApRjNSwqIw==
X-Received: by 2002:a17:902:b109:b0:190:bf01:3a45 with SMTP id q9-20020a170902b10900b00190bf013a45mr18618572plr.25.1671590653005;
        Tue, 20 Dec 2022 18:44:13 -0800 (PST)
Received: from debian.me (subs28-116-206-12-57.three.co.id. [116.206.12.57])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903245200b00177e5d83d3esm10115137pls.88.2022.12.20.18.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:44:12 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id EEBF7104964; Wed, 21 Dec 2022 09:44:07 +0700 (WIB)
Date:   Wed, 21 Dec 2022 09:44:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: Improve usb_fill_* documentation
Message-ID: <Y6Jy90O38E25QgN6@debian.me>
References: <20221220-usb-dmadoc-v2-0-4dd4f198113e@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hNraL9BI9bJyuoZF"
Content-Disposition: inline
In-Reply-To: <20221220-usb-dmadoc-v2-0-4dd4f198113e@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hNraL9BI9bJyuoZF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 12:13:08AM +0100, Ricardo Ribalda wrote:
> Make the developer aware of the requirements of transfer buffer.
>=20
> The buffer must be DMAble, if the developer uses an invalid buffer, data
> corruption might happen.

Better say:

```
Document the transfer buffer requirement. That is, the buffer must be
DMAble - otherwise data corruption might occur.
```

> - * @transfer_buffer: pointer to the transfer buffer
> + * @transfer_buffer: pointer to the transfer buffer. Must be suitable fo=
r DMA.

"... The buffer must be ..."

> - * @transfer_buffer: pointer to the transfer buffer
> + * @transfer_buffer: pointer to the transfer buffer. Must be suitable fo=
r DMA.

Same here.

The rest is LGTM, thanks.

--=20
An old man doll... just what I always wanted! - Clara

--hNraL9BI9bJyuoZF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY6Jy8AAKCRD2uYlJVVFO
oyu4AP9RGvSyV5sX7yoqWF3dHrsRR+M4rQJ2i3D6CPVgp3/t9AD+Pmacn28PzDkQ
GL575b2RdKJ8bAecfEy3HFHXqCnW7QE=
=bOKJ
-----END PGP SIGNATURE-----

--hNraL9BI9bJyuoZF--
