Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C2D71192C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbjEYVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjEYVc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:32:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9969399;
        Thu, 25 May 2023 14:32:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso1280535e9.1;
        Thu, 25 May 2023 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685050347; x=1687642347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+atckhP8uIOj/Bvu+dP/pWeHfwyzLo5xd81Vr7qy2s=;
        b=VXrYhHI46oz6azXa6TK4Xu9Rgbkfbixex59N9rZM3y8eoCMtFGxF8LddSTwedxNjhG
         MWPA+zj8pybkr2qVMLBnbUM41S1R9mG2gNxlBYqRugL3efmM8F6y5YBB6kFrWCMvrSM6
         4oIC+304di3MRE0kr/swH/vvaOH2MpzTADzG1j4/4/Pp+g8abgO7c0OylJm60qRgxOO6
         wFQJRgovnOC7Et8qzHXyEVwYvlfxYKCXnKmUigN3qPHgGs0tVt0By2yS0cwOnsKWWN+n
         5ubXbhUYiW73BrzVxGnS+B3ntE2ffeBnjqWoHDcjja8gVUI5tAon2Tdp4KAGLsSvVu90
         cTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685050347; x=1687642347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+atckhP8uIOj/Bvu+dP/pWeHfwyzLo5xd81Vr7qy2s=;
        b=VsM1VDA/7YB30aYjhLLEA0Y6ynUTyx/SEKT9zXl7uK7DIToy0IWm/VJb4GiH+o5Msq
         IMnF/F6Z2a7fnnhZNvlnaE2vVE9gvjPL/cDXcMWPMW2GZExSj5+tLpUm7kG7BJKZBMf1
         6ME8dT3hjMC0Xv7gAfg5xXiFsuQMR8dQSacERpv3NG6xQ2irr/qLSSEEEwrkRWuvp5BK
         65399EcYFR17GiXednrYunEEbswm7ksD8KZ1iK2vAVKZKGPZbdE8eReIXPdZ4PGyMrYW
         wGl0UxU8hSES/sf/vaDW1dM9eDrDBaaDrIFwpus+MNxzrMpX7JDkACqk1sohuZ9CWNdo
         z88Q==
X-Gm-Message-State: AC+VfDyYa2LUHTy0QuaPVNJFTpGwYSIRBNeks01y8g6/t16b8GJpiRa5
        FUktW8ZAldlnKOnMix8yfumjgkEvgoQ=
X-Google-Smtp-Source: ACHHUZ7KLQy2NiLBOMNYryQfV9mTbi8yy0IEubbb0Ox80pJNx0/WBx07ZpBg3YqruYT3YzCXKlXIBw==
X-Received: by 2002:a05:600c:1d01:b0:3f5:fbc0:a8cc with SMTP id l1-20020a05600c1d0100b003f5fbc0a8ccmr3386512wms.2.1685050346850;
        Thu, 25 May 2023 14:32:26 -0700 (PDT)
Received: from xws.localdomain (pd9e5a196.dip0.t-ipconnect.de. [217.229.161.150])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003f42461ac75sm6814504wmf.12.2023.05.25.14.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:32:26 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/2] platform/surface: aggregator_tabletsw: Add support for book mode
Date:   Thu, 25 May 2023 23:32:16 +0200
Message-Id: <20230525213218.2797480-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Surface devices with a type-cover have an additional "book" mode. This
mode is activated when the device is oriented in portrait mode and the
type-cover is in an open position (including completely folded back;
unlike in landscape orientation there are no special modes for any of
the intermediate positions).

Currently, this mode is unsupported by the tablet switch driver, leading
to an error message (see individual commits for the exact messages).
Since the keyboard and touchpad input gets deactivated in this mode, map
it to tablet-mode.

I've split this change into two patches, one for each of the subsystems
(KIP and POS). This a) allows proper attribution via the "Fixes" tag and
b) with that should allow them to be backported fairly easily.

Maximilian Luz (2):
  platform/surface: aggregator_tabletsw: Add support for book mode in
    KIP subsystem
  platform/surface: aggregator_tabletsw: Add support for book mode in
    POS subsystem

 drivers/platform/surface/surface_aggregator_tabletsw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.40.1

