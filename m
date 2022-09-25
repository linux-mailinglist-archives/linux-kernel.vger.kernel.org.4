Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F75E945C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiIYQ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiIYQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:29:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F832CCA6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:29:05 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e81so5641206ybb.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aBqJlL/02oBSrti+6d3L04f/LaPwYB+ZmoE/wMNY/eU=;
        b=bf6sS35YmcXV5zSC1/hE5asbL/mes1Lxc4P4Mq/uFPvPTk5UYP3XWw6hFQ80W59GO+
         pc/zM9ZxTrLgz3wy63F6fQpXXf+xSHgDI0kLWlZUkPpGXBpIVw8IUySs2qKyA0aAY6cH
         bT2Rzune1FY3tbOUwvKSLTuD8ByxzkOtzImN7TF2vjoF1opSiH99vT5gWGzdVlRSfd5g
         xzcngRqcd2qkAHHg9RTX5B6iWe+c/SDmC6r+0ZpOCA6RK1Vp2TwO7V2wJCazJYtlcrYR
         7XgUo7Zu2s18p5ao3qD2lBUj2AWaepMN8gDnQFYrxeU+dEw5zyDTZmcf0wFnn3S1V92/
         KaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aBqJlL/02oBSrti+6d3L04f/LaPwYB+ZmoE/wMNY/eU=;
        b=Xe7QwggJV0ql+44MjUz1k0HuYhRa3jACP3uj1uHt1gOpoomtuzdzABCJMgo50Uhf7e
         CAEuVbeY4m2RWWaHVcCBczNRI/tf30hfYURFCPuIRph6TO/TZbNpfuylGXBhFWaqy6nT
         IFOqA1g+7BC2qO+8eZO6Z06dbIT3FfrCFscOS5BCK3DAT6ZRN7rfud4fEmCtGYm4a9Mj
         7E+D+Y1XbkY1azFFu9PQA16fenabsi1nUgxwmC+EISZcJQ7hi4SSW3b/qJTnqwyUcmIt
         K1tBr/xOey1Be3SGtlNSdVa8YU4Tis1ryrdh1jQ5rhwbPGlNmhZ1m/iKjEi15YbdBHNJ
         bZvw==
X-Gm-Message-State: ACrzQf2UUv3SXZNm2vhVNnKd5KkROOL0L+qZcn7pozWwCRISLLsF+gbY
        juXLjUq/DQGfLRVlEXR7iMTIxWnZudtEx7vaUYkqig==
X-Google-Smtp-Source: AMsMyM7LZRKjut7bA4rjDYiurDKc7/Bej35g4U4mOAWNa/UZDWJ2aBjzNFcwCWStg1DrQnvxCJr7CvxoYqU7memIn94=
X-Received: by 2002:a05:6902:10c3:b0:6ae:98b0:b8b1 with SMTP id
 w3-20020a05690210c300b006ae98b0b8b1mr18621750ybu.231.1664123344367; Sun, 25
 Sep 2022 09:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a96c0b05e97f0444@google.com> <CAM0EoMnJ=STtk5BnZ9oJtnkXY2Q+Px2cKa4gowFRGpp40UNKww@mail.gmail.com>
 <CAM0EoMm9uBQQepMb5bda1vR-Okw-tPp2nnf6TvfA0FzPu_D_2A@mail.gmail.com>
In-Reply-To: <CAM0EoMm9uBQQepMb5bda1vR-Okw-tPp2nnf6TvfA0FzPu_D_2A@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 25 Sep 2022 09:28:53 -0700
Message-ID: <CANn89i+4pgJe8M1cjLF6SkqG1Yp6e+5J2xEkMdSChiVYKMC09g@mail.gmail.com>
Subject: Re: [syzbot] WARNING in u32_change
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     syzbot <syzbot+a2c4601efc75848ba321@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kees Cook <keescook@chromium.org>
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

On Sun, Sep 25, 2022 at 9:14 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> On Sun, Sep 25, 2022 at 11:38 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > Is there a way to tell the boat "looking into it?"
>
>
> I guess I have to swim across to it to get the message;->
>
> I couldnt see the warning message  but it is obvious by inspection that
> the memcpy is broken. We should add more test coverage.
> This should fix it. Will send a formal patch later:
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 4d27300c2..591cbbf27 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -1019,7 +1019,7 @@ static int u32_change(struct net *net, struct
> sk_buff *in_skb,
>         }
>
>         s = nla_data(tb[TCA_U32_SEL]);
> -       sel_size = struct_size(s, keys, s->nkeys);
> +       sel_size = struct_size(s, keys, s->nkeys) + sizeof(n->sel);
>         if (nla_len(tb[TCA_U32_SEL]) < sel_size) {
>                 err = -EINVAL;
>                 goto erridr;

This patch is not needed, please look at struct_size() definition.

Here, we might switch to unsafe_memcpy() instead of memcpy()
