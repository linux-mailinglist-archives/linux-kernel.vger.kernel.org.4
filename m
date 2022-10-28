Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25162610F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJ1LUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJ1LUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:20:12 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B23474F2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:20:11 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id g130so5766665oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YDLELMW9bQB+oUEfSf8eu3TecKtyIw9GNRZbjMP6p+E=;
        b=pl+N3a9dTvEeFm0Z5WrtpZ8lNEfZgFLa9AkHwkfxim/UYcS6JMdse1fS6ZtRm6t9EM
         lYSJ6ASXkAqdphtRb6NtqZ5bdIkxCtHsyBH4t38HH63MtdaTm5GARiHT3BebsjMnXCjX
         ZpEtc4VKBK3NPrJh0Fd6txmZdPuwTleHs/T6EeVP7Ml3Bb60bhsV+nCyF0sYwKhBMaPa
         Z8jTt6kCMiNoCgpuy2+FJDJM7nAeiRhxBfPfFpQEFcOr/fGrclbo9aPF4Mrny+xuwdwX
         PBu35xBOFxSa4N438miuaJxrxOU49xMVQQadfZAZmOp9a+pl/frBQgiyNu01bSdamAWA
         IEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDLELMW9bQB+oUEfSf8eu3TecKtyIw9GNRZbjMP6p+E=;
        b=K0Ao5GqZqbfMElQzI9eGH/a8s8sD9Vz7OdwYEKFiZAyXBCgIGZ9NJHL8gY7ZtsGl4C
         qEUaQPh0++yIYpMuwItsEYadHf57PTSPHytDehtkkOwvkPi3boNLYUZeb6Nos9sY7SIx
         lIdlg01+NleXEwYyCi2W+zxCRgkHKgwtf+SYhFW7MaNaLT5vvZLFMYXDlSgGCVMED5mJ
         eG/5/UuJkuX45icp0IR3WweCeqSRECH2R+OuFZXrZN5LUNBoeQM6uYmeDNzJqailhjen
         mHjBEvHy90m1AYWN42NGGvFwdzSAXuSpONMRHABorGr7D7997tqEOVYToEatkAygVsZm
         aQtA==
X-Gm-Message-State: ACrzQf3S/h+Ft/2LUPJJ5EQYc14hsFy8fXJiYKw445W2uJozjnCIT1dE
        G1gCQND0BENGuf5I0YM15Jcm0IlKaESZ/XqDeEtr5SBWTQfF
X-Google-Smtp-Source: AMsMyM5qkynGjH4z/XncLUJo7KmF90DM2QQEFiZAw469Wk3g+DCl14S5t8y2cZG85cvxT26yVuiyltesGWc6PRJKWVw=
X-Received: by 2002:a05:6808:10d4:b0:359:c147:7afe with SMTP id
 s20-20020a05680810d400b00359c1477afemr4074675ois.172.1666956010584; Fri, 28
 Oct 2022 04:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221025113101.41132-1-wangweiyang2@huawei.com>
In-Reply-To: <20221025113101.41132-1-wangweiyang2@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Oct 2022 07:19:59 -0400
Message-ID: <CAHC9VhQW9g6QTpPMHehTyfT_N5kQjeAGZjdiiUS9od+0CrmbiQ@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: Roll back to original exceptions after
 copy failure
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com, serge.hallyn@canonical.com,
        akpm@linux-foundation.org, aris@redhat.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 7:02 AM Wang Weiyang <wangweiyang2@huawei.com> wrote:
>
> When add the 'a *:* rwm' entry to devcgroup A's whitelist, at first A's
> exceptions will be cleaned and A's behavior is changed to
> DEVCG_DEFAULT_ALLOW. Then parent's exceptions will be copyed to A's
> whitelist. If copy failure occurs, just return leaving A to grant
> permissions to all devices. And A may grant more permissions than
> parent.
>
> Backup A's whitelist and recover original exceptions after copy
> failure.
>
> Fixes: 4cef7299b478 ("device_cgroup: add proper checking when changing default behavior")
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
> ---
>  security/device_cgroup.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)

On quick glance this looks reasonable to me, but I'm working with
limited time connected to a network so I can't say I've given this a
full and proper review; if a third party could spend some time to give
this an additional review before I merge it I would greatly appreciate
it.

> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index a9f8c63a96d1..bef2b9285fb3 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -82,6 +82,17 @@ static int dev_exceptions_copy(struct list_head *dest, struct list_head *orig)
>         return -ENOMEM;
>  }
>
> +static void dev_exceptions_move(struct list_head *dest, struct list_head *orig)
> +{
> +       struct dev_exception_item *ex, *tmp;
> +
> +       lockdep_assert_held(&devcgroup_mutex);
> +
> +       list_for_each_entry_safe(ex, tmp, orig, list) {
> +               list_move_tail(&ex->list, dest);
> +       }
> +}
> +
>  /*
>   * called under devcgroup_mutex
>   */
> @@ -604,11 +615,13 @@ static int devcgroup_update_access(struct dev_cgroup *devcgroup,
>         int count, rc = 0;
>         struct dev_exception_item ex;
>         struct dev_cgroup *parent = css_to_devcgroup(devcgroup->css.parent);
> +       struct dev_cgroup tmp_devcgrp;
>
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
>
>         memset(&ex, 0, sizeof(ex));
> +       memset(&tmp_devcgrp, 0, sizeof(tmp_devcgrp));
>         b = buffer;
>
>         switch (*b) {
> @@ -620,15 +633,27 @@ static int devcgroup_update_access(struct dev_cgroup *devcgroup,
>
>                         if (!may_allow_all(parent))
>                                 return -EPERM;
> -                       dev_exception_clean(devcgroup);
> -                       devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
> -                       if (!parent)
> +                       if (!parent) {
> +                               devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
> +                               dev_exception_clean(devcgroup);
>                                 break;
> +                       }
>
> +                       INIT_LIST_HEAD(&tmp_devcgrp.exceptions);
> +                       rc = dev_exceptions_copy(&tmp_devcgrp.exceptions,
> +                                                &devcgroup->exceptions);
> +                       if (rc)
> +                               return rc;
> +                       dev_exception_clean(devcgroup);
>                         rc = dev_exceptions_copy(&devcgroup->exceptions,
>                                                  &parent->exceptions);
> -                       if (rc)
> +                       if (rc) {
> +                               dev_exceptions_move(&devcgroup->exceptions,
> +                                                   &tmp_devcgrp.exceptions);
>                                 return rc;
> +                       }
> +                       devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
> +                       dev_exception_clean(&tmp_devcgrp);
>                         break;
>                 case DEVCG_DENY:
>                         if (css_has_online_children(&devcgroup->css))
> --
> 2.17.1
>


-- 
paul-moore.com
