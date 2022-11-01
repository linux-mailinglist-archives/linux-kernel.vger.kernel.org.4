Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F7561433B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKAC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKAC2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:28:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EE11789E;
        Mon, 31 Oct 2022 19:28:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r18so12248574pgr.12;
        Mon, 31 Oct 2022 19:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcYDeI5SBeBnTD+t/yVKUy/qxI+mXodW4zJ5wc3sj7g=;
        b=C4FK3XybtipAlqgoYWZe/WzlhC82YUsRxr8zgYTroJf82Xdb9uumW5TYpZ+J5tB915
         uNxwl3bwD+VqtSzArx8MZ0pEZ7F848a7TyG+8JlcmkMiy3zYBEJ5c9Mpzr6WxIZ+kM1k
         gw0P9iJwXghJoblIlXvyFbLF4Vw3peX9j/fmwibD/d0Qk+4mEafrRUhF696Wqpbw2a4D
         57eopvOwHaubxmD7zUSe/rsvslezFdCSjZEncCX5yvQg6972ZXjRouxHXZmXCKbq1ygt
         KMgzzwGwDeo4YDMro8KixnxyBnMkWb4RWRRptJPN48pw821dUVCsHlNkk0fNZyBGHT/5
         vB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcYDeI5SBeBnTD+t/yVKUy/qxI+mXodW4zJ5wc3sj7g=;
        b=i32JYzypQhIl4WfcON6liBwIoQELT5KA721Kzad02zlNP2ZiiMbwQj1nXDc4iLk7v9
         MAnkTXLnXXwJagLeklRvZParfgAZJqyreu4W2ZLCfSSw11seDO7n9kGDwnhgpsIi4KuT
         HYf5A5S+iey1txTqaFDRsOvzJiZCMxrgKxbxhG8onwAqSqv2r2s28OwDaseiDkQDSR0g
         PBkuAFscpk4qDoJM1pGGd1kti3a5RcD5sdk0CNOt08kMntqK1PUPlnTlndQotmrB7R2K
         uGrshLrnuxZEkhdznO7xy07Ze37GZwy+M4FbMA4HGjRvXVpNqI0WiQ4QgzPsePrvy7fQ
         nz/Q==
X-Gm-Message-State: ACrzQf0GEinBBW8bxABFHQ/g7VoibkbrnyAmZDwxmMreiNZ1q0HsHVUT
        xJxB3yhx/sQTEmxy855Szhs=
X-Google-Smtp-Source: AMsMyM7Ulyp+a388OV9INgKc/JfAXLQTl8oJNbn5WefBkUQGKIa1Fl//qX+7mhHO6Tt0eKInzbHH9g==
X-Received: by 2002:a63:2158:0:b0:46f:9c0c:8673 with SMTP id s24-20020a632158000000b0046f9c0c8673mr50182pgm.154.1667269725704;
        Mon, 31 Oct 2022 19:28:45 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id t5-20020a625f05000000b005385e2e86eesm5126925pfb.18.2022.10.31.19.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 19:28:45 -0700 (PDT)
From:   TGSP <tgsp002@gmail.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        huanglei@kylinos.cn
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH -next 0/2] Fixes to the hibernate_preallocate_memory()
Date:   Tue,  1 Nov 2022 10:28:38 +0800
Message-Id: <20221101022840.1351163-1-tgsp002@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiongxin <xiongxin@kylinos.cn>

hibernate_preallocate_memory() function is still quite obscure, can
anyone add a little more description?

It seems that the max_size calculation formula is wrong in the comment
part, correct it;

It is also found that when mem preallocate is not enough, it goes
directly down without checking.

xiongxin (2):
  PM: hibernate: fix spelling mistake for annotation
  PM: hibernate: add check of preallocate mem for image size pages

 kernel/power/snapshot.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.25.1

