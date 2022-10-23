Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369646095B2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJWSuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJWSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:50:21 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADE72DABF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:50:20 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a24so4607214qto.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo2FXRI4ezRdP3Q+KGa6tSORGuBT0cFIf5tHm1iuBAA=;
        b=Jt6uz48TUndgKHW6KUNpL+gmN0dsX4EYS8ehAGq41nDBYiYyyiQpQwvuNBA8gDlc5y
         utGgPsy1GYdyaFYD28yFJDPkiyFSGhnfebQrw9Ba/XATKeRYG7HF/BuwQHOFGiuGsKit
         oYgaeiYQGSmV/UO5RhApqRlJClVjssQRQzWt5uXnWSlVJoHey6VMLGMLoEN/eTIK4RdC
         QyBihpH0hIby8zfEekCDfWwNFeA0ptS0gaJN0jZSd2dbEnaAXNEWgxXw5QMYFMDPKSQ9
         so0kG/YhpO9W+/NErXzFzghsELZY5NfmwkLfdZ1wsVP4NPcnCo9meTdUySDRJCcEBMrW
         9ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo2FXRI4ezRdP3Q+KGa6tSORGuBT0cFIf5tHm1iuBAA=;
        b=N0chIMyN3B4oR1sQu1LO7OmWA6Inv4mA9DscCJWEm2GvuGAnTUwHr7mIpqfeBNpLKF
         QM1eFh0iKk3qLESbaoa3p9qpPbBNJOQ1fLDRyG9t2GWBHu3hXyS9C5bJiq0ghBtFM9PK
         aFFfdzNb+yJf4G+Qbyj76WLmeN76GcUJxbJRePiClXzO1ar2D3GdEtKeBtJ13QuH6k7r
         BH3Dxm1HLI95QlWi+m3Ut04SXcK+Jk/4FZZ8i1U5LS8LDrF124G0wraTtEi/fzb7TbH5
         EYU4ltBwEufdP4OAoHSB57jwU81BtYTNwUARUAPClxCiHWt8atPImHDu/GP0fjJvAgHQ
         aEeA==
X-Gm-Message-State: ACrzQf3gavCBiO2nJG5CjOgFoN3aXJ2qEAV6guEXyADxPA+7TBfAE+X8
        rflBn3t5SPGICi5mNRUoYeMJuA==
X-Google-Smtp-Source: AMsMyM7pIZzGA8m3YFTKvr4fcYK1riAaox42UGlghPk4R9OQVx70tm/FX0bc7mgTx+m4aEtUfZtQpA==
X-Received: by 2002:a05:622a:1054:b0:39c:fff0:9d32 with SMTP id f20-20020a05622a105400b0039cfff09d32mr19269643qte.677.1666551019723;
        Sun, 23 Oct 2022 11:50:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b0035ba48c032asm11378685qts.25.2022.10.23.11.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 11:50:19 -0700 (PDT)
Date:   Sun, 23 Oct 2022 11:50:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     syzbot <syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>, hughd@google.com,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Hawkins Jiawei <yin31149@gmail.com>
Subject: Re: [syzbot] general protection fault in
 _parse_integer_fixup_radix
In-Reply-To: <ce198a72-92c9-e09a-ca92-2860326c2938@I-love.SAKURA.ne.jp>
Message-ID: <17a1fdc-14a0-cf3c-784f-baa939895aef@google.com>
References: <0000000000002feb6605eb71458e@google.com> <ce198a72-92c9-e09a-ca92-2860326c2938@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 23 Oct 2022, Tetsuo Handa wrote:

> syzbot is reporting that "vfs: parse: deal with zero length string value"
> in linux-next.git broke tmpfs's mount option parsing, for tmpfs is expecting that
> vfs_parse_fs_string() returning 0 implies that param.string != NULL.
> 
> The "nr_inodes" parameter for tmpfs is interpreted as "nr_inodes=$integer", but
> the addition of
> 
> 	if (!v_size) {
> 		param.string = NULL;
> 		param.type = fs_value_is_empty;
> 	} else {
> 
> to vfs_parse_fs_string() and
> 
> 	if (param->type == fs_value_is_empty)
> 		return 0;
> 
> to fs_param_is_string() broke expectation by tmpfs.
> 
>   Parsing an fs string that has zero length should result in the parameter
>   being set to NULL so that downstream processing handles it correctly.
> 
> is wrong and
> 
>   Parsing an fs string that has zero length should result in invalid argument
>   error so that downstream processing does not dereference NULL param.string
>   field.
> 
> is correct for the "nr_inodes" parameter.
> 
> 
> 
> How do we want to fix?
> Should we add param.string != NULL checks into the downstream callers (like
> Hawkins Jiawei did for https://syzkaller.appspot.com/bug?extid=a3e6acd85ded5c16a709 ) ?
> Or should we add
> 
> 	if (!*param.string)
> 		param.string = NULL;
> 
> rewriting into downstream callers which expect
> 
>   For example, the proc mount table processing should print "(none)" in this
>   case to preserve mount record field count, but if the value points to the
>   NULL string this doesn't happen.
> 
> behavior?

I've given it no thought at all: I was hoping, as Al suggests in
https://lore.kernel.org/lkml/Y1VwdUYGvDE4yUoI@ZenIV/
that the breaking commit would soon be reverted, and Ian think again.

Hugh
