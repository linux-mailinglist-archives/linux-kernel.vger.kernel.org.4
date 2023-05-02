Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A3F6F4C39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjEBVaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEBVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:30:08 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D0C10FE;
        Tue,  2 May 2023 14:30:07 -0700 (PDT)
Date:   Tue, 2 May 2023 23:30:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683063005; bh=w+kKsFePE+hV8C+y/o423iW0bUDfnkSuaBi7WrMOCcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5C35WoemlRgOkEGL5gZQN7AOg7lsqikBAcdQVKTuhlyu9/No5vo7cafSR56b1wZ4
         8k57+n5vlvzFNwFy9Itgz9WSGb954pJaqZAn7vZDBPf6ARgRlInqVlWgjvY9C4lZj4
         YUj79KkRnD5Rf/b4aEX4fcGLI89qRDe/n1bnRVg4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/14] HP BIOSCFG driver - int-attributes
Message-ID: <efafedc0-e9d3-4060-a174-dc4f33f77246@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-5-jorge.lopez2@hp.com>
 <26f0a80e-d3f8-4d6c-83ff-d756abed7b6b@t-8ch.de>
 <CAOOmCE8+Kgkm4uscYEei1+9xHiN=wd2oNtEiLeneDS+zppuYcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOOmCE8+Kgkm4uscYEei1+9xHiN=wd2oNtEiLeneDS+zppuYcg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

thanks for incorporating my feedback, I'm curious for the next revision!

The review comments are very terse but that is only to bring across
their points better. Your effort is appreciated.

On 2023-05-02 15:56:22-0500, Jorge Lopez wrote:

<snip>

> > On 2023-04-20 11:54:44-0500, Jorge Lopez wrote:
> > > ---
> > > Based on the latest platform-drivers-x86.git/for-next
> > > ---
> > >  .../x86/hp/hp-bioscfg/int-attributes.c        | 474 ++++++++++++++++++
> > >  1 file changed, 474 insertions(+)
> > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > >
> > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > > new file mode 100644
> > > index 000000000000..d8ee39dac3f9
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c

<snip>

> > > +int populate_integer_elements_from_package(union acpi_object *integer_obj,
> > > +                                        int integer_obj_count,
> > > +                                        int instance_id)
> > > +{
> > > +     char *str_value = NULL;
> > > +     int value_len;
> > > +     int ret = 0;
> > > +     u32 size = 0;
> > > +     u32 int_value;
> > > +     int elem = 0;
> > > +     int reqs;
> > > +     int eloc;
> > > +
> > > +     if (!integer_obj)
> > > +             return -EINVAL;
> > > +
> > > +     strscpy(bioscfg_drv.integer_data[instance_id].common.display_name_language_code,
> > > +             LANG_CODE_STR,
> > > +             sizeof(bioscfg_drv.integer_data[instance_id].common.display_name_language_code));
> > > +
> > > +     for (elem = 1, eloc = 1; elem < integer_obj_count; elem++, eloc++) {
> > > +
> > > +             /* ONLY look at the first INTEGER_ELEM_CNT elements */
> >
> > Why?
> The information provided in element 0 from the package is ignored as
> directed by the BIOS team.
> Similar action is taken when reading the information from ACPI Buffer
> (populate_integer_elements_from_buffer())

This should be mentioned somewhere.

But my question was more why to we only look at INTEGER_ELEM_CNT?
It is clear to me now, but this is very convulted. See below.

<snip>

> >
> > > +
> > > +int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> > > +                                       int instance_id)
> > > +{
> > > +     char *dst = NULL;
> > > +     int elem;
> > > +     int reqs;
> > > +     int integer;
> > > +     int size = 0;
> > > +     int ret;
> > > +     int dst_size = *buffer_size / sizeof(u16);
> > > +
> > > +     dst = kcalloc(dst_size, sizeof(char), GFP_KERNEL);
> > > +     if (!dst)
> > > +             return -ENOMEM;
> > > +
> > > +     elem = 0;
> > > +     strscpy(bioscfg_drv.integer_data[instance_id].common.display_name_language_code,
> > > +             LANG_CODE_STR,
> > > +             sizeof(bioscfg_drv.integer_data[instance_id].common.display_name_language_code));
> > > +
> > > +     for (elem = 1; elem < 3; elem++) {
> > > +
> > > +             ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> > > +             if (ret < 0)
> > > +                     continue;
> > > +
> > > +             switch (elem) {
> > > +             case VALUE:
> > > +                     ret = kstrtoint(dst, 10, &integer);
> > > +                     if (ret)
> > > +                             continue;
> > > +
> > > +                     bioscfg_drv.integer_data[instance_id].current_value = integer;
> > > +                     break;
> > > +             case PATH:
> > > +                     strscpy(bioscfg_drv.integer_data[instance_id].common.path, dst,
> > > +                             sizeof(bioscfg_drv.integer_data[instance_id].common.path));
> > > +                     break;
> > > +             default:
> > > +                     pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     for (elem = 3; elem < INTEGER_ELEM_CNT; elem++) {
> >
> > This loop pattern seems weird to me.
> > It is not obvious that the values are read in the order of the switch()
> > branches from the buffer.
> >
> 
> The order in which the data is read from the buffer is set by BIOS.

This I understand.

> The switch statement was used to enforce the reading order of the
> elements and provide additional clarity

This is not clear from the code alone. One also needs to know the
concrete values of the enums.

> > Something more obvious would be:
> >
> > instance.common.is_readonly = read_int_from_buf(&buffer_ptr);
> > instance.common.display_in_ui = read_int_from_buf(&buffer_ptr);
> > instance.common.requires_physical_presence = read_int_from_buf(&buffer_ptr);

The proposed pattern above, just regular function calls, are also
executed in the correct order, the order in which they are written.

For a reader it is clear that the order is important and part of the
ABI of the BIOS.

> > This would make it clear that these are fields read in order from the
> > buffer. Without having to also look at the numeric values of the
> > defines.
> >
> > Furthermore it would make the code shorter and errorhandling would be
> > clearer and the API similar to the netlink APIs.
> >
> > Or maybe with error reporting:
> >
> > ret = read_int_from_buf(&buffer_ptr, &instance.common.is_readonly);
> > if (ret)
> >     ...
> 
> Instance.common.is_readonly is only evaluated when the user attempt to
> update an attribute current value

is_readonly was only an example on how to more nicely read the data from
the buffer. It applies to all values of all attribute types.

> > ret = read_int_from_buf(&buffer_ptr, &instance.common.display_in_ui);
> > if (ret)
> >     ...
> 
> Instance.common.display_in_ui has no specific use at this time.
> 
> The code was made shorter and easier to understand by replacing the
> long statements with
> 
> struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> ...
> integer_data->common.is_readonly = integer;
> 
> Same approach was taken for all attribute files.

Thanks!

Please do try to use the "plain functioncall" pattern as outlined above.
I think it can make the code much shorter and idiomatic.
