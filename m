Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BAA655AC6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiLXQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 11:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiLXQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 11:56:44 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AECD116
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 08:56:42 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id r15so4983749qvm.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 08:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JpcHNwpuE5O5lhju52DhjRWOVFDf/6KjMwJeJDv0qOk=;
        b=eHv1mgQ5AP7oglntmJxZbKwRJLD99vZvrbBfFnrC1Jz7Ia5B1JDL0ZVdTe1ypPUTRQ
         5WCHLYSZyzzKFMghdQRAE1HIgHcXJ19GaLrYGrmqNcv/IylzDZaqSNbaWFNgXXY8isCb
         xvyY1lejoB6EYNIgNic+EwyGt+zj1OR7/0hzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpcHNwpuE5O5lhju52DhjRWOVFDf/6KjMwJeJDv0qOk=;
        b=lZZQytD9dJNrunNSlku17nYaLF1tJk63/O49WFykGR3VdN+3A5rroFIB7dqJUBhmqe
         QgZAYzy6lrNiSpjSBddBfkO7XC9TmSb38mDICY3ssaNMobSEBqySsGr2C+ZoujGMsa+w
         PG2x5Zz5U18TWNlTAskRXdhtFLx5862N2bJsmiGKGayksrPzpbEDwMmRO7BPf/im53o5
         FWl01xMeNcUiRcJsn4yL4uFdmO1IdsYEoMZYHyxl9DnW2tw7R6ISbyWuHVkMVoipQbF/
         s6BsWoDbakVm/xT+lDHTfj9HKdID0KDY/JWwMiTRCMHTKI5h9lgxv/6jpk4fJ82wmUDg
         7/ug==
X-Gm-Message-State: AFqh2kpPv38X21sn3LwBl9mXaUUWWQZOTNDKFfi1v/uV3k0pHwdDbS7k
        oQWGF8TaMyWdTO9vp4B9UKceiXhBHr/07HeG
X-Google-Smtp-Source: AMrXdXv9pMVFfkNMGH697g1whTkNjaa+bXvzK7FGdfbg3ZtW6QijwuhhXP5OI9ag+yMOKR6c7DFKDg==
X-Received: by 2002:a05:6214:15c6:b0:4c6:d665:a6ba with SMTP id p6-20020a05621415c600b004c6d665a6bamr34862790qvz.22.1671901001346;
        Sat, 24 Dec 2022 08:56:41 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05620a458d00b006fefa5f7fc9sm4353610qkb.134.2022.12.24.08.56.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 08:56:39 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id i20so5859059qtw.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 08:56:39 -0800 (PST)
X-Received: by 2002:ac8:4e26:0:b0:3a7:648d:23d4 with SMTP id
 d6-20020ac84e26000000b003a7648d23d4mr705942qtw.180.1671900999023; Sat, 24 Dec
 2022 08:56:39 -0800 (PST)
MIME-Version: 1.0
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com> <Y6amzxU7choHAXWi@infradead.org>
 <c67eba0-fc5a-4ad0-971-cf80bc1c6e5a@google.com>
In-Reply-To: <c67eba0-fc5a-4ad0-971-cf80bc1c6e5a@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Dec 2022 08:56:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjVw9=Hio5pRfGW45+yL-geWfNGyPeSFess3FAZQwVJrg@mail.gmail.com>
Message-ID: <CAHk-=wjVw9=Hio5pRfGW45+yL-geWfNGyPeSFess3FAZQwVJrg@mail.gmail.com>
Subject: Re: 6.2 nvme-pci: something wrong
To:     Hugh Dickins <hughd@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 2:19 AM Hugh Dickins <hughd@google.com> wrote:
>
> Regarding the awful 0's based queue depth: yes, it just looked to me
> as if the way that got handled in pci.c before differed from the way
> it gets handled in pci.c and core.c now, one too many "+ 1"s or "- 1"s
> somewhere.

The commit in question seems to replace nvme_pci_alloc_tag_set() calls
with nvme_alloc_io_tag_set(), and that has a big difference in how
queue_depth is set.

It used to do (in nnvme_pci_alloc_tag_set()):

        set->queue_depth = min_t(unsigned, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;

but now it does (in nvme_alloc_io_tag_set())

        set->queue_depth = ctrl->sqsize + 1;

instead.

So that "set->queue_depth" _seems_ to have historically had that "-1"
(that "zero means one" that apparently sqsize also has), but the new
code basically undoes it.

I don't know the code at all, but this does all seem to be a change
(and *very* confusing).

The fact that Hugh gets it to work by doint that

        set->queue_depth = ctrl->sqsize;

does seem to match the whole "it used to subtract one" behavior it
had. Which is why I assume Hugh tried that patch in the first place.

             Linus
