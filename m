Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B783A6F9330
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjEFQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFQ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921B1A1D1
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 09:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E737600BE
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 16:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B5DC4339B
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683392312;
        bh=LVgtX4bh80LJlep+k4IGEYulY+rofifGgyo1RpA7Cf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qitu9HnDdyFJLdUkWzZy5bH4/fmmA5WwHYECeVaHu35cuBRo1ZSNfdKqnPDsiJmQX
         meE4Rax0udBR2I0JTRSPtmK2xkBEScPe086MehXw3O+NAjskwn6u02zXC8ZF2QH5u5
         6TP4N10hm3lqArogYSaX76/10QX/JaEc3VE6uA6nKQ8Xcz+ILJ9skyNqyDbmGhdFqh
         sVXggSHXj2E1+czuVoxeOZ0MD+DqJcs1Fvz38k6IAdbEJuv2s6kGEBnvsCRa6tNCfO
         CUtgoPmWmQPpG+C4ft32vZYg7xE4OKw1TvJGYcXPDr3qjcdsbn0WpnaAXVSz/OBYCy
         RbcXxY7mNL1sA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ac82b07eb3so27418061fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 09:58:32 -0700 (PDT)
X-Gm-Message-State: AC+VfDwfhzW2ShIsgBnH9cVWvGMoWS1o3KFhVro6F8zPTr/AZu52bZZ8
        acJQn8kakZcBqePHI9IpTcKJ43p2ij3W6AovkWk=
X-Google-Smtp-Source: ACHHUZ5tnNuzNJIzHG5eKXGjxzX7Fh34nvehe7JCz6ZG1h3xtFMSK3V17ADoen5SerbC+bM6897z+Px2lL4BWsg0fV4=
X-Received: by 2002:a2e:b70b:0:b0:2ad:8a4b:6a9e with SMTP id
 j11-20020a2eb70b000000b002ad8a4b6a9emr78ljo.26.1683392310511; Sat, 06 May
 2023 09:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d3001a05faf979c8@google.com> <CANp29Y4Q-VWEWeHmZu0f9tLLik1Va8oDF-s8hAeVkBZbX4K0gg@mail.gmail.com>
In-Reply-To: <CANp29Y4Q-VWEWeHmZu0f9tLLik1Va8oDF-s8hAeVkBZbX4K0gg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 6 May 2023 18:58:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGTgx3aJP+KUDo=qer-wsv79ehVVLiCxzkYQ9D2j_-F9w@mail.gmail.com>
Message-ID: <CAMj1kXGTgx3aJP+KUDo=qer-wsv79ehVVLiCxzkYQ9D2j_-F9w@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in load_balance
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, syzkaller-bugs@googlegroups.com,
        yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
f4fd69d8877146677709f66778c40bc3c7bcb40f
