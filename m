Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE7714263
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjE2Dtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjE2Dto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:49:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED66B1;
        Sun, 28 May 2023 20:49:43 -0700 (PDT)
Received: from dggpeml500001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QV1cx0c5Sz18Ll7;
        Mon, 29 May 2023 11:45:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 29 May
 2023 11:49:39 +0800
From:   kongweibin <kongweibin2@huawei.com>
To:     <kongweibin2@huawei.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <hsinweih@uci.edu>, <jakub@cloudflare.com>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [bpf?] [net?] socket test data of ebpf sockmap/redirection and TCP/IP stack
Date:   Mon, 29 May 2023 11:49:18 +0800
Message-ID: <20230529034918.718150-1-kongweibin2@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20230525143814.361127-1-kongweibin2@huawei.com>
References: <20230525143814.361127-1-kongweibin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500001.china.huawei.com (7.185.36.227)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your attention!

The testing tool is Fortio.First,start a Fortio server container,and then
start a Fortio client container to send messages to the server container.
Compare the performance indicators of using ebpf sockmap/redirect and TCP/IP
stack.

test cmd:
fortio server:docker run -it -d --name=fortio-server fortio/fortio server
fortio client:docker run -it --rm --name=fortio-client fortio/fortio load 
              -c $connum -t 30s -qps 0 -jitter=true -payload-size $payload 
			  -quiet http://172.17.0.2:8080

As I increase `connum` or `payload`,the performance improvement gradually
becomes less significant or even decreases.

Host Configuration:16 CPUs(x86_64),64G mem
OS kernel version:5.10

here are the test datas:

|----------------------------------------------------------------------------
|connum	|payload|   qps	  |avg(ms)|   qps   |avg(ms)|qps improve|avg reduce |
|----------------------------------------------------------------------------
|       |       |     TCP/IP  	  |		  ebpf      |           |           |
|1		|0k		|25819.43 |0.039  |31060.83 |0.032 	|20.30%		|17.24%     |
|1		|1k		|20697.53 |0.048  |27073.13 |0.037 	|30.80%		|23.45%     |
|1		|10k	|11086.70 |0.090  |14656.67 |0.068 	|32.20%		|24.44%     |
|1		|100k	|2993.60  |0.334  |3746.63  |0.267 	|25.15%		|20.16%     |
|10		|0k		|145297.5 |0.069  |170481.7 |0.058 	|17.33%		|15.53%     |
|10		|1k		|80145.87 |0.124  |94578.50 |0.105 	|18.01%		|15.28%     |
|10		|10k	|20523.40 |0.487  |23920.67 |0.418 	|16.55%		|14.11%     |
|10		|100k	|6532.70  |1.531  |6837.87  |1.462 	|4.67%		|4.49%      |
|20		|0k		|218367.3 |0.091  |258349.1 |0.077 	|18.31%		|15.38%     |
|20		|1k		|90609.27 |0.221  |98366.67 |0.203 	|8.65%		|7.93%      |
|20		|10k	|20363.63 |0.983  |22731.00 |0.880 	|11.66%		|10.45%     |
|20		|100k	|7391.83  |2.705  |7374.20  |2.712 	|-0.24%		|-0.25%     |
|50		|0k		|221913.6 |0.225  |255631.1 |0.195 	|15.20%		|13.18%     |
|50		|1k		|110390.9 |0.453  |123547.0 |0.404 	|12.00%		|10.74%     |
|50		|10k	|28793.87 |1.737  |28751.90 |1.739 	|-0.08%		|-0.15%     |
|50		|100k	|9590.40  |5.213  |9565.83  |5.227 	|-0.26%		|-0.26%     |
|100	|0k		|286830.5 |0.349  |348999.5 |0.287 	|21.67%		|17.78%     |
|100	|1k		|147858.3 |0.676  |170042.6 |0.588 	|15.01%		|13.01%     |
|100	|10k	|50195.63 |1.992  |52431.73 |1.907 	|4.49%		|4.25%      |
|100	|100k	|11895.37 |8.405  |11982.83 |8.344 	|0.74%		|0.73%      |
|----------------------------------------------------------------------------
