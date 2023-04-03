Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD686D5525
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjDCXSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjDCXSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5960E1BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680563889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mKQAlhdwEv2W0Wg0Ync8Qe+weqVP4a18Rc/3M7do/+k=;
        b=SN6I9+LudE5eQihk5D93/byvLW+eYctktIAoBjG4koQcaib/xY/gPpr7ULFoLo0CzEIGhY
        mvrBDS2NQeqfV9fbwHt4i+AJiDOw0SuA9IWI0ICFRzUuG1kypp9io+wUrdDdoP0tqLSvFX
        /fTHOKxvxtg8/DzFRA6Enyy6eo39iqs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-OJdYkzPFM_-d5yAO2cz7UA-1; Mon, 03 Apr 2023 19:18:08 -0400
X-MC-Unique: OJdYkzPFM_-d5yAO2cz7UA-1
Received: by mail-qk1-f198.google.com with SMTP id 195-20020a3705cc000000b00746a3ab9426so13861487qkf.20
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 16:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680563887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKQAlhdwEv2W0Wg0Ync8Qe+weqVP4a18Rc/3M7do/+k=;
        b=RnUv4UrCal75Brk1xo/ZOAPKXSjdAWDX+tkfIS6i4ZMhaTO1MaP7/KjhlC29hLcRbo
         j/kqZ05H3OuTJ44tmu8nDtZzZFdPKZt1GlAgCYPK0VOZqGp1O+63Of1+LbFo4k6eO4ob
         YIozmJTAOR7sZRb4auvF3rfTe6KF4t3056F4bgOivXLHms8MW+lIpWhiHWqD8QTDa8Yd
         /sMEzWkViULjoJNdee6YTE3F7XJV0e2d8nDGaN/XQ7wg5gmcYbLLRHStBjA4hjAQJQoR
         MT0yqMQLfsQrNE33wEGI21khHxvQ8OXj0DxDnuOVRHl/Vpw51RGM+sspARut7O3Zq5SH
         kk+g==
X-Gm-Message-State: AAQBX9dLH2uIQRgK0a/YadfNCJEGyzrmU85N39GMiDfGrwDlXwGitTXR
        P1uBRpJix31NAZXHztgBBtLgiv42W2cqFKf7CZW90/bjGxrpfaKNe0YE639hE1NNvKd4ggbLnZD
        AEpK0DN3cRNBp/GS/U2cmRiGd2YMqhxtMv5+8TLk27NKrfA8aRJysxQxCru5VNrczp8WU11bf+/
        wHMqa0OqIe3g==
X-Received: by 2002:a05:6214:20c7:b0:5bd:74a7:e6f0 with SMTP id 7-20020a05621420c700b005bd74a7e6f0mr888128qve.20.1680563887228;
        Mon, 03 Apr 2023 16:18:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bqxjqhUc1/YgEorGYeLXst+f0hju0GvBMFx6hlrmR9Luls83e6h0eRMOfaFzBbtfvnjlckNQ==
X-Received: by 2002:a05:6214:20c7:b0:5bd:74a7:e6f0 with SMTP id 7-20020a05621420c700b005bd74a7e6f0mr888095qve.20.1680563886918;
        Mon, 03 Apr 2023 16:18:06 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id v6-20020ad45346000000b005e231177992sm2670207qvs.74.2023.04.03.16.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 16:18:06 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] arch_topology: Pre-allocate cacheinfo from primary CPU
Date:   Mon,  3 Apr 2023 19:15:49 -0400
Message-Id: <20230403231551.1090704-1-rrendec@redhat.com>
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

Radu Rendec (2):
  cacheinfo: Add arch specific early level initializer
  cacheinfo: Add arm64 early level initializer implementation

 arch/arm64/kernel/cacheinfo.c | 32 +++++++++++++++-----
 drivers/base/cacheinfo.c      | 57 +++++++++++++++++++++++------------
 include/linux/cacheinfo.h     |  2 ++
 3 files changed, 64 insertions(+), 27 deletions(-)

-- 
2.39.2

