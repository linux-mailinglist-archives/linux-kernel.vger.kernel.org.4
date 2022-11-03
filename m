Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783326173E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiKCBxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKCBxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:53:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE701182E;
        Wed,  2 Nov 2022 18:53:34 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N2mxh5jCyz15MK9;
        Thu,  3 Nov 2022 09:53:28 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 09:53:32 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 09:53:31 +0800
Message-ID: <7eb86cad-16f4-7f00-c6d5-cc9496f6f99e@huawei.com>
Date:   Thu, 3 Nov 2022 09:53:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] cifs: fix use-after-free on the link name
To:     Steve French <smfrench@gmail.com>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <sfrench@samba.org>, <pc@cjr.nz>,
        <lsahlber@redhat.com>
References: <20221102061659.920334-1-chenxiaosong2@huawei.com>
 <CAH2r5mv0wahqYWOXiSdxDiUB4BTq=yRxYF8R8w_0=aJ_2-B8Zg@mail.gmail.com>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <CAH2r5mv0wahqYWOXiSdxDiUB4BTq=yRxYF8R8w_0=aJ_2-B8Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfstests generic/011 can reproduce this bug in about 10+ minutes, enable 
CONFIG_KASAN=y, my mount option is: -o mfsymlinks,vers=3.0 -o 
context=system_u:object_r:unlabeled_t:s0

在 2022/11/3 8:59, Steve French 写道:
> Looks promising. How common was the xfstest failure in your setup?
