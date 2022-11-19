Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52312631139
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 23:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiKSWTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 17:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiKSWTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 17:19:20 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F4A18355
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 14:19:13 -0800 (PST)
Date:   Sat, 19 Nov 2022 22:19:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668896349; x=1669155549;
        bh=fqOStUAmVrAotbXFIlrr8QbNS0hj013ZEI3Vplbc3OA=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=oy/0DIf7HJldA20aliuqCON94TEA7lpdv/XksjCYtAnFSULs2dplv0cPwxV6zWx/Q
         gwB575WeYS9h+4HqVRUrdOK+lp5aWp2EfVwWO4SSkxxjefZzWuqrWG+Xjk2xMakCsL
         GMg1t5T0HK+QeHBfbFPctB+d1DadoRj4QSjVcuW38Mk8hettvCUAqN7KpePFuGN/hZ
         MQVdkBQZHKkxVAMZbtGPqLQTMDp+APJgvKzDikHqeaSoUAc04ssMQdICMJG4LHMQeK
         c3kIsPkp9L2zA90F6isN4lpVVGfhtLzdbmfP9vWfjDHqdi+hp/1TLxZIY+yTdA2z39
         lSxGVS/P6mbzw==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Alexandre <roger.andersen@protonmail.com>
Subject: io_uring / POLLFREE bug
Message-ID: <_wc1nIgRG1zvW3080DQDu3PEJwSosUqccFhCNUZzKcawvz68icwFEtkSECxh18CTIRpbFN1gBhB74sfbVoGfJuDcczaQf25ePXNoh9DBg1o=@protonmail.com>
Feedback-ID: 5143840:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wanted (as an exercise) to dive into recent io_uring / POLLFREE pb and tr=
y to understand what really happens under the hood. I looked at this commit=
 of yours : https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/commit?h=3Dlinux-5.4.y&id=3Dfc78b2fc21f10c4c9c4d5d659a685710ffa63659 and =
tried to investigate from there. Basically, I tried to produce the bug / tr=
igger a crash with a small C code (using liburing) that creates a signalfd(=
) and polls it with io_uring. I failed until now to understand what happens=
.

This is my understanding of the situation :
- "signalfd_wqh" is a queue created during task creation (kernel/fork.c:sig=
hand_ctor())
- it is freed with kmem_cache_free() at task end (kernel/fork.c/__cleanup_s=
ighand())
- before it is freed, there is a call to signalfd_cleanup() that sends a PO=
LLFREE (kernel/fork.c/__cleanup_sighand())
- waiters are supposed to use this POLLFREE to stop polling and free resour=
ces, but io_uring does not do that=C2=A0
- the bug is that : io_uring_poll (io_uring.c) calls signalfd_poll() using=
=C2=A0signalfd_wqh as its poll_table parameter, but it has been freed (poll=
_wait, should crash I suppose)
- since the task must be finished, we *MUST* use "kernel polled" mode, to a=
llow kernel to continue polling after the memory was freed. Otherwise we ca=
n't trigger the bug, can we ?
- but then, why would kernel enter io_uring_poll after task was terminated =
?

Thanks again and keep up the good work
