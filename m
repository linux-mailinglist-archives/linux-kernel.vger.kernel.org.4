Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA536200E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiKGVST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiKGVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:17:47 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C638DA444
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:14:03 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id hh9so7627386qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MqVAPqJxeEU3XG1tVaA5GAHZj3yx6NNtyPNlyitFnVI=;
        b=YiLW1T4XyIWN1qVhwLtQX88HQWgwsa0OdUf3VXSJi/vNV84RC7jSzne5LJ15gEFDz8
         RdalHSfxOGgBeq0PKLFZ8YCgrT4UbCVlmXqcoG4WTMby5mTqowDCqkB5Z3sYZ7zpbVC5
         o32yALAgP7Pi+If0ZFf5Z/YIIdTlB8wJ8+/Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqVAPqJxeEU3XG1tVaA5GAHZj3yx6NNtyPNlyitFnVI=;
        b=538Dy2aMtgP3pxatHJ70Eq87j+elNYGjMJPwKSza+dWNErPWh/RKu+O6Rv7LbXJ5Cz
         ablzEraQ4GKNMEaKENkZ4HOvX54HKOKQPvqkLclNiLZj3X9Qcz+p/hsHmfPNozlBhuCN
         /CI69Noxy27lOUAuZ+OD4b7gTwFOql3Mg+ODfPVs7rFVNAfElpamCoMbImt1Fzs/bVE2
         W8nRebz8YBBUDC96FK7WbHM3sYSbpoQeZA8WFurudL0jzMhnAVnwjxXdyOUvmU2P8K2m
         CvlHls91qrSEvKQ7PbNcjSmNIYh16UmG0T+TjJrEdZDEFGnX/8d+T4WdhBejJjLdJkCR
         wubg==
X-Gm-Message-State: ANoB5pm4e/0JzFOFXeQzmNvRxQHQNz1OYHSa8ZefcQSAmYVwxPgV+1OX
        pIM2wdMOaKdSfYv5ovx5f7vL5OtxIiZbvQ==
X-Google-Smtp-Source: AA0mqf4KRHk02tbmCa6kjPMkyY1dGQfgBw6k+otgowzqjcfKaFhqMOZBdDasN1PAUwP+2eRZoCKfdw==
X-Received: by 2002:a05:622a:14c9:b0:3a5:826f:644f with SMTP id u9-20020a05622a14c900b003a5826f644fmr8494354qtx.287.1667855642682;
        Mon, 07 Nov 2022 13:14:02 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id r4-20020ae9d604000000b006fa2b1c3c1esm7553763qkk.58.2022.11.07.13.13.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 13:14:00 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id r3so15148719yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:13:59 -0800 (PST)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr53022688ybu.310.1667855639442; Mon, 07
 Nov 2022 13:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20221107201121.1169273-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221107201121.1169273-1-Liam.Howlett@oracle.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 7 Nov 2022 13:13:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9WQXBGkNdKD2bqocnN73rDswuWsavBB7T-tekykEn_A@mail.gmail.com>
Message-ID: <CAHk-=wg9WQXBGkNdKD2bqocnN73rDswuWsavBB7T-tekykEn_A@mail.gmail.com>
Subject: Re: [PATCH] fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com" 
        <syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 12:12 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> When iterating the VMAs, the maple state needs to be invalidated if the
> tree is modified by a split or merge to ensure the maple tree node
> contained in the maple state is still valid.  These invalidations were
> missed, so add them to the paths which alter the tree.

I have applied this as an obvious fix, but I would *really* want to
also see longer-term

 - I'd really like the 'mas' operations to have 'vma' specializations
that get the type safety right

 - that mas_pause() name is horrible, please let's just fix it to
something sensible in this context

 - moving the iterator invalidation into split_vma() and vma_merge()
or at least have some other means of not having these mistakes

From what I can tell, things like mprotect() and mlock() - end up not
using the iterator at all because of this issue. Instead they seem to
just do

                vma = find_vma(current->mm, prev->vm_end);

despite having actually started out with the whole iterator state.
Except for 'apply_mlockall_flags()' that randomly does end up usign
the iterator (and has that mas_pause() as a result).

So it would make *sense* to have "mlock_fixup()" take a MA_STATE
instead of "vma, &prev" as arguments, but it doesn't.

I dunno. Maybe there's some other reason for this very non-intuitive
mix of "sometimes iterators, sometimes not, and always horrible
naming".

                Linus
