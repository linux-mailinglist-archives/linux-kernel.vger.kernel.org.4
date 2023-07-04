Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7F8746F03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGDKoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGDKoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E03184
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688467391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEFf8IweK/2NTi+/cPDtasQ38LRXnMtCi68paJV591U=;
        b=VrHgUe9qDDMZ0xMIU80+2KgrtOcw4CAEoOKHKCaV6Qy9e4zJiotwxE651O934fauKEbwv/
        gm4Xl46He18T3kSDz5Ue+ogyF/IO2dyIYhla7vL4uAL6HlA2wrQO+604SeQ+I4oZTy3EjA
        OLTL8T4M5NmkcehBQTY81FMLPL1ouiU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-HdYPT_zVN9-0KIdpitpaaw-1; Tue, 04 Jul 2023 06:43:10 -0400
X-MC-Unique: HdYPT_zVN9-0KIdpitpaaw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-977e6c94186so388378266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 03:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688467389; x=1691059389;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEFf8IweK/2NTi+/cPDtasQ38LRXnMtCi68paJV591U=;
        b=RsvDKU8mOw+cFlz9zWwbHo9LnBhvyNazXM1CNgl17SPy0/iWMifR0CyEF56sBP0ZEE
         pquVJRfSuaboTWWGxeyLXvWV6mybX2MR02abBjB8E40pvEzmxCrk1dRD5AYOVNn1jSOf
         sxDoi0RO2+HCDCzIbzLN5wxGi6dln5/o1mi9wq7ayO4FCJJmyd2/bAEiVWY68mdH0po7
         zT6kf73uElbLPmdsB7m7KE5NCIaXKZBL4IX/mIIRBgLU34tNpACqJUoSH58lk4BJ65MY
         htTZEzUdNSPkG0gC2yTJpU1wESqGZ6PeijlEhioacA1Vzn/VeNRFfGZ3CPgLBJ2w3j76
         uH3w==
X-Gm-Message-State: ABy/qLZua8xA84WV1D66UdgidYwDtaFPCu4uwdkGTf2E6FpCUpbgmOrQ
        pmhDWUI9q7IW4I7RR36L4ub2Y9xWP3E+1/XSolxKeQmvZmdzxEo8VV568LrQXLLjUNK4XmgoxoN
        M9X8bMJqOBFH5ckPdeFwqsJlaB4xlXRny
X-Received: by 2002:a17:907:984b:b0:982:bb95:5014 with SMTP id jj11-20020a170907984b00b00982bb955014mr9792145ejc.64.1688467388932;
        Tue, 04 Jul 2023 03:43:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fVEL8UBsxh8FbxtmFvWQZ5aAW+mNYUK+xcV12Cr84Wh0/RXihkwsEDaVE/W2Y4q5IYOH7Mw==
X-Received: by 2002:a17:907:984b:b0:982:bb95:5014 with SMTP id jj11-20020a170907984b00b00982bb955014mr9792131ejc.64.1688467388547;
        Tue, 04 Jul 2023 03:43:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b0096a6be0b66dsm13101770ejb.208.2023.07.04.03.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 03:43:08 -0700 (PDT)
Message-ID: <43369522-5e39-a90c-5263-cd4eacba3e24@redhat.com>
Date:   Tue, 4 Jul 2023 12:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v17 00/13] hp-bioscfg driver
Content-Language: en-US, nl
To:     Jorge Lopez <jorgealtxwork@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com
References: <20230608163319.18934-1-jorge.lopez2@hp.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230608163319.18934-1-jorge.lopez2@hp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/8/23 18:33, Jorge Lopez wrote:
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
> documentation cover HP-specific firmware sysfs attributes such Secure
> Platform Management and Sure Start. Each section provides security
> feature description and identifies sysfs directories and files exposed
> by the driver.
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
> To prevent unauthorized changes to these settings, the system can
> be configured to use a cryptographic signature-based authorization
> string that the BIOS will use to verify authorization to modify the
> setting.
> 
> Linux Security components are under development and not published yet.
> The only linux component is the driver (hp bioscfg) at this time.
> Other published security components are under Windows.
> 
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Patches which are added to review-hans now are intended for
the next kernel cycle. This branch will get rebased to the next
rc1 when it is out and after the rebasing the contents of review-hans
will be pushed to the platform-drivers-x86/for-next branch.

Regards,

Hans


> 
> ---
> Based on the latest platform-drivers-x86.git/for-next
> 
> History
> 
> Version 17
> 	Only patches marked [update] changed between version 17 and 16
> 	Added helper routine to handle all common data for all attributes.
> 	Corrected spaces found prior and after a '"'.
>         Update commit message to reflect comments from reviewers
>        
> 
> 	Patches
> 	 Documentation                  [update]
> 	 biosattr-interface
> 	 bioscfg 			[update]
> 	 bioscfg-h 			[update]
> 	 enum-attributes 		[update]
> 	 int-attributes 		[update]
> 	 order-list-attributes 		[update]
> 	 passwdattr-interface           [update]
> 	 spmobj-attributes
> 	 string-attributes 		[update]
> 	 surestart-attributes
> 	 Makefile ../hp/Makefile ../hp/Kconfig 
> 	 MAINTAINERS
> 
> Version 16
> 	Only patches marked [update] changed between version 16 and 15
> 
> 	Patches
> 	 Documentation
> 	 biosattr-interface
> 	 bioscfg 			[update]
> 	 bioscfg-h 			[update]
> 	 enum-attributes 		[update]
> 	 int-attributes 		[update]
> 	 order-list-attributes 		[update]
> 	 passwdattr-interface
> 	 spmobj-attributes
> 	 string-attributes 		[update]
> 	 surestart-attributes
> 	 Makefile ../hp/Makefile ../hp/Kconfig 
> 	 MAINTAINERS
> 
> 
> Version 15
> 	Only patches marked [update] changed between version 15 and 14
> 
> 	Patches
> 	 Documentation			[update]
> 	 biosattr-interface
> 	 bioscfg
> 	 bioscfg-h
> 	 enum-attributes
> 	 int-attributes
> 	 order-list-attributes
> 	 passwdattr-interface
> 	 spmobj-attributes		[update]
> 	 string-attributes
> 	 surestart-attributes 
> 	 Makefile ../hp/Makefile ../hp/Kconfig 
> 	 MAINTAINERS
> 
> Version 14
> 	Only patches marked [update] changed between version 14 and 13
> 	Sorted commit patches alphabetically
> 	Rename ordered-attributes to order-list-attributes
> 
> 	Patches
> 	 Documentation
> 	 biosattr-interface 		[update]
> 	 bioscfg
> 	 bioscfg-h
> 	 enum-attributes 		[update]
> 	 int-attributes
> 	 order-list-attributes
> 	 passwdattr-interface
> 	 spmobj-attributes
> 	 string-attributes
> 	 surestart-attributes 
> 	 Makefile ../hp/Makefile ../hp/Kconfig 
> 	 MAINTAINERS
> 
> 
> Version 13
> 	Only patches marked [update] changed between version 12 and 13
> 	Sorted commit patches alphabetically
> 	Rename ordered-attributes to order-list-attributes
> 
> 	Patches
> 	 Documentation 			[update]
> 	 biosattr-interface 		[update]
> 	 bioscfg 			[update]
> 	 bioscfg-h 			[update]
> 	 enum-attributes 		[update]
> 	 int-attributes 		[update]
> 	 order-list-attributes 		[update]
> 	 passwdattr-interface 		[update]
> 	 spmobj-attributes 		[update]
> 	 string-attributes 		[update]
> 	 surestart-attributes 		[update] 
> 	 Makefile ../hp/Makefile ../hp/Kconfig 
> 	 MAINTAINERS
> 
> Version 12
> 	Only patches marked [update] changed between version 11 and 12
> 
> 	Patches
> 	 Documentation 			[update]
> 	 biosattr-interface 		[update]
> 	 bioscfg 			[update]
> 	 int-attributes 		[update]
> 	 ordered-attributes 		[update]
> 	 passwdobj-attributes 	[deleted]
> 	 string-attributes 		[update]
> 	 bioscfg-h 			[update]
> 	 enum-attributes 		[update]
> 	 passwdattr-interface 		[update]
> 	 spmobj-attributes 		[update]
> 	 surestart-attributes 		[update] 
> 	 Makefile ../hp/Makefile ../hp/Kconfig [update]
> 	 MAINTAINERS
> 
> 
> Version 11
> 	Only patches marked [update] changed between version 10 and 11
> 
> 	Patches
> 	 Documentation
> 	 biosattr-interface 		[update]
> 	 bioscfg
> 	 int-attributes
> 	 ordered-attributes
> 	 passwdobj-attributes 		[update]
> 	 string-attributes
> 	 bioscfg-h
> 	 enum-attributes
> 	 passwdattr-interface
> 	 spmobj-attributes 		[update]
> 	 surestart-attributes 		[update]
> 	 Makefile ../hp/Makefile ../hp/Kconfig
> 	 MAINTAINERS
> 
> Version 10
> 	Break down changes to single files per patch
> 	Removed SPM/statusbin support
> 	Patches
> 	 Documentation
> 	 biosattr-interface
> 	 bioscfg
> 	 int-attributes
> 	 ordered-attributes
> 	 passwdobj-attributes
> 	 string-attributes
> 	 bioscfg-h
> 	 enum-attributes
> 	 passwdattr-interface
> 	 spmobj-attributes
> 	 surestart-attributes
> 	 Makefile ../hp/Makefile ../hp/Kconfig
> 	 MAINTAINERS
> 
> Version 9
> 	Includes only sysfs-class-firmware-attributes documentation
> 
> Version 8
> 	Includes only sysfs-class-firmware-attributes documentation
> 
> Version 7
> 	Includes only sysfs-class-firmware-attributes documentation
> 
> 
> Jorge Lopez (13):
>   hp-bioscfg: Documentation
>   hp-bioscfg: bioscfg-h
>   hp-bioscfg: bioscfg
>   hp-bioscfg: biosattr-interface
>   hp-bioscfg: enum-attributes
>   hp-bioscfg: int-attributes
>   hp-bioscfg: order-list-attributes
>   hp-bioscfg: passwdobj-attributes
>   hp-bioscfg: spmobj-attributes
>   hp-bioscfg: string-attributes
>   hp-bioscfg: surestart-attributes
>   hp-bioscfg: Makefile
>   hp-bioscfg: MAINTAINERS
> 
>  .../testing/sysfs-class-firmware-attributes   |  101 +-
>  MAINTAINERS                                   |    6 +
>  drivers/platform/x86/hp/Kconfig               |   16 +
>  drivers/platform/x86/hp/Makefile              |    1 +
>  drivers/platform/x86/hp/hp-bioscfg/Makefile   |   11 +
>  .../x86/hp/hp-bioscfg/biosattr-interface.c    |  312 +++++
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 1055 +++++++++++++++++
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  |  487 ++++++++
>  .../x86/hp/hp-bioscfg/enum-attributes.c       |  447 +++++++
>  .../x86/hp/hp-bioscfg/int-attributes.c        |  409 +++++++
>  .../x86/hp/hp-bioscfg/order-list-attributes.c |  436 +++++++
>  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  |  543 +++++++++
>  .../x86/hp/hp-bioscfg/spmobj-attributes.c     |  386 ++++++
>  .../x86/hp/hp-bioscfg/string-attributes.c     |  390 ++++++
>  .../x86/hp/hp-bioscfg/surestart-attributes.c  |  132 +++
>  15 files changed, 4730 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> 

