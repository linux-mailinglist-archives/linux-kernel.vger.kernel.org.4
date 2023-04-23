Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB24C6EBC8D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 05:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjDWDIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 23:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDWDIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 23:08:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE9211C;
        Sat, 22 Apr 2023 20:08:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a50cb65c92so28713225ad.0;
        Sat, 22 Apr 2023 20:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682219323; x=1684811323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRa8+FoOALv4APJpWbkEwxqQB2wwpsdDuWka4oQkSXw=;
        b=EbzaIQRuoTYzlseyU+5IxOgQziMdElPg5BNm5g+ggkhsJWmx89EJd8oiYJ/4Hjehj1
         Y42InVChVjBcjIvWUlvjKqWrFRkM5nZpdKflA/17HfJpZkhRwpdk+5tyj9v7ggDbiduO
         4zdubbU7OaXO+M3Cm4ZVWhipeP497DcBIiWLqJeZzSKBNsupx6h+CHT30L5y0pPETSdY
         Ogpst+nodf5dtL9ZlxXuHThJanPvjnu4A4EuKk3EkW9jH6j0YuMJud9Hn4CdU7dW1H5m
         vo51kfMGoJhIz2s6wIUl/AqyY0GKVrXASIZ73Ebb5sCgwHEpLcY/TTNjlHDH4rMI5K7Y
         S8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682219323; x=1684811323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRa8+FoOALv4APJpWbkEwxqQB2wwpsdDuWka4oQkSXw=;
        b=YadMKEMIL0MkWd6s8gBEhuWeWYlugs1N8SB5zaJPwDSNLccQBVXjeECFcyLe3PrMGl
         eqmikrjK4aDCk9wXy5mbX5tUe5HDsmOx0S5rpicp/H/QbT0CxR8s0fRcnPsIK6C5X6m3
         XvDrWR9EjgrAkHXMDwGBkLTPBOuhH0Zuwyy41guZshTUONPzb2kDlHTdXOBUQAjBHkKM
         NvARKYpV9wa1+nU3aTDxcL8H8AMvwY6geFwBelO5a5LhlBxGmzlwzGapF18q8JvPNDQ+
         n21ZEBcxSil1fNsDbzGytQItuwf7ujcPvu28zVkavreb3hsXCTRG9SD3y5OOz2yd8jeu
         HO1Q==
X-Gm-Message-State: AAQBX9d+p2svpa+PlwLlS/wv1wRaEz9fV0aWuohS3NcJo08h0gBO16+v
        obdX5LsQyCcP8/1WhqdLBkL4LK3eUY8=
X-Google-Smtp-Source: AKy350bTmVHmFQp+sHMoEWRiOX2xVPt0WzEAHxnrS6hDPHNkDRxiO8QJ1ugaI1RmjlNfwIOuxhO94A==
X-Received: by 2002:a17:903:1251:b0:1a9:5dfb:11c5 with SMTP id u17-20020a170903125100b001a95dfb11c5mr4330418plh.35.1682219323319;
        Sat, 22 Apr 2023 20:08:43 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-51.three.co.id. [116.206.28.51])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902bd9000b001a6dc4f4a8csm478065pls.73.2023.04.22.20.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 20:08:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7B7EC106797; Sun, 23 Apr 2023 10:08:38 +0700 (WIB)
Date:   Sun, 23 Apr 2023 10:08:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] MIPS: uprobes: Restore thread.trap_nr
Message-ID: <ZEShNUil0gsVlrDo@debian.me>
References: <1682213883-3654-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O7Is9K1MZxESaB/k"
Content-Disposition: inline
In-Reply-To: <1682213883-3654-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O7Is9K1MZxESaB/k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 23, 2023 at 09:38:03AM +0800, Tiezhu Yang wrote:
> thread.trap_nr is saved in arch_uprobe_pre_xol(), it should be restored
> in arch_uprobe_{post,abort}_xol() accordingly, actually it was only done
> in the post function, just do it in the abort function too, this change
> is similar with x86 and powerpc.

I'm confused (please fix up grammar, spelling, and punctuation). Can you
explain why thread.trap_nr should be restored somewhere else? Also, what
x86/powerpc changes as reference?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--O7Is9K1MZxESaB/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZEShMQAKCRD2uYlJVVFO
o7JPAQCKqSaf6wOMWWRmqM4AeXMOR0pUHFOq5zLSBrenErDLQQEApLxOMi2vHQnN
LJVZgZBTHH2kHDtlkofiZXWfxh6TxAs=
=yyT7
-----END PGP SIGNATURE-----

--O7Is9K1MZxESaB/k--
