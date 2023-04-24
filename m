Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE9C6ED681
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjDXVEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjDXVEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:04:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5789E6185;
        Mon, 24 Apr 2023 14:04:18 -0700 (PDT)
Date:   Mon, 24 Apr 2023 23:04:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682370255; bh=PZbcpsup20QeRuaUGzcXEPgVVxiaSu5FYW4sV+lkMQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOBRPp4wYWAM0cZtj0ag+vmiLp2ENK3L35Y/b5jamskGrcvrveF+RBAyWIMED3Cjc
         uUdNYqphtnnX572/gARhlTHfJUWU7oncdjs/P2LbFV7tZJFllw+5oulKVEtnv1Wa35
         TGCAvc8gHEGWvOITzIGQjhKPXvgpsS/fLOVifnIs=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 02/14] HP BIOSCFG driver - biosattr-interface
Message-ID: <67108caf-2a03-4ef0-9f8d-819b0d6f0a2e@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-3-jorge.lopez2@hp.com>
 <b7c49593-13f9-44f8-b3b8-66551b01e966@t-8ch.de>
 <CAOOmCE_MdHnPb250DDYC6Hoqutod2m=2voBqFz4g0dLcmJ5PRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE_MdHnPb250DDYC6Hoqutod2m=2voBqFz4g0dLcmJ5PRQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-24 15:33:26-0500, Jorge Lopez wrote:
> Hi Thomas,
> 
> Please see my comments below.
> 
> On Sat, Apr 22, 2023 at 4:30 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > Hi Jorge,
> >
> > checkpatch.pl finds some issues on your patches.
> > Please make sure checkpath.pl --strict is happy.
> >
> I wasn't aware of the '--strict' parameter.  It is not part of the
> help information for checkpath.pl tool.
> Nonetheless, I will use it forward.
> Thanks

It's an alias to --subjective. But indeed, it's hard to see in the help
output.

> > On 2023-04-20 11:54:42-0500, Jorge Lopez wrote:
> > > ---
> > > Based on the latest platform-drivers-x86.git/for-next
> > No need to initialize auth_token_choice and start.
> > Consider coalescing variable declaration to avoid wasting vertical
> > space.
> >
> Done!

Please note that this affects many parts of the driver,
try to fix it everywhere.

> > > +{
> > > +     struct acpi_buffer input, output = { ACPI_ALLOCATE_BUFFER, NULL };
> > > +     struct bios_return *bios_return;
> > > +     union acpi_object *obj = NULL;
> > > +     struct bios_args *args = NULL;
> > > +     int mid, actual_outsize;
> > > +     size_t bios_args_size;
> > > +     int ret;
> > > +
> > > +     mid = encode_outsize_for_pvsz(outsize);
> > > +     if (WARN_ON(mid < 0))
> > > +             return mid;
> > > +
> > > +     bios_args_size = struct_size(args, data, insize);
> > > +     args = kmalloc(bios_args_size, GFP_KERNEL);
> > > +     if (!args)
> > > +             return -ENOMEM;
> > > +
> > > +     input.length = bios_args_size;
> > > +     input.pointer = args;
> > > +
> > > +     args->signature = 0x55434553;
> >
> > What does this number mean?
> This is a HEX representation of the word  'SECU' expected by BIOS as a signa.

Sounds like a good thing to comment or put into a #define.

> >
> > > +     args->command = command;
> > > +     args->commandtype = query;
> > > +     args->datasize = insize;
> > > +     memcpy(args->data, buffer, flex_array_size(args, data, insize));
> > > +
> > > +     ret = wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &input, &output);
> >
> > The driver is mixing calls to the UUID based APIs and the wmi_device
> > ones.
> > wmi_devices is newer and preferred.
> 
> The driver  calls wmi_evaluate_method when initiating an WMI call.
> Where is the driver mixing calls to the UUID based APIs and the
> wmi_device one?
> WMI calls are made by calling hp_wmi_perform_query() which invokes
> wmi_evaluate_method().
> Did I miss something?

wmi_evaluate_method() is UUID-based.
struct wmi_driver is wmi_device based.

The wmi_driver/wmi_device code essentially does nothing and is only used
to validate that a device is present.
The same can be done more easily wmi_has_guid().

> >
> > > +     bioscfg_wmi_error_and_message(ret);
> > > +
> > > +     if (ret)
> > > +             goto out_free;
> > > +
> > > +     obj = output.pointer;
> > > +     if (!obj) {
> > > +             ret = -EINVAL;
> > > +             goto out_free;
> > > +     }
> > > +     if (query != HPWMI_SECUREPLATFORM_GET_STATE &&
> > > +         command != HPWMI_SECUREPLATFORM)
> > > +             if (obj->type != ACPI_TYPE_BUFFER ||
> > > +                 obj->buffer.length < sizeof(*bios_return)) {
> > > +                     pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
> > > +                     ret = -EINVAL;
> > > +                     goto out_free;
> > > +             }
> > > +
> > > +
> > > +     bios_return = (struct bios_return *)obj->buffer.pointer;
> >
> > For query == HPWMI_SECUREPLATFORM_GET_STATE && command == HPWMI_SECUREPLATFORM
> > this is not guaranteed to be a buffer.
> 
> BIOS ensures the output is of buffer type and  buffer of 1024 bytes in
> size.  This check also help us validate that BIOS only returns a
> buffer type for this query/command type.

The kernel does not trust the BIOS :-)
It trusts nothing and nobody.

All cases should be validated.

> >
> > > + */
> > > +void *ascii_to_utf16_unicode(u16 *p, const u8 *str)
> > > +{
> > > +     int len = strlen(str);
> > > +     int ret;
> > > +
> > > +     /*
> > > +      * Add null character when reading an empty string
> > > +      * "02 00 00 00"
> > > +      */
> > > +     if (len == 0)
> > > +             return utf16_empty_string(p);
> > > +
> > > +     /* Move pointer len * 2 number of bytes */
> > > +     *p++ = len * 2;
> > > +     ret = utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN, p, len);
> > > +     if (ret < 0) {
> > > +             dev_err(bioscfg_drv.class_dev, "UTF16 conversion failed\n");
> > > +             goto ascii_to_utf16_unicode_out;
> > > +     }
> >
> > What if ret != len ?
> 
> only in conditions where utf8s_to_utf16s an error, we can state  ret != len.
> ret == len when utf8s_to_utf16s() is successful.
> >
> > > +
> > > +     if ((ret * sizeof(u16)) > U16_MAX) {
> > > +             dev_err(bioscfg_drv.class_dev, "Error string too long\n");
> > > +             goto ascii_to_utf16_unicode_out;
> > > +     }
> > > +
> > > +ascii_to_utf16_unicode_out:
> > > +     p += len;
> >
> > In cases of errors this will still point to the end of the data that
> > should have been written but was not actually written.
> > The caller has no way to recognize the error case.
> >
> That is correct.  If an error occurs, we only provide an error message
> for those conditions.

But the caller has no idea that this error occurred and will try to use
the garbage buffer.
The error should be communicated to the caller, and the caller has to
validate the result.
Maybe return NULL?

> 
> > > +     return p;
> > > +}
> > > +
> > > +/*
> >
> > kernel-doc comments start with "/**". Note the two asterisks.
> Done

This also needs to be done all over the driver.
