Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6969F616BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKBSI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKBSIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5792F01A;
        Wed,  2 Nov 2022 11:08:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so47368413ejb.13;
        Wed, 02 Nov 2022 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94rmcDkdjrCGxv2Cn/WpEypZpF2kxP75q7QoZpGWNew=;
        b=ekX5hSaEueliIxmzaE5dgNJ3EX4kjNF5VY2hGEdzwx6d3+r2oOn96JfuAKDyci+QLq
         XQ+XJ2MTFjJE/IQAUbqjWsBYD7F/V8ZPEDEtiKxIohY26Ow0vpAWBSaPe0rYb2nSFXkP
         T8uyQenowxqzR2CP7+JD0AdVaxorzLxwxdaKkJdQrkK0V3nOTj85AhlV8eDaeESDIiga
         Hn1JXPIPI7UxsSSOV7SSaR0INEXUiDRrF0UrIfWbn8/bw78MfYxLB2b3+ZezMyEAYmXK
         TElTQNvengSph89HBmZT+iFMCKQcQkOr5N0lxAorn3nyzFhrv+oBkZ+21JMUBC2jYxMw
         YZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94rmcDkdjrCGxv2Cn/WpEypZpF2kxP75q7QoZpGWNew=;
        b=kc+9ZcesCI9smwCmINF3UDthCr+/9EqJ6tA30qN8pYNoCnlfg2zBj/PMxeyT8OHKJ1
         DL0HJkX2TZ8USfA0u3fnnfPfzWQFUmHW23huVt5WOcaz6gL8UztGx8IllZjVcIRNdQkr
         Gnpu0LE/TBZDBuYJb9e1ssOAHydEAoiwSRaYRCeGRK8NJ0840KwP1nQLz7uENr1aCUPa
         oZN+kkV5xnin0LNxM8MVh41AVbsEqlPOFnnXD6vgZuznFpDb4v6RNDuchVaNVmJiYRol
         C6Emal/aigTo13SpVt1aztKB3aK+YG2B7vjYyjx/ZMBWNo8koie4XPcLqwpnU1DHNUyN
         Ntjg==
X-Gm-Message-State: ACrzQf1qOHGUlgmgI/zyMsQxYFyoAX2nD6zQaEF2su/diRa49wVB01UD
        1qczHEmkraP6E5ZKgAdxqRs=
X-Google-Smtp-Source: AMsMyM45xz8lKz2n6ZZKU3vArbgM/LEaLIXdVBWy0aGRkor1nOrSj43LK1IZVOfAkUEFrv2qMYLIQg==
X-Received: by 2002:a17:906:2353:b0:7ad:daae:6edd with SMTP id m19-20020a170906235300b007addaae6eddmr15139513eja.40.1667412497517;
        Wed, 02 Nov 2022 11:08:17 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm5677460ejb.134.2022.11.02.11.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:08:16 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 00/11] media: cedrus: Format handling improvements and 10-bit HEVC support
Date:   Wed,  2 Nov 2022 19:07:59 +0100
Message-Id: <20221102180810.267252-1-jernej.skrabec@gmail.com>
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

Changes from v1:
- collected acks, except for patch 5, which was changed
- use cedrus_is_capable() for cedrus_find_format() too (patch 4)
- tightly pack control pointers in ctx->ctrls[] (patch 5)

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

 drivers/staging/media/sunxi/cedrus/cedrus.c   | 102 +++++----
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  22 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |   4 +-
 .../staging/media/sunxi/cedrus/cedrus_h264.c  |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |  37 +++-
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  18 +-
 .../staging/media/sunxi/cedrus/cedrus_hw.h    |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c |   2 +-
 .../staging/media/sunxi/cedrus/cedrus_regs.h  |  16 ++
 .../staging/media/sunxi/cedrus/cedrus_video.c | 200 ++++++++++--------
 .../staging/media/sunxi/cedrus/cedrus_video.h |   2 +
 .../staging/media/sunxi/cedrus/cedrus_vp8.c   |   2 +-
 12 files changed, 244 insertions(+), 165 deletions(-)

--
2.38.1

