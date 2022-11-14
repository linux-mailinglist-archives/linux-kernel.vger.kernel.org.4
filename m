Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D016287D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiKNSHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiKNSHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:07:11 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1F02CDC4;
        Mon, 14 Nov 2022 10:07:10 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id d7so5544104qkk.3;
        Mon, 14 Nov 2022 10:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imL5BjFkkzVa0rO26uOafgzKTrXUaxWVazJANPcqqLs=;
        b=1apRiKVP11fJtK2q0s3rRCmMTkNKVbxmUL954Sn9ThabW3HuUGNsL4qOOLIm5dY064
         sRsfwNgRaoPp9RWPUFzPCTiAXXR8KjGUbPv0odfNbxGqPzzLeTP/OhrXaAPKUj/jMbuK
         FFsTwKgi4oau/Y80vFfSHX8IjY9Fb1t8wfbskLh+Isawf8XM78auLU+hoG5alQ9t+WXY
         ToVXKglFXuUXzWAeU3nQ/RlZEd0uRZHuDZ8aBcMgFZcFRme0l5O2osQ2baTxJaU9Xn8l
         WYApxzoFdnQfG6l/RuXW7UkKe2Qefe0NxBGZPRFZJtYmBjsB9AJ+iiVxcYBlUfzc6LmZ
         nIbA==
X-Gm-Message-State: ANoB5pkzrl2LNue943pXGhN2qa4sB1ZCOe1GzuiZ6uuhai7/Bo5Aw8G9
        EzyCT9STUrRb1a1P/67Xu4UJvYGUTXZZBkRNa9g=
X-Google-Smtp-Source: AA0mqf6e1vQXrSgNFs7J9/nVJUiJliv9qrFecXfYeXKsvdDuN0EMZBzNMsE3TdNZQGV2n5qNeKoGSfO/dGpQE40go9Q=
X-Received: by 2002:a05:620a:b15:b0:6fa:af7e:927c with SMTP id
 t21-20020a05620a0b1500b006faaf7e927cmr11818876qkg.443.1668449229462; Mon, 14
 Nov 2022 10:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20221110152500.3032655-1-linux@roeck-us.net>
In-Reply-To: <20221110152500.3032655-1-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Nov 2022 19:06:57 +0100
Message-ID: <CAJZ5v0j50TWszcRWkb_m4BDQ_gEpCuJDR2EuOJWN8zvBf_KkUw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] thermal/core: Protect thermal device operations
 against removal
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 4:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Accesses to thermal zones, and with it to thermal zone device operations,
> are still possible after the thermal zone device has been unregistered.
> For example, thermal_zone_get_temp() can be called from temp_show()
> in thermal_sysfs.c if the sysfs attribute was opened before the thermal
> device was unregistered. This is problematic and may result in crashes
> since the operations data structure and the underlying code may be gone
> when the calls are made.
>
> The following series solves the problem by protecting accesses to thermal
> device operations with the thermal device mutex, and by verifying that the
> thermal device is still registered after the mutex has been acquired.
>
> This was previously sent as RFC/RFT as single patch [1]. The code was reworked
> to match thermal subsystem changes made between v6.0 and v6.1, and it was
> split into several patches to simplify review.
>
> [1] https://lore.kernel.org/linux-pm/20221004033936.1047691-1-linux@roeck-us.net/
>
> v2: Improved documentation, rearranged code.
>     No functional changes. See individual patches for details.
>
> ----------------------------------------------------------------
> Guenter Roeck (9):
>       thermal/core: Destroy thermal zone device mutex in release function
>       thermal/core: Delete device under thermal device zone lock
>       thermal/core: Ensure that thermal device is registered in thermal_zone_get_temp
>       thermal/core: Move parameter validation from __thermal_zone_get_temp to thermal_zone_get_temp
>       thermal/core: Introduce locked version of thermal_zone_device_update
>       thermal/core: Protect hwmon accesses to thermal operations with thermal zone mutex
>       thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
>       thermal/core: Remove thermal_zone_set_trips()
>       thermal/core: Protect thermal device operations against thermal device removal
>
>  drivers/thermal/thermal_core.c    | 76 +++++++++++++++++++++++--------------
>  drivers/thermal/thermal_core.h    |  3 +-
>  drivers/thermal/thermal_helpers.c | 67 +++++++++++++++++++++------------
>  drivers/thermal/thermal_hwmon.c   | 10 ++++-
>  drivers/thermal/thermal_sysfs.c   | 79 ++++++++++++++++++++++++++++++++-------
>  5 files changed, 168 insertions(+), 67 deletions(-)

All applied as 6.2 material, thanks!
