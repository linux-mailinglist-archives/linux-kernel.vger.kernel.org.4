Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AA9632368
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKUN0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKUN0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:26:46 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814D240467;
        Mon, 21 Nov 2022 05:26:45 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id h10so7959207qvq.7;
        Mon, 21 Nov 2022 05:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMCxxZGsTl/DsHAlAb9K2gPcoa3rE0jXnKHh3JJXIr8=;
        b=YS13pQXfSZuXWTGtO2JghNNEnLBIXl4GpzkpYe0Pxnvv2NdwvzQf9BmmPV9YUoA84A
         DcLlGdVbJ2YGxAATGLowLxrBrQr7Wvz5fwP63cEtYjZdADMpASzvPLCMiwU5X6pyXdBt
         d67j6jBLOd+W1P5szjuDer2zUivmDGK4UyNrge4VJVsCjZI22jmi1FO2VfqEo7kLcWLB
         4CSRqeufeOizAliuLeLWJxsGVvM2g2G/zykbNSmUO/ddlWmYVLPDETbA5uMMpSKMhTIv
         VrabeN29s3ftXACqPgrHj/wymebD0sj4RQunmrtJjIyFmYyxNDLSGbU2auTkROgOgPlH
         z6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMCxxZGsTl/DsHAlAb9K2gPcoa3rE0jXnKHh3JJXIr8=;
        b=WGXtbz1oOML7NU5au4EEc6z1CmmgESDp4wcmcAzbFGz7djSzO6/S7Sf2+pvnUsxdix
         BMplXOnm5Rl84Qxsz/uz1FahOxbz4/Vho0ewG+YqZeyMD0HbbfedjA/XH7pHzRS2+oWc
         N3sNPstyWSoraMDN3NxWPEAO/sK0l2F6UqWwqBr1Y48pGcY84MKWsAjO2Zrl7aSlQtka
         4GKM9T9RakPhoyjR7NP9v9h21EY1uZiV1zKCVwBcDcin77IodGwjEnfsrtg8WiSjSXXi
         mW8n1dvDe2jDY38e069+L4gmd1jwdF27uHfa9hI9skxeoGsl8bTO9fHS7JEAPc05XnAO
         dMDw==
X-Gm-Message-State: ANoB5pkvg5N+AqryGRbJ6T+SZn2aVVgLjlGHE8864NzB3HCvWussqah+
        CLgWBucxcZ2pw7JaWKp3agwgnuGmoVdfIKAngu8=
X-Google-Smtp-Source: AA0mqf6VSCttlMDQ4ePrIMuuWUop9z+BTcjYAUHqsQZ33364ZUGwjrt/1mDKwx6Oi5wu+AkigSoems+jlC80zO3rZM0=
X-Received: by 2002:a0c:ef51:0:b0:4bb:7f7a:2a62 with SMTP id
 t17-20020a0cef51000000b004bb7f7a2a62mr2557030qvs.82.1669037204617; Mon, 21
 Nov 2022 05:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20221121123833.164614-1-mmkurbanov@sberdevices.ru> <20221121123833.164614-3-mmkurbanov@sberdevices.ru>
In-Reply-To: <20221121123833.164614-3-mmkurbanov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Nov 2022 15:26:08 +0200
Message-ID: <CAHp75VfgxHo7YEtfrvvC=yGL28v8-tK4f6Y4ZMnqnw=fj5Q1ew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] leds: trigger: pattern: notify usespace if pattern finished
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 2:39 PM Martin Kurbanov
<mmkurbanov@sberdevices.ru> wrote:
>
> In the current moment, userspace caller can schedule LED pattern with

a LED pattern

> appropriate parameters, but it doesn't have ability to listen to any
> events indicated pattern finished. This patch implements such an event
> using sysfs node and sysfs_notify_dirent() call.

...

> +Date:          October 2022
> +KernelVersion: 6.1

It can't be. Have you read my previous comments?

...

> +               1 means pattern is running and number 0 are finish or not run.

are finished

...

> +static void pattern_trig_remove_is_running(struct led_classdev *led_cdev)
> +{
> +       struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
> +
> +       sysfs_put(data->is_running_kn);
> +       device_remove_file(led_cdev->dev, &dev_attr_is_running);
> +}

If the file is opened at this time, what would happen during execution
of this function?

-- 
With Best Regards,
Andy Shevchenko
