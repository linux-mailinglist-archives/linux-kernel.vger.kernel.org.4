Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C335BCB77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiISMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiISMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:08:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B72AC50;
        Mon, 19 Sep 2022 05:08:02 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWNc8577mzMn4n;
        Mon, 19 Sep 2022 20:03:20 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:08:00 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:08:00 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 5/6] crypto: benchmark - add API documentation
Date:   Mon, 19 Sep 2022 20:05:36 +0800
Message-ID: <20220919120537.39258-6-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20220919120537.39258-1-shenyang39@huawei.com>
References: <20220919120537.39258-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a crypto benchmark to help the developer quickly get the
performance of a crypto-registed algorithm.

To simulate more scenes, the tool has following parameters under
'/sys/modules/crypto_benchmark/parameters/' to configure: algorithm,
algtype, inputsize, loop, numamask, optype, reqnum, threadnum
and time.

To shield the differences between different algorithms, the tool has
following interface to do a crypto request: init, uninit, create_tfm,
release_tfm, create_req, release_req, perf and help.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 Documentation/crypto/benchmark.rst | 104 +++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/crypto/benchmark.rst

diff --git a/Documentation/crypto/benchmark.rst b/Documentation/crypto/benchmark.rst
new file mode 100644
index 000000000000..e9b13e81bce3
--- /dev/null
+++ b/Documentation/crypto/benchmark.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Crypto Benchmark
+================
+
+Overview
+--------
+The crypto benchmark is a crypto algorithm performance tool.
+
+Designed Scheme
+---------------
+
+1. Parameters
+
+The crypto benchmark is used for test the algorithm registered in crypto
+subsystem. Users can use module parameters to simulate different scenarios.
+Both considering the test scenarios and the use complexity, the benchmark
+tool has following module parameters:
+
+- algorithm
+The 'algorithm' is used to create a 'crypto_tfm'. The right algorithm name
+can be found in /proc/crypto.
+
+- algtype
+The 'algtype' is used to find the operations of algorithm. Can get the
+algorithm class by echo 'algtype' to
+/sys/module/crypto_benchmark/parameters/help.
+
+- inputsize
+The 'inputsize' is used as testing inputsize, outputsize will be set
+according to algorithm.
+
+- loop
+The 'loop' is used as times to try to send request for one 'crypto_req'.
+Avoid performance fluctuations caused by environment.
+For synchronization mode, the loop times is equal to send times.
+But for asynchronization, the send times is often less than loop times.
+
+- numamask
+The 'numamask' is used as testing binding numa nodes. The input will be
+analyzed as a bitmap.
+
+- optype
+The 'optype' is used for choose algorithm operation function. Can get the
+algorithm available operation types by cat
+/sys/module/crypto_benchmark/parameters/help with specified 'algtype'.
+For example, choose the compress and decompress when test crypto comp.
+
+- reqnum
+The 'reqnum' is used as requests number of a crypto tfm. For asynchronization,
+one thread may used plural 'crypto_req' to improve performance. One request
+a thread is a synchronous model
+
+- threadnum
+The 'threadnum' is used for creating testing threads. To simplify model,
+create a 'crypto_tfm' per thread. Notice that all threads will be divided
+equally to the specified NUMA node, and threads that cannot be divided
+equally will be created on the last node.
+
+- time
+The 'time' is used for testing. Used for stop the test thread. If the time
+is not enough, the thread will send another group loop times requests.
+
+- run
+The 'run' is used to trigger the test. Echo 0 for stop all test threads,
+and others for starting test.
+
+- help
+The 'help' is used to guide users to use the test interface. Echo a module
+parameter name to 'help' can get the detailed information. Cat the 'help'
+can get some private  information according to 'algtype'.
+
+2. Register
+
+There are too many differences between crypto algorithms. Therefore, the
+crypto benchmark only completes the general work. All the different parts
+are put into the callback of the algorithm to complete. The usual crypto
+task can be divided into three parts: alloc tfm, alloc request, and send
+request.
+
+A new algorithm class want to register to crypto benchmark should realize
+following callbacks:
+
+- init & uninit
+The initialize related functions. Algorithm can do some private setting.
+
+- create_tfm & release_tfm
+The crypto_tfm related functions. Algorithm has different tfm name.
+But they both has a member named tfm, so use tfm to stand for algorithm
+handle. The benchmark has provides the tfm array.
+
+- create_req & release_req
+The crypto_req related functions. The registrant should create a 'reqnum'
+'crypto_req' group in struct 'crypto_bm_base'. And the also suggest
+prepare the request data in this function. To simulate real cache and TLB
+hit rate, using a big data groups is a good plan.
+
+- perf
+The request sending functions. The registrant should use parameter 'loop'
+to send requests repeatly. And update the count in struct
+'crypto_bm_thread_data'.
+
+- help
+The algorithm private parameters meaning functions.
-- 
2.24.0

