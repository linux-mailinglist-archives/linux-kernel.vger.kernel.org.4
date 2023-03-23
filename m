Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9599F6C5EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjCWFco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCWFcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2160622018
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id le6so21291175plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3DhZ6b2/Cat//geb2wYI+Q6V+P6wWnnhrfxNudLCpk=;
        b=e6HcJuDFL4JYzLtGSwoRmFcMtNkc0XY58kIpmAnTCLtZgo9O5haDVBc/i4Cid4cH7v
         crtFyTSRHTwyeQYit4X5M6KWBNNTTHfPgJ1kOFnl9UWwrrKE08k6jzyLO14WPuRyn2Nd
         Rw2kl4tHknYtTyZEr6cDPVpHOvPNXjPfWzAuf5Z8ADcAvvc7lZYHbZWwKtbo4jwfqh+/
         6mtBBrigpvPgeV/+C/7hP82YR1SCUEXYgP9r8dVti3dduEzir+f7TuPeOf2sxQl628Oe
         0fonCwiRBMB/2E6qW+W2HFZaXg0asiY1y03TEVWUa34y9bt67UbbAlohXzmllkBjA73J
         VuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3DhZ6b2/Cat//geb2wYI+Q6V+P6wWnnhrfxNudLCpk=;
        b=hFSUmVoXWjZ0rt6LmqRNU319CSXERxFRd4kRm0eLTUrP8EQp8+1QQNEvZKXPRxuKtN
         VFpm9pfQGFJDcBTT7+au19fIar6jwneKYN+VoUelLYl7zjxtFFMrBQskvgoD6mAscABQ
         5Ph6sWIRKpaKmu4Ax3qbVDCrU0S4sJBDsUYw+xQm7F/GUHblRu9Rza49W5wxe0zageHH
         3g0KfbBTZgYrQ1CCaHalTpgPBxXHsMQBu4PDeOP9kawxK0YxFqZe4YLOM3XBg0kv/g43
         jzuPuhYUg6aBH+Ow1KaCKAGCvZM2UXB+TtfPEPQIzWGJ5a28qcWDSEXypPlQL2IuK59/
         bzUw==
X-Gm-Message-State: AO0yUKUsLm7eAsmDlijMWYK3JA98DEFVokI74sD9WM3q244nOLp6/R4u
        1TOna2136rT0YQpCJDQwRdIb
X-Google-Smtp-Source: AK7set+HOZ5FIL2prWiJfZTkE+9WN4aKPpPKGF9Y2L1QmB3xf2Eq33k71ZWGNrpszrdM8fWSrvMRjg==
X-Received: by 2002:a17:90b:17d2:b0:22c:816e:d67d with SMTP id me18-20020a17090b17d200b0022c816ed67dmr6798965pjb.24.1679549475944;
        Wed, 22 Mar 2023 22:31:15 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902bb8300b0019a7d58e595sm11443864pls.143.2023.03.22.22.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:15 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] lib/group_cpus: Export group_cpus_evenly()
Date:   Thu, 23 Mar 2023 13:30:33 +0800
Message-Id: <20230323053043.35-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323053043.35-1-xieyongji@bytedance.com>
References: <20230323053043.35-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export group_cpus_evenly() so that some modules
can make use of it to group CPUs evenly according
to NUMA and CPU locality.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 lib/group_cpus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 9c837a35fef7..aa3f6815bb12 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -426,3 +426,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	return masks;
 }
 #endif /* CONFIG_SMP */
+EXPORT_SYMBOL_GPL(group_cpus_evenly);
-- 
2.20.1

