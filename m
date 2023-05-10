Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281376FD510
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjEJE34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJE3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:29:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761BF2D54;
        Tue,  9 May 2023 21:29:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaf21bb427so48597025ad.1;
        Tue, 09 May 2023 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683692992; x=1686284992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aM5NY/KUHqYL9w0DdOz9GTnXa2GoHiTuTmams40J5o=;
        b=mIUX+1c8zSq1vIBaZknShJh4FlsjYTJ8mB8GwjIyTezZGY3MDERW6xFJCHcGtv737r
         CCsvlVd1moMaNpwtMj1LK+go8Edf5erddvNynXI4FZl93uWPCEIcjGhI1q3GkQDA0B63
         4VXGplEN2mABJaeCAx+LrZGU4fjrBeIzl8RV4wFPr3CPdMamJl0oeTA47/wDLVfdOvWZ
         FsCAo8ZNR6XfsHuEcWDNy6KKayZLGs8c79uNY9R0/cj/EO+02I4mxKn+mDYOV7/agcRj
         deGJWGawp3PGVgQYfGdsq50EQAU1IGHNmYdQrbc3EeAfmU3Hwbxm0c5lxDSpfsvaftLF
         58mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683692992; x=1686284992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aM5NY/KUHqYL9w0DdOz9GTnXa2GoHiTuTmams40J5o=;
        b=GNJPEJsdr82BiP4iqn873eJi2ZgKbnO7kj+PQbWjvWozBrtP6god6aDOJSrJ0Baxp5
         fWz1D45Ai0iEqXsA81bOmA9zxf24E9K28A89rDsHVMOvWS0a+bAZ2NboQOyogsFrWwDf
         Due4cjhNDDFVNrqYbeh+E5FYr2M/1/AyoPXfHlU6EEhJJN9HW9EShzFdbbJmZYd1slw6
         a4xpuQaGM4NYhSd1Kr1Q/GPhg6xzK4wt2CnGcj7llmt9mrvAp/kibulm4tn1I2GHfTRo
         IG5Z2l0jqhm1aJtV/aCgSGzvHOVKbwnTNtUsgG32icczVwpkKCpQhfbF3zQefxdhBDVu
         yKpg==
X-Gm-Message-State: AC+VfDyVfllJaiTTqO8KzQwB2f7igr33cxteMk3lcUPLhVE+m0jE7cED
        503TzmETFINgpwScluzp1SY=
X-Google-Smtp-Source: ACHHUZ5JpzVIN/DIs7qJBXKKpwABHf20uqh5yBLrXKfwPc64fJKRXs3HZO4pKmEoTFgaLV2jXH/5Qw==
X-Received: by 2002:a17:902:ecc6:b0:1ac:6153:50b1 with SMTP id a6-20020a170902ecc600b001ac615350b1mr14634154plh.39.1683692991790;
        Tue, 09 May 2023 21:29:51 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-2.three.co.id. [116.206.28.2])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001ab13f1fa82sm2545706pll.85.2023.05.09.21.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:29:51 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4C54E106AA3; Wed, 10 May 2023 11:29:48 +0700 (WIB)
Date:   Wed, 10 May 2023 11:29:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
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
Subject: Re: [PATCH v3 3/3] Documentation: trace: Add documentation for
 Coresight Dummy Trace
Message-ID: <ZFsdvCuTTEkTm9VA@debian.me>
References: <20230422073714.38844-1-quic_hazha@quicinc.com>
 <20230422073714.38844-4-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e2+brUqtxyUTcWFS"
Content-Disposition: inline
In-Reply-To: <20230422073714.38844-4-quic_hazha@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e2+brUqtxyUTcWFS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 22, 2023 at 03:37:14PM +0800, Hao Zhang wrote:
> +Introduction
> +---------------------------
> +
> +Coresight Dummy Trace Module is for the specific devices that kernel
> +don't have permission to access or configure, e.g., CoreSight TPDMs
> +on Qualcomm platforms. So there need driver to register dummy devices
> +as Coresight devices. It may also be used to define components that
> +may not have any programming interfaces (e.g, static links), so that
> +paths can be established in the driver. Provide Coresight API for
> +dummy device operations, such as enabling and disabling dummy devices.
> +Build the Coresight path for dummy sink or dummy source for debugging.
> +
> +Config details
> +---------------------------
> +
> +There are two types of nodes, dummy sink and dummy source. The nodes
> +should be observed at the below coresight path::
> +
> +    ``/sys/bus/coresight/devices``.
> +
> +e.g.::
> +
> +    / $ ls -l /sys/bus/coresight/devices | grep dummy
> +    dummy0 -> ../../../devices/platform/soc@0/soc@0:dummy_source/dummy0
> +    dummy1 -> ../../../devices/platform/soc@0/soc@0:dummy_sink/dummy1

The wording confuses me, so I have to make the improv:

---- >8 ----
diff --git a/Documentation/trace/coresight/coresight-dummy.rst b/Documentat=
ion/trace/coresight/coresight-dummy.rst
index 7cb59f080c8892..f0a92669288b0c 100644
--- a/Documentation/trace/coresight/coresight-dummy.rst
+++ b/Documentation/trace/coresight/coresight-dummy.rst
@@ -8,27 +8,25 @@ Coresight Dummy Trace Module
     :Date:     May 2023
=20
 Introduction
----------------------------
+------------
=20
-Coresight Dummy Trace Module is for the specific devices that kernel
-don't have permission to access or configure, e.g., CoreSight TPDMs
-on Qualcomm platforms. So there need driver to register dummy devices
-as Coresight devices. It may also be used to define components that
-may not have any programming interfaces (e.g, static links), so that
-paths can be established in the driver. Provide Coresight API for
-dummy device operations, such as enabling and disabling dummy devices.
-Build the Coresight path for dummy sink or dummy source for debugging.
+The Coresight dummy trace module is for the specific devices that kernel d=
on't
+have permission to access or configure, e.g., CoreSight TPDMs on Qualcomm
+platforms. For these devices, a dummy driver is needed to register them as
+Coresight devices. The module may also be used to define components that m=
ay
+not have any programming interfaces (e.g, static links), so that paths can=
 be
+created in the driver. It provides Coresight API for operations on dummy
+devices, such as enabling and disabling them. It also provides the Coresig=
ht
+dummy sink/source paths for debugging.
=20
 Config details
----------------------------
+--------------
=20
-There are two types of nodes, dummy sink and dummy source. The nodes
-should be observed at the below coresight path::
+There are two types of nodes, dummy sink and dummy source. These nodes
+are available at ``/sys/bus/coresight/devices``.
=20
-    ``/sys/bus/coresight/devices``.
+Example output::
=20
-e.g.::
-
-    / $ ls -l /sys/bus/coresight/devices | grep dummy
+    $ ls -l /sys/bus/coresight/devices | grep dummy
     dummy_sink0 -> ../../../devices/platform/soc@0/soc@0:sink/dummy_sink0
     dummy_source0 -> ../../../devices/platform/soc@0/soc@0:source/dummy_so=
urce0

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--e2+brUqtxyUTcWFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFsduAAKCRD2uYlJVVFO
o2TjAQDYYZqIoZ6+z7SOd233T+YD4aMEAQt5d3y8eqQjHBnsGgD9ELC02YzoibPW
QS5ra91ddWiO98Yu1l05a8zSZPt0DQI=
=vhHp
-----END PGP SIGNATURE-----

--e2+brUqtxyUTcWFS--
