Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764A26C7244
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCWVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCWVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:25:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4EE28E55
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:25:52 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54184571389so418283237b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679606752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJlfsjEn2YPJBYCKiEqWnj0cMJtOD/6yvVL6bZk3/ko=;
        b=RchpHhQ8JNK34VJo90S90GJErY+zx/gqfDhZnZNvz1FCvx1CQaK4Ql4kYfvMCnI1T/
         tWhVoLyrcjH7su+EfGejf7x87DcF2fcONkAzcWGHQYpGkvvzea2IJt/GV3nUEZB6IOaz
         O2EmP05Jr5dP+26DorvY7xftPphPPLj8lySEfJ37CgEMbpi93wK0YqthUFrXpUajCLK+
         6E2HHUW3uUybZh4rZtNiSKi2CL3vI9xpWYH8Yvrzq7HVsnN5a82yG24MyOxRONQH26nS
         s2HbZUFsgA/QdY1J4YhzoNXsI3xLz59m0rE6tO004OuPxeVlhHgnqiYDINBI2kFLS6i/
         0goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJlfsjEn2YPJBYCKiEqWnj0cMJtOD/6yvVL6bZk3/ko=;
        b=tyN7kzeuHAuchrqvNS5TwWRj2ry7tEQbkzJq8dPi2dGzcSEumNftZ6kUvhNyskZg1t
         9KsyGJj6dy+3GjztApTSdSFk9TB/8DR+O4+HjMnFPlN4Gbr1T6TAEJ3Se5q1AJ7bmXpg
         YceU3g6welqApvXzOLx0QszVq2lqgBeB0+I3WyqM00PGvVbhsjzNWP51tHFjd0gAvrA5
         PhymqcVBr4MnmY+NJiQ4oOHDJN+3KY9wF75eViSS+VyhQHKZrRN7vc34eK4xfkeSveT6
         pdFwdshx7ydZPsASyOkTLGSyrhCuQr/iFTWi8J22JTk+Ev0j8g3eFfNTwE99PIi/sohy
         8ZEA==
X-Gm-Message-State: AAQBX9dgI4Go+/mGBH+7Vf364LDfqlG+jd+dzTFgkJ65mLQ8MjCQpy1T
        shb9vwl8Ow1luS+mF+rUZCw7Kw==
X-Google-Smtp-Source: AKy350YPoPduVAo9sxtqNxUfqKbvyNc+o3O33T59Ozx72gUu8zjS8BtU2FvFBZuo8S2j63CLUEhp+A==
X-Received: by 2002:a81:bb48:0:b0:545:6224:96f1 with SMTP id a8-20020a81bb48000000b00545622496f1mr4699021ywl.24.1679606751863;
        Thu, 23 Mar 2023 14:25:51 -0700 (PDT)
Received: from fedora.attlocal.net ([172.56.72.93])
        by smtp.gmail.com with ESMTPSA id 204-20020a8112d5000000b00545a0818495sm52281yws.37.2023.03.23.14.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:25:51 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 0/3] Refactor 104-quad-8 to match device operations
Date:   Thu, 23 Mar 2023 17:25:26 -0400
Message-Id: <cover.1679605919.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Drop FIELD_MODIFY() macro introduction; u8p_replace_bits() is
   utilized instead for the same purpose
 - Replace FIELD_PREP() and FIELD_GET() with u8_encode_bits() and
   u8_get_bits()
 - Replace FIELD_MODIFY() with u8p_replace_bits()
 - Wrap up control register update in quad8_control_register_update()
 - Utilize ioread8_rep() and iowrite8_rep() to read and write counter
   data

The 104-quad-8 driver was initially introduced to the IIO subsystem
where it didn't quite fit with the existing paradigm [0]; these
differences eventually led to the creation of the Counter subsystem[1].
As a result of its awkward beginnings, the design of the 104-quad-8
driver was structured around maintaining abstract state buffers that
would eventually be converted to match the actual device registers
states on-the-fly as needed.

The original design approach for the 104-quad-8 driver was neither
efficient nor easy to troubleshoot, but it did allow us to focus on
implementing and supporting necessary APIs for the nascent Counter
subsystem. Now that development for the 104-quad-8 driver has shifted
to maintenance, it is a good time to refactor and clean up the code to
match closer to what is actually happening on the device. This patchset
is an attempt to rectify the situation as such.

The primary change is a transition from maintaining individual
configuration states independently, to storing buffers of the device
register configurations. To that end, the bitfield API is leveraged to
access and retrieve field states. Some helper functions are introduced
as well to abstract the handling of the PR, FLAG, PSC, and control
registers.

[0] https://lore.kernel.org/r/b43e2942b763b87afc85bfa9fe36e5695cba4c44.1475079578.git.vilhelm.gray@gmail.com/
[1] https://lore.kernel.org/r/cover.1554184734.git.vilhelm.gray@gmail.com/

William Breathitt Gray (3):
  counter: 104-quad-8: Utilize bitfield access macros
  counter: 104-quad-8: Refactor to buffer states for CMR, IOR, and IDR
  counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and
    PSC

 drivers/counter/104-quad-8.c | 536 +++++++++++++++++------------------
 1 file changed, 257 insertions(+), 279 deletions(-)


base-commit: 00f4bc5184c19cb33f468f1ea409d70d19f8f502
-- 
2.39.2

