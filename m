Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B539C6D9ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbjDFOm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbjDFOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:42:06 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EEFB757
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:40:33 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w133so29220315oib.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680792033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haQfQLtIHX3AMbhEtmhPzNtAxG8NcBrSOSgfDzvgaZY=;
        b=F3Pny9qKyanQubI7PdZw9QaNyLe7fQBOJpafO6/1MP6WO9qK8J764Dz1ugy4uiUt+Y
         J6DhtffYYSyxZjEqblmuzrAEFhyM7I9h66VXSxGlu8GlU+AGzegBnNH88A9hO+3jneGS
         n/bmxHJ1Y9s/Q1i7PsIlgY1+DC49LBNpCtZ/CcQqDkSYkY6RckBpnSLH+0cSQkfilidO
         03fzOTVcyQkou7OrImqXWBRQev3FnX34TMphjc1hUPqEeldktCYsPTI+qM3+b4FgF+gQ
         Zn7o7M1weH0i1P72NDArqhDujrnobGXt/rxWvAyf9kU7/dHeuaUxn84C3XbbHKnXXEXH
         8Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haQfQLtIHX3AMbhEtmhPzNtAxG8NcBrSOSgfDzvgaZY=;
        b=HsyYElCEFlGRkRq1J5/Ix0PksuzRVbhKbtFGu8KyC69tbkJ55W3X39mxlHiaWxKPLG
         lhyTHHe5gNSM2QszTCaewr2WSgGtdgVy9WuZv9q0Vi05Z+5I+l7yUVjpIp08YWqbMjwR
         3fzV+rqzwPE0zvh2qGo9tSvGssIVFFv0bMMdlooh+yEa0H+LbigMYBDApuX8mUC5zgcY
         McMrm+jeku124h095cKzU/D0wXy5w7deU7d8nAT3guY2Hbj3ZWOCP/SUzaGZ+Vu6MPos
         gUs5Yqv/9474iQ8yBn3dNuy5jMC5YFKk1dCSIGqibAwDGAX+p238p1hdMAWrN38Hivxr
         FHkQ==
X-Gm-Message-State: AAQBX9eYI9EZ7pmx1zKVdEb2cJnFmp6bVDT/MSL/LChwcX00HZhdhM3C
        etrLqTosUGNZJHrWEWrBTbarwA==
X-Google-Smtp-Source: AKy350Z+rx9pS7nPz2tJ11Na3ScH3fQ4x2FkN7YmH1OHKykbJ8eGSxYJ1CdnNtTp3SYGmtJdF0TpdQ==
X-Received: by 2002:aca:c0c1:0:b0:389:6b33:fe9e with SMTP id q184-20020acac0c1000000b003896b33fe9emr3282758oif.58.1680792032654;
        Thu, 06 Apr 2023 07:40:32 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q7-20020acaf207000000b0037d7f4eb7e8sm726209oih.31.2023.04.06.07.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:40:32 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 0/6] Migrate STX104 to the regmap API
Date:   Thu,  6 Apr 2023 10:40:09 -0400
Message-Id: <cover.1680790580.git.william.gray@linaro.org>
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

Changes in v5:
 - Explicitly check for negative val for IIO_CHAN_INFO_RAW case in
   stx104_write_raw(); this avoids the explicit case previously used
 - Use U16_MAX rather than hardcoding unsigned 16-bit maximum value
 - Improve ADC conversion comment format and use proper SI units format
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

To make the git history cleaner, precursor patches to use a define
rather than hardcoded limit and to improve indentation in
stx104_write_raw(), and a follow-up patch to utilize
regmap_read_poll_timeout() for polling the ADC conversion status are
included.

William Breathitt Gray (6):
  iio: addac: stx104: Fix race condition for stx104_write_raw()
  iio: addac: stx104: Fix race condition when converting
    analog-to-digital
  iio: addac: stx104: Use define rather than hardcoded limit for write
    val
  iio: addac: stx104: Improve indentation in stx104_write_raw()
  iio: addac: stx104: Migrate to the regmap API
  iio: addac: stx104: Use regmap_read_poll_timeout() for conversion poll

 drivers/iio/addac/Kconfig  |   2 +
 drivers/iio/addac/stx104.c | 460 +++++++++++++++++++++----------------
 2 files changed, 264 insertions(+), 198 deletions(-)


base-commit: f73df43e957a6fc705a9bd6d143585bdf1b13365
-- 
2.39.2

