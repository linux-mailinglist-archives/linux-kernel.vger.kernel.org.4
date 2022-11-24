Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588AC63785D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiKXMDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiKXMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:02:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE71DF2D;
        Thu, 24 Nov 2022 04:02:51 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDWtCVanTenDEPEwSotSCQQFYVhwAatQ+jgyAtI+zek=;
        b=0jOv2RuMx+w1W3VFlDLPG0l29dU1fCAhbYgaQhF6lGWQgTS1OftTMRwz4b30VlxBUh2ITx
        5MGUCnqXb3l1g/eWa9zo9khvaAOg2n4+Ih7yTK6pqNi1FQWaNDTb2JX0dbMC0L/dBzvOUW
        FOg6q6m5ckvbETipzpRvSo8puCjy/qRE0qDJ2YAkseoyHh/sqMxxp1EyfYOlFhMMdJw7lO
        BWkvAoBAGQlEueYVoR+TIYy2alO7gPsYaRK9b8Ftni16EgB3XWhdgNQKUR2rAcb6Wvy0sC
        qdgd5lnsApvk45tz5PrxDBlqwTAAzrkF7hhWwvIUWDNCcvtH/ZZfxYDuhvoKfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDWtCVanTenDEPEwSotSCQQFYVhwAatQ+jgyAtI+zek=;
        b=Yj7Lb4SUTJ18TKVYereusGSdcs/f25iMNyZ7AimZwfTLqRRgQARgduLGVgypqjQ7xW4tDh
        JXesRRNh39qvTDBQ==
From:   "tip-bot2 for Xiongfeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix reference count leak in
 sad_cfg_iio_topology()
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221118063137.121512-2-wangxiongfeng2@huawei.com>
References: <20221118063137.121512-2-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Message-ID: <166929136915.4906.10654616851718534191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c508eb042d9739bf9473526f53303721b70e9100
Gitweb:        https://git.kernel.org/tip/c508eb042d9739bf9473526f53303721b70e9100
Author:        Xiongfeng Wang <wangxiongfeng2@huawei.com>
AuthorDate:    Fri, 18 Nov 2022 14:31:34 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:24 +01:00

perf/x86/intel/uncore: Fix reference count leak in sad_cfg_iio_topology()

pci_get_device() will increase the reference count for the returned
pci_dev, and also decrease the reference count for the input parameter
*from* if it is not NULL.

If we break the loop in sad_cfg_iio_topology() with 'dev' not NULL. We
need to call pci_dev_put() to decrease the reference count. Since
pci_dev_put() can handle the NULL input parameter, we can just add one
pci_dev_put() right before 'return ret'.

Fixes: c1777be3646b ("perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221118063137.121512-2-wangxiongfeng2@huawei.com
---
 arch/x86/events/intel/uncore_snbep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b8f9bd1..b14d591 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4743,6 +4743,8 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
 		type->topology[die][stack_id].iio->pci_bus_no = dev->bus->number;
 	}
 
+	pci_dev_put(dev);
+
 	return ret;
 }
 
