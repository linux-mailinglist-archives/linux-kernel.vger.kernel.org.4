Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877CC6FD9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjEJIrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjEJIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:47:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38010C0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:47:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f4b911570so1079009366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708450; x=1686300450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NVCh+DFfUdpSAjq1ZIKCIcwLF9IWjBW6NZeKKzNk9f4=;
        b=cMAU7mpNrtoSaKGFEByBtKCDFb0PWeGCgGJ4mxynJisg4EkDiaanR5BY2twH1+yT0M
         pQkref4dfrYN+NIiQqxz9UfForq6G1G5mhI3jnGpZEnRolS2T0jQaX+vvAWMFO5/bjEn
         S4XMVVTiWxwoVpdKVKZP1PtlnfpVQF14edbD1m5igCIMPeG/5munivNXUXAxkwC+YZXF
         6EDFnJ7Ixvx4t6FRZB8p4h+ZNIKB5Y46Du5skbGxTkHBSfWqEOVqjrqBzSciF7ekWRsg
         CsX3W7KxmJuDTzT4XtVBGIRW1AL8aYfnn/smoUXkFdD7/6KFiwkGsr5qHqcAPusufbSr
         fmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708450; x=1686300450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVCh+DFfUdpSAjq1ZIKCIcwLF9IWjBW6NZeKKzNk9f4=;
        b=IrPqZqpq1SshXfXb6Zgft4aW00tCb9b8kUiYCHs9pYZInDoDWRtaf/x7sWzWXSDzbz
         fYyE6p184V0kL3szRXuY6QSBHWGEIgrUrxb7Y1q1k/RZTatVk6deXk0ZGinecibB6ELk
         a3HPoJ7l3TrvXkRZFK8PSCbxuyM0VHeMpyEdq4Rr04S5+j3c+wq7SYDHEH3ZGpDlY6pS
         YHbMUM4+NEdP3vfGuQwghxQgsg8614nQWkIjLlWP2ZlahUwqtjniNZKzX714rorY4BYG
         THplN1oztP/wJ/F1/ggc8vplpPccNHAxQGDd8Nt+Q5niZ+mWsZlfjZotv/Ww+JBkwRcm
         Ax6w==
X-Gm-Message-State: AC+VfDw66lqIqAvJZ4sHYIHxhDdXWNwgaZpCj2HFyt6JU/NoKESO08yY
        PZ9Db2+QpwvXH3bY6GwjpfUG6FZ011M=
X-Google-Smtp-Source: ACHHUZ7aWzxxSmYCc6kT6MpXFs9w1rn7sqW7qOEVhXPINeMfFTkgmAUNzBZ70jGuyZeLYfUFPwSnxQ==
X-Received: by 2002:a17:907:9490:b0:94c:dcac:4b24 with SMTP id dm16-20020a170907949000b0094cdcac4b24mr14982129ejc.49.1683708450479;
        Wed, 10 May 2023 01:47:30 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id jz10-20020a17090775ea00b00965ef79ae14sm2363694ejc.189.2023.05.10.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:47:29 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     rick.wertenbroek@heig-vd.ch
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memory_hotplug: Fix format string in __add_pages warning
Date:   Wed, 10 May 2023 10:47:13 +0200
Message-Id: <20230510084713.3528908-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format string has a typo and prints e.g.,
"Misaligned __add_pages start: 0xfc605 end: #fc609" instead
of "Misaligned __add_pages start: 0xfc605 end: 0xfc609"
Fix "#%lx" => "%#lx"

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8e0fa209d533..446abb088b51 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -325,7 +325,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	}
 
 	if (check_pfn_span(pfn, nr_pages)) {
-		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
+		WARN(1, "Misaligned %s start: %#lx end: %#lx\n", __func__, pfn, pfn + nr_pages - 1);
 		return -EINVAL;
 	}
 
-- 
2.25.1

