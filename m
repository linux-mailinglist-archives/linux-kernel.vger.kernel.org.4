Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9556C8CE8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 10:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjCYJUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 05:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjCYJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 05:20:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE66E91
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 02:20:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13so3486670pjh.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679736030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjW9k3rHH7SuTNAYZSMyYgzp462JYdnAFz1yHZvP0Co=;
        b=PPP45abKqEmPYtRod+0A2i32VjWmfsJbpjN0gPmIgS36aURG6BPYrY5BpowoTTsvKe
         1bYUVAr7JAofwE6ara4wsHqUD4dmTce1AvGIkw3foX8nIATNtFUbEZmgwdx5lVql45mL
         DG3ixN8AoC2h9Ct651727MsUUuwYQZ7/kie5kREW+mpy2jtRCOOLE8UHY6hGXBUk/n7V
         u4lDpMhad4y+qt7vaoSR/NrCfTtOxoUo714ZFuvPfWyyC02lsVE3zhUaVyaNvAIoKfqh
         FF9jbj31Y2VEN8Tuf45f/NVnUQEF4CmLw6gB3gi+FtACABb2JdpmVvf2JRoTv6q9/yor
         FMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679736030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjW9k3rHH7SuTNAYZSMyYgzp462JYdnAFz1yHZvP0Co=;
        b=58tNHjbI1rwBTmn6PoCa8mOcZzCC+B30ZqBSPQ8mCkbPByokDv2hOylxzXqefefDTJ
         zbWe2W3LVbZjcKUXAQmd3hKaB7SVbJOpED6oFfN9y0rSVUw2nkKuq3QEXJF/W8wUk7K9
         Uti4+Sd1jDAaIwaMXQk3EhuItcmMu2qfE7skHp5mDezHCHGaXHPexKZZgiGZR248BUQc
         R6ac0WR5gtgg0McfMGXagakH39K3z7JVrrTO38uuq10SF/tBhG8Tg6W7cFnxi/wSxEUf
         TVfGbcsxK2RJDPPyy923SyPxvXwNhoYESYw4ZBEsdhu8O18EOyIDL0wA5MMcHBX/Y37K
         eyVw==
X-Gm-Message-State: AAQBX9fFc31AnMwkRWLsucqPNyOUtooVQFolHSybwokg/Cf53ThgxEag
        XbUJs4O7y7Gg0AmAqy3t4ikCsMHqkSGSXP3zG9s=
X-Google-Smtp-Source: AKy350bF03Kry9/ivvmHAPgtU8YpmYLYbkoZ6D7Mu532hB/4crd/zIulLjtTwoiTQQeDA3xBzIno/pPgDqvdAK+OaIg=
X-Received: by 2002:a17:902:ef94:b0:1a1:c109:3700 with SMTP id
 iz20-20020a170902ef9400b001a1c1093700mr1876965plb.7.1679736030155; Sat, 25
 Mar 2023 02:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230320092652.16649-1-zbestahu@gmail.com> <ZB0Dwxs6xen7D/qh@slm.duckdns.org>
In-Reply-To: <ZB0Dwxs6xen7D/qh@slm.duckdns.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 25 Mar 2023 17:20:14 +0800
Message-ID: <CAJhGHyAvzjK5r5yfB_wcLPnq=Y=wwsxh=M=EA3x5EsNacRKMVQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Drop the NOT_RUNNING check to flags in worker_{set,clr}_flags
To:     Tejun Heo <tj@kernel.org>
Cc:     Yue Hu <zbestahu@gmail.com>, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 9:58=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Mar 20, 2023 at 05:26:52PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> >
> > We know whether the worker flags are belong to WORKER_NOT_RUNNING or no=
t
> > when we are setting and clearing them.  So check the flags not running
> > related is unnecessary for both the cases.
> >
> > Currently, worker_{set,clr}_flags() are all used for WORKER_NOT_RUNNING
> > except for clearing WORKER_IDLE.  Let's change to directly clear it
> > instead.  Also, update the comment a little in worker_clr_flags().
>
> I'm not sure this is better. Semantically, the existing code seems cleare=
r
> and less error-prone to me and this isn't gonna make any meaningful perf
> difference. Lai, what do you think?

objdump -DSr kernel/workqueue.o | less

    3275:       00 00
                        3273: R_X86_64_32S      current_task
        WARN_ON_ONCE(worker->task !=3D current);
    3277:       48 39 43 40             cmp    %rax,0x40(%rbx)
    327b:       0f 85 91 00 00 00       jne    3312 <process_one_work+0x3a2=
>
            !(worker->flags & WORKER_NOT_RUNNING)) {
    3281:       8b 43 68                mov    0x68(%rbx),%eax
        if ((flags & WORKER_NOT_RUNNING) &&
    3284:       a9 c8 01 00 00          test   $0x1c8,%eax
    3289:       75 0b                   jne    3296 <process_one_work+0x326=
>
        struct worker_pool *pool =3D worker->pool;
    328b:       48 8b 43 48             mov    0x48(%rbx),%rax
                pool->nr_running--;
    328f:       83 68 20 01             subl   $0x1,0x20(%rax)
    3293:       8b 43 68                mov    0x68(%rbx),%eax
        worker->flags |=3D flags;
    3296:       83 c8 40                or     $0x40,%eax
    3299:       89 43 68                mov    %eax,0x68(%rbx)

It seems the compiler will do the trick. The clearer existing code
seems better.

Thanks
Lai

>
> Thanks.
>
> --
> tejun
