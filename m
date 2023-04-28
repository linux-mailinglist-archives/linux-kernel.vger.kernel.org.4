Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0456F1BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjD1Pha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjD1Ph2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:37:28 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66355AD;
        Fri, 28 Apr 2023 08:36:53 -0700 (PDT)
Date:   Fri, 28 Apr 2023 17:36:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682696178; bh=7jLiEj7+Pv2h4RAIi3yfMfMbNX9AW+A1ZOdwGlDD00k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/0pCfV8PHvTtLuVAuSw4fiWwMZVPBpaRzGM+KJ15OUjgA0TR7DT1JzjyR9vDYLU4
         aDgJ6y0jMJJGsiGBxzIwgFl8BwER6MLaxqsC8EAIrrk15CK6c/J0zWLUoI3wM6JwQM
         4QupQhQ/0wLFTCKV6NXcueD+nDQuIPl9S/PrXFOs=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 08/14] HP BIOSCFG driver - bioscfg-h
Message-ID: <462b5d12-0430-4fbe-8c26-7b6126556ec8@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-9-jorge.lopez2@hp.com>
 <ca74121b-bb78-4093-8625-13359c324c28@t-8ch.de>
 <CAOOmCE_MpCBFOHd6QtzD5ufcwEz_FhJvqevj68pVeY_JS+V=Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE_MpCBFOHd6QtzD5ufcwEz_FhJvqevj68pVeY_JS+V=Rg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-28 10:24:40-0500, Jorge Lopez wrote:
> On Sun, Apr 23, 2023 at 7:01 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2023-04-20 11:54:48-0500, Jorge Lopez wrote:
> > > ---
> > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 613 +++++++++++++++++++
> > >  1 file changed, 613 insertions(+)
> > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h

<snip>

> > > +/* global structure used by multiple WMI interfaces */
> > > +extern struct bioscfg_priv bioscfg_drv;
> > > +
> > > +enum hp_wmi_data_type {
> > > +     HPWMI_STRING_TYPE               = 0x00,
> > > +     HPWMI_INTEGER_TYPE              = 0x01,
> > > +     HPWMI_ENUMERATION_TYPE          = 0x02,
> > > +     HPWMI_ORDERED_LIST_TYPE         = 0x03,
> > > +     HPWMI_PASSWORD_TYPE             = 0x04,
> > > +     HPWMI_SECURE_PLATFORM_TYPE      = 0x05,
> > > +     HPWMI_SURE_START_TYPE           = 0x06
> > > +};
> >
> > Unused.
> 
> Both hp_wmi_data_type and hp_wmi_data_elements are used
> for instance  HP_WMI_STRING_TYPE
> 
> bioscfg.c:338: case HPWMI_STRING_TYPE:
> bioscfg.c:626: case HPWMI_STRING_TYPE:
> bioscfg.c:722: case HPWMI_STRING_TYPE:
> bioscfg.c:798: case HPWMI_STRING_TYPE:
> bioscfg.c:906: ret = hp_init_bios_attributes(HPWMI_STRING_TYPE,
> HP_WMI_BIOS_STRING_GUID);
> bioscfg.h:247: HPWMI_STRING_TYPE

Indeed. I think I just searched for "hp_wmi_data_type".

The proper enum hp_wmi_data_type type should be used instead of
"int attr_type".

<snip>

> > > +
> > > +enum hp_wmi_elements_count {
> > > +     STRING_ELEM_CNT         = 12,
> > > +     INTEGER_ELEM_CNT        = 13,
> > > +     ENUM_ELEM_CNT           = 13,
> > > +     ORDERED_ELEM_CNT        = 12,
> > > +     PASSWORD_ELEM_CNT       = 15
> > > +};
> >
> > To make it clearer where these values come from you could put them into
> > the enum hp_wmi_data_elements.
> >
> > ...
> >         ORD_LIST_ELEMENTS = 11,
> >         ORD_LIST_ELEM_CNT = 12,
> > ...
> 
> Done!  changes provided across all files affected.
> 
> >
> > But replacing the loop logic would remove the need for these enums
> > completely.
> >
> 
> _CNT values are necessary when elements are read from a buffer (
> populate_string_elements_from_buffer).
> _CNT values are not needed when elements are read from a package
> (populate_string_package_data)

Hm, I don't see why populate_string_elements_from_buffer() would need
the _CNT define.

(In another review mail I wrote down how I would expect it to look
without the loop)

<snip>

> > > +
> > > +#define ATTRIBUTE_PROPERTY_STORE(curr_val, type)                     \
> > > +     static ssize_t curr_val##_store(struct kobject *kobj,           \
> > > +                                     struct kobj_attribute *attr,    \
> > > +                                     const char *buf, size_t count)  \
> > > +     {                                                               \
> > > +             char *p = NULL;                                         \
> > > +             char *attr_value = NULL;                                \
> > > +             int i;                                                  \
> > > +             int ret = -EIO;                                         \
> > > +                                                                     \
> > > +             attr_value = kstrdup(buf, GFP_KERNEL);                  \
> > > +             if (!attr_value)                                        \
> > > +                     return -ENOMEM;                                 \
> > > +                                                                     \
> > > +             p = memchr(attr_value, '\n', count);                    \
> > > +             if (p != NULL)                                          \
> > > +                     *p = '\0';                                      \
> >
> > This can also truncate the string if there is data after the newline.
> 
> This is a expected behavior as described by Hans in a later email

I'm fine with stripping a trailing newline.

But this truncates the string at the first newline.

"foo\nbar" -> "foo"
"\nfoo" -> ""

<snip>
