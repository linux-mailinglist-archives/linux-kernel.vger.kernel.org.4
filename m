Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5316EBE48
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDWJY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 05:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDWJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 05:24:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3E7210E;
        Sun, 23 Apr 2023 02:24:48 -0700 (PDT)
Date:   Sun, 23 Apr 2023 11:24:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682241887; bh=oWYrW7qOnCTjq6uD4REoiwSsZs5csK+OrUHzTZVNrBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7i6IzAJ7jspk4OzHT4F7f30uEGVnW6cI1FhgvAGwN7NgNxFqEwrjH5pnC6BJBlNS
         ERJutapH4qiLkkj25j06VaWPLSU0HEYJPs+97QaiBL7Sw14S4M/FsdQYrRqBu6QKzG
         40ixW2v7JwahDTDTvqwxmL6WkbLDLXLKlWD7tQF8=
From:   thomas@t-8ch.de
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 11/14] HP BIOSCFG driver - spmobj-attributes
Message-ID: <7364268c-cbff-42a3-a79a-069eef31899e@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-12-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420165454.9517-12-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 11:54:51-0500, Jorge Lopez wrote:
>  .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 405 ++++++++++++++++++
>  1 file changed, 405 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> new file mode 100644
> index 000000000000..78228f44c39b
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> @@ -0,0 +1,405 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to secure platform management object type
> + * attributes under BIOS PASSWORD for use with hp-bioscfg driver
> + *
> + *  Copyright (c) 2022 HP Development Company, L.P.
> + */
> +
> +#include "bioscfg.h"
> +
> +
> +static const char * const spm_state_types[] = {
> +	"not provisioned",
> +	"provisioned",
> +	"provisioning in progress"
> +};
> +
> +static const char * const spm_mechanism_types[] = {
> +	"not provision",

"not provisioned" as above?

> +	"signing-key",
> +	"endorsement-key"

Trailing commas please.

> +};
> +
> +
> +int check_spm_is_enabled(void)
> +{
> +	/* do we need to check the admin password is also configured */
> +	return bioscfg_drv.spm_data.is_enabled;
> +}
> +
> +/*
> + * calculate_security_buffer() - determines size of security buffer
> + * for authentication scheme
> + *
> + * @authentication: the authentication content
> + *
> + * Currently only supported type is Admin password
> + */
> +size_t calculate_security_buffer(const char *authentication)
> +{
> +	int size;
> +
> +	if (authentication != NULL && strlen(authentication) > 0) {
> +
> +		size = (sizeof(u16) + (strlen(authentication) * sizeof(u16)));
> +		if (strncmp(authentication, BEAM_PREFIX, strlen(BEAM_PREFIX)) != 0)

strstarts()

> +			size += (strlen(UTF_PREFIX) * sizeof(u16));

No need for braces.

> +
> +		return size;
> +	}
> +
> +	size  = sizeof(u16) * 2;
> +	return size;
> +}
> +
> +/*
> + * populate_security_buffer() - builds a security buffer for
> + * authentication scheme
> + *
> + * @buffer: the buffer to populate
> + * @authentication: the authentication content
> + *
> + * Currently only supported type is PLAIN TEXT
> + */
> +void populate_security_buffer(u16 *buffer, const char *authentication)
> +{
> +	u16 *auth = buffer;
> +	char *strprefix = NULL;
> +
> +	if (strncmp(authentication, BEAM_PREFIX, strlen(BEAM_PREFIX)) == 0) {

strstarts()

> +		/*
> +		 * BEAM_PREFIX is append to buffer when a signature
> +		 * is provided and Sure Admin is enabled in BIOS
> +		 */
> +		// BEAM_PREFIX found, convert part to unicode
> +		auth = ascii_to_utf16_unicode(auth, authentication);
> +	} else {
> +		/*
> +		 * UTF-16 prefix is append to the * buffer when a BIOS
> +		 * admin password is configured in BIOS
> +		 */
> +
> +		// append UTF_PREFIX to part and then convert it to unicode
> +		strprefix = kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
> +				      authentication);
> +		if (!strprefix)
> +			goto out_buffer;
> +
> +		auth = ascii_to_utf16_unicode(auth, strprefix);
> +	}
> +out_buffer:
> +
> +	kfree(strprefix);
> +}
> +
> +ssize_t update_spm_state(void)
> +{
> +	int ret;
> +	struct secureplatform_provisioning_data *data = NULL;

This can be allocated on the stack.

> +
> +	data = kmalloc(sizeof(struct secureplatform_provisioning_data),
> +		       GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto state_exit;
> +	}
> +
> +	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
> +				   HPWMI_SECUREPLATFORM, data, 0,
> +				   sizeof(*data));
> +	if (ret < 0)
> +		goto state_exit;
> +
> +	bioscfg_drv.spm_data.mechanism = data->state;
> +	if (bioscfg_drv.spm_data.mechanism)
> +		bioscfg_drv.spm_data.is_enabled = 1;
> +
> +state_exit:
> +	kfree(data);
> +
> +	return ret;
> +}
> +
> +ssize_t statusbin(struct kobject *kobj,
> +		  struct kobj_attribute *attr, char *buf)

This can be static.

If it is known that a struct secureplatform_provisioning_data is to be
passed, then the type can reflect that.

> +{
> +	int ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
> +				       HPWMI_SECUREPLATFORM, buf, 0,
> +				       sizeof(struct secureplatform_provisioning_data));
> +
> +	return ret ? -ENODEV : sizeof(struct secureplatform_provisioning_data);

Why not return "ret" on error?

> +}
> +
> +/*
> + * status_show - Reads SPM status
> + */
> +ssize_t status_show(struct kobject *kobj, struct kobj_attribute
> +		    *attr, char *buf)
> +{
> +	int ret, i;
> +	struct secureplatform_provisioning_data *data = NULL;

Can also be on-stack.

> +
> +	data = kmalloc(sizeof(struct secureplatform_provisioning_data),
> +		       GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto status_exit;
> +	}
> +
> +	ret = statusbin(kobj, attr, (char *)data);
> +	if (ret < 0)
> +		goto status_exit;
> +
> +	sysfs_emit(buf, "%s{\n", buf);
> +	sysfs_emit(buf, "%s\t\"State\": \"%s\",\n", buf,
> +		   spm_state_types[data->state]);
> +	sysfs_emit(buf, "%s\t\"Version\": \"%d.%d\",\n", buf, data->version[0],
> +		   data->version[1]);
> +
> +	/*
> +	 * state == 0 means secure platform management
> +	 * feature is not configured in BIOS.
> +	 */
> +	if (data->state == 0)
> +		goto status_exit;
> +
> +	sysfs_emit(buf, "%s\t\"Nonce\": %d,\n", buf, data->nonce);
> +	sysfs_emit(buf, "%s\t\"FeaturesInUse\": %d,\n", buf, data->features);
> +	sysfs_emit(buf, "%s\t\"EndorsementKeyMod\": \"", buf);
> +
> +	for (i = 255; i >= 0; i--)
> +		sysfs_emit(buf, "%s %u", buf, data->kek_mod[i]);
> +
> +	sysfs_emit(buf, "%s \",\n", buf);
> +	sysfs_emit(buf, "%s\t\"SigningKeyMod\": \"", buf);
> +
> +	for (i = 255; i >= 0; i--)
> +		sysfs_emit(buf, "%s %u", buf, data->sk_mod[i]);
> +
> +	/* Return buf contents */
> +
> +	sysfs_emit(buf, "%s \"\n", buf);
> +	sysfs_emit(buf, "%s}\n", buf);
> +
> +status_exit:
> +	kfree(data);
> +
> +	return strnlen(buf, PAGE_SIZE);
> +}
> +
> +static struct kobj_attribute password_spm_status = __ATTR_RO(status);
> +
> +ATTRIBUTE_SPM_N_PROPERTY_SHOW(is_enabled, spm);
> +static struct kobj_attribute password_spm_is_key_enabled = __ATTR_RO(is_enabled);
> +
> +
> +static ssize_t key_mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				  char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n",
> +			  spm_mechanism_types[bioscfg_drv.spm_data.mechanism]);
> +}
> +static struct kobj_attribute password_spm_key_mechanism = __ATTR_RO(key_mechanism);
> +
> +static ssize_t sk_store(struct kobject *kobj,
> +			struct kobj_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	int ret;
> +	int length;
> +
> +	length = count;
> +	if (buf[length-1] == '\n')
> +		length--;
> +
> +	/* allocate space and copy current signing key */
> +	bioscfg_drv.spm_data.signing_key = kmalloc(length, GFP_KERNEL);
> +	if (!bioscfg_drv.spm_data.signing_key) {
> +		ret = -ENOMEM;
> +		goto exit_sk;
> +	}
> +
> +	memcpy(bioscfg_drv.spm_data.signing_key, buf, length);
> +	bioscfg_drv.spm_data.signing_key[length] = '\0';

Is this supposed to handle zero-bytes in the input?
If yes: Did you test this with zero bytes, I don't think the normal
attribute APIs handle this.
If no: Why not use strscpy?

> +
> +	/* submit signing key payload */
> +	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_SK,
> +				   HPWMI_SECUREPLATFORM,
> +				   (void *)bioscfg_drv.spm_data.signing_key,
> +				   length, 0);
> +
> +	if (!ret) {
> +		bioscfg_drv.spm_data.mechanism = SIGNING_KEY;
> +		bioscfg_drv.pending_reboot = true;
> +	}
> +
> +exit_sk:
> +	kfree(bioscfg_drv.spm_data.signing_key);
> +	bioscfg_drv.spm_data.signing_key = NULL;
> +
> +	return ret ? ret : count;
> +}
> +
> +static struct kobj_attribute password_spm_signing_key = __ATTR_WO(sk);
> +
> +static ssize_t kek_store(struct kobject *kobj,
> +			 struct kobj_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	int ret;
> +	int length;
> +
> +	length = count;
> +	if (buf[length-1] == '\n')
> +		length--;
> +
> +	/* allocate space and copy current signing key */
> +	bioscfg_drv.spm_data.endorsement_key = kmalloc(length, GFP_KERNEL);
> +	if (!bioscfg_drv.spm_data.endorsement_key) {
> +		ret = -ENOMEM;
> +		goto exit_kek;
> +	}
> +
> +	memcpy(bioscfg_drv.spm_data.endorsement_key, buf, length);
> +	bioscfg_drv.spm_data.endorsement_key[length] = '\0';
> +
> +	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_KEK,
> +				   HPWMI_SECUREPLATFORM,
> +				   (void *)bioscfg_drv.spm_data.endorsement_key,
> +				   count, 0);
> +
> +	if (!ret) {
> +		bioscfg_drv.spm_data.mechanism = ENDORSEMENT_KEY;
> +		bioscfg_drv.pending_reboot = true;
> +	}
> +
> +exit_kek:
> +	kfree(bioscfg_drv.spm_data.endorsement_key);
> +	bioscfg_drv.spm_data.endorsement_key = NULL;
> +
> +	return ret ? ret : count;
> +}
> +static struct kobj_attribute password_spm_endorsement_key = __ATTR_WO(kek);
> +
> +static ssize_t display_name_language_code_show(struct kobject *kobj,
> +					       struct kobj_attribute *attr,
> +					       char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", LANG_CODE_STR);
> +}
> +
> +static struct kobj_attribute password_spm_display_langcode =
> +	__ATTR_RO(display_name_language_code);
> +
> +
> +static ssize_t display_name_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", SPM_STR_DESC);
> +}
> +static struct kobj_attribute password_spm_display_name = __ATTR_RO(display_name);
> +
> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "secure-platform-management\n");
> +}
> +static struct kobj_attribute password_spm_type = __ATTR_RO(type);
> +
> +static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", BIOS_SPM);
> +}
> +static struct kobj_attribute password_spm_role = __ATTR_RO(role);
> +
> +static ssize_t auth_token_store(struct kobject *kobj,
> +				struct kobj_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	int ret = 0;
> +	int length;
> +
> +	length = count;
> +	if (buf[length-1] == '\n')
> +		length--;
> +
> +	/* allocate space and copy current auth token */
> +	bioscfg_drv.spm_data.auth_token = kmalloc(count, GFP_KERNEL);
> +	if (!bioscfg_drv.spm_data.auth_token) {
> +		ret = -ENOMEM;
> +		goto exit_token;
> +	}
> +
> +	memcpy(bioscfg_drv.spm_data.auth_token, buf, count);
> +	bioscfg_drv.spm_data.auth_token[length] = '\0';
> +	return count;
> +
> +
> +exit_token:
> +	kfree(bioscfg_drv.spm_data.auth_token);
> +	bioscfg_drv.spm_data.auth_token = NULL;
> +
> +	return ret;
> +
> +}
> +static struct kobj_attribute password_spm_auth_token = __ATTR_WO(auth_token);
> +
> +static struct attribute *secure_platform_attrs[] = {
> +	&password_spm_display_name.attr,
> +	&password_spm_display_langcode.attr,
> +	&password_spm_is_key_enabled.attr,
> +	&password_spm_signing_key.attr,
> +	&password_spm_endorsement_key.attr,
> +	&password_spm_key_mechanism.attr,
> +	&password_spm_status.attr,
> +	&password_spm_type.attr,
> +	&password_spm_role.attr,
> +	&password_spm_auth_token.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group secure_platform_attr_group = {
> +	.attrs = secure_platform_attrs,
> +};
> +
> +void exit_secure_platform_attributes(void)
> +{
> +	/* remove secure platform sysfs entry and free key data*/
> +
> +	kfree(bioscfg_drv.spm_data.endorsement_key);
> +	bioscfg_drv.spm_data.endorsement_key = NULL;
> +
> +	kfree(bioscfg_drv.spm_data.signing_key);
> +	bioscfg_drv.spm_data.signing_key = NULL;
> +
> +	kfree(bioscfg_drv.spm_data.auth_token);
> +	bioscfg_drv.spm_data.auth_token = NULL;
> +
> +	if (bioscfg_drv.spm_data.attr_name_kobj)
> +		sysfs_remove_group(bioscfg_drv.spm_data.attr_name_kobj,
> +				   &secure_platform_attr_group);
> +}
> +
> +int populate_secure_platform_data(struct kobject *attr_name_kobj)
> +{
> +	/* Populate data for Secure Platform Management */
> +	bioscfg_drv.spm_data.attr_name_kobj = attr_name_kobj;
> +
> +	strscpy(bioscfg_drv.spm_data.attribute_name, SPM_STR,
> +		sizeof(bioscfg_drv.spm_data.attribute_name));
> +	strscpy(bioscfg_drv.spm_data.display_name, SPM_STR_DESC,
> +		sizeof(bioscfg_drv.spm_data.display_name));
> +
> +	bioscfg_drv.spm_data.is_enabled = 0;
> +	bioscfg_drv.spm_data.mechanism = 0;
> +	bioscfg_drv.pending_reboot = false;
> +	update_spm_state();
> +
> +	bioscfg_drv.spm_data.endorsement_key = NULL;
> +	bioscfg_drv.spm_data.signing_key = NULL;
> +	bioscfg_drv.spm_data.auth_token = NULL;
> +
> +	return sysfs_create_group(attr_name_kobj, &secure_platform_attr_group);
> +}
> -- 
> 2.34.1
> 
