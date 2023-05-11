Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328F76FEC60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbjEKHIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbjEKHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:08:18 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBA68A42
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:08:16 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b9d8730fe5aso10626741276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683788894; x=1686380894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd2Syo+tVpihK8x27Jr794LU7OeVE0LYf+cWSGjQc8g=;
        b=vrj4hl/lhoBuSWgjbMshRCXfTHtJg3MF2aUz+PoH9H2IUOKo//2sodrSswsh9PgElz
         k/ZV8RY8L2/0mC+pxxreC3H5FedwjdCAjz4NegItqTjXJOVOJ79NN9zH2JLwZuaMnEwj
         2Mx/OBbQP9+x4dbJYe13nZmix1+mwAIv2KcG/p+xwYOf3wJhe8KNUSVU9AvOA7ILK0xN
         pUk4Q5gSgzfVVTPW7Nl4ozBBonD/bdUx7amLI6peMfC+45gvuxs+iBkLI2C6fvtl7VgM
         a+rUsEYtGmcDgrt1E2ZX7b1IO0yOIoJfnRa0PGl5XsocRdhfX+X/xh5ZbUBbfNZimd0O
         HIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788894; x=1686380894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gd2Syo+tVpihK8x27Jr794LU7OeVE0LYf+cWSGjQc8g=;
        b=duKRrwGOc3YAPmXVE0k1A6R7anOxCZBu/pnfXhgc5zozxdhzw+LxAiN4j+IVuqwbzA
         usDARV/xkCBwzB1VslxDGafkY61q6HfQzMKsqJP6CZ9f0EiDEJTZUtsO5QBmtm2CQnLC
         IgstE6Pfl2VN/NJoEsq2g6N7lBrs2L8N5V7BIoJ1KzNZYv/tWm6OoL0AZjEj6xspXn0G
         Ekqh8R8lyhc0rvZK3/A2SSxipD0O/xDmerRQLzMZJ5JHj1n2KmRXlZroPAIdZatffXCQ
         cUVUizQclQnZkiPjQa5jxjWMSMW4Mts35QNgln23bTI5bGRe1IqL3FrvvubaDUZp8ydG
         kJ0A==
X-Gm-Message-State: AC+VfDyzqx2gSIfz+HXBi2pjFn7syjWTm9aX2YdOLrOF9wcdZ9Po+xm0
        YctN20PjjspLyqg1q8ooqjUQkqv6e5ZuhGN7AumSjA==
X-Google-Smtp-Source: ACHHUZ523bCQ2OW57uRgdP7bxIwgDuG/kGUulFCOWPqUQW1m6uKz4aSIzYRS0P8MGrgM0MkmCsbidaTue+2MS61X5TM=
X-Received: by 2002:a25:d74b:0:b0:ba6:954c:870a with SMTP id
 o72-20020a25d74b000000b00ba6954c870amr1564268ybg.17.1683788894289; Thu, 11
 May 2023 00:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a294db05fb6584a4@google.com>
In-Reply-To: <000000000000a294db05fb6584a4@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 11 May 2023 09:07:38 +0200
Message-ID: <CAG_fn=W2C0oX9LZ9=QJPr2GxorCwt1kW3sHNJkypF6aKpAYp9Q@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 8:58=E2=80=AFAM syzbot
<syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confusi=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17c0674c28000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da7a1059074b7b=
dce
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da66467b3864e82f=
8559f
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2

Sorry for the noise, I was trying to switch KMSAN bots to the upstream
tree (it is not ready yet, needs one more patch), and accidentally
sent this report to LKML. Please disregard it.
