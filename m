Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C905BC4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiISItU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiISIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:48:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDA722294
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:48:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc7so62895223ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XNzy8QXvxwZ2UpTnDHe3R7XKvvfCImteHTl3mRKpcsM=;
        b=i+MT/i2ms5AZZ+tjGq43WTntkkCCpoEtS138K73adMJjmg041OUPqWXqFvpM9KVywj
         TDgke3sufaBSbceIGNOubrQo146uutANELNtaUc7uhLe6ZIsCrc3MeMSDCUQhVSWeMyn
         E7dmcmeHqMN0hUjx5Wvktr1kU3tNYC1BG76oFKi84ydETh3HDKfGJf78UO1wAy4kmvjE
         TbBe9PbfQ9F3xZBLkfTtjd+dP2Hti4piDHyS0tg6E3Zimw0vKyejAwPssL7mWFdSwuP+
         QAJE5fAdNaeRdTZgVfw1txMlxG+tfhYrMUBKSMffUtGfG+ABRaN6v+nX8ZxsUiXez2kU
         U0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XNzy8QXvxwZ2UpTnDHe3R7XKvvfCImteHTl3mRKpcsM=;
        b=ZyEyhyeZkJvhhzH91C0yb1HVDkUQt5AgJnjAJDBBaE0odyyzSCve8UXGO3Vac8vE6z
         pyZLnX1RPCwqxQqpUFUfpL7/nCYxb4TD3tEpBzJEPmdxitcZ5vffwtNDNSAtNyAwllPq
         GUn96Neu3SfWiIN/pMOriB410MbsrBYTxH03PuQFDFSt8vSDFZT+TWBiiWWqQF6RWIYD
         43o8aTQygBo5TeIO6plp2bMqkiaG7M/kuOGRnr5SinMvEvPjh4C19HGkk8IGLQcsBSn2
         YW2ZgrAhkBYIMEB3lo5xZoua8W+1++EW3mzVm/tV7VPU/FrPKgupHaYU7+IA9892ws8m
         hkwg==
X-Gm-Message-State: ACrzQf0XZE+lRHwJjLBHgf9uLmLyWrt24VUwaXiuHKXKurNHcPndvnx5
        lfjKFRppKwfabHagGVAJLGxmofMUTAlrKw==
X-Google-Smtp-Source: AMsMyM760H9jD3JILh4U8k4DxkhTrd/+xB9n82UOmO/VLgipGN3WKTwo+jUCQsAT/RBF5ZdDOP4hHg==
X-Received: by 2002:a17:907:60d6:b0:77d:8aed:cf86 with SMTP id hv22-20020a17090760d600b0077d8aedcf86mr12082225ejc.43.1663577318848;
        Mon, 19 Sep 2022 01:48:38 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be (ptr-4xh0y3vyam57ypepalv.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:d368:146c:ce83:b3f3])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7d594000000b0044e9a3690e0sm20081326edq.9.2022.09.19.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:48:38 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v5 0/3] iio: temperature: mlx90632: Add powermanagement
Date:   Mon, 19 Sep 2022 10:48:15 +0200
Message-Id: <cover.1663577091.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

As discussed previously on the group under the
"Controlling device power management from terminal" thread the mlx90632
sensor provides measurement capabilities under sleep_step mode. This
series runtime suspends the unused chip to sleep step mode to save power
but in case of continuous sequential reading it switches to continuous
mode for faster readouts. This value is hardcoded to
MLX90632_MEAS_MAX_TIME (with some buffer) and not user configurable.

The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
hardcoded to 3 times as much as MEAS_MAX_TIME.

Changes in v5 (per review comments from Jonathan Cameron):

 - Migrate to devm also for driver removal, along with putting it to low
   power mode

Changes in v4 (per review comments from Jonathan Cameron):

 - Migrate back to devm_pm_runtime_enable and remove the pm_disable function
 - Remove pm stuff from remove and also sleep, since when iio device is
   not registered also sleep makes no sense.
 - Replace use EOPNOTSUPP as per checkpatch suggestion although some drivers
   still use ENOTSUPP.
 - Change the style of read frequency

Changes in v3 (per review comments from Jonathan Cameron):

 - Change the "available" attribute presentation to more recent way
   suggested
 - Replace devm_pm_runtime_enable with enable and devm_add_action_or_reset
 - When suspending device also put it to lower power mode in case there is
   dummy regulator
 - Use more switch cases instead of if/else

Changes in v2:

 - apply review comments from Andy Shevchenko

Crt Mori (3):
  iio: temperature: mlx90632 Add runtime powermanagement modes
  iio: temperature: mlx90632 Read sampling frequency
  iio: temperature: mlx90632 Change return value of sensor measurement
    channel

 drivers/iio/temperature/mlx90632.c | 432 ++++++++++++++++++++++++-----
 1 file changed, 360 insertions(+), 72 deletions(-)

-- 
2.34.1

