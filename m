Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195A85EE9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiI1WzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiI1WzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:55:01 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F64E869
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:00 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-131b7bb5077so2521740fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PvzZb/nWICcprKW+/UE1OuAMGD5iEigV3jBljtssS0c=;
        b=RCevJ0ybVc8g0Wqnq8u+Y7WbQOcPgEwCodLVYErhb/GSjvx51ESsOTOlJBioMlWWU+
         O+O08KHalLRnV5z7Qm/dlp4q9KYj01EsTkk9fEl238yCtfFOxe/eGoO49zUnD8Uy6UWi
         UV9YOOQsMK3LGJkCQrBOxbmu+zd9heeow0yMWS5bFs+9BoHK7fmcxzUmk3lJuaVFh6ec
         jqF9otkW5PH32dteHT347gsVeUsMvFMEfQlq0y1RrwV53pYUPTRRhdGn4ZDLhuy3ZUiZ
         AA+qJIt2r4wvlXbKOrlY3G2DkVsR5dix4Bfj+7nHZSKVNBOI7Z7ZnBckrw6RAd0zvGUx
         ZKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PvzZb/nWICcprKW+/UE1OuAMGD5iEigV3jBljtssS0c=;
        b=6mQSBC0ej/NyqkAxtpzS7/zcPLE53NtfbdQZHD+vYYOP4s1H476zdtIA1QLlLfJoqg
         ouia218+vZ6BJpmG73FuHhYScO2Fz30AoTpREQ5u/kAE2o0vVTJeVbGd3tPwrRlj9855
         ugTMVJQ0/Xs9/f2u5l3cIqQZYOZlzChWbEhF9CfEhHmcbnrFqBbY3kN/JRm6bJFNDe8g
         A23hN2OpIyZkWrIFRv8yAHOlXnxIEXQSiS8yMLXLKy8lwUuLtlySYQbRbo9fFbPyW83D
         LBcQNhbInNLhvBNL+JSVnDnjBZ0UnUJqzmj1JtEMgTKr6zSZTg6GKM5yCzKAlOun2CQ2
         vxTA==
X-Gm-Message-State: ACrzQf1XSJ6LNGnCkTrNTPtfhzsMci7+nFinz3Vxn0tOFDdsQZPH5igB
        au20EdeS8DRcAauS2wZAV1FJknGDDKo4pIjoCkcY
X-Google-Smtp-Source: AMsMyM4V8lNNjhhv2Ja8yyosbeUoQGfr097xBpeF5j/+xhdyk78uzlBFaTu2zmyDLPzbetRzXIHn0IArFGKEM004+cY=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr114330oab.172.1664405699174; Wed, 28
 Sep 2022 15:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com> <20220927225944.2254360-4-ankur.a.arora@oracle.com>
In-Reply-To: <20220927225944.2254360-4-ankur.a.arora@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Sep 2022 18:54:48 -0400
Message-ID: <CAHC9VhSY+ELJ_yX+U+ZzAPOtjJ=eGxtmLTtgpm6NhkYE3Yffuw@mail.gmail.com>
Subject: Re: [PATCH 3/3] audit: unify audit_filter_{uring(),inode_name(),syscall()}
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-audit@redhat.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 7:00 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> audit_filter_uring(), audit_filter_inode_name() are substantially similar
> to audit_filter_syscall(). Move the core logic to __audit_filter() which
> can be parametrized for all three.
>
> On a Skylakex system, getpid() latency (all results aggregated
> across 12 boot cycles):
>
>          Min     Mean    Median   Max      pstdev
>          (ns)    (ns)    (ns)     (ns)
>
>  -    173.11   182.51  179.65  202.09     (+- 4.34%)
>  +    162.11   175.26  173.71  190.56     (+- 4.33%)
>
> Performance counter stats for 'bin/getpid' (3 runs) go from:
>     cycles               706.13  (  +-  4.13% )
>     instructions        1654.70  (  +-   .06% )
>     IPC                    2.35  (  +-  4.25% )
>     branches             430.99  (  +-   .06% )
>     branch-misses          0.50  (  +-  2.00% )
>     L1-dcache-loads      440.02  (  +-   .07% )
>     L1-dcache-load-misses  5.22  (  +- 82.75% )
>
>  to:
>     cycles               678.79  (  +-  4.22% )
>     instructions        1657.79  (  +-   .05% )
>     IPC                    2.45  (  +-  4.08% )
>     branches             432.00  (  +-   .05% )
>     branch-misses          0.38  (  +- 23.68% )
>     L1-dcache-loads      444.96  (  +-   .03% )
>     L1-dcache-load-misses  5.13  (  +- 73.09% )
>
> (Both aggregated over 12 boot cycles.)
>
> Unclear if the improvement is just run-to-run variation or because of
> a slightly denser loop (the list parameter in the list_for_each_entry_rcu()
> exit check now comes from a register rather than a constant as before.)
>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/auditsc.c | 86 +++++++++++++++++++++++++-----------------------
>  1 file changed, 44 insertions(+), 42 deletions(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index bf26f47b5226..dd89a52988b0 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -805,6 +805,41 @@ static bool audit_in_mask(const struct audit_krule *rule, unsigned long val)
>         return rule->mask[word] & bit;
>  }
>
> +/**
> + * __audit_filter - common filter
> + *

Please remove the vertical whitespace between the function description
line and the parameter descriptions.

I'd also suggest renaming this function to "__audit_filter_op(...)"
since we have a few audit filtering functions and a generic
"__audit_filter()" function with no qualification in the name seems
just a bit too generic to not be misleading ... at least I think so.

I also might try to be just a bit more descriptive in the text above,
for example:

"__audit_filter_op - filter helper function for operations (syscall/uring/etc.)"

> + * @tsk: associated task
> + * @ctx: audit context
> + * @list: audit filter list
> + * @op: current syscall/uring_op
> + * @name: name to be filtered (used by audit_filter_inode_name)

I would change this to "@name: audit_name to use in filtering (can be
NULL)" and leave it at that.

> + *
> + * return: 1 if we hit a filter, 0 if we don't

The function header block comment description should be in regular
English sentences.  Perhaps something like this:

"Run the audit filters specified in @list against @tsk using @ctx,
@op, and @name as necessary; the caller is responsible for ensuring
that the call is made while the RCU read lock is held.  The @name
parameter can be NULL, but all others must be specified.  Returns
1/true if the filter finds a match, 0/false if none are found."

> + */
> +static int __audit_filter(struct task_struct *tsk,
> +                          struct audit_context *ctx,
> +                          struct list_head *list,
> +                          unsigned long op,
> +                          struct audit_names *name)
> +{
> +       struct audit_entry *e;
> +       enum audit_state state;
> +
> +       rcu_read_lock();

I would move the RCU locking to the callers since not every caller requires it.

> +       list_for_each_entry_rcu(e, list, list) {
> +               if (unlikely(audit_in_mask(&e->rule, op))) {

As discussed in patch 2/3, please remove the unlikely() call.

> +                       if (audit_filter_rules(tsk, &e->rule, ctx, name,
> +                                              &state, false)) {
> +                               rcu_read_unlock();
> +                               ctx->current_state = state;
> +                               return 1;
>  +                       }
> +               }
> +       }
> +       rcu_read_unlock();
> +       return 0;
> +}
> +

-- 
paul-moore.com
