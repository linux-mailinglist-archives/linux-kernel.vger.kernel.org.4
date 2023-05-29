Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1543714578
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjE2H2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE2H2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:28:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D88E3;
        Mon, 29 May 2023 00:28:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-256481ce1b5so1117663a91.1;
        Mon, 29 May 2023 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685345301; x=1687937301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygQ9/7FF2gwyrasLb/Tn66vCuscCVpQE5Y1FOjPAlvA=;
        b=PaT5Em2sZUZbdhKuuTEBaHrOug2J4KLOC0eMu5votMfZhGJRPy0BYjAALMZ2Hk4I0X
         nE6C7ICZ6qhr/Ap2FSeBxAmkBCzPSRO2AuT02E42yz8UwWe/wmLmpLUN6VizgVSzq9qV
         izStqqsyFsXkLFz6khRPLSOrPHYlaoXwV2YI5jlUgboGx4klmKxllqwjg4djsWncvUq/
         fzRQh+ZmvEr/blPham23epj3XRij9sMc9B1KnZ4DaZtYjXj7A01rfwykK/vC1igBozd0
         vKTJtaiOEClTuO/5n+mPXxmeS9Ym74F/x44TeKyybgJ65YmFu4eC91emPxf2Qpz5oxIy
         qKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685345301; x=1687937301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygQ9/7FF2gwyrasLb/Tn66vCuscCVpQE5Y1FOjPAlvA=;
        b=Fry8dXsdctxQgOe8Gv4luJQy2cy1PAz3b+2AjAoKXMNBirBol9RS83b5fWhWWYl6YF
         /HFlloEuS93aa0QvRMYpICAdCHHPbP77TTsGSvkfVhBYnEtEViKCe+Sj+cW9REL+p2DW
         cA/wBFWNCTffwMX6ZyIKiB9m4max7u29bzyamR5WolbByJnL4/cm0PPuD+Y+YCmIFfMn
         06aiMJx2qMcWn+7GItbR1F0+6BW3VejD3iweE0TzwOTf+biYSGqPe1x4WBfYMjzjBr6O
         QXyJAUFPUmlf5/styTboJTzNAIzprMOhptgaLw5MGTN4DJ+hLCv0moHLNpGMTT6/aEY4
         a56g==
X-Gm-Message-State: AC+VfDwlOnpS5Bc8FHm2PKsoMlDA81hhm9TyZlf41JzgkpfD18iYeKDx
        T9Hd57eYbwq4uev3mSd27FY=
X-Google-Smtp-Source: ACHHUZ7KTCdr1KdnRENQwXuixuIk9hb09wA9xzWbbZBbsOzhUWrYIaujlVa1hrTdLvD1uPqtDL7XkQ==
X-Received: by 2002:a17:902:dac2:b0:1b0:4687:ba0c with SMTP id q2-20020a170902dac200b001b04687ba0cmr2131341plx.8.1685345300763;
        Mon, 29 May 2023 00:28:20 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-25.three.co.id. [180.214.232.25])
        by smtp.gmail.com with ESMTPSA id ik24-20020a170902ab1800b001b0142908f7sm5512582plb.291.2023.05.29.00.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:28:20 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CB080106A11; Mon, 29 May 2023 14:28:16 +0700 (WIB)
Date:   Mon, 29 May 2023 14:28:16 +0700
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
Subject: Re: [PATCH v5 3/3] Documentation: trace: Add documentation for
 Coresight Dummy Trace
Message-ID: <ZHRUELoOoqw6rkbQ@debian.me>
References: <20230526100753.34581-1-quic_hazha@quicinc.com>
 <20230526100753.34581-4-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nzlE/XuSNu6KUNn7"
Content-Disposition: inline
In-Reply-To: <20230526100753.34581-4-quic_hazha@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nzlE/XuSNu6KUNn7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 06:07:53PM +0800, Hao Zhang wrote:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +Coresight Dummy Trace Module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +    :Author:   Hao Zhang <quic_hazha@quicinc.com>
> +    :Date:     May 2023
> +
> +Introduction
> +------------
> +
> +The Coresight dummy trace module is for the specific devices that kernel=
 don't
> +have permission to access or configure, e.g., CoreSight TPDMs on Qualcomm
> +platforms. For these devices, a dummy driver is needed to register them =
as
> +Coresight devices. The module may also be used to define components that=
 may
> +not have any programming interfaces (e.g, static links), so that paths c=
an be
> +created in the driver. It provides Coresight API for operations on dummy
> +devices, such as enabling and disabling them. It also provides the Cores=
ight
> +dummy sink/source paths for debugging.
> +
> +Config details
> +--------------
> +
> +There are two types of nodes, dummy sink and dummy source. These nodes
> +are available at ``/sys/bus/coresight/devices``.
> +
> +Example output::
> +
> +    $ ls -l /sys/bus/coresight/devices | grep dummy
> +    dummy_sink0 -> ../../../devices/platform/soc@0/soc@0:sink/dummy_sink0
> +    dummy_source0 -> ../../../devices/platform/soc@0/soc@0:source/dummy_=
source0

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--nzlE/XuSNu6KUNn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHRUDAAKCRD2uYlJVVFO
o5vLAQDo0n/f2fiGCqPXpyaiJvaaIUAHdmAnPJ+2AADYyHDB2wEAqaI6EkHEQUzk
2cmQ1IYwhe/9minYIy2mrKSyny8A7Q8=
=a0pw
-----END PGP SIGNATURE-----

--nzlE/XuSNu6KUNn7--
