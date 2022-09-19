Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF80F5BD5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiISUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiISUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:20:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2295C48C83
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:20:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t7so868675wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rleumtfsTqJmyQKHKe7K6jC9PgKbDZt02ru2L/1PApQ=;
        b=glCYw8Hs3O+85oP7tfzZwLJ1JR5Tkl/Zfkjf1X/Oq12xCUaXUBneUzQrnUB8P/Vxgo
         uYisVvYLvzldBy1no5802aMwOr+hWM3HBQIJlUo0oqM73uhXJ40LoOvMabG2rhlNVIBx
         J999xlBbSdmeLcGnWxqkpqzBHBGTRgOS5Nd6CaAxGbmubNVVrJWcAyA8AvvtvBJKn8GX
         UYVifNIA+gfXwdmjjTaC3YdcMddNbI3dKwsBPqNu0VctuSjtw8gx5S1OKAVHxn+/rkCM
         VfP9sOWWA9ooJcvzuFJofUKAhcn1jj8TN8mcwMAgUt1lWArzpqQdZJJg5DTU3aRM4ehX
         bCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rleumtfsTqJmyQKHKe7K6jC9PgKbDZt02ru2L/1PApQ=;
        b=20mAMkiSW9eptgPuWOISGTlBnk/rL+KR6xaIaS+K0ObqDxTavROks2fM7Sux3hCrly
         CVzra1tf3ztwV5R33eYAQ1lTrs7GVi2pTcQH1nx9OiOUnfkt7sFq7GAhRjjc67j7u9S4
         mEAFAaexYpqk13SoQVQjBdPZf9A/U7hrsg0SEGOWPpTdCRU3xK+mNX0AsNsp1Xr1taB8
         laek/K82dNGhBEjrMRkassfBhG3OEe4UWYiK+WFnw6MrSMDlo2eXw4wTGbUcrDuNFlun
         ezzXmYuWBtjQfsQveul2dfNvLcexnzFAtwwzWB6nZExVT1eQdqCk6cIojlD3lPm09VfV
         pWHQ==
X-Gm-Message-State: ACrzQf3trs085km783vMkd1m+OWkqX5tR4JoTYaCTdfUFxslD6vOIX7F
        TrEt/9zNkuTHFIReeavbz0qwW3scQZ1MBhsZ
X-Google-Smtp-Source: AMsMyM6kvysW+w84W4NM9Jg8am0rokoV2PqOrn+9to55Hk/t+UGKfvdQq3aL4AGmC//oWOkJM3jAew==
X-Received: by 2002:a05:6000:1842:b0:22a:4d1d:4bd6 with SMTP id c2-20020a056000184200b0022a4d1d4bd6mr11736864wri.603.1663618805346;
        Mon, 19 Sep 2022 13:20:05 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm17342849wmq.23.2022.09.19.13.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 13:20:04 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] selftests/Make: Recursively build TARGETS list
Date:   Mon, 19 Sep 2022 21:19:56 +0100
Message-Id: <20220919201958.279545-1-dima@arista.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 changes:
- fix `make install` in sub-directories with TARGETS, but with no
  TEST_LIST defined, i.e. selftests/net directory
  (reported-by: kernel test robot <yujie.liu@intel.com>)
- vfork_exec selftest is about to be reverted, don't add .gitignore entry

From [1]:
> Please look into a wayto invoke all of them instead of adding individual
> net/* to the main Makefile. This list seems to be growing. :)

I might have misunderstood what was suggested... Here is an attempt to
let sub-selftests define their own $(TARGETS) directories.

[1]: https://lore.kernel.org/all/aa0143bc-b0d1-69fb-c117-1e7241f0ad89@linuxfoundation.org/T/#u

Version 1: https://lore.kernel.org/all/20220905202108.89338-1-dima@arista.com/T/#u

Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

Dmitry Safonov (2):
  selftests/Make: Recursively build TARGETS list
  selftests/.gitignore: Add io_uring_zerocopy_tx

 tools/testing/selftests/Makefile             | 71 ++++----------------
 tools/testing/selftests/drivers/Makefile     |  7 ++
 tools/testing/selftests/filesystems/Makefile |  4 ++
 tools/testing/selftests/lib.mk               | 60 ++++++++++++++++-
 tools/testing/selftests/net/.gitignore       |  1 +
 tools/testing/selftests/net/Makefile         |  4 ++
 6 files changed, 87 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/Makefile


base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
-- 
2.37.2

