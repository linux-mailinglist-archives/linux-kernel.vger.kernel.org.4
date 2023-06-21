Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23373796C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFUDAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUDAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:00:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF860E7E;
        Tue, 20 Jun 2023 20:00:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77e2c42de06so176194439f.1;
        Tue, 20 Jun 2023 20:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687316450; x=1689908450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yk+CCzKPoEK1DNGd+x8aPT6YCsf+viHVDJzfkXgbxwM=;
        b=VRgq37DNHaxMgTnBuph6L5V1HPRkptAq8ksZwGPsvwidL2Xvf6TPy/M9KpkfUx0ZsC
         iSVwUvnf9FMnQU44mimALZbKUh/FkA6Jsdla2+Q6qxYjhqSsWceFrngsZzqVr6UieB1R
         GxJOORpgtrvXvXhpPNn89+bku4KgEnmGzzBqERZLxnRTMEut3yw6nmxCzXvuFU1dvm+R
         Bh+OVpfnwT09V5A72HMZ1lTeh2fXxlelsKk9YzP+yZ8qiYcHpOhZvr4Bgd3N/EA9zikm
         Q2E71GNrAlIaD4WhIBvhbSB19T9dVLcwbOjIucMNtjJmOnPB9IqubxVhMD5m3gNiAOlM
         s75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687316450; x=1689908450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yk+CCzKPoEK1DNGd+x8aPT6YCsf+viHVDJzfkXgbxwM=;
        b=CofBt2hm425r1r3Y4T7INGtdtXnIvfp+2BKSZ9SqRLp991W7CEOK9GzurCoRaEUV/5
         38B3aXH+495Ceqmi8h1a6C1BpsXr6ndTPnq71OHYps+i7kYNBKB9cWnJrBP7PO+u7e1U
         NACcsoadmk9UQsjnv3LdahcadRSHOWZDbZ7y/qLaO9FZdZBWuKNERTTbbbRt6y681I4l
         NFPixB3wpQ9CA/Kw36L0oZJzzlLFIDrmpbdYp42B1UJDB6FiWb7fhh6/3W4A61J7fYea
         oIBHXxRLNOZRVfYw2UN/3RGCSrHOK49kAH4DW9tbvZ1QF8cSqvihl9rPmwte1mKqEET4
         0DRg==
X-Gm-Message-State: AC+VfDyeaHNfU2wr0wGbIlO+TU+9PMDeApbDaDJQgukLp+qeOaXsAsvn
        IRmORK/u/Kff4tZGwtI1XpukeoKnVoPfeQ==
X-Google-Smtp-Source: ACHHUZ5tdpP+vH8ZxE1GLqqc/SHVOSQIlQ7gzYXMLVfVTpncwMOS3+mzoZuOl84qGUimIfjvOsU0LQ==
X-Received: by 2002:a5e:8909:0:b0:777:b6cd:5a93 with SMTP id k9-20020a5e8909000000b00777b6cd5a93mr12837261ioj.2.1687316450166;
        Tue, 20 Jun 2023 20:00:50 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id x6-20020a029706000000b0042682dd951dsm1035008jai.87.2023.06.20.20.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 20:00:49 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bodo Stroesser <bostroesser@gmail.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] scsi: Replace strlcpy with strscpy
Date:   Wed, 21 Jun 2023 03:00:31 +0000
Message-ID: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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

This patch series replaces strlcpy in the scsi subsystem wherever trivial
replacement is possible, i.e return value from strlcpy is unused. The patches
themselves are independent of each other and are included as a series for
ease of review. 

Azeem Shaikh (2):
  scsi: Replace strlcpy with strscpy
  scsi: target: tcmu: Replace strlcpy with strscpy

 drivers/scsi/ncr53c8xx.c          | 2 +-
 drivers/target/target_core_user.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

