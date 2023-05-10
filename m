Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B815E6FDA24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbjEJI4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbjEJI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:56:04 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27A9BE45;
        Wed, 10 May 2023 01:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=5fgX4Fhl0a
        Sp9FXpCFf3QP/h9Q7cD/Xeogk7PFQTbxg=; b=YOYEJbkx3Q7PrqHtYF/iMqaE6I
        nBpO1/Vlr1JQA3ZxAOsPmiY6ekTTBJpPkhIMeuDCyc/Bdep4JpBSnZPepdASfwmV
        sJ9drPAkkk+QZQYyrEkOk0cxbZO6OHC32wmVK5S6jLBbyYSy70V0RUlL52ui0cSk
        pEMKBV+HjoXkx+cgQ=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBnb2cIXFtkW9d5Ag--.63159S2;
        Wed, 10 May 2023 16:55:39 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-mm@kvack.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH 0/4] Fix type confusion in page_table_check
Date:   Wed, 10 May 2023 16:55:23 +0800
Message-Id: <20230510085527.57953-1-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBnb2cIXFtkW9d5Ag--.63159S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1fJw4ktrW7Jw4ftrWDJwb_yoW8XrW8p3
        WUCr1YqF4rG3s3Jw1SkanYk34ruF4rG3y7CryIk3yY93s5Jr1IkFn3Wr13Za4kAryUGr15
        KF4agry7Kr18Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
        vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        WkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEEBVPy770DbwAVsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Ruihan Li (4):
  usb: usbfs: Enforce page requirements for mmap
  usb: usbfs: Use consistent mmap functions
  mm: page_table_check: Make it dependent on !DEVMEM
  mm: page_table_check: Ensure user pages are not slab pages

 Documentation/mm/page_table_check.rst | 18 ++++++++++++
 drivers/usb/core/buffer.c             | 41 +++++++++++++++++++++++++++
 drivers/usb/core/devio.c              | 15 +++++++---
 include/linux/page-flags.h            |  6 ++++
 include/linux/usb/hcd.h               |  5 ++++
 mm/Kconfig.debug                      |  2 +-
 mm/page_table_check.c                 |  6 ++++
 7 files changed, 88 insertions(+), 5 deletions(-)

-- 
2.40.1

