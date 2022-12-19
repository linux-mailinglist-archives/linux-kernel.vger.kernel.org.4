Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAC26513F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiLSUad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiLSUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:30:03 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B488FCC;
        Mon, 19 Dec 2022 12:29:58 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJKRChb029372;
        Mon, 19 Dec 2022 20:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=jD3LLgSm37nQRHMfKV4CUST8QKYllFqCcPy8zK6SIaM=;
 b=RyEzalHhrx/aHW3orjqb8LBtPsIHKMSwHC0xpg9eaj/HNB2G6wFZy4pO5S/S8fd+oerW
 wmCJvFkeF7AxHxMq//9NyHmZM+gepIK8w5ZpT6mPKBLhtknXQLmZruX1Kq+Qo21mbkgo
 a+zmJ35F2pbb1rSjMZK3zyZtN9egQnXbcluUmf3axRXe/CU1Urc9OltNUTn2EFk9cD96
 WyL73c+6rrltYL9kqMV9A2g1Lk/6u51nTSi91Lpg1BWWzjmX4g7QwOL6EJL6VQGiF7tn
 gFAT7GoqnNyS9arIrU+H2L6n0Y7MKQuLl921TyI0Rl2Cbhr52HHp3B5kNJeDWxVT8YNv 9g== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjy0fr0hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 20:29:44 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 877EC807EE5;
        Mon, 19 Dec 2022 20:29:43 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1DC488065EB;
        Mon, 19 Dec 2022 20:29:43 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org
Cc:     linux-crypto@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 2/3] rcu: print first CPU on expedited stall line
Date:   Mon, 19 Dec 2022 14:29:09 -0600
Message-Id: <20221219202910.3063036-3-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219202910.3063036-1-elliott@hpe.com>
References: <20221219202910.3063036-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wSTApf6gnSbNoJkuVG0vozCGTGg8BbvZ
X-Proofpoint-GUID: wSTApf6gnSbNoJkuVG0vozCGTGg8BbvZ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=812 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212190180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the first CPU number in the first pr_err() call reporting
an expedited stall warning.

Printing the CPU numbers with subsequent pr_cont() calls can
result in the prints being many lines away or being dropped entirely
in a busy system. This change ensures there is indication of at
least one of the CPUs with the problem with the original message.

Before (if prints are interspersed with other prints):
  rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
  13-....
  } 32 jiffies s: 6685 root: 0x1/.

After:
  rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {13-....
  } 32 jiffies s: 6685 root: 0x1/.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 kernel/rcu/tree_exp.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index ed6c3cce28f2..ade6a18e6c07 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -624,8 +624,6 @@ static void synchronize_rcu_expedited_wait(void)
 		if (rcu_stall_is_suppressed())
 			continue;
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
-		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
-		       rcu_state.name);
 		ndetected = 0;
 		rcu_for_each_leaf_node(rnp) {
 			ndetected += rcu_print_task_exp_stall(rnp);
@@ -637,11 +635,21 @@ static void synchronize_rcu_expedited_wait(void)
 					continue;
 				ndetected++;
 				rdp = per_cpu_ptr(&rcu_data, cpu);
-				pr_cont(" %d-%c%c%c%c", cpu,
-					"O."[!!cpu_online(cpu)],
-					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
-					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
-					"D."[!!(rdp->cpu_no_qs.b.exp)]);
+				// print the prefix and the first CPU number together
+				// under heavy load, the pr_cont prints can be far away or dropped
+				if (ndetected == 1)
+					pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {%d-%c%c%c%c",
+					       rcu_state.name, cpu,
+					       "O."[!!cpu_online(cpu)],
+					       "o."[!!(rdp->grpmask & rnp->expmaskinit)],
+					       "N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
+					       "D."[!!(rdp->cpu_no_qs.b.exp)]);
+				else
+					pr_cont(" %d-%c%c%c%c", cpu,
+						"O."[!!cpu_online(cpu)],
+						"o."[!!(rdp->grpmask & rnp->expmaskinit)],
+						"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
+						"D."[!!(rdp->cpu_no_qs.b.exp)]);
 			}
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
-- 
2.38.1

