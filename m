Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7079C62C793
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiKPSX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiKPSXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:23:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4BE1DDCB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:23:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so2284876wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQjjMAQrrpASdD1L3n0QEFScybOlfh9l9bOTXc5TLUI=;
        b=AHSsEKDCZzvtWJkmy8woQvs6bKRrig5EHuBKPrPN0ravNbsiSOcvwPNFe06SPbtfJN
         /Z7AIjraaP+wrM7JKqUsWWT5HEPSWnJZz6AEXGuMn2wwyyV3n+NZxpWD3//N+OWv01E9
         NRhi317R3jfdOlBZTpvD9k0Pzljwk9WsBEzFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQjjMAQrrpASdD1L3n0QEFScybOlfh9l9bOTXc5TLUI=;
        b=neRDQ0qn8IBu2b1ONFsSZmM5EP15Th4an1QslUqSC/yD0OPoC1vWiHKV/5CF0QUm1Y
         kPQ5qvRWOorQYCkSQp8HcWUItv75+qmZHyou2QQuaikqiBmnakMm/oH90i5amVxFuB1s
         k6Wpl8/BE7f1RYQotMw3qC4uxesl0j4viPh4esRYQmE0Pt96CJpCxgnjDRFlqv8YQS99
         G63C3M+eOKXYXYmM98v1843np3lhQXSBzLir0652F8vAZBD0eZh5BXimcY5VPs84rfmM
         ZVsgcoE3uXQxUOfOiLstJYJKRV5fASCO2gX/GPMfFwjmqBPsiBHkdsBI4jhOHnT02e7p
         DR/A==
X-Gm-Message-State: ANoB5plDmuzWyZhHXH95fadzNXc4DeBgvgvnNY9olCC1rB2SaBVvNe4y
        sSkTnKRqrhHJjgP3p26T3INFgbfaZVO0KjWf4wLM+g==
X-Google-Smtp-Source: AA0mqf6PREhIqQFRTNwmNtN/1+ZAnN20ckUWwjWs3PeprIKnB+yvmUJX+i1K9IgGzYG3vHJlOXS1R/LeGk2IBSqBZmY=
X-Received: by 2002:a05:600c:601f:b0:3c6:e369:e856 with SMTP id
 az31-20020a05600c601f00b003c6e369e856mr3032899wmb.35.1668623029281; Wed, 16
 Nov 2022 10:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20210804213139.4139492-1-gwendal@chromium.org>
 <20210804213139.4139492-2-gwendal@chromium.org> <CAPUE2usQX_uQewpCYOs3SRUo7vDDMfg=n7idNvCgThDHMqTf7w@mail.gmail.com>
In-Reply-To: <CAPUE2usQX_uQewpCYOs3SRUo7vDDMfg=n7idNvCgThDHMqTf7w@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 16 Nov 2022 10:23:38 -0800
Message-ID: <CAPUE2uuj1qde16QWHb=0+yMW3ERhXzV7ehGcViWCfij7ADeyWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] platform/chrome: Poke kb_wake_angle attribute
 visibility when needed
To:     dtor@chromium.org, jwerner@chromium.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+chrome-platform@lists.linux.dev]

On Mon, Nov 14, 2022 at 8:10 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> This patch is still needed to get the attribute to be present on most machines.
> Putting the attribute in the sensor hub device is more complicated, as
> that device is not as easily findable as `cros_ec`, present in
> `/sys/class`.
>
> Gwendal.
>
> On Wed, Aug 4, 2021 at 2:31 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > When the sensorhub detects 2 accelerometers, kb_wake_angle attribute
> > in the chromeos EC class device needs to be visible.
> > When detected, the sensorhub requests the class device to
> > revisit the visibility of the kb_wake_angle attribute.
> > Expose the attribute group to alter to close a potiential race between
> > cros-ec-sensorhub and cros-ec-sysfs (that creates the attribute group
> > on behalf of the class driver).
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_sensorhub.c | 6 +++++-
> >  drivers/platform/chrome/cros_ec_sysfs.c     | 5 +++--
> >  include/linux/platform_data/cros_ec_proto.h | 2 ++
> >  3 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
> > index 9c4af76a9956e..8f24ed90b229c 100644
> > --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> > +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> > @@ -106,8 +106,12 @@ static int cros_ec_sensorhub_register(struct device *dev,
> >                 sensor_type[sensorhub->resp->info.type]++;
> >         }
> >
> > -       if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
> > +       if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
> >                 ec->has_kb_wake_angle = true;
> > +               if (ec->group && sysfs_update_group(&ec->class_dev.kobj,
> > +                                                   ec->group))
> > +                       dev_warn(dev, "Unable to update cros-ec-sysfs");
> > +       }
> >
> >         if (cros_ec_check_features(ec,
> >                                    EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> > diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> > index f07eabcf9494c..17fe657f3ffd5 100644
> > --- a/drivers/platform/chrome/cros_ec_sysfs.c
> > +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> > @@ -341,7 +341,8 @@ static int cros_ec_sysfs_probe(struct platform_device *pd)
> >         struct device *dev = &pd->dev;
> >         int ret;
> >
> > -       ret = sysfs_create_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
> > +       ec_dev->group = &cros_ec_attr_group;
> > +       ret = sysfs_create_group(&ec_dev->class_dev.kobj, ec_dev->group);
> >         if (ret < 0)
> >                 dev_err(dev, "failed to create attributes. err=%d\n", ret);
> >
> > @@ -352,7 +353,7 @@ static int cros_ec_sysfs_remove(struct platform_device *pd)
> >  {
> >         struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> >
> > -       sysfs_remove_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
> > +       sysfs_remove_group(&ec_dev->class_dev.kobj, ec_dev->group);
> >
> >         return 0;
> >  }
> > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > index 02599687770c5..c6dca260bbd5d 100644
> > --- a/include/linux/platform_data/cros_ec_proto.h
> > +++ b/include/linux/platform_data/cros_ec_proto.h
> > @@ -191,6 +191,7 @@ struct cros_ec_platform {
> >  /**
> >   * struct cros_ec_dev - ChromeOS EC device entry point.
> >   * @class_dev: Device structure used in sysfs.
> > + * @groups: sysfs attributes groups for this EC.
> >   * @ec_dev: cros_ec_device structure to talk to the physical device.
> >   * @dev: Pointer to the platform device.
> >   * @debug_info: cros_ec_debugfs structure for debugging information.
> > @@ -200,6 +201,7 @@ struct cros_ec_platform {
> >   */
> >  struct cros_ec_dev {
> >         struct device class_dev;
> > +       const struct attribute_group *group;
> >         struct cros_ec_device *ec_dev;
> >         struct device *dev;
> >         struct cros_ec_debugfs *debug_info;
> > --
> > 2.32.0.554.ge1b32706d8-goog
> >
