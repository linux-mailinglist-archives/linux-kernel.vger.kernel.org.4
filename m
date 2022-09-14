Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620075B8207
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiINHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiINHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:31:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4C6AA01
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:31:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v4so13531805pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Bi82u9DsgdoO75ZKo8/VX4X5fGCUP0wQ3zdQ3GARoh0=;
        b=vfCgkxtcRTBlcKwuI4o4gAY+0321gwOiDbPvENwBMSbguTCxWOl0rtQdCJEMT7obmv
         A2oQq+jYfIi10Rz6jhfe2nf8n1itVn6dV2DQ1l3UKm/RnaN9NuAvBFrYodFV7BSLirLh
         7nBWdvI1Bb8gLsaBkisHurvECUHK+cUsOsi7nm4dp/RLAWQGd364SVkWYo5hwMpy0uS5
         OBsgysFk1WE3zvZJvQFtMVgw0kFiho7BGehTHikGYJy4s4OdQew7zA2y1hA51A4Ny4XD
         //6VH+e+qm4Y3PYK3FE26Xk0AeNZajHxSDzJPjxTiiTkqP2AQFvsuVJ4Hue5qiWGC5Nf
         xYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Bi82u9DsgdoO75ZKo8/VX4X5fGCUP0wQ3zdQ3GARoh0=;
        b=znwP6d+z8eWY3kqE9UkeH0ZrfHx+ZoxXn+v3XCJGRLaB1oF+hz6Zc8abGP1NsQaweQ
         sjeHQpoP/r0BRfqFHTArWN14QH0xE0ShknrrGfQMBVnxp/my7G7c1kKnODh8QzwY2+b+
         tL6M6GQCRem4/uxmWAjjrbuMCUzBun7NaAo/30XtCPa05f7ElmNzjZHm44DpomRD+HSw
         6llPtvb0aG87N29jvZOXqBelQC0v1bLMhLJ0OQhFfPNQQpQxS5JLqZn9TmstRX6VMPkb
         GhMMXZOjYKrFBmjoOtnN6iQe94Qqb1fRz/moqx8tay70RmofAVKsJ5imG81735U1pmmW
         PRZg==
X-Gm-Message-State: ACgBeo3znU9zMjWI46TmK7dywJBxatkuJ8Mu7/2WqgTLNX+hB42pmDWO
        7eEVR/ShkOHxYUIL8OtfXvXbZA==
X-Google-Smtp-Source: AA6agR4+XTzFvoVDOefNtUh7etibxrcCRbvgeYMpFIKxYk5zPAdLNTNT8TK8APJI/Q6QSoQsC4Gz5g==
X-Received: by 2002:a63:88c8:0:b0:439:494d:fd10 with SMTP id l191-20020a6388c8000000b00439494dfd10mr4908998pgd.201.1663140696097;
        Wed, 14 Sep 2022 00:31:36 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b001754cfb5e21sm9831042pln.96.2022.09.14.00.31.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Sep 2022 00:31:35 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
Subject: [PATCH v4 0/2] simplify handling of per-node sysfs creation and removal
Date:   Wed, 14 Sep 2022 15:26:01 +0800
Message-Id: <20220914072603.60293-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on the latest mm-unstable branch (per Andrew).

Muchun Song (2):
  mm: hugetlb: simplify per-node sysfs creation and removal
  mm: hugetlb: eliminate memory-less nodes handling

 drivers/base/node.c     | 141 +++---------------------------------------------
 include/linux/hugetlb.h |  14 +++++
 include/linux/node.h    |  24 ++-------
 mm/hugetlb.c            |  63 +++++++++++-----------
 4 files changed, 55 insertions(+), 187 deletions(-)

-- 
2.11.0

