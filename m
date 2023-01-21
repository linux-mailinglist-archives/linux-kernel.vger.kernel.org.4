Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8179676297
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjAUA43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUA41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:56:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FDD5B599
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:56:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k18so6760133pll.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VKGR7N650E7ohgzsXOGi0UW8d19AxSmbFhxS4oOPuI=;
        b=LuoTvggKccsVj/ta1iOl2g1SjsxkLevfThTHAfn7dchNuK5g6AfJEQmj/EZn5PGSoc
         XcpESgSxn26HUCkKI6Dnl9JKpPNxSDIXcwki5n3KU3ZAW6CkOF4FxUAtJPzJcWbCwdK5
         eUyBZYnT6rbFdFiVMnr5n6rPA6J6wyUfxD6eawATMcBNvHsXdGppjThrNJiKU5EMKHG9
         L2N1YddMK3y1VHJDvyj0YdjHSt9SoLFo3P075qqGor4+4HGqGs1WHMWAQ1CI178i2/Nl
         0fvWDxgr7NOn6gIfR1uj20gcFI8NQe9B1qFEbo3+riccihuVhK5+ep4pO+QH9AkcCjl7
         taag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VKGR7N650E7ohgzsXOGi0UW8d19AxSmbFhxS4oOPuI=;
        b=weRjTBj4SJcQFZB/Ir/Q88z6EddkKS7B+9+YuuS6o95OjkMXQhT1/wtBbRUIWahS20
         UC3EaFBXSm2U8kTIMmBGjqIcYi+Z6YQUwPXQaut4Z+Q5ASpKdQCu33SdZeUgW/lsNBPf
         1U5PtMm/3OhE0a52ev3E8zuv0CSZZVMJq05ofi/XIZIFlWRQHm158u2bopGhCOe4L0Zf
         6pOMVB18vCkpW5BhsfHnBzmmtF9VNiMUdJqtIpLc2GSXn7O1HFccnFt29OpGylMpyxAs
         E6rNut2zI6i4PhH/o78qU238KEJ80kXwvqUDG4X4uon9Xo/yGFQKF4LWUeAGBKEjReoF
         FUQQ==
X-Gm-Message-State: AFqh2krVBpmjSvt3tI1pL3D64sEeVxOqHJlJKfIrxnnoP9Qxu3NkIwLP
        N5hNaskaIApTCFBDwlg5i6M=
X-Google-Smtp-Source: AMrXdXssS18iUi3fPwCfrq30hBXJ0lkVoisnrSl8bx2HZQ0jzubET40JAXg69+o6O6zwf0fdY+8c3Q==
X-Received: by 2002:a17:90b:3445:b0:228:d1d5:5468 with SMTP id lj5-20020a17090b344500b00228d1d55468mr17777388pjb.25.1674262586338;
        Fri, 20 Jan 2023 16:56:26 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id pc3-20020a17090b3b8300b001fde655225fsm11314371pjb.2.2023.01.20.16.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:56:25 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/3] Convert a couple migrate functions to use folios
Date:   Fri, 20 Jan 2023 16:56:19 -0800
Message-Id: <20230121005622.57808-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This patch set introduces folio_movable_ops() and converts 3 functions
in mm/migrate.c to use folios.

---
This can go under Sid's hugetlb fault function folio conversions as
suggested by Matthew.

Link: https://lore.kernel.org/linux-mm/Y8orMisdXzaUI0t8@casper.infradead.org/

Vishal Moola (Oracle) (3):
  mm: Add folio_movable_ops()
  mm/migrate: Convert isolate_movable_page() to use folios
  mm/migrate: Convert putback_movable_pages() to use folios

 include/linux/migrate.h |  9 +++++
 mm/migrate.c            | 87 +++++++++++++++++++++--------------------
 2 files changed, 53 insertions(+), 43 deletions(-)

-- 
2.38.1

