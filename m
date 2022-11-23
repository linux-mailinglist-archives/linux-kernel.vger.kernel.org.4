Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA9C63695A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbiKWSz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiKWSz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:55:56 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C1688F9F;
        Wed, 23 Nov 2022 10:55:55 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id j26so5968953qki.10;
        Wed, 23 Nov 2022 10:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7s6lbvc7lHM7l6f8IQURXuINfb0VjPAm0oTGMN2Eeg=;
        b=WuxKzdF1+aSxNewHv28NlTwesbEkehJdv/BI/kDap1px1M/byLdic4/Dp8WW2DxDrX
         pMEUXmfkSzj8ByzEgFw2YpRkpA2qxlSbnHN6U82cP/ZaioY7rVtWV6nghowfCLbtcClQ
         YgNog1GZnHlUdJdpsgY/ge/PCASxw9M+adjWvxn/aeLca8BDu33av84Uqn6yzjc0S3Uw
         VqH9lNvLmEU5SVe9uIM0SnZffplt7IJ+9n14CeJZkFLjC8tFwnHc7t7Q2yOrl8guztjc
         bQspq0Z279CkgGm2J6Hx8WqCIDFLXd31Ku1Flwh1SzEkV3qtRDnsmipH1amnZwnULW2S
         cl6w==
X-Gm-Message-State: ANoB5plzq2Schto1HhsNz6hJfR5hb88nncjflpJy/Mn37Sp0fj+4+bXH
        /N1u9b2Q94BDBGUcYIK0Jeq0rJYyJhQl47CVoX+OlzyiPE8=
X-Google-Smtp-Source: AA0mqf6shJnjTHqj6dLYBj9ePLdTskc4CscgrYQd0L3ZDN9Khn97ScUVPCcoqITVwY4Dt41j8gvKbRi8Wjm77bNJpro=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr25845781qkb.443.1669229755043; Wed, 23
 Nov 2022 10:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 19:55:44 +0100
Message-ID: <CAJZ5v0gewC7z5XY+r8=2bkOAO2y8q7VVbrazj0z+4xGRR2Bkew@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] device property: Get rid of __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 2:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> First of all, _ELEMENT_SIZE() repeats existing sizeof_field() macro.
> Second, usage of _ARRAY_ELSIZE_LEN() adds unnecessary indirection
> to the data layout. It's more understandable when the data structure
> is placed explicitly. That said, get rid of those macros by replacing
> them with the existing helper and explicit data structure layout.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The series in which this patch is included does not apply cleanly for me.

I guess it depends on the earlier material already in Greg's tree, so
I'm leaving it to Greg.

> ---
> v4: added tag (Heikki)
> v3: fixed typo in PROPERTY_ENTRY_REF_ARRAY_LEN() impl (LKP)
> v2: rebased on latest Linux Next, fixed anon union assignment
>  include/linux/property.h | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 5d840299146d..0eab13a5c7df 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -12,6 +12,7 @@
>
>  #include <linux/bits.h>
>  #include <linux/fwnode.h>
> +#include <linux/stddef.h>
>  #include <linux/types.h>
>
>  struct device;
> @@ -311,24 +312,14 @@ struct property_entry {
>   * crafted to avoid gcc-4.4.4's problems with initialization of anon unions
>   * and structs.
>   */
> -
> -#define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)                          \
> -       sizeof(((struct property_entry *)NULL)->value._elem_[0])
> -
> -#define __PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_, _elsize_, _Type_,    \
> -                                         _val_, _len_)                 \
> -(struct property_entry) {                                              \
> -       .name = _name_,                                                 \
> -       .length = (_len_) * (_elsize_),                                 \
> -       .type = DEV_PROP_##_Type_,                                      \
> -       { .pointer = _val_ },                                           \
> +#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)               \
> +(struct property_entry) {                                                              \
> +       .name = _name_,                                                                 \
> +       .length = (_len_) * sizeof_field(struct property_entry, value._elem_[0]),       \
> +       .type = DEV_PROP_##_Type_,                                                      \
> +       { .pointer = _val_ },                                                           \
>  }
>
> -#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
> -       __PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,                       \
> -                               __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),  \
> -                               _Type_, _val_, _len_)
> -
>  #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)              \
>         __PROPERTY_ENTRY_ARRAY_LEN(_name_, u8_data, U8, _val_, _len_)
>  #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)             \
> @@ -340,9 +331,12 @@ struct property_entry {
>  #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)          \
>         __PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
>  #define PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, _len_)             \
> -       __PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,                       \
> -                               sizeof(struct software_node_ref_args),  \
> -                               REF, _val_, _len_)
> +(struct property_entry) {                                              \
> +       .name = _name_,                                                 \
> +       .length = (_len_) * sizeof(struct software_node_ref_args),      \
> +       .type = DEV_PROP_REF,                                           \
> +       { .pointer = _val_ },                                           \
> +}
>
>  #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)                         \
>         PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
> @@ -360,7 +354,7 @@ struct property_entry {
>  #define __PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)                \
>  (struct property_entry) {                                              \
>         .name = _name_,                                                 \
> -       .length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),                \
> +       .length = sizeof_field(struct property_entry, value._elem_[0]), \
>         .is_inline = true,                                              \
>         .type = DEV_PROP_##_Type_,                                      \
>         { .value = { ._elem_[0] = _val_ } },                            \
> --
> 2.35.1
>
