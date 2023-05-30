Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E66716253
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjE3NmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjE3NmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:42:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA4C8E;
        Tue, 30 May 2023 06:42:22 -0700 (PDT)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QVtn11r9yzsSfJ;
        Tue, 30 May 2023 21:40:05 +0800 (CST)
Received: from [10.174.178.159] (10.174.178.159) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 21:42:18 +0800
Message-ID: <867dcc0a-c807-2851-e2c4-750a7646a97f@huawei.com>
Date:   Tue, 30 May 2023 21:42:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH -next v2] block: Fix the partition start may overflow in
 add_partition()
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
References: <20230525072041.3701176-1-zhongjinghua@huawei.com>
 <20230526053557.GA875@sol.localdomain>
From:   zhongjinghua <zhongjinghua@huawei.com>
In-Reply-To: <20230526053557.GA875@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.159]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/26 13:35, Eric Biggers 写道:
> On Thu, May 25, 2023 at 03:20:41PM +0800, Zhong Jinghua wrote:
>> +	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
>> +		return -EINVAL;
> Were zero-length partitions allowed before?
Before this patch,  the io to the zero-length partition failed, I think 
it is meaningless, and it was fixed by the way
> - Eric
