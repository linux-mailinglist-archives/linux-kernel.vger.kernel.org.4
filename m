Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62A47402B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjF0R4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjF0R4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:56:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EE71BD1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:56:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d884a22e7so4652896a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687888599; x=1690480599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBM9HTbVE8IN9zkGnkp6xc3S5GpMqGP8gETPCnCzVXo=;
        b=ZAKtTuJnvBJ0mMPXJRzdMshkWjH33bH2L3xcGz1iqCddlIVwQQwZ1nsVXMGqNKgCac
         mZvJD56rmK9hLaxlIBxKHEFSXukX38e816WSScn+dwxbTI7YsYgQnIgRqc4RRywKuf7t
         JSpVK5+5nTpdBcO1+ZukQyAfsMVyNn7LhRT/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687888599; x=1690480599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBM9HTbVE8IN9zkGnkp6xc3S5GpMqGP8gETPCnCzVXo=;
        b=bBfJOSplFs+oJ9VdcDufzcBxzQY/DHdppz++nvySNuN9ofL6+8+V2mbDsMxyRPMg7/
         ZC7CRhfCLnfg4HRDHbCLl3n+PScjzKxc7lyrKcFeD1+T8VKDeDTEFkjsu4dpwLV0qa1V
         YdcrnJfsELXpwAGX0dv65Ppy3Nk94Z8D30xcJne177RH5xatf46u1z0z47R5bnorplru
         8whAZjbOS2DKYZaMDH3kywiw0Td53sNZ5vPyuFIT38aAlOYJQyx8sZ/JtrD3HkAKBuSj
         Asb+KZ4LDymIM3GYqRGHufJ7KI2nAxby/XxXMfkfqpyYDlzzDjnZKmd7oZEf7UiBoXR2
         2opA==
X-Gm-Message-State: AC+VfDzRi/mFy1kmZq8hQpkbsTaEhv8T/ptFOV7Saa3uPxsIH+hMUzTQ
        f/F1pJQivFBoc9FqjboSiMU6u6FvI7QoTFRWGnX4W3Ce
X-Google-Smtp-Source: ACHHUZ6KejpghYiYux0DsDY2233MVbAlvA42+9QZOVXruvE0ce3QPuq3sIdq9m5Ru/w5zql1FCLnxA==
X-Received: by 2002:a05:6402:1006:b0:518:72f2:2969 with SMTP id c6-20020a056402100600b0051872f22969mr22352910edu.9.1687888599079;
        Tue, 27 Jun 2023 10:56:39 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id c4-20020aa7d604000000b0051a4a1abdbbsm4025304edr.49.2023.06.27.10.56.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 10:56:38 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51d884a22e7so4652866a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:56:38 -0700 (PDT)
X-Received: by 2002:aa7:c257:0:b0:51c:ef63:380a with SMTP id
 y23-20020aa7c257000000b0051cef63380amr7719283edo.27.1687888598013; Tue, 27
 Jun 2023 10:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
In-Reply-To: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 10:56:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
Message-ID: <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.5
To:     paulmck@kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 at 08:35, Paul E. McKenney <paulmck@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.06.22a
>
> o       Eliminate the single-argument variant of k[v]free_rcu() now
>         that all uses have been converted to k[v]free_rcu_mightsleep().

Well, clearly not all users had been.

The base of this RCU was v6.4-rc1, and when that commit was done, we
still had a single-argument variant:

  7e3f926bf453 ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")

but look here:

     git grep 'kfree_rcu([^,()][^,()]*)' 7e3f926bf453

results in

   7e3f926bf453:drivers/infiniband/sw/rxe/rxe_verbs.c:     kfree_rcu(mr);

so the RCU tree itself can not possibly have built cleanly.

How the heck did this pass testing in linux-next? Did linux-next just
assume that it was a merge error, and fix it up?

Anyway, I *did* fix it up, changing the 'kfree_rcu()' to
'kfree_rcu_mightsleep()', but no, this was not a merge artifact. This
was purely "the RCU tree did not build on its own", and as a result
the tree does not bisect cleanly if you have rdma enabled.

Adding rdma people to the participants just to let them know that this
happened, but it's not their fault. This is on the RCU tree, and lack
of proper coverage testing.

               Linus
