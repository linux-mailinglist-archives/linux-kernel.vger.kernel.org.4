Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFD63B8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiK2DQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiK2DQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:16:42 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D064E4733F;
        Mon, 28 Nov 2022 19:16:41 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w79so12446544pfc.2;
        Mon, 28 Nov 2022 19:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KoHEWJlnQdU5BQ/HIJRZryexzBCV0fcZJO2wF6lQsxg=;
        b=NJn71kyW76bMkZzipTJaMz3jMXxat2uhF0GN1+WkIGFKsy4bI+Qvof8iaz0BI9k2r8
         xuJMgHDX7xmMoikw1De7uXNCyqoPXTClnypKiAm0LrHSiP5ixULfvgSjZIDskcwjQAcP
         pB8JYzq7rWHJ9R/RxFPAdKurAeMP8sghuImUzTCjZ2ooOgnIzxbeXqQNDteDaua2UjWS
         hzztfmR5NBJkC5y4v0MWLECY/ur7Vc40BZxN/aMWuOXIWEazK6hlCz5Np8SRlP+txGyT
         YW1IqRXXY995I6j83XENhPSDKVS+7j4z+BSGyxo+YVUFQ27QWbifJ/9YZ4JTba8J6f+0
         IrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoHEWJlnQdU5BQ/HIJRZryexzBCV0fcZJO2wF6lQsxg=;
        b=W7MQKSawXBzJY5d7e9omURa5uyVkxYQ0Wah0/Ybd7UFzNmIg2gkr1VW0TpTrpEx6P7
         t8w1jq74nlV7xq7GhEwDKlo6sxejxfk90HhPB+Le8dpr9dXh9SrPgAKdJEnZ0hx2g8x6
         FzT74xYWqHHEnnKvdxNCQdopcgRNGoxasgxO1AvuZPHE9qOfECTB75qrwFl08ritJfMp
         gNCZue/zDNNBC1YK3/CStdHnjHrmdiIRDpPBE5daaVZlzuIxkVr4N/GOQerg0yKxoYPb
         cbjl2mknGmQewohzlDTFB6cJF2NA/HmMaVTuxxat9MWYyRljiX/kapsVA26WLgIfNba3
         GJGQ==
X-Gm-Message-State: ANoB5pmPI9JBANcgt7IsYJfzU9BRApZ336jsUCfMr4D3xFPD9iEmXAgF
        9NQg7RdRpZhmIDuJU7AI/Sc=
X-Google-Smtp-Source: AA0mqf4XiGNH/JGWpt4MTBVyFoDPyrL7Q5qTC5rK2Ab8bHc3D6OaCEOTCzp7NPRAQ8vz1UmSoeggvw==
X-Received: by 2002:aa7:9257:0:b0:56c:cea7:8650 with SMTP id 23-20020aa79257000000b0056ccea78650mr35575788pfp.40.1669691801303;
        Mon, 28 Nov 2022 19:16:41 -0800 (PST)
Received: from debian.me (subs28-116-206-12-33.three.co.id. [116.206.12.33])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79494000000b0056f0753390csm8921576pfk.96.2022.11.28.19.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 19:16:40 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3497B103E11; Tue, 29 Nov 2022 10:16:36 +0700 (WIB)
Date:   Tue, 29 Nov 2022 10:16:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>
Subject: Re: [PATCH v2] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <Y4V5lDHNqYHEzEaI@debian.me>
References: <20221127142657.1649347-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rQeuJg5WuXGQGv4c"
Content-Disposition: inline
In-Reply-To: <20221127142657.1649347-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rQeuJg5WuXGQGv4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 27, 2022 at 02:26:57PM +0000, Qais Yousef wrote:
> The new util clamp feature needs a document explaining what it is and
> how to use it. The new document hopefully covers everything one needs to
> know about uclamp.
>=20

For patch subject, better say "Documentation: sched: Document util clamp
feature".

> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>=20
> Changes in v2:
>=20
> 	* Address various style comments from Bagas
>=20

I don't see any of my wording suggestions from [1] being applied. Still
a rather confused to read (maybe should be applied on top of jon's
suggestions)?

[1]: https://lore.kernel.org/lkml/Y3II59dyKuvQGIhG@debian.me/
[2]: https://lore.kernel.org/linux-doc/87cz976pwn.fsf@meer.lwn.net/

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--rQeuJg5WuXGQGv4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4V5iQAKCRD2uYlJVVFO
o7hbAQC6ZmQaA71Mw+ML1SKY49EnY9RRYz6VAlcRH6LAVHOcCgEAm40jffgXGBdf
HhLugCwjCmjy1zE2UkxlEe8H3OK3UQM=
=8Ew3
-----END PGP SIGNATURE-----

--rQeuJg5WuXGQGv4c--
