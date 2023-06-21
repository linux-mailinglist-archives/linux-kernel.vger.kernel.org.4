Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CCD7391B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjFUVib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjFUVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:38:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1B1988;
        Wed, 21 Jun 2023 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pkZgplOLZ8AEWdttiF8Ut3/Ee7D1W2OVcYqdc7VQf0E=; b=hahh76qvYl0Fq2GFFDkufVXBNW
        oV2SJ1FhPuHkEy8W4LoBtBWC42GP7UJZe6fuCMix3NeaJpAMLLIDUBjqVvjoIUE/i86SVeM+lcP7q
        9MPBcOg8Kn7W/8izfWD6BIgq9RTItyF4Jqke2LfeA0YFjc3LooxYwi759wIfBbiqjnPYbkIhktmeO
        +Rapg1fUGOb2nKLhosk0mXDcggxZ5z0UPa5t+Gu7XDxSjYNDuXKtge4g+Z9SpIGSY4y3inPey7A3b
        Qar56EuAacwqJ+UjC4NlgqHAcBeA6g60aEiHm5rWzAWAErbCDlZwPley9kZivrg7iSRYP/QgOtKDW
        Z/v97k4g==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC5WJ-00FnwL-1q;
        Wed, 21 Jun 2023 21:37:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable module
Date:   Wed, 21 Jun 2023 14:37:42 -0700
Message-ID: <20230621213742.8245-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Require FDDI to be built-in if it is used. LCS needs FDDI to be
built-in to build without errors.

Prevents these build errors:
s390-linux-ld: drivers/s390/net/lcs.o: in function `lcs_new_device':
drivers/s390/net/lcs.c:2150: undefined reference to `fddi_type_trans'
s390-linux-ld: drivers/s390/net/lcs.c:2151: undefined reference to `alloc_fddidev'

This FDDI requirement effectively restores the previous condition
before the blamed patch, when #ifdef CONFIG_FDDI was used, without
testing for CONFIG_FDDI_MODULE.

Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202306202129.pl0AqK8G-lkp@intel.com
Suggested-by: Simon Horman <simon.horman@corigine.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/s390/net/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -6,11 +6,13 @@ config LCS
 	def_tristate m
 	prompt "Lan Channel Station Interface"
 	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
+	depends on FDDI=y || FDDI=n
 	help
 	  Select this option if you want to use LCS networking on IBM System z.
 	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
 	  To compile as a module, choose M. The module name is lcs.
 	  If you do not know what it is, it's safe to choose Y.
+	  If FDDI is used, it must be built-in (=y).
 
 config CTCM
 	def_tristate m
