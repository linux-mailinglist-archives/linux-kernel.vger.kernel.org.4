Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3B603079
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiJRQEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJRQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:04:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D34A02F0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:04:05 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c20so18554302ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APq/4ao2w3wM3w7dcXNTLMlvNyes52nnBtuQjcx7EAg=;
        b=mAYUdBVX9g0h7NVEsuArwdO+JSkTYINBI9eZ9SZP/HN1C28OzOzJFvyKJ7HWDvfuR+
         ncjq9cqJiYAoowUdIMYtYwgu2CBQnKus2tJAPA8Wbv25BnCyqru7+yMa0n1Wc/g/b+tJ
         LYDVxVxEyeXNaZclFdXvci+Bn8Hd2IlqxBU+6QRev104SvVpDc5r8rI7mjqlJ8z57vKa
         T+d9YFon6GhU0JC5SBnQt1DQRpBiVFGkOizCTTxQePe274xFh4s+7Paymc8y/UsfZn1k
         m7syJJNF9ptZ8MZHEKbEkunJ+svNoDlC+HXUM0w2et72jP1HztzI+RkLlC7QPZI/PtHI
         Eo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APq/4ao2w3wM3w7dcXNTLMlvNyes52nnBtuQjcx7EAg=;
        b=4GYhBd3HrpUnZMEap4lHYzvAkOTLjW7N6foMxi+4SQQPjDqBB+mdLIiNyRFDpQ0BhA
         hUN48PshqEI+PwMgdgTjZgkcjIDWRO8f6JABEnAmVNPbQbW29H2wNS+Sr7lvWqgWB2xU
         UlnLPL5RbUVYoDa9/PFtCBr0h/A3sLSed2Ry3YywI77UHzqedGrVknFw3C4aoKqH9jpf
         cVa9EvpoLM2pakmB4AH0xi3/VrNMV7Mg9YpmRxFxbFkBJNpyjE1YYMJT0Rpm2g/JmzUc
         PQwLKTsrmiZJQks4drbr7jN/SzYqB/pfuWVV+zo0U7Tu61OQkQR26kGmMnM7QvS0gxmO
         fvTw==
X-Gm-Message-State: ACrzQf1o7KyyHnk/g1E4F0V0FIEvJrDFKHzrTqZ8xyr0svVzyuF/5UJA
        pPKAq3YtejKcvmVDpxkesBI=
X-Google-Smtp-Source: AMsMyM78/En+eyLIgaDhn666Ec/5nqOrgtZGxs9ntdlCa6Pxh2z0qVC5KTLlHL1Li9Y18RJ5qV4wZQ==
X-Received: by 2002:a05:651c:194a:b0:26f:decf:a6b5 with SMTP id bs10-20020a05651c194a00b0026fdecfa6b5mr1392362ljb.240.1666109043367;
        Tue, 18 Oct 2022 09:04:03 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id v8-20020a056512348800b004a25468d86asm1905039lfr.68.2022.10.18.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:04:02 -0700 (PDT)
Date:   Tue, 18 Oct 2022 16:04:02 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rts5208: Replace instances of udelay by
 usleep_range
Message-ID: <Y07OcqPNjSihOByt@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of udelay by usleep_range as suggested by checkpatch:

CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
+               udelay(30);

CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
+               udelay(50);

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---

v2: changed the max values of the usleep_rage instances as they cannot
be equal to the min values as suggested by checkpatch

 drivers/staging/rts5208/ms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 14449f8afad5..a9724ca5eccf 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -3235,7 +3235,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 			return STATUS_FAIL;
 		}
 
-		udelay(30);
+		usleep_range(30, 31);
 
 		rtsx_init_cmd(chip);
 
@@ -4157,7 +4157,7 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 #ifdef MG_SET_ICV_SLOW
 	for (i = 0; i < 2; i++) {
-		udelay(50);
+		usleep_range(50, 51);
 
 		rtsx_init_cmd(chip);
 
-- 
2.34.1

