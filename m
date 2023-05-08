Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23406F9DB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 04:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjEHCZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 22:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEHCZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 22:25:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87393C25;
        Sun,  7 May 2023 19:25:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so26439265ad.3;
        Sun, 07 May 2023 19:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683512719; x=1686104719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYLAqa4N29w0Cq1DJ4k8DM0fCwpih36s8G7mBqAOZXc=;
        b=ZCWybXuDfQT+mxhdVVf1Ws901N6MMGsrzAGmW4LB7aHBbRnqQ4rqac/lb6AckLcyAl
         PCY3Pfmd2DN06Yp1Z5z97hMImlBF1DppNR7/jdzNwk2B1GeXYtpsy85qphiK6KnUGxdt
         mXJMi6dw0u7ZGqoTLwl3sv4gcIh0+A15pA2EjQhL+jKeKX8E+yLwREfKbqaKrP+bBvP5
         V8iMSVx7NmRdj2GtU8roRS17uKTAW4eRBfBsNRpOLR2yT/i7FxS3OeFghOoyexo+vSLb
         Isdlcsn4Ux5DWBqT5XqlVa3skzAVMB/1VdZV2wMMr9fbZM0WHpFcsLmJ8QV8OY9C15DL
         W6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683512719; x=1686104719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYLAqa4N29w0Cq1DJ4k8DM0fCwpih36s8G7mBqAOZXc=;
        b=cpkHMfpOf9y645jUA8qlSQ4ha4EqUV65H1vMIWZ9W8K79k1/93Rm4IEcCxp4l5eP75
         xDkSfIn/8erQMCLMp6cY8avLhfRz4aljsrym3Li+c3vo/rEH/72eJZU2Gzt9wbL2nWqb
         syh2iBnX3XlFHlBkRlR2OIkeG1Z0mXO4rVnZEsF7OGB5Nf+mHwND0BKOEHBXMDnxRzR9
         yQsknw87fhnlTuBTFhj427sSnKA419NK/SaXDnosqui2/aRcK2NWfe1pPF/mqci4Ow9D
         x48Ty8HOpqh6Uadg+tUgah+L+9FKbE0JB/rMHH5+vR9LsbskVIsOf2C8Rf6bmzrGiFuv
         eLMg==
X-Gm-Message-State: AC+VfDwIbF134aHJBv6QbpB307NXGkUoncRw9JaYw0qDp46nkmwNqTat
        kOIfjnLTLKvMBuNurobON1i06MO/eI4=
X-Google-Smtp-Source: ACHHUZ7Y5aVV8t9q7zGAGLZQ5D3gs1SrLPKHPhDYnTOfe8v3ib91O4aAMvK6p5JC5yg+HSKYE0Pt+A==
X-Received: by 2002:a17:902:7c07:b0:1a8:bc5:4912 with SMTP id x7-20020a1709027c0700b001a80bc54912mr9210652pll.52.1683512719049;
        Sun, 07 May 2023 19:25:19 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090a8e8200b0025043a8185dsm3405902pjo.23.2023.05.07.19.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 19:25:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 84B72103E37; Mon,  8 May 2023 09:25:15 +0700 (WIB)
Date:   Mon, 8 May 2023 09:25:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     corbet@lwn.net, platform-driver-x86@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Add documentation
Message-ID: <ZFhdi5B3coraW2fz@debian.me>
References: <20230429225525.10507-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7mldGUFpnv9ga7IP"
Content-Disposition: inline
In-Reply-To: <20230429225525.10507-1-W_Armin@gmx.de>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7mldGUFpnv9ga7IP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 30, 2023 at 12:55:24AM +0200, Armin Wolf wrote:
> diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/w=
mi/devices/dell-wmi-ddv.rst
> new file mode 100644
> index 000000000000..3fc6ee3e9f9b
> --- /dev/null
> +++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
> @@ -0,0 +1,294 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Dell DDV WMI interface driver (dell-wmi-ddv)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Many Dell notebooks made after ~2020 support a WMI-based interface for
> +retrieving various system data like battery temperature, ePPID, diagosti=
c data
> +and fan/thermal sensor data.
> +
> +This interface is likely used by the `Dell Data Vault` software on Windo=
ws,
> +so it was called `DDV`. Currently the ``dell-wmi-ddv`` driver supports
> +version 2 and 3 of the interface, with support for new interface versions
> +easily added.
> +
> +.. warning:: The interface is regarded as internal by Dell, so no vendor
> +             documentation is available. All knowledge was thus obtained=
 by
> +             trial-and-error, please keep that in mind.
> +
> +Dell ePPID (electronic Piece Part Identification)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Dell ePPID is used to uniquely identify components in Dell machines,
> +including batteries. It has a form similar to `CC-PPPPPP-MMMMM-YMD-SSSS-=
FFF`
> +and contains the following information:
> +
> +* Country code of origin (CC).
> +* Part number with the first character being a filling number (PPPPPP).
> +* Manufacture Identification (MMMMM).
> +* Manufacturing Year/Month/Date (YMD) in base 36, with Y being the last =
digit
> +  of the year.
> +* Manufacture Sequence Number (SSSS).
> +* Optional Firmware Version/Revision (FFF).
> +
> +The `eppidtool <https://pypi.org/project/eppidtool>`_ python utility can=
 be used
> +to decode and display this information.
> +
> +All information regarding the Dell ePPID was gathered using Dell support
> +documentation and `this website <https://telcontar.net/KBK/Dell/date_cod=
es>`_.
> +
> +WMI interface description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The WMI interface description can be decoded from the embedded binary MO=
F (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> + [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("W=
MI Function"), guid("{8A42EA14-4F2A-FD45-6422-0087F7A7E608}")]
> + class DDVWmiMethodFunction {
> +   [key, read] string InstanceName;
> +   [read] boolean Active;
> +
> +   [WmiMethodId(1), Implemented, read, write, Description("Return Batter=
y Design Capacity.")] void BatteryDesignCapacity([in] uint32 arg2, [out] ui=
nt32 argr);
> +   [WmiMethodId(2), Implemented, read, write, Description("Return Batter=
y Full Charge Capacity.")] void BatteryFullChargeCapacity([in] uint32 arg2,=
 [out] uint32 argr);
> +   [WmiMethodId(3), Implemented, read, write, Description("Return Batter=
y Manufacture Name.")] void BatteryManufactureName([in] uint32 arg2, [out] =
string argr);
> +   [WmiMethodId(4), Implemented, read, write, Description("Return Batter=
y Manufacture Date.")] void BatteryManufactureDate([in] uint32 arg2, [out] =
uint32 argr);
> +   [WmiMethodId(5), Implemented, read, write, Description("Return Batter=
y Serial Number.")] void BatterySerialNumber([in] uint32 arg2, [out] uint32=
 argr);
> +   [WmiMethodId(6), Implemented, read, write, Description("Return Batter=
y Chemistry Value.")] void BatteryChemistryValue([in] uint32 arg2, [out] st=
ring argr);
> +   [WmiMethodId(7), Implemented, read, write, Description("Return Batter=
y Temperature.")] void BatteryTemperature([in] uint32 arg2, [out] uint32 ar=
gr);
> +   [WmiMethodId(8), Implemented, read, write, Description("Return Batter=
y Current.")] void BatteryCurrent([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(9), Implemented, read, write, Description("Return Batter=
y Voltage.")] void BatteryVoltage([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(10), Implemented, read, write, Description("Return Batte=
ry Manufacture Access(MA code).")] void BatteryManufactureAceess([in] uint3=
2 arg2, [out] uint32 argr);
> +   [WmiMethodId(11), Implemented, read, write, Description("Return Batte=
ry Relative State-Of-Charge.")] void BatteryRelativeStateOfCharge([in] uint=
32 arg2, [out] uint32 argr);
> +   [WmiMethodId(12), Implemented, read, write, Description("Return Batte=
ry Cycle Count")] void BatteryCycleCount([in] uint32 arg2, [out] uint32 arg=
r);
> +   [WmiMethodId(13), Implemented, read, write, Description("Return Batte=
ry ePPID")] void BatteryePPID([in] uint32 arg2, [out] string argr);
> +   [WmiMethodId(14), Implemented, read, write, Description("Return Batte=
ry Raw Analytics Start")] void BatteryeRawAnalyticsStart([in] uint32 arg2, =
[out] uint32 argr);
> +   [WmiMethodId(15), Implemented, read, write, Description("Return Batte=
ry Raw Analytics")] void BatteryeRawAnalytics([in] uint32 arg2, [out] uint3=
2 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> +   [WmiMethodId(16), Implemented, read, write, Description("Return Batte=
ry Design Voltage.")] void BatteryDesignVoltage([in] uint32 arg2, [out] uin=
t32 argr);
> +   [WmiMethodId(17), Implemented, read, write, Description("Return Batte=
ry Raw Analytics A Block")] void BatteryeRawAnalyticsABlock([in] uint32 arg=
2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 Raw=
Data[]);
> +   [WmiMethodId(18), Implemented, read, write, Description("Return Versi=
on.")] void ReturnVersion([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(32), Implemented, read, write, Description("Return Fan S=
ensor Information")] void FanSensorInformation([in] uint32 arg2, [out] uint=
32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> +   [WmiMethodId(34), Implemented, read, write, Description("Return Therm=
al Sensor Information")] void ThermalSensorInformation([in] uint32 arg2, [o=
ut] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[=
]);
> + };
> +
> +Each WMI method takes an ACPI buffer containing a 32-bit index as input =
argument,
> +with the first 8 bit being used to specify the battery when using batter=
y-related
> +WMI methods. Other WMI methods may ignore this argument or interpret it
> +differently. The WMI method output format varies:
> +
> +* if the function has only a single output, then an ACPI object
> +  of the corresponding type is returned
> +* if the function has multiple outputs, when an ACPI package
> +  containing the outputs in the same order is returned
> +
> +The format of the output should be thoroughly checked, since many method=
s can
> +return malformed data in case of an error.
> +
> +The data format of many battery-related methods seems to be based on the
> +`Smart Battery Data Specification`, so unknown battery-related methods a=
re
> +likely to follow this standard in some way.
> +
> +WMI method GetBatteryDesignCapacity()
> +-------------------------------------
> +
> +Returns the design capacity of the battery in mAh as an u16.
> +
> +WMI method BatteryFullCharge()
> +------------------------------
> +
> +Returns the full charge capacity of the battery in mAh as an u16.
> +
> +WMI method BatteryManufactureName()
> +-----------------------------------
> +
> +Returns the manufacture name of the battery as an ASCII string.
> +
> +WMI method BatteryManufactureDate()
> +-----------------------------------
> +
> +Returns the manufacture date of the battery as an u16.
> +The date is encoded in the following manner:
> +
> +- bits 0 to 4 contain the manufacture day.
> +- bits 5 to 8 contain the manufacture month.
> +- bits 9 to 15 contain the manufacture year biased by 1980.
> +
> +.. note::
> +   The data format needs to be verified on more machines.
> +
> +WMI method BatterySerialNumber()
> +--------------------------------
> +
> +Returns the serial number of the battery as an u16.
> +
> +WMI method BatteryChemistryValue()
> +----------------------------------
> +
> +Returns the chemistry of the battery as an ASCII string.
> +Known values are:
> +
> +- "Li-I" for Li-Ion
> +
> +WMI method BatteryTemperature()
> +-------------------------------
> +
> +Returns the temperature of the battery in tenth degree kelvin as an u16.
> +
> +WMI method BatteryCurrent()
> +---------------------------
> +
> +Returns the current flow of the battery in mA as an s16.
> +Negative values indicate discharging.
> +
> +WMI method BatteryVoltage()
> +---------------------------
> +
> +Returns the voltage flow of the battery in mV as an u16.
> +
> +WMI method BatteryManufactureAccess()
> +-------------------------------------
> +
> +Returns a manufacture-defined value as an u16.
> +
> +WMI method BatteryRelativeStateOfCharge()
> +-----------------------------------------
> +
> +Returns the capacity of the battery in percent as an u16.
> +
> +WMI method BatteryCycleCount()
> +------------------------------
> +
> +Returns the cycle count of the battery as an u16.
> +
> +WMI method BatteryePPID()
> +-------------------------
> +
> +Returns the ePPID of the battery as an ASCII string.
> +
> +WMI method BatteryeRawAnalyticsStart()
> +--------------------------------------
> +
> +Performs an analysis of the battery and returns a status code:
> +
> +- ``0x0``: Success
> +- ``0x1``: Interface not supported
> +- ``0xfffffffe``: Error/Timeout
> +
> +.. note::
> +   The meaning of this method is still largely unknown.
> +
> +WMI method BatteryeRawAnalytics()
> +---------------------------------
> +
> +Returns a buffer usually containg 12 blocks of analytics data.
> +Those blocks contain:
> +- block number starting with 0 (u8)
> +- 31 bytes of unknown data
> +
> +.. note::
> +   The meaning of this method is still largely unknown.
> +
> +WMI method BatteryDesignVoltage()
> +---------------------------------
> +
> +Returns the design voltage of the battery in mV as an u16.
> +
> +WMI method BatteryeRawAnalyticsABlock()
> +---------------------------------------
> +
> +Returns a single block of analytics data, with the second byte
> +of the index being used for selecting the block number.
> +
> +*Supported since WMI interface version 3!*
> +
> +.. note::
> +   The meaning of this method is still largely unknown.
> +
> +WMI method ReturnVersion()
> +--------------------------
> +
> +Returns the WMI interface version as an u32.
> +
> +WMI method FanSensorInformation()
> +---------------------------------
> +
> +Returns a buffer containg fan sensor entries, terminated
> +with a single ``0xff``.
> +Those entries contain:
> +
> +- fan type (u8)
> +- fan speed in RPM (little endian u16)
> +
> +WMI method ThermalSensorInformation()
> +-------------------------------------
> +
> +Returns a buffer containing thermal sensor entries, terminated
> +with a single ``0xff``.
> +Those entries contain:
> +
> +- thermal type (u8)
> +- current temperature (s8)
> +- min. temperature (s8)
> +- max. temperature (s8)
> +- unknown field (u8)
> +
> +.. note::
> +   Find out what the meaning of the last byte is.

Is the note above TODO? If so, mark as such, keeping the note::
directive.

> +
> +ACPI battery matching algorithm
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +The algorithm used to match ACPI batteries to indices is based on inform=
ation
> +which was found inside the logging messages of the OEM software.
> +
> +Basically for each new ACPI battery, the serial numbers of the batteries=
 behind
> +indices 1 till 3 are compared with the serial number of the ACPI battery.
> +Since the serial number of the ACPI battery can either be encoded as a n=
ormal
> +integer or as a hexadecimal value, both cases need to be checked. The fi=
rst
> +index with a matching serial number is then selected.
> +
> +A serial number of 0 indicates that the corresponding index is not assoc=
iated
> +with an actual battery, or that the associated battery is not present.
> +
> +Some machines like the Dell Inspiron 3505 only support a single battery =
and thus
> +ignore the battery index. Because of this the driver depends on the ACPI=
 battery
> +hook mechanism to discover batteries.
> +
> +.. note::
> +   The ACPI battery matching algorithm currently used inside the driver =
is
> +   outdated and does not match the algorithm described above. The reason=
s for
> +   this are differences in the handling of the ToHexString() ACPI opcode=
 between
> +   Linux and Windows, which distorts the serial number of ACPI batteries=
 on many
> +   machines. Until this issue is resolved, the driver cannot use the abo=
ve
> +   algorithm.
> +
> +Reverse-Engineering the DDV WMI interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +1. Find a supported Dell notebook, usually made after ~2020.
> +2. Dump the ACPI tables and search for the WMI device (usually called "A=
DDV").
> +3. Decode the corresponding bmof data and look at the ASL code.
> +4. Try to deduce the meaning of a certain WMI method by comparing the co=
ntrol
> +   flow with other ACPI methods (_BIX or _BIF for battery related methods
> +   for example).
> +5. Use the built-in UEFI diagostics to view sensor types/values for fan/=
thermal
> +   related methods (sometimes overwriting static ACPI data fields can be=
 used
> +   to test different sensor type values, since on some machines this dat=
a is
> +   not reinitialized upon a warm reset).
> +
> +Alternatively:
> +
> +1. Load the ``dell-wmi-ddv`` driver, use the ``force`` module param
> +   if necessary.
> +2. Use the debugfs interface to access the raw fan/thermal sensor buffer=
 data.
> +3. Compare the data with the built-in UEFI diagnostics.
> +
> +In case the DDV WMI interface version available on your Dell notebook is=
 not
> +supported or you are seeing unknown fan/thermal sensors, please submit a
> +bugreport on `bugzilla <https://bugzilla.kernel.org>`_ so they can be ad=
ded
> +to the ``dell-wmi-ddv`` driver.

Also don't forget to read
Documentation/admin-guide/reporting-issues.rst.

Regardless, the formatting LGTM, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--7mldGUFpnv9ga7IP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFhdawAKCRD2uYlJVVFO
o7K4AQCoY64oytfSkk2H1Qr7DeV4b3LS3hnlAbBblO2sgO+cXwEAkFcutp7Rmkyn
cNYyC8U0uAixJhdtVIFqz12cxHSesAo=
=75NX
-----END PGP SIGNATURE-----

--7mldGUFpnv9ga7IP--
