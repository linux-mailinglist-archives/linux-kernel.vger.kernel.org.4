Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7E7030C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbjEOO7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbjEOO7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:59:08 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE86E76;
        Mon, 15 May 2023 07:59:07 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-44f98c344d3so4523783e0c.1;
        Mon, 15 May 2023 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684162746; x=1686754746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQMGJRI+BxrDkdVmUoJRi2iznxWtLqgiSM4o7y7l7fk=;
        b=Qjv0nzecW7ogdJwXJWzVTrzbEA2WkUwfcuC7ji4UQ0wtJCk0jQe3qFQFf1sL2JGV1y
         9i9Y4AGmRrLHa0ePayuYRlpNGyDZns6sIfOkTTd1PfpV7xABICKPVbOUN0chFwioLIC0
         2U7lCWtToxgzCYbFcH0x9h8hRJuGtyPVOkRpsF77z/UX8rENvKYKhMmGT7QYILo1PuSC
         pfHQU8WdIleJ0J5YWtkdqWAXyH6UvryzVnULLGHrMyUcE/PyDoi0vwdwVPNWDzpbGM9H
         p2h/ku1xomB0NGez0QfdmVARyax42aldy5/AbCv94r+uKzt7vWsBOM7+Up65+yb9jy1q
         Hd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684162746; x=1686754746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQMGJRI+BxrDkdVmUoJRi2iznxWtLqgiSM4o7y7l7fk=;
        b=JSJHEw6sTRoQXPnFu8Mg9+sG6VXlbwuY74zg1R5hOBsdvJCqsaj6jz8oKSi4plvRw/
         5TsY37nfVSh6cGCbk+zgVvcoDr0u1h+7KNkVof2PKnf5vkBtbfuNzx7NU/ga1CCWXElp
         MDSDWusoy9PmU0C//mOQo84vN+s46+OXd4C+DFhNkQN18D3imd9ec0eeQQ1TQ4DKwIow
         m5ULdbu4cXb6JyNmc0nCshalsFEWn8HX+3S0ULJ98yRb4pQQZz39yl6XUbNIr9dg0Amk
         v6ps601ueOwcD/JtgDkZBnsCGAW+bLW0vPhLzo+8jdzs1cIefTI6ZFa864C3xDo7kgHz
         ejfA==
X-Gm-Message-State: AC+VfDxiy/d45oZqp49DWRhOUe4hXzsV0LogM3O87s7KIq1ovIkjdiWQ
        jWPYDlLC5j7nX0AfYbmd81easEbk9cNAKLM+yC8=
X-Google-Smtp-Source: ACHHUZ4TP+YajVbVBhIE6+fV+P13GfFxu+8+U8VUF+ZiSkMdMm7OJ0reDzcaWfN4kw861ld/pYjq6CiTgAObTRcS2nU=
X-Received: by 2002:a67:fd11:0:b0:434:865e:700a with SMTP id
 f17-20020a67fd11000000b00434865e700amr11303997vsr.16.1684162746488; Mon, 15
 May 2023 07:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230515133629.1974610-1-chengzhihao1@huawei.com>
 <20230515133629.1974610-2-chengzhihao1@huawei.com> <20230515-sprachen-zeltlager-6925dfbe19c1@brauner>
In-Reply-To: <20230515-sprachen-zeltlager-6925dfbe19c1@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 May 2023 17:58:55 +0300
Message-ID: <CAOQ4uxjo3rzdrjmbXr=SgJbrBf_EA-HpXH25LORo_vPY=q0jWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ovl: ovl_permission: Fix null pointer dereference
 at realinode in rcu-walk mode
To:     Christian Brauner <brauner@kernel.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 4:58=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, May 15, 2023 at 09:36:28PM +0800, Zhihao Cheng wrote:
> > Following process:
> >           P1                     P2
> >  path_lookupat
> >   link_path_walk
> >    inode_permission
> >     ovl_permission
> >       ovl_i_path_real(inode, &realpath)
> >         path->dentry =3D ovl_i_dentry_upper(inode)
> >                           drop_cache
> >                          __dentry_kill(ovl_dentry)
> >                           iput(ovl_inode)
> >                            ovl_destroy_inode(ovl_inode)
> >                             dput(oi->__upperdentry)
> >                              dentry_kill(upperdentry)
> >                               dentry_unlink_inode
> >                                upperdentry->d_inode =3D NULL
> >       realinode =3D d_inode(realpath.dentry) // return NULL
> >       inode_permission(realinode)
> >        inode->i_sb  // NULL pointer dereference
> > , will trigger an null pointer dereference at realinode:
> >   [  335.664979] BUG: kernel NULL pointer dereference,
> >                  address: 0000000000000002
> >   [  335.668032] CPU: 0 PID: 2592 Comm: ls Not tainted 6.3.0
> >   [  335.669956] RIP: 0010:inode_permission+0x33/0x2c0
> >   [  335.678939] Call Trace:
> >   [  335.679165]  <TASK>
> >   [  335.679371]  ovl_permission+0xde/0x320
> >   [  335.679723]  inode_permission+0x15e/0x2c0
> >   [  335.680090]  link_path_walk+0x115/0x550
> >   [  335.680771]  path_lookupat.isra.0+0xb2/0x200
> >   [  335.681170]  filename_lookup+0xda/0x240
> >   [  335.681922]  vfs_statx+0xa6/0x1f0
> >   [  335.682233]  vfs_fstatat+0x7b/0xb0
> >
> > Fetch a reproducer in [Link].
> >
> > Add a new helper ovl_i_path_realinode() to get realpath and real inode
> > after non-nullptr checking, use the helper to replace the current realp=
ath
> > getting logic.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217405
> > Fixes: 4b7791b2e958 ("ovl: handle idmappings in ovl_permission()")
> > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/inode.c | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> > index 541cf3717fc2..cc3ef5a6666a 100644
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -278,6 +278,26 @@ int ovl_getattr(struct mnt_idmap *idmap, const str=
uct path *path,
> >       return err;
> >  }
> >
> > +static inline int ovl_i_path_realinode(struct inode *inode,
> > +                                    struct path *realpath,
> > +                                    struct inode **realinode, int rcu)
> > +{
> > +     /* Careful in RCU walk mode */
> > +     ovl_i_path_real(inode, realpath);
> > +     if (!realpath->dentry) {
> > +             WARN_ON(!rcu);
> > +             return -ECHILD;
> > +     }
> > +
> > +     *realinode =3D d_inode(realpath->dentry);
> > +     if (!*realinode) {
> > +             WARN_ON(!rcu);
> > +             return -ECHILD;
> > +     }
> > +
> > +     return 0;
> > +}
>
> If you want to return the inode wouldn't it possibly make more sense to
> return the inode from the function directly? But not fuzzed. Maybe Amir
> has a preference. As I said, I'm even fine with the original approach.

Sorry for not reviewing v1, I was traveling, even though it is hard to use
this excuse when I was traveling with Christian who did review v1 :)

>
> static inline struct inode *ovl_i_path_realinode(struct inode *inode,
>                                                  struct path *realpath,
>                                                  int rcu)
> {
>         struct inode *realinode;
>
>         /* Careful in RCU walk mode */
>         ovl_i_path_real(inode, realpath);
>         if (!realpath->dentry) {
>                 WARN_ON(!rcu);
>                 return ERR_PTR(-ECHILD);
>         }
>
>         realinode =3D d_inode(realpath->dentry);
>         if (!realinode) {
>                 WARN_ON(!rcu);
>                 return ERR_PTR(-ECHILD);
>         }
>
>         return realinode;
> }
>

I think this helper is over engineered ;-)
The idea for a helper that returns inode is good,
but I see no reason to mix RCU walk in this helper
and don't even need a new helper (see untested patch below).

Thanks,
Amir.

---
-void ovl_i_path_real(struct inode *inode, struct path *path)
+struct inode *ovl_i_path_real(struct inode *inode, struct path *path)
 {
        struct ovl_path *lowerpath =3D ovl_lowerpath(OVL_I_E(inode));

@@ -342,6 +342,8 @@ void ovl_i_path_real(struct inode *inode, struct path *=
path)
        } else {
                path->mnt =3D ovl_upper_mnt(OVL_FS(inode->i_sb));
        }
+
+       return path->dentry ? d_inode(path->dentry) : NULL;
 }

@@ -295,8 +295,8 @@ int ovl_permission(struct mnt_idmap *idmap,
        int err;

        /* Careful in RCU walk mode */
-       ovl_i_path_real(inode, &realpath);
-       if (!realpath.dentry) {
+       realinode =3D ovl_i_path_real(inode, &realpath);
+       if (!realpath.dentry || !realinode) {
                WARN_ON(!(mask & MAY_NOT_BLOCK));
                return -ECHILD;
        }
@@ -309,7 +309,6 @@ int ovl_permission(struct mnt_idmap *idmap,

        if (err)
                return err;

-       realinode =3D d_inode(realpath.dentry);
        old_cred =3D ovl_override_creds(inode->i_sb);
