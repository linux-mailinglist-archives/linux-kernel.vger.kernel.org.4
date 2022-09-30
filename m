Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFA05F07C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiI3JiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiI3JiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:38:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7709012CCA0;
        Fri, 30 Sep 2022 02:38:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u92so3763238pjh.3;
        Fri, 30 Sep 2022 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vGNPCEtLFhWjfK9IXcgU0eqgNukRg8dBOh1kmfIugDc=;
        b=TlZV7Yu6bLgOiddHXSBLZd7CK9ZKlbrAxvAPMZDWN30ox2qkD4yR/fW4/s03iMLL8b
         X8inC57H6O8bNIFUfvBR5jynzAGnLJ2MLRUd0hYevYW7fxT4DW/4R/Q6+wbASf1xXoRI
         u/xY4KRM2nOLSpNMFhOgjZTadeveyicND3Yc4RnwAmshUYGFkWX9wBqtqHxQ6SfCX1Ux
         SIi5oUH/8aMd211aS0yr8UJNO3rokwaVMnQKkEXaSE7dkvrBtuQylkjqy57OkAINfqmh
         TwYLLcCgdwFs+beXEFD4x1npY8suH2CHuYbpFEyQRwyel70SExxFtEzF7USjmYURAbJX
         kw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vGNPCEtLFhWjfK9IXcgU0eqgNukRg8dBOh1kmfIugDc=;
        b=qABTtqtBWvZlCRfvMTqCu3nY0EJsvtQucUAHO61//C2iEKjU9R6+wxFe1tvLX1Evp8
         VtzrEfltxSixSm49zDaKtBMXfS22LusdPe0N6SnP5rQpruFVGKSjZ1hzEkMwamlgCARG
         wepp/B5yuIszRS9EaRYos8bkbh5+54g6ozcaA+h/NC58u3w+JIpZir0mCfKh7hel/IAd
         2B7kCTd/OZh47ndAfSKRh5zoA5sSgM7S+ASeMt6krZ8SJ0cm1QFcEay+l0xlG7NVNPLi
         FO23zXdCsYSQbkq03To1+uUkPXQjU/EzZZcEyUIBiH480ejmjRrCrVB7Nf9kIEOaUueU
         59kA==
X-Gm-Message-State: ACrzQf1uMs3XuLrO2xqWU8w65GI87FZmSBhn4aNmY24MWn5VM1BwqYVH
        ZztIsbDPy0n44lQW0M7cXCc=
X-Google-Smtp-Source: AMsMyM6Tysv9I/TfW5N5DdZ3nVlO6jJR0Vkk+lJOnV/5UmqJrpM/rddNW+Vj2qAk9z8Q/RCD2gDi8g==
X-Received: by 2002:a17:902:d70e:b0:178:2d9d:ba7b with SMTP id w14-20020a170902d70e00b001782d9dba7bmr8014206ply.90.1664530695076;
        Fri, 30 Sep 2022 02:38:15 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id gm7-20020a17090b100700b0020599274efdsm1252960pjb.0.2022.09.30.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:38:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 444661005BB; Fri, 30 Sep 2022 16:38:11 +0700 (WIB)
Date:   Fri, 30 Sep 2022 16:38:11 +0700
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
Subject: Re: [PATCH v9 9/9] docs: ABI: testing: Document the Ampere Altra
 Family's SMpro sysfs interfaces
Message-ID: <Yza5AyTDyM5yo7HG@debian.me>
References: <20220929094321.770125-1-quan@os.amperecomputing.com>
 <20220929094321.770125-10-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kUsQPpaU0BXqgnpI"
Content-Disposition: inline
In-Reply-To: <20220929094321.770125-10-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kUsQPpaU0BXqgnpI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2022 at 04:43:21PM +0700, Quan Nguyen wrote:
> diff --git a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-=
smpro b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
> new file mode 100644
> index 000000000000..d8f82a06570d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
> @@ -0,0 +1,125 @@
> +What:		/sys/bus/platform/devices/smpro-errmon.*/error_[core|mem|pcie|oth=
er]_[ce|ue]
> +KernelVersion:	5.18
> +Contact:	quan@os.amperecomputing.com
> +Description:
> +		(RO) Contains the 48-byte Ampere (Vendor-Specific) Error Record printed
> +		in hex format.
> +
> +		The detail of each sysfs entries is as below:
> +		+-------------+-------------------------------------------------------=
--+
> +		|   Error     |                   Sysfs entry                         =
  |
> +		+-------------+-------------------------------------------------------=
--+
> +		| Core's CE   | /sys/bus/platform/devices/smpro-errmon.*/error_core_ce=
 |
> +		| Core's UE   | /sys/bus/platform/devices/smpro-errmon.*/error_core_ue=
 |
> +		| Memory's CE | /sys/bus/platform/devices/smpro-errmon.*/error_mem_ce =
 |
> +		| Memory's UE | /sys/bus/platform/devices/smpro-errmon.*/error_mem_ue =
 |
> +		| PCIe's CE   | /sys/bus/platform/devices/smpro-errmon.*/error_pcie_ce=
 |
> +		| PCIe's UE   | /sys/bus/platform/devices/smpro-errmon.*/error_pcie_ue=
 |
> +		| Other's CE  | /sys/bus/platform/devices/smpro-errmon.*/error_other_c=
e|
> +		| Other's UE  | /sys/bus/platform/devices/smpro-errmon.*/error_other_u=
e|
> +		+-------------+-------------------------------------------------------=
--+
> +		UE: Uncorrect-able Error
> +		CE: Correct-able Error
> +
> +		See section 3.3 Ampere (Vendor-Specific) Error Record Formats,
> +		Altra Family RAS Supplement.
> +
> +
> +What:		/sys/bus/platform/devices/smpro-errmon.*/overflow_[core|mem|pcie|=
other]_[ce|ue]
> +KernelVersion:	5.18
> +Contact:	quan@os.amperecomputing.com
> +Description:
> +		(RO) Return the overflow status of each type HW error reported:
> +		  0      : No overflow
> +		  1      : There is an overflow and the oldest HW errors are dropped
> +
> +		The detail of each sysfs entries is as below:
> +		+-------------+-------------------------------------------------------=
----+
> +		|   Overflow  |                   Sysfs entry                         =
    |
> +		+-------------+-------------------------------------------------------=
----+
> +		| Core's CE   | /sys/bus/platform/devices/smpro-errmon.*/overflow_core=
_ce |
> +		| Core's UE   | /sys/bus/platform/devices/smpro-errmon.*/overflow_core=
_ue |
> +		| Memory's CE | /sys/bus/platform/devices/smpro-errmon.*/overflow_mem_=
ce  |
> +		| Memory's UE | /sys/bus/platform/devices/smpro-errmon.*/overflow_mem_=
ue  |
> +		| PCIe's CE   | /sys/bus/platform/devices/smpro-errmon.*/overflow_pcie=
_ce |
> +		| PCIe's UE   | /sys/bus/platform/devices/smpro-errmon.*/overflow_pcie=
_ue |
> +		| Other's CE  | /sys/bus/platform/devices/smpro-errmon.*/overflow_othe=
r_ce|
> +		| Other's UE  | /sys/bus/platform/devices/smpro-errmon.*/overflow_othe=
r_ue|
> +		+-------------+-------------------------------------------------------=
----+
> +		UE: Uncorrect-able Error
> +		CE: Correct-able Error
> +
> +What:           /sys/bus/platform/devices/smpro-errmon.*/[error|warn]_[s=
mpro|pmpro]
> +KernelVersion:	5.18
> +Contact:	quan@os.amperecomputing.com
> +Description:
> +		(RO) Contains the internal firmware error/warning printed as hex forma=
t.
> +
> +		The detail of each sysfs entries is as below:
> +		+---------------+-----------------------------------------------------=
-+
> +		|   Error       |                   Sysfs entry                       =
 |
> +		+---------------+-----------------------------------------------------=
-+
> +		| SMpro error   | /sys/bus/platform/devices/smpro-errmon.*/error_smpro=
 |
> +		| SMpro warning | /sys/bus/platform/devices/smpro-errmon.*/warn_smpro =
 |
> +		| PMpro error   | /sys/bus/platform/devices/smpro-errmon.*/error_pmpro=
 |
> +		| PMpro warning | /sys/bus/platform/devices/smpro-errmon.*/warn_pmpro =
 |
> +		+---------------+-----------------------------------------------------=
-+
> +		See more details in section 5.10 RAS Internal Error Register Definitio=
ns,
> +		Altra Family Soc BMC Interface Specification.
> +
> +What:           /sys/bus/platform/devices/smpro-errmon.*/event_[vrd_warn=
_fault|vrd_hot|dimm_hot]
> +KernelVersion:	5.18
> +Contact:	quan@os.amperecomputing.com
> +Description:
> +		(RO) Contains the detail information in case of VRD/DIMM warning/hot e=
vents
> +		in hex format as below:
> +
> +		AAAA
> +		Where:
> +		  AAAA: The event detail information data
> +
> +		See more details in section 5.7 GPI Status Registers,
> +		Altra Family Soc BMC Interface Specification.
> +
> +
> +What:		/sys/bus/platform/devices/smpro-misc.*/boot_progress
> +KernelVersion:	5.18
> +Contact:	quan@os.amperecomputing.com
> +Description:
> +		(RO) Contains the boot stages information in hex as format below:
> +
> +		AABBCCCCCCCC
> +		Where:
> +		  AA      : The boot stages
> +		              00: SMpro firmware booting
> +		              01: PMpro firmware booting
> +		              02: ATF BL1 firmware booting
> +		              03: DDR initialization
> +		              04: DDR training report status
> +		              05: ATF BL2 firmware booting
> +		              06: ATF BL31 firmware booting
> +		              07: ATF BL32 firmware booting
> +		              08: UEFI firmware booting
> +		              09: OS booting
> +		  BB      : Boot status
> +		              00: Not started
> +		              01: Started
> +		              02: Completed without error
> +		              03: Failed.
> +		  CCCCCCCC: Boot status information defined for each boot stages
> +
> +		See more details in section 5.11 Boot Stage Register Definitions,
> +		and section 6. Processor Boot Progress Codes, Altra Family Soc BMC
> +		Interface Specification.
> +
> +
> +What:           /sys/bus/platform/devices/smpro-misc*/soc_power_limit
> +KernelVersion:	5.18
> +Contact:	quan@os.amperecomputing.com
> +Description:
> +		(RW) Contains the desired SoC power limit in Watt.
> +		Writes to this sysfs set the desired SoC power limit (W).
> +		Reads from this register return the current SoC power limit (W).
> +		The value ranges:
> +		  Minimum: 120 W
> +		  Maximum: Socket TDP power

The documentation above produces htmldocs warnings:

Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro:71: WARNI=
NG: Unexpected indentation.
Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro:117: WARN=
ING: Unexpected indentation.
Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro:86: WARNI=
NG: Unexpected indentation.
Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro:86: WARNI=
NG: Definition list ends without a blank line; unexpected unindent.

I have applied the fixup (with fixes to technical references):

---- >8 ----

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-sm=
pro b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
index d8f82a06570d88..39cf222fb6510a 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
+++ b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
@@ -6,23 +6,32 @@ Description:
 		in hex format.
=20
 		The detail of each sysfs entries is as below:
+
 		+-------------+---------------------------------------------------------+
 		|   Error     |                   Sysfs entry                           |
 		+-------------+---------------------------------------------------------+
-		| Core's CE   | /sys/bus/platform/devices/smpro-errmon.*/error_core_ce |
-		| Core's UE   | /sys/bus/platform/devices/smpro-errmon.*/error_core_ue |
-		| Memory's CE | /sys/bus/platform/devices/smpro-errmon.*/error_mem_ce  |
-		| Memory's UE | /sys/bus/platform/devices/smpro-errmon.*/error_mem_ue  |
-		| PCIe's CE   | /sys/bus/platform/devices/smpro-errmon.*/error_pcie_ce |
-		| PCIe's UE   | /sys/bus/platform/devices/smpro-errmon.*/error_pcie_ue |
-		| Other's CE  | /sys/bus/platform/devices/smpro-errmon.*/error_other_ce|
-		| Other's UE  | /sys/bus/platform/devices/smpro-errmon.*/error_other_ue|
+		| Core's CE   | /sys/bus/platform/devices/smpro-errmon.*/error_core_ce  |
 		+-------------+---------------------------------------------------------+
+		| Core's UE   | /sys/bus/platform/devices/smpro-errmon.*/error_core_ue  |
+		+-------------+---------------------------------------------------------+
+		| Memory's CE | /sys/bus/platform/devices/smpro-errmon.*/error_mem_ce   |
+		+-------------+---------------------------------------------------------+
+		| Memory's UE | /sys/bus/platform/devices/smpro-errmon.*/error_mem_ue   |
+		+-------------+---------------------------------------------------------+
+		| PCIe's CE   | /sys/bus/platform/devices/smpro-errmon.*/error_pcie_ce  |
+		+-------------+---------------------------------------------------------+
+		| PCIe's UE   | /sys/bus/platform/devices/smpro-errmon.*/error_pcie_ue  |
+		+-------------+---------------------------------------------------------+
+		| Other's CE  | /sys/bus/platform/devices/smpro-errmon.*/error_other_ce |
+		+-------------+---------------------------------------------------------+
+		| Other's UE  | /sys/bus/platform/devices/smpro-errmon.*/error_other_ue |
+		+-------------+---------------------------------------------------------+
+
 		UE: Uncorrect-able Error
 		CE: Correct-able Error
=20
-		See section 3.3 Ampere (Vendor-Specific) Error Record Formats,
-		Altra Family RAS Supplement.
+		For details, see section `3.3 Ampere (Vendor-Specific) Error Record Form=
ats,
+		Altra Family RAS Supplement`.
=20
=20
 What:		/sys/bus/platform/devices/smpro-errmon.*/overflow_[core|mem|pcie|ot=
her]_[ce|ue]
@@ -30,24 +39,36 @@ KernelVersion:	5.18
 Contact:	quan@os.amperecomputing.com
 Description:
 		(RO) Return the overflow status of each type HW error reported:
-		  0      : No overflow
-		  1      : There is an overflow and the oldest HW errors are dropped
+
+		  - 0      : No overflow
+		  - 1      : There is an overflow and the oldest HW errors are dropped
=20
 		The detail of each sysfs entries is as below:
+
 		+-------------+---------------------------------------------------------=
--+
 		|   Overflow  |                   Sysfs entry                           =
  |
 		+-------------+---------------------------------------------------------=
--+
 		| Core's CE   | /sys/bus/platform/devices/smpro-errmon.*/overflow_core_c=
e |
+		+-------------+---------------------------------------------------------=
--+
 		| Core's UE   | /sys/bus/platform/devices/smpro-errmon.*/overflow_core_u=
e |
+		+-------------+---------------------------------------------------------=
--+
 		| Memory's CE | /sys/bus/platform/devices/smpro-errmon.*/overflow_mem_ce=
  |
+		+-------------+---------------------------------------------------------=
--+
 		| Memory's UE | /sys/bus/platform/devices/smpro-errmon.*/overflow_mem_ue=
  |
+		+-------------+---------------------------------------------------------=
--+
 		| PCIe's CE   | /sys/bus/platform/devices/smpro-errmon.*/overflow_pcie_c=
e |
+		+-------------+---------------------------------------------------------=
--+
 		| PCIe's UE   | /sys/bus/platform/devices/smpro-errmon.*/overflow_pcie_u=
e |
+		+-------------+---------------------------------------------------------=
--+
 		| Other's CE  | /sys/bus/platform/devices/smpro-errmon.*/overflow_other_=
ce|
+		+-------------+---------------------------------------------------------=
--+
 		| Other's UE  | /sys/bus/platform/devices/smpro-errmon.*/overflow_other_=
ue|
 		+-------------+---------------------------------------------------------=
--+
-		UE: Uncorrect-able Error
-		CE: Correct-able Error
+
+		where:
+
+		  - UE: Uncorrect-able Error
+		  - CE: Correct-able Error
=20
 What:           /sys/bus/platform/devices/smpro-errmon.*/[error|warn]_[smp=
ro|pmpro]
 KernelVersion:	5.18
@@ -56,61 +77,74 @@ Description:
 		(RO) Contains the internal firmware error/warning printed as hex format.
=20
 		The detail of each sysfs entries is as below:
+
 		+---------------+------------------------------------------------------+
 		|   Error       |                   Sysfs entry                        |
 		+---------------+------------------------------------------------------+
 		| SMpro error   | /sys/bus/platform/devices/smpro-errmon.*/error_smpro |
+		+---------------+------------------------------------------------------+
 		| SMpro warning | /sys/bus/platform/devices/smpro-errmon.*/warn_smpro  |
+		+---------------+------------------------------------------------------+
 		| PMpro error   | /sys/bus/platform/devices/smpro-errmon.*/error_pmpro |
+		+---------------+------------------------------------------------------+
 		| PMpro warning | /sys/bus/platform/devices/smpro-errmon.*/warn_pmpro  |
 		+---------------+------------------------------------------------------+
-		See more details in section 5.10 RAS Internal Error Register Definitions,
-		Altra Family Soc BMC Interface Specification.
+
+		For details, see section `5.10 RAS Internal Error Register Definitions,
+		Altra Family Soc BMC Interface Specification`.
=20
 What:           /sys/bus/platform/devices/smpro-errmon.*/event_[vrd_warn_f=
ault|vrd_hot|dimm_hot]
 KernelVersion:	5.18
 Contact:	quan@os.amperecomputing.com
 Description:
 		(RO) Contains the detail information in case of VRD/DIMM warning/hot eve=
nts
-		in hex format as below:
+		in hex format as below::
=20
-		AAAA
-		Where:
-		  AAAA: The event detail information data
+		    AAAA
=20
-		See more details in section 5.7 GPI Status Registers,
-		Altra Family Soc BMC Interface Specification.
+		where:
+
+		  - ``AAAA``: The event detail information data
+
+		For more details, see section `5.7 GPI Status Registers,
+		Altra Family Soc BMC Interface Specification`.
=20
=20
 What:		/sys/bus/platform/devices/smpro-misc.*/boot_progress
 KernelVersion:	5.18
 Contact:	quan@os.amperecomputing.com
 Description:
-		(RO) Contains the boot stages information in hex as format below:
+		(RO) Contains the boot stages information in hex as format below::
=20
-		AABBCCCCCCCC
-		Where:
-		  AA      : The boot stages
-		              00: SMpro firmware booting
-		              01: PMpro firmware booting
-		              02: ATF BL1 firmware booting
-		              03: DDR initialization
-		              04: DDR training report status
-		              05: ATF BL2 firmware booting
-		              06: ATF BL31 firmware booting
-		              07: ATF BL32 firmware booting
-		              08: UEFI firmware booting
-		              09: OS booting
-		  BB      : Boot status
-		              00: Not started
-		              01: Started
-		              02: Completed without error
-		              03: Failed.
-		  CCCCCCCC: Boot status information defined for each boot stages
+		    AABBCCCCCCCC
=20
-		See more details in section 5.11 Boot Stage Register Definitions,
-		and section 6. Processor Boot Progress Codes, Altra Family Soc BMC
-		Interface Specification.
+		where:
+
+		  - ``AA``      : The boot stages
+
+		    - 00: SMpro firmware booting
+		    - 01: PMpro firmware booting
+		    - 02: ATF BL1 firmware booting
+		    - 03: DDR initialization
+		    - 04: DDR training report status
+		    - 05: ATF BL2 firmware booting
+		    - 06: ATF BL31 firmware booting
+		    - 07: ATF BL32 firmware booting
+		    - 08: UEFI firmware booting
+		    - 09: OS booting
+
+		  - ``BB``      : Boot status
+
+		    - 00: Not started
+		    - 01: Started
+		    - 02: Completed without error
+		    - 03: Failed.
+
+		  - ``CCCCCCCC``: Boot status information defined for each boot stages
+
+		For details, see section `5.11 Boot Stage Register Definitions`
+		and section `6. Processor Boot Progress Codes, Altra Family Soc BMC
+		Interface Specification`.
=20
=20
 What:           /sys/bus/platform/devices/smpro-misc*/soc_power_limit
@@ -121,5 +155,6 @@ Description:
 		Writes to this sysfs set the desired SoC power limit (W).
 		Reads from this register return the current SoC power limit (W).
 		The value ranges:
-		  Minimum: 120 W
-		  Maximum: Socket TDP power
+
+		  - Minimum: 120 W
+		  - Maximum: Socket TDP power

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--kUsQPpaU0BXqgnpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYza4/wAKCRD2uYlJVVFO
o5svAQCSZ1OckshjdWjDv7dwUTOOGBgC0fNz9+j2TFy7QR45EwD9GvxlUDr42ysP
UJgWNqn/Qxi7jKVp1cTlGl86h+PwmQw=
=bzCY
-----END PGP SIGNATURE-----

--kUsQPpaU0BXqgnpI--
