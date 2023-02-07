Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46B68D606
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBGLy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGLyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:54:54 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B8F752;
        Tue,  7 Feb 2023 03:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675770883; bh=SaUu9T4vaIZciJlVkGRy87wxHmCtXAbwvw+39ODNwlw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=DvqUJEJOto8u3e9OTH/T0jX42fvj5sQj1LYOOrELo80jRoKrnau8n8yQBRHgwcw6S
         lUkj/SEUiLjz/GQRy062Mg/do0J9S2nnV6lYhxT19+OamkRTtyRD8ACY3pGKpGpEHb
         yX+XP5qJU9cJla3KGnY4jo/cr2ML/jCQfKg/0NoQ=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  7 Feb 2023 12:54:43 +0100 (CET)
X-EA-Auth: bTmKoI02WghlHFGMmY+O2C5h3+AW3/JQnLXwyq7DYGmBt211b5gzWTn9UghYDJ/q155Yr1KW3Tl6rlJMjCKqKxCBUjpXR6SS
Date:   Tue, 7 Feb 2023 17:24:37 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: qla1280: Replace arithmetic addition by bitwise OR
Message-ID: <Y+I7/QpQYjBXutLf@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding two bit-field mask values, an OR operation offers higher
performance over an arithmetic operation. So, convert such addition to
an OR based expression.
Issue identified using orplus.cocci semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/qla1280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 1e7f4d138e06..d806beb4ad1c 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -3709,7 +3709,7 @@ qla1280_error_entry(struct scsi_qla_host *ha, struct response *pkt,
 		ha->outstanding_cmds[handle] = NULL;
 
 		/* Bad payload or header */
-		if (pkt->entry_status & (BIT_3 + BIT_2)) {
+		if (pkt->entry_status & (BIT_3 | BIT_2)) {
 			/* Bad payload or header, set error status. */
 			/* CMD_RESULT(sp->cmd) = CS_BAD_PAYLOAD; */
 			CMD_RESULT(sp->cmd) = DID_ERROR << 16;
-- 
2.34.1



