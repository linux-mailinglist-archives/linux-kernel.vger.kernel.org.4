Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8195971EEDD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjFAQ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjFAQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:27:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FF418D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:26:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b1806264e9so5464145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1685636817; x=1688228817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nziXaIgwJ/5heFWqluluHQ82ERFUdGM6TmjJraDSTks=;
        b=ES7I+iTe/v1lSnNrJYYaIzF7qH+PXEowpeFSRu7jvFOzX6UYcw7nNlu5gpBUHEgb3Z
         KPJaRvZYNmqKFsjy5Qmr2pwZvg1wRcSpIyThhnRgN2ny6Gw0UsYWa0r6Owuaw020lOMt
         Ko/4uP5G/cCnoZIuoocAIxmii+QLeZRrH8bn69pMv1D2VeRTYBvQm/e70cGC1lNBrY+J
         UUXffw3Hq0FJOrA2oGTrQ6Nl/1Q+oCbI9+sFTiU88RT9F7o/Uz/9+ma6aOKYx0p8/p7P
         iBtPzDg/CAuxvEvNTF+aOzDsojTE9nRze5lDlFveFMsLtOcJ0mVrkAQ+u9sPgmETIGPq
         cCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685636817; x=1688228817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nziXaIgwJ/5heFWqluluHQ82ERFUdGM6TmjJraDSTks=;
        b=BKK1BPgOkkLtdwcuCMtp1F4buzSSFn5EatIYRDePF7sfI9rufRu7mof8d8InQIXzpi
         1IX6J4gi8MTUSpg4291ThPuO+OIr79ROJ0bA5dllIZ0HtpyQW85G+2fWfvoG7KwoJ7JP
         +0cKfbPa1kdGZePji6WCdImuOM66bMYtxINKXnJySMhEE4AFJ2nylA6z24bEWgE36T07
         +c2vIZ2syoCNx6/qBAmum6IpWGs83jzOjF2Tg86QZM1srNFTe6UrY6S2gFBmRA6NRftX
         b1709NcJaKRqN8C3vZo1bvh+j1wIS/phvht21f3wwZmFRMtxaUf91YJn+8PfUJG/tNxU
         +yNg==
X-Gm-Message-State: AC+VfDx1TsLct0JNclgZgyTQH5dnRN/ocoyurzOH7UNIbfPuag79LEim
        FKvNbokAyDdgsxt6RZj9bHe4mQ==
X-Google-Smtp-Source: ACHHUZ56Lbux4cPw2Lf7EpeSv2aJodEmoCdmuIv0dKl7yhbW+3eGIDVr/H42xGKGSmCkv0LyHn1Fzg==
X-Received: by 2002:a17:902:b18f:b0:1ab:7c4:eb24 with SMTP id s15-20020a170902b18f00b001ab07c4eb24mr5837438plr.22.1685636816818;
        Thu, 01 Jun 2023 09:26:56 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001acaf7e26bbsm3750487plk.53.2023.06.01.09.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:26:56 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     david@redhat.com
Cc:     osalvador@suse.de, rppt@kernel.org, mhocko@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/2] mm/memory_hotplug: remove reset_node_managed_pages() in hotadd_init_pgdat()
Date:   Thu,  1 Jun 2023 16:26:25 +0000
Message-Id: <20230601162626.1030-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

managed pages has already been set to 0 in free_area_init_core_hotplug(),
so it's pointless to reset again.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memory_hotplug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8e0fa209d533..65e385f34679 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1210,7 +1210,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 	 * online_pages() and offline_pages().
 	 * TODO: should be in free_area_init_core_hotplug?
 	 */
-	reset_node_managed_pages(pgdat);
 	reset_node_present_pages(pgdat);
 
 	return pgdat;
-- 
2.25.1

