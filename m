Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CBB6F7903
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEDWVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 18:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEDWVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 18:21:14 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A70124BD;
        Thu,  4 May 2023 15:21:06 -0700 (PDT)
Date:   Fri, 5 May 2023 00:21:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683238862; bh=nU/A/v9PUK0xVMjHH0iKaik1gYQJC4LyFxlKFA7zhrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cc84+qDslyVmGx5hjR9zAw6hn3fKkvk5jaO+iH2Lj2491Q0zrQCxGcupfpKelr0TC
         hwAyeDde+UjoqbRR2RJ1gCWMcy3YB6ZiVKJ5cofF6FBp0O3zg+jOFLyjfXJHVcDTKB
         urz9oGGHsuYxyTLuRu+oxM4E6jB1NZFWKAI4OgEY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 06/14] HP BIOSCFG driver - passwdobj-attributes
Message-ID: <1f80c7a9-cc88-4c30-9797-e20e3cb4859c@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-7-jorge.lopez2@hp.com>
 <016a9a6a-cff1-444d-b96a-63eded1ac58a@t-8ch.de>
 <CAOOmCE9USvpih7E6cq7sKiMmGJa_FV74g36kb6EZMSrkg5BnLg@mail.gmail.com>
 <9bbf8cb3-6333-4742-b32a-c7e9118bc618@t-8ch.de>
 <CAOOmCE-S-GpcmG9c6eB1hz6o3hudX8hWY9jmZ-cUwivHzijsPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE-S-GpcmG9c6eB1hz6o3hudX8hWY9jmZ-cUwivHzijsPw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 16:34:06-0500, Jorge Lopez wrote:
> On Thu, May 4, 2023 at 3:59 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2023-05-04 15:29:21-0500, Jorge Lopez wrote:
> > > On Sun, Apr 23, 2023 at 4:07 AM <thomas@t-8ch.de> wrote:
> > > >
> > > > On 2023-04-20 11:54:46-0500, Jorge Lopez wrote:
> > > > > ---
> > > > >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 669 ++++++++++++++++++
> > > > >  1 file changed, 669 insertions(+)
> > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c

<snip>

> > > > > +
> > > > > +     id = get_password_instance_id(kobj);
> > > > > +
> > > > > +     if (id >= 0)
> > > > > +             ret = validate_password_input(id, buf_cp);
> > > > > +
> > > > > +     if (!ret) {
> > > > > +             strscpy(bioscfg_drv.password_data[id].current_password,
> > > > > +                     buf_cp,
> > > > > +                     sizeof(bioscfg_drv.password_data[id].current_password));
> > > > > +             /*
> > > > > +              * set pending reboot flag depending on
> > > > > +              * "RequiresPhysicalPresence" value
> > > > > +              */
> > > > > +             if (bioscfg_drv.password_data[id].common.requires_physical_presence)
> > > > > +                     bioscfg_drv.pending_reboot = true;
> > > >
> > > > Just setting this to true does not emit the necessary KOBJ_CHANGE event
> > > > on the class dev kobj which is necessary for userspace to be able to
> > > > react.
> > >
> > > This feature was added outside of the original design specification to
> > > be used at a later time.
> > > Changes to the value to true does not emit a KOBJ_CHANGE event.
> >
> > This contradicts the documentation:
> >
> >         A read-only attribute reads 1 if a reboot is necessary to apply
> >         pending BIOS attribute changes. Also, an uevent_KOBJ_CHANGE is
> >         generated when it changes to 1.
> >
> > This will confuse userspace, there are generic userspace applications
> > waiting for those events.
> > If there is a reason for not emitting them it should be good and
> > documented.
> >
> > Also according to the docs the authentication attributes should
> > KOBJ_CHANGE events. I think this also affects this driver and should be
> > implemented.
> >
> 
> HP-BIOSCFG initially is not intended for the use of fwupd tool nor was
> it tested.
> This does not mean the driver will interface with fwupd and other
> tools in the future.

There are probably more tools than fwupd using this ABI.

The driver is implementing a well-known ABI and users of this ABI expect
it to work as documented.

Emitting these events seems straigtforward and simple.

Maybe Hans can give more guidance on it.

> > > >
> > > > > +     }
> > > > > +
> > > > > +exit_password:
> > > > > +     kfree(buf_cp);
> > > > > +     return ret ? ret : count;
> > > > > +}
> > > > > +static struct kobj_attribute password_current_password = __ATTR_WO(current_password);
> > > > > +
> > > > > +static ssize_t new_password_store(struct kobject *kobj,
> > > > > +                               struct kobj_attribute *attr,
> > > > > +                               const char *buf, size_t count)
> > > > > +{
> > > > > +     char *p, *buf_cp = NULL;
> > > > > +     int id = 0;
> > > > > +     int ret = -EIO;
> > > > > +
> > > > > +     buf_cp = kstrdup(buf, GFP_KERNEL);
> > > > > +     if (!buf_cp) {
> > > > > +             ret = -ENOMEM;
> > > > > +             goto exit_password;
> > > > > +     }
> > > > > +
> > > > > +     p = memchr(buf_cp, '\n', count);
> > > > > +
> > > > > +     if (p != NULL)
> > > > > +             *p = '\0';
> > > >
> > > > Same as above.
> > >
> > > This is an expected behavior.  If the user enters '\n' as part of the
> > > password, the buffer data will be truncated since only one line per
> > > sysfs file is permitted.
> >
> > If a user accidentally presses enter before entering a password this
> > may set the password to the empty string; surprising.
> >
> > This should really use the helper.
> 
> Done!  enforce_single_line_input() function is used.
> >
> > > >
> <snip>
> > > > > +
> > > > > +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, password);
> > > > > +static struct kobj_attribute  password_prerequisites_val =
> > > > > +             __ATTR_RO(prerequisites);
> > > > > +
> > > > > +ATTRIBUTE_N_PROPERTY_SHOW(encodings_size, password);
> > > > > +static struct kobj_attribute  password_encodings_size_val =
> > > > > +             __ATTR_RO(encodings_size);
> > > >
> > > > As before, these size attribute are fairly pointless for userspace as
> > > > they can't be relied on.
> > >
> > > I will remove the attribute from being reported in sysfs but they will
> > > be kept as part of the driver internal data
> > >
> > > >
> > > > > +
> > > > > +ATTRIBUTE_VALUES_PROPERTY_SHOW(encodings, password);
> > > > > +static struct kobj_attribute  password_encodings_val =
> > > > > +             __ATTR_RO(encodings);
> > > > > +
> > > > > +
> > > > > +static struct attribute *password_attrs[] = {
> > > > > +     &password_is_password_set.attr,
> > > > > +     &password_min_password_length.attr,
> > > > > +     &password_max_password_length.attr,
> > > > > +     &password_current_password.attr,
> > > > > +     &password_new_password.attr,
> > > > > +     &password_role.attr,
> > > > > +     &password_mechanism.attr,
> > > > > +     &password_type.attr,
> > > > > +     &password_display_name.attr,
> > > > > +     &password_display_langcode.attr,
> > > > > +     &password_prerequisites_size_val.attr,
> > > > > +     &password_prerequisites_val.attr,
> > > > > +     &password_encodings_val.attr,
> > > > > +     &password_encodings_size_val.attr,
> > > > > +     NULL
> > > > > +};
> > > >
> > > > Many of these attributes are not documented.
> > >
> > > Those attributes are documented under authentication section, lines 150-329
> > >
> > > What: /sys/class/firmware-attributes/*/authentication/
> > > Date: February 2021
> > > KernelVersion: 5.11
> > > Contact: Divya Bharathi <Divya.Bharathi@Dell.com>,
> > > Prasanth KSR <prasanth.ksr@dell.com>
> > > Dell.Client.Kernel@dell.com
> > > Description:
> > > Devices support various authentication mechanisms which can be exposed
> > > as a separate configuration object.
> >
> > If I read that correctly the authentication attributes are not "normal"
> > attributes.
> > So they don't need "type", "display_name", "display_langcode".
> >
> 
> Type, display_name, and display_langcode are required and default settings.
> See documentation lines 15-52
> 
> type:
>     A file that can be read to obtain the type of attribute.
>     This attribute is mandatory.
> 
> display_name:
> A file that can be read to obtain a user friendly
> description of the at <attr>
> 
> display_name_language_code:
> A file that can be read to obtain
> the IETF language tag corresponding to the
> "display_name" of the <attr>

They are required for

/sys/class/firmware-attributes/*/attributes/*/

but here we implement 

/sys/class/firmware-attributes/*/authentication/*/

which is a different ABI.

> 
> > Do they need prerequisites?
> 
> Prerequisites is optional and not documented.  I will remove it from
> the list of items reported within sysfs
> >
> > >
> > >
> > > >
> > > > > +
> > > > > +static const struct attribute_group bios_password_attr_group = {
> > > > > +     .attrs = password_attrs
> > > > > +};
> > > > > +
> > > > > +static const struct attribute_group system_password_attr_group = {
> > > > > +     .attrs = password_attrs
> > > > > +};
> > > >
> > > > These groups are the same, are both needed?
> > >
> > > Yes.  They will show under  'Setup Password' and 'Power-on password'
> >
> > These are identical constant structures. It should be possible to have
> > only one and use it for both usecases.
> >
> 
> Both 'Setup Password' and 'Power-on password' need to coexist hence
> the reason for keeping them separate.
> Both attributes share the same helper routines.  Unifying  both
> passwords into a single structure adds unnecessary complexity.

They are already sharing the "password_attrs" array and all the
attributes listed in it.

It seems they could also share the attribute_group which does not really
contain any data.
