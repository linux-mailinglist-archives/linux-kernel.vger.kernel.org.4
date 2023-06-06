Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607872508A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbjFFXOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbjFFXN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:13:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC1210C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 16:13:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-75ea05150b3so255301285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686093236; x=1688685236;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5bwj1z7HnH+2QnddyqopBsaPUZmUyRMoGGaHHRmdoU=;
        b=dQBs8m7JPeeygMxsKuUzm5VTwp2Blozhsgvsj5I0blRCBSX019vDn85e/CcelOU6UL
         HdZGzTb619CcUd2vImvQN5v+d1BglGdha7l6TXEY5GyUk2Wy5Rgs+KUIiRFjbLRhkxpY
         7DpyydIyATqNXHfRXjDYc+CMKrU0rs6yEV9d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093236; x=1688685236;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5bwj1z7HnH+2QnddyqopBsaPUZmUyRMoGGaHHRmdoU=;
        b=R6SjrK1jNs9eAnUenJqU1saxg1hOzrWJUNHnwrS/VopaPJsxqZTyOw7sJqGV6DjDDg
         K2Z0U9dzh1wmXSbuBYsoWjTkTO1ogmzGNSsuoB8X8RBvgGWN+RVIn0vtu5HLVnqMiXHy
         r3wkferNIZ1nuBztSPw0w0SeT8hY/+GSbOUBeCFaxdmT2qsWo0923iI1qQ73GCfjcEhS
         cXRGdn8j+97W653Yw9kFxXtlaFEbXMNOVgkIMCK51bLWvDD7SBnLxfKSQrL2bXT8D3iJ
         5lmTGhFFLB1dQ8eI+FcrJ58x8J8Qlpu68jZRHpM8oRsolTMVDQSaFcPhjM6bcVGQ6Rle
         FhJQ==
X-Gm-Message-State: AC+VfDyI14TB/ExFjhrUQ0s0GrpHLtV7jbbz7sNhnUA6rJcFvhrTHHie
        44+3QYGoTBjynpW7uzow9Xb6qQ==
X-Google-Smtp-Source: ACHHUZ5GrEI5xMXNYA+bW3RPq1G+ysrSDy8dyOlAho90ciEB+xEd4Dw1bEDef0O3NRz7Y8g87xVi3g==
X-Received: by 2002:a05:620a:843:b0:75e:cda3:16ab with SMTP id u3-20020a05620a084300b0075ecda316abmr181956qku.33.1686093236614;
        Tue, 06 Jun 2023 16:13:56 -0700 (PDT)
Received: from ubuntu-22.localdomain ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id x9-20020ae9e909000000b0075b23e55640sm5221519qkf.123.2023.06.06.16.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 16:13:55 -0700 (PDT)
From:   William Zhang <william.zhang@broadcom.com>
To:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>
Cc:     f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 01/12] mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller
Date:   Tue,  6 Jun 2023 16:12:41 -0700
Message-Id: <20230606231252.94838-2-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606231252.94838-1-william.zhang@broadcom.com>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000071e35f05fd7e2ca4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000071e35f05fd7e2ca4
Content-Transfer-Encoding: 8bit

v7.2 controller has different ECC level field size and shift in the acc
control register than its predecessor and successor controller. It needs
to be set specifically.

Fixes: decba6d47869 ("mtd: brcmnand: Add v7.2 controller support")
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 2e9c2e2d9c9f..b2cde1082b3b 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -977,12 +977,20 @@ static inline u32 brcmnand_ecc_level_mask(struct brcmnand_controller *ctrl)
 	mask <<= NAND_ACC_CONTROL_ECC_SHIFT;
 
 	/* v7.2 includes additional ECC levels */
-	if (ctrl->nand_version >= 0x0702)
+	if (ctrl->nand_version == 0x0702)
 		mask |= 0x7 << NAND_ACC_CONTROL_ECC_EXT_SHIFT;
 
 	return mask;
 }
 
+static inline int brcmnand_ecc_level_shift(struct brcmnand_controller *ctrl)
+{
+	if (ctrl->nand_version == 0x0702)
+		return NAND_ACC_CONTROL_ECC_EXT_SHIFT;
+	else
+		return NAND_ACC_CONTROL_ECC_SHIFT;
+}
+
 static void brcmnand_set_ecc_enabled(struct brcmnand_host *host, int en)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
@@ -992,8 +1000,8 @@ static void brcmnand_set_ecc_enabled(struct brcmnand_host *host, int en)
 
 	if (en) {
 		acc_control |= ecc_flags; /* enable RD/WR ECC */
-		acc_control |= host->hwcfg.ecc_level
-			       << NAND_ACC_CONTROL_ECC_SHIFT;
+		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
+		acc_control |= host->hwcfg.ecc_level << brcmnand_ecc_level_shift(ctrl);
 	} else {
 		acc_control &= ~ecc_flags; /* disable RD/WR ECC */
 		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
-- 
2.37.3


--00000000000071e35f05fd7e2ca4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFpz+eeKhakuaLxF0Egpf7fM7M8T
wz5tfolZwASxwrn4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDYwNjIzMTM1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA/MSV8iNqeIOQBumEdEMftQZCr1WH/tKqnzzifevcW/SYY
b95Jww8tOXAL/Cmu7MjijLD4PaO0FWOdL4ReNTISEeOGu6qEWz2rmM+OvagU7RzI3fObmNUGS+QX
j3tFqXbmEseu+OMQzgewFyPLi+X1V7BcNpA4EQW3e3G/aXCy5rjLVKWt0Glf5YCvypZze6JlZI2z
rR7YaKXvGEPdbSLHbhNy+tALMNFTw8d4Ojdmw4cGqHA8P7EG25fvw8olzJhIsnRDDgknNZrl6sBV
N8RHMuSp1Y07blP/xRdgz0m6mmSPWW6JW4wenHYM1ssBpfRojeK73pTYmR1gUfodcwoL
--00000000000071e35f05fd7e2ca4--
