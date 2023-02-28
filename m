Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225126A5605
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjB1JmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjB1JmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:42:13 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7D912855
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:12 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id fd25so5306743pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZXmNRcPsICL6kN8QABaXbPWSPAMlFY7UslgXOPbl2g=;
        b=WZm1/ppM9bXo+zrQbhLrwZvlq2t4bwNPkt4KUj6yPa5gKCwz8hlkwCNxGY3/hdZBLs
         KyXwByvuLOAC+7T0rNGW/cSpoyGkNBHdKZFtS8QZA4wobdHYVgRwMYD5IJZRpIFlm5Go
         pdPu+E58xD2ArAgqnwyJChUBVUhs2RxrXSuEsbA/4pn8AKWmqMGjJE+5L/LNtGdFF9me
         6f3yh0poY2vWE4vGs4uGGs1Fc8fOg8rENBJuSyy0r2hwicETvbZS/zfbLlsaBWwjngJR
         jxb7VJU7pMmi1cB7Pt+t96Ut3llgUL1lCK7XZEahCoZV8FOIBXLOSw/bZOV/5i+HiG5l
         eP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZXmNRcPsICL6kN8QABaXbPWSPAMlFY7UslgXOPbl2g=;
        b=ZZTiLkRK57mZYyZcZK1XOlwFNSFnRT+DEt1R5yBPKBgRRaKc0L7VzJuTz2YYpxktKX
         WUfDagQ+A1rWrRpRRD5TI+r8lozk5QyrZz1x/xk25lEKHICFtG1UVY0Yzn3MnWfryke9
         mi1AQuV6QqJIuq1WPTOzkyrBCtkNu0wH1VLjHMkLJoaa7EPsFz/uhejyuytf346oNm6H
         ArxkuiuLaYj2/1BR2mswk3Qjg4UkOcmVfm69rSWv6yKrVTRySt3w39DWD9xG4IDh4XrU
         btUwIN8A8Q4UmW6oSXfkxBcX0hEIolqYHGVwsBPrwCso0sTTl3fuRAMAS12NWYOWiKfG
         /llg==
X-Gm-Message-State: AO0yUKUlAgj2J+mpDePHjhmb1tWoGiNbegtKM/tRCZoRAbvgNjPOEp6y
        ec97hTtCf/z0gV9QHWsOToG7K4dlNYplBUs=
X-Google-Smtp-Source: AK7set+3yAVpuE0+W31PocteZQbp7Jfg/gw72pcGhpvkIIBjNzUWy2DSGF/+10Ov4ubcwXv5mpZFrg==
X-Received: by 2002:a62:546:0:b0:5a8:ecb1:bfe with SMTP id 67-20020a620546000000b005a8ecb10bfemr1992722pff.2.1677577331997;
        Tue, 28 Feb 2023 01:42:11 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id r24-20020a62e418000000b00571f66721aesm5616892pfh.42.2023.02.28.01.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:11 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] lib/group_cpus: Export group_cpus_evenly()
Date:   Tue, 28 Feb 2023 17:41:00 +0800
Message-Id: <20230228094110.37-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230228094110.37-1-xieyongji@bytedance.com>
References: <20230228094110.37-1-xieyongji@bytedance.com>
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

Export group_cpus_evenly() so that some modules
can make use of it to group CPUs evenly according
to NUMA and CPU locality.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
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

