Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E826290FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiKODy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiKODy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:54:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E52B17A9E;
        Mon, 14 Nov 2022 19:54:56 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBC3s4gblzmVtp;
        Tue, 15 Nov 2022 11:54:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 11:54:54 +0800
Received: from [10.67.108.193] (10.67.108.193) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 11:54:53 +0800
Subject: Re: [PATCH] device_cgroup: Roll back to original exceptions after
 copy failure
To:     Paul Moore <paul@paul-moore.com>
CC:     <jmorris@namei.org>, <serge@hallyn.com>,
        <serge.hallyn@canonical.com>, <akpm@linux-foundation.org>,
        <aris@redhat.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        wangweiyang <wangweiyang2@huawei.com>
References: <20221025113101.41132-1-wangweiyang2@huawei.com>
 <CAHC9VhQW9g6QTpPMHehTyfT_N5kQjeAGZjdiiUS9od+0CrmbiQ@mail.gmail.com>
From:   wangweiyang <wangweiyang2@huawei.com>
Message-ID: <7da459bc-ffb7-1b0b-dcac-5e967d836434@huawei.com>
Date:   Tue, 15 Nov 2022 11:54:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQW9g6QTpPMHehTyfT_N5kQjeAGZjdiiUS9od+0CrmbiQ@mail.gmail.com>
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

Hi, Paul
Can this patch be applied or something to improve?

Thanks

on 2022/10/28 19:19, Paul Moore wrote:
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
> On quick glance this looks reasonable to me, but I'm working with
> limited time connected to a network so I can't say I've given this a
> full and proper review; if a third party could spend some time to give
> this an additional review before I merge it I would greatly appreciate
> it.
> 
>> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
>> index a9f8c63a96d1..bef2b9285fb3 100644
>> --- a/security/device_cgroup.c
>> +++ b/security/device_cgroup.c
>> @@ -82,6 +82,17 @@ static int dev_exceptions_copy(struct list_head *dest, struct list_head *orig)
>>         return -ENOMEM;
>>  }
>>
>> +static void dev_exceptions_move(struct list_head *dest, struct list_head *orig)
>> +{
>> +       struct dev_exception_item *ex, *tmp;
>> +
>> +       lockdep_assert_held(&devcgroup_mutex);
>> +
>> +       list_for_each_entry_safe(ex, tmp, orig, list) {
>> +               list_move_tail(&ex->list, dest);
>> +       }
>> +}
>> +
>>  /*
>>   * called under devcgroup_mutex
>>   */
>> @@ -604,11 +615,13 @@ static int devcgroup_update_access(struct dev_cgroup *devcgroup,
>>         int count, rc = 0;
>>         struct dev_exception_item ex;
>>         struct dev_cgroup *parent = css_to_devcgroup(devcgroup->css.parent);
>> +       struct dev_cgroup tmp_devcgrp;
>>
>>         if (!capable(CAP_SYS_ADMIN))
>>                 return -EPERM;
>>
>>         memset(&ex, 0, sizeof(ex));
>> +       memset(&tmp_devcgrp, 0, sizeof(tmp_devcgrp));
>>         b = buffer;
>>
>>         switch (*b) {
>> @@ -620,15 +633,27 @@ static int devcgroup_update_access(struct dev_cgroup *devcgroup,
>>
>>                         if (!may_allow_all(parent))
>>                                 return -EPERM;
>> -                       dev_exception_clean(devcgroup);
>> -                       devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
>> -                       if (!parent)
>> +                       if (!parent) {
>> +                               devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
>> +                               dev_exception_clean(devcgroup);
>>                                 break;
>> +                       }
>>
>> +                       INIT_LIST_HEAD(&tmp_devcgrp.exceptions);
>> +                       rc = dev_exceptions_copy(&tmp_devcgrp.exceptions,
>> +                                                &devcgroup->exceptions);
>> +                       if (rc)
>> +                               return rc;
>> +                       dev_exception_clean(devcgroup);
>>                         rc = dev_exceptions_copy(&devcgroup->exceptions,
>>                                                  &parent->exceptions);
>> -                       if (rc)
>> +                       if (rc) {
>> +                               dev_exceptions_move(&devcgroup->exceptions,
>> +                                                   &tmp_devcgrp.exceptions);
>>                                 return rc;
>> +                       }
>> +                       devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
>> +                       dev_exception_clean(&tmp_devcgrp);
>>                         break;
>>                 case DEVCG_DENY:
>>                         if (css_has_online_children(&devcgroup->css))
>> --
>> 2.17.1
>>
> 
> 
