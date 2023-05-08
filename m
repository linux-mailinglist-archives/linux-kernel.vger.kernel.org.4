Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208306F9EB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjEHEh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHEhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:37:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A4A5D7;
        Sun,  7 May 2023 21:37:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso6121208a12.2;
        Sun, 07 May 2023 21:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683520639; x=1686112639;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/8czNSQMs5ZE09eqckQj59m+BAk70EHKVeIQzqF9EK4=;
        b=OrX7cXFngrppVRComppBE4UToSOKhTOtvHKt1JD1uvVdSq9/l9srY8ZZltdGPrFdOT
         BuoNw8RhtaHq8RBY6biHGkjWXPQX/l5ewR7rqEFcsqPt37kD+uZrwmHhHIVJ2RuSMEZ1
         OR+3J6TnSua4CiADomxzYfV1OYNGsBTCnaysAV1FcdNYy9vB8R7k/OT3Bu+2q+cmViuk
         x9ar4lXL6Sw+GhfvBrRwLVFTiGC5cu0GAk5D0p9YIMjim1BszyEA/XV6oK3StMZndeQN
         ekQthcD2Hr/V7lrZ37d+mzkDJZSe/LQQmGlHN0hsCFcbRFnlECnXzzz4/YCgvNes3EXd
         xOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683520639; x=1686112639;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8czNSQMs5ZE09eqckQj59m+BAk70EHKVeIQzqF9EK4=;
        b=HnWTBOQkz2LXv834JHO8D+oB8zRzsnUmvJEvNeX84qaOvKKgHkuhCpe1FOHjCYxoZl
         n1RZHC13NS6giaIaiz+cniF+nOtxeld/7o4/WJgxCCoSc4z/lCuiUarYmeXzPZF7Wdld
         wR/wpj+V7wnQQ61OLYm7S1V/YdDNpCrHfaOhbF23Mgj/eC236jgNDZvAK+z7IwTsU/Pq
         EQj9L0j4jrbTdc24Y9GYouMpeLd6LFVidEF/Ronka5lbDiqaGAyKXbPZJzFZWNrNGRhF
         +IFk8ZY+i4t8rRH//DjXfgV5N26Qhk79rakFmqYXlXyQOiXim1nuQnY+O+M9fnqOzNt3
         5FCA==
X-Gm-Message-State: AC+VfDxudWmicaNeBYdTa4LuW+vdiOESQN1bVuNq7ngb8c3CIwwR/OpX
        0aPeBRum7SUjPb1+QJlqw7OB3bns5KYj5WAdmRroIbuiuMg=
X-Google-Smtp-Source: ACHHUZ7AU6ziTxSqRyS3fPV30ECK7IKc3B+wOVDvdBbi2PalD9CZLNYONUaHrqBYisqSGynttE+LHcSoj6PtX5Rl1+o=
X-Received: by 2002:a17:907:70e:b0:965:6b9e:7ded with SMTP id
 xb14-20020a170907070e00b009656b9e7dedmr6705510ejb.42.1683520638939; Sun, 07
 May 2023 21:37:18 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 8 May 2023 06:37:01 +0200
Message-ID: <CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com>
Subject: Situation of CONFIG_BLK_WBT_MQ after commit b11d31ae01e6 ("blk-wbt:
 remove unnecessary check in wbt_enable_default()")
To:     Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yu Kuai, dear Christoph, dear Jens,


The commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
wbt_enable_default()") removes the only reference to the config
BLK_WBT_MQ in the kernel tree.

The commit comes with the statement "If CONFIG_BLK_WBT_MQ is disabled,
wbt_init() won't do anything.". The statement "If CONFIG_BLK_WBT is
disabled, wbt_init() won't do anything." (note: CONFIG_BLK_WBT vs.
CONFIG_BLK_WBT_MQ) is certainly true, but I do not see that "If
CONFIG_BLK_WBT_MQ is disabled, wbt_init() won't do anything.", but I
believe it would simply do what wbt_init() does with CONFIG_BLK_WBT
being enabled.

Now, it seems that with this commit applied, the intended switch of
the config BLK_WBT_MQ is gone, and the config really now has no effect
at all.

So, I am a bit puzzled:

1. Either the config BLK_WBT_MQ does have an effect somewhere, but one
cannot find its reference with 'git grep -i "BLK_WBT_MQ" .' --- so, my
investigation is just incomplete or wrong, or

2. We really do not need this further build config BLK_WBT_MQ beyond
the other configs already there --- then this config should just be
removed, or

3. the commit unintentionally broke the purpose of the config
BLK_WBT_MQ --- then this commit above should be reverted.

I would be happy if you could provide some guidance on what is the
situation with config BLK_WBT_MQ.

Currently, I am guessing it is option 2 and the config BLK_WBT_MQ
simply can be deleted, but I am really unsure. Probably, this build
option is not used by many people and its effect is hardly noticed, if
one does not specifically check for that in the running system.


Best regards,

Lukas
