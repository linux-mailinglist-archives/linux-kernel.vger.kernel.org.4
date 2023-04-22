Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C06EBA2D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjDVQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:08:17 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E234D1BE3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 09:08:15 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fb89e1666so16108017b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682179695; x=1684771695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZp9jk1hw8skfJNap0PJPqr2YiWhtiNJB6fV4jiyYzk=;
        b=KuVRypuaA2aAMAyb8wf/5utdkQhWQ9gjCIvYLt7MnodRD8KY0Y1htD2khKSPDWGw4O
         WxrFMnJ/PPWxUzsft/L3DlbS55RoZpWHksDOU6LFjrVB7oWWWiRj1xQNIfK8hCIUFkFX
         9yUlKoq0o3G8prMAR38ry2FxCLQYllJPxb60ew6n71ULQARLfIG0+gdzPR1FU7+rErIm
         M9/Fp6m2QFlNx/Xwtknmoh6VFOBOQV40O0/1TcCBLok83N4bVguvUTN2s4gW+JwELvDv
         LMVSoZwQZ9wU8PVSYpz95fS9FEz6ClScKB6oD3RoWwxPyfq3tldF9tlNQcTG1JNk+R00
         hd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682179695; x=1684771695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZp9jk1hw8skfJNap0PJPqr2YiWhtiNJB6fV4jiyYzk=;
        b=K1fIlsIsDqrHomy/7F47ujlAa/36obKls0NNZ/U7mBK//n4Zm+Mc08SWY/tHfcdZUO
         5WKKsL1w80jnWqSnZTsVPbA4qYV+iCRUSVcCJSeEdYIuePlJ6kMkOwEGuYS41dejBb2f
         TRlhPxNowlBT4RYuH26MNLvYG72p2Nkjg77ufXyCYv333sMqsZEaLtiD1dZE0cRhwy3I
         aPvf/VN06imn7jGz9qXDSF+0Dasr0CHhw3+NzTGExmGxb81ENrN4ko53lK6u2igFaSep
         0ht6CX7Hr4ko2LEG+zvGOTRkc2Kv6F9A6aUCRyy7eK2eV0zVuJJzXQYZl5rCGraNrqTC
         RNwA==
X-Gm-Message-State: AAQBX9doul/NsYiOQoNIk9JMOlLU65QUKZcAQGyO7L1+TO8VqjE7yMjT
        oHaD0omkIikpXgiKaYpnClkAmw==
X-Google-Smtp-Source: AKy350ZJg8RdMgvTWTZBD5fohaNCFYBrhOEZI6+GxHVWbpI0PbBLb5zWyQySimCLWCa6f+jXbHDAKg==
X-Received: by 2002:a0d:d6cd:0:b0:54e:ddbb:64df with SMTP id y196-20020a0dd6cd000000b0054eddbb64dfmr5004323ywd.30.1682179695091;
        Sat, 22 Apr 2023 09:08:15 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i205-20020a0ddfd6000000b00545a08184a9sm1719364ywe.57.2023.04.22.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 09:08:14 -0700 (PDT)
Date:   Sat, 22 Apr 2023 12:08:12 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>,
        "open list:COUNTER SUBSYSTEM" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/counter: Makefile: Remove lingering 'include'
 when make clean
Message-ID: <ZEQGbGor+5i4Gzk/@fedora>
References: <tencent_F85E314661100B0CE2845EB27E2E2F558C09@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HyUY9zxsR7N84CpR"
Content-Disposition: inline
In-Reply-To: <tencent_F85E314661100B0CE2845EB27E2E2F558C09@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HyUY9zxsR7N84CpR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 22, 2023 at 10:27:38PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>=20
> 'make' create 'include' directory, we should remove it when 'make clean'.
>=20
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Hi Rong,

The code changes in this v2 are acceptable for me now, but I would like
the commit description typos fixed. I can fix it myself when I apply
this patch so that you don't need to submit a v3. Would you be okay if I
did that?

William Breathitt Gray

--HyUY9zxsR7N84CpR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZEQGbAAKCRC1SFbKvhIj
K8phAQCwMU19MWjiyoqRLhQL6C55SGaXp3RRChIOi5zNRfQW6wEAz4HNh1hyEFF2
WDRmyFwG+Z+RzNyf15s/ENcczFMMxQM=
=RAAv
-----END PGP SIGNATURE-----

--HyUY9zxsR7N84CpR--
