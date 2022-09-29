Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59A5EF042
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiI2IV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiI2IVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:21:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1D3128495;
        Thu, 29 Sep 2022 01:21:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so5233800pjq.3;
        Thu, 29 Sep 2022 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CuiqeCfMEreF4DTn3VvfAhzBQan3CsNH0VnTzJ+bFVc=;
        b=WDgRMOKrA5B/cpilZcMHZToi3BvnKtmBAOSFngLJIIxMs0i++40A+d5geGn7t27kV+
         +x2DRgOMMZjJJrX8WSzMhQZe0YRmtupNiY6fydu7TqJqKBX31UrVo3MejG3UDPxI/xPI
         eO4Ifa1tA1zfEOLWRZaKDKCTP56NV14AIlEeA2mHOnRxe9JDlIGhQCiHVz8WMoQHb6lY
         7DhmkRdAM7Dw76zo/0NxZLrAu+8LTt6UB4IERGFjLGv60Tpr4hOFA9d1ioCuZxL9T/5X
         uY4dcbPfC8o68y5c0JHDkqDQLHCnDKfr5EVUiVpKOteCgAHwKo7znw6mmAs1TK9MalUi
         GU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CuiqeCfMEreF4DTn3VvfAhzBQan3CsNH0VnTzJ+bFVc=;
        b=7xL0fjCOhtNa1Jn/KhqEwLxUUMDhpPHfvr+OhodRaNek0qFIJ1GuR7Ah6pQldVFzPu
         sspJcG544r1SFSwuaI+6zYBFev2A5nQYawEs1XBTXvxl0wZbyvU7l5BBR+qSImevNQhH
         Ky9Ma1aJZuY0sUyTFYLxMzjgZJnFN23YJPNDE9SxGs1v9oagIwjI5njfo/jro2e1NGUz
         WFzit3TtvcSs+SR8K1+CQv8kd83ulWQrDNSS8Qd62XtyIJkNHXRIJdxfcx59mua2Kwy9
         6dOCh1CDwhTmqgxQ9c9Si7G9on5JRbP1ZecZPPrtAv1hvbDXDqNVckPd6fju9+jcDSbg
         gOaQ==
X-Gm-Message-State: ACrzQf2Q0z6zB0tvhaz59at8sh6YQs6vp9KcLtlqvVgCUYIiFIdZayB8
        VEcSXPa6yMGaQanilml77M+KzUidO8UCVuTL
X-Google-Smtp-Source: AMsMyM5E/S2sE9Lx8twqXZuhd8j+Jnn/wCmx8hxvjh9vgSE5fFQUFImTm+AR9ajGUH9GyF9nv7PTkw==
X-Received: by 2002:a17:902:b68f:b0:178:627d:b38d with SMTP id c15-20020a170902b68f00b00178627db38dmr2307824pls.87.1664439680796;
        Thu, 29 Sep 2022 01:21:20 -0700 (PDT)
Received: from dell-void.nyanpasu256.gmail.com.beta.tailscale.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id p16-20020aa79e90000000b005360da6b26bsm5474476pfq.159.2022.09.29.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:21:20 -0700 (PDT)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Input: Fix incorrectly halved touchpad range on ELAN v3 touchpads
Date:   Thu, 29 Sep 2022 01:21:16 -0700
Message-Id: <20220929082119.22112-1-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.37.3
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

On Linux 5.19.10, on my laptop (Dell Inspiron 15R SE 7520) with an Elan
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
double-resolution.

Link: https://lore.kernel.org/linux-input/CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com/

Eirin Nya (3):
  Input: Remove redundant field elantech_data::y_max
  Input: Remove redundant field elantech_data::width
  Input: Fix incorrectly halved touchpad range on ELAN v3 touchpads

 drivers/input/mouse/elantech.c | 51 +++++++++++++++++++++++-----------
 drivers/input/mouse/elantech.h |  2 --
 2 files changed, 35 insertions(+), 18 deletions(-)


base-commit: fff1011a26d6cbf26b18c8ee4c61d99943174f8c
-- 
2.37.3

