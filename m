Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792EF6FB883
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjEHUup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjEHUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:50:43 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16694558B;
        Mon,  8 May 2023 13:50:41 -0700 (PDT)
Date:   Mon, 8 May 2023 22:50:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683579039; bh=dfn7KP7eW3b6FJAaT1K9Gf2p1Tfx4qQ+LXBw16Z3Bh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToQmI1vJ/m7Oq41eOFZnNCDxAJ3JMryjtxopQ32ZnuyzcYcqJAmAryxztFcbKIBj0
         mXoM4GhILSm8kifRMKJXHGQ7JzbtYXYCr4JYk0qthgb3NPDrSj9v2b6wy3WZSvGExo
         9cbtVzBZgZWtvvzHHM3T3lkB28THBSKNW81Y10vw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 05/14] HP BIOSCFG driver - ordered-attributes
Message-ID: <5662fa47-1156-459b-af86-31351d69cc3f@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-6-jorge.lopez2@hp.com>
 <24fb56f9-49c6-432d-8c2f-17df7f7e37b2@t-8ch.de>
 <CAOOmCE-HR205R2vjyZedDocZLwvMdk7B1w7w9HgdXaypTrBK+A@mail.gmail.com>
 <34539db1-98a4-4696-934b-af04d74720cc@t-8ch.de>
 <CAOOmCE_9fmLKgum9hYxPpa_BrX0FyFFz_dRUX8sNm9T2EUABMg@mail.gmail.com>
 <daf6a6e0-69cd-48a6-b61b-c893324323ff@t-8ch.de>
 <CAOOmCE-FNUUh+tZLPdJW+y5m0JKufWXiJ8M-7WFEiveNi4rRAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE-FNUUh+tZLPdJW+y5m0JKufWXiJ8M-7WFEiveNi4rRAg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-08 08:56:55-0500, Jorge Lopez wrote:
> On Sat, May 6, 2023 at 12:51 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2023-05-05 16:57:59-0500, Jorge Lopez wrote:
> > > On Fri, May 5, 2023 at 4:11 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > > >
> > > > On 2023-05-05 11:09:55-0500, Jorge Lopez wrote:
> > > > > On Sun, Apr 23, 2023 at 1:55 AM <thomas@t-8ch.de> wrote:
> > > > > >
> > > > > > On 2023-04-20 11:54:45-0500, Jorge Lopez wrote:
> > > > > > >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 563 ++++++++++++++++++
> > > > > > >  1 file changed, 563 insertions(+)
> > > > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > > > > >
> > > > > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..5e5d540f728d
> > > > > > > --- /dev/null
> 
> <snip>
> 
> > > > > > > +     elem_found = 0;
> > > > > > > +     while (elem_found < bioscfg_drv.ordered_list_data[instance_id].elements_size) {
> > > > > > > +
> > > > > > > +             value = strsep(&new_values, ",");
> > > > > >
> > > > > > The docs say the separator is semicolon.
> > > > >
> > > > > BIOS reports the current value using ',' as separator instead of ";".
> > > > >
> > > > > ./hp-bioscfg/attributes/UEFI Boot Order/current_value
> > > > > HDD:M.2:3,HDD:USB:1(Disabled),HDD:M.2:4,HDD:M.2:1,HDD:M.2:2,NETWORK
> > > > > IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK
> > > > > IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1
> > > > >
> > > > > To avoid having to convert from "," to ";" and vice versa, I will
> > > > > update the documentation to reflect the use of  "'," commas as the
> > > > > separator
> > > >
> > > > The enum data format uses ";". Therefore it makes sense to also stick to
> > > > ";".
> > > > The implementation detail of the BIOS using ',' should not matter to
> > > > users.
> > >
> > > The use of ',' does matter because BIOS expects the updated string to
> > > use commas as separators
> > > current_value is reported by BIOS using commas.  Any changes to the
> > > order of items in that string needs to use commas.
> > >
> > > The difference with enum is the fact the user needs to  enter only one
> > > value out of those possible values available and no separators are
> > > needed.
> > > For ordered attributes...
> > >
> > > when the current value  is "foo,bar,baz".   the user provides a string
> > > which items are ordered differently.  i.e. "baz,bar,foo"
> > > if the new string is using semicolon instead of comma for the
> > > separator, BIOS will reject the data.
> >
> > Of course the BIOS expects the format with comma.
> >
> > But the users of this API should not have to care about implementation
> > details like that.
> > They want a consistent API. As the ordered-list type is fairly general
> > it may be promoted to be a general attribute type later.
> >
> > If this happens the API can't be changed as that would break users of
> > hp-bioscfg. So either there would be two APIs for the ordered-list, one
> > for hp-bioscfg and one for all other drivers, or different attribute
> > types would use different kinds of separators.
> >
> > Was there an issue with the previous replacement logic?
> 
> No issue. I was anticipating a potential problem/confusion and created
> a solution.  Customers will start using this driver when it becomes
> part of the upstream code.
> Users primarily will use Powershell scripts to interact with the
> driver.  The use of powershell will require the user to have the
> knowledge and convert ';' semicolon to ',' commas prior to submitting
> the request to the driver.  AFIK, the boot order is one of those
> attributes that is not configured often by the user.  Just my opinion.

If this conversion is done by the driver why would the users have to
care?

> >
> > The whole point of device drivers is to translate general kernel APIs
> > into whatever a specific device needs, switching around ',' and ';'
> > seems not so bad.
> 
> So, are you saying, it is ok for the driver to convert  ';' semicolon
> to ',' commas prior to submitting a request  to change any attribute
> of type 'ordered-list' or when reading current value ?
> If that is correct, then we can change the documentation back to use
> ';' semicolons.
> Please confirm.

A device drivers task it to translate from the domain of the kernel and
its unified APIs to whatever a specific device needs.

If we agree that it is more consistent to use semicolons for class
firmware-attribute APIs then the driver would make sure that userspace
always sees semicolons while the ACPI calls always use commas.

This means translating semicolon->comma when writing to and
comma->semicolon when reading from ACPI.
Userspace should not be exposed to the implementation details but just
the consistent and documented kernel API.

> > > > > > > +             if (value != NULL) {
> > > > > > > +                     if (!*value)
> > > > > > > +                             continue;
> > > > > > > +                     elem_found++;
> > > > > > > +             }
> > > > > > > +
> > > > > > > +             found = 0;
> > > > > > > +             for (elem = 0; elem < bioscfg_drv.ordered_list_data[instance_id].elements_size; elem++) {
> > > > > > > +                     if (!strcasecmp(bioscfg_drv.ordered_list_data[instance_id].elements[elem], value)) {
> > > > > >
> > > > > > It's surprising that this is case-insensitive.
> > > > >
> > > > > As validated in earlier reviews,  BIOS rejects strings that do not
> > > > > match the internal values.
> > > > >
> 
> <snip>
> 
> > > > > > > +
> > > > > > > +     strscpy(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code,
> > > > > > > +             LANG_CODE_STR,
> > > > > > > +             sizeof(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code));
> > > > > >
> > > > > > This seems to be the same for every type. Can it not be moved into
> > > > > > common code?
> > > > >
> > > > > Each instance requires to report 'display_name_language_code' hence it
> > > > > cannot be moved to a common code.
> > > >
> > > > Can it every be different from LANG_CODE_STR?
> > >
> > > Yes.   The string currently is LANG_CODE_STR (en_US.UTF-8)  but it
> > > will change as the BIOS provides additional translations at a later
> > > time.
> > > This is a future enhancement for the driver.
> >
> > Is this planned for the near future?
> > And/Or already implemented in the BIOS?
> >
> > If there are no concrete plans to implement this soon, in my opinion,
> > it would be better to only introduce this code when it does something
> > useful.
> 
> There are no concrete plans yet for the driver.  BIOS provides
> translations for strings (F10) UI but the attributes are reported in
> English regardless of the language configured.
> firmware-attributes requires 'display_name_language_code' to be
> reported.  At this time, the driver can provide a common helper to
> assign the LANG_CODE_STR to the corresponding attribute.

Yes please.

Create an attribute in bioscfg.c that can be used in all the other
attribute_groups.

> > > > If not instead of having one kobj_attribute diplay_langcode for each
> > > > string/enum/integer/etc you could have one kobj_attribute defined in
> > > > bioscfg.c and then added to each string_attrs, enum_attrs...
> > > >
> > > > The _show() callback for this attribute would just return the constant
> > > > string.
> > > >
> > > > This removes the need for many attribute definition, members in the data
> > > > struct, initialization of these member...
