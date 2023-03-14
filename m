Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4436B9842
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCNOtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCNOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DEC80913
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678805305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GWQwIVEUxODiUAPgvgj873Ly69YqVHrDDQoHbnjV5Lg=;
        b=UF/71B/iCxOs/d53p3WxyerGDXrPlE8K4TzmMdZPZy4QwFutW+S0RuQjqFbdqlAkeQVf/Y
        jLapw/8sVOorFtpbOwyXUcRvbXAWXemUhVJx62w3sWbTwOeVGWBmEM3VYKpGTJ6/1Qe6HF
        HqozUBc7Kw+kCWtCJf3XZnXBUB1jRC0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-WY6wRthnMfeAIDF4vJeh3A-1; Tue, 14 Mar 2023 10:48:24 -0400
X-MC-Unique: WY6wRthnMfeAIDF4vJeh3A-1
Received: by mail-qv1-f72.google.com with SMTP id a15-20020a0562140c2f00b005ad28a23cffso432710qvd.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678805303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWQwIVEUxODiUAPgvgj873Ly69YqVHrDDQoHbnjV5Lg=;
        b=6hzf1gtCfj5z+WdxRs9d5F30zA8YZ0SxBNAY4GxEr0XmPBKi/DImdlpSOpF7sLZSij
         wZ3YkLTB/2EkK2iDP/F794W/Firv7OAKLjUTStJQe9RrVVMwPTPcGFfFLv0xwKf/uB5F
         ejhlrvl3ZRPmCCvAoR51sqIm8t55O51T22KYO6kFRQJ2SSOdTVmEHwXZzE+KB3WkTmGO
         hnc0XWzN37NbZgr4WrHk1KVnfMxihRwBUpI2glm/JjxZE+FgDPooXlkMts485zhZeqF+
         85ZQ2mawdkeun0//rFhho55cn1SPS6Ap6EZ8+V1CJBWAAnEx5aHCWWHBNjs7pqSDxtZL
         w+5Q==
X-Gm-Message-State: AO0yUKVe0fbx+aRcPpB3NZM26o+l0cQZwHJ7Xf+MHIBQ2PnAg28IEaJq
        XhG/BcQvPaZqzc4BOE7YvWvHvwDhxKNowg4OPfZPewskJlI7ISAIveXukAyhdNr5jK2SMAjMbXk
        lKjWdXKhNzvOH136FSL4+Oqve
X-Received: by 2002:a05:6214:1d01:b0:56f:b28f:cc30 with SMTP id e1-20020a0562141d0100b0056fb28fcc30mr21788490qvd.4.1678805302993;
        Tue, 14 Mar 2023 07:48:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set86DHUQlCKODKwX6vtrt+QBsX323HL8EnwcuuTSwJgeoTcuOKzLQX65s8Qw0siNi4lCn0DLcA==
X-Received: by 2002:a05:6214:1d01:b0:56f:b28f:cc30 with SMTP id e1-20020a0562141d0100b0056fb28fcc30mr21788425qvd.4.1678805302507;
        Tue, 14 Mar 2023 07:48:22 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o6-20020a375a06000000b006fa16fe93bbsm1881186qkb.15.2023.03.14.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:48:22 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sched/topology: set varaiables sched_energy_mutex,update storage-class-specifier to static
Date:   Tue, 14 Mar 2023 10:48:18 -0400
Message-Id: <20230314144818.1453523-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
kernel/sched/topology.c:212:1: warning:
  symbol 'sched_energy_mutex' was not declared. Should it be static?
kernel/sched/topology.c:213:6: warning:
  symbol 'sched_energy_update' was not declared. Should it be static?

These variables are only used in topology.c, so should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 051aaf65c749..6682535e37c8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -209,8 +209,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 static unsigned int sysctl_sched_energy_aware = 1;
-DEFINE_MUTEX(sched_energy_mutex);
-bool sched_energy_update;
+static DEFINE_MUTEX(sched_energy_mutex);
+static bool sched_energy_update;
 
 void rebuild_sched_domains_energy(void)
 {
-- 
2.27.0

