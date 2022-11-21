Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F02631CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiKUJcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKUJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:32:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19CE8FB2C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:32:13 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG2G72bZhzmW4n;
        Mon, 21 Nov 2022 17:31:43 +0800 (CST)
Received: from [10.67.109.51] (10.67.109.51) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 17:32:12 +0800
Message-ID: <902bb40e-3eb8-cee6-cd6e-849d2fd87f15@huawei.com>
Date:   Mon, 21 Nov 2022 17:32:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] ubifs: Fix build errors as symbol undefined
To:     Richard Weinberger <richard@nod.at>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        yusongping <yusongping@huawei.com>
References: <20221115083335.21211-1-hucool.lihua@huawei.com>
 <23feff35-6f2d-5cd7-57f9-ff2591a3c74e@huawei.com>
 <433070166.256175.1668893150374.JavaMail.zimbra@nod.at>
 <ed4618a5-67b4-7ee5-f172-a2709ee738fa@huawei.com>
 <540631712.260900.1669017601995.JavaMail.zimbra@nod.at>
From:   "Lihua (lihua, ran)" <hucool.lihua@huawei.com>
In-Reply-To: <540631712.260900.1669017601995.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.51]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow your suggestion, I will push a new patch，Thanks.

在 2022/11/21 16:00, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "Lihua" <hucool.lihua@huawei.com>
>> An: "richard" <richard@nod.at>
>> CC: "Sascha Hauer" <s.hauer@pengutronix.de>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
>> <linux-kernel@vger.kernel.org>, "Wei Yongjun" <weiyongjun1@huawei.com>, "yusongping" <yusongping@huawei.com>
>> Gesendet: Montag, 21. November 2022 02:54:53
>> Betreff: Re: [PATCH] ubifs: Fix build errors as symbol undefined
> 
>> You can verify it with the config in the attachment. TKS :D
> 
> Thanks for your .config, I was able to identify the problem.
> When CONFIG_CC_OPTIMIZE_FOR_SIZE is set the compiler does not optimize this construct:
> 
>          err = ubifs_node_check_hash(c, buf, zbr->hash);
>          if (err) {
>                  ubifs_bad_hash(c, buf, zbr->hash, lnum, offs);
>                  return 0;
>          }
> 
> With CONFIG_UBIFS_FS_AUTHENTICATION not set, the compiler can assume that
> ubifs_node_check_hash() is never true and drops the call to ubifs_bad_hash().
> Is CONFIG_CC_OPTIMIZE_FOR_SIZE enabled this optimization does not happen anymore.
> 
> So we need a no-op ubifs_bad_hash() for the CONFIG_UBIFS_FS_AUTHENTICATION=n case.
> 
> Thanks,
> //richard
> 
> .
> 
