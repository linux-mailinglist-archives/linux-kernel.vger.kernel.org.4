Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CF16BB462
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjCONUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjCONUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:20:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6C24122
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:19:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p16so12540237wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678886387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUlnp1fB6sDr4A7BqDurvwTCfCpIFKb0AFx9h4y4qgs=;
        b=UEOfl28r8EeUXOKXouo1hBqWMuNis1mmzwyRAmX1RWRzptJB4gfHITSw9+0EiaMqZ1
         HIf0WeJtbD5ZTot0365o8M3+tVRYqcvX3jHp8SRMm6DEzzoXv3G0N4yoOYa88nL0weYr
         HmI5wc31hGPWaFOOHJ2NgRPNgNaNWiTFMCa/BAOoJZpRAzAtTQEtisSmqKNTtZhAFRaT
         qkk6WOXHSASEMZDPkkFmZd3wpAuiVXsNB2t18uMGtYeeL5qgDhtXv6za5DPbsa2fdEoe
         8QEwWd9C1f6EjdWRRf4+xo+x3/aMH7kB0UosIYl9SY2jU3t0JB71LUXHOPjDAkZx3zfB
         PYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUlnp1fB6sDr4A7BqDurvwTCfCpIFKb0AFx9h4y4qgs=;
        b=ZTnonrUmMnIa+Jw2WzD5cBDammpf8qYByX89scGTtNVPB7/IDX7ZYmGrA2l0uxPWzn
         2P1leUmIzrJNKm9V6dRQSKH4+6W64mAf50t0xyeIV2hEoCVcs61v1+9yQZW+xbQqrFvC
         S9DCW+RIhTwdxKAwZivZJcZVEJ8WtbIvyFIlR/pO5QBnhe4PkxrLN3v9pG58RPXi3ZDD
         pvEXTrPK1Ww1Fi0D9OueE4JT6prDsoSq9PiA82I8pOvZfyMa/3rjg1sEUKy/iU1rPbSl
         yXiGbo0Fmot2cJiq0odfU/nEEGEa1y53EOyMYz7Y57xUAgr43nnsXIGvKDAqNp99M4OO
         PlfA==
X-Gm-Message-State: AO0yUKXSSmLuzs2vcShE01IlYZfQ2G2RmSswAkqmrKFrBUKl14gj9SjM
        a9kXRLYbRY1l03MBClFiOZg=
X-Google-Smtp-Source: AK7set+qRkJFNWa6iCgoQYjmiHQddUMUBq8CB04MbNnjr8zLbiMiMRp+wKP9QeeR0gATLEJlrstn0Q==
X-Received: by 2002:a05:600c:1c96:b0:3eb:3300:1d13 with SMTP id k22-20020a05600c1c9600b003eb33001d13mr17750518wms.14.1678886387320;
        Wed, 15 Mar 2023 06:19:47 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003ebff290a52sm2120911wmo.28.2023.03.15.06.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:19:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: Re: [PATCH 2/2] staging: vme_user: remove unnecessary blank lines
Date:   Wed, 15 Mar 2023 14:19:45 +0100
Message-ID: <2403283.QvUyjg2IbA@suse>
In-Reply-To: <8958127fc8fdb4fede7867f38579578af924b719.1678882204.git.eng.mennamahmoud.mm@gmail.com>
References: <b56c7b94e59a4051373af8b5d90a0685dfc9233a.1678882204.git.eng.mennamahmoud.mm@gmail.com>
 <8958127fc8fdb4fede7867f38579578af924b719.1678882204.git.eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 15 marzo 2023 13:21:33 CET Menna Mahmoud wrote:
> remove unnecessary blank lines before a close brace
> as reported by checkpatch script
>=20
> CHECK: Blank lines aren't necessary before a close brace '}'
> +
> +}
>=20
> CHECK: Blank lines aren't necessary before a close brace '}'
> +
> +}
>=20
> CHECK: Blank lines aren't necessary before a close brace '}'
> +
> +	}
>=20
> CHECK: Blank lines aren't necessary before a close brace '}'
> +
> +}
>=20
> CHECK: Blank lines aren't necessary before a close brace '}'
> +
> +}

There are no valid reasons about copy-pasting that warning 5 times in a row=
=2E=20
Just say that you get that message from checkpatch.pl in five different sit=
es=20
in the file you are changing.

What if you had had 20 or 30 occurrences of that same "CHECK" in the same=20
file?

Thanks,

=46abio=20

> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
>  drivers/staging/vme_user/vme_tsi148.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/staging/vme_user/vme_tsi148.c
> b/drivers/staging/vme_user/vme_tsi148.c index bfa604043355..2f5eafd50934
> 100644
> --- a/drivers/staging/vme_user/vme_tsi148.c
> +++ b/drivers/staging/vme_user/vme_tsi148.c
> @@ -1023,7 +1023,6 @@ static int tsi148_master_set(struct=20
vme_master_resource
> *image, int enabled, err_res:
>  err_window:
>  	return retval;
> -
>  }
>=20
>  /*
> @@ -1741,7 +1740,6 @@ static int tsi148_dma_list_add(struct vme_dma_list
> *list, list);
>  		prev->descriptor.dnlau =3D cpu_to_be32(address_high);
>  		prev->descriptor.dnlal =3D cpu_to_be32(address_low);
> -
>  	}
>=20
>  	return 0;
> @@ -1773,7 +1771,6 @@ static int tsi148_dma_busy(struct vme_bridge
> *tsi148_bridge, int channel) return 0;
>  	else
>  		return 1;
> -
>  }
>=20
>  /*
> @@ -2220,7 +2217,6 @@ static int tsi148_crcsr_init(struct vme_bridge
> *tsi148_bridge, }
>=20
>  	return 0;
> -
>  }
>=20
>  static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
> @@ -2530,7 +2526,6 @@ static int tsi148_probe(struct pci_dev *pdev, const
> struct pci_device_id *id) kfree(tsi148_bridge);
>  err_struct:
>  	return retval;
> -
>  }
>=20
>  static void tsi148_remove(struct pci_dev *pdev)
> --
> 2.34.1




