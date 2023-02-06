Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBCF68B762
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBFIao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjBFIaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:30:39 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C91CF69
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:30:38 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id s76so5713252vkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6CnRSFC3p2fDgRb6llNDu9VKSx8wKx1SpGxo6gkZyXM=;
        b=bwyuaQoUpY2O0l8d7Ns6jwCsjwIebS5XZ3D8e7BGgN4g7vP2ZkASqVfiMMVlEHoFfq
         7bE7WL0jCaQ2S04evk10RulPltaUhjx4WIfg6pW24raGWD2fOufd51ikcExouo1LdFLe
         g8vXXX1zv+qFHf57uL8MvBAKdJZcaopCjdsN8iSulgg/YScplvBOXMcEu2FcQgj7WRXn
         Mcxxk+e8iel+HMnvOROuFFu0ce+5TUBQN09uckPtuSHM2M2IBrKIf1UHzjZSjSSMFo2s
         eS/Nj/GBi9oONWkzEzaEEF3m6oS3K9Y1f5ROdwTufiOTnq3XYnuay7rAx7OY2OKzx9zd
         dA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CnRSFC3p2fDgRb6llNDu9VKSx8wKx1SpGxo6gkZyXM=;
        b=G4e558Vv6FlKqQEPfFy/SC6rDDErxhPZoYTr3WRFJ19ctL9YDh67fDO+Tud2uQwVZv
         Go00fiySf+kR9LpDgMSCmMELrjz8F4cRvKVD57HJqJf10LfHPFASHnKz7p4NVUVLZLoA
         WjT5QAwcZWa7R06IENTY4Qez63l469HpO+aGX9x2wek+swdfTQl24EeXOGpD+WunGGNY
         y0qhrNgp2+wo+c+7KbMNqRdsawUJVS8vpIDe0wGNWOGPOWTxiilhac9y3gsm7ACDk2f8
         6IirUeBF6gnXqas0lM2PTYtTiQSdY9r9hO4I8FCbfMuZn/OT/LgVSo9RswQRwDXSHZGe
         ArZw==
X-Gm-Message-State: AO0yUKVPzUSzy9nJzpFf3aKf3qJ+NB4/s6ydNZouMI8MItdsCqSUeYLM
        FV5ZUpPnQHEqM/S9Cv57tUsi83keJihfHSwILiQ/dg==
X-Google-Smtp-Source: AK7set+M/hRPwmwRWzaEZh8xVMqVX66tLwflJ0kh/yAn6j4lopheNK4Tyuon26Rx0XIXzTBJrrN5HTbyJI0K9sHq2mM=
X-Received: by 2002:a1f:de81:0:b0:3d5:5b1c:7e9 with SMTP id
 v123-20020a1fde81000000b003d55b1c07e9mr2807833vkg.40.1675672237161; Mon, 06
 Feb 2023 00:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20230131-tuntap-sk-uid-v3-0-81188b909685@diag.uniroma1.it> <20230131-tuntap-sk-uid-v3-3-81188b909685@diag.uniroma1.it>
In-Reply-To: <20230131-tuntap-sk-uid-v3-3-81188b909685@diag.uniroma1.it>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 6 Feb 2023 09:30:26 +0100
Message-ID: <CANn89iKhRepmwD6UHr3ub5v5U_uNEZ0dTpHKTh4H_RTtTxccJA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] tap: tap_open(): correctly initialize
 socket uid
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 4, 2023 at 6:39 PM Pietro Borrello
<borrello@diag.uniroma1.it> wrote:
>
> sock_init_data() assumes that the `struct socket` passed in input is
> contained in a `struct socket_alloc` allocated with sock_alloc().
> However, tap_open() passes a `struct socket` embedded in a `struct
> tap_queue` allocated with sk_alloc().
> This causes a type confusion when issuing a container_of() with
> SOCK_INODE() in sock_init_data() which results in assigning a wrong
> sk_uid to the `struct sock` in input.
> On default configuration, the type confused field overlaps with
> padding bytes between `int vnet_hdr_sz` and `struct tap_dev __rcu
> *tap` in `struct tap_queue`, which makes the uid of all tap sockets 0,
> i.e., the root one.
> Fix the assignment by using sock_init_data_uid().
>
> Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
