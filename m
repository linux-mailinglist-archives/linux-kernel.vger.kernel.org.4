Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6874A6F8A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjEEVLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjEEVLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:11:17 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C16F46B7;
        Fri,  5 May 2023 14:11:14 -0700 (PDT)
Date:   Fri, 5 May 2023 23:11:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683321072; bh=9K6Xo+2FAJY+HhScMhfLDUV2iVPLGTOgwshlRYpJtn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLgyEs4ht/xCZ7IBeqZlcbhJpk7ww/UkEz1CVQ4/B0snE7Wg+z97dD1Vv9jCVS8ao
         J5bARIl3v/453B8nuPvbGBw3JF5xqXHUGvE/3Rerr4odYyNeWHGcXgVMM9dn7lBOP2
         MRr3YDQ6eF4Hv6nG11aMNKBE8iVE4xgjlJqxKGGA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 05/14] HP BIOSCFG driver - ordered-attributes
Message-ID: <34539db1-98a4-4696-934b-af04d74720cc@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-6-jorge.lopez2@hp.com>
 <24fb56f9-49c6-432d-8c2f-17df7f7e37b2@t-8ch.de>
 <CAOOmCE-HR205R2vjyZedDocZLwvMdk7B1w7w9HgdXaypTrBK+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE-HR205R2vjyZedDocZLwvMdk7B1w7w9HgdXaypTrBK+A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 11:09:55-0500, Jorge Lopez wrote:
> On Sun, Apr 23, 2023 at 1:55 AM <thomas@t-8ch.de> wrote:
> >
> > On 2023-04-20 11:54:45-0500, Jorge Lopez wrote:
> > >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 563 ++++++++++++++++++
> > >  1 file changed, 563 insertions(+)
> > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > >
> > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > new file mode 100644
> > > index 000000000000..5e5d540f728d
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > @@ -0,0 +1,563 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Functions corresponding to ordered list type attributes under
> > > + * BIOS ORDERED LIST GUID for use with hp-bioscfg driver.
> > > + *
> > > + *  Copyright (c) 2022 HP Development Company, L.P.
> > > + */
> > > +
> > > +#include "bioscfg.h"
> > > +
> > > +GET_INSTANCE_ID(ordered_list);
> > > +
> > > +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> > > +{
> > > +
> > > +     int instance_id = get_ordered_list_instance_id(kobj);
> > > +
> > > +     if (instance_id < 0)
> > > +             return -EIO;
> > > +
> > > +     return sysfs_emit(buf, "%s\n",
> > > +                      bioscfg_drv.ordered_list_data[instance_id].current_value);
> > > +}
> > > +
> > > +/*
> > > + * validate_ordered_list_value -
> > > + * Validate input of current_value against possible values
> >
> > Does the firmware not also validate this?
> >
> > If so it may be easier to just let it do so and remove the validations
> > from the driver.
> 
> Yes.  the firmware validates the data.
> Will remove the validation
> >
> > > + *
> > > + * @instance_id: The instance on which input is validated
> > > + * @buf: Input value
> > > + */
> > > +static int validate_ordered_list_values(int instance_id, const char *buf)
> > > +{
> > > +     int ret = 0;
> > > +     int found = 0;
> > > +     char *new_values = NULL;
> > > +     char *value;
> > > +     int elem;
> > > +     int elem_found = 0;
> > > +
> > > +     /* Is it a read only attribute */
> > > +     if (bioscfg_drv.ordered_list_data[instance_id].common.is_readonly)
> > > +             return -EIO;
> > > +
> > > +     new_values = kstrdup(buf, GFP_KERNEL);
> > > +
> > > +     /*
> > > +      * Changes to ordered list values require checking that new
> > > +      * values are found in the list of elements.
> > > +      */
> > > +     elem_found = 0;
> > > +     while (elem_found < bioscfg_drv.ordered_list_data[instance_id].elements_size) {
> > > +
> > > +             value = strsep(&new_values, ",");
> >
> > The docs say the separator is semicolon.
> 
> BIOS reports the current value using ',' as separator instead of ";".
> 
> ./hp-bioscfg/attributes/UEFI Boot Order/current_value
> HDD:M.2:3,HDD:USB:1(Disabled),HDD:M.2:4,HDD:M.2:1,HDD:M.2:2,NETWORK
> IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK
> IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1
> 
> To avoid having to convert from "," to ";" and vice versa, I will
> update the documentation to reflect the use of  "'," commas as the
> separator

The enum data format uses ";". Therefore it makes sense to also stick to
";".
The implementation detail of the BIOS using ',' should not matter to
users.

> > > +             if (value != NULL) {
> > > +                     if (!*value)
> > > +                             continue;
> > > +                     elem_found++;
> > > +             }
> > > +
> > > +             found = 0;
> > > +             for (elem = 0; elem < bioscfg_drv.ordered_list_data[instance_id].elements_size; elem++) {
> > > +                     if (!strcasecmp(bioscfg_drv.ordered_list_data[instance_id].elements[elem], value)) {
> >
> > It's surprising that this is case-insensitive.
> 
> As validated in earlier reviews,  BIOS rejects strings that do not
> match the internal values.
> 
> >
> > > +                             found = 1;
> > > +                             break;
> > > +                     }
> > > +             }
> > > +
> > > +
> > > +             if (!found) {
> > > +                     ret = -EINVAL;
> > > +                     goto out_list_value;
> > > +             }
> > > +     }
> > > +
> > > +     if (elem_found == bioscfg_drv.ordered_list_data[instance_id].elements_size) {
> > > +             pr_warn("Number of new values is not equal to number of ordered list elements (%d)\n",
> > > +                     bioscfg_drv.ordered_list_data[instance_id].elements_size);
> > > +             ret = -EINVAL;
> > > +             goto out_list_value;
> > > +     }
> > > +
> > > +out_list_value:
> > > +     kfree(new_values);
> > > +     return ret;
> > > +}
> >
> > This algorithm does not seem to validate that different values are
> > provided.
> >
> > So if "possible_values" is "foo,bar,baz" this function would accept
> > "foo,foo,foo".
> >
> 
> BIOS will reject strings such as "foo,foo,foo" when the current value
> is "foo,bar,baz".   It is ok to provide a string which items are
> ordered differently.  i.e. "baz,bar,foo"
> validate_ordered_list_values() function will be removed as indicated earlier.
> 
> > > +
> > > +/*
> > > + * validate_ordered_input() -
> > > + * Validate input of current_value against possible values
> > > + *
> > > + * @instance_id: The instance on which input is validated
> > > + * @buf: Input value
> > > + */
> > > +static int validate_ordered_list_input(int instance_id, const char *buf)
> > > +{
> > > +     int ret = 0;
> > > +
> > > +     ret = validate_ordered_list_values(instance_id, buf);
> > > +     if (ret < 0)
> > > +             return -EINVAL;
> > > +
> > > +     /*
> > > +      * set pending reboot flag depending on
> > > +      * "RequiresPhysicalPresence" value
> > > +      */
> > > +     if (bioscfg_drv.ordered_list_data[instance_id].common.requires_physical_presence)
> > > +             bioscfg_drv.pending_reboot = true;
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void update_ordered_list_value(int instance_id, char *attr_value)
> > > +{
> > > +     strscpy(bioscfg_drv.ordered_list_data[instance_id].current_value,
> > > +             attr_value,
> > > +             sizeof(bioscfg_drv.ordered_list_data[instance_id].current_value));
> > > +}
> > > +
> > > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, ordered_list);
> > > +static struct kobj_attribute ordered_list_display_langcode =
> > > +     __ATTR_RO(display_name_language_code);
> > > +
> > > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, ordered_list);
> > > +static struct kobj_attribute ordered_list_display_name =
> > > +     __ATTR_RO(display_name);
> > > +
> > > +ATTRIBUTE_PROPERTY_STORE(current_value, ordered_list);
> > > +static struct kobj_attribute ordered_list_current_val =
> > > +     __ATTR_RW_MODE(current_value, 0644);
> > > +
> > > +
> > > +ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, ordered_list);
> > > +static struct kobj_attribute  ordered_list_prerequisites_size_val =
> > > +     __ATTR_RO(prerequisites_size);
> > > +
> > > +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, ordered_list);
> > > +static struct kobj_attribute  ordered_list_prerequisites_val =
> > > +     __ATTR_RO(prerequisites);
> > > +
> > > +ATTRIBUTE_N_PROPERTY_SHOW(elements_size, ordered_list);
> > > +static struct kobj_attribute  ordered_list_elements_size_val =
> > > +     __ATTR_RO(elements_size);
> >
> > "size" and "length" attributes are fairly useless to userspace.
> > They can't be trusted to provide information about another attribute as
> > the information can be out of date when the other attribute is read.
> >
> 
> Prerequisites, prerequisites_size and elements_size will be removed
> 
> > > +
> > > +ATTRIBUTE_VALUES_PROPERTY_SHOW(elements, ordered_list);
> > > +static struct kobj_attribute  ordered_list_elements_val =
> > > +     __ATTR_RO(elements);
> > > +
> 
> <snip>
> 
> > > +
> > > +
> > > +int populate_ordered_list_elements_from_package(union acpi_object *order_obj,
> > > +                                             int order_obj_count,
> > > +                                             int instance_id)
> > > +{
> > > +     char *str_value = NULL;
> > > +     int value_len;
> > > +     int ret = 0;
> > > +     u32 size = 0;
> > > +     u32 int_value;
> > > +     int elem = 0;
> > > +     int reqs;
> > > +     int eloc;
> > > +     char *tmpstr = NULL;
> > > +     char *part_tmp = NULL;
> > > +     int tmp_len = 0;
> > > +     char *part = NULL;
> > > +
> > > +     if (!order_obj)
> > > +             return -EINVAL;
> > > +
> > > +     strscpy(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code,
> > > +             LANG_CODE_STR,
> > > +             sizeof(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code));
> >
> > This seems to be the same for every type. Can it not be moved into
> > common code?
> 
> Each instance requires to report 'display_name_language_code' hence it
> cannot be moved to a common code.

Can it every be different from LANG_CODE_STR?

If not instead of having one kobj_attribute diplay_langcode for each
string/enum/integer/etc you could have one kobj_attribute defined in
bioscfg.c and then added to each string_attrs, enum_attrs...

The _show() callback for this attribute would just return the constant
string.

This removes the need for many attribute definition, members in the data
struct, initialization of these member...
