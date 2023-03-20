Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7A6C190B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjCTPaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjCTP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:29:09 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58F2103;
        Mon, 20 Mar 2023 08:22:16 -0700 (PDT)
Date:   Mon, 20 Mar 2023 15:22:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679325731;
        bh=dDG2JtIile5x6NxbgOI2fXE3QmL+bkySLTnSTWsfbIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOLmAaEGNMZFLXdU8dkmaqTHJYZohe/u6D6i574mlQEpE+EI3Oab3uxIAbdwtKxFV
         VsJlx8eJ4/O9BwKVJkriJLLxYFi/KaWuhkZEaB4tEAsI6I56jEctXHepXKaEvzwUB2
         lDLOpRusxem/tyna4hT2WDlhzReyqLzTqxyR4M/A=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     hdegoede@redhat.com, markgross@kernel.org, markpearson@lenovo.com,
        pobrn@protonmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 2/4] platform/x86: think-lmi: use correct
 possible_values delimiters
Message-ID: <3df8ca69-e2a4-49d1-9c5c-8e6ff8bb0f96@t-8ch.de>
References: <mpearson-lenovo@squebb.ca>
 <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
 <20230320003221.561750-2-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320003221.561750-2-mpearson-lenovo@squebb.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for the series!
For all of it:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

If you decide to reroll it, one more nitpick below.

On Sun, Mar 19, 2023 at 08:32:19PM -0400, Mark Pearson wrote:
> firmware-attributes class requires that possible values are delimited
> using ';' but the Lenovo firmware uses ',' instead.
> Parse string and replace where appropriate.
> 
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v4
>  - Moved earlier in the series as recommended
>  - used strreplace function as recommended
> Changes in v3: 
>  - New patch added to the series. No v1 & v2.
> 
>  drivers/platform/x86/think-lmi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index a765bf8c27d8..53f34b1adb8c 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -954,7 +954,7 @@ static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  	if (setting->possible_values) {
>  		/* Figure out what setting type is as BIOS does not return this */
> -		if (strchr(setting->possible_values, ','))
> +		if (strchr(setting->possible_values, ';'))
>  			return sysfs_emit(buf, "enumeration\n");

If you make this patch the first on of the series it would
* make the hunk above unnecessary.
* make it easier to backport if somebody wants do do so.
* make the then second patch easier to read as it would not introduce
  "incorrect" code that needs a fix-up in the following commit.

>  	}
>  	/* Anything else is going to be a string */
> @@ -1413,6 +1413,13 @@ static int tlmi_analyze(void)
>  				pr_info("Error retrieving possible values for %d : %s\n",
>  						i, setting->display_name);
>  		}
> +		/*
> +		 * firmware-attributes requires that possible_values are separated by ';' but
> +		 * Lenovo FW uses ','. Replace appropriately.
> +		 */
> +		if (setting->possible_values)
> +			strreplace(setting->possible_values, ',', ';');
> +
>  		kobject_init(&setting->kobj, &tlmi_attr_setting_ktype);
>  		tlmi_priv.setting[i] = setting;
>  		kfree(item);
> -- 
> 2.39.2
> 
