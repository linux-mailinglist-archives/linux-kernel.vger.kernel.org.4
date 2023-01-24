Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D27678ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjAXDIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjAXDId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:08:33 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE33729E3B;
        Mon, 23 Jan 2023 19:08:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jm10so13400986plb.13;
        Mon, 23 Jan 2023 19:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zl51L2YCfCRRJTRQsCzHwSFrb0PqSyLFDnXqEM45mak=;
        b=B2GOUU36rv0jrvPLAjptNCAnS1OgokYWxxZpbUz9eO52RZjglKjPhUa+QoRYS9LL/n
         fPgSLXE7MPAxI2NnOIWI7UOamw3wFLjuuOrJjldqoPXfQ9BjEHy7AnMe+lP5wSM8fEOE
         WOY1jphzrX10HJxCkWQJ/T/334pWRuTFpu530KfSNYxE9reldAzGgoBpRwF02gl7Zces
         W1s4zOeSUtkZaYQU0nufEZcTergjxPar/bW1k7CBR6UFR3P6H9Az3dKM2bBJg//p7c/u
         fT5/0pg6y9wUAVXQeofout1FNaFN8zJDvNCJLWzGh1xKxDB6sPAl5eDHVFhAqM1b7udQ
         VsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl51L2YCfCRRJTRQsCzHwSFrb0PqSyLFDnXqEM45mak=;
        b=M9RJ6yUqlWtRsD1YTXarj4P+xPG1VMgiWqqTfEKl/cOaIsYj/3i/o5rgF6CVHQuttc
         OVM3NeyV3MSrlLhYMIvKhypRdrN0EqIhRd/Goo2eQyke5M91zTuN6h4E42mhdInZXmQV
         2KgUkKlow59DpRYtyyfnwabjRoxIRJVZvBU9bTGO4kCkLDIvK8B7klVbO509ro7jSpcp
         1UwdwOXLQW669yjIN8p6mTw0mAKL9ILPIrgGAB2nnfimMVIAJQ6eNniFU15saTnhTn/T
         lua5y6ctVo8eyNBl0JoE0ejIlDH3m5Qny2KD9T4rtOO3ODo+PiFdrE4GEs63vgffcNgc
         raqA==
X-Gm-Message-State: AFqh2kp4nYp03NsrUdScEBBUv43ncsyHDivDMOtzYp6t5YAiCVwGSgVt
        J5KCar5mOAG0XMBb7oT6nUK4/581pm7FPg==
X-Google-Smtp-Source: AMrXdXuf22Pdp4cDMDLVzrUV5OMqEq/085szkFSH41jM+xqw/CxBrYfVN83IAyxBTLpnxS8bcHQzkg==
X-Received: by 2002:a05:6a20:b282:b0:a3:a90f:5326 with SMTP id ei2-20020a056a20b28200b000a3a90f5326mr25783497pzb.61.1674529712400;
        Mon, 23 Jan 2023 19:08:32 -0800 (PST)
Received: from debian.me (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id e8-20020a656788000000b004d1d89ec63fsm282587pgr.6.2023.01.23.19.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 19:08:31 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 13968105170; Tue, 24 Jan 2023 10:08:28 +0700 (WIB)
Date:   Tue, 24 Jan 2023 10:08:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yoann Congal <yoann.congal@smile.fr>,
        linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Documentation: kprobetrace: Improve readability
Message-ID: <Y89LrFN0ua3p3pNE@debian.me>
References: <20230121225304.1711635-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sel1TNfbmc4EwpVA"
Content-Disposition: inline
In-Reply-To: <20230121225304.1711635-1-yoann.congal@smile.fr>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sel1TNfbmc4EwpVA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 21, 2023 at 11:53:02PM +0100, Yoann Congal wrote:
> Hi,
>=20
> Version 3 of this series of small readability fixes on kprobetrace.rst.
>=20

Quickly skimmed this series, it LGTM. Thanks for submitting.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Sel1TNfbmc4EwpVA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY89LrAAKCRD2uYlJVVFO
o5/zAQCy17GusBRTmSGAGwpCkY4vNXkBuXx/mAV7BXFRVI7IfgD/cIOnCh9eomoI
fRLSiy8WsEoS0IAa3trlQobCHbc7GQ4=
=JndY
-----END PGP SIGNATURE-----

--Sel1TNfbmc4EwpVA--
