Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC55FE458
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMVpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJMVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:45:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463AC53A66
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:45:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-352e29ff8c2so28650257b3.21
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q2R/hsm49uk88OerGE7g+BdKMkZvbcCHzaGf+dnABps=;
        b=Zm4JNi59McSgtrZO3mTQE5c795q2xbejWFdsYn2FLal8WgYRezz4RsjUb9EegTCKF4
         1+NnxEFTQgcvq29EQpQ8XxZnLIDXWY4Gbc1yUAa+0e9WrWHGaLztknyIUeOfsCEVjJzO
         6MelgFtufgP93wq3/AYgv+NfsuBT+9Gmy/m4w6E8jlds9Dgy6E8CKdG9/zRn4cZ+jg/a
         E3KBJoheGEd4rtN2YtBXFyMUkD8xm82haWrPa9yAcxU0a1Nu0yCLUeR2EToqlf9qfjtM
         6oKWfRCm38QN92WUPgaKVL9vZRBsUcTZeO2i6CcVh8uq5QptXvsPWlCkRG/iKED0Fh+A
         tZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2R/hsm49uk88OerGE7g+BdKMkZvbcCHzaGf+dnABps=;
        b=Qm3xphV+O0Imk4IupztroMNHRm4fyvVuSzfp0sT4+T/XkpeIJ21hB7wKA/75aZUh+6
         bjlPuy6L8WdG96M2zlQ4B9p4wVZOBXVno1itd2LLRtt95M8nPxgp0RaaZeAS5VS1qpIg
         mwILfN/bdveqebhQILvAJSAQoe20XYKH34txaeurc+mIKJcPg7qFNXDdibaeK99lVS8j
         fAqH2eNhWDjKwHFFsKcXePVFYU2+Y1uzYTuqxoZNeuam19Zc+CHHeJq4BkXn0Yh1GfJ8
         x+sK+xin+PHjhcJI7laaLxu/p7O1ItB9VQKfqSuZ5sbu0r1dWcHtzn34wK6iy2mr6Sn4
         HthA==
X-Gm-Message-State: ACrzQf00I5TcghDQHpRn9AFVhepMoOoDNNtseul8oD83SGHc5kA8pJ+x
        Myy8k3nr565rYdZqkxWE5///QCZw9bD0
X-Google-Smtp-Source: AMsMyM6A+6LUVQQdIiV2XphAdHir7CheNdf1l8TPeEh1HPXHTo6V9a4uDUfdS5Oi1nF0vQP8MwWXn9lR2rEO
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a81:9e42:0:b0:361:4dad:7a95 with SMTP id
 n2-20020a819e42000000b003614dad7a95mr1959497ywj.256.1665697513640; Thu, 13
 Oct 2022 14:45:13 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:45:07 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013214508.2195347-1-jiangzp@google.com>
Subject: [PATCH v1 0/1] Bluetooth: hci_qca: only assign wakeup with serial
 port support
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch will check if the serial port supports wakeup before assigning
the hdev->wakeup callback. After landing the 'commit c1a74160eaf1a
("Bluetooth: hci_qca: Add device_may_wakeup support")', the wake-on-bt
was broken in Jacuzzi because the qca_wakeup returns false. In this case
it will fall back to the default hci_uart_wakeup.

Changes in v1:
- Check serial port support before assigning wakeup callback

Zhengping Jiang (1):
  Bluetooth: hci_qca: only assign wakeup with serial port support

 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.38.0.413.g74048e4d9e-goog

