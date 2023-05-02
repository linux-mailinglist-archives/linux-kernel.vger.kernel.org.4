Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3160B6F4BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjEBVOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:14:14 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E210EA;
        Tue,  2 May 2023 14:14:09 -0700 (PDT)
Date:   Tue, 2 May 2023 23:14:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683062048; bh=e07JQPbrzErLVZNtCZRsd72YMBOeDKOjG5kkaPnDxHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhI0e1KyFlV8tv2ZcCxD2xFZO0C2LhOKZ9WCqkyaa63PM3v0izkqQjZBtcBWgR5ur
         zW07mFrAN+GUb3t2zLEEOSTeWn6WsiB2rWDU2pmvyAN0vhjij/OzaDGqBhzdvp2jNm
         pGbmqQSR2FKgONmrRnkO427GC1KA6ykXuM7QHA7k=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 03/14] HP BIOSCFG driver - bioscfg
Message-ID: <e85d71dd-3836-4b06-80d8-199c59383eff@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-4-jorge.lopez2@hp.com>
 <05785df6-28e3-4de2-bdef-5acdfac1f558@t-8ch.de>
 <CAOOmCE97GmqAxhk-_2f0gpOC7VZ=k-retewj7aTRP78ud1HKrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE97GmqAxhk-_2f0gpOC7VZ=k-retewj7aTRP78ud1HKrQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-02 14:52:14-0500, Jorge Lopez wrote:
> On Sat, Apr 22, 2023 at 5:16 PM <thomas@t-8ch.de> wrote:
> >
> > On 2023-04-20 11:54:43-0500, Jorge Lopez wrote:
> > > ---
> > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 961 +++++++++++++++++++
> > >  1 file changed, 961 insertions(+)
> > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > >
> > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > > new file mode 100644
> > > index 000000000000..4b0d4f56e65f
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c

<snip>

> > > +     int retval = 0;
> > > +     u8 *attr_name;
> >
> > const char *
> 
> Cannot define  attr_name as 'const char *'.  attr_name value is set
> within the function

Then use "char *". This is pointing to a NULL-terminated string,
not a number or binary data.

This is also the type used by the functions this value is passed to.

<snip>

> > > +                     retval = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
> > > +                                                   NULL, "%s", str_value);
> > > +
> > > +                     if (retval) {
> > > +                             kobject_put(attr_name_kobj);
> >
> > The kobj was not created, why does it need the kobj_put() ?
> As indicated by kobject_init_and_add ...
> 
>  * This function combines the call to kobject_init() and kobject_add().
>  *
>  * If this function returns an error, kobject_put() must be called to
>  * properly clean up the memory associated with the object.  This is the
>  * same type of error handling after a call to kobject_add() and kobject
>  * lifetime rules are the same here.

I stand corrected, thanks!

> >
> > > +                             goto err_attr_init;
> > > +                     }
> > > +
> > > +                     /* enumerate all of these attributes */
> > > +                     switch (attr_type) {
> > > +                     case HPWMI_STRING_TYPE:
> > > +                             retval = populate_string_package_data(elements,
> > > +                                                                   instance_id,
> > > +                                                                   attr_name_kobj);
> > > +                             break;
> > > +                     case HPWMI_INTEGER_TYPE:
> > > +                             retval = populate_integer_package_data(elements,
> > > +                                                                    instance_id,
> > > +                                                                    attr_name_kobj);
> > > +                             break;
> > > +                     case HPWMI_ENUMERATION_TYPE:
> > > +                             retval = populate_enumeration_package_data(elements,
> > > +                                                                        instance_id,
> > > +                                                                        attr_name_kobj);
> > > +                             break;
> > > +                     case HPWMI_ORDERED_LIST_TYPE:
> > > +                             retval = populate_ordered_list_package_data(elements,
> > > +                                                                         instance_id,
> > > +                                                                         attr_name_kobj);
> > > +                             break;
> > > +                     case HPWMI_PASSWORD_TYPE:
> > > +                             retval = populate_password_package_data(elements,
> > > +                                                                     instance_id,
> > > +                                                                     attr_name_kobj);
> > > +                             break;
> > > +                     default:
> > > +                             break;
> >
> > This default does nothing.
> >
> > > +                     }
> > > +
> > > +                     kfree(str_value);
> >
> > Why is str_value only freed down here? It has not been used for half a
> > screen of code.
> 
> Added early in the development process and failed to clean up here.
> >
> > > +             }
> >
> > else
> >
> > > +
> > > +             if (obj->type == ACPI_TYPE_BUFFER) {
> > > +
> > > +                     buffer_size = obj->buffer.length;
> > > +                     buffer_ptr = obj->buffer.pointer;
> > > +
> > > +                     retval = get_string_from_buffer(&buffer_ptr, &buffer_size, str, MAX_BUFF);
> > > +                     if (retval < 0)
> > > +                             goto err_attr_init;
> > > +
> > > +                     if (attr_type == HPWMI_PASSWORD_TYPE || attr_type == HPWMI_SECURE_PLATFORM_TYPE)
> > > +                             tmp_set = bioscfg_drv.authentication_dir_kset;
> > > +                     else
> > > +                             tmp_set = bioscfg_drv.main_dir_kset;
> >
> > There is a bunch of common logic duplicated in both the buffer and
> > package branches.
> 
> Older BIOS reports the ACPI data as objects of type ACPI_TYPE_PACKAGE
> and the associated data is reported as elements.
> Newer BIOS reports the ACPI data as objects of type ACPI_TYPE_BUFFER.
>  (actypes.h   union acpi_object)
> The code follows a common logic although the data is acquired
> differently according to the ACPI object type
> >
> > > +
> > > +                     if (kset_find_obj(tmp_set, str)) {
> > > +                             pr_warn("Duplicate attribute name found - %s\n", str);
> >
> > Also mention that it is being ignored.
> >
> > > +                             goto nextobj;
> > > +                     }
> > > +
> > > +                     /* build attribute */
> > > +                     attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
> > > +                     if (!attr_name_kobj) {
> > > +                             retval = -ENOMEM;
> > > +                             goto err_attr_init;
> > > +                     }
> > > +
> > > +                     attr_name_kobj->kset = tmp_set;
> > > +
> > > +                     temp_str = str;
> > > +                     if (attr_type == HPWMI_SECURE_PLATFORM_TYPE)
> > > +                             temp_str = "SPM";
> > > +
> > > +                     retval = kobject_init_and_add(attr_name_kobj,
> > > +                                                   &attr_name_ktype, NULL, "%s",
> > > +                                                   temp_str);
> > > +                     if (retval) {
> > > +                             kobject_put(attr_name_kobj);
> > > +                             goto err_attr_init;
> > > +                     }
> > > +
> > > +                     /* enumerate all of these attributes */
> > > +                     switch (attr_type) {
> > > +                     case HPWMI_STRING_TYPE:
> > > +                             retval = populate_string_buffer_data(buffer_ptr,
> > > +                                                                  &buffer_size,
> > > +                                                                  instance_id,
> > > +                                                                  attr_name_kobj);
> > > +                             break;
> > > +                     case HPWMI_INTEGER_TYPE:
> > > +                             retval = populate_integer_buffer_data(buffer_ptr,
> > > +                                                                   &buffer_size,
> > > +                                                                   instance_id,
> > > +                                                                   attr_name_kobj);
> > > +                             break;
> > > +                     case HPWMI_ENUMERATION_TYPE:
> > > +                             retval = populate_enumeration_buffer_data(buffer_ptr,
> > > +                                                                       &buffer_size,
> > > +                                                                       instance_id,
> > > +                                                                       attr_name_kobj);
> > > +                             break;
> > > +                     case HPWMI_ORDERED_LIST_TYPE:
> > > +                             retval = populate_ordered_list_buffer_data(buffer_ptr,
> > > +                                                                        &buffer_size,
> > > +                                                                        instance_id,
> > > +                                                                        attr_name_kobj);
> > > +                             break;
> > > +                     case HPWMI_PASSWORD_TYPE:
> > > +                             retval = populate_password_buffer_data(buffer_ptr,
> > > +                                                                    &buffer_size,
> > > +                                                                    instance_id,
> > > +                                                                    attr_name_kobj);
> > > +                             break;
> > > +                     default:
> > > +                             break;
> > > +                     }
> > > +             }
> >
> > What if it's neither a package nor a buffer?
> 
> we return an error if it is neither a package nor a buffer.
> 
> if (obj->type != ACPI_TYPE_PACKAGE && obj->type != ACPI_TYPE_BUFFER) {
>        pr_err("Error: Expected ACPI-package or buffer type, got:
> %d\n",  obj->type);
>        retval = -EIO;
>        goto err_attr_init;
> }

Indeed, thanks.

This could be pulled together into:

if (package)
	...
else if (buffer)
	...
else
	report error

Note:

The "Error: " prefix is unnecessary. It's already logged as pr_err().

<snip>
