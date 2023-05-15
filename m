Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6D702DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbjEONLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242058AbjEONKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:10:54 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20BD32128;
        Mon, 15 May 2023 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=LvhrVb0s14CrLTcM4FhMNI+cmHRMtswfGA
        OaVnNkRyo=; b=jAzgEqi2kWQSxQpp8Ssp9pYqTir9nWSu8mUrzeiAHy3qJ0NGNz
        ugsLO1+8bowctxCvSOa04NUk7ICcyEJUc+wFiVcCV7lGnvBj40GlkhheYW1K5INa
        GoqAUZGkQUN5WgfEWqu3cHvlG468Aw+KHLEwpKRhpG5g6v7K3t7J884QA=
Received: from localhost.localdomain (unknown [10.7.98.243])
        by front02 (Coremail) with SMTP id 54FpogAnLDgqL2JkVboyFA--.10053S5;
        Mon, 15 May 2023 21:10:08 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-mm@kvack.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruihan Li <lrh2000@pku.edu.cn>, stable@vger.kernel.org
Subject: [PATCH v2 3/4] mm: page_table_check: Make it dependent on EXCLUSIVE_SYSTEM_RAM
Date:   Mon, 15 May 2023 21:09:57 +0800
Message-Id: <20230515130958.32471-4-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515130958.32471-1-lrh2000@pku.edu.cn>
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogAnLDgqL2JkVboyFA--.10053S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy3tF4xZF4xGw4xZrW5ZFb_yoW5Ww17pa
        4kt3yS9rs8Ga4fur4xZwn29r1fKrn3AFW3GrnakF1DZa4DCr9avr13KFyjv3W8C3ykAasx
        XF4Ygr1UJw4UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
        x26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEMBVPy7743xAACsL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without EXCLUSIVE_SYSTEM_RAM, users are allowed to map arbitrary
physical memory regions into the userspace via /dev/mem. At the same
time, pages may change their properties (e.g., from anonymous pages to
named pages) while they are still being mapped in the userspace, leading
to "corruption" detected by the page table check.

To avoid these false positives, this patch makes PAGE_TABLE_CHECK
depends on EXCLUSIVE_SYSTEM_RAM. This dependency is understandable
because PAGE_TABLE_CHECK is a hardening technique but /dev/mem without
STRICT_DEVMEM (i.e., !EXCLUSIVE_SYSTEM_RAM) is itself a security
problem.

Even with EXCLUSIVE_SYSTEM_RAM, I/O pages may be still allowed to be
mapped via /dev/mem. However, these pages are always considered as named
pages, so they won't break the logic used in the page table check.

Cc: <stable@vger.kernel.org> # 5.17
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 Documentation/mm/page_table_check.rst | 19 +++++++++++++++++++
 mm/Kconfig.debug                      |  1 +
 2 files changed, 20 insertions(+)

diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
index cfd8f4117..c12838ce6 100644
--- a/Documentation/mm/page_table_check.rst
+++ b/Documentation/mm/page_table_check.rst
@@ -52,3 +52,22 @@ Build kernel with:
 
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
+PAGE_TABLE_CHECK depends on EXCLUSIVE_SYSTEM_RAM. The reason is that without
+EXCLUSIVE_SYSTEM_RAM, users are allowed to map arbitrary physical memory
+regions into the userspace via /dev/mem. At the same time, pages may change
+their properties (e.g., from anonymous pages to named pages) while they are
+still being mapped in the userspace, leading to "corruption" detected by the
+page table check.
+
+Even with EXCLUSIVE_SYSTEM_RAM, I/O pages may be still allowed to be mapped via
+/dev/mem. However, these pages are always considered as named pages, so they
+won't break the logic used in the page table check.
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index a925415b4..018a5bd2f 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -98,6 +98,7 @@ config PAGE_OWNER
 config PAGE_TABLE_CHECK
 	bool "Check for invalid mappings in user page tables"
 	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	depends on EXCLUSIVE_SYSTEM_RAM
 	select PAGE_EXTENSION
 	help
 	  Check that anonymous page is not being mapped twice with read write
-- 
2.40.1

