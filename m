Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056DE704DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjEPMZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEPMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:25:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C529049F5;
        Tue, 16 May 2023 05:25:30 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QLFhP1Nslz18LWG;
        Tue, 16 May 2023 20:21:09 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 20:25:27 +0800
Subject: Re: [PATCH v2 2/2] ovl: get_acl: Fix null pointer dereference at
 realinode in rcu-walk mode
To:     Amir Goldstein <amir73il@gmail.com>
CC:     <miklos@szeredi.hu>, <brauner@kernel.org>,
        <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230515133629.1974610-1-chengzhihao1@huawei.com>
 <20230515133629.1974610-3-chengzhihao1@huawei.com>
 <CAOQ4uxj-j-ugHrvvfS+XF=rzE3NH_NaZgf4_rWBxvaGYO3iN-w@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <1f11e2f3-bdf8-553c-82fa-b24619e28e73@huawei.com>
Date:   Tue, 16 May 2023 20:25:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxj-j-ugHrvvfS+XF=rzE3NH_NaZgf4_rWBxvaGYO3iN-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/5/16 19:40, Amir Goldstein 写道:
> On Mon, May 15, 2023 at 4:39 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>
>> Following process:
>>           P1                     P2
>>   path_openat
>>    link_path_walk
>>     may_lookup
>>      inode_permission(rcu)
>>       ovl_permission
>>        acl_permission_check
>>         check_acl
>>          get_cached_acl_rcu
>>           ovl_get_inode_acl
>>            realinode = ovl_inode_real(ovl_inode)
>>                                drop_cache
>>                                 __dentry_kill(ovl_dentry)
>>                                  iput(ovl_inode)
>>                                   ovl_destroy_inode(ovl_inode)
>>                                    dput(oi->__upperdentry)
>>                                     dentry_kill(upperdentry)
>>                                      dentry_unlink_inode
>>                                       upperdentry->d_inode = NULL
>>              ovl_inode_upper
>>               upperdentry = ovl_i_dentry_upper(ovl_inode)
>>               d_inode(upperdentry) // returns NULL
>>            IS_POSIXACL(realinode) // NULL pointer dereference
>> , will trigger an null pointer dereference at realinode:
>>    [  205.472797] BUG: kernel NULL pointer dereference, address:
>>                   0000000000000028
>>    [  205.476701] CPU: 2 PID: 2713 Comm: ls Not tainted
>>                   6.3.0-12064-g2edfa098e750-dirty #1216
>>    [  205.478754] RIP: 0010:do_ovl_get_acl+0x5d/0x300
>>    [  205.489584] Call Trace:
>>    [  205.489812]  <TASK>
>>    [  205.490014]  ovl_get_inode_acl+0x26/0x30
>>    [  205.490466]  get_cached_acl_rcu+0x61/0xa0
>>    [  205.490908]  generic_permission+0x1bf/0x4e0
>>    [  205.491447]  ovl_permission+0x79/0x1b0
>>    [  205.491917]  inode_permission+0x15e/0x2c0
>>    [  205.492425]  link_path_walk+0x115/0x550
>>    [  205.493311]  path_lookupat.isra.0+0xb2/0x200
>>    [  205.493803]  filename_lookup+0xda/0x240
>>    [  205.495747]  vfs_fstatat+0x7b/0xb0
>>
>> Fetch a reproducer in [Link].
>>
>> Fix it by using helper ovl_i_path_realinode() to get realpath and real
>> inode after non-nullptr checking.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217404
>> Fixes: 332f606b32b6 ("ovl: enable RCU'd ->get_acl()")
> 
> Note that this bug is also in 5.15.y, in method ovl_get_acl().
> I hope you will be able to follow up with a simple backport for 5.15 -
> i.e. only need to add a check for NULL realinode at the beginning.
> There was no realpath back then.
> 

Sure. I notice that there is a '[ Upstream commit xxx ]' field in 5.15 
patch, so may I backport it after the fix applied into mainline(6.4)?

> AFAICT, both your patches should apply cleanly to 6.1.y, so should
> be picked up automatically by stable kernel bots.
> 
> Thanks,
> Amir.
> 
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Suggested-by: Christian Brauner <brauner@kernel.org>
>> ---
>>   fs/overlayfs/inode.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
>> index cc3ef5a6666a..b2021eada8be 100644
>> --- a/fs/overlayfs/inode.c
>> +++ b/fs/overlayfs/inode.c
>> @@ -576,20 +576,18 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
>>                                   struct inode *inode, int type,
>>                                   bool rcu, bool noperm)
>>   {
>> -       struct inode *realinode = ovl_inode_real(inode);
>> +       struct inode *realinode;
>>          struct posix_acl *acl;
>>          struct path realpath;
>> +       int err;
>> +
>> +       err = ovl_i_path_realinode(inode, &realpath, &realinode, rcu);
>> +       if (err)
>> +               return ERR_PTR(err);
>>
>>          if (!IS_POSIXACL(realinode))
>>                  return NULL;
>>
>> -       /* Careful in RCU walk mode */
>> -       ovl_i_path_real(inode, &realpath);
>> -       if (!realpath.dentry) {
>> -               WARN_ON(!rcu);
>> -               return ERR_PTR(-ECHILD);
>> -       }
>> -
>>          if (rcu) {
>>                  /*
>>                   * If the layer is idmapped drop out of RCU path walk
>> --
>> 2.39.2
>>
> .
> 

