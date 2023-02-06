Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1390E68C289
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjBFQIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjBFQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:08:22 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CD022030;
        Mon,  6 Feb 2023 08:08:15 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id l12so3262551edb.0;
        Mon, 06 Feb 2023 08:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bc2twtnw1XnblNNsxowZYsyvrqHE1B8hP2067+vzsN0=;
        b=geG4GTd2B9V1/SQE3OsJvDmCzkhAvtva5WOxhOU6M0OwbTcYhZkHQll8ppfVYN7WgE
         HTqPrA1GtYtuqIE1xYuFxjYv6yjkkz2Dq/bc4Ts9LiHeRAXm5Jb7+iiYwVLjGKdeE+xd
         7CnsfxVIbqUVtN0ZL/jEVGzrkI03xBv+4moESOet5k7T3QmrjCw5xrFWEcVl63e8am5b
         wXFatGiIz4LCV7NEdnvpO4fCIXRU6YfbVqU5TxmVGWt7G0tuHgsrCMIrrjsmm4pOt0FP
         9gGcUdVjPxrkj3duh2X3NoiN6i9LbViMBn3H3ilxfLfiUrhNdk5RS4DHaG/kvpivcc9o
         6B+w==
X-Gm-Message-State: AO0yUKU+xxaRoEMFSzAXH4X1AWSOWHNgCoHoqyN9qaEgLZJuzNRVPH9T
        OmyxLSQXdBlEAgy0J79UDKmoOe0HFkMOBhTb0V0=
X-Google-Smtp-Source: AK7set+kqr+xxulHS4tVKGg+/HpeGG/yvK0eLZ3lf2Ji+NXibBMJjweUWTweXseG6JD/e8JPUt/3lVOi6PFeFL8WmsQ=
X-Received: by 2002:a50:f693:0:b0:4aa:a0ee:7ed1 with SMTP id
 d19-20020a50f693000000b004aaa0ee7ed1mr2237358edn.58.1675699693712; Mon, 06
 Feb 2023 08:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Feb 2023 17:08:02 +0100
Message-ID: <CAJZ5v0jzLCQt22MhfaAvL8w+RP7Y-YqxUdcgQ2u2Tz9i0CS+2A@mail.gmail.com>
Subject: Re: [PATCH] thermal: Hunt zero trip points thermal zones usage
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 6:59 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Some drivers are declaring a thermal zone without any thermal trip
> points.
>
> On the other side, we are introducing the function
> thermal_zone_device_register_with_trips() which provides an array of
> generic thermal trip points. When all the drivers will be converted to
> the generic trip points, keeping two functions will be useless.
>
> Most of the drivers are now using
> thermal_zone_device_register_with_trips() with the generic trip
> points. As soon as the remaining drivers are merged, the
> thermal_zone_device_register_with_trips() will be renamed to
> thermal_zone_device_register().

So why is this the first time I'm learning about this plan?

> Obviously this renaming can only happen if there are no more user of
> the thermal_zone_device_register() function.
>
> This change uses thermal_zone_device_register_with_trips() with a NULL
> parameter for the trip point array instead of
> thermal_zone_device_register().

And later it will be renamed to thermal_zone_device_register() again?

Can we just stop confusing people this way?

What would be wrong with changing both
thermal_zone_device_register_with_trips() and
thermal_zone_device_register() together when we are ready?  And why
can't the both be replaced with something line thermal_zone_register()
doing all of the necessary things in one go?  Why do we have to make
confusing and redundant changes?
