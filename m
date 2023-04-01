Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558016D30A0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjDAL7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:59:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF9524AF5;
        Sat,  1 Apr 2023 04:59:34 -0700 (PDT)
Date:   Sat, 1 Apr 2023 11:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1680350336; bh=9I2h0vymyOExIaDcWrmr56LidA9U/E8lgQAP62ltD/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baTRzmmfkf1lI3dS3ODKuLgs5rR3tIHRfS47sqUmmWbe1yhs0vU99JRnzO3dWQf8a
         SZ6KsGuWpcNcPd4ug7TfndguxeELD0mnIzE5eXTuMLzcbZOuW9LCUlbEkKuUnpXQV/
         iD2tZpo1P9iDahJafUlrpvd3uE966rZfs5iUJLF0=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] Introduction of HP-BIOSCFG driver [4]
Message-ID: <6da33dcc-0526-4398-bf35-655b64d07e20@t-8ch.de>
References: <20230309201022.9502-1-jorge.lopez2@hp.com>
 <20230309201022.9502-5-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309201022.9502-5-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

Hans asked me to do a review of your series, so this is it.

I'll start with patch 4 because it is the one with the docs and build
system changes.
Reviews of the other patches and the code of this patch will follow.

In my opinion the best way forward is to drop some of the non-core
and duplicated functionality.
The reduced scope will make review and rework easier and therefore speed
up the process.

Please also Cc the general kernel mailing list
linux-kernel@vger.kernel.org for future revisions.
This will make sure the patchset is picked up and tested by the bots.

On 2023-03-09 14:10:22-0600, Jorge Lopez wrote:
> The purpose for this patch is submit HP BIOSCFG driver to be list of
> HP Linux kernel drivers.  The driver include a total of 12 files
> broken in several patches.

No need for this paragraph.

> HP BIOS Configuration driver purpose is to provide a driver supporting
> the latest sysfs class firmware attributes framework allowing the user
> to change BIOS settings and security solutions on HP Inc.’s commercial
> notebooks.

Here it says "notebooks", below "PC's". Does it also support
non-notebook machines?

> Many features of HP Commercial PC’s can be managed using Windows
> Management Instrumentation (WMI). WMI is an implementation of Web-Based
> Enterprise Management (WBEM) that provides a standards-based interface
> for changing and monitoring system settings.  HP BISOCFG driver provides
> a native Linux solution and the exposed features facilitates the
> migration to Linux environments.
> 
> The Linux security features to be provided in hp-bioscfg driver enables
> managing the BIOS settings and security solutions via sysfs, a virtual
> filesystem that can be used by user-mode applications.   The new
> documentation cover features such Secure Platform Management, Sure
> Admin, and Sure Start.  Each section provides security feature
> description and identifies sysfs directories and files exposed by
> the driver.
> 
> Many HP Commercial PC’s include a feature called Secure Platform
> Management (SPM), which replaces older password-based BIOS settings
> management with public key cryptography. PC secure product management
> begins when a target system is provisioned with cryptographic keys
> that are used to ensure the integrity of communications between system
> management utilities and the BIOS.
> 
> HP Commercial PC’s have several BIOS settings that control its behaviour
> and capabilities, many of which are related to security. To prevent
> unauthorized changes to these settings, the system can be configured
> to use a Sure Admin cryptographic signature-based authorization string
> that the BIOS will use to verify authorization to modify the setting.
> 
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> 
> ---
> Based on the latest platform-drivers-x86.git/for-next
> 
> History
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
>  .../testing/sysfs-class-firmware-attributes   | 107 ++++++-
>  MAINTAINERS                                   |   6 +
>  drivers/platform/x86/hp/hp-bioscfg/Makefile   |  13 +
>  .../x86/hp/hp-bioscfg/biosattr-interface.c    | 303 ++++++++++++++++++
>  .../x86/hp/hp-bioscfg/passwdattr-interface.c  |  51 +++
>  5 files changed, 479 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index 4cdba3477176..d1ae6b77da13 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -22,6 +22,13 @@ Description:
>  			- integer: a range of numerical values
>  			- string
>  
> +		HP specific types
> +		-----------------
> +			- ordered-list - a set of ordered list valid values
> +			- sure-admin

Does sure-admin still exist?

> +			- sure-start
> +
> +
>  		All attribute types support the following values:
>  
>  		current_value:
> @@ -126,6 +133,38 @@ Description:
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
> +					hightest priority. Writing the list in a different order to
> +					current_value alters the priority order for the particular
> +					attribute.
> +
> +		"sure-start"-type specific properties:
> +
> +		audit_log_entries:
> +					A read-only file that returns the events in the log.
> +
> +					Audit log entry format
> +
> +					Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
> +					Byte 16-127: Unused
> +
> +		audit_log_entry_count:
> +					A read-only file that returns the number of existing audit log events available to be read.
> +
> +					[No of entries],[log entry size],[Max number of entries supported]

sysfs is based on the idea of "one-value-per-file".
The two properties above violate this idea.
Maybe a different interface is needed.

Are these properties very important for the first version of this
driver? If not I would propose to drop them for now and resubmit them
as separate patches after the main driver has been merged.

> +
> +
>  What:		/sys/class/firmware-attributes/*/authentication/
>  Date:		February 2021
>  KernelVersion:	5.11
> @@ -206,7 +245,7 @@ Description:
>  		Drivers may emit a CHANGE uevent when a password is set or unset
>  		userspace may check it again.
>  
> -		On Dell and Lenovo systems, if Admin password is set, then all BIOS attributes
> +		On Dell, Lenovo, and HP systems, if Admin password is set, then all BIOS attributes

No comma after "Lenovo".

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
> @@ -364,3 +412,60 @@ Description:
>  		use it to enable extra debug attributes or BIOS features for testing purposes.
>  
>  		Note that any changes to this attribute requires a reboot for changes to take effect.
> +
> +
> +		HP specific class extensions
> +		--------------------------------
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'kek' is a write-only file that can be used to configure the
> +		RSA public key that will be used by the BIOS to verify
> +		signatures when setting the signing key.  When written,
> +		the bytes should correspond to the KEK certificate
> +		(x509 .DER format containing an OU).  The size of the
> +		certificate must be less than or equal to 4095 bytes.
> +
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'sk' is a write-only file that can be used to configure the RSA
> +		public key that will be used by the BIOS to verify signatures
> +		when configuring BIOS settings and security features.  When
> +		written, the bytes should correspond to the modulus of the
> +		public key.  The exponent is assumed to be 0x10001.

The names of the files 'SPM', 'kek' and 'sk' are cryptic.

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
> +		  SPM Counter: <16-bit unsigned number display in base 10>
> +		  Signing Key Public Key Modulus (base64):
> +		  KEK Public Key Modulus (base64):

This also violates 'one-value-per-file'.
Can it be split into different files?
This would also remove the need for the statusbin file.

For the values:

Status: I think symbolic names are better for sysfs:
        not_provisioned, provisioned, etc.
Feature Bit Mask: Use names.
Keys: It would be nicer if these could be shown directly in the files
      that can be used to configure them.

As before, what is really needed and what can be added later?

> +
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/statusbin
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'statusbin' is a read-only file that returns identical status
> +		information reported by 'status' file in binary format.

How does this binary format work?

> +
> +
> +What:		/sys/class/firmware-attributes/*/attributes/last_error
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'last_error' is a read-only file that returns WMI error number
> +		and message reported by last WMI command.

Does this provide much value?
Or could this error just be logged via pr_warn_ratelimited()?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index f32538373164..663ae73fb8be 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9367,6 +9367,12 @@ S:	Obsolete
>  W:	http://w1.fi/hostap-driver.html
>  F:	drivers/net/wireless/intersil/hostap/
>  
> +HP BIOSCFG DRIVER
> +M:	Jorge Lopez <jorge.lopez2@hp.com>
> +L:      platform-driver-x86@vger.kernel.org

Broken whitespace

> +S:	Maintained
> +F:	drivers/platform/x86/hp/hp-bioscfg/
> +
>  HP COMPAQ TC1100 TABLET WMI EXTRAS DRIVER
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/Makefile b/drivers/platform/x86/hp/hp-bioscfg/Makefile
> new file mode 100644
> index 000000000000..529eba6fa47f
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/Makefile
> @@ -0,0 +1,13 @@
> +obj-$(CONFIG_HP_BIOSCFG) := hp-bioscfg.o

The kbuild part that defines CONFIG_HP_BIOSCFG is missing, so this is
never built.

drivers/platform/x86/hp/Makefile also needs to reference this Makefile.

After fixing up Kbuild please build the driver with "make W=1" and clean
up all the unused functions/variables.
(This won't catch unused stuff from bioscfg.c, so you have to check
these manually)

> +
> +hp-bioscfg-objs := bioscfg.o	\
> +	enum-attributes.o	\
> +	int-attributes.o	\
> +	string-attributes.o	\
> +	passwdobj-attributes.o	\
> +	biosattr-interface.o	\
> +	passwdattr-interface.o	\
> +	ordered-attributes.o	\
> +	surestart-attributes.o	\
> +	spmobj-attributes.o
> +

> [..] unreviewed code here.
