Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49365F19C0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 06:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJAELk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 00:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJAELg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 00:11:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9887515A70B;
        Fri, 30 Sep 2022 21:11:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d24so5511610pls.4;
        Fri, 30 Sep 2022 21:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OSv7SDIGCVEG314+BzEZq4WXeWqQBm4mHIqqx0BP8u0=;
        b=mwHdTkcA1tHAUfCcwsrvYGERtpdrG4RMnvKmYCTjX15LrwOYgVEtmVMbfqrVfhHakj
         7g4ftx6CetZsFng+iOI1q36bEhi9Cp6b2zzqkzRWHV0xA/3d4eEvRddPSJcnKPwVanr2
         z7Om/zQ0sB4VC0OZPjqGhbysth6zx37my4dFgOuPoi0Iwq4CiW+z5OWZR8BNvEY2q7nC
         cCubav/qpG+PQN5ZHd+r4w4QLSZwxmiP21gxbAz70sgvgjeoeRgqhr+cTjmmTgN4qIzm
         5sjs9soqW4ai993zQIP0ylhAJ4NcBgB/S6pJ6pYDA8iWLrmemXGwQGRLPgj4lTRHCcM9
         VwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OSv7SDIGCVEG314+BzEZq4WXeWqQBm4mHIqqx0BP8u0=;
        b=bV482kxuqVlorcN5NO95aV7vW2pgFRwyHF7AkzZ4xyJieF/KNp/GxcMJUsqZVV+hri
         2xUB2++8Vxf8HzBP390ZWKa3/SqSjNsnxId44PuAO7YoIs42FnGPvzjoMds0YsuJV6SK
         R9iZfjjPDH7n9yTRBTr1/v4/tUk98rFsar+bHT/PBKKNEhM/6yfYpouaeBa2Hh2Xd/mX
         e923alNApqsa0Nle4NEwbOvIM3nZ6dGrMSdtB187HgrUHl9XOYlxKk/qiK7LdexxxiP5
         qgAg6yyIRZMKEc8nIVgD4Pw6HwTZotmxooyyZeYA517ZHMKpM90ZxIaSlAWlzNuKh11q
         TTQg==
X-Gm-Message-State: ACrzQf3rNKfZhCjLznzPIEF2gFK7czid6iaZHXkg9nARQQactGelrZbK
        ZouLNudpozIMJuh7ab3HwCM=
X-Google-Smtp-Source: AMsMyM7bN9tAhIY4k9a7/S9pez9PmFy400BkzIrhaakxm4+6Obe+6Nd6DZjTA5R0T/f/fCPIEXJ/tQ==
X-Received: by 2002:a17:902:a707:b0:178:bd1e:e8be with SMTP id w7-20020a170902a70700b00178bd1ee8bemr11997820plq.167.1664597493786;
        Fri, 30 Sep 2022 21:11:33 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-5.three.co.id. [180.214.232.5])
        by smtp.gmail.com with ESMTPSA id z186-20020a6265c3000000b0055fc0a132aasm175757pfb.92.2022.09.30.21.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 21:11:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 831731005BB; Sat,  1 Oct 2022 11:11:29 +0700 (WIB)
Date:   Sat, 1 Oct 2022 11:11:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     macro@orcam.me.uk, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Subject: Re: [PATCH v9 6/9] docs: misc-devices: (smpro-misc) Add documentation
Message-ID: <Yze98CgmGuNA0uGr@debian.me>
References: <20220929094321.770125-1-quan@os.amperecomputing.com>
 <20220929094321.770125-7-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zsOt5hDHQ+A0q34n"
Content-Disposition: inline
In-Reply-To: <20220929094321.770125-7-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zsOt5hDHQ+A0q34n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2022 at 04:43:18PM +0700, Quan Nguyen wrote:
> Adds documentation for the Ampere(R)'s Altra(R) SMpro misc driver.
>=20

s/Adds/Add/

> Signed-off-by: Thu Nguyen <thu@os.amperecomputing.com>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Does this patch originally authored by Thu? If so, add From: line before
the patch description.

> diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-de=
vices/index.rst
> index b74b3b34a235..b40cd1b402f7 100644
> --- a/Documentation/misc-devices/index.rst
> +++ b/Documentation/misc-devices/index.rst
> @@ -28,6 +28,7 @@ fit into other categories.
>     oxsemi-tornado
>     pci-endpoint-test
>     smpro-errmon
> +   smpro-misc
>     spear-pcie-gadget
>     uacce
>     xilinx_sdfec
> diff --git a/Documentation/misc-devices/smpro-misc.rst b/Documentation/mi=
sc-devices/smpro-misc.rst
> new file mode 100644
> index 000000000000..d21be4a09e69
> --- /dev/null
> +++ b/Documentation/misc-devices/smpro-misc.rst
> @@ -0,0 +1,82 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver Ampere(R) Altra(R) SMpro miscellaneous
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Supported chips:
> +
> +  * Ampere(R) Altra(R)
> +
> +    Prefix: 'smpro'
> +
> +    Reference: Altra SoC BMC Interface Specification
> +
> +Author: Thu Nguyen <thu@os.amperecomputing.com>
> +
> +Description
> +-----------
> +
> +This driver support the monitoring and configuration of various miscella=
neous
> +data provided by Ampere(R) Altra(R) SMpro processor.
> +At this time, these include:
> +
> +  * Reading Boot Progress information
> +  * Configuring SoC Power Limit
> +
> +Sysfs entries
> +-------------
> +
> +1) Boot progress
> +
> +SMpro misc driver creates the sysfs files ``boot_progress``.
> +The format of ``boot_progress`` file is as below::
> +
> +<boot stage><boot status><boot progress>
> +
> +Where:
> +
> +* Boot stage::
> +
> +    0: SMpro firmware booting.
> +    1: PMpro firmware booting.
> +    2: ATF BL1 firmware booting.
> +    3: DDR initialization.
> +    4: DDR training report status.
> +    5: ATF BL2 firmware booting.
> +    6: ATF BL31 firmware booting.
> +    7: ATF BL32 firmware booting.
> +    8: UEFI firmware booting.
> +    9: OS booting.
> +
> +* Boot status::
> +
> +    0: Not started.
> +    1: Started.
> +    2: Complete without error.
> +    3: Failure.
> +
> +* boot progress: 32 bits boot progress code
> +
> +The sysfs ``boot_progress`` only reports the boot state when the host is=
 booting.
> +If the host is already booted, it returns latest state.
> +
> +Example::
> +
> +    #cat boot_progress
> +    0102808454A8
> +
> +2) SoC Power Limit
> +
> +SMpro misc driver creates the sysfs file ``soc_power_limit`` to get/set =
the SoC Power Limit.
> +
> +Reading this sysfs return the current setting of SoC Power Limit (W) in =
decimal string.
> +Writing the desired value in decimal string to set the SoC Power Limit i=
n Watt (W).
> +The range of SoC Power Limit is 90-500(W) and will be ignored if out of =
range.
> +
> +Example::
> +
> +    #cat soc_power_limit
> +    90
> +    #echo 95 > soc_power_limit
> +    #cat soc_power_limit
> +    95

The documentation above can be improved (both grammatical and
formatting):

---- >8 ----

diff --git a/Documentation/misc-devices/smpro-misc.rst b/Documentation/misc=
-devices/smpro-misc.rst
index d21be4a09e69c4..f33466152ac402 100644
--- a/Documentation/misc-devices/smpro-misc.rst
+++ b/Documentation/misc-devices/smpro-misc.rst
@@ -7,76 +7,77 @@ Supported chips:
=20
   * Ampere(R) Altra(R)
=20
-    Prefix: 'smpro'
+    Prefix: ``smpro``
=20
-    Reference: Altra SoC BMC Interface Specification
+    Reference: `Altra SoC BMC Interface Specification`
=20
 Author: Thu Nguyen <thu@os.amperecomputing.com>
=20
 Description
 -----------
=20
-This driver support the monitoring and configuration of various miscellane=
ous
-data provided by Ampere(R) Altra(R) SMpro processor.
-At this time, these include:
+The smpro-misc driver supports monitoring and configuration of various
+miscellaneous data provided by Ampere(R) Altra(R) SMpro processor.
+Currently, the driver supports:
=20
-  * Reading Boot Progress information
-  * Configuring SoC Power Limit
+  * reading boot progress information
+  * configuring SoC power limit
=20
 Sysfs entries
 -------------
=20
 1) Boot progress
=20
-SMpro misc driver creates the sysfs files ``boot_progress``.
-The format of ``boot_progress`` file is as below::
+   The driver creates ``boot_progress`` sysfs file. Its format is described
+   as::
=20
-<boot stage><boot status><boot progress>
+     <boot stage><boot status><boot progress>
=20
-Where:
+   where:
=20
-* Boot stage::
+   * ``<boot stage>`` can be:
=20
-    0: SMpro firmware booting.
-    1: PMpro firmware booting.
-    2: ATF BL1 firmware booting.
-    3: DDR initialization.
-    4: DDR training report status.
-    5: ATF BL2 firmware booting.
-    6: ATF BL31 firmware booting.
-    7: ATF BL32 firmware booting.
-    8: UEFI firmware booting.
-    9: OS booting.
+     * 0: SMpro firmware booting.
+     * 1: PMpro firmware booting.
+     * 2: ATF BL1 firmware booting.
+     * 3: DDR initialization.
+     * 4: DDR training report status.
+     * 5: ATF BL2 firmware booting.
+     * 6: ATF BL31 firmware booting.
+     * 7: ATF BL32 firmware booting.
+     * 8: UEFI firmware booting.
+     * 9: OS booting.
=20
-* Boot status::
+  * ``<boot status>`` can be:
=20
-    0: Not started.
-    1: Started.
-    2: Complete without error.
-    3: Failure.
+     * 0: Not started.
+     * 1: Started.
+     * 2: Complete without error.
+     * 3: Failure.
=20
-* boot progress: 32 bits boot progress code
+  * ``<boot progress>``: 32-bit boot progress code
=20
-The sysfs ``boot_progress`` only reports the boot state when the host is b=
ooting.
-If the host is already booted, it returns latest state.
+  The sysfs file  only reports the boot state when the host is booting. If
+  the host is already booted, it returns the latest state.
=20
-Example::
+  Example::
=20
     #cat boot_progress
     0102808454A8
=20
-2) SoC Power Limit
+2) SoC power limit
=20
-SMpro misc driver creates the sysfs file ``soc_power_limit`` to get/set th=
e SoC Power Limit.
+   The driver creates ``soc_power_limit`` sysfs file to get/set the SoC
+   power limit.
=20
-Reading this sysfs return the current setting of SoC Power Limit (W) in de=
cimal string.
-Writing the desired value in decimal string to set the SoC Power Limit in =
Watt (W).
-The range of SoC Power Limit is 90-500(W) and will be ignored if out of ra=
nge.
+   Reading the file returns the current limit. Write the desired value in
+   decimal to set the limit (in watts).  The valid limit range is 90-500 W.
+   If the value is out of range, it will be ignored.
=20
-Example::
+   Example::
=20
-    #cat soc_power_limit
-    90
-    #echo 95 > soc_power_limit
-    #cat soc_power_limit
-    95
+     #cat soc_power_limit
+     90
+     #echo 95 > soc_power_limit
+     #cat soc_power_limit
+     95

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--zsOt5hDHQ+A0q34n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYze96AAKCRD2uYlJVVFO
owcpAP0SzTkhr29W2c7tfiTwIYHWalYjmZY5EzVRjxQmi/J9sAD/WNg/Verj9bSP
Po+V7JVmI96xpkLGdOLqpermfOky3Q8=
=qEoH
-----END PGP SIGNATURE-----

--zsOt5hDHQ+A0q34n--
