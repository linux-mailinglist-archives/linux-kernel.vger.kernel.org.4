Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C093720E27
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 08:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjFCGfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 02:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjFCGfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 02:35:41 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D47E58;
        Fri,  2 Jun 2023 23:35:38 -0700 (PDT)
Date:   Sat, 3 Jun 2023 08:35:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685774136; bh=IvzyDvrX1HHtU1K9Qkr17qgkwFnZasbNrgKIibjiv1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQRZ8jJ/VZ4q6tPz3j6Z5UnZHvl7MdVYwcx0YUHEPa0g0b9KQc5J2fU90gpWbGjzF
         7HNBdtmrqYfh/ztrHVzmswZHy6YnQQWfFGq5hfPJkFGT9blcFKol/gwNeBfk/y0BxG
         XZXxIR6V5VTXn7ytACObGLRnEom9/ZkaiR9MARDg=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v15 05/13] hp-bioscfg: enum-attributes
Message-ID: <f53ddc7e-40d7-487d-9eff-1ee9fe2fcd9b@t-8ch.de>
References: <20230519201300.12964-1-jorge.lopez2@hp.com>
 <20230519201300.12964-6-jorge.lopez2@hp.com>
 <0cbd158e-0742-4e04-9996-bd376f9b555b@t-8ch.de>
 <CAOOmCE8=C_qH862G9sdLS59=QPh6U_78WY0SzJwzZfW+iSUiPA@mail.gmail.com>
 <dd9df9e7-9693-4ddc-8429-cc5e0567da17@t-8ch.de>
 <CAOOmCE_=LH9rcz4x=q-iq8sBhC4G7TtaU5M_R-ZLWwaJYNadSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE_=LH9rcz4x=q-iq8sBhC4G7TtaU5M_R-ZLWwaJYNadSw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-31 10:59:58-0500, Jorge Lopez wrote:
> On Tue, May 30, 2023 at 4:42 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2023-05-30 12:01:57-0500, Jorge Lopez wrote:
> > > On Fri, May 26, 2023 at 10:35 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > > >
> > > > On 2023-05-19 15:12:52-0500, Jorge Lopez wrote:
> > > >
> > > > <snip>
> > > >
> > > > >  .../x86/hp/hp-bioscfg/enum-attributes.c       | 465 ++++++++++++++++++
> > > > >  1 file changed, 465 insertions(+)
> > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > > > >
> > > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > > > > new file mode 100644
> > > > > index 000000000000..80842835606d
> > > > > --- /dev/null
> > > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > > > > @@ -0,0 +1,465 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Functions corresponding to enumeration type attributes under
> > > > > + * BIOS Enumeration GUID for use with hp-bioscfg driver.
> > > > > + *
> > > > > + * Copyright (c) 2022 HP Development Company, L.P.
> > > > > + */
> > > > > +
> > > > > +#include "bioscfg.h"
> > > > > +
> > > > > +GET_INSTANCE_ID(enumeration);
> > > > > +
> > > > > +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> > > > > +{
> > > > > +     int instance_id = get_enumeration_instance_id(kobj);
> > > > > +
> > > > > +     if (instance_id < 0)
> > > > > +             return -EIO;
> > > > > +
> > > > > +     return sysfs_emit(buf, "%s\n",
> > > > > +                      bioscfg_drv.enumeration_data[instance_id].current_value);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * validate_enumeration_input() -
> > > > > + * Validate input of current_value against possible values
> > > > > + *
> > > > > + * @instance_id: The instance on which input is validated
> > > > > + * @buf: Input value
> > > > > + */
> > >
> > > <snip>
> > >
> > > > > +static int hp_populate_enumeration_elements_from_package(union acpi_object *enum_obj,
> > > > > +                                                      int enum_obj_count,
> > > > > +                                                      int instance_id)
> > > > > +{
> > > > > +     char *str_value = NULL;
> > > > > +     int value_len;
> > > > > +     u32 size = 0;
> > > > > +     u32 int_value;
> > > > > +     int elem = 0;
> > > > > +     int reqs;
> > > > > +     int pos_values;
> > > > > +     int ret;
> > > > > +     int eloc;
> > > > > +     struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
> > > > > +
> > > > > +     for (elem = 1, eloc = 1; elem < enum_obj_count; elem++, eloc++) {
> > > > > +             /* ONLY look at the first ENUM_ELEM_CNT elements */
> > > > > +             if (eloc == ENUM_ELEM_CNT)
> > > > > +                     goto exit_enumeration_package;
> > > > > +
> > > > > +             switch (enum_obj[elem].type) {
> > > > > +             case ACPI_TYPE_STRING:
> > > > > +                     if (PREREQUISITES != elem && ENUM_POSSIBLE_VALUES != elem) {
> > > > > +                             ret = hp_convert_hexstr_to_str(enum_obj[elem].string.pointer,
> > > > > +                                                            enum_obj[elem].string.length,
> > > > > +                                                            &str_value, &value_len);
> > > > > +                             if (ret)
> > > > > +                                     return -EINVAL;
> > > > > +                     }
> > > > > +                     break;
> > > > > +             case ACPI_TYPE_INTEGER:
> > > > > +                     int_value = (u32)enum_obj[elem].integer.value;
> > > > > +                     break;
> > > > > +             default:
> > > > > +                     pr_warn("Unsupported object type [%d]\n", enum_obj[elem].type);
> > > > > +                     continue;
> > > > > +             }
> > > > > +
> > > > > +             /* Check that both expected and read object type match */
> > > > > +             if (expected_enum_types[eloc] != enum_obj[elem].type) {
> > > > > +                     pr_err("Error expected type %d for elem %d, but got type %d instead\n",
> > > > > +                            expected_enum_types[eloc], elem, enum_obj[elem].type);
> > > > > +                     return -EIO;
> > > > > +             }
> > > > > +
> > > > > +             /* Assign appropriate element value to corresponding field */
> > > > > +             switch (eloc) {
> > > > > +             case NAME:
> > > > > +             case VALUE:
> > > > > +                     break;
> > > > > +             case PATH:
> > > > > +                     strscpy(enum_data->common.path, str_value,
> > > > > +                             sizeof(enum_data->common.path));
> > > > > +                     break;
> > > > > +             case IS_READONLY:
> > > > > +                     enum_data->common.is_readonly = int_value;
> > > > > +                     break;
> > > > > +             case DISPLAY_IN_UI:
> > > > > +                     enum_data->common.display_in_ui = int_value;
> > > > > +                     break;
> > > > > +             case REQUIRES_PHYSICAL_PRESENCE:
> > > > > +                     enum_data->common.requires_physical_presence = int_value;
> > > > > +                     break;
> > > > > +             case SEQUENCE:
> > > > > +                     enum_data->common.sequence = int_value;
> > > > > +                     break;
> > > > > +             case PREREQUISITES_SIZE:
> > > > > +                     enum_data->common.prerequisites_size = int_value;
> > > > > +                     if (int_value > MAX_PREREQUISITES_SIZE)
> > > > > +                             pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> > > > > +
> > > > > +                     /*
> > > > > +                      * This HACK is needed to keep the expected
> > > > > +                      * element list pointing to the right obj[elem].type
> > > > > +                      * when the size is zero. PREREQUISITES
> > > > > +                      * object is omitted by BIOS when the size is
> > > > > +                      * zero.
> > > > > +                      */
> > > > > +                     if (int_value == 0)
> > > > > +                             eloc++;
> > > > > +                     break;
> > > > > +
> > > > > +             case PREREQUISITES:
> > > > > +                     size = min_t(u32, enum_data->common.prerequisites_size, MAX_PREREQUISITES_SIZE);
> > > >
> > > > We cannot blindly truncate this to a maximum value.
> > > > The firmware reported an amount of elements it would return.
> > > >
> > > > If this value is to big than we can not just intpret the data as if it
> > > > was something the firmware did not return.
> > > >
> > > > An error needs to be reported to userspace.
> > > > A default value is not enough as userspace can not interpret this
> > > > properly.
> > > >
> > >
> > > It is ok to truncate prerequisite size to MAX_PREREQUISITES_SIZE.
> > > MAX_PREREQUISITES_SIZE is a value predefined by BIOS when the
> > > prerequisite values size is invalid ( > MAX_PREREQUISITES_SIZE) and/or
> > > the prerequisite data is corrupted.
> > > Neither PREREQUISITES nor PREREQUISITES_SIZE are reported to the
> > > userspace so there is no need to report a failure on data that is not
> > > exposed.  One item that needs clarification is the fact that
> > > regardless if  PREREQUISITES or PREREQUISITES_SIZE are invalid, that
> > > does not mean other values are invalid.  It is for this reason, we
> > > need to continue to read all remaining packages.
> >
> > It may be that prerequisites are not reported to userspace.
> > But the following values are:
> >
> > security level, current value and possible values.
> >
> > And if prerequisites are garbage then those are now also garbage.
> 
> This statement is not correct.  Each attribute value is isolated from
> each other hence it only affects a single value and does not impact
> the following values such security level, current value and possible
> values

Indeed, I stand corrected.
I guess the loop-based logic is still confusing me.

> Here is a sample where the prerequisite_size is invalid but the
> prerequisites, security, string min value and string max value are
> correct.
> 
> 8003.571287] Attribute: HP_Disk0MapForUefiBootOrder    Prerequisite_size 3145848
> [ 8003.571287] String Prerequisites size value exceeded the maximum
> number of elements supported or data may be malformed
> 
> [ 8003.571288] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[0]
> /Pci(0x1F,0x6)/MAC(3
> [ 8003.571288] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[1]
> 24D33F453F,0x0)/IPv6(000
> [ 8003.571289] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[2]
> :0000:0000:0000:0000:000
> [ 8003.571290] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[3]
> :0000:0000,0x0,Static,00
> [ 8003.571290] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[4]
> 0:0000:0000:0000:0000:00
> [ 8003.571291] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[5]
> 0:0000:0000,0x40,0000:00
> [ 8003.571291] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[6]
> 0:0000:0000:0000:0000:00
> [ 8003.571292] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[7]
> 0:0000)\r\n\tPciRoot(0x0)/P
> [ 8003.571292] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[8]
> i(0x0,0x0)/IPv4(0.0.0.0,0x0,DHCP,0.0.0.0,0.0.0.0,
> [ 8003.571293] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[9]
> .0.0.0)\r\n\tPciRoot(0x0)/P
> [ 8003.571293] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[10]
> i(0x0,0x0)/IPv6(0000:0000:0000:0000:0000:0000:000
> [ 8003.571294] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[11]
> :0000,0x0,Static,0000:00
> [ 8003.571295] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[12]
> 0:0000:0000:0000:0000:00
> [ 8003.571295] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[13]
> 0:0000,0x0,0000:0000:000
> [ 8003.571296] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[14]
> :0000:0000:0000:0000:000
> [ 8003.571296] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[15] )
> [ 8003.571297] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[16]
> [ 8003.571297] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[17]
> [ 8003.571298] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[18]
> [ 8003.571298] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[19]
> 
> [ 8003.571298] Attribute: HP_Disk0MapForUefiBootOrder Security 0
> [ 8003.571299] Attribute: HP_Disk0MapForUefiBootOrder String Min Length  0
> [ 8003.571299] Attribute: HP_Disk0MapForUefiBootOrder String Max Length  0
> 
> 
> >
> > hp_populate_enumeration_package_data() always returns "0".
> 
> Earlier in the code, failures reported for a particular attribute
> value were ignored because each value is independent from each other.
> It is up to the user space application to analyze the raw data read from BIOS.

Please remember that this API will not only be used by HPs own userspace
component.

Where are the rules for userspace documented to analyze the raw data and recognize
an error?
Looking at the kernel log is not enough, it is not an API.

> >
> > > In earlier reviews, it was agreed to report a warning  that reads
> > >
> > > /* Report a message and limit prerequisite size to maximum value */
> > > pr_warn("Enum Prerequisites size value exceeded the maximum number of
> > > elements supported or data may be malformed\n");
> > >
> > > See lines 370-374
> > >
> > > > (Affects all attributes)
> > > >
> > > > > +                     for (reqs = 0; reqs < size; reqs++) {
> > > > > +                             if (elem >= enum_obj_count) {
> > > > > +                                     pr_err("Error enum-objects package is too small\n");
> > > > > +                                     return -EINVAL;
> > > > > +                             }
> > > > > +
> > > > > +                             ret = hp_convert_hexstr_to_str(enum_obj[elem + reqs].string.pointer,
> > > > > +                                                            enum_obj[elem + reqs].string.length,
> > > > > +                                                            &str_value, &value_len);
> > > > > +
> > > > > +                             if (ret)
> > > > > +                                     return -EINVAL;
> > > > > +
> > > > > +                             strscpy(enum_data->common.prerequisites[reqs],
> > > > > +                                     str_value,
> > > > > +                                     sizeof(enum_data->common.prerequisites[reqs]));
> > > > > +
> > > > > +                             kfree(str_value);
> > > > > +                     }
> > > > > +                     break;
> > > > > +
> > > > > +             case SECURITY_LEVEL:
> > > > > +                     enum_data->common.security_level = int_value;
> > > > > +                     break;
> > > > > +
> > > > > +             case ENUM_CURRENT_VALUE:
> > > > > +                     strscpy(enum_data->current_value,
> > > > > +                             str_value, sizeof(enum_data->current_value));
> > > > > +                     break;
> > > > > +             case ENUM_SIZE:
> > > > > +                     enum_data->possible_values_size = int_value;
> > > > > +                     if (int_value > MAX_VALUES_SIZE)
> > > > > +                             pr_warn("Possible number values size value exceeded the maximum number of elements supported or data may be malformed\n");
> > > > > +
> > > > > +                     /*
> > > > > +                      * This HACK is needed to keep the expected
> > > > > +                      * element list pointing to the right obj[elem].type
> > > > > +                      * when the size is zero. POSSIBLE_VALUES
> > > > > +                      * object is omitted by BIOS when the size is zero.
> > > > > +                      */
> > > > > +                     if (int_value == 0)
> > > > > +                             eloc++;
> > > > > +                     break;
> > > > > +
> > > > > +             case ENUM_POSSIBLE_VALUES:
> > > > > +                     size = enum_data->possible_values_size;
> > > > > +
> > > > > +                     for (pos_values = 0; pos_values < size && pos_values < MAX_VALUES_SIZE;
> > > > > +                          pos_values++) {
> > > > > +                             if (elem >= enum_obj_count) {
> > > > > +                                     pr_err("Error enum-objects package is too small\n");
> > > > > +                                     return -EINVAL;
> > > > > +                             }
> > > > > +
> > > > > +                             ret = hp_convert_hexstr_to_str(enum_obj[elem + pos_values].string.pointer,
> > > > > +                                                            enum_obj[elem + pos_values].string.length,
> > > > > +                                                            &str_value, &value_len);
> > > > > +
> > > > > +                             if (ret)
> > > > > +                                     return -EINVAL;
> > > > > +
> > > > > +                             /*
> > > > > +                              * ignore strings when possible values size
> > > > > +                              * is greater than MAX_VALUES_SIZE
> > > > > +                              */
> > > > > +                             if (size < MAX_VALUES_SIZE)
> > > > > +                                     strscpy(enum_data->possible_values[pos_values],
> > > > > +                                             str_value,
> > > > > +                                             sizeof(enum_data->possible_values[pos_values]));
> > > > > +                     }
> > > > > +                     break;
> > > > > +             default:
> > > > > +                     pr_warn("Invalid element: %d found in Enumeration attribute or data may be malformed\n", elem);
> > > > > +                     break;
> > > > > +             }
> > > > > +
> > > > > +             kfree(str_value);
> > > > > +     }
> > > > > +
> > > > > +exit_enumeration_package:
> > > > > +     kfree(str_value);
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * hp_populate_enumeration_package_data() -
> > > > > + * Populate all properties of an instance under enumeration attribute
> > > > > + *
> > > > > + * @enum_obj: ACPI object with enumeration data
> > > > > + * @instance_id: The instance to enumerate
> > > > > + * @attr_name_kobj: The parent kernel object
> > > > > + */
> > > > > +int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
> > > > > +                                      int instance_id,
> > > > > +                                      struct kobject *attr_name_kobj)
> > > > > +{
> > > > > +     struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
> > > > > +
> > > > > +     enum_data->attr_name_kobj = attr_name_kobj;
> > > > > +
> > > > > +     hp_populate_enumeration_elements_from_package(enum_obj,
> > > > > +                                                   enum_obj->package.count,
> > > > > +                                                   instance_id);
> > > > > +     hp_update_attribute_permissions(enum_data->common.is_readonly,
> > > > > +                                     &enumeration_current_val);
> > > > > +     /*
> > > > > +      * Several attributes have names such "MONDAY". Friendly
> > > > > +      * user nane is generated to make the name more descriptive
> > > > > +      */
> > > > > +     hp_friendly_user_name_update(enum_data->common.path,
> > > > > +                                  attr_name_kobj->name,
> > > > > +                                  enum_data->common.display_name,
> > > > > +                                  sizeof(enum_data->common.display_name));
> > > > > +     return sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
> > > > > +}
> > > > > +
> > > > > +static int hp_populate_enumeration_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> > > > > +                                                     int instance_id)
> > > > > +{
> > > > > +     int reqs;
> > > > > +     int values;
> > > > > +     struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
> > > > > +
> > > > > +     /*
> > > > > +      * In earlier implementation, reported errors were ignored
> > > > > +      * causing the data to remain uninitialized. It is for this
> > > > > +      * reason functions may return an error and no validation
> > > > > +      * takes place.
> > > > > +      */
> > > >
> > > > Where is this error returned?
> > >
> > > functions such hp_get_string_from_buffer, hp_get_integer_from_buffer
> >
> > But the errors returned from those functions are just thrown away, no?
> 
> Earlier in the code, failures reported for a particular attribute
> value were ignored because each value is independent from each other.
> It is for this reason, we are throwing away any errors returned from
> those functions.
> 
> > > >
> > > > > +
> > > > > +     // VALUE:
> > > > > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_data->current_value,
> > > > > +                               sizeof(enum_data->current_value));
> > > > > +
> > > > > +     // PATH:
> > > > > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_data->common.path,
> > > > > +                               sizeof(enum_data->common.path));
> > > > > +
> > > > > +     // IS_READONLY:
> > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                                &enum_data->common.is_readonly);
> > > > > +
> > > > > +     //DISPLAY_IN_UI:
> > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                                &enum_data->common.display_in_ui);
> > > > > +
> > > > > +     // REQUIRES_PHYSICAL_PRESENCE:
> > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                                &enum_data->common.requires_physical_presence);
> > > > > +
> > > > > +     // SEQUENCE:
> > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                                &enum_data->common.sequence);
> > > > > +
> > > > > +     // PREREQUISITES_SIZE:
> > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                                &enum_data->common.prerequisites_size);
> > > > > +
> > > > > +     if (enum_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
> > > > > +             /* Report a message and limit prerequisite size to maximum value */
> > > > > +             pr_warn("Enum Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> > > > > +             enum_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
> > > > > +     }
> > > > > +
> > > > > +     // PREREQUISITES:
> > > > > +     for (reqs = 0; reqs < enum_data->common.prerequisites_size; reqs++)
> > > > > +             hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                                       enum_data->common.prerequisites[reqs],
> > > > > +                                       sizeof(enum_data->common.prerequisites[reqs]));
> > > > > +
> > > > > +     // SECURITY_LEVEL:
> > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                                &enum_data->common.security_level);
> > > >
> > > > The reading of all the common elemtns can be extracted into a helper
> > > > and reused from all the attributes.
> > >
> > > Is extracting all common elements into a helper routine absolutely
> > > necessary now or can it be refactored after driver is accepted?
> >
> > It's not necessary.
> 
> Thank you
> >
> > > >
> > > > > +
> > > > > +     // ENUM_CURRENT_VALUE:
> > > > > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                               enum_data->current_value,
> > > > > +                               sizeof(enum_data->current_value));
> > > > > +     // ENUM_SIZE:
> > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                                &enum_data->possible_values_size);
> > > > > +
> > > > > +     if (enum_data->possible_values_size > MAX_VALUES_SIZE) {
> > > > > +             /* Report a message and limit possible values size to maximum value */
> > > > > +             pr_warn("Enum Possible size value exceeded the maximum number of elements supported or data may be malformed\n");
> > > > > +             enum_data->possible_values_size = MAX_VALUES_SIZE;
> > > > > +     }
> > > > > +
> > > > > +     // ENUM_POSSIBLE_VALUES:
> > > > > +
> > > > > +     for (values = 0; values < enum_data->possible_values_size; values++)
> > > > > +             hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > > > > +                                       enum_data->possible_values[values],
> > > > > +                                       sizeof(enum_data->possible_values[values]));
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * hp_populate_enumeration_buffer_data() -
> > > > > + * Populate all properties of an instance under enumeration attribute
> > > > > + *
> > > > > + * @buffer_ptr: Buffer pointer
> > > > > + * @buffer_size: Buffer size
> > > > > + * @instance_id: The instance to enumerate
> > > > > + * @attr_name_kobj: The parent kernel object
> > > > > + */
> > > > > +int hp_populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> > > > > +                                     int instance_id,
> > > > > +                                     struct kobject *attr_name_kobj)
> > > > > +{
> > > > > +     struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
> > > > > +
> > > > > +     enum_data->attr_name_kobj = attr_name_kobj;
> > > > > +
> > > > > +     /* Populate enumeration elements */
> > > > > +     hp_populate_enumeration_elements_from_buffer(buffer_ptr, buffer_size, instance_id);
> > > > > +
> > > > > +     hp_update_attribute_permissions(enum_data->common.is_readonly,
> > > > > +                                     &enumeration_current_val);
> > > > > +     /*
> > > > > +      * Several attributes have names such "MONDAY". A Friendlier
> > > > > +      * user nane is generated to make the name more descriptive
> > > > > +      */
> > > > > +     hp_friendly_user_name_update(enum_data->common.path,
> > > > > +                                  attr_name_kobj->name,
> > > > > +                                  enum_data->common.display_name,
> > > > > +                                  sizeof(enum_data->common.display_name));
> > > > > +
> > > > > +     return sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * hp_exit_enumeration_attributes() - Clear all attribute data
> > > > > + *
> > > > > + * Clears all data allocated for this group of attributes
> > > > > + */
> > > > > +void hp_exit_enumeration_attributes(void)
> > > > > +{
> > > > > +     int instance_id;
> > > > > +
> > > > > +     for (instance_id = 0; instance_id < bioscfg_drv.enumeration_instances_count;
> > > > > +          instance_id++) {
> > > > > +             struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
> > > > > +             struct kobject *attr_name_kobj = enum_data->attr_name_kobj;
> > > > > +
> > > > > +             if (attr_name_kobj)
> > > > > +                     sysfs_remove_group(attr_name_kobj, &enumeration_attr_group);
> > > > > +     }
> > > > > +     bioscfg_drv.enumeration_instances_count = 0;
> > > > > +
> > > > > +     kfree(bioscfg_drv.enumeration_data);
> > > > > +     bioscfg_drv.enumeration_data = NULL;
> > > > > +}
> > > > > --
> > > > > 2.34.1
> > > > >
