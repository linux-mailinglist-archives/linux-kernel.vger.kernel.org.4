Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8F72A036
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjFIQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFIQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:31:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42571AB;
        Fri,  9 Jun 2023 09:31:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977c89c47bdso350587566b.2;
        Fri, 09 Jun 2023 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686328315; x=1688920315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rlAqFxCz5Ne5aNPQx9aRysGdidTcTLDbsbNzl4FRlY=;
        b=OiKlFAj+WWsrQxniU3ecowfRCGEQJZGnKPIDPfv2NJOLuv+WqOALRhRa+Q97+yktHQ
         zskEvCVr+lA6oOv8lWmZujjjvbBa4rsbHN6YE+2BhxSu0nEnGgv0y7TbbEa4INrxyibr
         5hZvsJxI0NLbBI8v+49cgtmtlkP7LbZ0cpVyx92vI3lVp1E2IwGDfWpdtLBLtWPZCDvk
         bqF8LfdUsWuXL4kITuj7yx+hhfNY0lfBTUyTGng1Jg1m0SvTjPeS/ImQUHEWmKrCfQiA
         BV93XhXJ3/dgtu8fPSOj0O9Zi28P6fTmJxaLUcX1YOhlsne4FlScjoIDAWC/uULI2uUD
         owTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686328315; x=1688920315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rlAqFxCz5Ne5aNPQx9aRysGdidTcTLDbsbNzl4FRlY=;
        b=J9gqaWsOCK+GpkjV3MBdsJRBVzhgqCTNul4ozOcROJ+sm0kqWq8mBqvckAGplAcdzz
         /lQqCEsJ+dULaSdBeZEZ8otE0NMfL4524rweY6Jf+f5/sm93XLv3CfQsRdpiZWrTY5NF
         TJptccidcj2Ol82OcaKvbh5ezWbCxwOSSFSoo9FwDZ3AGAntuexVvhQBEZSPR9yjdu1B
         AvU/mekMgUTmbsF30gmvqQcVCx0pJaqyA5q5xlGCGzimzJtRPIvRQbYYwXs/Ycie6Anm
         B62VUiiLUBCRnNEbAs5MdL/kie13k8uz6bPGmoCrgWONfdwcw4C5+FG2cgt5FKHT9kRe
         XTlg==
X-Gm-Message-State: AC+VfDy7Ljr9lWvm90BD/ZWSUZ3UBTckXKkBNWUGa/SVWl8e0HkPblm4
        szLf8CroqWuUmYzF6t/UR/EEnIP//74=
X-Google-Smtp-Source: ACHHUZ5EO2p2JLlN6XiQPXK/vURKlAPjMKBtnTzV9exHQvAM/+VuYFafNdOrH+efudjq/20k7/tocw==
X-Received: by 2002:a17:906:fe4d:b0:974:1e0e:91ee with SMTP id wz13-20020a170906fe4d00b009741e0e91eemr2526028ejb.13.1686328314902;
        Fri, 09 Jun 2023 09:31:54 -0700 (PDT)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id kg1-20020a17090776e100b00977da5d3350sm1449326ejc.107.2023.06.09.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:31:54 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.4-rc6
Date:   Fri,  9 Jun 2023 18:31:42 +0200
Message-Id: <20230609163142.16428-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Hi Linus,

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.4-rc6

for you to fetch changes up to 409e873ea3c1fd3079909718bbeb06ac1ec7f38b:

  ceph: fix use-after-free bug for inodes when flushing capsnaps (2023-06-08 08:56:25 +0200)

----------------------------------------------------------------
A fix for a potential data corruption in differential backup and
snapshot-based mirroring scenarios in RBD and a reference counting
fixup to avoid use-after-free in CephFS, all marked for stable.

----------------------------------------------------------------
Ilya Dryomov (2):
      rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting
      rbd: get snapshot context after exclusive lock is ensured to be held

Xiubo Li (1):
      ceph: fix use-after-free bug for inodes when flushing capsnaps

 drivers/block/rbd.c | 62 +++++++++++++++++++++++++++++++++++++----------------
 fs/ceph/caps.c      |  6 ++++++
 fs/ceph/snap.c      |  4 +++-
 3 files changed, 53 insertions(+), 19 deletions(-)
