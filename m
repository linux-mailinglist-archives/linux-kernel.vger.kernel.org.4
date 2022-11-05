Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411C461A78A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 05:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKEEjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 00:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEEjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 00:39:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5172431DC2;
        Fri,  4 Nov 2022 21:39:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bp15so9869270lfb.13;
        Fri, 04 Nov 2022 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbMdUA8UzsgI7FBm0NGKkw14zTLbr3tXLACAHzr4fDs=;
        b=CBUyq6rYjIfFSwz5VzRXGpr7DVFky/4CH0A1ipD4d8L+781f6w+0x2TsJmqGkamr6I
         Hhnl26yg+95M13iR75yIefdX4cFjP7cM7ovutbIu4KrZRCmVksiqh7JoLI37N0plcNMS
         s9NnMhjo2JWh1+xUY9vq9Afy0Dxf54t2hlyzG2wVyu1exu6xtm9AuZjL4+J35APgWn5Y
         OwWXVvFlXy7J8ZlO7Bihw9NhuQo5QQ34atPRgXxJaqUOe8hGIzxu6K8muyCci9r05v02
         Z4JLv06IBzqXbfXhVZc86fRd6QpvdlNiGQHLWu9sFaR4N4yNlRcNnQvCxQTtS8l6jBqk
         ueTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbMdUA8UzsgI7FBm0NGKkw14zTLbr3tXLACAHzr4fDs=;
        b=z9QMQY899s4r/3iMaoKQ8psOEqyXRGfwRpKvu0ZFhv2EehtzXgtNrDsEwVT2rR4Vvt
         MzhZeK+rEAyfnQf1mVTebql0gDGs8HE7z88DgmIbW3UGjNiKmpnQQQwCI/a9xHQSe7z4
         kFFKdVrlJDewX8ClRYnVkex8oUiQP8cnogF7Ay3XvWiX+mbaZovpg8FEtWwdAZvBYwRj
         kA44U4zz0piKyANaxrwFTIKbAlXQvIDxpBQ9gazrfBBckRWeGRJOy8u2VRCECYugG3iV
         7VuiOTKtH2JUdeuBzPlGAx36w8oxWfyxgHUn/daxqhZY8ZKuETviYB+/2d/lYR1wK34U
         /VzA==
X-Gm-Message-State: ANoB5plomwEq3cphw/XAaeKHVF4YMENy/UImiytiNrpaQNXwTCe69LkQ
        uph9Aq8cX7Xy1opR4IIb1/YUlXlqoZUE3hzs0UFaMteE
X-Google-Smtp-Source: AA0mqf7nLvop9D7qwQ0uqbWJPpEk5/avywHRXNBnPB/1d3nHsLxajC4xHLpyUku0yqPnJvMAPZXupJDsz6XCNwkQ0DY=
X-Received: by 2002:a19:c215:0:b0:4b2:9de:44fe with SMTP id
 l21-20020a19c215000000b004b209de44femr1584906lfc.636.1667623160012; Fri, 04
 Nov 2022 21:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221104074441.634677-1-chenxiaosong2@huawei.com>
 <871qqi1u3a.fsf@cjr.nz> <CAH2r5msDR41wQhtsAcE_pUvXXdvwWBBNdESvCkieBoy42vVhcA@mail.gmail.com>
In-Reply-To: <CAH2r5msDR41wQhtsAcE_pUvXXdvwWBBNdESvCkieBoy42vVhcA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 4 Nov 2022 23:39:08 -0500
Message-ID: <CAH2r5msCeS_3LJffON76hOO5fe7HA6Kc-5z7wDbXuoEDAijVbA@mail.gmail.com>
Subject: Fwd: [PATCH v2] cifs: fix use-after-free on the link name
To:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tentatively merged into cifs-2.6.git for-next pending additional testing

On Fri, Nov 4, 2022 at 12:57 PM Paulo Alcantara via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> ChenXiaoSong <chenxiaosong2@huawei.com> writes:
>
> > When opened a symlink, link name is from 'inode->i_link', but it may be
> > reset to a new value when revalidate the dentry. If some processes get the
> > link name on the race scenario, then UAF will happen on link name.
> >
> > Fix this by implementing 'get_link' interface to duplicate the link name.
> >
> > Fixes: 76894f3e2f71 ("cifs: improve symlink handling for smb2+")
> > Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> > ---
> >  fs/cifs/cifsfs.c | 26 +++++++++++++++++++++++++-
> >  fs/cifs/inode.c  |  5 -----
> >  2 files changed, 25 insertions(+), 6 deletions(-)
>
> Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
>


-- 
Thanks,

Steve


-- 
Thanks,

Steve
