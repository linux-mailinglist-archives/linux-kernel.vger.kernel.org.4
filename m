Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D76E4E09
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjDQQJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjDQQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC6646AB;
        Mon, 17 Apr 2023 09:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8491D61E78;
        Mon, 17 Apr 2023 16:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40618C4339B;
        Mon, 17 Apr 2023 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681747764;
        bh=SgZElnsulqzJEQ+SjN/G4C6kbP5ZJN5SDWFrxmvGZf4=;
        h=From:To:Cc:Subject:Date:From;
        b=g+KDJTbASg5nOX3QqZM1MxqWu8Ruj4/4RPEvRuq3bb9xCTM+Vknngja+OLEx4A8th
         two0N4gvjeJd8FIPnQr84I+pbEhxEGq1RniD6rHq4DgPuiWqWbmDxORm3xCCB4Ufr/
         Pn0yC4h5sc8pBXGXYtwoL55beIBbcVY3weuUZ9rYrQdXcHiPfWmck2u7U28A2s64Hg
         gbM8QaK4tJBnNZMIe5cCh+1PiakAiRygaG1DVtKxuf1wvSkW4geDp6zqHeIguiSsxO
         GXmXqbni2IMEubYuqCtvIAS4qyGeczp9axtzQpT3EFKYGR8UKsQPrBo1F0+vvLwtcn
         jq8KyZ3mntA9Q==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the driver-core tree with the iommu tree
Date:   Mon, 17 Apr 2023 17:09:20 +0100
Message-Id: <20230417160920.3387706-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  include/linux/iommu.h

between commit:

  f7f9c054a227a ("iommu: Remove iommu_group_get_by_id()")

from the iommu tree and commit:

  b18d0a0f92a8f ("iommu: make the pointer to struct bus_type constant")

from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/linux/iommu.h
index ad238d6e4677b,0fd4e6734d5b2..0000000000000
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@@ -455,11 -455,12 +455,11 @@@ static inline const struct iommu_ops *d
  	return dev->iommu->iommu_dev->ops;
  }
  
- extern int bus_iommu_probe(struct bus_type *bus);
- extern bool iommu_present(struct bus_type *bus);
+ extern int bus_iommu_probe(const struct bus_type *bus);
+ extern bool iommu_present(const struct bus_type *bus);
  extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
  extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
- extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
+ extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
 -extern struct iommu_group *iommu_group_get_by_id(int id);
  extern void iommu_domain_free(struct iommu_domain *domain);
  extern int iommu_attach_device(struct iommu_domain *domain,
  			       struct device *dev);
