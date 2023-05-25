Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E20710221
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjEYA6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEYA6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:58:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9659DE6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:58:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae50da739dso6447965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684976285; x=1687568285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAPj42Llo1zBn7j5EbZjUwNn1stxlOLmIFbZP+Hkftw=;
        b=sWE5ttu3IOXvq5dPyRBpeVf+bDhetwFF738sdeIWuimyyiaHOkxhav9sQg3tTgc91z
         bK7sKVesnW5qwF+P3y1gUG0uoH73rhx+bkvwhXldiYbhYUV+RrMpl0exxYN7PP6+HGEU
         FU+s9gSBGTDVP3WIF0BjcE1UdvboZ1FE/dkAjCpPiDDutsaZ/u7pi5/9WQpPpNkvb1Gs
         Z8TpW8V59Lqn3Xti6S16RkRWlOpslsh5mDZs15+ZZYf1jVvj999Snw9VgawFwlkCBsHo
         eqHSppNjj7DpNC14XSkoBhooTRdrKVsjAfG+aG3zr4Z34f9LuIxigXjPpOKk1AKZM0so
         7Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684976285; x=1687568285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAPj42Llo1zBn7j5EbZjUwNn1stxlOLmIFbZP+Hkftw=;
        b=hA5238KiynFXH7WHr5dCE3svzJ22vMrITZRppvganmgfb95xjIu2oQwmk50XNtMJvv
         B81gmeAFSHCOf7De9Q1gcV/06fWGjzHSjX/hdx7K71bZ/8qe/+5XHEE9X7bcxh/Ipdp2
         jN+e9E+tCGYxtzTO1Rz2DdRsRUDTQO65yVtcWXB7GQ8pA5rQW1WPM102D/ubjxdqjbOe
         7GEDjoR6Top3D7KZFhwopHb1BerpW9x4lJn7YUocQFYJunzAxPDpuxPh7g2UsZlu8sHa
         Nu3xj5Ggm7kVe6cLMK/ZWwRP8zJheKv2DS+ILkdl47j4vt6BXdmeUi4B3GcycWQl7psA
         mURQ==
X-Gm-Message-State: AC+VfDwNYVtpz0sL76y3tl5gjR+QlOPLr3zkPFXKO/JtSuuPJCE6lUnv
        dP/3ss6ZmGQbDl0lrJE/ZBo=
X-Google-Smtp-Source: ACHHUZ6vCwyHjQH58WcHE/CqcAAdVyARITzyZWBize5iGPj/Rzy5RhPCJclyEbqnFkeiDbOlfU74IQ==
X-Received: by 2002:a17:903:124f:b0:1af:9c18:a160 with SMTP id u15-20020a170903124f00b001af9c18a160mr17670692plh.17.1684976284891;
        Wed, 24 May 2023 17:58:04 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-12.three.co.id. [116.206.28.12])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902b68200b001ac8218ddb7sm76943pls.84.2023.05.24.17.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 17:58:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6D35D10625B; Thu, 25 May 2023 07:58:00 +0700 (WIB)
Date:   Thu, 25 May 2023 07:57:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        doru iorgulescu <doru.iorgulescu1@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: Re: Fwd: ./include/linux/mmzone.h:1735:2: error: #error Allocator
 MAX_ORDER exceeds SECTION_SIZE (v6.4-rc3 build regression)
Message-ID: <ZG6yl8RN0ChIfNGG@debian.me>
References: <2a1cd5e6-01f7-66f9-1f9d-c655cc3f919b@gmail.com>
 <5d22e1e9-0307-3664-8b4a-99caaaaa4315@gmail.com>
 <87bki9ai11.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uI/IsBv88xgOn6QO"
Content-Disposition: inline
In-Reply-To: <87bki9ai11.fsf@mail.lhotse>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uI/IsBv88xgOn6QO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 01:03:22AM +1000, Michael Ellerman wrote:
> Should be fixed properly by:
>=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20230519113806.37=
0635-1-mpe@ellerman.id.au/
>=20
> Which is in powerpc-fixes as 358e526a1648.

Telling regzbot:

#regzbot fix: 358e526a1648cd

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--uI/IsBv88xgOn6QO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZG6ykgAKCRD2uYlJVVFO
oxijAP45l+3tHS1RyfI0SLq839DSHCEILcLXGqrYLoT/703ziwEArDioVbgb0kUO
HKdcUrooAH0IKxya1qWE/qkt2ZKQpwo=
=oXBj
-----END PGP SIGNATURE-----

--uI/IsBv88xgOn6QO--
