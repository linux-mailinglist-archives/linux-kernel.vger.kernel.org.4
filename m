Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F61611864
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJ1Q4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiJ1Qzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C8240A6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666976090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdcDk47USY1AAs2NC9Jgcp38nSNmzzXOjaUWiRf+Iv4=;
        b=csQAQqvgIuO7PH+HLbqQCsQLIr8LxYvKsP4Uygs6VmJ+nv3BcAiBwpPudlnxneCJGrDR0s
        36m2mk3HppuLmK3xIo/vUlcJX4JOK5xdxtkEM6GaCEhuRcd1KHBEvSOMV+cqWjKkZizh+N
        MWTU5pQ33r3puljn00o2WvyZ3y7JcOM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98-8frFksXRN7mZ51xKjrqWow-1; Fri, 28 Oct 2022 12:54:48 -0400
X-MC-Unique: 8frFksXRN7mZ51xKjrqWow-1
Received: by mail-wr1-f70.google.com with SMTP id u13-20020adfa18d000000b00236566b5b40so1330871wru.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdcDk47USY1AAs2NC9Jgcp38nSNmzzXOjaUWiRf+Iv4=;
        b=MWGuG9/i421PFRPT73v/ed2K1vMIIOYUaisPKWaeWXkh6AGNgAOiPwedcqGHr1VVBN
         PUJtQPSME65NlHyuNVGR7m2XQ6MPUQH/9OT1SAA/cqS1tf2UPjlzRa4Ljkd563epNXRt
         Nw7fOHJzHeTZeSxJeZspwoW/qKI529Zw0bsaxLGnZpVy/sL4me1tbO4pg0PvqjlwSHmU
         174dNgVyZDXu8pZxdjmFEwTfXuefiWtcDoJOC7ENob5IJWpuYb/WSzKOUY28fe7ZdESg
         v/XMRm7WvdBFpxgtm/QL0oppJIpMwRxf6ZUpneHwaAJNZEL+ooJq4GizDlN9P2pBIm3M
         uB7Q==
X-Gm-Message-State: ACrzQf1DQuc9H8ne6uCH59zyabF0/wlEJeKX8otQIARPo2bMhCoZH42b
        CvfCzTZBuEx3p07S2YsRE+00mBkWVj3aJ375zIEaFW6S5pAdoRLaYh/uIUCIs2w7HDxmTyatebD
        W695l9AV2eaLhoT7XqQcZuRYH
X-Received: by 2002:a05:600c:5252:b0:3c6:f478:96db with SMTP id fc18-20020a05600c525200b003c6f47896dbmr129958wmb.116.1666976087570;
        Fri, 28 Oct 2022 09:54:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7f0szCZRq/AyWSF4FAbMLi4c+VZ61awGxbMQMux0B+kV44EN3ui369YGc5WFbD9TcBb6f5Wg==
X-Received: by 2002:a05:600c:5252:b0:3c6:f478:96db with SMTP id fc18-20020a05600c525200b003c6f47896dbmr129938wmb.116.1666976087392;
        Fri, 28 Oct 2022 09:54:47 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id l2-20020a7bc342000000b003c6c182bef9sm9239733wmj.36.2022.10.28.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:54:46 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v6 2/3] sched/topology: Introduce for_each_numa_hop_mask()
Date:   Fri, 28 Oct 2022 17:54:28 +0100
Message-Id: <20221028165429.1368452-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221028164959.1367250-1-vschneid@redhat.com>
References: <20221028164959.1367250-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently introduced sched_numa_hop_mask() exposes cpumasks of CPUs
reachable within a given distance budget, wrap the logic for iterating over
all (distance, mask) values inside an iterator macro.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/topology.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 64199545d7cf6..2223c987a1383 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -255,5 +255,22 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
+ *                          from a given node.
+ * @mask: the iteration variable.
+ * @node: the NUMA node to start the search from.
+ *
+ * Requires rcu_lock to be held.
+ *
+ * Yields cpu_online_mask for @node == NUMA_NO_NODE.
+ */
+#define for_each_numa_hop_mask(mask, node)				       \
+	for (unsigned int __hops = 0;					       \
+	     mask = (node != NUMA_NO_NODE || __hops) ?			       \
+		     sched_numa_hop_mask(node, __hops) :		       \
+		     cpu_online_mask,					       \
+	     !IS_ERR_OR_NULL(mask);					       \
+	     __hops++)
 
 #endif /* _LINUX_TOPOLOGY_H */
-- 
2.31.1

