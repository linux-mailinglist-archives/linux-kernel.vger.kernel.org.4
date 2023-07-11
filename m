Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2874F0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjGKNxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKNxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:53:36 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9290CE6A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:53:35 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-565cd3f645bso3500869eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083615; x=1691675615;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCTVwmB5J6a5dx6XYxqF53hqOsGWkSYIyrPo76Icn50=;
        b=F9oDif8MdPruIeusfWUXdsE6FRq+1bdc4cBFON5fy6cafoFOVeNwSOwNvNFesS3r12
         kJAmxYZaNtjvHI7oLSY2he1S8wbPggrZxFlXCx8ybq3tOkrzt6RrzI5rE4HHAJdsYUZa
         zg3ZUq6sgCUIMjQqJkjx4oVEWb8R0y5/EG0VbdKyYTLZn3dP9uOcQNsXJE8JtBnRAxtT
         XV/xUaGpkZ5n21VQ3qe8P5FvmXtDTarTNYs328aLct8php85R/FZ1wg8wCK5kAPH/9IH
         IsXmDDKIagbd3XTSmmueGEVn3MKHlrnd50E2tO8MAWrKOhQPYOfs7vblEKaWHucztYcg
         l8CQ==
X-Gm-Message-State: ABy/qLZyRFwAaZHwXXKpqc4z812Ze+RXAnOuIzSFFw0S1dIUTTNGBYsg
        TJiKObwdTy4drjqXI1WmG+AyRywZZJyQqJSwa7scre/mSpk6
X-Google-Smtp-Source: APBJJlECruf66V+JyRtf/KQM/NOn3dy9C/Lb8k9+y2hASr80eBt7evZQjebFhxPNCMT+nnvVQAppHWH3WgcG/RDwIiq/YDiQySGh
MIME-Version: 1.0
X-Received: by 2002:aca:db54:0:b0:3a2:214d:3da9 with SMTP id
 s81-20020acadb54000000b003a2214d3da9mr1601278oig.10.1689083614942; Tue, 11
 Jul 2023 06:53:34 -0700 (PDT)
Date:   Tue, 11 Jul 2023 06:53:34 -0700
In-Reply-To: <000000000000de1eec059692c021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd5c040600366c6f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in j1939_sock_pending_del
From:   syzbot <syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, dania@coconnect-ltd.com, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, nogikh@google.com, o.rempel@pengutronix.de,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
can: j1939: socket: rework socket locking for

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=07bb74aeafc88ba7d5b4

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
