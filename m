Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28E5FB9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJKRpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJKRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:45:14 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1FF2E9F1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:45:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p186so11451726iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8xH4szhLQ9lo52EIlDPuABeYiQRNpOGbXO1EMEBvf2E=;
        b=c5vE4z4d062tsOIqsjv8GH+B5jtkv+mViPakJlB3g34EBSUonGSrb9NP7BTicFc3PM
         wmPC+/8PZCLh03AL75qnywtfcBFW79r/gz76F8xr1BN5PW548diBx8ZkJJ6O4z3uJiFm
         YNtxhHfz9E+eSu21kRDkHsvqJZNKdbximbGCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xH4szhLQ9lo52EIlDPuABeYiQRNpOGbXO1EMEBvf2E=;
        b=Z8qSY4KvEpeA+WQ+swhOmyn5fBdKyZUoAoX2WLERmfM2kuzwHN1vybA/uVae4rztAj
         HJ4Bi8Qz6585rfzsE5Gz9uEybvuri5ykdwd5BuWGrHWczY9oXtDlJ2cuS6Hi3kGr3svN
         LNducUVTGwjmV9Kg5T8SZaYNrAD1hTiCTiyWnhatEcEsGFoEK+/TH/WvG/2YLpZ6sGbS
         9cew7+Ua3v0hLSVi2r5oKNrWPdXfq/B7AqlkJ/ywCqme86V5K6SbdB+QXkIMVRfmVqJJ
         Klwldv8xGMiG/12dnBeZzTcHu3Ri6MBtmDsIXvp/RvsY7hv8JKnQkbo+Bs87+rBOy8rs
         4mZg==
X-Gm-Message-State: ACrzQf3LDVs1weBqwdvtVeT6+Ewgg+arJTRLwpUYs/lAjPSJDuI4p0IO
        puevRMrK7Rj8QdOSB0czHET0l8+qdpkhHWW4eMO3aw==
X-Google-Smtp-Source: AMsMyM6fzT2TKdbM6buZFdhAM+QZcR7gjpiR1Y1MzI9STAunA5zQ0SQTFcYkv1hUPMwJHM5lOIZe4iR++FTh+VBA5no=
X-Received: by 2002:a05:6638:40a2:b0:35a:bd14:1a31 with SMTP id
 m34-20020a05663840a200b0035abd141a31mr13552857jam.107.1665510312785; Tue, 11
 Oct 2022 10:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org> <20221006191130.GC4196@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221006191130.GC4196@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 11 Oct 2022 13:44:59 -0400
Message-ID: <CAEXW_YRuPQWdqEvk-5T4Kn2y_kPDtB1wby490uue8=BUS1UWjg@mail.gmail.com>
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 3:11 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[..]
> >  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > -                             bool *was_alldone, unsigned long flags)
> > +                             bool *was_alldone, unsigned long flags,
> > +                             bool lazy)
> >  {
> >       unsigned long c;
> >       unsigned long cur_gp_seq;
> >       unsigned long j = jiffies;
> >       long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > +     bool bypass_is_lazy = (ncbs == READ_ONCE(rdp->lazy_len));
>
> In the alphabet, "b" comes before "c".  Picky, but it does make these
> things easier to find.  Which can be important when you are searching
> for all occurrences of something -- nice to be able to find the variable
> in alpha order without interrupting your search.

For this comment, I cannot reorder it because it will break as ncbs
needs to be defined before it is used. I will leave this one alone if
it is Ok with you.

I am OK with all the other comments.

Thanks.
