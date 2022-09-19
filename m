Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1735BCB72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiISMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiISMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:08:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4D2A411;
        Mon, 19 Sep 2022 05:08:02 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWNfK2FVdzpSyh;
        Mon, 19 Sep 2022 20:05:13 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:08:00 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:07:59 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 0/6] crypto: benchmark - add the crypto benchmark
Date:   Mon, 19 Sep 2022 20:05:31 +0800
Message-ID: <20220919120537.39258-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
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

Add crypto benchmark - A tool to help the users quickly get the
performance of a algorithm registered in crypto.

The tool tries to use the same API to unify the processes of different
algorithms. The algorithm can do some private operations in the callbacks.
For users, they can see the unified configuration parameters, rather than
a set of configuration parameters corresponding to each algorithm.

This tool can provide users with the ability to test the performance of
algorithms in some specific scenarios. At present, the following parameters
are selected for users configuration: block size, block number,
thread number, bound numa and request number for per tfm. These parameters
can help users simulate approximate business scenarios.

For the RFC version, the compression benchmark test is supported.
I did some verification on Kunpeng920.

The first test case is for zlib-deflate software algorithm.
The cpu frequency is 2.6 GHz. I want to show you the influence of these
parameters.

The configuration is following:
run set: algorithm zlib-deflate, algtype CRYPTO_COMPRESS, inputsize 1024,
loop 1, numamask 0x0, optype 0, reqnum 1, threadnum 1, time 1.
The result is :
Crypto benchmark result:
        throughput      pps             time
        150 MB/s        150 kPP/s       1000 ms

And then change the block size:
run set: algorithm zlib-deflate, algtype CRYPTO_COMPRESS, inputsize 8192,
loop 1, numamask 0x0, optype 0, reqnum 1, threadnum 1, time 1.
Crypto benchmark result:
        throughput      pps             time
        473 MB/s        59 kPP/s        1005 ms

run set: algorithm zlib-deflate, algtype CRYPTO_COMPRESS, inputsize 65536,
loop 1, numamask 0x0, optype 0, reqnum 1, threadnum 1, time 1.
Crypto benchmark result:
        throughput      pps             time
        421 MB/s        6 kPP/s         1038 ms

With the test, users can know that the throughput and pps are both
influenced by block size on this server. And the throughput has a peak
value while the pps is inverse ratio with bolck size increasing.
Due to the software algorithm, thread number will linear increase the
result while it is less than cpu number and other parameters have little
influence on performance.

The second test case is for zlib-deflate hardware. The tested parameters
has the same effect on hardware. Here I test the parameter 'reqnum'.
The software algorithm register to synchronous process. So here it is
useless for software performance.

run set: algorithm zlib-deflate, algtype CRYPTO_COMPRESS, inputsize 8192,
loop 1, numamask 0x0, optype 0, reqnum 1, threadnum 1, time 1.
Crypto benchmark result:
        throughput      pps             time
        367 MB/s        46 kPP/s        941 ms

run set: algorithm zlib-deflate, algtype CRYPTO_COMPRESS, inputsize 8192,
loop 1, numamask 0x0, optype 0, reqnum 10, threadnum 1, time 1.
Crypto benchmark result:
        throughput      pps             time
        3507 MB/s       438 kPP/s       1003 ms

run set: algorithm zlib-deflate, algtype CRYPTO_COMPRESS, inputsize 8192,
loop 1, numamask 0x0, optype 0, reqnum 100, threadnum 1, time 1.
Crypto benchmark result:
        throughput      pps             time
        6318 MB/s       790 kPP/s       1093 ms

So we can know that for asynchronous algorithms, request number for per
tfm also influence the throughput and pps until a peak value.

So with this tool, we can get a quick verification for different platform
and get some reference for business scenarios configuration.

Yang Shen (6):
  moduleparams: Add hexulong type parameter
  crypto: benchmark - add a crypto benchmark tool
  crytpo: benchmark - support compression/decompresssion
  crypto: benchmark - add help information
  crypto: benchmark - add API documentation
  MAINTAINERS: add crypto benchmark MAINTAINER

 Documentation/crypto/benchmark.rst | 104 +++++
 MAINTAINERS                        |   7 +
 crypto/Kconfig                     |   2 +
 crypto/Makefile                    |   5 +
 crypto/benchmark/Kconfig           |  11 +
 crypto/benchmark/Makefile          |   3 +
 crypto/benchmark/benchmark.c       | 599 +++++++++++++++++++++++++++++
 crypto/benchmark/benchmark.h       |  76 ++++
 crypto/benchmark/bm_comp.c         | 435 +++++++++++++++++++++
 crypto/benchmark/bm_comp.h         |  19 +
 include/linux/moduleparam.h        |   7 +-
 kernel/params.c                    |   1 +
 12 files changed, 1268 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/crypto/benchmark.rst
 create mode 100644 crypto/benchmark/Kconfig
 create mode 100644 crypto/benchmark/Makefile
 create mode 100644 crypto/benchmark/benchmark.c
 create mode 100644 crypto/benchmark/benchmark.h
 create mode 100644 crypto/benchmark/bm_comp.c
 create mode 100644 crypto/benchmark/bm_comp.h

--
2.24.0
