Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4B6A2E7F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBZF42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBZF4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:56:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60F1024D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 21:56:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso6951584pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 21:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ps7PPtmkV1wfKAGYjMd8DEEZ2jaRpzCcvl95Jx3hG3Q=;
        b=Y919pzF9HjdPEaxqQJ3+VWrmE1yAwv8f1ShwtatXfaJUlb7xwQvIwMwUpNvk2mLeyl
         pA32wARnZRm4Gpb1FfjbmSD/+EAEbSQpnevuVDFENf+vYTZG6nIKtGR5n9oY3Sd7sFOF
         OmBgtdNi2CpuKXOqJeTCa4Q3j4VmS40yBR8ecf2IzCnLqE5GlOp2BFvlVrr5i1T5hdLY
         WLqId5aIFRo/5K9UETp0FidD5KkHmlbq2DiO1Sl97sDwcvSi3Wqj3TJVOKn5LeDqomqW
         ApwT2tjdgMniuvvBclPE0xryR4QodJXofvRckFQGZ7XQhr+X8zoH2KxhwpzrjaxCFOhI
         EyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ps7PPtmkV1wfKAGYjMd8DEEZ2jaRpzCcvl95Jx3hG3Q=;
        b=WCJ39xXsvujfYUeE71Mv0KungzhX6tvWxsqsu0BebmDTzRclV72a/8a24U9+rxPIF1
         obPZnXuSlMIk9o63QZnhIYe5Uxr7dC1YAdfTLOXHH9TnFT1vZqGyp/yCoFtIx/vW/WD4
         lEQuyopfmETvJMxREgwLq8j2/ZwZTiqZVwrC1SibRxRFkERouqhvtpRNSLoi0rRuLOyh
         ISD7OeEbw+CuVcUBSn85H0fNOZaEx0g0H7O85xjoNOrDuJiEI9EaNINMDXPRmISZcKuz
         KCIeft0YUwck3pamzAIl348u17jc8PTjcfHc5taxGsbKooF4nEltksC91qatyFP0ttaG
         leRg==
X-Gm-Message-State: AO0yUKUrIKjRKDm9eFHafF4e0wZwV0WZS93jdTemSgruq3RSnWxphgHO
        y6YoShTRvt7SRSUIKhHYR4nRhAnYqMP4/Smb
X-Google-Smtp-Source: AK7set/USgLACHG20TuGc+NO2lmQmZsRDGjXQY8KMULXPcThNbFtj/fymqPVEE9UHRF7kgsjlxr24A==
X-Received: by 2002:a17:903:230f:b0:189:5ef4:6ae9 with SMTP id d15-20020a170903230f00b001895ef46ae9mr27273116plh.45.1677390983349;
        Sat, 25 Feb 2023 21:56:23 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709028d8100b00189e7cb8b89sm2081471plo.127.2023.02.25.21.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 21:56:22 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] nvdimm: check for null return of devm_kmalloc in nd_pfn_probe
Date:   Sun, 26 Feb 2023 13:56:15 +0800
Message-Id: <20230226055615.2518149-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kmalloc may fails, pfn_sb might be null and will cause
null pointer dereference later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/nvdimm/pfn_devs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index af7d93015..d24fad175 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -640,6 +640,8 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
 	if (!pfn_dev)
 		return -ENOMEM;
 	pfn_sb = devm_kmalloc(dev, sizeof(*pfn_sb), GFP_KERNEL);
+	if (!pfn_sb)
+		return -ENOMEM;
 	nd_pfn = to_nd_pfn(pfn_dev);
 	nd_pfn->pfn_sb = pfn_sb;
 	rc = nd_pfn_validate(nd_pfn, PFN_SIG);
-- 
2.34.1

