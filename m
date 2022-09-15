Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A2E5BA1CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIOUaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIOU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:29:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D024D30F77
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:29:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q21so28678815edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=J6g4J+gYjXd8OHWCzm+tXzp/795vOtzfgmy4dG6lLeU=;
        b=Qw3+cE33st4nv2CtQj/v2TRUZnQND1xzsKByP30WefXFUPe9J/FrN/zP69U4d/+rwz
         gRVzYTXK1qaVbO7+ZS2CVOoDvGXDcyFK4VrQ544RutlD38+j39tzNt9zmZ8dYSogJ1I4
         qI2CvdKpYQVS3Ig2Ee3dtjdxqgh9ntkVcTu5NefWpbJG/5MJKSzQK1rs/4A1U+M0wpJR
         2wowSWLnafMZud15464KUegsXrkwZNr4oOMtiNPu09LmpPr7zuFCwXBP+lhyiVjstxN5
         kDuC1aWUM2e9jOXW8Z3/9Iv2kuNlQ3neYNNwAbLEpgqwqMTQ8GqJTl62CdhqKXYL6I/R
         TnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=J6g4J+gYjXd8OHWCzm+tXzp/795vOtzfgmy4dG6lLeU=;
        b=2vWVVTgTrXfY3iEn01FVgbQyg0OY0pXejST4+RC8ad/WTrxC/qKs1GUuGFkflQ4qeu
         WUm/xSGOOQqnwMkGWFJ5woYSez+6iMrxcBFz+gr96N9tBDfswKaYCyW7At/J1Oa/n6H5
         e6ry9sVzNMLLwzgIC4Lf7SvqZ+sAw5AcFIgcH/rRSQSInTAxVnsMNNpDyLKINwx64aPp
         upvnh0V8pRYtCpV3T5AMd/zOOUnL1hULagH27uSfuDFTMM7Ekc483UUiboXbQuO2nObh
         hYaEEvokiNMsaoSw/0k37XDH6mx1Yv7obttMZ090pe1ZxYriLdPLdgEcB+YZDllA9uRf
         qBDw==
X-Gm-Message-State: ACrzQf0nG1rJGyIk3bqPJ0DFfTrPu3RAh1BwFj1emhtY5et8gPNlPJne
        8vJ3QHSC1feG6+eUzQxKchM=
X-Google-Smtp-Source: AMsMyM56mM/0EyLlbyS2sE9U0WxWKUevEa4qdXO9H3trLQUX/NR2nmRliblkBfDWAcNo4gGn/yAqgg==
X-Received: by 2002:a05:6402:51c6:b0:451:6379:81cb with SMTP id r6-20020a05640251c600b00451637981cbmr1334443edd.372.1663273796153;
        Thu, 15 Sep 2022 13:29:56 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-43.ip.prioritytelecom.net. [217.105.46.43])
        by smtp.gmail.com with ESMTPSA id ci25-20020a170906c35900b0072b3406e9c2sm9607295ejb.95.2022.09.15.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 13:29:55 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH 0/5] staging: vt6655: Implement allocation failure handling
Date:   Thu, 15 Sep 2022 22:29:31 +0200
Message-Id: <cover.1663273218.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This driver does not handle allocation failure when receiving data very well.
This patchset implements better handling in the case of allocation failure.

Nam Cao (5):
  staging: vt6655: remove redundant if condition
  staging: vt6655: change vnt_receive_frame return type to void
  staging: vt6655: split device_alloc_rx_buf
  staging: vt6655: change device_alloc_rx_buf's argument
  staging: vt6655: implement allocation failure handling

 drivers/staging/vt6655/device_main.c | 41 ++++++++++++++++++----------
 drivers/staging/vt6655/dpc.c         |  8 +++---
 drivers/staging/vt6655/dpc.h         |  2 +-
 3 files changed, 31 insertions(+), 20 deletions(-)

-- 
2.25.1

