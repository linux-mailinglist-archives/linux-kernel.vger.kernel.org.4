Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397E162911C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 05:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKOEKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 23:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKOEKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 23:10:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97134F5AE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:10:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g12so21942306wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IElvyJJPBw9r+gdipVqwpElhrsenjulEC/tqTO1F0KQ=;
        b=c5fllgJIvec+jdDG6e5FKyzgRx3R5vhaKAj3ul8IPRhxKBKvIhadw7hIl2ygO5EVIf
         vkr2jthATA04vEQnY1Lz1OH51YXuvbkNN6nMUVTbFKdr/tebsWAdGov4Vrn15JeLtJVw
         w+YOv1pz24pxLKlM6e6jPa6e95H+O6C+OLoYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IElvyJJPBw9r+gdipVqwpElhrsenjulEC/tqTO1F0KQ=;
        b=pFEsUskUcZOvwcKtjes6jd+ge1a6wttm6A74VASOiKHt+a0tznxlsQAJQDERlHC6SS
         kpJw9odhce8jx8HsXt1Gm7hhslOVC0rAVpPJL74P1KkRbh1RQ8cFCs1XeSuJHTP1E1Fy
         WAKLaxzbesOpaYTE/CgfkRXDWAI66wXcAe8bIUZ1UNa7dE9iPb2h5Ts6xyqp5epi8DCp
         qaf15GLVnDyRutc+HLq4wXK2a+61JiN/NcIiAiN5QxF6geP0WhbeFJ4qFMnYcBcaEIfA
         +i8y7PtxWSMFPPRrA78dAbEYA3uUpPMEOAJR+qcrwoe/EVO+pPwF1IncdrjqghhuQKy4
         dsRg==
X-Gm-Message-State: ANoB5plZCJX2V1mHHeoPYQua1FVLrcc4UkebUmsMkDmt6tC8JzOawyMu
        7is/vpM3R1W/dKzM3g/18075htBLryaNERj5n2fKEg==
X-Google-Smtp-Source: AA0mqf7oXuSo3jnPwsnYi7JaHs7ijwDEFYYxyEJUlBH/9vuOHEop55zJ4FhKltgKO8GEUF8qT6+nc6YbI7xwyYfRjGA=
X-Received: by 2002:adf:f009:0:b0:236:657e:757e with SMTP id
 j9-20020adff009000000b00236657e757emr9444021wro.350.1668485440108; Mon, 14
 Nov 2022 20:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20210804213139.4139492-1-gwendal@chromium.org> <20210804213139.4139492-2-gwendal@chromium.org>
In-Reply-To: <20210804213139.4139492-2-gwendal@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 14 Nov 2022 20:10:29 -0800
Message-ID: <CAPUE2usQX_uQewpCYOs3SRUo7vDDMfg=n7idNvCgThDHMqTf7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] platform/chrome: Poke kb_wake_angle attribute
 visibility when needed
To:     dtor@chromium.org, jwerner@chromium.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is still needed to get the attribute to be present on most machines.
Putting the attribute in the sensor hub device is more complicated, as
that device is not as easily findable as `cros_ec`, present in
`/sys/class`.

Gwendal.

On Wed, Aug 4, 2021 at 2:31 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> When the sensorhub detects 2 accelerometers, kb_wake_angle attribute
> in the chromeos EC class device needs to be visible.
> When detected, the sensorhub requests the class device to
> revisit the visibility of the kb_wake_angle attribute.
> Expose the attribute group to alter to close a potiential race between
> cros-ec-sensorhub and cros-ec-sysfs (that creates the attribute group
> on behalf of the class driver).
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_sensorhub.c | 6 +++++-
>  drivers/platform/chrome/cros_ec_sysfs.c     | 5 +++--
>  include/linux/platform_data/cros_ec_proto.h | 2 ++
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
> index 9c4af76a9956e..8f24ed90b229c 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -106,8 +106,12 @@ static int cros_ec_sensorhub_register(struct device *dev,
>                 sensor_type[sensorhub->resp->info.type]++;
>         }
>
> -       if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
> +       if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
>                 ec->has_kb_wake_angle = true;
> +               if (ec->group && sysfs_update_group(&ec->class_dev.kobj,
> +                                                   ec->group))
> +                       dev_warn(dev, "Unable to update cros-ec-sysfs");
> +       }
>
>         if (cros_ec_check_features(ec,
>                                    EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index f07eabcf9494c..17fe657f3ffd5 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -341,7 +341,8 @@ static int cros_ec_sysfs_probe(struct platform_device *pd)
>         struct device *dev = &pd->dev;
>         int ret;
>
> -       ret = sysfs_create_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
> +       ec_dev->group = &cros_ec_attr_group;
> +       ret = sysfs_create_group(&ec_dev->class_dev.kobj, ec_dev->group);
>         if (ret < 0)
>                 dev_err(dev, "failed to create attributes. err=%d\n", ret);
>
> @@ -352,7 +353,7 @@ static int cros_ec_sysfs_remove(struct platform_device *pd)
>  {
>         struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
>
> -       sysfs_remove_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
> +       sysfs_remove_group(&ec_dev->class_dev.kobj, ec_dev->group);
>
>         return 0;
>  }
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 02599687770c5..c6dca260bbd5d 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -191,6 +191,7 @@ struct cros_ec_platform {
>  /**
>   * struct cros_ec_dev - ChromeOS EC device entry point.
>   * @class_dev: Device structure used in sysfs.
> + * @groups: sysfs attributes groups for this EC.
>   * @ec_dev: cros_ec_device structure to talk to the physical device.
>   * @dev: Pointer to the platform device.
>   * @debug_info: cros_ec_debugfs structure for debugging information.
> @@ -200,6 +201,7 @@ struct cros_ec_platform {
>   */
>  struct cros_ec_dev {
>         struct device class_dev;
> +       const struct attribute_group *group;
>         struct cros_ec_device *ec_dev;
>         struct device *dev;
>         struct cros_ec_debugfs *debug_info;
> --
> 2.32.0.554.ge1b32706d8-goog
>
