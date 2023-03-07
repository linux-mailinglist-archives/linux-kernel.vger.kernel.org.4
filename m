Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C96AD3C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCGBUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCGBUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:20:32 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879A2ED7A;
        Mon,  6 Mar 2023 17:20:23 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C12FDC0000EA;
        Mon,  6 Mar 2023 17:20:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C12FDC0000EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1678152022;
        bh=0d1f6kwQz4ouYMBgT7ij+utdVrqCzXLV7v6Nz90LLUM=;
        h=From:To:Cc:Subject:Date:From;
        b=vU0r0m+tgr/rrasOPhmb906Er8Plv2muT9DzxawnpLZXeN91PpYWo1rJFRKBy8/FM
         abDmRXKyFUaeUY6D9W4wkC86eHuRFFTEkvCn1ttxEd49ZnmiyxmA+L6e3t29+wEZwQ
         46iMZf5T5AspnAiiuBhdtwRC7fWZGzidVvaEDuIY=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id B399118041CAC6;
        Mon,  6 Mar 2023 17:20:22 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 9A162101C1F; Mon,  6 Mar 2023 17:20:22 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     joel.peshkin@broadcom.com, dregan@mail.com, jonas.gorski@gmail.com,
        dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, kursad.oney@broadcom.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Fix cocci warnings
Date:   Mon,  6 Mar 2023 17:20:04 -0800
Message-Id: <20230307012004.414502-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cocci reported warning: !A || A && B is equivalent to !A || B. This fix
simplified the condition check to !A || B.

Fixes: 76a85704cb91 ("spi: spi-mem: Allow controller supporting mem_ops without exec_op")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303010051.HrHWSr9y-lkp@intel.com/

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 798030c0c5ce..503eb04826e7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3076,7 +3076,7 @@ static int spi_controller_check_ops(struct spi_controller *ctlr)
 	 * If ->mem_ops or ->mem_ops->exec_op is NULL, we request that at least
 	 * one of the ->transfer_xxx() method be implemented.
 	 */
-	if (!ctlr->mem_ops || (ctlr->mem_ops && !ctlr->mem_ops->exec_op)) {
+	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
 		if (!ctlr->transfer && !ctlr->transfer_one &&
 		   !ctlr->transfer_one_message) {
 			return -EINVAL;
-- 
2.37.3

