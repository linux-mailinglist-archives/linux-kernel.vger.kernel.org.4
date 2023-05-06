Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0F6F8EC0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 07:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEFFvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 01:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEFFvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 01:51:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8883C9;
        Fri,  5 May 2023 22:51:15 -0700 (PDT)
Date:   Sat, 6 May 2023 07:51:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683352273; bh=UGjeWoNcTEu6bjLhkAAMXAwPdSa3fyu7dz5n787ajXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7jtBcYUpal4DCzeHiI6KPE8LzmIFF1wGItpLAHgc9TradZ2aEJctniZS1f8SpwBi
         hUwdJvDSiEQ5IQ/KDRcpquJLHow/jkz/T7QjBzYbR9+Z+qRLOr8/Zh/qRJh4zkzBt7
         BzsWZm5xf8pLzqG+2WhyjMA0pz4NHL5VTHsvLTSY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 05/14] HP BIOSCFG driver - ordered-attributes
Message-ID: <daf6a6e0-69cd-48a6-b61b-c893324323ff@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-6-jorge.lopez2@hp.com>
 <24fb56f9-49c6-432d-8c2f-17df7f7e37b2@t-8ch.de>
 <CAOOmCE-HR205R2vjyZedDocZLwvMdk7B1w7w9HgdXaypTrBK+A@mail.gmail.com>
 <34539db1-98a4-4696-934b-af04d74720cc@t-8ch.de>
 <CAOOmCE_9fmLKgum9hYxPpa_BrX0FyFFz_dRUX8sNm9T2EUABMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE_9fmLKgum9hYxPpa_BrX0FyFFz_dRUX8sNm9T2EUABMg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 16:57:59-0500, Jorge Lopez wrote:
> On Fri, May 5, 2023 at 4:11 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2023-05-05 11:09:55-0500, Jorge Lopez wrote:
> > > On Sun, Apr 23, 2023 at 1:55 AM <thomas@t-8ch.de> wrote:
> > > >
> > > > On 2023-04-20 11:54:45-0500, Jorge Lopez wrote:
> > > > >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 563 ++++++++++++++++++
> > > > >  1 file changed, 563 insertions(+)
> > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > > >
> > > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > > > new file mode 100644
> > > > > index 000000000000..5e5d540f728d
> > > > > --- /dev/null
> > > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > > > @@ -0,0 +1,563 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Functions corresponding to ordered list type attributes under
> > > > > + * BIOS ORDERED LIST GUID for use with hp-bioscfg driver.
> > > > > + *
> > > > > + *  Copyright (c) 2022 HP Development Company, L.P.
> > > > > + */
> > > > > +
> > > > > +#include "bioscfg.h"
> > > > > +
> > > > > +GET_INSTANCE_ID(ordered_list);
> > > > > +
> > > > > +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> > > > > +{
> > > > > +
> > > > > +     int instance_id = get_ordered_list_instance_id(kobj);
> > > > > +
> > > > > +     if (instance_id < 0)
> > > > > +             return -EIO;
> > > > > +
> > > > > +     return sysfs_emit(buf, "%s\n",
> > > > > +                      bioscfg_drv.ordered_list_data[instance_id].current_value);
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * validate_ordered_list_value -
> > > > > + * Validate input of current_value against possible values
> > > >
> > > > Does the firmware not also validate this?
> > > >
> > > > If so it may be easier to just let it do so and remove the validations
> > > > from the driver.
> > >
> > > Yes.  the firmware validates the data.
> > > Will remove the validation
> > > >
> > > > > + *
> > > > > + * @instance_id: The instance on which input is validated
> > > > > + * @buf: Input value
> > > > > + */
> > > > > +static int validate_ordered_list_values(int instance_id, const char *buf)
> > > > > +{
> > > > > +     int ret = 0;
> > > > > +     int found = 0;
> > > > > +     char *new_values = NULL;
> > > > > +     char *value;
> > > > > +     int elem;
> > > > > +     int elem_found = 0;
> > > > > +
> > > > > +     /* Is it a read only attribute */
> > > > > +     if (bioscfg_drv.ordered_list_data[instance_id].common.is_readonly)
> > > > > +             return -EIO;
> > > > > +
> > > > > +     new_values = kstrdup(buf, GFP_KERNEL);
> > > > > +
> > > > > +     /*
> > > > > +      * Changes to ordered list values require checking that new
> > > > > +      * values are found in the list of elements.
> > > > > +      */
> > > > > +     elem_found = 0;
> > > > > +     while (elem_found < bioscfg_drv.ordered_list_data[instance_id].elements_size) {
> > > > > +
> > > > > +             value = strsep(&new_values, ",");
> > > >
> > > > The docs say the separator is semicolon.
> > >
> > > BIOS reports the current value using ',' as separator instead of ";".
> > >
> > > ./hp-bioscfg/attributes/UEFI Boot Order/current_value
> > > HDD:M.2:3,HDD:USB:1(Disabled),HDD:M.2:4,HDD:M.2:1,HDD:M.2:2,NETWORK
> > > IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK
> > > IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1
> > >
> > > To avoid having to convert from "," to ";" and vice versa, I will
> > > update the documentation to reflect the use of  "'," commas as the
> > > separator
> >
> > The enum data format uses ";". Therefore it makes sense to also stick to
> > ";".
> > The implementation detail of the BIOS using ',' should not matter to
> > users.
> 
> The use of ',' does matter because BIOS expects the updated string to
> use commas as separators
> current_value is reported by BIOS using commas.  Any changes to the
> order of items in that string needs to use commas.
> 
> The difference with enum is the fact the user needs to  enter only one
> value out of those possible values available and no separators are
> needed.
> For ordered attributes...
> 
> when the current value  is "foo,bar,baz".   the user provides a string
> which items are ordered differently.  i.e. "baz,bar,foo"
> if the new string is using semicolon instead of comma for the
> separator, BIOS will reject the data.

Of course the BIOS expects the format with comma.

But the users of this API should not have to care about implementation
details like that.
They want a consistent API. As the ordered-list type is fairly general
it may be promoted to be a general attribute type later.

If this happens the API can't be changed as that would break users of
hp-bioscfg. So either there would be two APIs for the ordered-list, one
for hp-bioscfg and one for all other drivers, or different attribute
types would use different kinds of separators.

Was there an issue with the previous replacement logic?

The whole point of device drivers is to translate general kernel APIs
into whatever a specific device needs, switching around ',' and ';'
seems not so bad.

> > > > > +             if (value != NULL) {
> > > > > +                     if (!*value)
> > > > > +                             continue;
> > > > > +                     elem_found++;
> > > > > +             }
> > > > > +
> > > > > +             found = 0;
> > > > > +             for (elem = 0; elem < bioscfg_drv.ordered_list_data[instance_id].elements_size; elem++) {
> > > > > +                     if (!strcasecmp(bioscfg_drv.ordered_list_data[instance_id].elements[elem], value)) {
> > > >
> > > > It's surprising that this is case-insensitive.
> > >
> > > As validated in earlier reviews,  BIOS rejects strings that do not
> > > match the internal values.
> > >
> > > >
> > > > > +                             found = 1;
> > > > > +                             break;
> > > > > +                     }
> > > > > +             }
> > > > > +
> > > > > +
> > > > > +             if (!found) {
> > > > > +                     ret = -EINVAL;
> > > > > +                     goto out_list_value;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     if (elem_found == bioscfg_drv.ordered_list_data[instance_id].elements_size) {
> > > > > +             pr_warn("Number of new values is not equal to number of ordered list elements (%d)\n",
> > > > > +                     bioscfg_drv.ordered_list_data[instance_id].elements_size);
> > > > > +             ret = -EINVAL;
> > > > > +             goto out_list_value;
> > > > > +     }
> > > > > +
> > > > > +out_list_value:
> > > > > +     kfree(new_values);
> > > > > +     return ret;
> > > > > +}
> > > >
> > > > This algorithm does not seem to validate that different values are
> > > > provided.
> > > >
> > > > So if "possible_values" is "foo,bar,baz" this function would accept
> > > > "foo,foo,foo".
> > > >
> > >
> > > BIOS will reject strings such as "foo,foo,foo" when the current value
> > > is "foo,bar,baz".   It is ok to provide a string which items are
> > > ordered differently.  i.e. "baz,bar,foo"
> > > validate_ordered_list_values() function will be removed as indicated earlier.
> > >
> > > > > +
> > > > > +/*
> > > > > + * validate_ordered_input() -
> > > > > + * Validate input of current_value against possible values
> > > > > + *
> > > > > + * @instance_id: The instance on which input is validated
> > > > > + * @buf: Input value
> > > > > + */
> > > > > +static int validate_ordered_list_input(int instance_id, const char *buf)
> > > > > +{
> > > > > +     int ret = 0;
> > > > > +
> > > > > +     ret = validate_ordered_list_values(instance_id, buf);
> > > > > +     if (ret < 0)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     /*
> > > > > +      * set pending reboot flag depending on
> > > > > +      * "RequiresPhysicalPresence" value
> > > > > +      */
> > > > > +     if (bioscfg_drv.ordered_list_data[instance_id].common.requires_physical_presence)
> > > > > +             bioscfg_drv.pending_reboot = true;
> > > > > +
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static void update_ordered_list_value(int instance_id, char *attr_value)
> > > > > +{
> > > > > +     strscpy(bioscfg_drv.ordered_list_data[instance_id].current_value,
> > > > > +             attr_value,
> > > > > +             sizeof(bioscfg_drv.ordered_list_data[instance_id].current_value));
> > > > > +}
> > > > > +
> > > > > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, ordered_list);
> > > > > +static struct kobj_attribute ordered_list_display_langcode =
> > > > > +     __ATTR_RO(display_name_language_code);
> > > > > +
> > > > > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, ordered_list);
> > > > > +static struct kobj_attribute ordered_list_display_name =
> > > > > +     __ATTR_RO(display_name);
> > > > > +
> > > > > +ATTRIBUTE_PROPERTY_STORE(current_value, ordered_list);
> > > > > +static struct kobj_attribute ordered_list_current_val =
> > > > > +     __ATTR_RW_MODE(current_value, 0644);
> > > > > +
> > > > > +
> > > > > +ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, ordered_list);
> > > > > +static struct kobj_attribute  ordered_list_prerequisites_size_val =
> > > > > +     __ATTR_RO(prerequisites_size);
> > > > > +
> > > > > +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, ordered_list);
> > > > > +static struct kobj_attribute  ordered_list_prerequisites_val =
> > > > > +     __ATTR_RO(prerequisites);
> > > > > +
> > > > > +ATTRIBUTE_N_PROPERTY_SHOW(elements_size, ordered_list);
> > > > > +static struct kobj_attribute  ordered_list_elements_size_val =
> > > > > +     __ATTR_RO(elements_size);
> > > >
> > > > "size" and "length" attributes are fairly useless to userspace.
> > > > They can't be trusted to provide information about another attribute as
> > > > the information can be out of date when the other attribute is read.
> > > >
> > >
> > > Prerequisites, prerequisites_size and elements_size will be removed
> > >
> > > > > +
> > > > > +ATTRIBUTE_VALUES_PROPERTY_SHOW(elements, ordered_list);
> > > > > +static struct kobj_attribute  ordered_list_elements_val =
> > > > > +     __ATTR_RO(elements);
> > > > > +
> > >
> > > <snip>
> > >
> > > > > +
> > > > > +
> > > > > +int populate_ordered_list_elements_from_package(union acpi_object *order_obj,
> > > > > +                                             int order_obj_count,
> > > > > +                                             int instance_id)
> > > > > +{
> > > > > +     char *str_value = NULL;
> > > > > +     int value_len;
> > > > > +     int ret = 0;
> > > > > +     u32 size = 0;
> > > > > +     u32 int_value;
> > > > > +     int elem = 0;
> > > > > +     int reqs;
> > > > > +     int eloc;
> > > > > +     char *tmpstr = NULL;
> > > > > +     char *part_tmp = NULL;
> > > > > +     int tmp_len = 0;
> > > > > +     char *part = NULL;
> > > > > +
> > > > > +     if (!order_obj)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     strscpy(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code,
> > > > > +             LANG_CODE_STR,
> > > > > +             sizeof(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code));
> > > >
> > > > This seems to be the same for every type. Can it not be moved into
> > > > common code?
> > >
> > > Each instance requires to report 'display_name_language_code' hence it
> > > cannot be moved to a common code.
> >
> > Can it every be different from LANG_CODE_STR?
> 
> Yes.   The string currently is LANG_CODE_STR (en_US.UTF-8)  but it
> will change as the BIOS provides additional translations at a later
> time.
> This is a future enhancement for the driver.

Is this planned for the near future?
And/Or already implemented in the BIOS?

If there are no concrete plans to implement this soon, in my opinion,
it would be better to only introduce this code when it does something
useful.

> > If not instead of having one kobj_attribute diplay_langcode for each
> > string/enum/integer/etc you could have one kobj_attribute defined in
> > bioscfg.c and then added to each string_attrs, enum_attrs...
> >
> > The _show() callback for this attribute would just return the constant
> > string.
> >
> > This removes the need for many attribute definition, members in the data
> > struct, initialization of these member...
