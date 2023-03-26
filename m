Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C916C986B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 00:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjCZWGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 18:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCZWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 18:06:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E39D5B94
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:06:11 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w133so5033868oib.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679868370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXiSJ7wBXq/4T1LMMz36pZlbBBVWNt83xm/Cv55ylqw=;
        b=wXyTxdMVTS8KjcfegNn8UAkXSQgoOOYwT3LHMhxwRM7GhGPauzAltWsT4Vn1UJm01E
         o01qVCbHpO41EJENGv/+36M7Xp+jvaXqQTTdxJki1+kzTQoMiEk8orCG5gPCKYa8cVsD
         WRsSTHbC+n0XOcxmIV04eRMl4H29VdOE2ucGPwEZT/0hUJuBufDH5JYEGxyUNRLKnoN6
         K390zpudbM178CGuOM0Nve9bjBzzMBE0Fo6q+z0jyP4WsDOAD2BIvKQx6jj0dW/IEoWQ
         L0N69GT2AMHYia3B5mBNYp7xb8RtXwjaqmU5x8wKvFK1/KuwnXhVatOzjgkDmACIUTJ5
         wEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679868370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXiSJ7wBXq/4T1LMMz36pZlbBBVWNt83xm/Cv55ylqw=;
        b=OrFpZV3RodOxbaSMy43ivJtGc+dmnN9t4hlY5RkfYDnjRweHb8VHQfvFTuNBRMlcu2
         gWsRBoZK/7iMhmqkqqWrOa08CcfI+b9Pw58PleVcqYRZrRghV1qGWW8hM221jOxqciD4
         9TFwnSJgzcyLkHgJARFnTLpThIhUABxB5UUgAHHzgIBAR7IsiRUBB9Sx9JbjARa1rGSt
         RRcHbbWTNED9sY+DTPByq4F5ZpB+Pcnn4gJwt5YYpKhPyd5FhxDo04TV8gtFMcppzRzP
         2E4UE6fDfQnqUeHkwofST+/Bz5g7GSdI8vBTxoRlZO2cJ3KdmggjpizYH+CDerKBcBfz
         yqLQ==
X-Gm-Message-State: AO0yUKWI3OJ86O6eJZGm71ZPku8s5ATL/9K7iedZkZxvYb1TBc4BI2pi
        +7z9Umjd+C80jsiiT6NJezvl3w==
X-Google-Smtp-Source: AK7set+9k6nq994o7HQfTsr3tmP7Q1dYPuV+hXUX4tpWmIV2INklxJHhM6IkWLdiaK2gHucyxng9Aw==
X-Received: by 2002:a54:4d99:0:b0:387:1e85:d1ae with SMTP id y25-20020a544d99000000b003871e85d1aemr4011199oix.18.1679868370301;
        Sun, 26 Mar 2023 15:06:10 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o187-20020acaf0c4000000b0038476262f65sm10593744oih.33.2023.03.26.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 15:06:09 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 0/2] Migrate STX104 to the regmap API
Date:   Sun, 26 Mar 2023 18:05:56 -0400
Message-Id: <cover.1679867815.git.william.gray@linaro.org>
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

Changes in v3:
 - Add STX104_ prefixes to defines to avoid potential name classes
 - Rename SAME_CHANNEL() to STX104_SINGLE_CHANNEL() to convey intention
   better
 - Utilize u8_encode_bits() to define STX104_SOFTWARE_TRIGGER
 - Adjust to utilize reg_base members in regmap_config structures
 - Fix off-by-one errors in aio_data_wr_ranges[], aio_data_rd_ranges[],
   and aio_data_regmap_config max_register
 - Inline gpio_config initialization to avoid zeroing it at declaration
 - Add blank lines between register map init blocks for clarity
 - Utilize regmap_read_poll_timeout() for ADC conversion status poll
Changes in v2:
 - Relocate struct stx104_iio for the sake of a clearer patch diff
 - Replace FIELD_PREP() and FIELD_GET() with u8_encode_bits() and
   u8_get_bits()

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

A patch to utilize regmap_read_poll_timeout() for polling the ADC
conversion status is included as follow-up to make the git history
clearer for this change.

William Breathitt Gray (2):
  iio: addac: stx104: Migrate to the regmap API
  iio: addac: stx104: Use regmap_read_poll_timeout() for conversion poll

 drivers/iio/addac/Kconfig  |   2 +
 drivers/iio/addac/stx104.c | 434 +++++++++++++++++++++----------------
 2 files changed, 244 insertions(+), 192 deletions(-)


base-commit: 46e33707fe95a21aa9896bded0be97285b779509
-- 
2.39.2

