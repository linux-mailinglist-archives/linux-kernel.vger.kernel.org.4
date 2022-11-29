Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C12263C076
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiK2M4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiK2Mz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:55:57 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F911E719
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:55:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id h33so7949387pgm.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy83467U3H+rFGcrG1yDL7ih1Oqj7wh1LLSNdYTMBcU=;
        b=EiKvu64eC4DHQOcOHzxwMOqMowCIQqVSJAltDSBm2vZfQiVxgtIAjita4f/4fc9nBj
         hyg143hB0ZilxYPFKHSjI2VChiX9FrtSbL09/bkjBExq/gK8CvOGsdF36t1AyjpaxZGq
         WzbdEHzjL17HmI3w3nGbUCUe2XKcZifAm7fF5tTaA+kQDbBxrumEAzHUKhjx5fA8mgf+
         /4hijeV/euU8jDyrolSFU9Q3XbCpAyx7Rk3FrpYQGMz97jzgwYroJv7YqF8w8TJjXjgr
         70Pt+SWy6EHEAo97X1Ax3PN5V6tnHinYO8wOpAq3mQfzX9E51Xyvs8h6Ki/uLuv1qmwD
         eRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy83467U3H+rFGcrG1yDL7ih1Oqj7wh1LLSNdYTMBcU=;
        b=Od9lZfih7oCMTraBbnhVAZm47LPuyvGU3n7B2kEqMhLgTr0PEzS6ZOqsuOt/YaIy3t
         GmSdSg9LFTLVoBbGUPqHEfK3fzqNsPpZ2Nvw6pcyz43VvVCgx6Sew0XLH5eV9+LChYtN
         dHSfg9AQdjlBih684Gw1/U/ITgFMvY2x2GBRrVt8AD+vRg6GkjD4v+Ju0a1bSiQ0PRlH
         9ugRpTQS6zrXjaX5BNkwRQJF/0shTrEeQvlZgy2JDmSbZwI+Ls2jcDXVHmslDm/tiMpy
         A29qavoKMjN9Gnh1aF31kUkb5nrWS67kPPqdDQ+qeUjcpGPD7HWeSynoL2qjIuNWus7C
         nudw==
X-Gm-Message-State: ANoB5pkCZmMXa1XVbcAahi1S7M9Dt4v7e9cf9pxojRox9raqt809vwiZ
        /TM6h0EYeMKRV9hBU2cJhKBaTXRwc0xNj7CEo/k20Q==
X-Google-Smtp-Source: AA0mqf5sdoqiDXcTRSYvQNo3bLhe4FZXxHWETUy05AGd2lsnn1ZSSsG4KgM2ksUgpvXlj2KB91hAxORiqb0e+pNIj00=
X-Received: by 2002:a63:2154:0:b0:477:b650:494b with SMTP id
 s20-20020a632154000000b00477b650494bmr28701267pgm.434.1669726534164; Tue, 29
 Nov 2022 04:55:34 -0800 (PST)
MIME-Version: 1.0
References: <57d4aceb25254e448bd3e575bd99b0c2@hyperstone.com>
In-Reply-To: <57d4aceb25254e448bd3e575bd99b0c2@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:58 +0100
Message-ID: <CAPDyKFpxUwX=79L1yZ=A7EOSM7WpKwQNPicYTUr+nZrBri7JUg@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: block: remove non-data R1B ioctl workaround
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2022 at 18:46, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> The workaround of pretending R1B non-data transfers are
> data transfers in order for the busy timeout to be respected
> by the host controller driver is removed. It wasn't useful
> in a long time.
>
> Initially the workaround ensured that R1B commands did not
> time out by setting the data timeout to be the command timeout
> in commit cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl").
> This was moved inside of an if clause with idata->buf_bytes being set
> in commit 4d6144de8ba2 ("mmc: core: check for zero length ioctl data").
> Since the workaround is now inside of the idata->buf_bytes clause
> and intended to fix R1B non-data transfers that do not have buf_bytes
> set we can also remove the workaround altogether.
> Since there are no data transfer invoking R1B commands this was dead
> code.
>
> Fixes: cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl")
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Since the code that we now remove doesn't really break anything, I
don't think we need to use a fixes tag.

So, applied for next by removing the fixes tag, thanks!

Kind regards
Uffe



> ---
> -v2: clarified commit message, no code change
>  drivers/mmc/core/block.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index db6d8a099910..20da7ed43e6d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -514,19 +514,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card=
, struct mmc_blk_data *md,
>                 if (idata->ic.data_timeout_ns)
>                         data.timeout_ns =3D idata->ic.data_timeout_ns;
>
> -               if ((cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B) {
> -                       /*
> -                        * Pretend this is a data transfer and rely on th=
e
> -                        * host driver to compute timeout.  When all host
> -                        * drivers support cmd.cmd_timeout for R1B, this
> -                        * can be changed to:
> -                        *
> -                        *     mrq.data =3D NULL;
> -                        *     cmd.cmd_timeout =3D idata->ic.cmd_timeout_=
ms;
> -                        */
> -                       data.timeout_ns =3D idata->ic.cmd_timeout_ms * 10=
00000;
> -               }
> -
>                 mrq.data =3D &data;
>         }
>
> --
> 2.37.3
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
