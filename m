Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93160BCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiJXWDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiJXWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:03:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F342FACE3;
        Mon, 24 Oct 2022 13:17:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k2so7689186ejr.2;
        Mon, 24 Oct 2022 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1fBlLJXdA6H7C7X3qALVt9OFqOQbonL8kspTcSbYe8A=;
        b=YPJ3jwQsNmm9WLt/GBkLWWRa6lFn8eahlu81M8lp72RvYGLMe/rQjA2qPa5v1u4tT6
         90ivSVYqP66OxTklswMOTjjr9ecvUkAP0NUIauygidG6sWAb1j1q05ALUBQxKfn0aTu5
         2S3QwjiaKOaIMvBqG9wc3wTVwidG1wG8FEuhFE+iEE2VUjwRX7c+FY1I7Xdn55PK08z9
         i2ufSZEQzWz2r7uSmuMUBEkFRjVqHQY1evrOLHZ5Fk2qSSqIk/Jn+sTiLw0wQLqe4tal
         36VZBHwYk13cnxp/sU7GMLV7E/HHAvlWE1h6zbYbhyPiwxfyyLicgnWx9g4h+13XZg8z
         xLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fBlLJXdA6H7C7X3qALVt9OFqOQbonL8kspTcSbYe8A=;
        b=5aU6Nqu9jL2jf6ccP2zCWobbqPbgI4Xh9okWhY2/wvVbZ+puqBopY0J77wVjKjPrZ/
         hPtvsoVpNPjk/RC6WPlL2+x3EC73wqc0TOgzFchspZL51fM+KqmebIb18DPnAsiDQvjF
         KHq1Ovx3MvT7W1DKUk5dLTNHwvGYpykQznFKWCo2APdv94FxyspPAKUKe2RR746whQzS
         6JRLjFWkD0My0b2d1nDK8rtPqQhODBYX9VqKCDFL/AUSrjiDtX2teOEPS0T0bsq/C5kl
         PvJr8QsXGcG83+OPC8+69psBKjMYVPsvOMT7xZZWAHRv2nchBDlcQG/JXRvEP37aXuIJ
         z77Q==
X-Gm-Message-State: ACrzQf3kCxabPTfGqrQ6hiYbxf7pTrSI+X9a7yVaFktbdZl4aZ/kXVjh
        fuT0LiP8BPMlXDmw9mNBdj0=
X-Google-Smtp-Source: AMsMyM6Tfi2MudIbF6SuC3N6qkh7fPJgYp0ed+IaKSyzxHBs7xvcwSqolHobZJoh1xVju7+sSEmzxA==
X-Received: by 2002:a17:907:7e87:b0:78e:2dc3:945 with SMTP id qb7-20020a1709077e8700b0078e2dc30945mr29430002ejc.326.1666642529414;
        Mon, 24 Oct 2022 13:15:29 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:28 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 00/11] media: cedrus: Format handling improvements and 10-bit HEVC support
Date:   Mon, 24 Oct 2022 22:15:04 +0200
Message-Id: <20221024201515.34129-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While my first intention was to just add 10-bit HEVC handling, I noticed
a few format handling issues and a bit of redundancy in some cases. Final
result is that driver now sticks to stateless decoder rules better.

Format handling improvements:
1. Default format selection is now based on HW capabilities. Before, MPEG2
   was hardcoded but some Cedrus variants don't actually support it.
2. Controls are registered only if related codec is supported by HW.
3. Untiled output format is preferred, if supported, over tiled one. All
   display engine cores support untiled format, but only first generation
   supports tiled one.

I hope this makes Cedrus eligible for destaging.

Best regards,
Jernej

Jernej Skrabec (11):
  media: cedrus: remove superfluous call
  media: cedrus: Add format reset helpers
  media: cedrus: use helper to set default formats
  media: cedrus: Add helper for checking capabilities
  media: cedrus: Filter controls based on capability
  media: cedrus: set codec ops immediately
  media: cedrus: Remove cedrus_codec enum
  media: cedrus: prefer untiled capture format
  media: cedrus: initialize controls a bit later
  media: cedrus: Adjust buffer size based on control values
  media: cedrus: h265: Support decoding 10-bit frames

 drivers/staging/media/sunxi/cedrus/cedrus.c   |  97 +++++-----
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  22 +--
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |   4 +-
 .../staging/media/sunxi/cedrus/cedrus_h264.c  |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |  37 +++-
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  18 +-
 .../staging/media/sunxi/cedrus/cedrus_hw.h    |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_regs.h  |  16 ++
 .../staging/media/sunxi/cedrus/cedrus_video.c | 166 ++++++++++--------
 .../staging/media/sunxi/cedrus/cedrus_video.h |   2 +
 .../staging/media/sunxi/cedrus/cedrus_vp8.c   |   2 +-
 12 files changed, 225 insertions(+), 145 deletions(-)

--
2.38.1

