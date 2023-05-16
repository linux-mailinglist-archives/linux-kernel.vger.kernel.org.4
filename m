Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2F704DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjEPM1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEPM1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:27:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A586B5BBC;
        Tue, 16 May 2023 05:27:41 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QLFkv68blzqSJ4;
        Tue, 16 May 2023 20:23:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 20:27:38 +0800
Subject: Re: [PATCH v2 1/2] ovl: ovl_permission: Fix null pointer dereference
 at realinode in rcu-walk mode
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Christian Brauner <brauner@kernel.org>, <miklos@szeredi.hu>,
        <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230515133629.1974610-1-chengzhihao1@huawei.com>
 <20230515133629.1974610-2-chengzhihao1@huawei.com>
 <20230515-sprachen-zeltlager-6925dfbe19c1@brauner>
 <CAOQ4uxjo3rzdrjmbXr=SgJbrBf_EA-HpXH25LORo_vPY=q0jWQ@mail.gmail.com>
 <20230515-dulden-symmetrie-3b5d934478d4@brauner>
 <CAOQ4uxjageSA8G1UR=9KPCYm80=GFLrwVonEotjOf0tpZDBY+g@mail.gmail.com>
 <53e81e0a-a99c-9a2a-7691-04789e2a2710@huawei.com>
 <CAOQ4uxi9bhs0xKO-zCj-QiFzd-xZEp8DtG222vG-R6U5HBHcVg@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <06361c3e-9f78-6f44-9cd0-e39e1eb9c546@huawei.com>
Date:   Tue, 16 May 2023 20:27:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxi9bhs0xKO-zCj-QiFzd-xZEp8DtG222vG-R6U5HBHcVg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/5/16 19:45, Amir Goldstein 写道:
> On Tue, May 16, 2023 at 4:16 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>
>> 在 2023/5/15 23:36, Amir Goldstein 写道:
>>> On Mon, May 15, 2023 at 6:16 PM Christian Brauner <brauner@kernel.org> wrote:
>>>>
>>>> On Mon, May 15, 2023 at 05:58:55PM +0300, Amir Goldstein wrote:
>>>>> On Mon, May 15, 2023 at 4:58 PM Christian Brauner <brauner@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, May 15, 2023 at 09:36:28PM +0800, Zhihao Cheng wrote:
>>>>>>> Following process:
>>>>>>>             P1                     P2
>>>>>>>    path_lookupat
>>>>>>>     link_path_walk
>>>>>>>      inode_permission
>>>>>>>       ovl_permission
>>>>>>>         ovl_i_path_real(inode, &realpath)
>>>>>>>           path->dentry = ovl_i_dentry_upper(inode)
>>>>>>>                             drop_cache
>>>>>>>                            __dentry_kill(ovl_dentry)
>>>>>>>                             iput(ovl_inode)
>>>>>>>                              ovl_destroy_inode(ovl_inode)
>>>>>>>                               dput(oi->__upperdentry)
>>>>>>>                                dentry_kill(upperdentry)
>>>>>>>                                 dentry_unlink_inode
>>>>>>>                                  upperdentry->d_inode = NULL
>>>>>>>         realinode = d_inode(realpath.dentry) // return NULL
>>>>>>>         inode_permission(realinode)
>>>>>>>          inode->i_sb  // NULL pointer dereference
>>>>>>> , will trigger an null pointer dereference at realinode:
>>>>>>>     [  335.664979] BUG: kernel NULL pointer dereference,
>>>>>>>                    address: 0000000000000002
>>>>>>>     [  335.668032] CPU: 0 PID: 2592 Comm: ls Not tainted 6.3.0
>>>>>>>     [  335.669956] RIP: 0010:inode_permission+0x33/0x2c0
>>>>>>>     [  335.678939] Call Trace:
>>>>>>>     [  335.679165]  <TASK>
>>>>>>>     [  335.679371]  ovl_permission+0xde/0x320
>>>>>>>     [  335.679723]  inode_permission+0x15e/0x2c0
>>>>>>>     [  335.680090]  link_path_walk+0x115/0x550
>>>>>>>     [  335.680771]  path_lookupat.isra.0+0xb2/0x200
>>>>>>>     [  335.681170]  filename_lookup+0xda/0x240
>>>>>>>     [  335.681922]  vfs_statx+0xa6/0x1f0
>>>>>>>     [  335.682233]  vfs_fstatat+0x7b/0xb0
>>>>>>>
>>>>>>> Fetch a reproducer in [Link].
>>>>>>>
>>>>>>> Add a new helper ovl_i_path_realinode() to get realpath and real inode
>>>>>>> after non-nullptr checking, use the helper to replace the current realpath
>>>>>>> getting logic.
>>>>>>>
>>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217405
>>>>>>> Fixes: 4b7791b2e958 ("ovl: handle idmappings in ovl_permission()")
>>>>>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>>>>>>> Suggested-by: Christian Brauner <brauner@kernel.org>
>>>>>>> ---
>>>>>>>    fs/overlayfs/inode.c | 31 ++++++++++++++++++++++++-------
>>>>>>>    1 file changed, 24 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
>>>>>>> index 541cf3717fc2..cc3ef5a6666a 100644
>>>>>>> --- a/fs/overlayfs/inode.c
>>>>>>> +++ b/fs/overlayfs/inode.c
>>>>>>> @@ -278,6 +278,26 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
>>>>>>>         return err;
>>>>>>>    }
>>>>>>>
>>>>>>> +static inline int ovl_i_path_realinode(struct inode *inode,
>>>>>>> +                                    struct path *realpath,
>>>>>>> +                                    struct inode **realinode, int rcu)
>>>>>>> +{
>>>>>>> +     /* Careful in RCU walk mode */
>>>>>>> +     ovl_i_path_real(inode, realpath);
>>>>>>> +     if (!realpath->dentry) {
>>>>>>> +             WARN_ON(!rcu);
>>>>>>> +             return -ECHILD;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     *realinode = d_inode(realpath->dentry);
>>>>>>> +     if (!*realinode) {
>>>>>>> +             WARN_ON(!rcu);
>>>>>>> +             return -ECHILD;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>
>>>>>> If you want to return the inode wouldn't it possibly make more sense to
>>>>>> return the inode from the function directly? But not fuzzed. Maybe Amir
>>>>>> has a preference. As I said, I'm even fine with the original approach.
>>>>>
>>>>> Sorry for not reviewing v1, I was traveling, even though it is hard to use
>>>>> this excuse when I was traveling with Christian who did review v1 :)
>>>>
>>>> Well, I did only do it this morning. :)
>>>>
>>>>>
>>>>>>
>>>>>> static inline struct inode *ovl_i_path_realinode(struct inode *inode,
>>>>>>                                                    struct path *realpath,
>>>>>>                                                    int rcu)
>>>>>> {
>>>>>>           struct inode *realinode;
>>>>>>
>>>>>>           /* Careful in RCU walk mode */
>>>>>>           ovl_i_path_real(inode, realpath);
>>>>>>           if (!realpath->dentry) {
>>>>>>                   WARN_ON(!rcu);
>>>>>>                   return ERR_PTR(-ECHILD);
>>>>>>           }
>>>>>>
>>>>>>           realinode = d_inode(realpath->dentry);
>>>>>>           if (!realinode) {
>>>>>>                   WARN_ON(!rcu);
>>>>>>                   return ERR_PTR(-ECHILD);
>>>>>>           }
>>>>>>
>>>>>>           return realinode;
>>>>>> }
>>>>>>
>>>>>
>>>>> I think this helper is over engineered ;-)
>>>>
>>>> Yes. As mentioned before, I would've been happy even with v1 that didn't
>>>> have any helper.
>>>>
>>>>> The idea for a helper that returns inode is good,
>>>>> but I see no reason to mix RCU walk in this helper
>>>>> and don't even need a new helper (see untested patch below).
>>>>
>>>> Looks good to me too.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Amir.
>>>>>
>>>>> ---
>>>>> -void ovl_i_path_real(struct inode *inode, struct path *path)
>>>>> +struct inode *ovl_i_path_real(struct inode *inode, struct path *path)
>>>>>    {
>>>>>           struct ovl_path *lowerpath = ovl_lowerpath(OVL_I_E(inode));
>>>>>
>>>>> @@ -342,6 +342,8 @@ void ovl_i_path_real(struct inode *inode, struct path *path)
>>>>>           } else {
>>>>>                   path->mnt = ovl_upper_mnt(OVL_FS(inode->i_sb));
>>>>>           }
>>>>> +
>>>>> +       return path->dentry ? d_inode(path->dentry) : NULL;
>>>>>    }
>>>>>
>>>>> @@ -295,8 +295,8 @@ int ovl_permission(struct mnt_idmap *idmap,
>>>>>           int err;
>>>>>
>>>>>           /* Careful in RCU walk mode */
>>>>> -       ovl_i_path_real(inode, &realpath);
>>>>> -       if (!realpath.dentry) {
>>>>> +       realinode = ovl_i_path_real(inode, &realpath);
>>>>> +       if (!realpath.dentry || !realinode) {
>>>>>                   WARN_ON(!(mask & MAY_NOT_BLOCK));
>>>>>                   return -ECHILD;
>>>>>           }
>>>>> @@ -309,7 +309,6 @@ int ovl_permission(struct mnt_idmap *idmap,
>>>>>
>>>>>           if (err)
>>>>>                   return err;
>>>>>
>>>>> -       realinode = d_inode(realpath.dentry);
>>>>>           old_cred = ovl_override_creds(inode->i_sb);
>>>>
>>
>> Thanks for reviewings and helpful discussion from Amir and Christian.
>>
> 
> You're welcome.
> 
> Note to self: there is be a trivial conflict with the change to
> ovl_i_path_real()
> return type and this patch from my ovl-lazy-lowerdata series:
> https://lore.kernel.org/linux-unionfs/20230427130539.2798797-7-amir73il@gmail.com/
> 
> After Miklos takes your fixes, I will rebase.

Thanks for rebasing, so you will take v2 with modified helper 
ovl_i_path_real(return realinode)?

> 
> Thanks,
> Amir.
> .
> 

