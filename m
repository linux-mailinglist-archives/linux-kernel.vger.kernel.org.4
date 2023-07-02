Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2787452FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 00:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGBWnH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Jul 2023 18:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGBWm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 18:42:57 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763F11B9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 15:42:56 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id CE8EA801E0;
        Sun,  2 Jul 2023 22:42:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id E83FA2E;
        Sun,  2 Jul 2023 22:42:50 +0000 (UTC)
Message-ID: <676aae2eb65d228796d6f18e86d261ed96540a87.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add old hwmon APIs to deprecated list
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 02 Jul 2023 15:42:49 -0700
In-Reply-To: <20230702211450.3789779-1-linux@roeck-us.net>
References: <20230702211450.3789779-1-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E83FA2E
X-Stat-Signature: bfeaq6gichdq81k7hu5k5oimpab7xfeg
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/sQuA5+nZy/pfq6uwytRuxrKRnezCVJsc=
X-HE-Tag: 1688337770-526317
X-HE-Meta: U2FsdGVkX1/3Qxn72CVdm3HS4t8RNpgLWezkUt+V2uq9C7bSpmDtJmyCEC+N+THnCCSdQCuLVGCMXfqDZWym8pzcMyyctlJ6HhrAmQPXuBRGklu9pHE/MXHITPxRNpADLFaaUPNv5iHPMRAc5NGk2RQf2d0gO6vWONwBlqc3rWNfu/WlAym7nGlawab0CPj1rEhHazx9UCJtfJ1p7BmCuNwWt6ITIAMJrGB1aHBN8QGMTDhmkFgRQOgUvhBupaGOI2Nyhgjg7hxza6X72xpaJdLRQ+psvEWYlV+jc4bA8ehFr/6pP4RLN2GiqwH+ZucEs1grCyGty1IUASOx7E7iIQCn/Cv6reeElitF3kOrTwTJYC3JQRsq1q5+OTV16e9x
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-07-02 at 14:14 -0700, Guenter Roeck wrote:
> hwmon_device_register() and [devm_]hwmon_device_register_with_groups()
> have been deprecated. All hardware monitoring drivers should use
> [devm_]hwmon_device_register_with_info() instead.
> 
> The problem with the old API functions is that they require sysfs attribute
> handling in driver code. The new API handles sysfs attributes in the
> hwmon core. Using the new API typically reduces driver code size by 20-40%.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Seems sensible, thanks.

But how big an effort is it to convert all the existing uses
and remove the code?  There are less than 200 uses.

Perhaps it's not that onerous.
Is it something that coccinelle could do reasonably well?

$ git grep -w hwmon_device_register | wc -l
49

$ git grep -w hwmon_device_register_with_groups | wc -l
22

$ git grep -w devm_hwmon_device_register_with_groups | wc -l
108

> ---..
>  scripts/checkpatch.pl | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7bfa4d39d17f..6d97f1a6028e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -842,6 +842,9 @@ our %deprecated_apis = (
>  	"kunmap"				=> "kunmap_local",
>  	"kmap_atomic"				=> "kmap_local_page",
>  	"kunmap_atomic"				=> "kunmap_local",
> +	"hwmon_device_register"			=> "hwmon_device_register_with_info",
> +	"hwmon_device_register_with_groups"	=> "hwmon_device_register_with_info",
> +	"devm_hwmon_device_register_with_groups"=> "devm_hwmon_device_register_with_info",
>  );
>  
>  #Create a search pattern for all these strings to speed up a loop below

