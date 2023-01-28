Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA0367F72C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjA1Kj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjA1Kj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:39:26 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7E3757A6;
        Sat, 28 Jan 2023 02:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674902355; bh=i3OVujB4KLVLDGE0Fr7EASyJveRKF8eT3d88+y3e42w=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=k6QEnyHntZuXRepVb90tckWffNAsE19Pnp9R3YxkmC58SuOj/CaifC1L0UBO+Woqw
         HCuS6EcEAiikiZ7Ztux4YzDcfPBRrsoglnFCys0t/V+TD+IYzrjGbqQyFXrnfi1KkS
         8UuOnApWBBKjMqVRAEQPwKiX2E8waTyRLx2UkAnM=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 28 Jan 2023 11:39:15 +0100 (CET)
X-EA-Auth: Fkf8d9ReBXPysJCalcJ1P5bj+NmJgnDSYDgXM1qvVwLxgjBD7WlxvtIXncnpveDpm/aoiai542S/zZt3qW3gUtfrDgSjIbFZ
Date:   Sat, 28 Jan 2023 16:09:11 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH 1/2] scsi: megaraid: Use max helper for comparison and
 assignment
Message-ID: <9db7d3932ac03616f181dabaa53d0b37efb30914.1674900575.git.drv@mailo.com>
References: <cover.1674900575.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674900575.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code using max() helper macro for logical evaluation and value
assignment.
Proposed change is identified using minmax.cocci semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/megaraid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index bf491af9f0d6..c9600e395c34 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -3473,8 +3473,7 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 		/*
 		 * Choose the xferlen bigger of input and output data
 		 */
-		uioc->xferlen = uioc_mimd.outlen > uioc_mimd.inlen ?
-			uioc_mimd.outlen : uioc_mimd.inlen;
+		uioc->xferlen = max(uioc_mimd.outlen, uioc_mimd.inlen);
 
 		if( uioc_mimd.outlen ) uioc->flags = UIOC_RD;
 		if( uioc_mimd.inlen ) uioc->flags |= UIOC_WR;
-- 
2.34.1



