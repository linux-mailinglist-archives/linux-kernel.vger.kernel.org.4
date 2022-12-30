Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDFE65990C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiL3Nv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiL3Nu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:50:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCCBE0D0;
        Fri, 30 Dec 2022 05:50:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so21766325pjo.3;
        Fri, 30 Dec 2022 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dB9r5V5aeX+alSFvpbQYK5BT2uyrb/7da7XO94Paajo=;
        b=WUSik7yBmMMh1VTE7/8Qwg2PPJyKs04E9WkVjrx3i6haMANv60RXsP+4V5bVX/epYE
         ia7TGFVmhPxkmQYCvu6Uq2ThC4aX1jCVrueRLQEL7CS+capdrm7X+JAh90f3lsSsPp2r
         BLDCYug6P1tfE6K3dHgXgHcjbpJaEv5usy9sRujZDoDa3CBnKwAKZYQf5zqD1+FYj0RM
         XIoKUXHHyzfEgrI6JVQkzpMkmoUml47ZnUwmVEDcTgjVPS6Hh+qtfzgWofeh/TNyuxWt
         yinGb6F7pxRGLj74Vs29UzNoAHtrcBKoqzBUglMIlbRunZB6W7qiyN0o8BO6KVN5ou7J
         NOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dB9r5V5aeX+alSFvpbQYK5BT2uyrb/7da7XO94Paajo=;
        b=JnwSzzgfm2F42vImLl6IdmXM8XYqoy+W6wBg40YSAa3yS+ViChSFvnvxmtj9kqLjM0
         SIifrQL80RMJrVeskaMstAJTqpCB/P/R0/OiLj/SGm4y3NsjmbjigF3h23XNgkN2XXVj
         yPohg18zGD2rKM+saW4Ncq19ibD6O8wnD9c07Twiek2JGcIlWBwWquSEPpfwl0v403gK
         NSDMZ5VR0BVk++8s2mMNm6jn6wJYAa02xyzLkHHoXrpWJuayvc0jFtwgI7VQI4eY/hNu
         1kTjE2lGPQqA/Ue9FPFzwKAqfsWpIGZQ4CEU4iwap3NmuuYYbXP5asfGxF30KQNuivXF
         KRSg==
X-Gm-Message-State: AFqh2kp+GX922K8jgzEgqNFgSfda4+4ViA09WUNyxXrvMO8H+KPv7n1E
        Ur0ZQZInYF1w2g4YVKo1RSs=
X-Google-Smtp-Source: AMrXdXuL5qzcwQeSJj1OOSBSORrTV+WFAHk7IxKJk003dcSYs6+xcWYpB2Ykdqp/m+Z2buN35rzG1Q==
X-Received: by 2002:a17:902:c7d2:b0:192:ab25:45b8 with SMTP id r18-20020a170902c7d200b00192ab2545b8mr2508458pla.58.1672408255483;
        Fri, 30 Dec 2022 05:50:55 -0800 (PST)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b001887e30b9ddsm14893593plf.257.2022.12.30.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:50:54 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 14B4E100AD6; Fri, 30 Dec 2022 20:50:50 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Devicetree <devicetree@vger.kernel.org>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] soc: qcom: dcc: Fix examples list on /sys/kernel/debug/dcc/.../[list-number]/config documentation
Date:   Fri, 30 Dec 2022 20:50:30 +0700
Message-Id: <20221230135030.17002-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230135030.17002-1-bagasdotme@gmail.com>
References: <20221230135030.17002-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4153; i=bagasdotme@gmail.com; h=from:subject; bh=izZVMy8lCwMk1GHgkPp8APZotOXlfQy4ZKvqzrJFgNg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnr3iybfMt95utwgaCjix7ZOdtdfuM07bXUyibtHqb9U4Qu yZwu6yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBE4o4xMvya3y1pXrS8ezbzYvMsn2 +SxxwM7nOtXGpbaHx36o9Uu5eMDDc1FHbI/L/3Jli/O939w5PlU9pqjkjsNmWbKzsvfc2OTG4A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported htmldocs warnings:

Documentation/ABI/testing/debugfs-driver-dcc:34: WARNING: Unexpected indentation.
Documentation/ABI/testing/debugfs-driver-dcc:34: WARNING: Block quote ends without a blank line; unexpected unindent.

Fix these by fixing numbered list syntax on description of
/sys/kernel/debug/dcc/.../[list-number]/config, including adding blank line
separators as appropriate.

Link: https://lore.kernel.org/linux-doc/202212300426.eMLsZsvA-lkp@intel.com/
Fixes: 4cbe60cf5ad622 ("soc: qcom: dcc: Add driver support for Data Capture and Compare unit(DCC)")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/debugfs-driver-dcc | 63 +++++++++++++-------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
index a4680950205931..a00f4502885b58 100644
--- a/Documentation/ABI/testing/debugfs-driver-dcc
+++ b/Documentation/ABI/testing/debugfs-driver-dcc
@@ -44,35 +44,54 @@ Description:
 		example user can jump to list x only after list y is
 		configured and enabled. The format for entering all
 		types of instructions are explained in examples as
-		follows.
-		Example:
-	         i)Read Type Instruction
+		follows:
+
+	        i) Read Type Instruction
+
 		   echo R <1> <2> <3> >/sys/kernel/debug/dcc/../[list-number]/config
+
 		   1->Address to be considered for reading the value.
+
 		   2->The word count of the addresses, read n words
 		      starting from address <1>. Each word is of 32 bits.
 		      If not entered 1 is considered.
+
 		   3->Can be 'apb' or 'ahb' which indicates if it is apb or ahb
 		      bus respectively. If not entered ahb is considered.
-		ii)Write Type Instruction
-		   echo W <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
-		   1->Address to be considered for writing the value.
-		   2->The value that needs to be written at the location.
-		   3->Can be a 'apb' or 'ahb' which indicates if it is apb or ahb
-		      but respectively.
-	       iii)Read Modify Write type instruction
-		   echo RW <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
-		   1->The address which needs to be considered for read then write.
-		   2->The value that needs to be written on the address.
-		   3->The mask of the value to be written.
-		iv)Loop Type Instruction
-		   echo L <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
-		   1->The loop count, the number of times the value of the addresses will be
-		      captured.
-		   2->The address count, total number of addresses to be entered in this
-		      instruction.
-		   3->The series of addresses to be entered separated by a space like <addr1>
-		      <addr2>... and so on.
+
+		ii) Write Type Instruction
+
+		    echo W <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
+
+		    1->Address to be considered for writing the value.
+
+		    2->The value that needs to be written at the location.
+
+		    3->Can be a 'apb' or 'ahb' which indicates if it is apb or ahb
+		       but respectively.
+
+	        iii) Read Modify Write type instruction
+
+		     echo RW <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
+
+		     1->The address which needs to be considered for read then write.
+
+		     2->The value that needs to be written on the address.
+
+		     3->The mask of the value to be written.
+
+		iv) Loop Type Instruction
+
+		    echo L <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
+
+		    1->The loop count, the number of times the value of the addresses will be
+		       captured.
+
+		    2->The address count, total number of addresses to be entered in this
+		       instruction.
+
+		    3->The series of addresses to be entered separated by a space like <addr1>
+		       <addr2>... and so on.
 
 What:           /sys/kernel/debug/dcc/.../[list-number]/enable
 Date:           December 2022
-- 
An old man doll... just what I always wanted! - Clara

