Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF1655838
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 04:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiLXD0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 22:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiLXD0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 22:26:32 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE96B7FF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 19:26:31 -0800 (PST)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nf8W43F5zzJpS0;
        Sat, 24 Dec 2022 11:22:40 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 24 Dec 2022 11:26:28 +0800
Subject: Re: [PATCH] virtio_balloon: high order allocation
To:     Soichiro Ueda <the.latticeheart@gmail.com>, <mst@redhat.com>,
        <david@redhat.com>, <jasowang@redhat.com>,
        <akpm@linux-foundation.org>
References: <20221223093527.12424-1-the.latticeheart@gmail.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kalutes@google.com>, <mhiramat@kernel.org>, <cwd@google.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <3fabf076-0fd8-2ad2-52e7-3c2913308156@huawei.com>
Date:   Sat, 24 Dec 2022 11:26:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221223093527.12424-1-the.latticeheart@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Soichiro:

I'm interested with your patch. I'm looking at it and found some possible issues.


On 2022/12/23 17:35, Soichiro Ueda wrote:
> +			for (i = 0; i < num_pfns; i++) {
> +				set_page_pfns(vb, vb->pfns + vb->num_pfns + i,
> +					      nth_page(page, i));
> +			}
Since the interval of vb->num_pfns is VIRTIO_BALLOON_PAGES_PER_PAGE,
it seems that the pfns[] should be vb->pfns + vb->num_pfns + i * VIRTIO_BALLOON_PAGES_PER_PAGE.
> +			vb->num_pages +=
> +				num_pfns * VIRTIO_BALLOON_PAGES_PER_PAGE;
> +			if (!virtio_has_feature(
> +				    vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +				adjust_managed_page_count(page, -num_pfns);
num_pfns is of the unsigned int type so need be to converted to long manually.

root@syzkaller:~# free -m
              total        used        free      shared  buff/cache   available
Mem:           1975          78        1822           2          74        1869
Swap:             0           0           0
root@syzkaller:~# QEMU 7.2.0 monitor - type 'help' for more information
(qemu) info balloon
balloon: actual=2048
(qemu) balloon 2046
(qemu)

root@syzkaller:~# free -m
              total        used        free      shared  buff/cache   available
Mem:       33556405    33554510        1819           2          74        1867
Swap:             0           0           0
> +
> +		num_pfns = (1 << order);
> +		for (i = 0; i < num_pfns; i++)
> +			set_page_pfns(vb, vb->pfns + vb->num_pfns + i, nth_page(page, i));
The same problem mentioned above.


thanks,

Liu Shixin

.
