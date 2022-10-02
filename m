Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797BA5F23F3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJBPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 11:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJBPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 11:52:36 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21CA120B2;
        Sun,  2 Oct 2022 08:52:35 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id n5so205750vke.12;
        Sun, 02 Oct 2022 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vjeLG2XTrGNkMtJovXcIe08FMWx6adqZPyqcWpGEYZU=;
        b=XS0E4dEy/uW5hV/GqUalKvHGucERBmvC0l6QwKX8jlI4p8bc0BiM8WZeytuKzwfL39
         zPjoD0RHV6BWH7SgQ5H4a4ThrDq08jlr4P9zJhZM5lN9MbO2LEks1Hi/maT+LKtWHAvs
         IItu68qvujotO/hlBYPGhLCjtGhujSMNAiPu+xSrBXdIdrZQgCC6fmJ7rFipYybKce/O
         67e8kM1PcSyDlwHjPU/z9ZbOy7M62RIRcZ8RKe+2JHzCcxygC+e16mv7TdGpDXOnno4r
         5u3seElxMo2fGYK/W1+ts10uupIQDk4Y5tOMo1MWx1A18ohRNWBsMFQWpGUYpiBIHmlZ
         5shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vjeLG2XTrGNkMtJovXcIe08FMWx6adqZPyqcWpGEYZU=;
        b=NkmW4AhiZfU+9gf9pyA9+4LYdPxtOsXxr/2ZaGqQN8wpLAId7J0AXSipxQ51Nj3aHL
         v4sDbAHsajGFjGDgCRXwsFJHk88J6DKDd0nB3S3DfdG2WaoZ0Dyxyg4+hyA8/R/ZNQoo
         Rn/T7TUQSokbB+1HuQDTVUnaqP1zJZWIm94guw9Ml1HztgBb1sTUHGA3SIbxxmsKpq9o
         S+mZaE2Y3VSva2OtopHHt525a8e3Ci9B1Ow/fk7ikftcJ3KmT6NDvhE6NaKkoD4a5QHb
         +EpIFVfAgFwOZ5CaLTFNtrmOGDWLv/EpEbTEXvzkAn7wY/kHf8rK7+ejWISLuvLBUvlm
         N86w==
X-Gm-Message-State: ACrzQf2EiEMRbPRygA6VYstu/jp0XXdmdJdo9nSSiQ0eqnIxW+aO0Jy7
        A7LZUA1IZky2SnAq4qG5UWYzcTH+Zrk9a0uOHwOaA1hyZEk=
X-Google-Smtp-Source: AMsMyM4UDxzaeRh30SUXiIB2z7rBUp26QpuzouT5qJuG0A7NkIJieZ3BKt76ilhNssHBD/fR2RLOkmzAg2ce48mZ+rI=
X-Received: by 2002:a1f:a7ca:0:b0:3a2:cb7e:65a1 with SMTP id
 q193-20020a1fa7ca000000b003a2cb7e65a1mr7861521vke.4.1664725954939; Sun, 02
 Oct 2022 08:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <3b7a3398-0826-04de-f805-c926b39e7d35@gmail.com>
In-Reply-To: <3b7a3398-0826-04de-f805-c926b39e7d35@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 3 Oct 2022 00:52:18 +0900
Message-ID: <CAKFNMom7Z_5QWaGTG-=C67n0aT__nu4Wfs=Tsa3jgpXQMtWkEA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in nilfs_segctor_confirm
To:     000000000000219dcd05e9f95ed9@google.com
Cc:     linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+b8c672b0e22615c80fe0@syzkaller.appspotmail.com>
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

On Sun, Oct 2, 2022 at 6:25 PM Khalid Masum wrote:
>
> Hi all,
>
> The reproducer triggers the same bug in upstream 6.0-rc7 as well.
>
>
> Thanks,
>
>    -- Khalid Masum

It looks like this and a few similar issues are caused by duplicate
inode allocation with the same inode number
as the root inode on a corrupted disk image.

I'm now digging into the issue and trying to fix it.

Thanks,
Ryusuke Konishi
