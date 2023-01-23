Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E556E677FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjAWP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjAWP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:28:19 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D31A5247
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:28:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l8so9308004wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4LJarsnkdhyd97tYRIrrxw0RvU50l/jYtwzDdWZInI=;
        b=kk0OVCGbVgVRrHSQFpCiMa8D71V3DHvt9h1mVmp6bS03a2nTrp1h5mpupoafzy8nVt
         O0NQE9CnQDNPWhsoYxvcvsNwNxxyatSTn7+LkASKaTDIzZifmrZ8IZBTpfwdKDyrqbAO
         gVP6IgEvHzwnMZGbs5odEjSftKlAbLZ/pPez+ecM4vWznenW0J4l//G6t/PbMVnTUHeS
         XpMQYSFh8fDyws9v/6yPI4g3yLfkvHmK7EYqU2/CbF5lGJ60vh2kAagJTNbI8JyUq6zG
         OLuyShypFYR7fPqk2wRX/HR63rt/vKddHO9e4EFQPJVhi9sjyxODi1gQmg8UJIPb3UYv
         yFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4LJarsnkdhyd97tYRIrrxw0RvU50l/jYtwzDdWZInI=;
        b=n4A+rjml22LWNSWI9C5SaBtIKzj8c6WqDvmE08nsmvQIS1SIPwLGnCgZbAx6sQMgmv
         Bm+iS2WfD4aI+YdrJGC6xxSj6Gc2z9vRce/VJWgKJpOZVqurHQcadA5332ZQddyMW0Ms
         W8IjqJ8B6oe+druVQvv4i8QMvB4Ih5d6rRtC99TT3MBCGINTO9bRxXhx+vnp/tRJs4i1
         01KUAbICWi2OGO65FZhQaDCs7CS6jSDJVg4YsPm+gAM4N5QdrPAZ1F4V7VsDXRROmMO7
         yUUWvconkAQyGJPOf/x18EUUlOjDIXQF2GFYciPX9uUqfH2eTiETVLfut+RywBq/ysAl
         2ZQg==
X-Gm-Message-State: AFqh2krY1WbRFj2wReKiocoEylYPW+jP/ybgr+Y4/8gg9BSsXgJd74Be
        IzT/aS4ALAwkwczem9K71rMyBA==
X-Google-Smtp-Source: AMrXdXsR+m2BrOH6D/qXIhjotsev29FI7xivvRFLiQte4C2ftsFg0KoXiV4E6UL03GsC2GTW9Njs6Q==
X-Received: by 2002:a05:600c:2046:b0:3d2:3ae8:886a with SMTP id p6-20020a05600c204600b003d23ae8886amr32287292wmg.17.1674487695909;
        Mon, 23 Jan 2023 07:28:15 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t13-20020a1c770d000000b003db1ca20170sm10673096wmi.37.2023.01.23.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:28:15 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Misc thermal cleanup and fixes
Date:   Mon, 23 Jan 2023 16:27:53 +0100
Message-Id: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on linux-pm/thermal

It unregisters the netlink generic family for thermal in case the thermal
framework fails to initialize, removes a unneeded ida_destroy() call and moves
the thermal trip code in a separate file.

A couple of changes have been removed from the previous version:

 - Ordering the trip points. Some consolidation is needed in the set_trip_temp
   ops before ordering the trip points, so this change is postpone

 - Remove the mutex destroy call. Even if the call is not needed, the
   justification of the change is not accurate. So it is postponed also.

 V2:
   - Removed ordering the trip points change
   - Removed mutex destroy change
   - Added "No functional change intented" as requested by Rui
   - Added the function declaration for_each_thermal_trip

Daniel Lezcano (3):
  thermal/core: Fix unregistering netlink at thermal init time
  thermal/core: Remove unneeded ida_destroy()
  thermal/core: Move the thermal trip code to a dedicated file

 drivers/thermal/Makefile          |   4 +-
 drivers/thermal/thermal_core.c    |  93 +--------------
 drivers/thermal/thermal_core.h    |   4 +
 drivers/thermal/thermal_helpers.c |  62 ----------
 drivers/thermal/thermal_netlink.c |   5 +
 drivers/thermal/thermal_netlink.h |   3 +
 drivers/thermal/thermal_trip.c    | 182 ++++++++++++++++++++++++++++++
 7 files changed, 199 insertions(+), 154 deletions(-)
 create mode 100644 drivers/thermal/thermal_trip.c

-- 
2.34.1

