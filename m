Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE4721C89
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 05:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjFED1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 23:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjFED1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:27:03 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F7B1;
        Sun,  4 Jun 2023 20:27:00 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b0d38ce700so3340536a34.2;
        Sun, 04 Jun 2023 20:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685935619; x=1688527619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dwal0L6sGBe4Tija8w5m6MusCvofbkwy4bszwLInaTI=;
        b=Ay7nte0rxPqj9fVhJgbG/FHztxxZIqkOp5rra/Xzf5a4e+rzgaZeC1H6XoyG5cMJhY
         uSD9j0Zo+Aqgo2EV//XbEAAD65l9aF8ROz6MXpVpLPSpoJQe9nj0ZmltyJrzTG2K9XO7
         Er/Dhv2lvSCCQhm8X9KosKAVSfYwu4MJeV2sv1JzpqTrRAri7mV9QJiJFeJSeQ3KE5hq
         /pO+acfGUR3MerUgYQwFhS5GdEFhVGNimbr9AEzEGt4lAcUBw6B3+yb0Id0pH/uea4Jz
         EZURzWFxE8XroknUyx9pqZOLIvApTVvVNMxvgc1GXg0T5HdVtVWhAyQMKEcZvqPwtSr4
         ORxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685935619; x=1688527619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwal0L6sGBe4Tija8w5m6MusCvofbkwy4bszwLInaTI=;
        b=JoRWPG/EkzE4kUuwdJgSDx+KiEGtWSlrXW2+FyZABvL5Y49/ewETweD+eblFzvkzmR
         nbieJLW8nIa2JFHU7QrzLo8X23aCkkxLA+0qnoeuJNWdWAjs4kjBCF5pGDI1cx9LP/sb
         Wx54F0ENqOGtxm1j0AdC16Uz7t2FgsvnJVg6MlMO8dk3hWeBYAcQYz1D+38KZTMamQAg
         u+8VVMSaO5IJwNWeBWyh0TPewNLcY4fEXzeQowplukusZwm7fXP3lq0DNHcNrvw/RLzN
         7x9oIeWQdX7/e//8Yqr4UauW7D5VHkt0o5aFhnbXgHHIPrKSeiA1HY1zWs4/p4VmZ6/R
         xOXw==
X-Gm-Message-State: AC+VfDy6rnbLTFty51lxMKpx+rach7omoHfo71ETzxRiw1yxmYspO8f2
        7dmiG1iaHEJI7NnZzVWBZEA=
X-Google-Smtp-Source: ACHHUZ4W+cRsdWRORSzDYMPoa42K0S+ECjUK9kAXMfdNknMckwnftY5YdZavnMxICgOANNXm00QN2Q==
X-Received: by 2002:a9d:7692:0:b0:6ab:bec:592f with SMTP id j18-20020a9d7692000000b006ab0bec592fmr8870075otl.17.1685935619041;
        Sun, 04 Jun 2023 20:26:59 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-4.three.co.id. [180.214.233.4])
        by smtp.gmail.com with ESMTPSA id s17-20020aa78291000000b006413e6e7578sm4230048pfm.5.2023.06.04.20.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 20:26:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CDB3A106291; Mon,  5 Jun 2023 10:26:55 +0700 (WIB)
Date:   Mon, 5 Jun 2023 10:26:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Message-ID: <ZH1V_-WXejzDsKXh@debian.me>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IrxVMi6lhpyOnVcO"
Content-Disposition: inline
In-Reply-To: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrxVMi6lhpyOnVcO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 04, 2023 at 01:38:10PM +0200, Krzysztof Kozlowski wrote:
> Hi,
>=20
> #regzbot introduced: 9551fbb64d09
>=20
> Bisect pointed to commit 9551fbb64d09 ("perf/core: Remove pmu linear
> searching code") as first one where all hardware events are gone from
> perf for ARMv7 Exynos5422 board.

Fixing up regzbot entry title:

#regzbot title: All Exynos5422 hardware events are gone from perf due to re=
moving pmu linear searching code

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--IrxVMi6lhpyOnVcO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZH1V/wAKCRD2uYlJVVFO
o/RiAP9rzLBOEEPKnBvjwy3gCOa2Atg4tW8EaJSjiILhC9vE7wD8CWr+6XulOmFf
vEyQi5u81HGW/Wdd3xItqgKg0kT8dAg=
=gvFv
-----END PGP SIGNATURE-----

--IrxVMi6lhpyOnVcO--
