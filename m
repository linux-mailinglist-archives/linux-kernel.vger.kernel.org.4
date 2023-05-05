Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD96F7BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjEEEMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEEEMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:12:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D579011B76;
        Thu,  4 May 2023 21:12:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643995a47f7so1010093b3a.1;
        Thu, 04 May 2023 21:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683259949; x=1685851949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lH7DdaAqtoGsvrBlBaE7fQdtK2Ol6Msxd6emTLzyGrQ=;
        b=Poazv1uDV4XKBT3piMhHtD6/2sQxy/T4NfrzewHTA/kyTBxBmidHndlOxHgFuYJL/3
         M8YUA29MuAjU1HEtB2729G1Yx1isvMIHHypbAbvSIzRnJeI9Z32VLDrTLQ0Ox6wLf5ZE
         d+SEdbG/UfsyVKMOhMKy1bWUo4QtQOSV/vl9ajCQu4naXW+HEGWxQ+33TLluH9DwiIpL
         T33h7xpjUs2kBe4RhgCUyAcppzciTT8PAk9CC7hQt5BwWkIoQAS8Efi3w5sL4YYhhtfN
         rerDw1l0Q2JwLBQIpJYc8eBIG9JpKqiodYnTvHA50bPvS8/QFkeEyMRrHz2OYmRWRVXc
         uxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683259949; x=1685851949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH7DdaAqtoGsvrBlBaE7fQdtK2Ol6Msxd6emTLzyGrQ=;
        b=HtCPPwF4ydBEVoZXpeAlk4t61jx3+lDBznagsOZLJKUx5cgpideX5qfoRzZ59InyXv
         u6G1nZT/59bcTcgovokAi3spQ6MXjYfdAjoeDXNnM/F0py+5VLLpioFwjA8HgaJSB9eL
         BkPJqShmlHgGzob3nGCLai5BDXDyKNL7h2VdkkbOfIzkG2c0THJzQ93tVoC/q6+Fynf/
         F/VXkl9oPhZzLcKbV+PzwoSIEnxt178jTNb6PoHvOUx/Is+9K35biHEhn3WYNZtf71lq
         dVZU9oTBajr0dHoVOG7/q/GC9qmpFEIVNIXPoAS6Ewj77av1mL0fq0XAvnEP2/rKoKKY
         NZCQ==
X-Gm-Message-State: AC+VfDyQK/GMNZZ6PlUuH7vqXE44tXptJAzzP3B9UZA2AUsHO65mYb3/
        WZmRAOKjoE/k40kI9gS8Clk=
X-Google-Smtp-Source: ACHHUZ4P/UW9z5k6xy2K7UR6Gp/5gMFGUx9Lk04zz/+HQGVTJgHMobKi7VdFmH1rK4pbldP8MSt6KA==
X-Received: by 2002:a05:6a20:4293:b0:f2:64f8:b214 with SMTP id o19-20020a056a20429300b000f264f8b214mr248640pzj.13.1683259949146;
        Thu, 04 May 2023 21:12:29 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-25.three.co.id. [180.214.233.25])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78dc6000000b00640e01dfba0sm537123pfr.175.2023.05.04.21.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:12:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 598EE1068DB; Fri,  5 May 2023 11:12:25 +0700 (WIB)
Date:   Fri, 5 May 2023 11:12:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 04/11] Documentation/hwmon: Revise hwmon kernel API
 reference
Message-ID: <ZFSCKa0SaH6pqDVC@debian.me>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-5-james@equiv.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TArBaNHqyhj2iQWJ"
Content-Disposition: inline
In-Reply-To: <20230504075752.1320967-5-james@equiv.tech>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TArBaNHqyhj2iQWJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 12:57:45AM -0700, James Seo wrote:
> Reorganize content into coherent sections.
> Use kerneldocs to document functions and data structures when
> possible and add more details on using various API facilities.
> Fix minor issues (typos, grammar, etc.) and add markup.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--TArBaNHqyhj2iQWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFSCHwAKCRD2uYlJVVFO
o1wjAP9Lud+NvAPsROUHXOvKVK9niGxnyshZqeA40JS/oqx4swD/dZdarpQrNkhJ
o5DYlxSM/vISrRx/FgNI0JrOVnWvrgw=
=UKtj
-----END PGP SIGNATURE-----

--TArBaNHqyhj2iQWJ--
