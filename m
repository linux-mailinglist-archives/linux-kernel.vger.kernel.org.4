Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323FB65CBA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjADByM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjADByJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:54:09 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC0164AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:54:09 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g13so48396902lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 17:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ENfREs/+kE8uL6hKvwskOdg+lSrgQr9bKPvZeVGJsQ=;
        b=l2Oa3ChyCBqNbRs+zG8Q6BjSygUEBDXqjvOtb6ISycKB4uz13FzHAd2NeOuT80deCp
         F16Ls0b3Hdpp2sDdKdqrXl8/UYlrxyjvUeXNgVAB5u0L9AWtjUCfXBz/NyCx3BzRq69w
         SrJI+RN9AJ8gOkTUDJYsZuAC+SrK26Y0tfgdEhAIL9ZInzItPmdOXi6ISqi5hB3rWzyp
         LzT1CpRrx+yJdky8GmUENBZLxQ6IPW2F8yWHMjQpPERIrhnpL4mlBn+ute/muhBRkncO
         mJQsxGdcc5fHz8hnS+pF0KcU4A/meIIeMZQWHigy0Ppo6dciulyyraX0Yzj3WVydOPce
         1Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ENfREs/+kE8uL6hKvwskOdg+lSrgQr9bKPvZeVGJsQ=;
        b=Ll+Th0zOJcl16LzzXlhyhMPGlBree3l6AQgst+x3r4KzdURaWZUvoqdpe7DuhiiBtK
         L3JKx9kWsH0DtVsTMo2oNVpGqUrxAiUsE/cnk2gAp1Fc5LulgNDedf7GWHjBACvIxXkY
         bBUlQvwqQbnQCemZ8u1P1tR3Dy31tFNODNtOlzt8voa9L3Q3upXUfZXv2LIRIMsvbBCe
         1zkw5NZaczzWwAisBUQwSTEBYz0VCCapfpbBiOjRY3CFTq/r+T4FDOiU/E6xoQq0S6Wm
         w4mDh4Ff/UcOOCpQ7iSFl+jDY3YJyodGOppM4C33fw24Tu2xRQYQoSrVMTLVurOjAblk
         ovsw==
X-Gm-Message-State: AFqh2kq5tL12jPU2Fw7q67NQAznEMSA8AFgsl0fDOlxfdvcvr4CdN9Kt
        9dF1Av+TfAVkhaHnA+UzK/A9rmQofNPRqEk2wio=
X-Google-Smtp-Source: AMrXdXummYS5wWjhsB82C1I1nGXyx/WY06hs91ePQQc/dWXl7bXvUORru8MGAx3oYddjt38BMzgtQGyukuftT2d1NC4=
X-Received: by 2002:ac2:53ae:0:b0:4b5:7968:630f with SMTP id
 j14-20020ac253ae000000b004b57968630fmr3152653lfh.351.1672797246897; Tue, 03
 Jan 2023 17:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20221230154332.5082-1-chao@kernel.org> <167276540205.24190.7786330518792341546.git-patchwork-notify@kernel.org>
In-Reply-To: <167276540205.24190.7786330518792341546.git-patchwork-notify@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
Date:   Wed, 4 Jan 2023 09:53:32 +0800
Message-ID: <CALJQGLmws5BBdDUYp3qiytEWrCLegT6RA+M+9H7O1kYfoy6TXg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid NULL pointer dereference in f2fs_issue_flush()
To:     patchwork-bot+f2fs@kernel.org
Cc:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<patchwork-bot+f2fs@kernel.org> =E4=BA=8E2023=E5=B9=B41=E6=9C=884=E6=97=A5=
=E5=91=A8=E4=B8=89 01:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello:
>
> This patch was applied to jaegeuk/f2fs.git (dev)
> by Jaegeuk Kim <jaegeuk@kernel.org>:
>
> On Fri, 30 Dec 2022 23:43:32 +0800 you wrote:
> > With below two cases, it will cause NULL pointer dereference when
> > accessing SM_I(sbi)->fcc_info in f2fs_issue_flush().
> >
> > a) If kthread_run() fails in f2fs_create_flush_cmd_control(), it will
> > release SM_I(sbi)->fcc_info,
> >
> > - mount -o noflush_merge /dev/vda /mnt/f2fs
> > - mount -o remount,flush_merge /dev/vda /mnt/f2fs  -- kthread_run() fai=
ls
> > - dd if=3D/dev/zero of=3D/mnt/f2fs/file bs=3D4k count=3D1 conv=3Dfsync
> >
> > [...]
>
> Here is the summary with links:
>   - [f2fs-dev] f2fs: fix to avoid NULL pointer dereference in f2fs_issue_=
flush()
>     https://git.kernel.org/jaegeux/f2fs/c/b3d83066cbeb
>

Hi jeageuk,
There is a character error in patchwork configuration, :).
:s/jaegeux/jeageuk/g

> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
