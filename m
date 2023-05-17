Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B8706B25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjEQObt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjEQObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:31:47 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C3FD7;
        Wed, 17 May 2023 07:31:45 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-33179bbb900so2038505ab.3;
        Wed, 17 May 2023 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684333905; x=1686925905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Lke+yCCOr0es05iyZ8RuBmLQLBA6r6BTGksr8bpRhM=;
        b=Pg3W+iFAfOfGF+wIsN5Uto67nR/pcQc6Uen1eLfI1TK11t/dizUcJYkp+ZWuvaZKK3
         ELrXjFINXmUMj+9i79RbuR+jVtjuM8O1IeCkmdJwBXAs/mdtvdyau5NF7yBfNKq5CmQE
         QUM6vPyR3iFBKc3GYgn8o7dzml3cTVwX5okun5MRoT8iVK9Ee6RSrmim+TcQbSZ/9Yiz
         +2BX8GUUI1JbezWuOPZuHNjSssy9b07q9rUKWQXJjYTQGF9AEvbMjPtrwtiICCzGtd1/
         oSdH8v8H1IyOBs0HJ5W496m//a+TqdXu92147pWH+SgVuFoNwD3elpzseYH/biAF3enl
         OKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333905; x=1686925905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Lke+yCCOr0es05iyZ8RuBmLQLBA6r6BTGksr8bpRhM=;
        b=AM69lx9xW6aCdRZ8Pje2JukGnC9UNs0ttRgKStCnRaBNsLfrjikxi//KeYKNhceGFm
         vQAlkmdg68cbJ1ff8j/sVWPtIcdEShB3YzsBoP5NnAKJD7CJuSfsLP3gxoJrbu84HhuN
         nWvC9EsTFBoLz6cZFJ3sB+5tI3ysaoLM512tMxA/mSOKTP5owo+4QMrSB1Ysbm7NqsAV
         ANHyotZ1slc1fx9JpaL/+5XUiIHuOLHR+b5VdQPjJQlO91e+DOc7LeoX29kx6METuow9
         1Smdv3Ej2Pg/3u2fiWv1j7UkqzINI3XilEqwW5PlBg2s8L7+/cWYrJ/nwCB5Pw0qJd18
         om/A==
X-Gm-Message-State: AC+VfDzKbyA1SX93+f14oacr5ELva7JbC/Uokplz61HD1haVPLPNZaEh
        G3Z3VBMADg78S/5QtcgVnit+w+kV0nylXA==
X-Google-Smtp-Source: ACHHUZ7J6AS3RReBuk7ob2oUgt6e1ky1TB7AAp3I0h6cavueIKN2LhKrBiKYKgYjUL+i0Gkr62fCbw==
X-Received: by 2002:a92:da45:0:b0:325:d689:6cd7 with SMTP id p5-20020a92da45000000b00325d6896cd7mr2277338ilq.16.1684333904626;
        Wed, 17 May 2023 07:31:44 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id 10-20020a920d0a000000b0032b399aafa5sm8416592iln.18.2023.05.17.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:31:44 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: bnx2i: Replace all non-returning strlcpy with strscpy
Date:   Wed, 17 May 2023 14:31:30 +0000
Message-ID: <20230517143130.1519941-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/scsi/bnx2i/bnx2i_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2i/bnx2i_init.c b/drivers/scsi/bnx2i/bnx2i_init.c
index 2b3f0c10478e..872ad37e2a6e 100644
--- a/drivers/scsi/bnx2i/bnx2i_init.c
+++ b/drivers/scsi/bnx2i/bnx2i_init.c
@@ -383,7 +383,7 @@ int bnx2i_get_stats(void *handle)
 	if (!stats)
 		return -ENOMEM;
 
-	strlcpy(stats->version, DRV_MODULE_VERSION, sizeof(stats->version));
+	strscpy(stats->version, DRV_MODULE_VERSION, sizeof(stats->version));
 	memcpy(stats->mac_add1 + 2, hba->cnic->mac_addr, ETH_ALEN);
 
 	stats->max_frame_size = hba->netdev->mtu;

