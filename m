Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE026DA626
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjDFXkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDFXkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BFE7ED2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680824399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FyyxmsR12PIJKtju28/DIjkSeXN5QuTWPlrU2BOeH0k=;
        b=GbAWeXK2BFzG5H/j9RrUKJtAtqWEPBS8c/qZAC0uK5GBOp5rxuNdGXswnt3N8rjwDVL/Wj
        WxOQcPONjU2fEXp5Hjv9zY4bDMXCAUNUKQD3cfZ9CXAxVz5YnD97e4sWS7BP8D2CFN73Xf
        bzbwVG5SvbppkXwsX444gFG4jacoJ8Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-6u-G4vuAN5-fBNtazPGKJQ-1; Thu, 06 Apr 2023 19:39:58 -0400
X-MC-Unique: 6u-G4vuAN5-fBNtazPGKJQ-1
Received: by mail-qv1-f70.google.com with SMTP id w2-20020a0cc242000000b00583d8e55181so18646391qvh.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680824397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyyxmsR12PIJKtju28/DIjkSeXN5QuTWPlrU2BOeH0k=;
        b=eSp5m6KSGcnwGJMpuTpFFTHg0vIYwps/UoS5FL/wyubnq+tmUm1ZjK6Mfu8pketqdX
         orEESmQEoiEeaLqWd1E+S8kuDyadJAe83Z7v5FI7I0Wz5QUcku0ZFFKjUt2CSasdpJ92
         /YoX9D3sELAQB9RT4zVnM25GBIOJA4IbVeNAFSbmpKLJuGz9qrM0CMnzUl2+CCPVXKGq
         D88VaHoMIkitbnhOy2Uch9XltA3pSYdmv8LTSy6yi8h3hqpUvySee/gs1L3QAaJ4oZUP
         dZudFTqvssbnIbH6S90ndoQlNXY1XgkGKY6lc9fR2mIFFACilxd8VZ/Lr/WXYdvp6uH6
         afyg==
X-Gm-Message-State: AAQBX9e/uJGPWTz/fj15hWhUdiZBAY3gM1XN7FI8NApKqixdSm4x1Kv4
        QMgMnQwR/eyYSGtMNTQLeAFX3+hJpRVw3zz9esZ7DjW6GJtxmhlBYTHz8/XqEs/WHAY+vO7d19/
        uwUS7Mj41p+ho3JwSv9UzvMc/GIsqiuenB4BTMpL33np+9XPyCChlecceaPi81m3OjoTWkiV+Wr
        0F/npV+CI=
X-Received: by 2002:a05:6214:c63:b0:56f:8ef:693 with SMTP id t3-20020a0562140c6300b0056f08ef0693mr1240393qvj.0.1680824397642;
        Thu, 06 Apr 2023 16:39:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350YPYHCW537G/8xb3AdG7CIgSTiR+bz0OfW7EXjmNk068VXWNrsvEu5F6SBBnFsLqDfB0TOJUQ==
X-Received: by 2002:a05:6214:c63:b0:56f:8ef:693 with SMTP id t3-20020a0562140c6300b0056f08ef0693mr1240372qvj.0.1680824397298;
        Thu, 06 Apr 2023 16:39:57 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id mk21-20020a056214581500b005dd8b9345f0sm865599qvb.136.2023.04.06.16.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 16:39:56 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] arch_topology: Pre-allocate cacheinfo from primary CPU
Date:   Thu,  6 Apr 2023 19:39:24 -0400
Message-Id: <20230406233926.1670094-1-rrendec@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
tries to build the cacheinfo from the primary CPU prior to secondary
CPUs boot, if the DT/ACPI description contains cache information.
However, if such information is not present, it still reverts to the old
behavior, which allocates the cacheinfo memory on each secondary CPU. On
RT kernels, this triggers a "BUG: sleeping function called from invalid
context" because the allocation is done before preemption is first
enabled on the secondary CPU.

The solution is to add cache information to DT/ACPI, but at least on
arm64 systems this can be avoided by leveraging automatic detection
(through the CLIDR_EL1 register), which is already implemented but
currently doesn't work on RT kernels for the reason described above.

This patch series attempts to enable automatic detection for RT kernels
when no DT/ACPI cache information is available, by pre-allocating
cacheinfo memory on the primary CPU.

The first patch adds an architecture independent infrastructure that
allows architecture specific code to take an early guess at the number
of cache leaves of the secodary CPUs, while it runs in preemptible
context on the primary CPU. At the same time, it gives architecture
specific code the opportunity to go back later, while it runs on the
secondary CPU, and reallocate the cacheinfo memory if the initial guess
proves to be wrong.

The second patch leverages the infrastructure implemented in the first
patch and enables early cache depth detection for arm64.

The patch series is based on an RFC patch that was posted to the
linux-arm-kernel mailing list and discussed with a smaller audience:
https://lore.kernel.org/all/20230323224242.31142-1-rrendec@redhat.com/

Changes to v2:
* Address minor coding style issue (unbalanced braces).
* Move cacheinfo reallocation logic from detect_cache_attributes() to a
  new function to improve code readability.
* Minor fix to cacheinfo reallocation logic to avoid a new detection of
  the cache level if/when detect_cache_attributes() is called again.

Radu Rendec (2):
  cacheinfo: Add arch specific early level initializer
  cacheinfo: Add arm64 early level initializer implementation

 arch/arm64/kernel/cacheinfo.c | 32 +++++++++++----
 drivers/base/cacheinfo.c      | 75 +++++++++++++++++++++++++----------
 include/linux/cacheinfo.h     |  2 +
 3 files changed, 79 insertions(+), 30 deletions(-)

-- 
2.39.2

