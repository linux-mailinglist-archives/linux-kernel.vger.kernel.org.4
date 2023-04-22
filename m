Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3426EB708
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjDVDSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 23:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDVDR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 23:17:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86619B4;
        Fri, 21 Apr 2023 20:17:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a5197f00e9so24153665ad.1;
        Fri, 21 Apr 2023 20:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682133475; x=1684725475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ro9WxBg3nAsMPx4XvKLNPdXQpuH038dO7bV4dlzLzyM=;
        b=ocKjaQmFsMBBPD53/mf+PXlwKLosIf2W1+0alr1mh8QE0TjaMhkCHb62g0JN17fRxg
         CflH83+LrJhEF/mE8j18M7flZAv4q6/4WNzM5d/q1LBXMNnDwrvX/x2LTsegvfiC5LT6
         o9M8DczIUyb5Zbb9NpWo+23r3ZndIBl7zHJcl8SI9w1hioNFRTATnh1ej8BozYekcFZY
         qJYApoXY1xtVN+hJRtWUmZj6VtAKoihTn8B3R/blOE++CLI2qroUx/10tuhQ56aImoqF
         8C881wG6PT+s22vcEfgEhA5uJU1bUVqpo+EEpqHFAlWPUeubPkPNBEhKcO0X9LxQCwxF
         kQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682133475; x=1684725475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro9WxBg3nAsMPx4XvKLNPdXQpuH038dO7bV4dlzLzyM=;
        b=Oth07RriRhrCJCtLaAmf15NivAXVAgi8SmtVTqJtu0jvKZWE2PylgvUxsye4AKPPhs
         phgu+8EOkrBqi61Uwp8LT0pmOG7OomeTxUfBzw6rck41odD3beZIcOBXO0E0GROG9V8k
         QyKzvia+fGX4n6hy8zeq2BmpZ1LdmYKxLi8egF9q7U46SoQ58WeZUwgGDAN9CTqEZejZ
         a+K6ZcujhGQvHkMcegNB4A390kLltcVUYaDa6pyPu/hzFxPjUQZqRI0rI+LVj5KW398X
         ucaZqMpeyVt9yx5TC631AhpkhAhT4hG9Tn9oUdl/wkhDOpZAv3J+yyTRp9PRw4jO4zoK
         9XyA==
X-Gm-Message-State: AAQBX9dj3NVD4VVJSgvrQkbD+rmud5uJGAXpvGqP4ug7LMXa+v8pwsn7
        v+ia3VNJgEu1AAs6FtPzyBY=
X-Google-Smtp-Source: AKy350ahrxtMfvGaOr/CB/BRc/hQA+C6Ggm3IkcnUj5nQb6eRkPlyvwmkRxMb9/q89kqCUBlY+qMfQ==
X-Received: by 2002:a17:902:a989:b0:1a6:5575:9059 with SMTP id bh9-20020a170902a98900b001a655759059mr6736489plb.62.1682133474789;
        Fri, 21 Apr 2023 20:17:54 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-89.three.co.id. [180.214.233.89])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709027b8800b001a661000398sm3287567pll.103.2023.04.21.20.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 20:17:54 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 83E371068A8; Sat, 22 Apr 2023 10:17:50 +0700 (WIB)
Date:   Sat, 22 Apr 2023 10:17:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, kraxel@redhat.com,
        dovmurik@linux.ibm.com, elena.reshetova@intel.com,
        dave.hansen@linux.intel.com, Dhaval.Giani@amd.com,
        michael.day@amd.com, pavankumar.paluri@amd.com,
        David.Kaplan@amd.com, Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Message-ID: <ZENR3go7UFkd7/0a@debian.me>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZCQVmIKXWXX2xvo-@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3g8wlG6vw73gCno8"
Content-Disposition: inline
In-Reply-To: <ZCQVmIKXWXX2xvo-@kroah.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3g8wlG6vw73gCno8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 12:40:24PM +0200, Greg KH wrote:
> > +   * - Guest malicious configuration
> > +     - A malicious host modifies one of the following guest's
> > +       configuration:
> > +
> > +       1. Guest firmware or bootloader
> > +
> > +       2. Guest kernel or module binaries
> > +
> > +       3. Guest command line parameters
> > +
> > +       This allows the host to break the integrity of the code running
> > +       inside a CoCo guest and violate the CoCo security objectives.
>=20
> So hosts are not allowed to change this?  I don't understand the use of
> "violate" here, sorry.

I think the situation described above is when malicious actors gain
control of a CoCo host.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--3g8wlG6vw73gCno8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZENR2AAKCRD2uYlJVVFO
ox5gAQDr0xDZcHVst4ZSWAsItsLfu4e/paGzNVDkaipTysmkPgEA5zp3+WfbAkW+
XHdKvwKTa9cvmJFockTMXNcdcO9C4gI=
=yGwU
-----END PGP SIGNATURE-----

--3g8wlG6vw73gCno8--
