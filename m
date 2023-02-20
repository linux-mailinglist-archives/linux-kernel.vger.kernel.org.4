Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8FA69C7EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBTJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBTJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:49:55 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE7CEFB6;
        Mon, 20 Feb 2023 01:49:53 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id l15so1851743pls.1;
        Mon, 20 Feb 2023 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkuF2XpcLlHLBtotkO9F3qPaIksG7O8FBf992O8c4NU=;
        b=hJ9+wMznx7QDABJjPSpKynnLC0yXJ4zeBSgzMHQNGNuTjRQj57l0VD15FOEj2SJesf
         Dhtoe2Vi6rVbi3fdIiPYybPoFCuMbJIORp6uRWlK+gz6Xq8H+I3l0E0pGxUGbCm/bW7m
         EnGFXSXLG7tqPY+3qS2z4/+JR5g4DkFzgO7+4YsL6/aqkiBdkdDQ3tFsYH21+yvO+aXz
         5e6UpyCSjHnEMNGURECIhbtoxTnng+I2iW/4gpXKg1Y+hf0bcpOHaSepHyBPdm3pGG90
         MSkKo/VnkE1UHtO9CNoqibIDBHwYzN1mut1TwLocBmNRacExOMVFr9JFGcTX/YlQuY5Q
         Ovuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkuF2XpcLlHLBtotkO9F3qPaIksG7O8FBf992O8c4NU=;
        b=Zrzz2PnfZSZhX1ed5heKPkEllDksCmXKf2O8aEngrOJ6Z+L261Zf2MF7FgQVX2rfNm
         D/lqqpypNiignTQowY1aqOpYYIDCegfyhqo5s2pFxzRDRxssJySka85Vq85WVvFO1qCT
         Jqo/XpXFPHQhxyS4Q2xAEH+vJhCyNZUbh02nR3j084i5x9DcBfATDvEkXnyqTShGtURF
         yDsC8/2Igd4dhdh/+OjqcDwHoTwJc8RXdF5lK51n4Os7xyL6sre6K9MiOTnfXMQHgDKi
         w+8kGsvrfIlFSfjh5sa3MH2hcWV7Qj3uFCQcgBvHYebBcWb7E0odfiLaSwsTGGkR5q6m
         GYvw==
X-Gm-Message-State: AO0yUKUu/NA+b9zUU+TmXiJHKVxh2GzPvPxwwkbWKPgUVH1HwBBgksgC
        55kootqM9DdNxFmEcDg4Wuw=
X-Google-Smtp-Source: AK7set+wDuPOLZ7wT7N9QwMw1u9NB8NnYkJxDvivatC3VbubxYQwmyQWgKGQvo4LQY+k4iVObsZs7A==
X-Received: by 2002:a17:903:5c4:b0:19a:fd85:1895 with SMTP id kf4-20020a17090305c400b0019afd851895mr238590plb.3.1676886593048;
        Mon, 20 Feb 2023 01:49:53 -0800 (PST)
Received: from debian.me (subs02-180-214-232-13.three.co.id. [180.214.232.13])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b0019608291564sm7488793plw.134.2023.02.20.01.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:49:52 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id CD17F104661; Mon, 20 Feb 2023 16:49:48 +0700 (WIB)
Date:   Mon, 20 Feb 2023 16:49:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg KH <greg@kroah.com>, Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <Y/NCPC3rjOT7dJtE@debian.me>
References: <20230220163133.481e43d8@canb.auug.org.au>
 <896c1146-21bb-35bb-dc25-a12014eb5ccd@bytedance.com>
 <Y/Mh7uA61KMvMHAt@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uWTzqJDj9FojYxYY"
Content-Disposition: inline
In-Reply-To: <Y/Mh7uA61KMvMHAt@kroah.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uWTzqJDj9FojYxYY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2023 at 08:31:58AM +0100, Greg KH wrote:
> On Mon, Feb 20, 2023 at 03:26:41PM +0800, Qi Zheng wrote:
> >=20
> >=20
> > On 2023/2/20 13:31, Stephen Rothwell wrote:
> > > Hi all,
> > >=20
> > > After merging the driver-core tree, today's linux-next build
> > > (htmldocs) produced this warning:
> > >=20
> > > Documentation/filesystems/api-summary:146: fs/debugfs/inode.c:804: WA=
RNING: Inline literal start-string without end-string.
> > >=20
> > > Introduced by commit
> > >=20
> > >    d3002468cb5d ("debugfs: update comment of debugfs_rename()")
> >=20
> > This is just a comment modification. Didn't see where my modification
> > caused this WARNING. :(
>=20
> Yeah, I don't understand either, here's the diff, what's wrong with it?
>=20
>=20
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -802,8 +802,8 @@ EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
>   * exist for rename to succeed.
>   *
>   * This function will return a pointer to old_dentry (which is updated to
> - * reflect renaming) if it succeeds. If an error occurs, %NULL will be
> - * returned.
> + * reflect renaming) if it succeeds. If an error occurs, %ERR_PTR(-ERROR)
> + * will be returned.
>   *
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.

Hi Greg and Qi,

The simple fix is to drop the percent (which is an inline code variant):

---- >8 ----
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 58a35afb7c5d89..a7a6a0821605a8 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -802,7 +802,7 @@ EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
  * exist for rename to succeed.
  *
  * This function will return a pointer to old_dentry (which is updated to
- * reflect renaming) if it succeeds. If an error occurs, %ERR_PTR(-ERROR)
+ * reflect renaming) if it succeeds. If an error occurs, ERR_PTR(-ERROR)
  * will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--uWTzqJDj9FojYxYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/NCMwAKCRD2uYlJVVFO
oyNHAQDDOW915RsZyzcbtOQMygi0ddnO2B/mXpXEfcMD+LITyAD/Ut85gOa1xWSB
R36OA91Eb+GT2b/+kMRyGgCXwTe7dwE=
=JcLD
-----END PGP SIGNATURE-----

--uWTzqJDj9FojYxYY--
