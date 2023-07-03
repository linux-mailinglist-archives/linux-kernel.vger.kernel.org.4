Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E493745ED3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGCOnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjGCOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:42:51 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98C10E6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:42:42 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55767141512so2301629a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688395362; x=1690987362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrA308we96oVwz/kgmxRDcKXJtyEBbepsNUANAmoIY0=;
        b=Ipef32BA2RNaBK8hQFCP5rn7/iZ5F+7/2ITqgBNoT//Pyxpw5oJDZHImVjcaj/f9cr
         oBov6aTuCU/uWiIANJI0IGAVCGW2NceXrknYsmfRXoEStDWuLTlj0WO1coDT98FpDZpd
         OoSbiBIH1+0SnVorEzx6R15ihrj8UvThvWlRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688395362; x=1690987362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrA308we96oVwz/kgmxRDcKXJtyEBbepsNUANAmoIY0=;
        b=TzYUfK6/mVh2htRmNRlaQ6DenvKvZj795t3DpvVRi/qylUhmH2OzYJt7TY+fUyrl6S
         dhBXa7ZnfRPgwjWAAvfEriqMg5/7HdEneZkw1OoX8LEp9fybEiXHKKZ7Qhp7aN7hNrmV
         cYZb6Dbtv0RVSJKCnOJHtTVgCoylh6Z5614DoQ2yB/aK00u2FILD9EzbjUP07d1P9q3L
         dNWI7kHYq04bDkL29JpYKyB90+PRz5LK0u7wsmOijYNL5KfF2oRRHRc7yrr+LiaPEzDd
         H1OYGf4ZHw9C9fdWnIz86mxu0l4oue2yvUxWeaHYJlSxnprhiY3KyVWq2mGsgbuWxkwh
         uaCQ==
X-Gm-Message-State: ABy/qLaRtUIM2U/JShCN5eO0e7uSKB6LWJ0hQlALwIve4Qx6uAj9TTb6
        vPe91a51jUHRYkrpHNbhFR00JVDDgQwsK+Ipt5HqKA==
X-Google-Smtp-Source: ACHHUZ5mTAPpxbNhYNSgpszF3WnuYH2PV51tm62xSaVgy4bpo+CAIhriuYCoo7xWSfATi1JfQBwW7sG7ccxjqSs1lls=
X-Received: by 2002:a05:6a20:a128:b0:11a:c623:7849 with SMTP id
 q40-20020a056a20a12800b0011ac6237849mr10155512pzk.48.1688395361920; Mon, 03
 Jul 2023 07:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230615152918.3484699-1-revest@chromium.org> <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com>
 <20230621111454.GB24035@breakpoint.cc> <CABRcYmKeo6A+3dmZd9bRp8W3tO9M5cHDpQ13b8aeMkhYr4L64Q@mail.gmail.com>
 <20230621184738.GG24035@breakpoint.cc>
In-Reply-To: <20230621184738.GG24035@breakpoint.cc>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 3 Jul 2023 16:42:30 +0200
Message-ID: <CABRcYmKkDyMBqe0C5AGZVihGQhXzCjsQrg5fBhtTX3qjxe7jOA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        lirongqing@baidu.com, daniel@iogearbox.net, ast@kernel.org,
        kpsingh@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 8:47=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Florent Revest <revest@chromium.org> wrote:
> > > in this case an initcall is failing and I think panic is preferrable
> > > to a kernel that behaves like NF_CONNTRACK_FTP=3Dn.
> >
> > In that case, it seems like what you'd want is
> > nf_conntrack_standalone_init() to BUG() instead of returning an error
> > then ? (so you'd never get to NF_CONNTRACK_FTP or any other if
> > nf_conntrack failed to initialize) If this is the prefered behavior,
> > then sure, why not.
> >
> > > AFAICS this problem is specific to NF_CONNTRACK_FTP=3Dy
> > > (or any other helper module, for that matter).
> >
> > Even with NF_CONNTRACK_FTP=3Dm, the initialization failure in
> > nf_conntrack_standalone_init() still happens. Therefore, the helper
> > hashtable gets freed and when the nf_conntrack_ftp.ko module gets
> > insmod-ed, it calls nf_conntrack_helpers_register() and this still
> > causes a use-after-free.
>
> Can you send a v2 with a slightly reworded changelog?
>
> It should mention that one needs NF_CONNTRACK=3Dy, so that when
> the failure happens during the initcall (as oposed to module insertion),
> nf_conntrack_helpers_register() can fail cleanly without followup splat?

Sure! :) On it.
