Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE95621F42
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKHW3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiKHW3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:29:07 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED133657DA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 14:25:50 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id p18so5435582qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 14:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jvyE+a/VzGi/Mx5kFb7LbgyWR350ByNCZEt0N3cpML8=;
        b=dKygR0CxCqyjGTvl2IWDIb8jaR/u/d9iiBXaf3egCii7YfMz5/xAEUoN3/0qCLqKxi
         pxEUtf7Hrs4+2eZTmxD6mZADVqpe7h3EBXn1RzSlJsfRG5AUwxQhsTJRAQ9BpMvWBkVg
         h6azusM+UX6lyaeAzwegWteazcyKI/Owumc1+ioYKEbvX6mq/sn+DuEsELtOhmKC0IU8
         /8JxUwwhy+Clx0QMfCdZyquxhudKzzKDxoEd2Bmr5i/lYoGkiE/YZ2zpyvGUuCVNVbQb
         TEnrbdIyVrV/5R9l+q7JUmZ2tJTcezHPjvn5z1kC8q77/2WBS5d5xSoNQcCX3FHTWhw6
         3Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvyE+a/VzGi/Mx5kFb7LbgyWR350ByNCZEt0N3cpML8=;
        b=mENWEecVGuu92xcuQFIVMP9Iyz2PEiRnsVfzEPKgUpBF1XlHmWLV60g22kodxDoG8O
         mkAwdpxhfN3GmlASpsH3ZDa1rYbVUr6gUwu2eIHvKLBLMS2ZJ/X5AfAysCMLz8/mjSnL
         JXgGG5bzx+LEgKaWSWOkFe/QqZnNBB66+j3M0GqTfm4MnOq+Zcqr3/aQsEvG/hvzTcxI
         ykxrSGkVgrugBPpY8aXM759OCOkjzzLd8jVwmvUqBxPmbqbKSzcB/Q/ehVmuuAQ7s57S
         ltWjz0VwVJasxdcBn/k50c4Dd58xHLBUdEQj80txZmdWWsIYd20gNZt1tMiK/nMzv0Xg
         tTrw==
X-Gm-Message-State: ANoB5pkNqYPCu12b3NzZuroNEZwLM+lkc3um6X7ZqkQtMdQLXdoq+DSV
        +CidyX4i1ZzL5Ak7gE7GyVMztVoduG8=
X-Google-Smtp-Source: AA0mqf7PGivH6W+iIwhx3OSx5tyNLvnpQZisgyAZd93t6VOBpMbUm+3V2HZEfqxEEuWyFV+IdL4dow==
X-Received: by 2002:ae9:dd85:0:b0:6fa:e7e6:2009 with SMTP id r127-20020ae9dd85000000b006fae7e62009mr7959850qkf.428.1667946343666;
        Tue, 08 Nov 2022 14:25:43 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b006bb366779a4sm10096697qkb.6.2022.11.08.14.25.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 14:25:43 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 131so14642234ybl.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 14:25:43 -0800 (PST)
X-Received: by 2002:a25:23d6:0:b0:6ca:7fd:d664 with SMTP id
 j205-20020a2523d6000000b006ca07fdd664mr56798893ybj.85.1667946342834; Tue, 08
 Nov 2022 14:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20221030220203.31210-1-axboe@kernel.dk> <20221030220203.31210-7-axboe@kernel.dk>
 <Y2rUsi5yrhDZYpf/@google.com> <4764dcbf-c735-bbe2-b60e-b64c789ffbe6@kernel.dk>
In-Reply-To: <4764dcbf-c735-bbe2-b60e-b64c789ffbe6@kernel.dk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Nov 2022 17:25:05 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdawNGXhW0DEf0-R6--1bDh7qByO=ViD_h=BfRe3XaFkw@mail.gmail.com>
Message-ID: <CA+FuTSdawNGXhW0DEf0-R6--1bDh7qByO=ViD_h=BfRe3XaFkw@mail.gmail.com>
Subject: Re: [PATCH 6/6] eventpoll: add support for min-wait
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Soheil Hassas Yeganeh <soheil@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
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

> > This would be similar to the approach that willemb@google.com used
> > when introducing epoll_pwait2.
>
> I have, see other replies in this thread, notably the ones with Stefan
> today. Happy to do that, and my current branch does split out the ctl
> addition from the meat of the min_wait support for this reason. Can't
> seem to find a great way to do it, as we'd need to move to a struct
> argument for this as epoll_pwait2() is already at max arguments for a
> syscall. Suggestions more than welcome.

Expect an array of two timespecs as fourth argument?
