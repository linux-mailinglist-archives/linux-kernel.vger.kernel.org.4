Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC17B5ECCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiI0T1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiI0T05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:26:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB2FF684B;
        Tue, 27 Sep 2022 12:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1B3EB81D42;
        Tue, 27 Sep 2022 19:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5A4C433C1;
        Tue, 27 Sep 2022 19:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664306814;
        bh=7s6DRRKagiuwq7mXpL1jp/UeVqkk/OPpva+3hUauOfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Rht6gsc7SIHh6dlQl2y5Lj+tPqMSyFXt29XJGcUVuU2GbCFQBm9lXCNZTnnEqMJRA
         k91BGx+TWs3/Ksa9+m3mTHZ6VzA7JMZXQvi7e1ExUuaEHgtd8CmlA/o+DJ68Aws7yS
         6ny6UwLjmNGBKYT+Ze4ZnKw+D9P1nOnXHhe1UE4gRmcjvZdRtDZt4HKQsknK8eEc/A
         c+zAbrmlJKV6YIAafTxLZQgsVQo4oWX2n5X/lE1Zff+EUbfshkQLIK6jg2OxFGS+wm
         ZSeRHyjrH+yARfLDozkt8duVi3FMxyC3vqhjAxdQRlu2DOMw6L9PmJ/QLkjBEyG3gT
         GeWCRW9zuBqkA==
From:   broonie@kernel.org
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Subject: linux-next: manual merge of the mm-stable tree with the bitmap tree
Date:   Tue, 27 Sep 2022 20:26:49 +0100
Message-Id: <20220927192650.516143-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  include/linux/nodemask.h

between commit:

  97848c10f9f8a ("lib/bitmap: remove bitmap_ord_to_pos")

from the bitmap tree and commit:

  3e061d924fe9c ("lib/nodemask: optimize node_random for nodemask with single NUMA node")

from the mm-stable tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/linux/nodemask.h
index 0c45fb066caa7,e66742db741cf..0000000000000
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@@ -504,11 -505,21 +505,20 @@@ static inline int num_node_state(enum n
  static inline int node_random(const nodemask_t *maskp)
  {
  #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
- 	int w, bit = NUMA_NO_NODE;
+ 	int w, bit;
  
  	w = nodes_weight(*maskp);
- 	if (w)
+ 	switch (w) {
+ 	case 0:
+ 		bit = NUMA_NO_NODE;
+ 		break;
+ 	case 1:
+ 		bit = first_node(*maskp);
+ 		break;
+ 	default:
 -		bit = bitmap_ord_to_pos(maskp->bits,
 -					get_random_int() % w, MAX_NUMNODES);
 +		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w);
+ 		break;
+ 	}
  	return bit;
  #else
  	return 0;
