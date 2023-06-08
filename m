Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889847280C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbjFHNAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjFHNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:00:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674EE26B2;
        Thu,  8 Jun 2023 06:00:28 -0700 (PDT)
Received: from kwepemm600001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QcPR46RqBz25h63;
        Thu,  8 Jun 2023 20:58:40 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 21:00:23 +0800
From:   zhangmingyi <zhangmingyi5@huawei.com>
To:     <sdf@google.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <hsinweih@uci.edu>, <jakub@cloudflare.com>,
        <john.fastabend@gmail.com>, <kongweibin2@huawei.com>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuxin350@huawei.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>,
        <syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <yanan@huawei.com>,
        <zhangmingyi5@huawei.com>
Subject: Re: [PATCH] libbpf:fix use empty function pointers in ringbuf_poll
Date:   Thu, 8 Jun 2023 20:58:20 +0800
Message-ID: <20230608125820.726340-1-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ZH4a1l1pfG8ewo3v@google.com>
References: <ZH4a1l1pfG8ewo3v@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06,Stanislav Fomichev wrote:

> On 06/05, Xin Liu wrote:
> > From: zhangmingyi <zhangmingyi5@huawei.com>
> 
> > The sample_cb of the ring_buffer__new interface can transfer NULL. However,
> > the system does not check whether sample_cb is NULL during 
> > ring_buffer__poll, null pointer is used.

> What is the point of calling ring_buffer__new with sample_cb == NULL?

Yes, as you said, passing sample_cb in ring_buffer__new to NULL doesn't 
make sense, and few people use it that way, but that doesn't prevent this 
from being a allowed and supported scenario. And when ring_buffer__poll is 
called, it leads to a segmentation fault (core dump), which I think needs 
to be fixed to ensure the security quality of libbpf.
