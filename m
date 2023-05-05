Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CBE6F7E11
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjEEHmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEEHmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:42:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E59F17DFA;
        Fri,  5 May 2023 00:42:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1208495a12.1;
        Fri, 05 May 2023 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683272550; x=1685864550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvUgppSfIXlx3T0H4ExJKT3TgM82YfCHbwZdd+OA/Xk=;
        b=G1IlrfV4q3pXyLQo7vGKIbIgC+zTv6rb7KVR+iK5VTTjIJq5SLSxYisBbAhcxlBZP6
         gWULDdPK12sZfVHEJAn9kJXkhomlZO1ZtW+30oPEQd5GmsRl3wtnNCvs28eNl4MPag1L
         I0OOWbK3re4ICgeMTSM91RvymVr8KsDkBxH2FB+Gf3GHSsLCGB/FBE21rXGLOgy8h89y
         z1qGz2hg+dPuifU0+yFd0pXCYIp8eMIrQ0cD9Shz6MYlMRSGPRN2eKb+SeUvCViSPEXj
         W8cufqM2+cAM7lM+SXq8fRl8qENNN+al93o0ts1eJajZ676AYcrMVW+DHCc81SuzK5g+
         kFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683272550; x=1685864550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvUgppSfIXlx3T0H4ExJKT3TgM82YfCHbwZdd+OA/Xk=;
        b=WqGfokupPZ6WmpGUAS3EUF8YDH0+bBUVa8feWz5HvSEkdrYDbZ11BCrYfuL10JLYLw
         0YtLyfZRGc3LW/egcJTzZlMv5o6pR2llGjSNehuercDpS88PIYJX2jfgtY+SApgGe3vu
         2ei2KvMXhxzu4HWAMHzfyBm+zqUTWBZdFIHXzt3tSIHhQQmyxwtLQervXhGFjeXg7Qi4
         VIH5n20wLN/WlIJhwIqCEmDLelm9bB6m57istEWn6khGoY4Iw14PEIcDegh+sNU0W94K
         whLnVfVfD6K+MBhrKGli1UEKW0+1JHBxuJdbM0YRssRb3RcdVirwm6BLfuibOxlaJM6T
         2Clg==
X-Gm-Message-State: AC+VfDyxr2xf8n4rynVa8ltExbKut1LagXMqDD9nGu/dfMFRgRmncdhQ
        +MH8rbeW0d5bsDCOwmDLLgvpQOP0O1I=
X-Google-Smtp-Source: ACHHUZ7uHA4sZeGrS37G+/C3rDylErJOpV0O/8F/XTCiIXpmmoTSNaOkKcMDgVjBUzGlx+yOH4PEZw==
X-Received: by 2002:a17:903:294c:b0:1ab:1b8:8a5f with SMTP id li12-20020a170903294c00b001ab01b88a5fmr538068plb.33.1683272549688;
        Fri, 05 May 2023 00:42:29 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b001aaef9d0102sm988252plb.197.2023.05.05.00.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 00:42:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 842E4106280; Fri,  5 May 2023 14:42:20 +0700 (WIB)
Date:   Fri, 5 May 2023 14:42:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi:dc395x: Correct "structures" spelling mistakes
Message-ID: <ZFSzW2sFnyXGcJcL@debian.me>
References: <9721BDA46BD84475+ZFTPVLLFKTMn4lSE@TP-P15V>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U5+4O5tRFB+ILI3y"
Content-Disposition: inline
In-Reply-To: <9721BDA46BD84475+ZFTPVLLFKTMn4lSE@TP-P15V>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U5+4O5tRFB+ILI3y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 05:41:40PM +0800, Wang Honghui wrote:
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
>=20
> As title.

1) This is v2 of [1], right? Did you forget to pass `-v` to
   git-format-patch(1)?
2) The trailers (including SoB) should be placed after the patch descriptio=
n.
3) Last but not least, you forget to add my Reviewed-by: from v1 [1].

Please reroll, keeping above in mind.

Thanks.

[1]: https://lore.kernel.org/all/262EBDA8BEEA7619+ZFN1b1D66%2FLp8hzh@TP-P15=
V/
[2]: https://lore.kernel.org/all/ZFOD%2F6rT36evHXNz@debian.me/

--=20
An old man doll... just what I always wanted! - Clara

--U5+4O5tRFB+ILI3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFSzVgAKCRD2uYlJVVFO
o8/7AP95cJRp5nDYDQSPm2ROeJzaV46wr9QystWokCEyAZTpOwEA1bBQIRwc50Zc
Pk8Z1Iv58dloK0i/zBBNMaQ0NxlxSgg=
=GJAq
-----END PGP SIGNATURE-----

--U5+4O5tRFB+ILI3y--
