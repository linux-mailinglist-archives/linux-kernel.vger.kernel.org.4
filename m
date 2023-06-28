Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F2574178F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjF1RyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjF1RyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0F21FE8;
        Wed, 28 Jun 2023 10:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 851366141D;
        Wed, 28 Jun 2023 17:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F162C433C8;
        Wed, 28 Jun 2023 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687974844;
        bh=oSRPOgHpNDB64XuYcsnvS74umcBXdshhYlA/hMOAXX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3m7jv70ePbAmDUscA1F0AhYSYj7TOZVKgCeF01P64dnTgDXLMxvVR6PT4N6Fe5cS
         yi2yAQIJQVICsaInV50nOacomxIXbN/EA7ueM5VYALZZb/xMiOTGmOVr3qcutoFZaq
         Q4FI0gMtZo86BobjGg/qAv7HRb6PZ4MfAXFm0ceeDZE4uK2p1V4Oe1dAuJOw6N77TV
         4bw2cBT5r9AbcHMwRg2rtonUVZ6Wdt9TiP4R1C8x51iSq8QVZOuchu28Uj0xN2Je1f
         6THqWVmanj40ydMVnAllifZdpTzwKzJlbreJFrCwQtB42A9SpDxPSp7L90sG5JY63+
         ikrYCgaxZe4Kg==
Date:   Wed, 28 Jun 2023 11:54:58 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 02/10][next] scsi: aacraid: Use struct_size() helper in
 aac_get_safw_ciss_luns()
Message-ID: <cd80ea8f2446fe62ec15ffb0bbcecb69e0c342af.1687974498.git.gustavoars@kernel.org>
References: <cover.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer struct_size() over open-coded versions.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aachba.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index bba2d4d952ca..fff0550e02e4 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1832,8 +1832,7 @@ static int aac_get_safw_ciss_luns(struct aac_dev *dev)
 	struct aac_srb_unit srbu;
 	struct aac_ciss_phys_luns_resp *phys_luns;
 
-	datasize = sizeof(struct aac_ciss_phys_luns_resp) +
-		   AAC_MAX_TARGETS * sizeof(struct _ciss_lun);
+	datasize = struct_size(phys_luns, lun, AAC_MAX_TARGETS);
 	phys_luns = kmalloc(datasize, GFP_KERNEL);
 	if (phys_luns == NULL)
 		goto out;
-- 
2.34.1

