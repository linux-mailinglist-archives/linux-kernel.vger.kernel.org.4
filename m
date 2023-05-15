Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4E702DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbjEONL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241718AbjEONKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:10:52 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF6972130;
        Mon, 15 May 2023 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=7xP0On4kxe
        WWPTALWosP9FmQHvyKTJsqUxCPEueBxBA=; b=PyktA73T0EpdMP25nHKIC6+pYR
        ePo7FQpi3nT0OD4EhVD1vH7lAqqcsJZJJG36MSe5JAI4UTP3RibTfOsqkyq0qL8/
        oVF2di/eCNH2HkQEp6dFXTODuHprDjFmg1ORnZOFjZyIVU83XwO3CkK8Qn40BW9d
        2W2oY56GUXWSmWzIw=
Received: from localhost.localdomain (unknown [10.7.98.243])
        by front02 (Coremail) with SMTP id 54FpogAnLDgqL2JkVboyFA--.10053S2;
        Mon, 15 May 2023 21:10:06 +0800 (CST)
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
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH v2 0/4] Fix type confusion in page_table_check 
Date:   Mon, 15 May 2023 21:09:54 +0800
Message-Id: <20230515130958.32471-1-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogAnLDgqL2JkVboyFA--.10053S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1fJw4ktrW7Jw4ftry5urg_yoW8Cw43pF
        1UCw13XFs5G3s3Jw1SkanY9a4ruF4rGay7A34xK345u3s5A34xCFn3Wr13Za4kArWUG34Y
        qF42gryUKw18J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEMBVPy7743xAABsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, syzbot reported [1] ("kernel BUG in page_table_check_clear").
The root cause is that usbdev_mmap calls remap_pfn_range on kmalloc'ed
memory, which leads to type confusion between struct page and slab in
page_table_check. This series of patches fixes the usb side by avoiding
mapping slab pages into userspace, and fixes the mm side by enforcing
that all user-accessible pages are not slab pages. A more detailed
analysis and some discussion of how to fix the problem can also be found
in [1].

 [1] https://lore.kernel.org/lkml/20230507135844.1231056-1-lrh2000@pku.edu.cn/T/

Changes since v1:
  * Fix inconsistent coding styles. (Alan Stern)
  * Relax !DEVMEM requirements to EXCLUSIVE_SYSTEM_RAM, which is
    equivalent to !DEVMEM || STRICT_DEVMEM. (David Hildenbrand)
  * A few random tweaks in commit messages and code comments, none of
    them major.
Link to v1:
  https://lore.kernel.org/lkml/20230510085527.57953-1-lrh2000@pku.edu.cn/T/

Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Ruihan Li (4):
  usb: usbfs: Enforce page requirements for mmap
  usb: usbfs: Use consistent mmap functions
  mm: page_table_check: Make it dependent on EXCLUSIVE_SYSTEM_RAM
  mm: page_table_check: Ensure user pages are not slab pages

 Documentation/mm/page_table_check.rst | 18 ++++++++++++
 drivers/usb/core/buffer.c             | 41 +++++++++++++++++++++++++++
 drivers/usb/core/devio.c              | 20 +++++++++----
 include/linux/page-flags.h            |  6 ++++
 include/linux/usb/hcd.h               |  5 ++++
 mm/Kconfig.debug                      |  2 +-
 mm/page_table_check.c                 |  6 ++++
 7 files changed, 91 insertions(+), 7 deletions(-)

-- 
2.40.1

