Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA49618BD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKCWrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiKCWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:47:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF3F205C7;
        Thu,  3 Nov 2022 15:47:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u6so3274683plq.12;
        Thu, 03 Nov 2022 15:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62F2OEfjiQohqbU6sN5IcLCXyh2FVhzQsYQeHkUyEnk=;
        b=Mr2eDstZWkl7rG9GuxUwoPcf10TNjUbyMNE7QoZfN7g0lHtRM9603ErR0ybCFW5u4M
         jH98g5omf1ZOTtXsf2G74Pl4IjhUL2jVc/88ytnF/smKJi3iQaTQQvoOXsltnspsgJN7
         dQAX4YpFVZnW62RLUisonW5WsajwAvIthR5Pt/eoarGDnQzxq9zf7ai3xYFnvxmlvtYa
         4sJD75VSH63aSOCZgJsY9WeiNmbb56Ejo6uYJaAZhhGwKmtgnJrMHKGt7GCd55H7yRSX
         78VuCa4PXfL5fjZgZoF41JXB7j+4V8n1FczMBILQo60kK4XMcxICdvXBfdSicOX1ryRP
         sUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62F2OEfjiQohqbU6sN5IcLCXyh2FVhzQsYQeHkUyEnk=;
        b=gi/1niPdwF1jGnOnIx6pbkXS6AkQCTPa+/nb9Q74dcW3zldSHotUdNkw9vrN3neMAe
         Fjm1IoeFgx3ju6YbgrG3EN3toEY4qTeyOYn5MLeaWSqRxETGSeCtoo5noKbfqWRMYoNw
         bDjKD9367orAhRae1a2J2pL0oPWEwUvncwGeTGuHRKBWgwCMJn7zSwjPrU7ZLAILsWZt
         hw97ztAqYhniO18Dc7NptFTjP5rdRsHa+WRSyZxJC1E4NSJAVkZeDiZ3YbHBysb5dqyL
         69bbNrr5iuhjkoJo5S8w950IuXpMxtVTFU2X25Uhe5VPZ97PRBFh+t1bsZXZxg9iy7+h
         AyVw==
X-Gm-Message-State: ACrzQf2YmNJzojpjQS+plP8w0RNblmUYSbYDcvCzwmZESSbclocIMFRF
        5wqMx3LXnT60REjacuWKLAp/XHw0qHI=
X-Google-Smtp-Source: AMsMyM6qBW2zWz3GrytPL0bVRkK76t5nEo/iJdPDnrHA2dI45imfBq4xdE4zxzXXvtYSVApsW4sn0w==
X-Received: by 2002:a17:902:ce81:b0:187:2f28:bfa5 with SMTP id f1-20020a170902ce8100b001872f28bfa5mr18917403plg.51.1667515623775;
        Thu, 03 Nov 2022 15:47:03 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:02 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Convert omapfb drivers to gpiod API
Date:   Thu,  3 Nov 2022 15:46:36 -0700
Message-Id: <20221103-omapfb-gpiod-v1-0-5cc59257f7be@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts various OMAPFB drivers to use the newer gpiod API
that respects line polarity specified in DTS.

Unfortunately existing DTS files specify incorrect (active high) polarity
for reset lines. As discussed in [1] we will not try to correct existing
DTSes, but instead follow the path established by DRM drivers for the same
components, and continue using inverted polarity in the FB drivers.

[1] https://lore.kernel.org/all/20221004213503.848262-1-dmitry.torokhov@gmail.com/

To: Helge Deller <deller@gmx.de>
To: Tony Lindgren <tony@atomide.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Dmitry Torokhov (7):
      omapfb: connector-hdmi: switch to using gpiod API
      omapfb: panel-sony-acx565akm: remove support for platform data
      omapfb: panel-sony-acx565akm: switch to using gpiod API
      omapfb: encoder-tfp410: switch to using gpiod API
      omapfb: panel-dsi-cm: switch to using gpiod API
      omapfb: panel-tpo-td043mtea1: switch to using gpiod API
      omapfb: panel-nec-nl8048hl11: switch to using gpiod API

 .../fbdev/omap2/omapfb/displays/connector-hdmi.c   |  49 +++------
 .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   |  67 ++++--------
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     | 116 ++++++++-------------
 .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   |  72 ++++---------
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   | 105 ++++++-------------
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  59 +++--------
 include/video/omap-panel-data.h                    |  16 ---
 7 files changed, 151 insertions(+), 333 deletions(-)
---
base-commit: 61c3426aca2c71052ddcd06c32e29d92304990fd
change-id: 20221103-omapfb-gpiod-87ca2550bd90

-- 
Dmitry

