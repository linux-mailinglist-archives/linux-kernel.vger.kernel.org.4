Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1156CD3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjC2IAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC2IAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:00:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A95210D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E37EDB820F8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07077C433EF;
        Wed, 29 Mar 2023 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680076801;
        bh=cb8TYrkiBBY882Dfq3SS1IYxneIycjw3TPPS0/qy3XA=;
        h=From:To:Cc:Subject:Date:From;
        b=DleDmRxbClOx+h3mHP5GODFSfuEli5fv5t8Q2vcbMKoQI9MjTJ9fzIp5BgNp/HJTZ
         exDZo4GspE2+Y6SJiG0ZPBH6uc5mSIbj2lOnjCervq7VCmvtOCOE/iqiwk5hvPfL47
         J0r/cfCz7uGkjRPD76MNB80P9EEn5XHgIcgExQvInorUlti6dc0MNlRqwHaCGJ7Rcd
         eFKrOSkAJuopD4reuWwlv3r18nHVqdAbOOW84BzNrDwHmiNrjisimkxwRLMTzjIWtM
         w4hub84S3uHD5oiq2G/3jhTpUELNq2w9rAZodiKIZBSVDCHDf5MHD+6MCICmDroZKp
         sZvaY7Srv89JA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Desnes Nunes <desnesn@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-debug: use %pap format string for phys_addr_t
Date:   Wed, 29 Mar 2023 09:59:45 +0200
Message-Id: <20230329075956.2376819-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit architectures with 64-bit physical addresses, the
debug print is broken:

kernel/dma/debug.c: In function 'dump_show':
kernel/dma/debug.c:568:87: error: format '%llx' expects argument of type 'long long unsigned int', but argument 11 has type 'phys_addr_t' {aka 'unsigned int'} [-Werror=format=]
  568 |                                    "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
      |                                                                                    ~~~^
      |                                                                                       |
      |                                                                                       long long unsigned int
      |                                                                                    %x
......
  574 |                                    cln, dir2name[entry->direction],
      |                                    ~~~
      |                                    |
      |                                    phys_addr_t {aka unsigned int}

Use the special %pap format modifier for printing physical addresses.

Fixes: bd89d69a529f ("dma-debug: add cacheline to user/kernel space dump messages")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/dma/debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 676142072d99..d8b233683a8c 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -534,11 +534,11 @@ void debug_dma_dump_mappings(struct device *dev)
 			if (!dev || dev == entry->dev) {
 				cln = to_cacheline_number(entry);
 				dev_info(entry->dev,
-					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
+					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pap %s %s\n",
 					 type2name[entry->type], idx,
 					 phys_addr(entry), entry->pfn,
 					 entry->dev_addr, entry->size,
-					 cln, dir2name[entry->direction],
+					 &cln, dir2name[entry->direction],
 					 maperr2str[entry->map_err_type]);
 			}
 		}
@@ -565,13 +565,13 @@ static int dump_show(struct seq_file *seq, void *v)
 		list_for_each_entry(entry, &bucket->list, list) {
 			cln = to_cacheline_number(entry);
 			seq_printf(seq,
-				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
+				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pap %s %s\n",
 				   dev_driver_string(entry->dev),
 				   dev_name(entry->dev),
 				   type2name[entry->type], idx,
 				   phys_addr(entry), entry->pfn,
 				   entry->dev_addr, entry->size,
-				   cln, dir2name[entry->direction],
+				   &cln, dir2name[entry->direction],
 				   maperr2str[entry->map_err_type]);
 		}
 		spin_unlock_irqrestore(&bucket->lock, flags);
-- 
2.39.2

