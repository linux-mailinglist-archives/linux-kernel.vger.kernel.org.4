Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7160168B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJQSoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJQSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:44:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7941C2;
        Mon, 17 Oct 2022 11:44:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so11804083pjb.2;
        Mon, 17 Oct 2022 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EDculVdfuod3LvB+YZ/9tyRLowaSjT/EMGrKWwqWrs=;
        b=Ag3jTmTkmqxi6rRrA6Rj3jQtI2WHV93lD7AVOheEsJ6CeVPutPpaNZOqSsCGMTVRNo
         ACyP8mowy4wm/T2YjeECJC5RcZo6Kdk1kfBjH0VT7GzKFyHXz4UXtBQihW3Zf5kqol5W
         31IJpOKADtfRGIu9vpvwf2OCJSTzH2uTsAWOIjCFCsrL1d/RqPeZqwWXPNk2629NXEJD
         2Ni3vOpt38/XBG7OwNoZ2XYwqUes1TZ81nkMUMT4oZ0T2/uvdGbTUbk59mHtBVXoWqks
         DwegG5xkm0qlGJjxkeWwHKXZi0Gg1lhm+x5ITOrG0ICZ8hP9Xy7onvZ5gVz310ouRj79
         YQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EDculVdfuod3LvB+YZ/9tyRLowaSjT/EMGrKWwqWrs=;
        b=w5L57yAnzQRsNhqRPcDA98stA5h9SmENNzLRcGaPLzWvsFG6XAahxvXIGHK8xXh6hw
         h7XQRdliqW1hT4ydZchG8Va4G1grKiIYW1ylldx12U4ryeCN1CFlS4FvfJGKzu9MVh8k
         0UZVcEJn0THD2APHLuR7tFcQ57AE+etkoISrq0Om0/mWECVyvUg8nnCyAVlEcXfZxHdj
         edgwFMk9p/TZRnI4UN58+TUJNeExZQkMzlIyko+VyutqaXdBDeASJ6HbkWF+oCeGDm11
         okeNwERHlX7XaKT5sAGuKN0oSi483lAW1ZPGzdBs9FCRstO1I+RpXbxsxkqlbb7EI7S0
         +fww==
X-Gm-Message-State: ACrzQf3pU0BHel1SlNkAmhFBP3LEc3Of3T24t8xx4P9kYrvI+PXNf+yf
        Wnd8ezuSEEX2fxULMMTidsY51KiQGYM=
X-Google-Smtp-Source: AMsMyM4zkDy5DAtUIXjtxrTG1iendeglHLWEa4bgd2iGMur+37H7ncHWGU8DpqO7zqzP74e6PB9S3A==
X-Received: by 2002:a17:90b:33c3:b0:20a:ebc3:6514 with SMTP id lk3-20020a17090b33c300b0020aebc36514mr34401275pjb.147.1666032253704;
        Mon, 17 Oct 2022 11:44:13 -0700 (PDT)
Received: from localhost ([115.117.107.100])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001801aec1f6bsm7011337plh.141.2022.10.17.11.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:44:13 -0700 (PDT)
From:   Manank Patel <pmanank200502@gmail.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manank Patel <pmanank200502@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2] "ACPI: PCC: Fix unintentional integer overflow"
Date:   Tue, 18 Oct 2022 00:13:39 +0530
Message-Id: <20221017184338.64152-1-pmanank200502@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221017182035.3g67uudttl6k5gag@bogus>
References: <20221017182035.3g67uudttl6k5gag@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed unintentional u32 overflow by changing PCC_CMD_WAIT_RETRIES_NUM to 500ULL

Fixes: 91cefefb6991 ("ACPI: PCC: replace wait_for_completion()")

Signed-off-by: Manank Patel <pmanank200502@gmail.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

---
Thank you so much @sudeep for your clarifications!

Changelog:
v1->v2:
        Change the macro itself to ULL instead of typecasting in the
        code

 drivers/acpi/acpi_pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index ee4ce5ba1fb2..3e252be047b8 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -27,7 +27,7 @@
  * Arbitrary retries in case the remote processor is slow to respond
  * to PCC commands
  */
-#define PCC_CMD_WAIT_RETRIES_NUM	500
+#define PCC_CMD_WAIT_RETRIES_NUM	500ULL
 
 struct pcc_data {
 	struct pcc_mbox_chan *pcc_chan;
-- 
2.38.0

