Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77CA6F779E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjEDVAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEDVAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:00:20 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8593FE;
        Thu,  4 May 2023 14:00:03 -0700 (PDT)
Date:   Thu, 4 May 2023 22:59:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683233998; bh=ruqYEKXRNGS9PZw7L4ZE2k6BitP4uC8r7qrWbLRFwxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPLjwUQ440aBCZFZPIipvGoCHOVMD/pYUD3irZdNQ81TA/Ij9bOr/KqpC9LapkjVL
         /LhdAe2A28B9q42TwpME5ptYo2FoVIvLnGYW3jHZOMGeTh6UqgZ75pVkxEDngbZNkG
         0si/niitg2NchQ+xEJycBZ2bUIf8Lvg/r02qav0M=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 06/14] HP BIOSCFG driver - passwdobj-attributes
Message-ID: <9bbf8cb3-6333-4742-b32a-c7e9118bc618@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-7-jorge.lopez2@hp.com>
 <016a9a6a-cff1-444d-b96a-63eded1ac58a@t-8ch.de>
 <CAOOmCE9USvpih7E6cq7sKiMmGJa_FV74g36kb6EZMSrkg5BnLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE9USvpih7E6cq7sKiMmGJa_FV74g36kb6EZMSrkg5BnLg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 15:29:21-0500, Jorge Lopez wrote:
> On Sun, Apr 23, 2023 at 4:07 AM <thomas@t-8ch.de> wrote:
> >
> > On 2023-04-20 11:54:46-0500, Jorge Lopez wrote:
> > > ---
> > >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 669 ++++++++++++++++++
> > >  1 file changed, 669 insertions(+)
> > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > >
> > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > > new file mode 100644
> > > index 000000000000..c03b3a71e9c4
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > > @@ -0,0 +1,669 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> 
> <snip>
> 
> > > +int validate_password_input(int instance_id, const char *buf)
> > > +{
> > > +     int length;
> > > +
> > > +     length = strlen(buf);
> > > +     if (buf[length-1] == '\n')
> > > +             length--;
> > > +
> > > +     if (length > MAX_PASSWD_SIZE)
> > > +             return INVALID_BIOS_AUTH;
> > > +
> > > +     if (bioscfg_drv.password_data[instance_id].min_password_length > length ||
> > > +         bioscfg_drv.password_data[instance_id].max_password_length < length)
> > > +             return INVALID_BIOS_AUTH;
> > > +     return SUCCESS;
> > > +}
> > > +
> > > +int password_is_set(const char *name)
> >
> > bool is_password_set(const char *name)
> 
> Function is invoked nowhere.  It will be removed.
> >
> > > +{
> > > +     int id;
> > > +
> > > +     id = get_password_instance_for_type(name);
> > > +     if (id < 0)
> > > +             return 0;
> > > +
> > > +     return bioscfg_drv.password_data[id].is_enabled;
> > > +}
> > > +
> > > +ATTRIBUTE_N_PROPERTY_SHOW(is_enabled, password);
> > > +static struct kobj_attribute password_is_password_set = __ATTR_RO(is_enabled);
> > > +
> > > +static ssize_t current_password_store(struct kobject *kobj,
> > > +                                   struct kobj_attribute *attr,
> > > +                                   const char *buf, size_t count)
> > > +{
> > > +     char *p, *buf_cp;
> > > +     int id, ret = 0;
> > > +
> > > +     buf_cp = kstrdup(buf, GFP_KERNEL);
> > > +     if (!buf_cp) {
> > > +             ret = -ENOMEM;
> > > +             goto exit_password;
> > > +     }
> > > +
> > > +     p = memchr(buf_cp, '\n', count);
> > > +
> > > +     if (p != NULL)
> > > +             *p = '\0';
> >
> > This will also accept input like "foo\nbar" and truncate away the "bar".
> >
> > For something like a password it seems errorprone to try to munge the
> > value.
> 
> This is an expected behavior.  If the user enters '\n' as part of the
> password, the buffer data will be truncated since only one line per
> sysfs file is permitted.

As discussed in another patch this would silently truncate the input on
the first newline character; even if it is not the last character of the
input string.

This should use the same helper as the other files to only strip a
newline at the end of the input.

> >
> > > +
> > > +     id = get_password_instance_id(kobj);
> > > +
> > > +     if (id >= 0)
> > > +             ret = validate_password_input(id, buf_cp);
> > > +
> > > +     if (!ret) {
> > > +             strscpy(bioscfg_drv.password_data[id].current_password,
> > > +                     buf_cp,
> > > +                     sizeof(bioscfg_drv.password_data[id].current_password));
> > > +             /*
> > > +              * set pending reboot flag depending on
> > > +              * "RequiresPhysicalPresence" value
> > > +              */
> > > +             if (bioscfg_drv.password_data[id].common.requires_physical_presence)
> > > +                     bioscfg_drv.pending_reboot = true;
> >
> > Just setting this to true does not emit the necessary KOBJ_CHANGE event
> > on the class dev kobj which is necessary for userspace to be able to
> > react.
> 
> This feature was added outside of the original design specification to
> be used at a later time.
> Changes to the value to true does not emit a KOBJ_CHANGE event.

This contradicts the documentation: 

	A read-only attribute reads 1 if a reboot is necessary to apply
	pending BIOS attribute changes. Also, an uevent_KOBJ_CHANGE is
	generated when it changes to 1.

This will confuse userspace, there are generic userspace applications
waiting for those events.
If there is a reason for not emitting them it should be good and
documented.

Also according to the docs the authentication attributes should
KOBJ_CHANGE events. I think this also affects this driver and should be
implemented.

> >
> > > +     }
> > > +
> > > +exit_password:
> > > +     kfree(buf_cp);
> > > +     return ret ? ret : count;
> > > +}
> > > +static struct kobj_attribute password_current_password = __ATTR_WO(current_password);
> > > +
> > > +static ssize_t new_password_store(struct kobject *kobj,
> > > +                               struct kobj_attribute *attr,
> > > +                               const char *buf, size_t count)
> > > +{
> > > +     char *p, *buf_cp = NULL;
> > > +     int id = 0;
> > > +     int ret = -EIO;
> > > +
> > > +     buf_cp = kstrdup(buf, GFP_KERNEL);
> > > +     if (!buf_cp) {
> > > +             ret = -ENOMEM;
> > > +             goto exit_password;
> > > +     }
> > > +
> > > +     p = memchr(buf_cp, '\n', count);
> > > +
> > > +     if (p != NULL)
> > > +             *p = '\0';
> >
> > Same as above.
> 
> This is an expected behavior.  If the user enters '\n' as part of the
> password, the buffer data will be truncated since only one line per
> sysfs file is permitted.

If a user accidentally presses enter before entering a password this
may set the password to the empty string; surprising.

This should really use the helper.

> >
> > > +
> > > +     id = get_password_instance_id(kobj);
> > > +
> > > +     if (id >= 0)
> > > +             ret = validate_password_input(id, buf_cp);
> > > +
> > > +     if (!ret)
> > > +             strscpy(bioscfg_drv.password_data[id].new_password,
> > > +                     buf_cp,
> > > +                     sizeof(bioscfg_drv.password_data[id].new_password));
> > > +
> > > +     if (!ret)
> > > +             ret = hp_set_attribute(kobj->name, buf_cp);
> > > +
> > > +exit_password:
> > > +     /*
> > > +      * Regardless of the results both new and current passwords
> > > +      * will be set to zero and avoid security issues
> > > +      */
> > > +     clear_passwords(id);
> > > +
> > > +     kfree(buf_cp);
> > > +     return ret ? ret : count;
> > > +}
> > > +
> > > +static struct kobj_attribute password_new_password = __ATTR_WO(new_password);
> > > +
> > > +
> > > +ATTRIBUTE_N_PROPERTY_SHOW(min_password_length, password);
> > > +static struct kobj_attribute password_min_password_length = __ATTR_RO(min_password_length);
> > > +
> > > +ATTRIBUTE_N_PROPERTY_SHOW(max_password_length, password);
> > > +static struct kobj_attribute password_max_password_length = __ATTR_RO(max_password_length);
> > > +
> > > +static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
> > > +                      char *buf)
> > > +{
> > > +     if (strcmp(kobj->name, SETUP_PASSWD) == 0)
> > > +             return sysfs_emit(buf, "%s\n", BIOS_ADMIN);
> > > +
> > > +     if (strcmp(kobj->name, POWER_ON_PASSWD) == 0)
> > > +             return sysfs_emit(buf,  "%s\n", POWER_ON);
> > > +
> > > +     return -EIO;
> > > +}
> > > +static struct kobj_attribute password_role = __ATTR_RO(role);
> > > +
> > > +static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
> > > +                        char *buf)
> > > +{
> > > +     int i = get_password_instance_id(kobj);
> > > +
> > > +     if (i < 0)
> > > +             return i;
> > > +
> > > +     if (bioscfg_drv.password_data[i].mechanism != PASSWORD)
> > > +             return -EINVAL;
> > > +
> > > +     return sysfs_emit(buf, "%s\n", PASSWD_MECHANISM_TYPES);
> > > +}
> > > +static struct kobj_attribute password_mechanism = __ATTR_RO(mechanism);
> > > +
> > > +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> > > +                      char *buf)
> > > +{
> > > +     return sysfs_emit(buf, "password\n");
> > > +}
> > > +static struct kobj_attribute password_type = __ATTR_RO(type);
> > > +
> > > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, password);
> > > +static struct kobj_attribute password_display_name =
> > > +             __ATTR_RO(display_name);
> > > +
> > > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, password);
> > > +static struct kobj_attribute password_display_langcode =
> > > +             __ATTR_RO(display_name_language_code);
> > > +
> > > +ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, password);
> > > +static struct kobj_attribute  password_prerequisites_size_val =
> > > +             __ATTR_RO(prerequisites_size);
> > > +
> > > +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, password);
> > > +static struct kobj_attribute  password_prerequisites_val =
> > > +             __ATTR_RO(prerequisites);
> > > +
> > > +ATTRIBUTE_N_PROPERTY_SHOW(encodings_size, password);
> > > +static struct kobj_attribute  password_encodings_size_val =
> > > +             __ATTR_RO(encodings_size);
> >
> > As before, these size attribute are fairly pointless for userspace as
> > they can't be relied on.
> 
> I will remove the attribute from being reported in sysfs but they will
> be kept as part of the driver internal data
> 
> >
> > > +
> > > +ATTRIBUTE_VALUES_PROPERTY_SHOW(encodings, password);
> > > +static struct kobj_attribute  password_encodings_val =
> > > +             __ATTR_RO(encodings);
> > > +
> > > +
> > > +static struct attribute *password_attrs[] = {
> > > +     &password_is_password_set.attr,
> > > +     &password_min_password_length.attr,
> > > +     &password_max_password_length.attr,
> > > +     &password_current_password.attr,
> > > +     &password_new_password.attr,
> > > +     &password_role.attr,
> > > +     &password_mechanism.attr,
> > > +     &password_type.attr,
> > > +     &password_display_name.attr,
> > > +     &password_display_langcode.attr,
> > > +     &password_prerequisites_size_val.attr,
> > > +     &password_prerequisites_val.attr,
> > > +     &password_encodings_val.attr,
> > > +     &password_encodings_size_val.attr,
> > > +     NULL
> > > +};
> >
> > Many of these attributes are not documented.
> 
> Those attributes are documented under authentication section, lines 150-329
> 
> What: /sys/class/firmware-attributes/*/authentication/
> Date: February 2021
> KernelVersion: 5.11
> Contact: Divya Bharathi <Divya.Bharathi@Dell.com>,
> Prasanth KSR <prasanth.ksr@dell.com>
> Dell.Client.Kernel@dell.com
> Description:
> Devices support various authentication mechanisms which can be exposed
> as a separate configuration object.

If I read that correctly the authentication attributes are not "normal"
attributes.
So they don't need "type", "display_name", "display_langcode".

Do they need prerequisites?

> 
> 
> >
> > > +
> > > +static const struct attribute_group bios_password_attr_group = {
> > > +     .attrs = password_attrs
> > > +};
> > > +
> > > +static const struct attribute_group system_password_attr_group = {
> > > +     .attrs = password_attrs
> > > +};
> >
> > These groups are the same, are both needed?
> 
> Yes.  They will show under  'Setup Password' and 'Power-on password'

These are identical constant structures. It should be possible to have
only one and use it for both usecases.

<snip>
