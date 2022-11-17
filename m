Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81262D40D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbiKQH2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiKQH2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:28:16 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774942F46;
        Wed, 16 Nov 2022 23:28:14 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NCWdp6DkkzJnlm;
        Thu, 17 Nov 2022 15:25:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:27:41 +0800
Received: from [10.67.108.193] (10.67.108.193) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:27:40 +0800
Subject: Re: [PATCH] device_cgroup: Roll back to original exceptions after
 copy failure
To:     Paul Moore <paul@paul-moore.com>
CC:     <jmorris@namei.org>, <serge@hallyn.com>,
        <serge.hallyn@canonical.com>, <akpm@linux-foundation.org>,
        <aris@redhat.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        wangweiyang <wangweiyang2@huawei.com>
References: <20221025113101.41132-1-wangweiyang2@huawei.com>
 <CAHC9VhRa16htUXSN0AXrbUwadRa-qQv+UX8ZO_8W_z2eL=6trw@mail.gmail.com>
From:   wangweiyang <wangweiyang2@huawei.com>
Message-ID: <2a52eca2-a064-38da-9f6f-6f4736753067@huawei.com>
Date:   Thu, 17 Nov 2022 15:27:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRa16htUXSN0AXrbUwadRa-qQv+UX8ZO_8W_z2eL=6trw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.193]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/17 7:33, Paul Moore wrote:
> On Tue, Oct 25, 2022 at 7:02 AM Wang Weiyang <wangweiyang2@huawei.com> wrote:
>>
>> When add the 'a *:* rwm' entry to devcgroup A's whitelist, at first A's
>> exceptions will be cleaned and A's behavior is changed to
>> DEVCG_DEFAULT_ALLOW. Then parent's exceptions will be copyed to A's
>> whitelist. If copy failure occurs, just return leaving A to grant
>> permissions to all devices. And A may grant more permissions than
>> parent.
>>
>> Backup A's whitelist and recover original exceptions after copy
>> failure.
>>
>> Fixes: 4cef7299b478 ("device_cgroup: add proper checking when changing default behavior")
>> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
>> ---
>>  security/device_cgroup.c | 33 +++++++++++++++++++++++++++++----
>>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> Merged into lsm/next, but with a stable@vger tag.  Normally I would
> merge something like this into lsm/stable-X.Y and send it up to Linus
> after a few days, but I'd really like this to spend some time in
> linux-next before going up to Linus.

Thanks Paul. This sounds fine.
