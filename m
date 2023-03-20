Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600876C0D91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCTJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCTJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:42:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF81DB9D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:42:25 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id cu12so1277096pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679305345;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZvAMX5itGVrognPljliNPCRQ/XR57NkdNwX/WZ6dW8=;
        b=X/RQc+MQtf8fHRbo+7nE6s0etZ8vwI0fHMAgWx+OIf2A6+yDMLUxALFjB85LRkigR2
         kR+OrNlEoaNAysczkU1e0qil8EDwKhaSamHD1WB+Mi3jR25k8iBWZtqxrxLwtfR+6IdG
         88vBG1dnGjo4VE8plia24MyOeZS9fcNYDcaykqLp6tooVbP9u//6fgGv0VA1E45mzKdZ
         CDM+cxbNePcYIE849s0TW7+DByCWTYSp8ge/Wnxm0aA3USh2GVH8W+Stf07IwQf8l7i8
         svL1/L2x0XYl/hr5sRllXkWFIoslSpYjz8G15nOMdUzbhVF88Vk14Y3cZ/a6JqyXOWEP
         wOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679305345;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZvAMX5itGVrognPljliNPCRQ/XR57NkdNwX/WZ6dW8=;
        b=GpcTlkqprpWszB6iwhW6z/TRIEVOSOADlEu6gV7H8XUlzVE/uAOuLos/uVCt684dsH
         EII5IigJ3SZAXrmKJjVYWgot/y1U/rXzSLjOKU1Gy1DIRu+1Fl2OpMM5MZQzquZkwkW8
         BcSaKs6TEa8x3rKlAdXaG2+4I8KF9sgyc5vOoSc/y7t8gjRV+CTrZ5vzjCk1b/97EsVk
         vkAgJTdgTDHETcXgjAZKBAJn2gHkpyvzpu1wbYrlumI1rRehaktR2sBLikM5kE7VQ3kz
         bCRg07tMqEiAB48N3IHgul8XiYluv220iMelzJ9seeZafvwYOYaFlGvMqqZyJJLMWdT7
         ZKWw==
X-Gm-Message-State: AO0yUKVyRk/Se08qX6ILF39bXFNOzeJ7mKByXa3H4rboVN/jOt/pLAhv
        4uBeutJ111/sEN4CUHRC3o8=
X-Google-Smtp-Source: AK7set8fEGaXukeeDGBrb9yeuD2jFCGf2EqHkOLkmJYo3c1NMtD0lnPKGOpkZcNb/NYlOWCks2BtqQ==
X-Received: by 2002:aa7:8422:0:b0:627:f85c:b7ee with SMTP id q2-20020aa78422000000b00627f85cb7eemr3476700pfn.2.1679305345331;
        Mon, 20 Mar 2023 02:42:25 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-66.three.co.id. [180.214.232.66])
        by smtp.gmail.com with ESMTPSA id a6-20020aa780c6000000b005a9ea5d43ddsm6099809pfn.174.2023.03.20.02.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 02:42:24 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F391C1065D0; Mon, 20 Mar 2023 16:42:21 +0700 (WIB)
Date:   Mon, 20 Mar 2023 16:42:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: vgetcpu.c W=1 error (no previous prototype)
Message-ID: <ZBgqff1Vy5tWTGhG@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QNPWODC6DIaWre3l"
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QNPWODC6DIaWre3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Building x86_64_defconfig with W=3D1 on GCC 10.2.0 (Debian 11), I see missi=
ng
prototypes error:

  CC      arch/x86/entry/vdso/vgetcpu.o
arch/x86/entry/vdso/vgetcpu.c:13:1: error: no previous prototype for =E2=80=
=98__vdso_getcpu=E2=80=99 [-Werror=3Dmissing-prototypes]
   13 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *u=
nused)
      | ^~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [scripts/Makefile.build:252: arch/x86/entry/vdso/vgetcpu.o] Er=
ror 1

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--QNPWODC6DIaWre3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZBgqegAKCRD2uYlJVVFO
o1O4AQD/sdgjoyQiQoYSeWQ/HhLCqe+xshozIl4z+XTVmqQ9xAD/aW6WOwwzl72D
FoFg8+RHF1VsIM0owCG5z+SE0DBS3wI=
=4Mga
-----END PGP SIGNATURE-----

--QNPWODC6DIaWre3l--
