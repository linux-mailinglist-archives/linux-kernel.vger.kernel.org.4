Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE7735D33
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjFSR5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjFSR5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:57:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FB612A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:57:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-986d871a9beso483896866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687197457; x=1689789457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91ya57sBghq3g7zgKLiTtn0v+IyDnYxUjv4qrxeCvmY=;
        b=qCgGxfZGGUDTq8y218bOMBxMHfghmE+40/FS+XHNOrQ6bDXIzOXaGc3K+U3rim5Mzs
         mqbUcyLVy465st22BiXCyl1ttiGydkBOphM4SCT4+U3IJWgWbNpxfJwV9Cl7H+YqZjOt
         T+heN1Rzrqo9QtHxXJZCgUXZqAoDU+thbTp4QV5C4Oti8q8rDaens4YAHYHhy9Rs3/4h
         vrnCbUkpc9Ppy9wySKEYCpIwX+0Pwo1L0eohpCLZZag4Lz0hSZNc91fwE159S1oxGkiP
         eruUlWwxn53ddn+R540EbaEkhE9f+bJ/oMikHWm548MlIpc1lP43ecoMVV4Z8xeUCw2y
         vAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687197457; x=1689789457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91ya57sBghq3g7zgKLiTtn0v+IyDnYxUjv4qrxeCvmY=;
        b=aKR8vxfTklFCr2GLR7VdFS723sL9c25tWGiyaErLhGZHMmqC2Yk0o7WwUWqNryCaFx
         kVAJ8B3eusDbbk0dHLvJXifo/VAi8F4HcvdOwr6O1sroVFfZnV8N0F9AAeeYnIM+6wEA
         W4Yu9Te18NbtQ9g266T6Jxy2a1MRJhs0lgztBLqc7ln4eeG9aX5IhlIRDOvxrEEsGNn8
         X2Wc5Cx95SDegG9PP8lNwtQTYmtpQKIgNQuU1fIy0lvJDWGxQogrgDnd4+lhucNIKV8G
         Aj0IFz5wXqLo45AhJd11PrFkXdFDV+h3a759FHDvUqcv2Vg8yrx7+Bdipz+YR3SV5QlC
         W/QA==
X-Gm-Message-State: AC+VfDwp5j9toYNZIwtRsL3TwihrF8ySsl13aCvInOxh/Mw/ODYdXkPT
        znODipmaSk5UR7JJdv07j3M=
X-Google-Smtp-Source: ACHHUZ48OeFtLT4mS1Z/ABnCYeFsOL8xaJk3NajO43nO0+eZCexBqnnfhnemhJ+YejJg+rJ+akVKKA==
X-Received: by 2002:a17:907:1609:b0:986:4789:1029 with SMTP id hb9-20020a170907160900b0098647891029mr10134421ejc.23.1687197457026;
        Mon, 19 Jun 2023 10:57:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:dcda:2154:7873:34])
        by smtp.gmail.com with ESMTPSA id q25-20020a170906145900b0098503ba0db4sm9146ejc.149.2023.06.19.10.57.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jun 2023 10:57:36 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, eperi1024@gmail.com,
        hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        gregkh@linuxfoundation.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH 0/5] Fix some checkpatch issues
Date:   Mon, 19 Jun 2023 19:57:03 +0200
Message-Id: <20230619175703.18826-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches to fix some trivial checkpatch issues. Not all
issues have been fixed. I intend to submit another series to fix more stuff.

Testing:
* Build the kernel with `CONFIG_RTL8723BS=m`
* Boot the kernel with busybox in initramfs
* Load the module
-> No errors or warnings

Franziska Naepelt (5):
  staging: rtl8723bs: Fix indentation issues
  staging: rtl8723bs: Fix space issues
  staging: rtl8723bs: Fix block comment issue
  staging: rtl8723bs: Fix blank line issues
  staging: rtl8723bs: Fix alignment open parenthesis

 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 224 +++++++-----------
 1 file changed, 92 insertions(+), 132 deletions(-)


base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
--
2.39.2 (Apple Git-143)

