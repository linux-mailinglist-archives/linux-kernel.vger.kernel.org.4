Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B383C6FC2BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjEIJ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjEIJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD824C26
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683624401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEcOfqCp1rrzASpfXVvlGrb4MMXQCCnMXeB3QkjwiT4=;
        b=MwhUCvwLAvTF6VAU/Ak1u9AuoDa6gPwJfoEttQjsu+pZnqg9HKq7eADCxCtlWGelttTT28
        rLTzNpc/bZdPfyWE0wwZvcZnhpKAqYf60BNs05MTkenKADfgTKJpYGpxxYbTVrt7qmk6vk
        AQXgAPcNAxFFPZjlyC0Pr9gtOa46SGA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-TLNMtZIuOomzEnt5XmzgeA-1; Tue, 09 May 2023 05:26:38 -0400
X-MC-Unique: TLNMtZIuOomzEnt5XmzgeA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50bc55eaaccso6514504a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683624397; x=1686216397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEcOfqCp1rrzASpfXVvlGrb4MMXQCCnMXeB3QkjwiT4=;
        b=g90QoN4+9r50xsqAslfC0h9Ly9VCuJKZTePC+HG+1K6D/QYj0RIE3r60xe9LiSUfAw
         hkx1fN5+FSKgzugLPTxEV2Oc94c3Ae3zTWpT/3gL0GCqF3E01F5ixUTuu9sBDuAzLFgb
         BVzF6RNglP81XyEi4lcpLUMw6kmyj2faby0uz9CuaB+OFpPRKvwPl2h/YvuhI/5caxu+
         rgcO3quD3mAbM1/Gb0k1lIGFpBlJePjTdgYE/nDUwSa0yuvNZTV0KAg+iDGJcMT1LC40
         nLAQqbhmn+dRSiiLONsUQtyALnEu7UYTfwIhd0vAuNH5b38fqLrlaiLQFxkyE37i5jEK
         x0sQ==
X-Gm-Message-State: AC+VfDx1Albvez9VdV0loKJYDF9x7aSDIZeUsLcdiD9DQJHnadQbeUGO
        p+3iRm/zGVXuaHqNBZqK2c21gy0SnOFUDZjnN55hRjOVq1Ye9vb6CkNFkzA/Xp8roRoUDRz3h8J
        mxUDnnsdQJVHEbzMJ88T4DkE0
X-Received: by 2002:aa7:db90:0:b0:50d:9a30:f305 with SMTP id u16-20020aa7db90000000b0050d9a30f305mr5353638edt.24.1683624397189;
        Tue, 09 May 2023 02:26:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gkPE0T2BpmbGbcZIDVicfiKGyu81xbmOPSAs/Wup8YJFliE0u5qRHi4NtsdvIYg2ZS1upbg==
X-Received: by 2002:aa7:db90:0:b0:50d:9a30:f305 with SMTP id u16-20020aa7db90000000b0050d9a30f305mr5353624edt.24.1683624396671;
        Tue, 09 May 2023 02:26:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7d694000000b0050bcbb5708asm551702edr.35.2023.05.09.02.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 02:26:36 -0700 (PDT)
Message-ID: <2751085b-2c72-91ec-b2b1-2bd5d4ac3d1b@redhat.com>
Date:   Tue, 9 May 2023 11:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] platform/x86: dell-ddv: Add documentation
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     corbet@lwn.net, bagasdotme@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230508204241.11076-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230508204241.11076-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/8/23 22:42, Armin Wolf wrote:
> The WMI interface used by the dell-wmi-ddv driver contains
> many methods which are currently unused, making it difficult
> to document these inside the drivers source code.
> Create the necessary documentation based on current knowledge
> so that all details of the WMI interface can be written down
> for later use.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> Changes in v2:
> - mark note regarding the unknown byte inside the thermal sensor entry as TODO
> - mention Documentation/admin-guide/reporting-issues.rst
> ---
>  Documentation/wmi/devices/dell-wmi-ddv.rst | 296 +++++++++++++++++++++
>  MAINTAINERS                                |   1 +
>  2 files changed, 297 insertions(+)
>  create mode 100644 Documentation/wmi/devices/dell-wmi-ddv.rst
> 
> diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wmi/devices/dell-wmi-ddv.rst
> new file mode 100644
> index 000000000000..d8aa64e9c827
> --- /dev/null
> +++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
> @@ -0,0 +1,296 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +============================================
> +Dell DDV WMI interface driver (dell-wmi-ddv)
> +============================================
> +
> +Introduction
> +============
> +
> +Many Dell notebooks made after ~2020 support a WMI-based interface for
> +retrieving various system data like battery temperature, ePPID, diagostic data
> +and fan/thermal sensor data.
> +
> +This interface is likely used by the `Dell Data Vault` software on Windows,
> +so it was called `DDV`. Currently the ``dell-wmi-ddv`` driver supports
> +version 2 and 3 of the interface, with support for new interface versions
> +easily added.
> +
> +.. warning:: The interface is regarded as internal by Dell, so no vendor
> +             documentation is available. All knowledge was thus obtained by
> +             trial-and-error, please keep that in mind.
> +
> +Dell ePPID (electronic Piece Part Identification)
> +=================================================
> +
> +The Dell ePPID is used to uniquely identify components in Dell machines,
> +including batteries. It has a form similar to `CC-PPPPPP-MMMMM-YMD-SSSS-FFF`
> +and contains the following information:
> +
> +* Country code of origin (CC).
> +* Part number with the first character being a filling number (PPPPPP).
> +* Manufacture Identification (MMMMM).
> +* Manufacturing Year/Month/Date (YMD) in base 36, with Y being the last digit
> +  of the year.
> +* Manufacture Sequence Number (SSSS).
> +* Optional Firmware Version/Revision (FFF).
> +
> +The `eppidtool <https://pypi.org/project/eppidtool>`_ python utility can be used
> +to decode and display this information.
> +
> +All information regarding the Dell ePPID was gathered using Dell support
> +documentation and `this website <https://telcontar.net/KBK/Dell/date_codes>`_.
> +
> +WMI interface description
> +=========================
> +
> +The WMI interface description can be decoded from the embedded binary MOF (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> + [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("WMI Function"), guid("{8A42EA14-4F2A-FD45-6422-0087F7A7E608}")]
> + class DDVWmiMethodFunction {
> +   [key, read] string InstanceName;
> +   [read] boolean Active;
> +
> +   [WmiMethodId(1), Implemented, read, write, Description("Return Battery Design Capacity.")] void BatteryDesignCapacity([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(2), Implemented, read, write, Description("Return Battery Full Charge Capacity.")] void BatteryFullChargeCapacity([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(3), Implemented, read, write, Description("Return Battery Manufacture Name.")] void BatteryManufactureName([in] uint32 arg2, [out] string argr);
> +   [WmiMethodId(4), Implemented, read, write, Description("Return Battery Manufacture Date.")] void BatteryManufactureDate([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(5), Implemented, read, write, Description("Return Battery Serial Number.")] void BatterySerialNumber([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(6), Implemented, read, write, Description("Return Battery Chemistry Value.")] void BatteryChemistryValue([in] uint32 arg2, [out] string argr);
> +   [WmiMethodId(7), Implemented, read, write, Description("Return Battery Temperature.")] void BatteryTemperature([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(8), Implemented, read, write, Description("Return Battery Current.")] void BatteryCurrent([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(9), Implemented, read, write, Description("Return Battery Voltage.")] void BatteryVoltage([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(10), Implemented, read, write, Description("Return Battery Manufacture Access(MA code).")] void BatteryManufactureAceess([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(11), Implemented, read, write, Description("Return Battery Relative State-Of-Charge.")] void BatteryRelativeStateOfCharge([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(12), Implemented, read, write, Description("Return Battery Cycle Count")] void BatteryCycleCount([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(13), Implemented, read, write, Description("Return Battery ePPID")] void BatteryePPID([in] uint32 arg2, [out] string argr);
> +   [WmiMethodId(14), Implemented, read, write, Description("Return Battery Raw Analytics Start")] void BatteryeRawAnalyticsStart([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(15), Implemented, read, write, Description("Return Battery Raw Analytics")] void BatteryeRawAnalytics([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> +   [WmiMethodId(16), Implemented, read, write, Description("Return Battery Design Voltage.")] void BatteryDesignVoltage([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(17), Implemented, read, write, Description("Return Battery Raw Analytics A Block")] void BatteryeRawAnalyticsABlock([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> +   [WmiMethodId(18), Implemented, read, write, Description("Return Version.")] void ReturnVersion([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(32), Implemented, read, write, Description("Return Fan Sensor Information")] void FanSensorInformation([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> +   [WmiMethodId(34), Implemented, read, write, Description("Return Thermal Sensor Information")] void ThermalSensorInformation([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
> + };
> +
> +Each WMI method takes an ACPI buffer containing a 32-bit index as input argument,
> +with the first 8 bit being used to specify the battery when using battery-related
> +WMI methods. Other WMI methods may ignore this argument or interpret it
> +differently. The WMI method output format varies:
> +
> +* if the function has only a single output, then an ACPI object
> +  of the corresponding type is returned
> +* if the function has multiple outputs, when an ACPI package
> +  containing the outputs in the same order is returned
> +
> +The format of the output should be thoroughly checked, since many methods can
> +return malformed data in case of an error.
> +
> +The data format of many battery-related methods seems to be based on the
> +`Smart Battery Data Specification`, so unknown battery-related methods are
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
> +   TODO: Find out what the meaning of the last byte is.
> +
> +ACPI battery matching algorithm
> +===============================
> +
> +The algorithm used to match ACPI batteries to indices is based on information
> +which was found inside the logging messages of the OEM software.
> +
> +Basically for each new ACPI battery, the serial numbers of the batteries behind
> +indices 1 till 3 are compared with the serial number of the ACPI battery.
> +Since the serial number of the ACPI battery can either be encoded as a normal
> +integer or as a hexadecimal value, both cases need to be checked. The first
> +index with a matching serial number is then selected.
> +
> +A serial number of 0 indicates that the corresponding index is not associated
> +with an actual battery, or that the associated battery is not present.
> +
> +Some machines like the Dell Inspiron 3505 only support a single battery and thus
> +ignore the battery index. Because of this the driver depends on the ACPI battery
> +hook mechanism to discover batteries.
> +
> +.. note::
> +   The ACPI battery matching algorithm currently used inside the driver is
> +   outdated and does not match the algorithm described above. The reasons for
> +   this are differences in the handling of the ToHexString() ACPI opcode between
> +   Linux and Windows, which distorts the serial number of ACPI batteries on many
> +   machines. Until this issue is resolved, the driver cannot use the above
> +   algorithm.
> +
> +Reverse-Engineering the DDV WMI interface
> +=========================================
> +
> +1. Find a supported Dell notebook, usually made after ~2020.
> +2. Dump the ACPI tables and search for the WMI device (usually called "ADDV").
> +3. Decode the corresponding bmof data and look at the ASL code.
> +4. Try to deduce the meaning of a certain WMI method by comparing the control
> +   flow with other ACPI methods (_BIX or _BIF for battery related methods
> +   for example).
> +5. Use the built-in UEFI diagostics to view sensor types/values for fan/thermal
> +   related methods (sometimes overwriting static ACPI data fields can be used
> +   to test different sensor type values, since on some machines this data is
> +   not reinitialized upon a warm reset).
> +
> +Alternatively:
> +
> +1. Load the ``dell-wmi-ddv`` driver, use the ``force`` module param
> +   if necessary.
> +2. Use the debugfs interface to access the raw fan/thermal sensor buffer data.
> +3. Compare the data with the built-in UEFI diagnostics.
> +
> +In case the DDV WMI interface version available on your Dell notebook is not
> +supported or you are seeing unknown fan/thermal sensors, please submit a
> +bugreport on `bugzilla <https://bugzilla.kernel.org>`_ so they can be added
> +to the ``dell-wmi-ddv`` driver.
> +
> +See Documentation/admin-guide/reporting-issues.rst for further information.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d5b1f6d77f6..66e4eabaf972 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5804,6 +5804,7 @@ M:	Armin Wolf <W_Armin@gmx.de>
>  S:	Maintained
>  F:	Documentation/ABI/testing/debugfs-dell-wmi-ddv
>  F:	Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
> +F:	Documentation/wmi/devices/dell-wmi-ddv.rst
>  F:	drivers/platform/x86/dell/dell-wmi-ddv.c
> 
>  DELL WMI SYSMAN DRIVER
> --
> 2.30.2
> 

