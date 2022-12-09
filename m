Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A91E647C91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 04:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLIDWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLIDWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:22:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FDF11C28;
        Thu,  8 Dec 2022 19:22:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3615958pjm.2;
        Thu, 08 Dec 2022 19:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqPq3egEiol+w6ZuI7IGWgmtQxBJEvHkrKfaFZ8quNg=;
        b=S+DdFYZomTjuCXjcUJuGF5U4ww8T2mz+l/4RXWuehMFqG3FyddtjYDEMg01ZGPMHbd
         23NtRYJW2U4T2UZa1TYc2f4P5/gsM160/c6b7zQkh1rM4O9Rb47aZUBMap60F26eTr6x
         tqhLYhmmxciAytv6Nbdm7segG6qykh/f6b7F/Wjv3OEiYRs0siiu2xZINwkD03Tt6lGJ
         AZNvH/CkDXaY8J/OiO6m93S6jdUIjiIyky3nBF1FPY8Pw9M928pl0PsaB12XKC6tYtlS
         puFA2Y8Mn3aS74U6jieQtsxrZnTfzA8q2GqVTN2oV+E8VSofIo6tU0/1S3I+CKuAIljq
         8wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqPq3egEiol+w6ZuI7IGWgmtQxBJEvHkrKfaFZ8quNg=;
        b=kksQ3HMiKA6RI6JrNBXlyFeRQsTLnvfM0boAxaktqZbvZ2+9YzOfkg9CoYIFbBwA0P
         qrR0tMkTCQeSCNcEM+O/0rCbXZDXqUvRjvBoBMSaGBsobvK0UJeobm1L24TaR+8ok7T1
         vS6UlKPi/I0TBVIbre9lCuNAQUYlDUXzntvxjdQ9Ckt/la/u4xzi/GWf1S3FCrhLsgPr
         +8o5rNRRMaZXgFjy3ImT8HAFl0mqsQUsGFoZw209fUhH4rNG8/9V57rs0VMs0sMhje3u
         6Pbp0I4Cc8Jwc7OmJig2df1POrHMxNqJN64PwZSELssrWuIMeETtED6rZZC2tsisIszR
         qsAQ==
X-Gm-Message-State: ANoB5pmyhLvEdc4W8bBnv1/Rsq2c4ENof87GrNr53nXzpjb44wotXcOx
        B3p4EbjmcXfEd5kvrO7wLUY=
X-Google-Smtp-Source: AA0mqf42hRfj4NnycexV2/uvo+raASca364axoSA4/q+dS7fBXTTOv43PGc97ux5+A6vfCUc9MsB9Q==
X-Received: by 2002:a17:902:bcc5:b0:188:ef28:6d55 with SMTP id o5-20020a170902bcc500b00188ef286d55mr4072618pls.13.1670556161605;
        Thu, 08 Dec 2022 19:22:41 -0800 (PST)
Received: from debian.me (subs32-116-206-28-21.three.co.id. [116.206.28.21])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b00189adf6770fsm160058plh.233.2022.12.08.19.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 19:22:40 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 219AB1044CD; Fri,  9 Dec 2022 10:22:36 +0700 (WIB)
Date:   Fri, 9 Dec 2022 10:22:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Niklas Cassel <niklas.cassel@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 25/25] Documentation: sysfs-block-device: document
 command duration limits
Message-ID: <Y5Kp/JhhwF1rjrdu@debian.me>
References: <20221208105947.2399894-1-niklas.cassel@wdc.com>
 <20221208105947.2399894-26-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CYmK+XGGjrI5DVYI"
Content-Disposition: inline
In-Reply-To: <20221208105947.2399894-26-niklas.cassel@wdc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CYmK+XGGjrI5DVYI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2022 at 11:59:41AM +0100, Niklas Cassel wrote:
> +What:		/sys/block/*/device/duration_limits/enable
> +Date:		Dec, 2022
> +KernelVersion:	v6.3
> +Contact:	linux-scsi@vger.kernel.org
> +Description:
> +		(RW) For ATA and SCSI devices supporting the command duration
> +		limits feature, write to the file to turn on or off the
> +		feature. By default this feature is turned off. If the device
> +		does not support the command duration limits feature, this
> +		attribute does not exist (the directory
> +		"/sys/block/*/device/duration_limits" does not exist).
> +		Writing "1" to this file enables the use of command duration
> +		limits for read and write commands in the kernel and turns on
> +		the feature on the device. Writing "0" disables the feature.

Sphinx reported inline emphasis warning due to unescaped asterisk above:

Documentation/ABI/testing/sysfs-block-device:101: WARNING: Inline emphasis =
start-string without end-string.

I have applied the fixup:

---- >8 ----
diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/A=
BI/testing/sysfs-block-device
index 44841f91c69bfe..2cf806b638fbb3 100644
--- a/Documentation/ABI/testing/sysfs-block-device
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -107,7 +107,7 @@ Description:
 		feature. By default this feature is turned off. If the device
 		does not support the command duration limits feature, this
 		attribute does not exist (the directory
-		"/sys/block/*/device/duration_limits" does not exist).
+		"/sys/block/\*/device/duration_limits" does not exist).
 		Writing "1" to this file enables the use of command duration
 		limits for read and write commands in the kernel and turns on
 		the feature on the device. Writing "0" disables the feature.

> +
> +
> +What:		/sys/block/*/device/duration_limits/read/[1-7]/*
> +Date:		Dec, 2022
> +KernelVersion:	v6.3
> +Contact:	linux-scsi@vger.kernel.org
> +Description:
> +		(RO) For ATA and SCSI devices supporting the command duration
> +		limits feature, this shows the set of 7 command duration limits
> +		descriptors for read commands currently set on the device. For
> +		each of the 7 descritors, the following read-only attributes
> +		are present:
> +
> +		  - duration_guideline: specifies the preferred length of time
> +		    in microseconds for the completion of a command.
> +
> +		  - duration_guideline_policy: specifies the policy action
> +		    taken if the duration_guideline attribute specifies a
> +		    non-zero command duration guideline that the device is
> +		    unable to achieve for a command.
> +
> +		    Possible values are:
> +
> +		      - 0x0: The device will complete the command at the
> +			     earliest possible time consistent with the
> +			     specified command duration guideline.
> +		      - 0x1: If the specified command duration guideline has
> +			     not been achieved and the command duration
> +			     guideline policy field is not the seventh command
> +			     duration limits descriptor, then the device
> +			     continues processing that command using the
> +			     command duration limits descriptor that has
> +			     the next higher number.
> +		      - 0x2: The device will continue processing the command
> +			     as with no command duration limits descriptor
> +			     being used.
> +		      - 0xD: The device will complete the command and an IO
> +			     failure will be reported to the user with the ETIME
> +			     error code.
> +		      - 0xF: Same as 0xD.
> +
> <snipped>...
> +		    Possible values are:
> +
> +		      - 0x0: The device will complete the command at the
> +			     earliest possible time (i.e, do nothing based on
> +			     the max limit not being met).
> +		      - 0xD: The device will complete the command and an IO
> +			     failure will be reported to the user with the ETIME
> +			     error code.
> +		      - 0xE: Same as 0xD.
> +		      - 0xF: Same as 0xD.
> +
> <snipped>...
> +		    Possible values are:
> +
> +		      - 0x0: The device will complete the command at the
> +			     earliest possible time (i.e, do nothing based on
> +			     the time limit not being met).
> +		      - 0xD: The device will complete the command and an IO
> +			     failure will be reported to the user with the ETIME
> +			     error code.
> +		      - 0xF: Same as 0xD.
> +

The lists items above looks poorly indented in htmldocs (due to use of
proportional fonts). The fix is to align to first character after bullet
list marker, like:

---- >8 ----
diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/A=
BI/testing/sysfs-block-device
index 2cf806b638fbb3..79f67b975d57ac 100644
--- a/Documentation/ABI/testing/sysfs-block-device
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -135,21 +135,25 @@ Description:
 		    Possible values are:
=20
 		      - 0x0: The device will complete the command at the
-			     earliest possible time consistent with the
-			     specified command duration guideline.
+			earliest possible time consistent with the
+			specified command duration guideline.
+
 		      - 0x1: If the specified command duration guideline has
-			     not been achieved and the command duration
-			     guideline policy field is not the seventh command
-			     duration limits descriptor, then the device
-			     continues processing that command using the
-			     command duration limits descriptor that has
-			     the next higher number.
+			not been achieved and the command duration
+			guideline policy field is not the seventh command
+			duration limits descriptor, then the device
+			continues processing that command using the
+			command duration limits descriptor that has
+			the next higher number.
+
 		      - 0x2: The device will continue processing the command
-			     as with no command duration limits descriptor
-			     being used.
+			as with no command duration limits descriptor
+			being used.
+
 		      - 0xD: The device will complete the command and an IO
-			     failure will be reported to the user with the ETIME
-			     error code.
+			failure will be reported to the user with the ETIME
+			error code.
+
 		      - 0xF: Same as 0xD.
=20
 		  - max_active_time: specifies an upper limit in microseconds
@@ -165,12 +169,15 @@ Description:
 		    Possible values are:
=20
 		      - 0x0: The device will complete the command at the
-			     earliest possible time (i.e, do nothing based on
-			     the max limit not being met).
+			earliest possible time (i.e, do nothing based on
+			the max limit not being met).
+
 		      - 0xD: The device will complete the command and an IO
-			     failure will be reported to the user with the ETIME
-			     error code.
+			failure will be reported to the user with the ETIME
+			error code.
+
 		      - 0xE: Same as 0xD.
+
 		      - 0xF: Same as 0xD.
=20
 		  - max_inactive_time: specifies an upper limit in microseconds
@@ -185,11 +192,13 @@ Description:
 		    Possible values are:
=20
 		      - 0x0: The device will complete the command at the
-			     earliest possible time (i.e, do nothing based on
-			     the time limit not being met).
+			earliest possible time (i.e, do nothing based on
+			the time limit not being met).
+
 		      - 0xD: The device will complete the command and an IO
-			     failure will be reported to the user with the ETIME
-			     error code.
+			failure will be reported to the user with the ETIME
+			error code.
+
 		      - 0xF: Same as 0xD.
=20
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--CYmK+XGGjrI5DVYI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5Kp8wAKCRD2uYlJVVFO
o7EiAQDbFwVWhF/CVWXIYKBEOf576MDRyDzz42i92hrpx2BanwEAvM3aItECUxbW
3suLyS9RuTyeMDquZDebuRurHcvqJw4=
=QP6J
-----END PGP SIGNATURE-----

--CYmK+XGGjrI5DVYI--
