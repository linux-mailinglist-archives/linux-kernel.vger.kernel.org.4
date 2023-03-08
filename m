Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851FD6B0843
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjCHNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjCHNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:16:28 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2237D086;
        Wed,  8 Mar 2023 05:13:20 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id fd25so10177978pfb.1;
        Wed, 08 Mar 2023 05:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678281199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jb0Vwimnk1fKmcA4+/OiP1gsen8X11PPsbQ9csW+XKs=;
        b=PZlxCx+di/r0wWck61PYELpopGrw8/0U78Di0I2KqJM4dsx9glB09jbVkdzYgBmUcV
         XURe/r8D6cQScEycdBUYTHw7jdYlBvjiAkbh7kkCIbxz933KirxC04xFwKyB0LxX3g9i
         odXvHteQsB02kV4PfVwP4/kprfGa/P4p7JG4+h7bRDq0skO7Pg6f7LXrQe91R7UwXxxD
         jLuLJXaRHmT7muh7kBxfL5OwlWztctCNk3P0CpbYQd+pjVYkhJjGwzKl3LXxTVpDej0N
         ZE2b4xiFotyNuJK/alfTiijROd5Qm+k4+EdAc9rxZHiHGI/alusbDaGyI1MxsX7sw9xX
         Nv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jb0Vwimnk1fKmcA4+/OiP1gsen8X11PPsbQ9csW+XKs=;
        b=rsuulayuHuCxLLcSwJtJ5yDSoeqUgD+JDSc103SXxvtaDGLCfXTEgsGB9UU03dwFkF
         kBv2u7EXYoup8pBXGqL3tdr9qjcTKg6QKwbtUV4TglOJVJEaUgd1ooKTV9EJ9LjpZc75
         P7Syesc+tpcMbZI0bKiCucKTVlBDt4sPjwxSAhiNUDw793MS9EpOpWS6iMGd4ZaikU8A
         td5lvO+SIoHwjIM7gzZ/+k/t+TG+rSLe7PsrnfJRvzTVfo3cs/NGWFMPUN1wEwxgkN/6
         2eCqzNlJ9MhLSJJVHm/kMsSw+YxcpgGci0qw/oaZMf2ZTuJ3LHhGF3yYwybCCEwSRwyn
         UMfA==
X-Gm-Message-State: AO0yUKUknKGszf97CGEEeAxpYjIF5YBO6NpoDfQuVPdyXsaMMuVOHs0Z
        VICvBYYIke4N3QRPARhm6u0zBUog6SH17Q==
X-Google-Smtp-Source: AK7set/DCJN2LGTZAejsQ90dh02lYfrqZo27fuFdz5NbWWpkuPwhIvQ4moWWXeyz/oYqZhepbNMcmg==
X-Received: by 2002:aa7:982d:0:b0:5a9:e8dd:80ea with SMTP id q13-20020aa7982d000000b005a9e8dd80eamr15228265pfl.17.1678281199085;
        Wed, 08 Mar 2023 05:13:19 -0800 (PST)
Received: from localhost.localdomain (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id i15-20020aa78b4f000000b0061ddff8c53dsm931038pfd.151.2023.03.08.05.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:13:18 -0800 (PST)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     mkorpershoek@baylibre.com, phoenix@emc.com.tw,
        josh.chen@emc.com.tw, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: [PATCH V2 RESEND 0/3] Input: elantech - Fix incorrectly halved touchpad range on ELAN v3 touchpads
Date:   Wed,  8 Mar 2023 05:13:04 -0800
Message-Id: <20230308131307.13832-1-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux 6.1.15, on my laptop (Dell Inspiron 15R SE 7520) with an Elan
v3 touchpad, the reported size of my touchpad (1470 by 700) is half that
of the actual touch range (2940 by 1400), and the upper half of my
touchpad reports negative values. As a result, with the Synaptics or
libinput X11 driver set to edge scrolling mode, the entire right half of
my touchpad has x-values past evdev's reported maximum size, and acts as
a giant scrollbar!

The problem is that elantech_setup_ps2() -> elantech_set_absolute_mode()
sets up absolute mode and doubles the hardware resolution (doubling the
hardware's maximum reported x/y coordinates and its response to
ETP_FW_ID_QUERY), *after* elantech_query_info() fetches the touchpad
coordinate system size using ETP_FW_ID_QUERY, which gets cached and
reported to userspace through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the
touchpad size reported to userspace (and used to subtract vertical
coordinates from) is half the maximum position of actual touches.

This patch series splits out a function elantech_query_range_v3() which
fetches *only* ETP_FW_ID_QUERY (touchpad size), and calls it a second
time if elantech_set_absolute_mode() enables double-size mode. This
means the first call is redundant and wasted if a second call occurs,
but this minimizes the need to restructure the driver.

A possible alternative approach is to restructure the driver and set
resolution before querying touchpad size. I did not attempt this myself,
and don't know how the Windows Dell Touchpad ELAN driver handles
double-resolution. See
https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net/
for discussion.

Changes in v2:
- Fix commit summaries
- Add "Fixes:" tag holding commit that introduced bug

Tested on 6.1.15, rebased and built on dtor/next
d5f7638eb5fed0eb12e45a127764c4111b11c50e (though against 6.1.15 headers,
and the resulting binaries were not tested). The files changed
(drivers/input/mouse/elantech.c/h) have not been modified since 2021.

Link: https://lore.kernel.org/linux-input/CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com/
Link v1: https://lore.kernel.org/linux-input/20220929082119.22112-1-nyanpasu256@gmail.com/
Link v2: https://lore.kernel.org/linux-input/20221014111533.908-1-nyanpasu256@gmail.com/

Eirin Nya (3):
  Input: elantech - Remove redundant field elantech_data::y_max
  Input: elantech - Remove redundant field elantech_data::width
  Input: elantech - Fix incorrectly halved touchpad range on ELAN v3
    touchpads

 drivers/input/mouse/elantech.c | 51 +++++++++++++++++++++++-----------
 drivers/input/mouse/elantech.h |  2 --
 2 files changed, 35 insertions(+), 18 deletions(-)


base-commit: d5f7638eb5fed0eb12e45a127764c4111b11c50e
-- 
2.39.2

