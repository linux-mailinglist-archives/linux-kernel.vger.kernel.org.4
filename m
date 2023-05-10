Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB36FDA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbjEJJEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbjEJJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:04:12 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79EAE2D77;
        Wed, 10 May 2023 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=RB+r4iZrVOmwsYSQRyyhbeOKjs7TDEZNd2
        ZsWb5cZtk=; b=L0PRStVHlRMssHOkLlj1FvPWWrdexyLACLIumO/xDcAacGWE/+
        X1g6e1sA59PGoi59w9njDcCDKlSPAqDawPJKH26Lv7OGrs1CuTx3NjjL9Y4xKq0L
        Z2HeVgZmkWKCKy+IAJbU2f6jW6QWMJswqW1u0ytOkPN6uwKg0z8tYYat0=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBnb2cIXFtkW9d5Ag--.63159S5;
        Wed, 10 May 2023 16:55:43 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-mm@kvack.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruihan Li <lrh2000@pku.edu.cn>, stable@vger.kernel.org
Subject: [PATCH 3/4] mm: page_table_check: Make it dependent on !DEVMEM
Date:   Wed, 10 May 2023 16:55:26 +0800
Message-Id: <20230510085527.57953-4-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510085527.57953-1-lrh2000@pku.edu.cn>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBnb2cIXFtkW9d5Ag--.63159S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4fZF4xKw4DAF17WF4kZwb_yoW5WrWkpa
        s2qayS9rW5G34fur1fZws29r1rCrs3GFW3ZrySkF15u3s8CFyvvr4agFy3Z3WUC395Aasx
        XFWYgryYka18AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
        vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        WkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEHBVPy77151QAAse
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The special device /dev/mem enables users to map arbitrary physical
memory regions into the user space, which can conflict with the double
mapping detection logic used by the page table check. For instance,
pages may change their properties (e.g., from anonymous pages to named
pages) while they are still being mapped in the user space via /dev/mem,
leading to "corruption" detected by the page table check.

To address this issue, the PAGE_TABLE_CHECK config option is now
dependent on !DEVMM. This ensures that the page table check cannot be
enabled when /dev/mem is used. It should be noted that /dev/mem itself
is a significant security issue, and its conflict with a hardening
technique is understandable.

Cc: <stable@vger.kernel.org> # 5.17
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 Documentation/mm/page_table_check.rst | 18 ++++++++++++++++++
 mm/Kconfig.debug                      |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
index cfd8f4117..b04f29230 100644
--- a/Documentation/mm/page_table_check.rst
+++ b/Documentation/mm/page_table_check.rst
@@ -52,3 +52,21 @@ Build kernel with:
 
 Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
 table support without extra kernel parameter.
+
+Implementation notes
+====================
+
+We specifically decided not to use VMA information in order to avoid relying on
+MM states (except for limited "struct page" info). The page table check is a
+separate from Linux-MM state machine that verifies that the user accessible
+pages are not falsely shared.
+
+As a result, special devices that violate the model cannot live with
+PAGE_TABLE_CHECK. Currently, /dev/mem is the only known example. Given it
+allows users to map arbitrary physical memory regions into the userspace, any
+pages may change their properties (e.g., from anonymous pages to named pages)
+while they are still being mapped in the userspace via /dev/mem, leading to
+"corruption" detected by the page table check. Therefore, the PAGE_TABLE_CHECK
+config option is now dependent on !DEVMEM. It's worth noting that /dev/mem
+itself is a significant security issue, and its conflict with a hardening
+technique is understandable.
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index a925415b4..37f3d5b20 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -97,7 +97,7 @@ config PAGE_OWNER
 
 config PAGE_TABLE_CHECK
 	bool "Check for invalid mappings in user page tables"
-	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK && !DEVMEM
 	select PAGE_EXTENSION
 	help
 	  Check that anonymous page is not being mapped twice with read write
-- 
2.40.1

