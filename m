Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759656C8CA9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjCYIfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjCYIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:35:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE614988
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:35:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n19so2331955wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733298;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cDeguqASDwAgU6ia/rYFeY5FWxDs06bPutkb/feHzo=;
        b=ieSdwsGeEwVPjdmsQ97sOkx9XAFxePci4TT9J1QAdbfMTpmscgtBlRWHGApbUdyMAx
         0scADfX/bY/oHRKPmHSW9xbKiMtzawfCNjuLshaElL3fJQH+UkI+pjQbwxMd1LFzyYWT
         TvZ3vjrArdloK0pB6dUlrTHSMwzFU0J4My1/RHLFXVSW+2AmIJW32MNO1QzB+mOjKm4o
         mcvTxNMRkBYdbWTkFtgJjWtuTumCX2kVoWWj/DlPmbTUN3Gr03rUroApyJqlJ3DvPeRB
         O3jAvtbIjtChHwCZdOeatx57+GUSBueBvYQCcMEJUxM7U3wqrzXkiN57JLW8J4snDQJ1
         /C3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733298;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cDeguqASDwAgU6ia/rYFeY5FWxDs06bPutkb/feHzo=;
        b=lY6wjqOcSne+ZYxQgZBIAI4Q0b6DeuSOD19VOu+5yHBCgIcTxzUGdoosYZJaBOehbM
         hqzguPa8kmUBJ/iiIJ7SXS2gkUAyDQaA75e2UDBGvYJ2/3VgYSgUSlBHE8RJaFTUFm8w
         Q4d6S/VKaCKw/Vfl8evYmfCTGEB4Jc2XOQ4DbZxagm/760BPBtVQFUvWB/B/2azySkSi
         ijdIgxF+qMqlRBJ2GwKfZz9bzEZ03zFEmgyQyRboOoTQNHiz6xnK3UH3tQ2l6PcezrQi
         WYQ58ZjWiJyrdDvWEb3slyrmWigkEa3Y+Geo2an/GylIW27bb97Qzi9fqGuNK/F3UyMG
         ywaQ==
X-Gm-Message-State: AO0yUKW7jglt5ZddDjSR+0yev0cakwoiQh5GdAs6u8LCTGjW3MuEjR9u
        rk0v9FTSkaBiQLiIVZPkCCk=
X-Google-Smtp-Source: AK7set8DpW+O+nvS+3uJziKm3LHxgzOxcCzAbTQQfGc4OarR5XqpNrJRHRMsmgcI4PG5RuRPYxozpQ==
X-Received: by 2002:a05:600c:468b:b0:3eb:f5a2:2d49 with SMTP id p11-20020a05600c468b00b003ebf5a22d49mr4315258wmo.0.1679733298456;
        Sat, 25 Mar 2023 01:34:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c470e00b003ee6a91b596sm2189298wmo.29.2023.03.25.01.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:34:57 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:34:56 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] staging: rtl8192e: Remove variable priv->rf_chip from
 driver
Message-ID: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv->rf_chip is initialized to RF_8256 and never changed. Keep code that
is executed under condition (priv->rf_chip == RF_8256) and remove dead
code including unused variables.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (11):
  staging: rtl8192e: Remove priv->rf_chip in _rtl92e_phy_rf_read
  staging: rtl8192e: Remove priv->rf_chip in _rtl92e_phy_rf_write
  staging: rtl8192e: Remove priv->rf_chip in rtl92e_set_tx_power
  staging: rtl8192e: Remove priv->rf_chip in rtl92e_config_phy
  staging: rtl8192e: Remove priv->rf_chip in _rtl92e_set_tx_power_level
  staging: rtl8192e: Remove priv->rf_chip in
    _rtl92e_phy_switch_channel_step
  staging: rtl8192e: Remove priv->rf_chip in
    _rtl92e_set_bw_mode_work_item
  staging: rtl8192e: Remove priv->rf_chip in _rtl92e_set_rf_power_state
  staging: rtl8192e: Remove rf_chip in
    _rtl92e_get_supported_wireless_mode
  staging: rtl8192e: Remove priv->rf_chip in _rtl92e_get_channel_map
  staging: rtl8192e: Remove priv->rf_chip

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   2 -
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 431 ++++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  23 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  10 -
 4 files changed, 138 insertions(+), 328 deletions(-)

-- 
2.39.2

