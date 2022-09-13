Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9015B6C33
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiIMLGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiIMLGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:06:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AE74AD71
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:06:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u22so11426336plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dunHHPlB+nYX+OCkYqb8tHR/AQ3hXA5uxH59CPiYJAU=;
        b=qFUrzB8xdRJpCVirtXiFSX3vO3/sweRrBDdl0rAaFt6mX8ocWdyYpcTabCWpEefvym
         OTIysLoRgQOOxkWP2H45QIYOG30XsLFlxMNPjm9FmEYmL/5y3TCTkNaFhyypND00IFI/
         UYEHE+odGfvPDPpxHsQ1JRQU47x7ep8Ire//mlWpfSaPq/WrkhoZXdOHhg68odVRk5vj
         Sa38xGD+A93QZ4a+oMlvoNZStbjApcctumyde0ZxXyRhfY9cVmTbnu6lDNeKtGXw+vXm
         Bajnro7FS6Rp84kNfqd7S/vOOQiXubd4Zwac6bKIS5A8Uj2KYJClZ5LfDPiFAZaITXrb
         wm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dunHHPlB+nYX+OCkYqb8tHR/AQ3hXA5uxH59CPiYJAU=;
        b=yFaimcgHnM/Ou5ae02OKeVTdsCihnVBTnhzl2OsIEZix6kH9Nb/UM8BQSBrEtGP+cr
         mwpoa/oP6WeCzZYkQG7daF0022iGeS2a+BjHEXIAPEiX9XmoWt1DKN+vNN9N8TIKAXBB
         pr0M1WOB4umnWe2NXIib7BYqb+6s/rpgO6R93Ojh35wpp/PvZmtPBeWJ+Kgq0py1YmkN
         4cR+SS2xnb2F7U8uT4QZSxvxrXwkvVDAIQzWi9cRARXs6RB+he1+bkbjMhLUU1gCSUlh
         hEMI17VAcPB0+18ypPSZixwPBO04W5iKWTJx/UdPYctay0BkSqJ2wAb1t2pT8Vlr+EaH
         XaPg==
X-Gm-Message-State: ACgBeo1447lenDDgEQL8U65YYvw9Zhik6Xjdw3LDTUh8Gky0ZTNtSvcG
        tvC4E/yZs3TbudlaLzXGyTE=
X-Google-Smtp-Source: AA6agR6hJ7Qs33AEQ6ghHq11kpJTt1cYC9ayG/d8iuEFMQ7rJOYyqNS0Icn7cPHiTuVMAg2COugXGw==
X-Received: by 2002:a17:90b:23d8:b0:202:a51a:2512 with SMTP id md24-20020a17090b23d800b00202a51a2512mr3429735pjb.106.1663067201311;
        Tue, 13 Sep 2022 04:06:41 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cm3-20020a17090afa0300b002000d577cc3sm6888658pjb.55.2022.09.13.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:06:41 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, shaojunjun@coolpad.com, zbestahu@gmail.com,
        Yue Hu <huyue2@coolpad.com>
Subject: [RFC PATCH v4 0/2] erofs: support compressed fragments data
Date:   Tue, 13 Sep 2022 19:05:50 +0800
Message-Id: <cover.1663065625.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

This feature can merge tail of per-file or the whole files into a
special inode to achieve greater compression ratio.

Meanwhile, also add a interlaced uncompressed data layout support for
compressed files since fragments feature (and later) can use it.

mkfs v8: https://lore.kernel.org/all/cover.1663065968.git.huyue2@coolpad.com/

changes from v3:
 - improve the interlaced layout for non 4K uncompressed data as well (Xiang)
 - support 64bit fragment offset for fragment inode and legacy compress (Xiang)

changes from v2:
 - enhance the condition to check if pcluster is interlaced or not;
 - no typo.

changes from v1:
 - fix a compiling error without CONFIG_EROFS_FS_ZIP, reported by kernel test
   robot <lkp@intel.com>;
 - introduce the term 'interlaced' for patch 1/2 suggested by Xiang;
 - fix packed inode failure path when read super pointed out by Xiang;
 - use kmap_local_page instead of kmap_atomic pointed out by Xiang;
 - use a simpler way to avoid call read fragment data twice suggested by Xiang;
 - update commit message change.

Yue Hu (2):
  erofs: support interlaced uncompressed data for compressed files
  erofs: support on-disk compressed fragments data

 fs/erofs/decompressor.c | 47 ++++++++++++++++++-------------
 fs/erofs/erofs_fs.h     | 31 +++++++++++++++++----
 fs/erofs/internal.h     | 17 +++++++++--
 fs/erofs/super.c        | 15 ++++++++++
 fs/erofs/sysfs.c        |  2 ++
 fs/erofs/zdata.c        | 48 ++++++++++++++++++++++++++++++-
 fs/erofs/zmap.c         | 62 +++++++++++++++++++++++++++++++++++++----
 7 files changed, 187 insertions(+), 35 deletions(-)

-- 
2.17.1

