Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207E467E3A5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjA0Lky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjA0Lki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:40:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80CC710F4;
        Fri, 27 Jan 2023 03:40:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68AA515DB;
        Fri, 27 Jan 2023 03:40:39 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6A303F64C;
        Fri, 27 Jan 2023 03:39:54 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc:     suzuki.poulose@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joey Gouly <Joey.Gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-coco@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC kvmtool 03/31] hw: cfi flash: Handle errors in memory transitions
Date:   Fri, 27 Jan 2023 11:39:04 +0000
Message-Id: <20230127113932.166089-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127113932.166089-1-suzuki.poulose@arm.com>
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127113932.166089-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle failures in creating the memory maps and back in
transitioning the CFI flash. e.g., with MTE enabled, CFI
flash emulation breaks with the map operation, silently.
And we later hit unhandled aborts in the guest.

To avoid such issues, let us make sure we catch the error
and handle it right at source.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 hw/cfi_flash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/cfi_flash.c b/hw/cfi_flash.c
index 7faecdfb..bce546bc 100644
--- a/hw/cfi_flash.c
+++ b/hw/cfi_flash.c
@@ -455,6 +455,8 @@ static int map_flash_memory(struct kvm *kvm, struct cfi_flash_device *sfdev)
 				KVM_MEM_TYPE_RAM | KVM_MEM_TYPE_READONLY);
 	if (!ret)
 		sfdev->is_mapped = true;
+	else
+		die("CFI Flash: ERROR: Unable to map memory: %d\n", ret);
 
 	return ret;
 }
@@ -472,6 +474,8 @@ static int unmap_flash_memory(struct kvm *kvm, struct cfi_flash_device *sfdev)
 
 	if (!ret)
 		sfdev->is_mapped = false;
+	else
+		die("CFI Flash: Failed to unmap Flash %d", ret);
 
 	return ret;
 }
-- 
2.34.1

