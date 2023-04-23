Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A976EBF48
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjDWMQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDWMQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:16:45 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF458E7C;
        Sun, 23 Apr 2023 05:16:43 -0700 (PDT)
Date:   Sun, 23 Apr 2023 14:16:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682252202; bh=obaanwlCRiXi/G+btpPuwebs1bQipaMyoYVeq/4gcT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLmsif0ZSEter8BnEKJvXzZO3eTC1oTUCNPDIXp7soW/d1M+mPIf7P2rzwiCoWTCv
         avISZvRCeS1Epmecmv1YdgMv+97NeRlo8FO951rGFVBOHAnKY1vAH4pD5P6Aiyt1tr
         xypVaCH65voqq36bKoUJYDz0YeMTE47lpPq9Xqd8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 12/14] HP BIOSCFG driver - surestart-attributes
Message-ID: <cf54c6f4-d177-4904-82ee-9d33566fb920@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-13-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420165454.9517-13-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 11:54:52-0500, Jorge Lopez wrote:
>  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> new file mode 100644
> index 000000000000..72952758ffe3
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to sure start object type attributes under
> + * BIOS for use with hp-bioscfg driver
> + *
> + *  Copyright (c) 2022 HP Development Company, L.P.
> + */
> +
> +#include "bioscfg.h"
> +#include <asm-generic/posix_types.h>

Is the asm include needed?
If yes, why not use linux/types.h?

> +
> +#define LOG_MAX_ENTRIES		254

A comment on how this values came to be would be good.

> +#define LOG_ENTRY_SIZE		16
> +
> +/*
> + * audit_log_entry_count_show - Reports the number of
> + *				existing audit log entries available
> + *				to be read
> + */
> +static ssize_t audit_log_entry_count_show(struct kobject *kobj,
> +					  struct kobj_attribute *attr, char *buf)
> +{
> +	int ret;
> +	u32 count = 0;
> +
> +	ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> +				   HPWMI_SURESTART,
> +				   &count, 1, sizeof(count));
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d,%d,%d\n", count, LOG_ENTRY_SIZE,
> +			  LOG_MAX_ENTRIES);
> +}
> +
> +/*
> + * audit_log_entries_show() - Return all entries found in log file
> + */
> +static ssize_t audit_log_entries_show(struct kobject *kobj,
> +				      struct kobj_attribute *attr, char *buf)
> +{
> +	int ret;
> +	int i;
> +	u32 count = 0;
> +
> +	// Get the number of event logs
> +	ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> +				   HPWMI_SURESTART,
> +				   &count, 1, sizeof(count));
> +
> +	/*
> +	 * The show() api will not work if the audit logs ever go
> +	 *  beyond 4KB
> +	 */
> +	if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
> +		return -EFAULT;

The error code seems not to match.

Instead of not returning any data, why not show as many results as
possible?

> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * We are guaranteed the buffer is 4KB so today all the event
> +	 * logs will fit
> +	 */
> +
> +	for (i = 0; ((i < count) & (ret >= 0)); i++) {

&&

Better yet, pull the condition ret >= 0 into the body, as an else-branch
for the existing check.

> +		*buf = (i + 1);

Isn't this directly overwritten by the query below?

> +		ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
> +					   HPWMI_SURESTART,
> +					   buf, 1, 128);
> +		if (ret >= 0)
> +			buf += LOG_ENTRY_SIZE;

So 128 bytes are read but only the first 16 bytes are preserved?

The documentation says that each entry has 128 bytes in the file.
And that they are separated by ";", which is not implemented.

Can the audit-log not contain all-zero bytes?
If it does this would need to be a bin_attribute.

> +	}
> +
> +	return (count * LOG_ENTRY_SIZE);

No need for braces.

> +}
> +
> +static struct kobj_attribute sure_start_audit_log_entry_count = __ATTR_RO(audit_log_entry_count);
> +static struct kobj_attribute sure_start_audit_log_entries = __ATTR_RO(audit_log_entries);
> +
> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "sure-start\n");
> +}
> +static struct kobj_attribute sure_start_type = __ATTR_RO(type);
> +
> +static ssize_t display_name_language_code_show(struct kobject *kobj,
> +					       struct kobj_attribute *attr,
> +					       char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", LANG_CODE_STR);
> +}
> +
> +static struct kobj_attribute sure_start_display_langcode =
> +		__ATTR_RO(display_name_language_code);
> +
> +
> +static ssize_t display_name_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", SURE_START_DESC);
> +}
> +static struct kobj_attribute sure_start_display_name = __ATTR_RO(display_name);
> +
> +static struct attribute *sure_start_attrs[] = {
> +	&sure_start_display_name.attr,
> +	&sure_start_display_langcode.attr,
> +	&sure_start_audit_log_entry_count.attr,
> +	&sure_start_audit_log_entries.attr,
> +	&sure_start_type.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sure_start_attr_group = {
> +	.attrs = sure_start_attrs,
> +};
> +
> +void exit_sure_start_attributes(void)
> +{
> +	sysfs_remove_group(bioscfg_drv.sure_start_attr_kobj,
> +			   &sure_start_attr_group);
> +}
> +
> +int populate_sure_start_data(struct kobject *attr_name_kobj)
> +{
> +	bioscfg_drv.sure_start_attr_kobj = attr_name_kobj;
> +	return sysfs_create_group(attr_name_kobj, &sure_start_attr_group);
> +}
> -- 
> 2.34.1
> 
