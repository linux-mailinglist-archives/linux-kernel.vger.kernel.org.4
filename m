Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7735F07AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiI3Jb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiI3JbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DACAF84;
        Fri, 30 Sep 2022 02:31:14 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tKHQN/65I/Z+WmW6EJaXxIjYTWVygLq/UKPukob644=;
        b=uO1lmF5+VJHlorhWPpeQsrY1Dqu5KhMXbQ9LyRNounc4jIZo1BSyczi6oxg3zHqmBfJFdy
        BpXzjHFQx4T+ASIxcY2T8E898SckXKDCNnAKnkSDRcEeSg/pucVXY6GgUt3z0vPj9KJR9L
        BFOTxEzg2Vq/WAPFHU6GqSykwTUHVc2gSzcUfZPIRjHj3lF7DtIrU7saRbDw2K3ud5lcn4
        IE+715+rYOLfwfU8x7JBTKduQGciaiKpU2hWXuKYHD1dqpWncwfhJrIbE2ax7SANGcD60K
        WAV5vVXMGu45gHRZQOSyK0zFTrDmEpmFPoxVn7I2i4uQQYxlS0nooUziC1B30w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tKHQN/65I/Z+WmW6EJaXxIjYTWVygLq/UKPukob644=;
        b=nvIZ0ejkzRmIccyHikSPpnpgs605SGv4Bn+k34L/jxzi7y+3gZFaKU/CLkb+mAGA5mOvUy
        1q9sihLUsuVEVpCA==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928095805.596-2-ravi.bangoria@amd.com>
References: <20220928095805.596-2-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166453027081.401.11135130150980013880.tip-bot2@tip-bot2>
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

Commit-ID:     ee3e88dfec23153d0675b5d00522297b9adf657c
Gitweb:        https://git.kernel.org/tip/ee3e88dfec23153d0675b5d00522297b9adf657c
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 28 Sep 2022 15:27:51 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:54 +02:00

perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}

PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
accesses but it can not distinguish between local and remote IO.
Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220928095805.596-2-ravi.bangoria@amd.com
---
 include/uapi/linux/perf_event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index e639c74..4ae3c24 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1336,7 +1336,9 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0xa available */
+/* 5-0x8 available */
+#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
+#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
