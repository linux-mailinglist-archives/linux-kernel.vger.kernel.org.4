Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D5F5EEA89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 02:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiI2AZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 20:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiI2AZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 20:25:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ADA27B33
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 17:25:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x18so22136620wrm.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 17:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=m7MHYqMuAHBhH/T9CZiqeaADGWABE7uRJNp3MEzCJqk=;
        b=DZF/PJL37oCnZ3CZ4vXb9CP9jlG9rdA4aNcY22kcEnRm061ChtrCNXZ3zEUv9IEStJ
         A2j7bgQQqzsbskD80Gt2Oplqak+5MiwFbuBTvHpt/F0zVh+cVSi+IbX4Z7C+6z0KC0Z3
         UL6qv/huuKViuSL25AgApOgGKcAVGCcQh3T7NKU0br3mcGEIo9W8rBVxh1d16m7Pqq6Q
         tcHYLhwisXsVN2tK+UVz+FpAWelIRAGZlpok1H8jk256ezO19bObF2Ro319DviKXI/nD
         ffRzSjuFeCGcjCwKX35sIofPtjfzlyAzBkf8qJS1VcrcmjDIsF4UUFh2FlA7XWYNvrb9
         GFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=m7MHYqMuAHBhH/T9CZiqeaADGWABE7uRJNp3MEzCJqk=;
        b=15a3PdutUDd9vabjAdmAOJZvHWSpPRzO191tvp6IQEUY3sdGD0PvR9nXIz9rdThTSU
         +RzigLosLGD/vz67pLwDT0v615y/vrn7/YdVVxd/5HrVLNBgTQsoWCfCjNWL6QUsEXVW
         7zOL+oVtrEhFu7Qj/1w4wkVKPEpmK/qENxR8uYoyPw5aCrxNtleBzSdFuVJel3M04Tna
         i4Jbe8oyVrwGc1CMZx/0YRW5cSdfUwkSK4R27COqvW9xgT+8baAHjscxt9YfbdfcboEp
         HJZjQ/fPQXsnGI0PLfUjajp6NHxl7U0a5G0NikrK2Hp//Hbeceu0QmtWp0TYU9y2fPFV
         16cQ==
X-Gm-Message-State: ACrzQf0YZO+yiMcO24sHrIpIYkIPbysWbX4kPPGnK1fd8Tr0LtdQsxfA
        b4bSNXBQYUZTJoXxLyFWLIA3kQ==
X-Google-Smtp-Source: AMsMyM7RPlfL86DVl/IYW2OfoOiTVx08staNLB+32gv6hXBOwAphl4NYHVe4Kto1lniUqS5GljmfvA==
X-Received: by 2002:a05:6000:815:b0:22a:418e:f354 with SMTP id bt21-20020a056000081500b0022a418ef354mr261744wrb.97.1664411103002;
        Wed, 28 Sep 2022 17:25:03 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm3033841wma.6.2022.09.28.17.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 17:25:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 0/2] Expand get_maintainer to be explicit about supporters
Date:   Thu, 29 Sep 2022 01:24:58 +0100
Message-Id: <20220929002500.283481-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:

https://lore.kernel.org/lkml/20220928003006.230103-1-bryan.odonoghue@linaro.org/T/#u

- Documentation/process
  Added in text to also make clear subsystem mailing list should be
  included - Krzysztof

- Changed get_maintainer.pl to print maintainer[supporter] or
  maintainer[volunteer] depending on MAINTAINERS file. - Thorsten/Bryan

- Choose supporter and volunteer instead of supported and volunteer
  Supporter and volunteer describe the role of the person whereas supported
  and volunteer would describe an activity and a role which isn't
  consistent. - Thorsten/Bryan

- I didn't change Documentation/process/5.Posting.rst
  This file doesn't mention get_maintainer.pl and I was mostly aiming to
  fixup the process around get_maintainer.pl. - Thorsten

- Myself and Thorsten discussed changing get_maintainer.pl, how it seems
  like a desirable thing to do but also that "it might break scripts for
  people" and it might.

  I don't know if get_maintainer.pl is or should be considered to be a
  stable interface and an explicit software contract but, making it clear a
  supporter is also a maintainer seems like the right thing to do from a
  transmission of information perspective.

  There is still the option of just updating Documentation/process in
  isolation.

V1:
- Sent a standalone change to Documentation/process stating
  get_maintainer.pl email addresses marked "supporter" should be included
  in a patch run.

Bryan O'Donoghue (2):
  get_maintainer: Describe supporters and maintainers as required email
    recipients
  Documentation/process: Add text to indicate supporters should be
    mailed

 Documentation/process/submitting-patches.rst | 8 +++++---
 scripts/get_maintainer.pl                    | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.37.3

