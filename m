Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F696E96A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjDTOG1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDTOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:06:23 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE71BE3;
        Thu, 20 Apr 2023 07:06:21 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-506bcf9aa50so255456a12.1;
        Thu, 20 Apr 2023 07:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681999579; x=1684591579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jgg7OX/T96wNa/Haq/69/L0IA2HKROIWIem4E4UL828=;
        b=gLnSZXFo6V2i+tP664G3D1rrx6DXVFhongEIx0E40q+L/9ua5eluS8xX+X4mvFsJuU
         dHn9l7OaFiWlknnh7Agw5bUOSGGC/MCzIM0F5fZePcbeflSxmJeQfpB7jc+DsiZ5rrZl
         KKZgYijjfmNWI4OXqdtCyIeReoYO9ijIsFeCfuaq8ApIPzFwSikwTDWUMVkjb8t7SKGg
         4pRILbNUFWTHqlqLxSvpPn1r/106xPES0xOHOx1um8QwyplamCJoIRlZ/eQfWEPCOCy2
         o2VAH+EAY3j3SGNfS0vJFbUgKKtk7iL2S/oHNbo+7V5P4WKh39TNXjkfm7mxAatIAe9b
         XIhQ==
X-Gm-Message-State: AAQBX9cPIAgeewwa8FeMB+1AvuALSuPUQ1SiGORgu/w+WqduEjWBLwga
        SvXlLSTqXJ4E87TWgmV1BJhfGFNMKf8g6U7P46ZTUK9t
X-Google-Smtp-Source: AKy350Y9l+3RrBgnRt/ZsV97ky+Whhpraic1B8yk+LoKwK10xK2yro9LelhgWAoWXJW7Fm9Jt9OAbZ7Gg74wD/zZwus=
X-Received: by 2002:a17:906:35d1:b0:94f:4ec3:f0f5 with SMTP id
 p17-20020a17090635d100b0094f4ec3f0f5mr1583546ejb.4.1681999579416; Thu, 20 Apr
 2023 07:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230419164127.3773278-1-linux@roeck-us.net>
In-Reply-To: <20230419164127.3773278-1-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Apr 2023 16:06:08 +0200
Message-ID: <CAJZ5v0gmDgb+VFwZecbKrbiBejAvODT38Ws=B_wGEGeBHTGR+Q@mail.gmail.com>
Subject: Re: [PATCH] device property: make device_property functions take
 const device *
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 6:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> device_property functions do not modify the device pointer passed to them.
> The underlying of_device and fwnode_ functions actually already take
> const * arguments. Mark the parameter constant to simplify conversion
> from of_property to device_property functions, and to let the calling code
> use const device pointers where possible.
>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> Found by Chris when trying to convert a driver from of_property_ to
> device_property_ functions. I don't really see a reason why the device
> parameter to device_property functions should not be const.
> Please let me know if I am missing sonething.
>
>  drivers/base/property.c  | 16 ++++++++--------
>  include/linux/property.h | 36 ++++++++++++++++++------------------
>  2 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 083a95791d3b..21d7a5d13e05 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -38,7 +38,7 @@ EXPORT_SYMBOL_GPL(__dev_fwnode_const);
>   *
>   * Check if property @propname is present in the device firmware description.
>   */
> -bool device_property_present(struct device *dev, const char *propname)
> +bool device_property_present(const struct device *dev, const char *propname)
>  {
>         return fwnode_property_present(dev_fwnode(dev), propname);
>  }
> @@ -86,7 +86,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_present);
>   *        %-EOVERFLOW if the size of the property is not as expected.
>   *        %-ENXIO if no suitable firmware interface is present.
>   */
> -int device_property_read_u8_array(struct device *dev, const char *propname,
> +int device_property_read_u8_array(const struct device *dev, const char *propname,
>                                   u8 *val, size_t nval)
>  {
>         return fwnode_property_read_u8_array(dev_fwnode(dev), propname, val, nval);
> @@ -114,7 +114,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u8_array);
>   *        %-EOVERFLOW if the size of the property is not as expected.
>   *        %-ENXIO if no suitable firmware interface is present.
>   */
> -int device_property_read_u16_array(struct device *dev, const char *propname,
> +int device_property_read_u16_array(const struct device *dev, const char *propname,
>                                    u16 *val, size_t nval)
>  {
>         return fwnode_property_read_u16_array(dev_fwnode(dev), propname, val, nval);
> @@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u16_array);
>   *        %-EOVERFLOW if the size of the property is not as expected.
>   *        %-ENXIO if no suitable firmware interface is present.
>   */
> -int device_property_read_u32_array(struct device *dev, const char *propname,
> +int device_property_read_u32_array(const struct device *dev, const char *propname,
>                                    u32 *val, size_t nval)
>  {
>         return fwnode_property_read_u32_array(dev_fwnode(dev), propname, val, nval);
> @@ -170,7 +170,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u32_array);
>   *        %-EOVERFLOW if the size of the property is not as expected.
>   *        %-ENXIO if no suitable firmware interface is present.
>   */
> -int device_property_read_u64_array(struct device *dev, const char *propname,
> +int device_property_read_u64_array(const struct device *dev, const char *propname,
>                                    u64 *val, size_t nval)
>  {
>         return fwnode_property_read_u64_array(dev_fwnode(dev), propname, val, nval);
> @@ -198,7 +198,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
>   *        %-EOVERFLOW if the size of the property is not as expected.
>   *        %-ENXIO if no suitable firmware interface is present.
>   */
> -int device_property_read_string_array(struct device *dev, const char *propname,
> +int device_property_read_string_array(const struct device *dev, const char *propname,
>                                       const char **val, size_t nval)
>  {
>         return fwnode_property_read_string_array(dev_fwnode(dev), propname, val, nval);
> @@ -220,7 +220,7 @@ EXPORT_SYMBOL_GPL(device_property_read_string_array);
>   *        %-EPROTO or %-EILSEQ if the property type is not a string.
>   *        %-ENXIO if no suitable firmware interface is present.
>   */
> -int device_property_read_string(struct device *dev, const char *propname,
> +int device_property_read_string(const struct device *dev, const char *propname,
>                                 const char **val)
>  {
>         return fwnode_property_read_string(dev_fwnode(dev), propname, val);
> @@ -242,7 +242,7 @@ EXPORT_SYMBOL_GPL(device_property_read_string);
>   *        %-EPROTO if the property is not an array of strings,
>   *        %-ENXIO if no suitable firmware interface is present.
>   */
> -int device_property_match_string(struct device *dev, const char *propname,
> +int device_property_match_string(const struct device *dev, const char *propname,
>                                  const char *string)
>  {
>         return fwnode_property_match_string(dev_fwnode(dev), propname, string);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 0a29db15ff34..66fe73ee430d 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -40,20 +40,20 @@ struct fwnode_handle *__dev_fwnode(struct device *dev);
>                  const struct device *: __dev_fwnode_const,     \
>                  struct device *: __dev_fwnode)(dev)
>
> -bool device_property_present(struct device *dev, const char *propname);
> -int device_property_read_u8_array(struct device *dev, const char *propname,
> +bool device_property_present(const struct device *dev, const char *propname);
> +int device_property_read_u8_array(const struct device *dev, const char *propname,
>                                   u8 *val, size_t nval);
> -int device_property_read_u16_array(struct device *dev, const char *propname,
> +int device_property_read_u16_array(const struct device *dev, const char *propname,
>                                    u16 *val, size_t nval);
> -int device_property_read_u32_array(struct device *dev, const char *propname,
> +int device_property_read_u32_array(const struct device *dev, const char *propname,
>                                    u32 *val, size_t nval);
> -int device_property_read_u64_array(struct device *dev, const char *propname,
> +int device_property_read_u64_array(const struct device *dev, const char *propname,
>                                    u64 *val, size_t nval);
> -int device_property_read_string_array(struct device *dev, const char *propname,
> +int device_property_read_string_array(const struct device *dev, const char *propname,
>                                       const char **val, size_t nval);
> -int device_property_read_string(struct device *dev, const char *propname,
> +int device_property_read_string(const struct device *dev, const char *propname,
>                                 const char **val);
> -int device_property_match_string(struct device *dev,
> +int device_property_match_string(const struct device *dev,
>                                  const char *propname, const char *string);
>
>  bool fwnode_property_present(const struct fwnode_handle *fwnode,
> @@ -143,57 +143,57 @@ int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
>
>  unsigned int device_get_child_node_count(const struct device *dev);
>
> -static inline bool device_property_read_bool(struct device *dev,
> +static inline bool device_property_read_bool(const struct device *dev,
>                                              const char *propname)
>  {
>         return device_property_present(dev, propname);
>  }
>
> -static inline int device_property_read_u8(struct device *dev,
> +static inline int device_property_read_u8(const struct device *dev,
>                                           const char *propname, u8 *val)
>  {
>         return device_property_read_u8_array(dev, propname, val, 1);
>  }
>
> -static inline int device_property_read_u16(struct device *dev,
> +static inline int device_property_read_u16(const struct device *dev,
>                                            const char *propname, u16 *val)
>  {
>         return device_property_read_u16_array(dev, propname, val, 1);
>  }
>
> -static inline int device_property_read_u32(struct device *dev,
> +static inline int device_property_read_u32(const struct device *dev,
>                                            const char *propname, u32 *val)
>  {
>         return device_property_read_u32_array(dev, propname, val, 1);
>  }
>
> -static inline int device_property_read_u64(struct device *dev,
> +static inline int device_property_read_u64(const struct device *dev,
>                                            const char *propname, u64 *val)
>  {
>         return device_property_read_u64_array(dev, propname, val, 1);
>  }
>
> -static inline int device_property_count_u8(struct device *dev, const char *propname)
> +static inline int device_property_count_u8(const struct device *dev, const char *propname)
>  {
>         return device_property_read_u8_array(dev, propname, NULL, 0);
>  }
>
> -static inline int device_property_count_u16(struct device *dev, const char *propname)
> +static inline int device_property_count_u16(const struct device *dev, const char *propname)
>  {
>         return device_property_read_u16_array(dev, propname, NULL, 0);
>  }
>
> -static inline int device_property_count_u32(struct device *dev, const char *propname)
> +static inline int device_property_count_u32(const struct device *dev, const char *propname)
>  {
>         return device_property_read_u32_array(dev, propname, NULL, 0);
>  }
>
> -static inline int device_property_count_u64(struct device *dev, const char *propname)
> +static inline int device_property_count_u64(const struct device *dev, const char *propname)
>  {
>         return device_property_read_u64_array(dev, propname, NULL, 0);
>  }
>
> -static inline int device_property_string_array_count(struct device *dev,
> +static inline int device_property_string_array_count(const struct device *dev,
>                                                      const char *propname)
>  {
>         return device_property_read_string_array(dev, propname, NULL, 0);
> --
> 2.39.2
>
