Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D366A71F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCARTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCARTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:19:38 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E47B36442;
        Wed,  1 Mar 2023 09:19:33 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id i34so56777462eda.7;
        Wed, 01 Mar 2023 09:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRe05a9G8Y51+PSp1T278R9G34SaE71lnwKhgVyqRVM=;
        b=auk8vpkMOuh5ilZZaALuGEMCApUX0ABSxSJMZ2aue89jBbUX7xDmIDB2mDWgLPJNpa
         oYOt9QY7WXMt8CFPbk2XIAJ4qUQ4tMTKEC08rOwCtkaFegD5NxzlxMNXFVTsRlfCunue
         jnjXH0/dDBK/fmErHXTjplnXQYktwyTFqTXlH2mLzpHozizqcRf91qmr12wYJ4hqJc+T
         P+LHFnxB20ZpGIXPvn9x319k+KxVxDA38d8izKP65TWUv9k3EBxUyxGY8y1A5X3zY4iM
         tEr9SC/TkVm5/tTPJjX4a11j24ragZB5pNo8KAELJm8LC2LTwHIqK4ujuvsbs0YcPmo4
         5jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRe05a9G8Y51+PSp1T278R9G34SaE71lnwKhgVyqRVM=;
        b=JKe15pvCXfyg3pIpvxgkqfavpsJpkgVs748BCByu4UU7Gu0Y4lUWObfXZz+DxvdzPa
         QQlCO/KP1b38KFnd0wy9I191xlOMbtcGAAkt1ACRS4GHLNuVsLNgjTZhy9gh7FBiGPoU
         ivLIU9IhTSNLJaolCw12XBTD0MTCOFI9QhcMSltahVmpIP0zH62VNzbW3kWXUbAaqfFL
         Xh+x2bWUc9OO6RsgYnMyIFpcuPV5E+Twsznbf7D/uINaHYRn98i9K8SQ0sPMQDxjg2bf
         SGQ3Cu/JjuuM2GJLdCEXNpP5u7NHOkXpNptAOEjMMsFVHw6uHu2ymjh0mqLmNDmWa9Kf
         s8MA==
X-Gm-Message-State: AO0yUKVYlENye+wRGNR4BOPcUTbzJy7d8umQ3BwFlRYzuLweKS+NRCZ8
        3kC3ykrV2jk1Fpo8y88f3Wjfzq7SG4IkCuR6
X-Google-Smtp-Source: AK7set8I5zFIHu9/b8cAqaSqZg2Om7uarsCPaGoQTaNxsGGZ5pGbKuIL41wOPrSZU29w1QkQT1WfiQ==
X-Received: by 2002:a17:907:c68a:b0:87f:546d:7cb5 with SMTP id ue10-20020a170907c68a00b0087f546d7cb5mr7836689ejc.37.1677691171579;
        Wed, 01 Mar 2023 09:19:31 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id lc8-20020a170906f90800b008d57e796dcbsm5986567ejb.25.2023.03.01.09.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:19:31 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Wed, 01 Mar 2023 18:19:14 +0100
Subject: [PATCH] scsi: lpfc: avoid usage of list iterator variable after
 loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230301-scsi-lpfc-avoid-list-iterator-after-loop-v1-1-325578ae7561@gmail.com>
X-B4-Tracking: v=1; b=H4sIABGJ/2MC/x2OwQrDIBBEfyV47oKJlJT+SulhXddmwaq4IQRC/
 r2mt3nM8JjDKDdhNc/hMI03USm5w3gbDC2YPwwSOpvJTs46O4KSCqQaCXArEiCJriArN1xLA4w
 9QSqlwuzncCeHD45kus6jMviGmZZL+EXt06uojaPs/w+v93n+APnED1STAAAA
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677691171; l=1910;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=8hGXtX/Zsq0Mz986GnpBIGioOKRulASx+6dKpyss844=;
 b=J9yLwyS7zTkZV9LOu0KRbQK7L77rrhfHLSepm1zL3eHWxIbnQGk0Js3AfQjI8L/K4V3vA1WE9Nfd
 2htjx2PpDhi9OPD0o68L9N80mqOhn6R4qajYE6UExwXXPtGEx9or
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the &epd_pool->list is empty when executing
lpfc_get_io_buf_from_expedite_pool() the function would return an
invalid pointer. Even in the case if the list is guaranteed to be
populated, the iterator variable should not be used after the loop to be
more robust for future changes.

Linus proposed to avoid any use of the list iterator variable after the
loop, in the attempt to move the list iterator variable declaration into
the marcro to avoid any potential misuse after the loop [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index edbd81c3b643..5d06bf6d4f39 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -21899,20 +21899,20 @@ lpfc_get_io_buf_from_private_pool(struct lpfc_hba *phba,
 static struct lpfc_io_buf *
 lpfc_get_io_buf_from_expedite_pool(struct lpfc_hba *phba)
 {
-	struct lpfc_io_buf *lpfc_ncmd;
+	struct lpfc_io_buf *lpfc_ncmd = NULL, *iter;
 	struct lpfc_io_buf *lpfc_ncmd_next;
 	unsigned long iflag;
 	struct lpfc_epd_pool *epd_pool;
 
 	epd_pool = &phba->epd_pool;
-	lpfc_ncmd = NULL;
 
 	spin_lock_irqsave(&epd_pool->lock, iflag);
 	if (epd_pool->count > 0) {
-		list_for_each_entry_safe(lpfc_ncmd, lpfc_ncmd_next,
+		list_for_each_entry_safe(iter, lpfc_ncmd_next,
 					 &epd_pool->list, list) {
-			list_del(&lpfc_ncmd->list);
+			list_del(&iter->list);
 			epd_pool->count--;
+			lpfc_ncmd = iter;
 			break;
 		}
 	}

---
base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
change-id: 20230301-scsi-lpfc-avoid-list-iterator-after-loop-7b7d5c3a8efc

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

