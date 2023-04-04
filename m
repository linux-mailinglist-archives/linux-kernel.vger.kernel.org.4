Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1CB6D64DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjDDOMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjDDOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:12:08 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EE2D79
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:12:06 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-544787916d9so615140187b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680617525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ap5QnifDiiqkIiZVcjMyWrvUdPzu45RE6/ZRmZRra9g=;
        b=O2mAEIUmXml0vUnyKxQZcqMVeXraxjL9J/FvnL/8wVrcLZB/PcUxN+3CvUqy4y9t/c
         MeHoIQpqRdKSEjxsWKkPeHh1T6vCe6EX57Dbkn56pUPW9Uz9BhNNvlRvJuOgEu1Z6w32
         f/LJzGt1IvuLeP0oOGWj4bwRuvvwnN+SptlGmkypGvmMVeH+ti4XL1p8ULJJRZQq8Oyu
         6ojlqrd/6jATJbrmpAYutRc8JqkLp6dN1DSiyCFMeJs/Htc1WkSw42v0glcwBCGp9iTt
         81a0H/pZpP9/DBpOMq9hXBG5s6XOKoMLDkmW4fY+TpLTPZm4ZTRt7Cd32U3dZCuXBGvf
         hhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ap5QnifDiiqkIiZVcjMyWrvUdPzu45RE6/ZRmZRra9g=;
        b=JHO7KD2+QTPVDfHAVwIv8M6qNgJsR0rJ0MDw/M/F5Ac6Ia7WngG+G0ifVDdBwjqFIc
         LchMMuE1L+6R+7fs+ycl//SJC8SJYMbewyniaNebf/fKk0xkDBUZCyJJMyVn6T0u7yNj
         APlmWtusjK4/mvJ1epQHW4OC7EFkY4MD3wj4MFL9ScqO/46nVr4XiKlOgKV/JSIFgsi6
         Rlr0mkLxt6IESy8DpN6ltbPkx/KKgo2vKRUtUVG/lqFEd1EEaUy4nMnRaT2JoR1SPpJS
         uAtP2FUaROx4v/lRjUe9A2x5LszHDQh7toufEGHE0PxG6GFfo5cdfuttPwXIv/LsIVPn
         vVQw==
X-Gm-Message-State: AAQBX9ePKtXwYxVUh/eeUpEu+1c1MakmbZ6iYUiZDlRG5EVcRm01zCfq
        XyBZnrSbIWrhDDdmhJIod6rQ8g==
X-Google-Smtp-Source: AKy350anYZpdKncvP6NK23mmlxjyduZnB/P8VsZkA6z2XC+Z9XjaZ/6HSLg1AzG11K2nLzZt+hcLnQ==
X-Received: by 2002:a0d:d583:0:b0:541:7193:e136 with SMTP id x125-20020a0dd583000000b005417193e136mr2353099ywd.23.1680617525609;
        Tue, 04 Apr 2023 07:12:05 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d195-20020a811dcc000000b00545a08184d8sm3202750ywd.104.2023.04.04.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:12:05 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 0/5] Migrate STX104 to the regmap API
Date:   Tue,  4 Apr 2023 10:11:57 -0400
Message-Id: <cover.1680564468.git.william.gray@linaro.org>
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

Changes in v4:
 - Fix race conditions in stx104_read_raw() and stx104_write_raw() by
   utilizing a mutex
 - Improve indentation in stx104_write_raw() by bailing out early if
   chan->output is false in for the IIO_CHAN_INFO_RAW case
 - Remove regmap_config max_register lines as superfluous
 - Utilize BIT() for gain calculation in stx104_read_raw()
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

To make the git history cleaner, a precursor patch to improve
indentation in stx104_write_raw() and a follow-up patch to utilize
regmap_read_poll_timeout() for polling the ADC conversion status are
included.

William Breathitt Gray (5):
  iio: addac: stx104: Fix race condition for stx104_write_raw()
  iio: addac: stx104: Fix race condition when converting
    analog-to-digital
  iio: addac: stx104: Improve indentation in stx104_write_raw()
  iio: addac: stx104: Migrate to the regmap API
  iio: addac: stx104: Use regmap_read_poll_timeout() for conversion poll

 drivers/iio/addac/Kconfig  |   2 +
 drivers/iio/addac/stx104.c | 455 +++++++++++++++++++++----------------
 2 files changed, 261 insertions(+), 196 deletions(-)


base-commit: f73df43e957a6fc705a9bd6d143585bdf1b13365
-- 
2.39.2

