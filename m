Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B04714628
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjE2IME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjE2IMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:12:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1681890;
        Mon, 29 May 2023 01:11:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53202149ae2so1805177a12.3;
        Mon, 29 May 2023 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685347918; x=1687939918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITRflIOmLkq0lkA6U0VtIoupb3ZXWfiBF04AqIIoi9o=;
        b=EiieOEYW0qWqoR2XSztxvUhDXIvJwpk4VldiYlBD8rZ/atZqlf1ixEo+4Pq1ifvKsu
         7OZTF3u8iFOZz9hW7pM3iBAr+SzAR2bLaEgUW0hGuaVeXFTyJgE8KSIkSF/3JB++/02g
         XhphLaz0RqaiNbrxI6XoDsXUBagig+dCEUt3DCwwR5laM0cp22bGuaRlFAS0vmb8sGHS
         Qu9/a4yK1/E6WijthNXi7bVUD7oN984AmuLhmmvrJkAMvaIBigDuuDGf4sjK+ik2pORh
         0zs8q8twwlrEcp8/G3/Q5KhXCkXaoAKLESTKl4vEVaDZZNsY6tD5EaLoJuoPHsjCWEOn
         QjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347918; x=1687939918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITRflIOmLkq0lkA6U0VtIoupb3ZXWfiBF04AqIIoi9o=;
        b=hM8YUC7guNBMXJDQQM6uZMbCm8cGIPucbg7VpcU+RJVjWX7vKulw6BvD+7muD3fFsY
         La3SACHMIm/OOkXNUhUjqoVFZ11w3FikSs+tS45FzZL4l6fxn4gDR9oNdqr8LVQ4SPap
         aCf6V5VTNxKN1eeacoZaP6ClR/6bcs1yJd7xOO2JVd+ISG3N5RL5fyf9yiibe9qFDdsg
         Uo+xEtcZfnBuztnmXG/XA3hbwnhTkJWGwhUe31DM8tahexvDavsXnQDN7ccfAeUxkNYD
         rKCMC+iAtO7Nh7iB9wrGTWgqSE+MxcpvYxZwP3TOPS7Tw2yVxlDW3mwImQKaA+7UzbOd
         C2gw==
X-Gm-Message-State: AC+VfDx1ljNWxH+Xxn0hnTqIbPOYZ2RDzqRl3PZHWOLVT4Xt6UpuBmwR
        u50i82yMFW+pKWmsLsFnyzw=
X-Google-Smtp-Source: ACHHUZ7QZU0efRghNTC1uA2xMtvWd8GuQtAjRwoNf4tH35DbcLShCgaZ3fR5ZrBl4aw4/bJ1Hg8LkA==
X-Received: by 2002:a17:90a:fd09:b0:24d:ebf8:b228 with SMTP id cv9-20020a17090afd0900b0024debf8b228mr9564707pjb.19.1685347918446;
        Mon, 29 May 2023 01:11:58 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-78.three.co.id. [180.214.232.78])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090abe0200b002565a84c848sm2655118pjs.43.2023.05.29.01.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:11:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 691BC106A11; Mon, 29 May 2023 15:11:55 +0700 (WIB)
Date:   Mon, 29 May 2023 15:11:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Add support to configure Coresight Dummy subunit
Message-ID: <ZHReS1qkktqziCxM@debian.me>
References: <20230526100753.34581-1-quic_hazha@quicinc.com>
 <5c56a874-dc41-c68c-6f70-efcbc67c29b2@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6QXsBYr0FX1el6tf"
Content-Disposition: inline
In-Reply-To: <5c56a874-dc41-c68c-6f70-efcbc67c29b2@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6QXsBYr0FX1el6tf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 03:17:32PM +0800, Hao Zhang wrote:
> Hi,
>=20
> Add the missing information for this patch series.
>=20
> Thanks,
> Hao
>=20
> On 5/26/2023 6:07 PM, Hao Zhang wrote:
>=20
> Introduction of Coresight Dummy subunit
> The Coresight Dummy subunit is for Coresight Dummy component, there are
> some specific Coresight devices that HLOS don't have permission to access.
> Such as some TPDMs, they would be configured in NON-HLOS side, but it's
> necessary to build Coresight path for it to debug. So there need driver to
> register dummy devices as Coresight devices.
>=20
> Commit link:
> https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/coresight-du=
mmy-v5

OK, please reroll.

--=20
An old man doll... just what I always wanted! - Clara

--6QXsBYr0FX1el6tf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHReSwAKCRD2uYlJVVFO
o8nGAQCXX1l4ccCpzdDZVWr0b1HG+nQadNo2EQnbSJPsqEGQDwEApvpm9ytnx3IE
z1SjTimJHr/KkJAqU93pxteEYEpV9wQ=
=d+Dp
-----END PGP SIGNATURE-----

--6QXsBYr0FX1el6tf--
