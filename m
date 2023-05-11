Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2BD6FED5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbjEKIAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbjEKH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:59:54 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6984F8A65
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:59:47 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso12178263276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683791986; x=1686383986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oawR0w6UD60BU+9b68HboOl8QgKLMm6czgIlQXRKuBU=;
        b=uoF+36ErrVzTnitQ4WVF4ZyhB4N3KRqjVHBnqdIbrsSgbBqNQs6x/yW1dTvrcs4EZz
         5ufrMHn/z+gbTVdpSoDs9/rdfECVm3p850ZbLiII3M1Dr3QlajcTOHqxzNIw4ZPb5+kD
         wq+nb7R2MR8eX9Uz+M3bsZKGJi+BlSBguqJuzaBCFLrWIhrFVIDxLoMj56DoSLDshc0j
         BfzRYeAvlYJF90+eI7ggh1Dl8/BUTPfb4pv20fACqhAbuUXCUKxmdEn2J/c/45pOWXCC
         ydma2mnvhLJeIk66ollO9gLbfHXnguP/dEuzPX5AkxfLdqacR/UyWo5G4Hsb+MWso0nI
         Ao+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791986; x=1686383986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oawR0w6UD60BU+9b68HboOl8QgKLMm6czgIlQXRKuBU=;
        b=XHOY4j04qLFCdAXGczGG8r8yYGswcdQY2Cxr2krliBvAa6yfCGQwH0aT5b2frDfc2j
         70CZhPUWuduqIRf2ol6k6mud3zEveFzA6ezRYXCpmZeP6Pn10QDIcJFw803HK7c9N44F
         L+6Y3edTpKWFyAHOlreJjAzr2383aM1FHctWLF977SmV+PTbY3zfHG0acogkOKWHcpAx
         U0P0C4t8ED1sxdQFOuCDLdl7Hwblw5Ow/FS+EHh6hZ/cXMP9eNqCoff56H49lUHD3fvq
         IVXA2uNXvWYd+hMHgFgppuGw1Nb2GlP7CJjuhpjRPnZEgINfudjriwnIAC8p3EGSRtIM
         5cqQ==
X-Gm-Message-State: AC+VfDxVFksFyNeFUq5DG7ne6NLq79KwGHUiizvRp4DjEI7rqtVccHzc
        19hOg32Pc8ilewzhV3pXh2z3rILtlVUFSmwwaDgZbQ==
X-Google-Smtp-Source: ACHHUZ5H5lzljaWxci91tEcXgt6jxUa+m/W0KUORaesRDaJDm74QacCax3bmBd/piuw7EC9IQN5Lez1ZnokFOEVRgaE=
X-Received: by 2002:a25:6fc6:0:b0:b9e:6894:289c with SMTP id
 k189-20020a256fc6000000b00b9e6894289cmr18378218ybc.59.1683791986485; Thu, 11
 May 2023 00:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a294db05fb6584a4@google.com> <CAG_fn=W2C0oX9LZ9=QJPr2GxorCwt1kW3sHNJkypF6aKpAYp9Q@mail.gmail.com>
In-Reply-To: <CAG_fn=W2C0oX9LZ9=QJPr2GxorCwt1kW3sHNJkypF6aKpAYp9Q@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 11 May 2023 09:59:08 +0200
Message-ID: <CAG_fn=Vd9WCk_=YGAzK+ZOr6Tf-sCz2FD8Fx0YRmQYS3ja_aCg@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: KMSAN: uninit-value in unregister_blkdev
To:     syzbot <syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com>
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

On Thu, May 11, 2023 at 9:07=E2=80=AFAM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Thu, May 11, 2023 at 8:58=E2=80=AFAM syzbot
> <syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confu=
sio..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17c0674c280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da7a1059074b=
7bdce
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da66467b3864e8=
2f8559f
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
>
> Sorry for the noise, I was trying to switch KMSAN bots to the upstream
> tree (it is not ready yet, needs one more patch), and accidentally
> sent this report to LKML. Please disregard it.

#syz invalid
