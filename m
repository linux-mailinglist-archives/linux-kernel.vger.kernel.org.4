Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455AC67BDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjAYVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbjAYVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:12:26 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE44AA68
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:12:15 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 84-20020a630257000000b00477f88d334eso8762775pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V7hcBGquDXE1ItKYAPtHX4Q2dU+QIoSg4FK+T/D54PA=;
        b=L3NS8SHVeGfpP8K/JnRDmG6rwnuTD7bUQPX9vwPg3CHqHUok3RLjFxC0zFNpqDnaeh
         Hx93o78ZU46ooMSpQw6aRrqirTJde4WdlhK4xSLWkZNygnuWtZpcF98c/y/1QUvGfyZJ
         FqsqDPg0g+TI3Lw0tnqtvMnoXN+uMo0PNhg++KqF8iThWlGYxvVHP7lsfsgp9g5TgSee
         X1abd54KYFSDbLmoglzJSriOoi7uC4RZlxo6NJCVHpj0lB8fKFZ7YExlWS5Zw4sJroSJ
         uUtTpP1jcy1TC2tsAruW+WUDLrjO+nXEaFFQmHBtofDQhyYgAUHMhtg7kb4FKjbREwOn
         Etcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7hcBGquDXE1ItKYAPtHX4Q2dU+QIoSg4FK+T/D54PA=;
        b=RbxabJbrPGlM+r1ya0IwYfxmKzistW1emR1U/lGGxcDFJXLtJ99s5lfJTV8/6G6+eB
         ffNsEOECeQHVWJ/E5p9AIh3dwhkR3MR+OS71YJFMaALl2CMn0CnCdeW9xbj5Od/ufT9v
         aZDVEmKpU9X0qiWRFIb4D6bTnzN3qGOUjLLftpTKdScm35tYdKX/j2G04KgOeTSAqwaZ
         26mnyPEEMJzVpOxi4bGCSiExF801wkjk/RZB87sWAkNAcl/DqY2fa9fHRnoyWbrDj1dD
         bc3ImgXj1OIRCYAhQbkK+XvNPZEOV9WRVPeILK1a9PbIv2gD3hczuZRLbmAW0AxplWql
         wg4w==
X-Gm-Message-State: AFqh2kpLMxzHXVe/SgAgJuM4DHApTaAV3JHXn0W84E5voGAuLFPPVcA2
        NlXk2U79j2aCw8qYS4vxqhoFxk85V9/B
X-Google-Smtp-Source: AMrXdXurpipw0Ob2XUbpzap2fmXipRkyZte6Rsax47X//HKaWpT1QbUHEQGrvK5nz9rePsp4XryFA7XgyMhb
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:e83:b0:56b:9ce2:891f with SMTP id
 bo3-20020a056a000e8300b0056b9ce2891fmr3438596pfb.43.1674681134438; Wed, 25
 Jan 2023 13:12:14 -0800 (PST)
Date:   Wed, 25 Jan 2023 13:12:09 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125211210.552679-1-jiangzp@google.com>
Subject: [kernel PATCH v1 0/1] Reason to disable adv during power off without clearing
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This change was made to keep the same behavior as before the hci_sync
rework. When the adapter is powered off, the advertisement will be
disabled, instead of being cleared. As a result, when the adapter is powered
on, the advertisement can be re-enabled. There is no need to re-register
the same advertisement.

However, if the adv is not cleared and the user requested to remove the
adv when the adapter is off, it will trigger GPIO reset, so we will not
send the HCI command in this case.

Changes in v1:
- Mark the advertisement as disabled instead of clearing it.
- Remove the advertisement without sending HCI command if the adapter is off.

Archie Pusaka (1):
  Bluetooth: Don't send HCI commands to remove adv if adapter is off

 net/bluetooth/hci_sync.c | 57 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

-- 
2.39.1.456.gfc5497dd1b-goog

