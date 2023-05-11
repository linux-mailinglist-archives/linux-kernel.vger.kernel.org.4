Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561076FEC5E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbjEKHIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbjEKHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:07:44 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B133876BC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:07:41 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a8019379fso76495327b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683788861; x=1686380861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNfHxr4G/JrLUZZ6MRKxmP6K5eN8DLy2NxSaxhT7fow=;
        b=pZ6dwW3g3vD/gyjGwp+h6kPCy+pGuV6NiUU1NDODeoM8VLeFz/Z2mhpWDjnN2RFhSq
         1DSSLk66vJAkveL55yMkWDRmdnoD1Am278E5qw7QqopFUFa2yrOSq+vWZqXH3/ryL3Qr
         sD16FURh+ncBgfNcOMN4cMafv5JqVIdWBUQx03W3f1RQyYWAFrVk05mf3THwjg7loXqL
         XWPqxLMLAzUnSt1njfWuZyGI+2YfatcDaIU6wI7hbNwlZCm9vvuCg4SqSLb14st1TGSl
         Wft58J9o0CRFlveKeEdCFsl9NLT9b+M1jqLgM8L8Gh6ttuwCwSveY5IRtuwA+8qgBmWH
         xJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788861; x=1686380861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNfHxr4G/JrLUZZ6MRKxmP6K5eN8DLy2NxSaxhT7fow=;
        b=L8e8Lm+pD56J6weQJSTThswChgoevTh3dmyJkBPjvc+mLMnEzeUFxb4RND48twCpBX
         LflVBwclwp77Mv/+CIL9WkMRMsxrNTni+Z/b8oU8vTUFXntuQoMxVxOltvNm67w3Ekc9
         zzgi/7JLyCSBC1wrx5jQ8Pkb3aD+ItNj/MB/sGpF/rYyG8k1YGtXrKOPpf5FAZflGHuT
         6Vw5GYWos1QA4p5Imo5sl7754M/W7ltDEH2Tgw5y1ZnmbDtPj9WVvIBSmHfDs+yqXP5j
         zGLrHldxMUGZ66u7ttusyT/sOZB/lSm5/wz5ubshJjh3FMisne0+dmmk0xfQV4uO/m/v
         kaNw==
X-Gm-Message-State: AC+VfDxSYbM7T3bJGg3QyBwUfNwYjagp7sNZaktdpKYX+Bl7FPV+9aqz
        qbdD+qBSFq+o5CtyrqiFI/Y4ARQAMlxYOuDu4eaGAA==
X-Google-Smtp-Source: ACHHUZ4ocNSahL3QY/b6Az3Vujho4WRHGib4IF7PWeo5VA5RT9/RGS+kkKXlWVSymqRb1NQcpP8aprojMXVUxdfwqfQ=
X-Received: by 2002:a81:8445:0:b0:55c:67df:6700 with SMTP id
 u66-20020a818445000000b0055c67df6700mr22328993ywf.19.1683788860623; Thu, 11
 May 2023 00:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a686ca05fb6584ea@google.com>
In-Reply-To: <000000000000a686ca05fb6584ea@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 11 May 2023 09:07:04 +0200
Message-ID: <CAG_fn=XUQUpt69a66i7XM9tHeQL96WnzNJ9X60OTm3ZB5=khZA@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: KMSAN: uninit-value in strlcat
To:     syzbot <syzbot+26836cb949db3d40c992@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 8:58=E2=80=AFAM syzbot
<syzbot+26836cb949db3d40c992@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confusi=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10811e3428000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da7a1059074b7b=
dce
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D26836cb949db3d4=
0c992
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2

Sorry for the noise, I was trying to switch KMSAN bots to the upstream
tree (it is not ready yet, needs one more patch), and accidentally
sent this report to LKML. Please disregard it.
