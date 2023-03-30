Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC4F6D0796
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC3OFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjC3OFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:05:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51040BB96;
        Thu, 30 Mar 2023 07:05:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l184so2274254pgd.11;
        Thu, 30 Mar 2023 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680185111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk++6WuADzXEj545YZLcIu/E+vyot2si5kQysdm6DzM=;
        b=acBtc4ub7TGg6YAxrw7dd4a1GFdLRWVmii9tMK6G0MJ1wC7mjVqBVBTkj7gKtn2tIX
         O6J+y0X3wloOVSmaEPtP3rKzn0X93JaVcCnCKCWP9EZN+xjN5STWvhzJhMv52lF8Av+b
         6937RyhWhB9el68xdKJAxNbEljxa7arNO5kvFjVY4jMJDG6qaeDBQ64YKX5pyu/qkInO
         f68BgYEACYFNFP33wuXEqEDoHlG/iZc9eb0boMQC/MpvGCdDwW6xlfmK2edGND8Q8Plz
         QO8GIIWcNvl7UbuPVRKaddUV5eTDHNDGr17d/7R1KckwJp1LPhLfj00SBH79agbLfner
         DA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680185111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk++6WuADzXEj545YZLcIu/E+vyot2si5kQysdm6DzM=;
        b=CL5IUlXZADWI2LQPhJxQ9sqj3HIXvp4WhWOcBWPRelth9BtyIMHPn7nJPm5uNq3FoN
         pCWg58fsougUmEjRgW/C6hmOm2TH+Z9twxWJeOl3iWNLGT90BGM9AM8Kugk415EanvDU
         SRuEtH1ljgygKeg6IWZVR3ZfUjw91Tcpngne4YLXf9qkiThf6Y+XfDSp4KDs/R3wanPy
         OgxUvDbDgCJFNeSvItTpKRp9d53UG2nsUtHY+mCxgAcnw13hbGDuymKl7eudgbxIIVZ+
         vxk+NL7s0GL76oFIRQ/TtOlSx5Ntiu+tqHqffbAGgduevA8WRg3weJ3IPAKVgiM+xI9O
         2ySA==
X-Gm-Message-State: AAQBX9f7R1gl3dcbRi8gT/n7GvYpclMYIG/Ay2ZiDTX4haZCaV1njhgK
        UmJ2udPz/q9BHMX/JYyVxiXLQ2Ly8tX7/A==
X-Google-Smtp-Source: AKy350bcIE063saaE8MzRt7jv32kch0rUCUkmXzCgA9saTyXkRNmcIoCcEeszAstTNrQkHj5e0hAoQ==
X-Received: by 2002:a62:5e05:0:b0:626:a9b:94b8 with SMTP id s5-20020a625e05000000b006260a9b94b8mr23281404pfb.20.1680185110719;
        Thu, 30 Mar 2023 07:05:10 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78e51000000b00627fea66a4asm20175057pfr.39.2023.03.30.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:05:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 728ED10672E; Thu, 30 Mar 2023 21:05:06 +0700 (WIB)
Date:   Thu, 30 Mar 2023 21:05:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Feng Tang <feng.tang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
Subject: Re: [PATCH v2] Documentation: Add document for false sharing
Message-ID: <ZCWXET8MPoyUc/Md@debian.me>
References: <20230329073322.323177-1-feng.tang@intel.com>
 <ZCUPxMQPJ8ETvUbM@debian.me>
 <CALvZod48Fwua_VJvnzHatF-J4YRWqfMFnYjYN6W0_ioLtPZEfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VZOl/c00MbQzw8H5"
Content-Disposition: inline
In-Reply-To: <CALvZod48Fwua_VJvnzHatF-J4YRWqfMFnYjYN6W0_ioLtPZEfA@mail.gmail.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VZOl/c00MbQzw8H5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 09:51:56PM -0700, Shakeel Butt wrote:
> > > +* Turn hot global data to 'per-cpu data + global data' when possible,
> > > +  or reasonably increase the threshold for syncing per-cpu data to
> > > +  global data, to reduce or postpone the 'write' to that global data.
> > > +
> > > +  - Commit 520f897a3554 ("ext4: use percpu_counters for extent_statu=
s cache hits/misses")
> > > +  - Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according=
 to vm overcommit policy")
> > > +
> >
> > Here's what I mean by bridging conjunctions to example commits as I rev=
iewed
> > in v1 [1]:
> >
>=20
> This is too much and unneeded nitpicking. The patch looks good as is.

As ESL people, I feel there is a gap when a description paragraph is
followed immediately by some sort of lists without bridging (conjunction
between them). I expect a smooth transition in this case. Even though
before the list it is written "(with examples)", I think the conjunction
is needed anyway.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--VZOl/c00MbQzw8H5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCWXDgAKCRD2uYlJVVFO
o9YPAQCFZN6kjI3Mdb9a70VW/VfydKaJJrE3NzGtp5OKIPNmoQD1F2wNzJ8QDEFZ
fq6YjgBUMnNm9WIwZQVuHeB+hZBbAQ==
=Qtoy
-----END PGP SIGNATURE-----

--VZOl/c00MbQzw8H5--
