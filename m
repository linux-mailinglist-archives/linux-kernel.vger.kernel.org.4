Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E546F1C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbjD1QKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346093AbjD1QJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:09:51 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6FE5584;
        Fri, 28 Apr 2023 09:09:48 -0700 (PDT)
Date:   Fri, 28 Apr 2023 18:09:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682698186; bh=wFxWPZg0g3+E7n1JDEcPCNZnBu6Q7FN68+/hmBRZTMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3eHVD95ol2NBZnNog6HzcvqHkj45/yEs8cA9cDqUZN5B61u9Pbf5XGl+Yy6p+Pgd
         b6sXXtwQ/a5iwNDh/I/BT4cW6tgK7M0J7bmFABLxXkhcEWT5tziTmEl1jgVtXquudb
         gpIZ+V21H4DcGaV9LkPorKf/aSUXu/VO3P3XfX04=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 08/14] HP BIOSCFG driver - bioscfg-h
Message-ID: <152fb7c0-1075-4718-bca1-c2083c425788@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-9-jorge.lopez2@hp.com>
 <ca74121b-bb78-4093-8625-13359c324c28@t-8ch.de>
 <CAOOmCE_MpCBFOHd6QtzD5ufcwEz_FhJvqevj68pVeY_JS+V=Rg@mail.gmail.com>
 <462b5d12-0430-4fbe-8c26-7b6126556ec8@t-8ch.de>
 <CAOOmCE8iBfeuodTO7C=0EUOkqv16008h7vsZO2hhBZPuLoLECw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE8iBfeuodTO7C=0EUOkqv16008h7vsZO2hhBZPuLoLECw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-28 11:03:56-0500, Jorge Lopez wrote:
> On Fri, Apr 28, 2023 at 10:36 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2023-04-28 10:24:40-0500, Jorge Lopez wrote:
> > > On Sun, Apr 23, 2023 at 7:01 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > > >
> > > > On 2023-04-20 11:54:48-0500, Jorge Lopez wrote:
> > > > > ---
> > > > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 613 +++++++++++++++++++
> > > > >  1 file changed, 613 insertions(+)
> > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h

<snip>

> > > > > +#define ATTRIBUTE_PROPERTY_STORE(curr_val, type)                     \
> > > > > +     static ssize_t curr_val##_store(struct kobject *kobj,           \
> > > > > +                                     struct kobj_attribute *attr,    \
> > > > > +                                     const char *buf, size_t count)  \
> > > > > +     {                                                               \
> > > > > +             char *p = NULL;                                         \
> > > > > +             char *attr_value = NULL;                                \
> > > > > +             int i;                                                  \
> > > > > +             int ret = -EIO;                                         \
> > > > > +                                                                     \
> > > > > +             attr_value = kstrdup(buf, GFP_KERNEL);                  \
> > > > > +             if (!attr_value)                                        \
> > > > > +                     return -ENOMEM;                                 \
> > > > > +                                                                     \
> > > > > +             p = memchr(attr_value, '\n', count);                    \
> > > > > +             if (p != NULL)                                          \
> > > > > +                     *p = '\0';                                      \
> > > >
> > > > This can also truncate the string if there is data after the newline.
> > >
> > > This is a expected behavior as described by Hans in a later email
> >
> > I'm fine with stripping a trailing newline.
> >
> > But this truncates the string at the first newline.
> >
> > "foo\nbar" -> "foo"
> > "\nfoo" -> ""
> >
> All inputs expected by this driver and respectively by BIOS are a
> single line.  For this reason, '\n' will cause the string to be
> truncated.
> I propose reporting a warning message indicating that the data entered
> has a '\n' character and will be truncated in addition to failing the
> operation with -EINVAL

EINVAL sounds good, but a warning is overkill IMO.

Whoever put in the garbage value will see the error.

Stripping a trailing newline still seems fine though.
This would be a very good candidate for a helper function.
