Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD7068DFB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjBGSQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBGSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:16:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2307F3E601
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:16:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y1so14455292wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3O/aD4Uv2cETSrvPLtPnBPSmR1X5PU3SN0FZx5rCJs=;
        b=H46iivmubbNG5bbuSnlVhfSauQ6dL6uQj6DuSUlCCkjOa6nqUuc3TxnMT1KCzkg21N
         q6QcwCmLYTC3L+s3U24GTq1ONcqZkrrYLB7r9x7e18VE9/wkK4SFrQLkxyrW+Qhvbqlg
         3i+CV48cGSDhlzw1GuWlVEd7xnRqKf7bo55Idy8MoZUZ+SRvz9MbuPlseRS3XaxQbi2I
         0t4YTNqqLVJyHEKfTyihlwORxT41Qp8Q1Ai7Oq8gtsmh7448nw8lBuZuE1jetCJLwGbK
         Baz13ZcPVl6plyBYW0+NTSPgpb6Kf3lNj6j745eUHuMQJPwVY+zlT53ecpb+0ZryJbxY
         jMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3O/aD4Uv2cETSrvPLtPnBPSmR1X5PU3SN0FZx5rCJs=;
        b=eZQRHQsYlHXtUh7L2Io3rPmne+wWN6KeK2OzpZtmH5GlVIkw+NS9p0n3DDYh/AoJAP
         zcjanahplW5g5Xnf9/zXl90eiuVFNpnXz9ZWHCVbWt/U/PXJfHv0vADeQhKWIVb19aAU
         yU8l6S9wjWIJP5u+RGUiW+c55iCoTm8DKkLEXwmU+7WQ8KNtjCTK1vofQ+nW2lCl6yRf
         OUBvsJaCs3jUHrZGxUCsoiU3nKeb59HQbT/7xHUraOTarIx8/DFvIMEKZUN1QYhqBG1Y
         soLbgteYiSVifGO1Z99LHwfO7CTEgVwI98zxRaNM+gVnq2Tw+q0dHgPl79XXt8uaLRYB
         ErGg==
X-Gm-Message-State: AO0yUKUW9VrPaRgdO46/20iqP1XOza1Cr9b85W70XoilsTcuMM0GB0gN
        Y2Qnn8SICijfBf036X7eNbo=
X-Google-Smtp-Source: AK7set/44jn5Ep/pwE78uNH5fikW3GqzzST8Vhs3U+5tixpP0gBelHbi1NFKDVEY+2xa3j+uogMtAw==
X-Received: by 2002:a05:6000:12cb:b0:2bf:e46c:8b89 with SMTP id l11-20020a05600012cb00b002bfe46c8b89mr2738630wrx.4.1675793784708;
        Tue, 07 Feb 2023 10:16:24 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b002bfd524255esm12073035wri.43.2023.02.07.10.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:16:24 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:16:22 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Calculate definition of
 MSR_LINK_MASK
Message-ID: <8c8a126a83683bae69d0fd20a93bdea8f810f6d0.1675792435.git.philipp.g.hortmann@gmail.com>
References: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate definition of MSR_LINK_MASK ((1<<0)|(1<<1)) = 3. Equation is not
accepted by checkpatch because of missing spaces.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 1546bb575293..20a35c9caee8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -170,7 +170,7 @@ enum _RTL8192PCI_HW {
 #define	BW_OPMODE_20MHZ			BIT2
 	IC_VERRSION		= 0x301,
 	MSR			= 0x303,
-#define MSR_LINK_MASK      ((1<<0)|(1<<1))
+#define MSR_LINK_MASK      3
 #define MSR_LINK_MANAGED   2
 #define MSR_LINK_ADHOC     1
 #define MSR_LINK_MASTER    3
-- 
2.39.1

