Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6992D5EF59D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiI2Mkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiI2MkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3310D72873;
        Thu, 29 Sep 2022 05:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91DA9B82472;
        Thu, 29 Sep 2022 12:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A768C433D6;
        Thu, 29 Sep 2022 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664455211;
        bh=opJy4WGCjfCkazyMTKLVNlei3tkEp4TQKxWcany/vMU=;
        h=From:To:Cc:Subject:Date:From;
        b=s/3dWTa78Ao0dVG7TQeevFQztcsyLNAqvkq3t1UX+Fc5VhkmEWrlE8EMx3mbw8lVK
         d22VyOeQ+o9B6UxoffG73OpKrDuR9Vvu9Z0lYxAyeX0CYaH0N7hKhZA97R7xvGx0hM
         /gPqjkTgSXl+xkTrgs+hgMcQiJCh81DEm85zBNtNooJMuWBF+IopSl2b9D/ljA4gCy
         KkAgXYrSHI0we/QEtaD1c/rAWJh+yBBkRvyUjIM54MV1iOmIB59BXCUTtpaH5v3O88
         0jiSkIyyJdVc7jwoibfekjZ9kE09Lxq+CN03SO+ov3AmrtZ84EABGCTj+jMVL3Kxwn
         C4zkpHCQ/7Tsw==
From:   broonie@kernel.org
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Haoyue Xu <xuhaoyue1@hisilicon.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rdma tree with the origin tree
Date:   Thu, 29 Sep 2022 13:40:05 +0100
Message-Id: <20220929124005.105149-1-broonie@kernel.org>
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

Today's linux-next merge of the rdma tree got conflicts in:

  drivers/infiniband/hw/hns/hns_roce_hw_v2.c
  drivers/infiniband/hw/hns/hns_roce_main.c

between commit:

  45baad7dd98f4 ("RDMA/hns: Remove the num_qpc_timer variable")

from the origin tree and commits:

  29dc063596772 ("RDMA/hns: Remove redundant 'use_lowmem' argument from hns_roce_init_hem_table()")
  5436272c8cf4e ("RDMA/hns: Remove redundant 'num_mtt_segs' and 'max_extend_sg'")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c780646bd60ac,2d0192057d1af..0000000000000
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@@ -2272,7 -2270,7 +2270,6 @@@ static int hns_roce_query_pf_caps(struc
  	caps->max_sq_inline	     = le16_to_cpu(resp_a->max_sq_inline);
  	caps->max_rq_sg		     = le16_to_cpu(resp_a->max_rq_sg);
  	caps->max_rq_sg = roundup_pow_of_two(caps->max_rq_sg);
- 	caps->max_extend_sg	     = le32_to_cpu(resp_a->max_extend_sg);
 -	caps->num_qpc_timer	     = le16_to_cpu(resp_a->num_qpc_timer);
  	caps->max_srq_sges	     = le16_to_cpu(resp_a->max_srq_sges);
  	caps->max_srq_sges = roundup_pow_of_two(caps->max_srq_sges);
  	caps->num_aeq_vectors	     = resp_a->num_aeq_vectors;
diff --cc drivers/infiniband/hw/hns/hns_roce_main.c
index 4ccb217b2841d,53c53c20360d1..0000000000000
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@@ -725,10 -734,10 +734,10 @@@ static int hns_roce_init_hem(struct hns
  		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->qpc_timer_table,
  					      HEM_TYPE_QPC_TIMER,
  					      hr_dev->caps.qpc_timer_entry_sz,
- 					      hr_dev->caps.qpc_timer_bt_num, 1);
 -					      hr_dev->caps.num_qpc_timer);
++					      hr_dev->caps.qpc_timer_bt_num);
  		if (ret) {
  			dev_err(dev,
- 				"Failed to init QPC timer memory, aborting.\n");
+ 				"failed to init QPC timer memory, aborting.\n");
  			goto err_unmap_ctx;
  		}
  	}
