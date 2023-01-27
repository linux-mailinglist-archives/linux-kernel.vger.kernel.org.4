Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA067F142
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjA0Wjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjA0Wjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:39:31 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B168AD7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:39:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d3so6377096plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdMxl821Ab5HzS26+AY0ir4jhJTH1FXobocBvED2wrI=;
        b=UOv5vWR7TDdvS/ZtjH0Dc95BaNR9YxxISovL49ewINtqUnpu9u6hjafs9zG8RhNi/h
         4XTY5McUc98dknWJOOXO2EfIA1UldDGoRzbz7HXH2hj/URuXBM4YPJUkCT9Akzj6o9VD
         HVeIoDWG1guQrvAMgDMv5Dn/uCd4Z+/Odyseo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdMxl821Ab5HzS26+AY0ir4jhJTH1FXobocBvED2wrI=;
        b=SpEnXlGoXp5VKnPZgrPtRktTj9KiqNaBZ23kUAPxn7kC+coDzn1fyXaANXlyGXbQnQ
         VLH7+XMFJowCwdOQjfZHa3NcrnDkbIuEMG3sfCsrO7xAlnqhdjYpiqRYb6nUYsJsw9RQ
         BG1wA3rTCv/o0BgpEMxjBdNG1WsSlBsDmAt4CL3qgJCYtKcw+digUiLqyMELYWf+JH2x
         LmxMdDSLami5bpmvqrPVqcxl+1JtjfIiJW2hnWWO6hWEflFu8u3jscRUCIWhVz2gizFm
         L3go8zXC0ybGIoSxNEdJ0bVC03gSPxs3Y6TATPngh4fAUi3uP8tuMhnH8MEZEcPh5Hzy
         n/EQ==
X-Gm-Message-State: AO0yUKV5bdHhpu3tJ8P0Ihzxi5/uC11VR5TmkYDebc0mXVkWXMDZSO5V
        IxGrfr8YoORInIq7sVooWU1nmA==
X-Google-Smtp-Source: AK7set/8rbNVre6bexsF6NX/1/7XtoIuDybWTuLLFWf3OfkxMXUqt+QunqP5Wnx7edguVB8M7Dzziw==
X-Received: by 2002:a17:902:f112:b0:196:5979:fb0b with SMTP id e18-20020a170902f11200b001965979fb0bmr2500222plb.50.1674859163738;
        Fri, 27 Jan 2023 14:39:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b0019312dd3f99sm3345054plf.176.2023.01.27.14.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:39:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     Kees Cook <keescook@chromium.org>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] coda: Avoid partial allocation of sig_inputArgs
Date:   Fri, 27 Jan 2023 14:39:21 -0800
Message-Id: <20230127223921.never.882-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; h=from:subject:message-id; bh=eP76JxMZ6S1xFG8BKiuqypsXRZ3qoemnjdFzrcjSaXo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1FKZ/1CyCUzn0X/U43gaayBJEvPOCxJ5823GEjuY 0w2uGs2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RSmQAKCRCJcvTf3G3AJsGLD/ 9bVDEEakt+0cZgXE+v/xRPyJiikpIeJQK5S2nrmK7u7y0uhvmZM7gaPJTOZiSNdbYnk2fIvpzxVATL e5wy7WS177RKngqRhvFG8zKTx8nlwXrCkzvBOEaXZiu4CoaS+uVsltZu1WnJDitWCLkZANB0iYg5bg AAp3YEZnzM+mLJRjavowrhFGUnQU6LRRJFDMf4R3Xxvh2IDByTGpZA38lIMYc5Ly1QLWphIFwEsX2X CJD/3yUAtUMLBEiR5FVJHESJojiz5Tkkt8fVLaEK71lzdlPjT4/ImcAePr31LDqMYTeEIrr/zAqNDY aYTLv+/x3q+ChfptagI92MYVES/lGZ0JxbXKthr+WDHH8eEDipONs+h0B0CdN6eVRr4fggUtfLUCdB 5PiA28KcridQ4YTEJdCQA7ckzwV984TzZvDcsh4JuuZVpudOCrTo90IDp254q36dKfnDzw5ZhJMpDJ 8AEYWOmCiiYw4p0INLb4G73tiSmzq/fpAzAPnBUTo2mx4qqOWl4cGynVqOvt7asXRC6npzE55TjZ52 WeuwkESA2qFVn3o1Tjw5V1aOJr4ImMfOQo06CkaKJCG+wSSvXLob85DnjNQ2qs0RQlnkJLtiax7p6O zvy+Q5RpUEhlHYx0CugGpY9Q3h+I4hghKS8B8Z28ll7QcWUKaRiiSIXMU15w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC does not like having a partially allocation object, since it cannot
reason about it for bounds checking when it is passed to other code.
Instead, fully allocate sig_inputArgs. (Alternatively, sig_inputArgs
should be defined as a struct coda_in_hdr, if it is actually not using
any other part of the union.) Seen under GCC 13:

../fs/coda/upcall.c: In function 'coda_upcall':
../fs/coda/upcall.c:801:22: warning: array subscript 'union inputArgs[0]' is partly outside array bounds of 'unsigned char[20]' [-Warray-bounds=]
  801 |         sig_inputArgs->ih.opcode = CODA_SIGNAL;
      |                      ^~

Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/coda/upcall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 59f6cfd06f96..cd6a3721f6f6 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -791,7 +791,7 @@ static int coda_upcall(struct venus_comm *vcp,
 	sig_req = kmalloc(sizeof(struct upc_req), GFP_KERNEL);
 	if (!sig_req) goto exit;
 
-	sig_inputArgs = kvzalloc(sizeof(struct coda_in_hdr), GFP_KERNEL);
+	sig_inputArgs = kvzalloc(sizeof(*sig_inputArgs), GFP_KERNEL);
 	if (!sig_inputArgs) {
 		kfree(sig_req);
 		goto exit;
-- 
2.34.1

