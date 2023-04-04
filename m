Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1F6D6A8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjDDR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjDDR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:26:37 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752F5263;
        Tue,  4 Apr 2023 10:24:58 -0700 (PDT)
Date:   Tue, 4 Apr 2023 17:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1680629017; bh=vgKOa/bVFeEsCwYrjKIh0mANzZ4XmHS16QIJ65gmeVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGDQ9kOM8ffZO+Vw+4SbMSNo0KfsZh6bIZ+DQEk24Z+2LebEohP0jQ/hGPgBmGsNR
         i9+RwavOKm7Q62ENpEumPDUJHyXV6UCTVa1sg6G8uSDGbfJUmdtO92sxAfwTHUYviJ
         uCGvV08aQu/3fwUQvsgAABnERW//zTg6/TlzaOMQ=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
Message-ID: <d5fbc118-3b33-44b8-a7b6-4738e121b170@t-8ch.de>
References: <20230403211548.6253-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230403211548.6253-1-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge!

Comments inline.

Please also Cc reviewers of past revisions to future revisions.

On 2023-04-03 16:15:48-0500, Jorge Lopez wrote:
> HP BIOS Configuration driver purpose is to provide a driver supporting
> the latest sysfs class firmware attributes framework allowing the user
> to change BIOS settings and security solutions on HP Inc.’s commercial
> notebooks.
> 
> Many features of HP Commercial notebooks can be managed using Windows
> Management Instrumentation (WMI). WMI is an implementation of Web-Based
> Enterprise Management (WBEM) that provides a standards-based interface
> for changing and monitoring system settings. HP BIOSCFG driver provides
> a native Linux solution and the exposed features facilitates the
> migration to Linux environments.
> 
> The Linux security features to be provided in hp-bioscfg driver enables
> managing the BIOS settings and security solutions via sysfs, a virtual
> filesystem that can be used by user-mode applications. The new 
> documentation cover features such Secure Platform Management and Sure 
> Start. Each section provides security feature description and identifies 
> sysfs directories and files exposed by the driver.
> 
> Many HP Commercial notebooks include a feature called Secure Platform
> Management (SPM), which replaces older password-based BIOS settings
> management with public key cryptography. PC secure product management
> begins when a target system is provisioned with cryptographic keys
> that are used to ensure the integrity of communications between system
> management utilities and the BIOS.
> 
> HP Commercial notebooks have several BIOS settings that control its 
> behaviour and capabilities, many of which are related to security. 
> To prevent unauthorized changes to these settings, the system can be 
> configured to use a cryptographic signature-based authorization string 
> that the BIOS will use to verify authorization to modify the setting.
> 
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> 
> ---
> Based on the latest platform-drivers-x86.git/for-next
> 
> History
> 
> Version 7
> 	Includes only sysfs-class-firmware-attributes documentation
> 
> Version 6
> 	Breaks down the changes into 4 patches
> 	SureAdmin-attributes was removed
> 
> Version 5
> 	Remove version 4 patch 1
> 	Address review changes proposed in Version 4
> 	Reorganize all patches number and file order
> ---
>  .../testing/sysfs-class-firmware-attributes   | 119 ++++++++++++++++--
>  1 file changed, 107 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index 4cdba3477176..10afbb78baec 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -22,6 +22,12 @@ Description:
>  			- integer: a range of numerical values
>  			- string
>  
> +		HP specific types
> +		-----------------
> +			- ordered-list - a set of ordered list valid values
> +			- sure-start

Could you explain what "sure-start" does?
Is it actually an attribute type of which multiple attributes can exist?

Or are there just some global properties that need to be exposed?
If it is global it should be directly under
/sys/class/firmware-attributes/*/authentication/
without needing the type.

> +
> +
>  		All attribute types support the following values:
>  
>  		current_value:
> @@ -42,16 +48,16 @@ Description:
>  				description of the at <attr>
>  
>  		display_name_language_code:
> -						A file that can be read to obtain
> -						the IETF language tag corresponding to the
> -						"display_name" of the <attr>
> +				A file that can be read to obtain
> +				the IETF language tag corresponding to the
> +				"display_name" of the <attr>

Are these reindentations and other cleanups intentional?

If they are intentional and there are no interactions with your actual
patch you could split them into their own patch and submit them
separately.

This way we wouldn't have to worry about them here anymore.

Note:
These indentations are different from the newly introduced documentation.

>  
>  		"enumeration"-type specific properties:
>  
>  		possible_values:
> -					A file that can be read to obtain the possible
> -					values of the <attr>. Values are separated using
> -					semi-colon (``;``).
> +				A file that can be read to obtain the possible
> +				values of the <attr>. Values are separated using
> +				semi-colon (``;``).
>  
>  		"integer"-type specific properties:
>  
> @@ -64,8 +70,8 @@ Description:
>  				bound value of the <attr>
>  
>  		scalar_increment:
> -					A file that can be read to obtain the scalar value used for
> -					increments of current_value this attribute accepts.
> +				A file that can be read to obtain the scalar value used for
> +				increments of current_value this attribute accepts.
>  
>  		"string"-type specific properties:
>  
> @@ -126,6 +132,40 @@ Description:
>  					value will not be effective through sysfs until this rule is
>  					met.
>  
> +		HP specific class extensions
> +		------------------------------
> +
> +		On HP systems the following additional attributes are available:
> +
> +		"ordered-list"-type specific properties:
> +
> +		elements:
> +					A file that can be read to obtain the possible
> +					list of values of the <attr>. Values are separated using
> +					semi-colon (``;``). The order individual elements are listed
> +					according to their priority.  An Element listed first has the
> +					highest priority. Writing the list in a different order to
> +					current_value alters the priority order for the particular
> +					attribute.
> +
> +		"sure-start"-type specific properties:
> +
> +		audit_log_entries:
> +					A read-only file that returns the events in the log.
> +					Values are separated using semi-colon (``;``)
> +
> +					Audit log entry format
> +
> +					Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
> +					Byte 16-127: Unused

How to interpret each log entry?

If it is an opaque thing from the firmware that would also be useful to
know.

> +
> +		audit_log_entry_count:
> +					A read-only file that returns the number of existing audit log events available to be read.
> +					Values are separated using comma (``,``)
> +
> +					[No of entries],[log entry size],[Max number of entries supported]

Will log entry size always be 16? Or can it be bigger in the future when
more bytes are used?
This should be mentioned.

Is audit_log_entry_count ever used without reading audit_log_entries
right after?
If not the count file could be dropped.

> +
> +
>  What:		/sys/class/firmware-attributes/*/authentication/
>  Date:		February 2021
>  KernelVersion:	5.11
> @@ -139,8 +179,7 @@ Description:
>  		For example a "BIOS Admin" password and "System" Password can be set,
>  		reset or cleared using these attributes.
>  
> -		- An "Admin" password is used for preventing modification to the BIOS
> -		  settings.
> +		- An "Admin" password is used for preventing modification to the BIOS settings.
>  		- A "System" password is required to boot a machine.
>  
>  		Change in any of these two authentication methods will also generate an
> @@ -206,7 +245,7 @@ Description:
>  		Drivers may emit a CHANGE uevent when a password is set or unset
>  		userspace may check it again.
>  
> -		On Dell and Lenovo systems, if Admin password is set, then all BIOS attributes
> +		On Dell, Lenovo and HP systems, if Admin password is set, then all BIOS attributes
>  		require password validation.
>  		On Lenovo systems if you change the Admin password the new password is not active until
>  		the next boot.
> @@ -296,6 +335,15 @@ Description:
>  						echo "signature" > authentication/Admin/signature
>  						echo "password" > authentication/Admin/certificate_to_password
>  
> +		HP specific class extensions
> +		--------------------------------
> +
> +		On HP systems the following additional settings are available:
> +
> +		role: enhanced-bios-auth:
> +					This role is specific to Secure Platform Management (SPM) attribute.
> +					It requires configuring an endorsement (kek) and signing certificate (sk).
> +
>  
>  What:		/sys/class/firmware-attributes/*/attributes/pending_reboot
>  Date:		February 2021
> @@ -311,7 +359,7 @@ Description:
>  			==	=========================================
>  			0	All BIOS attributes setting are current
>  			1	A reboot is necessary to get pending BIOS
> -			        attribute changes applied
> +				attribute changes applied
>  			==	=========================================
>  
>  		Note, userspace applications need to follow below steps for efficient
> @@ -364,3 +412,50 @@ Description:
>  		use it to enable extra debug attributes or BIOS features for testing purposes.
>  
>  		Note that any changes to this attribute requires a reboot for changes to take effect.
> +
> +
> +		HP specific class extensions - Secure Platform Manager (SPM)
> +		--------------------------------
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'kek' Key-Encryption-Key is a write-only file that can be used to configure the
> +		RSA public key that will be used by the BIOS to verify signatures when setting
> +		the signing key.  When written, the bytes should correspond to the KEK
> +		certificate (x509 .DER format containing an OU).  The size of the certificate
> +		must be less than or equal to 4095 bytes.
> +
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'sk' Signature Key is a write-only file that can be used to configure the RSA
> +		public key that will be used by the BIOS to verify signatures when configuring
> +		BIOS settings and security features.  When written, the bytes should correspond
> +		to the modulus of the public key.  The exponent is assumed to be 0x10001.
> +
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/status
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'status' is a read-only file that returns ASCII text reporting
> +		the status information.
> +
> +		  State:  Not Provisioned / Provisioned / Provisioning in progress
> +		  Version:  Major.   Minor
> +		  Feature Bit Mask: <16-bit unsigned number display in hex>

How are these bits to be interpreted?

> +		  SPM Counter: <16-bit unsigned number display in base 10>
> +		  Signing Key Public Key Modulus (base64):
> +		  KEK Public Key Modulus (base64):

Is " (base64)" supposed to be part of the contents of the file?

> +
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/statusbin
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'statusbin' is a read-only file that returns identical status
> +		information reported by 'status' file in binary format.

This documentation should contain enough information to understand the
files contents.


I understand that one WMI call will return all the fields that are part
of the "status" and "statusbin" in one response.

Are these WMI calls especially expensive or called especially
frequently?

If not I would still argue to split them into one file per field and
remove the statusbin file.

It is much more intuitive to read for example the KEK from the file
"kek" where it is also updated from.

This interface will be used by various applications and it is much
easier to read simple files than having to parse single fields from
bespoke text or binary files.

Thomas
