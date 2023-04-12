Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B86DFE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDLTAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjDLTAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B18FB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681325935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qwMo+EqT8g2dvdoPVGiHJ1L+SUDIHOHBg4VPzZsqxmQ=;
        b=P9XB+ezs8n8jfK11TWzO91IUTNDqSOHBm8xFiMnahq8akFrDyCSjdxi9O1JMk0HLEwTupq
        9Fr1l9t66Awte3j8G7iTuq/uUOfFQUhZcfNji2Mc62muFpRBpO4JfidY26WTu+rpa0r9mx
        BXztVSwloAoKHQPNsP93BM+wZ6UcnE8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-53kTysORMdKF_om5zaouYQ-1; Wed, 12 Apr 2023 14:58:53 -0400
X-MC-Unique: 53kTysORMdKF_om5zaouYQ-1
Received: by mail-qv1-f70.google.com with SMTP id n12-20020a0cbe8c000000b005e79f8d1417so8273673qvi.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325932; x=1683917932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwMo+EqT8g2dvdoPVGiHJ1L+SUDIHOHBg4VPzZsqxmQ=;
        b=h/zfkLiYJhxBArs5U8bSi2ynTK/9JxJBoMbEOMy+9fXjN1mLHQzUjhBtihdWfyCg8G
         myGP/YjXFWQTCPad8Y2A4PWmuhnPTnqLnPOWuDXq/b+GIJ5+Cw44NKXabsaXBnt29Rt7
         aqT4yQGhzy5FfgvPsvQeJGIp/lXct0/NepY12XYRSX0KOF43opEE7DWqlVcpAB/5r9na
         A4lmCiz+sfD9JmcJvLcIq+as8IGog8c0Xk/nnjyzHJvByI072lZ9c8FeiTxI8r12ubC0
         WmSSqG76oWOCDCUZIyBmb59G/BhAinojjP1jccnhT5BmdkU9urnUTGXfgkPQgikGLyEW
         aeLw==
X-Gm-Message-State: AAQBX9fhHAsplwaLkowZNGPCHuc6eRpCiCe7Jx/0mc18iBe7+lEy5+yl
        RV4uPLHcsTxz+UjQeBCVlZrN9APDoIkFSFjqyEmkJlS2rHM+/rmtIU/5zuTyWVh1nxaxLhqGx1W
        k7XRLykC2s5Q3JHuZCPPFF0ZG3vC3O78YwSqtdZy3vxSM0SPFZlnbGRAfAzWwirnLSuNLA/aCpM
        aEMpRjq3U=
X-Received: by 2002:a05:622a:1b8a:b0:3e6:71d6:5d5d with SMTP id bp10-20020a05622a1b8a00b003e671d65d5dmr3896740qtb.1.1681325932195;
        Wed, 12 Apr 2023 11:58:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z3cv2wOUfSZ1yI11PC5cSu4o0dzjNOu9d3CB64tN0AWQDQpLV+D6zaZ5oJqshR1h2l3M45cw==
X-Received: by 2002:a05:622a:1b8a:b0:3e6:71d6:5d5d with SMTP id bp10-20020a05622a1b8a00b003e671d65d5dmr3896719qtb.1.1681325931749;
        Wed, 12 Apr 2023 11:58:51 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id k21-20020ac86055000000b003d3a34d2eb2sm4417558qtm.41.2023.04.12.11.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:58:51 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/3] arch_topology: Pre-allocate cacheinfo from primary CPU
Date:   Wed, 12 Apr 2023 14:57:56 -0400
Message-Id: <20230412185759.755408-1-rrendec@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

The third patch addresses a specific issue on ACPI systems with no PPTT.
This issue came up during review/testing of v3.

The patch series is based on an RFC patch that was posted to the
linux-arm-kernel mailing list and discussed with a smaller audience:
https://lore.kernel.org/all/20230323224242.31142-1-rrendec@redhat.com/

Changes to v3:
* Rebase on top of v6.3-rc6 to avoid a (trivial) merge conflict.
* Add patch #3 (brief description included above).
* Add "Reviewed-by: Pierre Gondois" tag to all patches.
* Rename the new field that is added to struct cpu_cacheinfo from
  early_arch_info to early_ci_levels to better reflect what it does.
* Use local variables in the new detect_cache_level() function. That way
  the code is easier to read and the original level/leaves algorithm is
  unchanged, which also makes the patch clearer.

Changes to v2:
* Address minor coding style issue (unbalanced braces).
* Move cacheinfo reallocation logic from detect_cache_attributes() to a
  new function to improve code readability.
* Minor fix to cacheinfo reallocation logic to avoid a new detection of
  the cache level if/when detect_cache_attributes() is called again.

Radu Rendec (3):
  cacheinfo: Add arch specific early level initializer
  cacheinfo: Add arm64 early level initializer implementation
  cacheinfo: Allow early level detection when DT/ACPI info is
    missing/broken

 arch/arm64/kernel/cacheinfo.c | 25 ++++++++++--
 drivers/base/arch_topology.c  |  4 +-
 drivers/base/cacheinfo.c      | 75 +++++++++++++++++++++++++----------
 include/linux/cacheinfo.h     |  2 +
 4 files changed, 79 insertions(+), 27 deletions(-)

-- 
2.39.2

