Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFCD675ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjATURs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjATURq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:17:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB2E1259C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:17:45 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so1433128wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5Xkr2k/6Nx+TaITzPx/69q4zOkt44vc7RBSXgmnDGY=;
        b=NRxR8B2Uz0daGdwYRqI63u1TDipu+pkE9xDEgEPBJNVuzu3upcqH7PZ4j+RdGksNUP
         P1l9GdjNPKpbtdvzMxZTCrwW8k2Ti1S3Nrk2zlPkRazFEJkD8DaOoU3brjzSDLeCVwRa
         j1bgbAKzCMmdoc5rPhJqNmjit7C6xLjD9HcsW6xpZnfbE/LJdv0e/aj+g94JLefpG7j6
         xmimbU6OIN2s1U4dQ6qt3T7jqq7lvRZFZt8Ycr2stoGl50wMUf2T1knAM/QU8NSB6T47
         98mMT1H2uLSMk8EM38xZYC0dYFcqCLbU9lLLDfPeqx4ynGzak5AWwfSoC4+pH8vLTyNN
         bDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Xkr2k/6Nx+TaITzPx/69q4zOkt44vc7RBSXgmnDGY=;
        b=WRDozXXQKE6V/qY5g7pSOveMGBDatvQkmuffhzDtuqQh6p714uUBtRGZEf5KUvjJPP
         E88i4xG2eMQS7E+7gRFTjduExkZqCEFxLmmVuLvPQlm6XB/tUg+362UXN9H3dcfso+GX
         /IlWchnCtrsZUwBfP7ve/sNqzt0UDntlrnEIEVuZAQ967+mhLCK5FzLNdy1tuAmFok4k
         S5CeSqkbwQ4ecjhsWNA1hMw2vztTbGgZoG09sw823Auyq0HzYtu0+9lwiHGnjqQ1Qii6
         AUJLN1+SCT3Qounzu8UOzBFKSUfOMbewbYTDsviS2QzZf1/ofa5OtAdxLUF4c23sSEW6
         cqKw==
X-Gm-Message-State: AFqh2kqsxj+R+mQXNqi8kzFM83FAJB1R6bhfVQLZMGeLK1qS98ypL82q
        3kw1phmKI3R6EAlO1OcGejs=
X-Google-Smtp-Source: AMrXdXt0lGMqr8IVTTV0MweFD2dPpnfKB8X+zmi3fEg59TyNNM03xSK1TW6bj81zKQCWXrPkP7nxqw==
X-Received: by 2002:a05:600c:3b0a:b0:3db:22a:1349 with SMTP id m10-20020a05600c3b0a00b003db022a1349mr4063921wms.2.1674245863454;
        Fri, 20 Jan 2023 12:17:43 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id bi16-20020a05600c3d9000b003daf89e01d3sm3242057wmb.11.2023.01.20.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:17:42 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:17:40 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Remove several variables that are zero from struct
 r8192_priv
Message-ID: <cover.1674244819.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arrays EEPROMRfACCKChnl1TxPwLevel, EEPROMRfAOfdmChnlTxPwLevel,
EEPROMRfCCCKChnl1TxPwLevel, EEPROMRfCOfdmChnlTxPwLevel are initialized to
zero and never changed. These arrays are used to initialize other
variables that are then also zero. Remove several variables set to zero
to avoid camelCase and to remove dead code.

Tested with rtl8192e (But most of this code is not executed on my hardware)
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (6):
  staging: rtl8192e: Combine three loops to one to init tx_pwr_level_...
  staging: rtl8192e: Init tx_pwr_level_cck_a and friends directly
  staging: rtl8192e: Remove zeroed arrays tx_pwr_level_cck_a and friends
  staging: rtl8192e: Remove ant_pwr_diff which is always zero
  staging: rtl8192e: Remove u4RegValue which is always zero
  staging: rtl8192e: Remove repeated set to zero of powerlevel and
    friend

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 31 -------------------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 24 ++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  8 -----
 3 files changed, 3 insertions(+), 60 deletions(-)

-- 
2.39.0

