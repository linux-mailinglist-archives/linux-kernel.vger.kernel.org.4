Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8726C6C878F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCXVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCXVje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:39:34 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B72736
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:39:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5447d217bc6so56941317b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679693969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKamTvnj+GL3ffTUBrTph5LM8KntsQaWHlQekMeTL9k=;
        b=f2sVjRn30AUSzqj/0co6DjfsWFab0eiB0J81pqIG/Z714o6YMlzvv+6uMym/AhN1ck
         wa6uyFjQ1JUpDkwFCgUFRmtPMbfu35NKnp7YVKuZraGD96RHphHISVGtr/onjWrChI+d
         05XyOJMH8yfPjpOQ5rThMNLHfZZsOS4+y80UBOvKL1WwjrBb4YGYrgEYwcowRv0Hh45v
         77tGQnrq/rB3/DUsAMvz7JZW11BdxhPzJdpQW+H2dfeCDYjWGAneYq5gM3m1gMXjmuDD
         IZkvSEfWpro3PS55S87WA1tvgEqmSU2aBAlZb5HiomonxnwigG+ROSnYzhOcmB5VxSlt
         fu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKamTvnj+GL3ffTUBrTph5LM8KntsQaWHlQekMeTL9k=;
        b=ShOL9txw/sQ5TTYZdcMRnOjDDcKT7x372lk861ML1fHI/LYgXXva7gE3r3eak6gSKv
         hnrErp2uTHGJIyNdCmGKGKDFstGBGlKaQpTei+m1GPt7pbuozhrNcU1rvQ0HK4+fTkbb
         X0Ui+9K0KboAL6r1spZ/dStKe/O4uaVR7X5tWLCjk2VOIaVcjSrAhRH4ls4hK8+Ju1tQ
         rJ9d+b+QMdprjp3Rpcv2LAmrPR2TmJodmjWwyjXeSXN9i6z13BfPUb1/z3fmDHsDNVqs
         GpjH2hzszagxNtfYKlEcOqUhSX2e0vDESlAKcwQT6QdJeHTnVG3p7wstXG6mtvZCb+SF
         RJXQ==
X-Gm-Message-State: AAQBX9dstyaujmWyKaW0YKCfoVNkAMQtPu6Hd6xWZI59pt5FusIpDV5B
        zgPtxZizMAKciBFz/0aOcQhX7djWh37Tbs73iLQS
X-Google-Smtp-Source: AKy350bsRKBP7uMR4F9gyjDuDEVJX4b81kaP6g857n9d964/HtlKQpjkiWIs0G73sRgUkkDNXxLVvj5qN6ETjoWdJDk=
X-Received: by 2002:a81:af18:0:b0:541:7f7b:a2ff with SMTP id
 n24-20020a81af18000000b005417f7ba2ffmr1741459ywh.8.1679693969542; Fri, 24 Mar
 2023 14:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com>
 <20230314081720.4158676-5-roberto.sassu@huaweicloud.com> <CAHC9VhTD3EyDiJs9+NQrgp84JcUs_sx8WONtRk2YYH4m1C8nVw@mail.gmail.com>
 <939e6c88662ad90b963993c4cc1b702083e74a7a.camel@huaweicloud.com> <ffc86b3907f7b87d3c568ae62bea3cdb3275be4e.camel@huaweicloud.com>
In-Reply-To: <ffc86b3907f7b87d3c568ae62bea3cdb3275be4e.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Mar 2023 17:39:18 -0400
Message-ID: <CAHC9VhRNjvjMOF5KLM6BoGfk=QpEBs_ur_CgRdGL5R1bA-JAwg@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 9:26=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Fri, 2023-03-24 at 11:18 +0100, Roberto Sassu wrote:
> > On Thu, 2023-03-23 at 20:09 -0400, Paul Moore wrote:
> > > On Tue, Mar 14, 2023 at 4:19=E2=80=AFAM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >
> > > > Currently, security_inode_init_security() supports only one LSM pro=
viding
> > > > an xattr and EVM calculating the HMAC on that xattr, plus other ino=
de
> > > > metadata.
> > > >
> > > > Allow all LSMs to provide one or multiple xattrs, by extending the =
security
> > > > blob reservation mechanism. Introduce the new lbs_xattr field of th=
e
> > > > lsm_blob_sizes structure, so that each LSM can specify how many xat=
trs it
> > > > needs, and the LSM infrastructure knows how many xattr slots it sho=
uld
> > > > allocate.
> > > >
> > > > Dynamically allocate the xattrs array to be populated by LSMs with =
the
> > > > inode_init_security hook, and pass it to the latter instead of the
> > > > name/value/len triple. Update the documentation accordingly, and fi=
x the
> > > > description of the xattr name, as it is not allocated anymore.
> > > >
> > > > Since the LSM infrastructure, at initialization time, updates the n=
umber of
> > > > the requested xattrs provided by each LSM with a corresponding offs=
et in
> > > > the security blob (in this case the xattr array), it makes straight=
forward
> > > > for an LSM to access the right position in the xattr array.
> > > >
> > > > There is still the issue that an LSM might not fill the xattr, even=
 if it
> > > > requests it (legitimate case, for example it might have been loaded=
 but not
> > > > initialized with a policy). Since users of the xattr array (e.g. th=
e
> > > > initxattrs() callbacks) detect the end of the xattr array by checki=
ng if
> > > > the xattr name is NULL, not filling an xattr would cause those user=
s to
> > > > stop scanning xattrs prematurely.
> > > >
> > > > Solve that issue by introducing security_check_compact_filled_xattr=
s(),
> > > > which does a basic check of the xattr array (if the xattr name is f=
illed,
> > > > the xattr value should be too, and viceversa), and compacts the xat=
tr array
> > > > by removing the holes.
> > > >
> > > > An alternative solution would be to let users of the xattr array kn=
ow the
> > > > number of elements of that array, so that they don't have to check =
the
> > > > termination. However, this seems more invasive, compared to a simpl=
e move
> > > > of few array elements.
> > > >
> > > > security_check_compact_filled_xattrs() also determines how many xat=
trs in
> > > > the xattr array have been filled. If there is none, skip
> > > > evm_inode_init_security() and initxattrs(). Skipping the former als=
o avoids
> > > > EVM to crash the kernel, as it is expecting a filled xattr.
> > > >
> > > > Finally, adapt both SELinux and Smack to use the new definition of =
the
> > > > inode_init_security hook, and to correctly fill the designated slot=
s in the
> > > > xattr array. For Smack, reserve space for the other defined xattrs =
although
> > > > they are not set yet in smack_inode_init_security().
> > > >
> > > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM=
 crash)
> > > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@arch=
linux/
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |   3 +-
> > > >  include/linux/lsm_hooks.h     |   1 +
> > > >  security/security.c           | 119 +++++++++++++++++++++++++++++-=
----
> > > >  security/selinux/hooks.c      |  19 ++++--
> > > >  security/smack/smack_lsm.c    |  33 ++++++----
> > > >  5 files changed, 137 insertions(+), 38 deletions(-)

...

> > > > @@ -1604,33 +1654,66 @@ int security_inode_init_security(struct ino=
de *inode, struct inode *dir,
> > > >                                  const struct qstr *qstr,
> > > >                                  const initxattrs initxattrs, void =
*fs_data)
> > > >  {
> > > > -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> > > > -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > > > -       int ret;
> > > > +       struct security_hook_list *P;
> > > > +       struct xattr *new_xattrs;
> > > > +       struct xattr *xattr;
> > > > +       int ret =3D -EOPNOTSUPP, num_filled_xattrs =3D 0;
> > > >
> > > >         if (unlikely(IS_PRIVATE(inode)))
> > > >                 return 0;
> > > >
> > > > +       if (!blob_sizes.lbs_xattr)
> > > > +               return 0;
> > > > +
> > > >         if (!initxattrs)
> > > >                 return call_int_hook(inode_init_security, -EOPNOTSU=
PP, inode,
> > > > -                                    dir, qstr, NULL, NULL, NULL);
> > > > -       memset(new_xattrs, 0, sizeof(new_xattrs));
> > > > -       lsm_xattr =3D new_xattrs;
> > > > -       ret =3D call_int_hook(inode_init_security, -EOPNOTSUPP, ino=
de, dir, qstr,
> > > > -                           &lsm_xattr->name,
> > > > -                           &lsm_xattr->value,
> > > > -                           &lsm_xattr->value_len);
> > > > -       if (ret)
> > > > +                                   dir, qstr, NULL);
> > > > +       /* Allocate +1 for EVM and +1 as terminator. */
> > > > +       new_xattrs =3D kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*ne=
w_xattrs),
> > > > +                            GFP_NOFS);
> > > > +       if (!new_xattrs)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       hlist_for_each_entry(P, &security_hook_heads.inode_init_sec=
urity,
> > > > +                            list) {
> > > > +               ret =3D P->hook.inode_init_security(inode, dir, qst=
r, new_xattrs);
> > > > +               if (ret && ret !=3D -EOPNOTSUPP)
> > > > +                       goto out;
> > > > +               /*
> > > > +                * As documented in lsm_hooks.h, -EOPNOTSUPP in thi=
s context
> > > > +                * means that the LSM is not willing to provide an =
xattr, not
> > > > +                * that it wants to signal an error. Thus, continue=
 to invoke
> > > > +                * the remaining LSMs.
> > > > +                */
> > > > +               if (ret =3D=3D -EOPNOTSUPP)
> > > > +                       continue;
> > > > +               /*
> > > > +                * As the number of xattrs reserved by LSMs is not =
directly
> > > > +                * available, directly use the total number blob_si=
zes.lbs_xattr
> > > > +                * to keep the code simple, while being not the mos=
t efficient
> > > > +                * way.
> > > > +                */
> > >
> > > Is there a good reason why the LSM can't return the number of xattrs
> > > it is adding to the xattr array?  It seems like it should be fairly
> > > trivial for the individual LSMs to determine and it could save a lot
> > > of work.  However, given we're at v8 on this patchset I'm sure I'm
> > > missing something obvious, can you help me understand why the idea
> > > above is crazy stupid? ;)
>
> Much simple answer. Yes, LSMs could return the number of xattrs set,
> but security_check_compact_filled_xattrs() also needs to know from
> which offset (the lbs_xattr of each LSM) it should start compacting.
>
> Example: suppose that you have three LSMs with:
>
> LSM#1: lbs_xattr 1
> LSM#2: lbs_xattr 2 (disabled)
> LSM#3: lbs_xattr 1
>
> The current compaction interval is: already compacted xattrs - end of
> new_xattr array.
>
> When the security_inode_init_security() loop calls LSM#3, the
> compaction interval is: 1 - 2 (LSM#2 returns 0), which clearly isn't
> right. The correct compaction interval should be: 3 - 4.
>
> Going to the end of new_xattrs is an approximation, but it ensures
> that security_check_compact_filled_xattrs() reaches the xattr set by
> LSM#3.
>
> The alternative I was mentioning of passing num_filled_xattrs to LSMs
> goes again in the direction of doing on-the-fly compaction, while LSMs
> are more familiar with using the lbs_* fields.

I guess I was thinking of the case where the LSM layer, i.e.
security_inode_init_security(), allocates an xattr array like it does
now based on the maximum number of xattrs possible using the
lsm_blob_sizes values and passes a pointer to the individual LSMs
which is incremented based on how many xattrs are created by the
individual LSMs.  Here is some *very* rough pseudo code:

int security_inode_init_security(...)
{

  /* allocate an xattr array */
  xattrs =3D kcalloc(blob_sizes, sizeof(*xattrs), GFP_BLAH);

  /* loop on the lsms */
  xa_cnt =3D 0;
  while (lsm_hooks) {
    rc =3D call_hook(lsm_hook, &xattrs[xa_cnt]);
    if (rc > 0)
      xa_cnt +=3D rc;
  }

  /* evm magic */
  evm_inode_init_security(...)
}

Does that work?  Am I missing something?

--=20
paul-moore.com
