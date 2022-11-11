Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1B625532
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiKKI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiKKI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:27:08 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC529F58
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:27:05 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N7sDc3dqBzJnZw;
        Fri, 11 Nov 2022 16:24:00 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 16:27:03 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 16:27:03 +0800
Subject: Re: [PATCH] kobject: hide illegible sysfs warning of kobject_del()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221111065807.3278713-1-liushixin2@huawei.com>
 <Y23rC0N1cL2LQpyF@kroah.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <d89eb156-3db2-df72-d21c-357baba3d377@huawei.com>
Date:   Fri, 11 Nov 2022 16:27:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y23rC0N1cL2LQpyF@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/11 14:26, Greg Kroah-Hartman wrote:
> On Fri, Nov 11, 2022 at 02:58:07PM +0800, Liu Shixin wrote:
>> Some consumers do not care whether kobject_add() succeed or failed such as
>> irqdesc. They call kobject_del() all the time even if kobject_add() failed.
>> Then kernel will report some illegible sysfs warning like this:
>>
>>  kernfs: can not remove 'actions', no directory
>>  WARNING: CPU: 0 PID: 277 at fs/kernfs/dir.c:1615 kernfs_remove_by_name_ns+0xd5/0xe0
> Why not fix the caller here?  Is that somehow not possible?
The caller should be freed by kobject_put() if kobject_add() failed. But in fact, the failure does not affect
the function of the caller. So the caller do not call kobject_put() Immediately.
If want to fix the caller, we can check konj->state_in_sysfs before call kobject_del(). This way has no difference
with check kobj->state_in_sysfs in kobject_del().
By the way, I'm not sure how many callers have this problem. So I think it's better to fix in kobject_del().

thanks,

>
> thanks,
>
> greg k-h
> .
>

