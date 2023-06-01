Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75CC71F655
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjFAXCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFAXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:02:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC1213D;
        Thu,  1 Jun 2023 16:02:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2562cc85d3dso1084144a91.1;
        Thu, 01 Jun 2023 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685660524; x=1688252524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8AQOja+G46vAJbdfQt8QEqJQ6D1aKuejDiORwMFbcwo=;
        b=JvF295kQwwL9nFaLdIEw5I9K4aPI98nE/TzT8CXobx7CjFOMnL2GcWwLBayLpLQJ4M
         6ctD9C46npPvf7yKVu9CettFRkRh7xD4IceBCtm7YnxOdeMMcKfconbN0ngB9n51hIbH
         xbMrWwcpG7EOo3zDN8s6Zza+UAmSEavLMXpQADhCx0zsg2rFJUHkQRO34n8PlvCJjcrA
         B8yofBGTCCP/Zc4QqvFalxFz32VM1uzTuJttQsfupU7W9tAQDrjyFTHprXUoStG1n7tp
         S940KkzrwlbhxniXQ7NLE/I94xPJpdRMkivPPQYrjufLjtNlAGAI8WbepC3+0tR4DISn
         Z0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685660524; x=1688252524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AQOja+G46vAJbdfQt8QEqJQ6D1aKuejDiORwMFbcwo=;
        b=KborSbW4CjwT7J/t/SusqHMnZ5KkC+jw06/aZwVg94RIt24ZppUSvRlkXv2Usulqom
         0qTG6YSC9oUSc7ZJDIxth2ixbMZt8+1ILu7nnuJrzEhWJXM7M6CgrCt2/owyR79+IP7s
         llp+aMt6b5YFNd5ur06v2npwvCOM7EasNBhLcWSs/ELmPrgsYMPMB3DzeITpEUVHBG/2
         HrmmZauWJq+H7PjX/BHRi+Cnp7uDuisKoY8wx3KcMB/lhnd67I8EVyy1hLwz6NcQ/u25
         7PQR4+YdJpH/YRBGy+rAjgPQ5oUuiBVWDnmXvWMT9GQaAVCvXBiksE2YkIRj8pE4Kr5/
         HaqQ==
X-Gm-Message-State: AC+VfDwb72pHWJFhUeWNEUMn4bXFtVBi1yxnEGdWiJF2simt9jNb1LZs
        Wnc8gjvuwYMkR9rhkKuPM/g=
X-Google-Smtp-Source: ACHHUZ7InpIFlD65V/WMZ4KI4Fe0pcVeMLaL2vIMQkdnHs+SHqBsmLa2uacG/Pgze459dBMKmmsMUw==
X-Received: by 2002:a17:90b:1bd1:b0:256:cf04:f8f7 with SMTP id oa17-20020a17090b1bd100b00256cf04f8f7mr651984pjb.29.1685660524167;
        Thu, 01 Jun 2023 16:02:04 -0700 (PDT)
Received: from babbage.. (162-227-164-7.lightspeed.sntcca.sbcglobal.net. [162.227.164.7])
        by smtp.gmail.com with ESMTPSA id lr4-20020a17090b4b8400b002467717fa60sm23957pjb.16.2023.06.01.16.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:02:03 -0700 (PDT)
From:   msmulski2@gmail.com
To:     linus.walleij@linaro.org
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Smulski <michal.smulski@ooma.com>
Subject: [PATCH v2 0/1] gpio: mpc8xxx: latch GPIOs state on module load when configured as output
Date:   Thu,  1 Jun 2023 16:01:59 -0700
Message-Id: <20230601230200.6128-1-msmulski2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Smulski <michal.smulski@ooma.com>

Changes between v1 and v2:
* moved comments closer to the added code for clarity.

Michal Smulski (1):
  gpio: mpc8xxx: latch GPIOs state on module load when configured as
    output

 drivers/gpio/gpio-mpc8xxx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1

