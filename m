Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545AE5BF301
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiIUBms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiIUBmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:42:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4450372EEF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:42:44 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MXLhd0TlKzHpcL;
        Wed, 21 Sep 2022 09:40:33 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:42:42 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:42:41 +0800
Subject: Re: [PATCH v5 2/5] Revert "frontswap: simplify
 frontswap_register_ops"
To:     Christoph Hellwig <hch@lst.de>
References: <20220915035003.3347466-1-liushixin2@huawei.com>
 <20220915035003.3347466-3-liushixin2@huawei.com>
 <20220920121305.GA4237@lst.de>
CC:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <2b469a5c-7960-ca6a-9360-c7d3aa26e8ae@huawei.com>
Date:   Wed, 21 Sep 2022 09:42:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220920121305.GA4237@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/20 20:13, Christoph Hellwig wrote:

> On Thu, Sep 15, 2022 at 11:50:00AM +0800, Liu Shixin wrote:
>> This reverts commit f328c1d16e4c764992895ac9c9425cea861b2ca0.
>>
>> Since we are supported to delay zswap initializaton, we need to invoke
>> ops->init for the swap device which is already online when register
>> backend.
> Why do we "have" to do it.  Retroactively supporting functionality on
> previously enabled swap devices seems rather odd, and the amount of
> cruft added for it here absolutely does not seem to be worth it.
Hi Christoph,

This revert makes code complicated, but I think it's necessary. When enable zswap,
I expect it to work for all swap devices as much as possible. In this way, user can enable
zswap and swap device in any order. Since we can enable zswap on previously swap
devices, why not support it to get such benifit?

Thanks,
> .
>

