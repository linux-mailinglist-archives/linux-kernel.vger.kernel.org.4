Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB5E740891
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjF1CpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjF1Cor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:44:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF43296D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:44:37 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QrQnc3x20zMpjM;
        Wed, 28 Jun 2023 10:41:24 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 10:44:34 +0800
Subject: Re: [PATCH] mm/ksm: delete the redundant ksm_merging_pages interafce
 in proc
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <xu.xin16@zte.com.cn>, <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230627133542.2446285-1-sunnanyong@huawei.com>
 <20230627122201.6e25819493823dfc7cca4741@linux-foundation.org>
From:   Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <000d6e0d-d4fc-abbf-5764-ab763e5dc8b2@huawei.com>
Date:   Wed, 28 Jun 2023 10:44:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20230627122201.6e25819493823dfc7cca4741@linux-foundation.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.79]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 3:22, Andrew Morton wrote:

> On Tue, 27 Jun 2023 21:35:42 +0800 Nanyong Sun <sunnanyong@huawei.com> wrote:
>
>> Since the ksm_merging_pages information already included in
>> /proc/<pid>/ksm_stat, we can delete /proc/<pid>/ksm_merging_pages to
>> make the directory more clean, and can save a little bit resources.
> Well, this is a non backward compatible change - any userspace
> which depends on ksm_merging_pages will break.
>
> Yes, we could remove this but it will be a lengthy process involving
> emitting a "please use ksm_stat instead" message for a few
> years before removal.
> .

This interface was just added last year(Apr 28 2022) in commit 7609385337a4

("ksm: count ksm merging pages for each process"), it does not have 
historical baggage.

Additionally, as stated in the commit message, this interface is mainly 
used to query the deduplication effect

of the application for the upper application optimization during the 
development phase,

so deleting it would have a very small impact.

