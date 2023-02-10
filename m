Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F65691BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjBJJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjBJJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:46:26 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756E64641
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:46:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gj9-20020a17090b108900b0023114156d36so8776409pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppfFWpSAcZ1aESEIi3DI7xxDUI8KrBz5/PkXTDog9ro=;
        b=LWCJXAT7I+EECVCLtdt5TrDfY1jP64bH1PN4m10e5ID9k8mohRc90Id/D9P5YQ0zo8
         tpNUNA/I+Y2qw21VFtzvbQq/iFU1JdeU5uWGqhcnZwqEX8DlWw+irAGC01fg4inhfNUj
         qfVuPkwbTvxBq/JFjbEKnDjL/vfK4QSLJHUBBrCzAQJAmSckmSmlND9nVCiYZS9FwxM7
         +mUz9uyIMg8cibzSLzifH+bR9e0N1BIuhqHHXFjp60clgMKLA9obumlPzfdkCI9SomZS
         xSKsStJ8KUfMd4aBExGiaG0EOb+1TG/W36cWikejp1fQnLVQm6sVf36/6dWb00RBzrR7
         nhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppfFWpSAcZ1aESEIi3DI7xxDUI8KrBz5/PkXTDog9ro=;
        b=ztHhFiPz6/aC69ON41gV5kRo5CEKUvBp2DZJs3jmKnSOnK7AOxoS5SGgrkmEuHuXPX
         jqeJQ8tYqHf0COpWVo5qPwFAW/cN5RQFeAJTWiqEelPDlAa2Bl9idClJ3FEKO9JtWLxS
         N7OzoE8KDdB+XVaDnM2Igz9dIAzb0sD88dHCpyyHLFzx+Mvrefhd8gBxsGy9NyCuJKzJ
         oj5OnnCy7PdRcMPRhAhEToDZKMH3fhUevN26O/qXHxoQ/IMe3K//v1B7wKM7LBR+6e4Z
         ZQw8cct7aDRTArFjuN3HrEDTMCVxEnmTrtIsdG2LuHne1UIvdefm5DRgDwzFX2wcyIPa
         ZDHA==
X-Gm-Message-State: AO0yUKWCLwxeVBfBSaFfdGnr+K7hH2bq7ewzlMymKICvwWSp/FOjpNQA
        jGrWY/RyCkwqChkQ0S+AdjtXag==
X-Google-Smtp-Source: AK7set+b58gL6zwZfMrrWNjgCByJacYZP1DVcOGb+Rp36X4U3HgVQgr2uQ/HX09SBRwBJkNHVKaQDA==
X-Received: by 2002:a17:902:d48e:b0:199:472b:927f with SMTP id c14-20020a170902d48e00b00199472b927fmr10878196plg.51.1676022384998;
        Fri, 10 Feb 2023 01:46:24 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902a40b00b0019460ac7c6asm2935186plq.283.2023.02.10.01.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 01:46:24 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm/memcg: Skip high limit check in root memcg
Date:   Fri, 10 Feb 2023 09:45:50 +0000
Message-Id: <20230210094550.5125-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high limit checks the memory usage from given memcg to root memcg.
However, there is no limit in root memcg. So this check makes no sense
and we can ignore it.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 73afff8062f9..a31a56598f29 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2780,6 +2780,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	do {
 		bool mem_high, swap_high;
 
+		/* There is no need for root memcg to check high limit */
+		if (mem_cgroup_is_root(memcg))
+			break;
+
 		mem_high = page_counter_read(&memcg->memory) >
 			READ_ONCE(memcg->memory.high);
 		swap_high = page_counter_read(&memcg->swap) >
-- 
2.25.1

