Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0A656140
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiLZIq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiLZIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:45:58 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF20E639B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:45:23 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NgWV24BHczJpVL;
        Mon, 26 Dec 2022 16:41:30 +0800 (CST)
Received: from [10.67.109.54] (10.67.109.54) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 26 Dec
 2022 16:45:20 +0800
From:   Hui Tang <tanghui20@huawei.com>
Subject: [bug-report] possible performance problem in ret_to_user_from_irq
To:     Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        <tanghui20@huawei.com>
Message-ID: <7ecb8f3c-2aeb-a905-0d4a-aa768b9649b5@huawei.com>
Date:   Mon, 26 Dec 2022 16:45:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.54]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi folks.

I found a performance problem which is introduced by commit
32d59773da38 ("arm: add support for TIF_NOTIFY_SIGNAL").
After the commit,  any bit in the range of 0..15 will cause
do_work_pending() to be invoked. More frequent do_work_pending()
invoked possible result in worse performance.

Some of the tests I've done， as follows:
lmbench test			base		with patch
./lat_ctx -P 1 -s 0  2		7.3167		11.04
./lat_ctx -P 1 -s 16 2          8.0467		14.5367
./lat_ctx -P 1 -s 64 2		7.8667		11.43
./lat_ctx -P 1 -s 16 16		16.47		18.3667
./lat_pipe -P 1			28.1671		44.7904

libMicro-0.4.1 test		base		with patch
./cascade_cond -E -C 200\
  -L -S -W -N "c_cond_1" -I 100	286.3333	358

When I adjust test bit, the performance problem gone.
-	movs	r1, r1, lsl #16
+	ldr	r2, =#_TIF_WORK_MASK
+	tst	r1, r2

Does anyone have a good suggestion for this problem?
should just test _TIF_WORK_MASK, as before?
