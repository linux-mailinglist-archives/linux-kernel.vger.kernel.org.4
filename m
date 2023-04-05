Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E26D7B09
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjDELTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbjDELTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:19:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15DB30DF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:19:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a11so36916317lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1680693555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=72pc9vhyxIvuldDD9tgX3t3tikielO9csSBNDuIyf3o=;
        b=K6oEpw3Ow3MY/fIglFjdqs7nhBovJ0r5oo8cyRibK36zpeJpjRGoLS7cgvCWHIa9nF
         fuK7Im4DfoKzl13jtvCJPkvke1aMER4AkFs2ONuIQhUaVujKGb4on2TyBAnIEB/dAtxK
         HpOoJmobAOKP95UMTLXV2MIrbFYNOGb5aI2MBq5OLbvK/YuOqMNJsD1ZfIyMHwvyofdI
         PgkKrr0sPrWdKV8wkgnaEe2+sud3GoBYRiJ5d50+dBiQtsG5XRX5E/1CDz0e8MkDqdEC
         PmHs3opQgWj9ngvvEqs/aHWunR4WSCK4nnIx3Sa5sBo9C68kKTeR1qeXpe5ZfBNJr7/c
         JfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72pc9vhyxIvuldDD9tgX3t3tikielO9csSBNDuIyf3o=;
        b=Thw0u1WVDmCpT8C968kvsANuvgdj/KCaWFsea/wPzP6dekKfcU0/nfMXhQhuIDGh2N
         S8SRoOi4JPaq58dIPPhQRLEvarXySBnv1z8QSMH8tjwMW11OdLCfyUtZsyMnVUZWH5UN
         NpTdepFhtEYLOkKyZ4ap+Edawl46BGLqtbt/QTcZIZZWrEUyE8jO8Jr/J8VRvzuwmWlZ
         Ab8CN43YlEDvHHargz9zOJ1DofO2cl2yeWsp2GQNW0H8DieEkX/0PNYfC81fVur/BJIO
         XVFE4nXL7KDjiKrpL1od3pQdIyfq0RwDEG+DLBKSMfwDyudzh79emPtFD7ydKpcbnyqb
         EQoQ==
X-Gm-Message-State: AAQBX9eNn+JfFU49whz8Q1kRvOqPu9OsxsBpvYryujvz290fjC3t/Lmc
        AcRaL46oDYCqve84LpD5sk2kig==
X-Google-Smtp-Source: AKy350aqpMgxzpiwXdM0m+GyuhcnrtO6q0xeQ4vOzynG0W8GswzngaH57R0hUCWQ9zYyklnBmvSXCA==
X-Received: by 2002:a2e:93c3:0:b0:2a6:3570:72d1 with SMTP id p3-20020a2e93c3000000b002a6357072d1mr1893217ljh.19.1680693554998;
        Wed, 05 Apr 2023 04:19:14 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id i19-20020a2e8093000000b0029f3e2efbb9sm2817730ljg.90.2023.04.05.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:19:14 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, Lukasz Majczak <lma@semihalf.com>
Subject: [PATCH v2 0/2] serial: core: fix broken console after suspend
Date:   Wed,  5 Apr 2023 13:15:57 +0200
Message-Id: <20230405111559.110220-1-lma@semihalf.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
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

This is v2 of a patch[1].
v1->v2:
* Fixed typos in commit message
* Tested[2] patch "serial: core: preserve cflags, ispeed and ospeed" on all
  current LTS kernels (4.14, 4.19, 5.4, 5.10, 5.15, 6.1) and on top of
  6.3-rc5 with positive results - console was working after resume
* During tests another issue was observed  on 6.1+ - FIFO not enabled after
  resume - and an additional change was needed ("serial: core: enable
  FIFO after resume")
* Test procedure:
  1) ensure the console output is ok
  2) suspend device with "echo freeze > /sys/power/state"
     (/sys/module/printk/parameters/console_suspend == N)
  3) resume device and check the console output
  4) suspend device with "echo freeze > /sys/power/state"
     (/sys/module/printk/parameters/console_suspend == Y)
  5) resume device and check the console output

[1] https://lore.kernel.org/lkml/20230301075751.43839-1-lma@semihalf.com/
[2] Test platforms: PC with i5-8400 + GB H370M D3H
		    HP Elite c1030 Chromebook Enterprise i5-10310U

Lukasz Majczak (2):
  serial: core: preserve cflags, ispeed and ospeed
  serial: core: enable FIFO after resume

 drivers/tty/serial/serial_core.c | 57 +++++++++++++++-----------------
 1 file changed, 27 insertions(+), 30 deletions(-)

-- 
2.40.0.577.gac1e443424-goog

