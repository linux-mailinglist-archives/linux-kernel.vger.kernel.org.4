Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1916D4FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjDCSGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjDCSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:06:35 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF02134
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:06:31 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p15so35824267ybl.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680545191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3+CGgkV2d0ZP2AifjfGuZxpORJesoO0QYyuCsv4r+E=;
        b=NddeXaLZuzRH7Wyzxun5Obh9pZoC5BBViRpzGRX9WSglrTMJegKakvZjaFE7EIFH+q
         4l35AVtGjDRRWXp6CiM4RilJCr33CSGzKqYhbwgJPb9PAVTwZUyV0tCUygok5m96djnt
         ycOfl+ZhEDWH5ksV/LgtfFbf/n61BODh8wsKXK3aJ3aPC1epu5zqKc92MM1Y4q1e1nDz
         2M2KjogXpB+tdjnFwz/HJRgJAoJOGniKpXWZtPbnfezwzDKcN6YdZCpsJOdY2f4pQTQJ
         JfEnOzR6TuNUzQ38NQPBqUbbDs0MDmi/lzv/x2MtP7Za2AnIgFk/ZOCpaTxvCgw2vNlJ
         1ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680545191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3+CGgkV2d0ZP2AifjfGuZxpORJesoO0QYyuCsv4r+E=;
        b=ZwIr2QMr9aVM1ScKeztl3yhGgU48pYUarXMOKRtRk2bgH/5Svu2xohdfG1eBS3WUYY
         6LeHX6xtGjpvzfm5iExj8p10qQvWtHLGfcYsKbN2ZcpgzBDnf4Wri4bpgSj2G+6PbVa6
         XmuzDKcBF5IVgV5C+/+MxEzD+80YCS1fqHWC4jhqVOA6z+wYsuhpVAI78oOrjVXDxuTS
         oyYg1I4eVH63MwmX4q5hdyKFg0xgzl0dpTxHwse3GIEq2XNA0BPLn4UrwRdOF3ZcJswB
         b//IAdY0cP+tVGNVQ/4Hezx7olOEIEiNvmTBqDldOvTxRV1s937PNWr6j8gck1t71ca2
         wBaQ==
X-Gm-Message-State: AAQBX9d09io5lVs/UNvw44Bcn+T7Jr7hlynhG3S2iAIJ17OVcKPcokfy
        ejWoGC4nqFSdP5cm7xLcL/bi7XE0tHsN2bQ9gfnhNQ==
X-Google-Smtp-Source: AKy350adyf52Qf8n2RJgfBrenXa792BIu5quX/ej/yV0XoVlcPUJDBEDxZwRGsppNX5dxtISxuCLiw==
X-Received: by 2002:a25:aa07:0:b0:b39:fe58:e25d with SMTP id s7-20020a25aa07000000b00b39fe58e25dmr191821ybi.3.1680545190785;
        Mon, 03 Apr 2023 11:06:30 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d2-20020a056902084200b00b7767ca7476sm2705100ybu.19.2023.04.03.11.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:06:30 -0700 (PDT)
Date:   Mon, 3 Apr 2023 14:06:28 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 0/4] Migrate IDIO-16 GPIO drivers to regmap API
Message-ID: <ZCsVpNmNMDCZBPfl@fedora>
References: <cover.1680296343.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1brxflNcpEOs0Vcu"
Content-Disposition: inline
In-Reply-To: <cover.1680296343.git.william.gray@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1brxflNcpEOs0Vcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 05:05:22PM -0400, William Breathitt Gray wrote:
> Changes in v4:
>  - Remove superfluous base check in idio_16_reg_mask_xlate()
>  - Format idio_16_names[] to 8 GPIO per line
>  - Utilize dev_err_probe() in idio_16_regmap_register()
>=20
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver. The 104-idio-16 and pci-idio-16 modules depend
> on the IDIO-16 library and are thus updated accordingly.
>=20
> By leveraging the regmap API, the idio-16 library is reduced to simply a
> devm_idio_16_regmap_register() function and a configuration structure
> struct idio_16_regmap_config.
>=20
> This patchset depends on the "Drop map from handle_mask_sync()
> parameters" patchset [0].
>=20
> [0] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.=
org/
>=20
> William Breathitt Gray (4):
>   gpio: idio-16: Migrate to the regmap API
>   gpio: 104-idio-16: Migrate to the regmap API
>   gpio: pci-idio-16: Migrate to the regmap API
>   gpio: idio-16: Remove unused legacy interface
>=20
>  drivers/gpio/Kconfig            |   7 +-
>  drivers/gpio/gpio-104-idio-16.c | 286 +++++++------------------------
>  drivers/gpio/gpio-idio-16.c     | 254 ++++++++++++++-------------
>  drivers/gpio/gpio-idio-16.h     |  79 +++------
>  drivers/gpio/gpio-pci-idio-16.c | 294 +++++++-------------------------
>  5 files changed, 289 insertions(+), 631 deletions(-)
>=20
>=20
> base-commit: 4ea0c97776bf8c63805eb0f8182d9c20072219d9
> prerequisite-patch-id: cd19046150b7cff1be4ac7152198777aa960a3df
> prerequisite-patch-id: bd3e3830d9ce4f3876a77483364d7190b7fdffa7
> --=20
> 2.39.2

The 104-idio-16 and pci-idio-16 drivers here likely need
use_raw_spinlock enabled for their respective regmap_config structures
to prevent deadlocks as described in the i8255 fixes patchset [0]. I'll
submit a v5 of this patchset to fix that.

[0] https://lore.kernel.org/all/cover.1680543810.git.william.gray@linaro.or=
g/

--1brxflNcpEOs0Vcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCsVpAAKCRC1SFbKvhIj
K/SVAP94BlaQ43teo7R8RFUgamJIROWAUFqiketa0AXmUz9iXQD9GCFVYlof/ycj
3tAq5rphog/cZ7IGPmLQ+dTTfA/Sjg4=
=T640
-----END PGP SIGNATURE-----

--1brxflNcpEOs0Vcu--
