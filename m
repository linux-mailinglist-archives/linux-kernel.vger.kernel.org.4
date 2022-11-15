Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF29F62A14F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiKOS3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiKOS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:29:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2352FFC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:29:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o7so14059758pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JyDgb7jTANE0Qk859LfOEdF0OgwEPQqULMlB2KUqBqA=;
        b=SPvwBZphKt7+WD2D+YQ/omAaF18nUwvOrvHwpHsUIQwQngxMUoOz8S51fOMuJRUcjy
         O5gyD+/5wcpkmMdwa3/gZlr/Zktv1qA+qM53PvIoaOk83YK0inRytOPqAMc7f47mADV8
         Qalg+zcJAkxyoSH5vGsLFIg2aw1TBgZ0kcyBHwTUFt+jAQ4HCE7fy1cgA5qdFBA9XYeO
         9g/G7BI1dFi+prQUVAbdAm2BBKCxzOzfwfVocNlZZNccSFT2+fKiDNSpoIIFdpSdxSZd
         +zXG1n3WoCJc1IyKZ/khKDqmsSyJrP45w3dMptlCoaswDJNg+QHrtAdDjAYmnAfFkg7j
         w3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyDgb7jTANE0Qk859LfOEdF0OgwEPQqULMlB2KUqBqA=;
        b=WveWs6P5+bYVOntD8H3z1g7uvCZ7WG5o38sk1kPQjV4yUs/RwxRhnWd7riqK/68DBe
         JxijLItTpERqdaBT4hmx8RsCQCndTkBRMBQ29jUEN5TMATOnvh4lEytW+VXSRXChkq0q
         mNc8yp5FnKn19NGEd8Qji3w0tcC3OKpZhL9pi34XVEUVeAj/ESfrDMOsgUApUy75cz9g
         eL/I2rleFInQ9o3BfuHQrD9Mwnq8RutXWcC+PMJQ56BQZamwp9TbkNt5+iTNZL68v3c4
         56t6ZPPAg0rMJ625P7/lcACDWCSlMhAT4GoSsrErh99+d/rzSwm990ChyOZP2qVVhKMx
         Lndg==
X-Gm-Message-State: ANoB5pmU+W8N2xrhPhccAZOWbD5CpNcoBM9VaJp9g/JF/mWf55zp8tKn
        +0IAW+yuYPy4FkBnI0mUto2vAY/uxT7Nlg==
X-Google-Smtp-Source: AA0mqf66garNKvM1of1uk/mXKAilT5V4v/nR05Pj2iYX1RAq7vck4xLmVnWZWoGwC9G9lzt2wbvyCg==
X-Received: by 2002:a17:902:e792:b0:188:dd4b:7da3 with SMTP id cp18-20020a170902e79200b00188dd4b7da3mr32566plb.91.1668536943144;
        Tue, 15 Nov 2022 10:29:03 -0800 (PST)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b0018853dd8832sm10277486plt.4.2022.11.15.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:29:02 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org
Subject: [RFC][PATCH 0/4] cachestat: a new syscall for page cache state of files
Date:   Tue, 15 Nov 2022 10:28:57 -0800
Message-Id: <20221115182901.2755368-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
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

There is currently no good way to query the page cache state of large
file sets and directory trees. There is mincore(), but it scales poorly:
the kernel writes out a lot of bitmap data that userspace has to
aggregate, when the user really doesn not care about per-page information
in that case. The user also needs to mmap and unmap each file as it goes
along, which can be quite slow as well.

This series of patches introduces a new system call, cachestat, that
summarizes the page cache statistics (number of cached pages, dirty
pages, pages marked for writeback, evicted pages etc.) of a file, in a
specified range of bytes. It also include a selftest suite that tests some
typical usage

This interface is inspired by past discussion and concerns with fincore,
which has a similar design (and as a result, issues) as mincore.
Relevant links:

https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04207.html
https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04209.html

For comparison with mincore, I ran both syscalls on a 2TB sparse file:

Using mincore:
real    0m37.510s
user    0m2.934s
sys     0m34.558s

Using cachestat:
real    0m0.009s
user    0m0.000s
sys     0m0.009s

Mincore takes about 4000 times longer to obtain less aggregated
information!

Some open questions:

* What other fields might be useful?
* Huge pages: another useful stat to include is the number of huge pages
  cached. However, as the size of a huge page can vary, having just a
  single field is not very meaningful.
* An alternative would be to have one field for each possible size - but
  this is not future-proof, as bigger sizes might be introduced later.

Johannes Weiner (1):
  workingset: fix confusion around eviction vs refault container

Nhat Pham (3):
  workingset: refactor LRU refault to expose refault recency check
  cachestat: implement cachestat syscall
  selftests: Add selftests for cachestat

 MAINTAINERS                                   |   8 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/swap.h                          |   1 +
 include/linux/syscalls.h                      |   2 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |   8 +
 kernel/sys_ni.c                               |   1 +
 mm/Makefile                                   |   2 +-
 mm/cachestat.c                                | 109 +++++++++++
 mm/workingset.c                               | 142 +++++++++-----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   9 +
 .../selftests/cachestat/test_cachestat.c      | 184 ++++++++++++++++++
 15 files changed, 430 insertions(+), 46 deletions(-)
 create mode 100644 mm/cachestat.c
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c

--
2.30.2
