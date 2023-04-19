Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3D96E716C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjDSDIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDSDIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:08:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A1846BA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:08:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p8so28310536plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1681873684; x=1684465684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nviNXZ8MpNGnswY2Ey+JPiFyvr7UX/7DG9RC/8jr/gg=;
        b=BdWMlTLAc9ygx2qd6sNmSkvG3hOuewMi1A6ltCqDBjeKwTiYoAjw31KLUXL4Um80zZ
         mMQpqvccs60Ix14cht+Y1dTzSmescFdlLdpVm5DtqpGGFf4WdMUjHT2/mYgvWVk2g/Ru
         xj+Uucw7XaIqG4bigweo2Fg1e76nUm/46kIEfQeIISYCI2pm5Ce1Q8RslNpStIE3S9FC
         kcONJwqS5ngxQMH+UCa84o2maXLDoBW3O3QiscYsUmr1+JLTTyfsPVTMS2+vvlzRIeWt
         R0tp3yOdznk0dSCAN5Pxl8T6Pf86sHJdaCDBb2dT9BNZMoQNhNQEOnOqEtp71GjkdLgU
         AW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681873684; x=1684465684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nviNXZ8MpNGnswY2Ey+JPiFyvr7UX/7DG9RC/8jr/gg=;
        b=PSetQe01oYXdGS2n4uVz9hl1s8OXxdu8hoN0SNUta25HkJguqv6blb1e4JMyo6PQWo
         wgmeRPgpysVg1O6Geo/pXpD/3agPgNsudWwv60Y/v6kWrFWbwucu9nC9XlyUpE2AKQFZ
         Q6+YdEmXgDgn/v9JU1Tqu5LaVr+lN5l6UvLowhMHdKELpDOafUFGHUeYKn1hZiYnZKvk
         BhumXM1EJK6kAQOKTxxyoqir0KQYrxZkirL7PPiULqOLK9v5U85trmPWDz8Vx741dbVm
         TUUebwy0o1sSDLdBkTikS9AkQf5A0O006Q+4z/dO2/ZfYD2Se3o2nqmS+ESY+LxNifKO
         YLHQ==
X-Gm-Message-State: AAQBX9e4kEPpmdWpHG3Eui9tEESszcPqO2wNaW6nXorY48OKmDxs9p4u
        WkbvXURS9pve1YVB1FDIg3LMiw==
X-Google-Smtp-Source: AKy350Y2AdbxTU4zuLNCibYIhpdwwFFwY4wE2TtYLiPTSPRgHOnSOsrrF+WPVMeIC8YSjbxC++Brhw==
X-Received: by 2002:a05:6a20:1612:b0:f0:f4cf:fcf0 with SMTP id l18-20020a056a20161200b000f0f4cffcf0mr2158017pzj.11.1681873683959;
        Tue, 18 Apr 2023 20:08:03 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b00639a1f7b54fsm9900150pfo.60.2023.04.18.20.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:08:03 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@suse.com
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2 1/2] memcg, oom: remove unnecessary check in mem_cgroup_oom_synchronize()
Date:   Wed, 19 Apr 2023 03:07:38 +0000
Message-Id: <20230419030739.115845-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZDUxVG2otm5i12o2@dhcp22.suse.cz>
References: <ZDUxVG2otm5i12o2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_oom_synchronize() is only used when the memcg oom handling is
handed over to the edge of the #PF path. Since commit 29ef680ae7c2 ("memcg,
oom: move out_of_memory back to the charge path") this is the case only
when the kernel memcg oom killer is disabled (current->memcg_in_oom is
only set if memcg->oom_kill_disable). Therefore a check for
oom_kill_disable in mem_cgroup_oom_synchronize() is not required.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
---
v2: split original into two and improve patch description
---
 mm/memcontrol.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..fbf4d2bb1003 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1999,16 +1999,9 @@ bool mem_cgroup_oom_synchronize(bool handle)
 	if (locked)
 		mem_cgroup_oom_notify(memcg);
 
-	if (locked && !memcg->oom_kill_disable) {
-		mem_cgroup_unmark_under_oom(memcg);
-		finish_wait(&memcg_oom_waitq, &owait.wait);
-		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
-					 current->memcg_oom_order);
-	} else {
-		schedule();
-		mem_cgroup_unmark_under_oom(memcg);
-		finish_wait(&memcg_oom_waitq, &owait.wait);
-	}
+	schedule();
+	mem_cgroup_unmark_under_oom(memcg);
+	finish_wait(&memcg_oom_waitq, &owait.wait);
 
 	if (locked) {
 		mem_cgroup_oom_unlock(memcg);
-- 
2.25.1

