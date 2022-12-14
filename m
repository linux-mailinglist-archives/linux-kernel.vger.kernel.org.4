Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180D64D319
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLNXPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:15:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D93315FED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:15:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j4so13058622lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzdgOz9gyjgH/qFtgaJL32M0dERZsKAxOLJDC6S8iQY=;
        b=XClglf5f+07TSaa2FELqubUMVQofVbKWE0rHR3vTLkFBamNmofDKIXp+8dPy2J0EGA
         5IyuqtNyK6Fv1uiHblBAkxuQBEwj+pAWFkoTdHXYDIZtPfObeZVnzMggavti4/di/niy
         gXNFu+PXnwQqqkQtZVtMSxAuKYDFegntYu2rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzdgOz9gyjgH/qFtgaJL32M0dERZsKAxOLJDC6S8iQY=;
        b=12mR0e/EiDqm6Nj/EH7vS+BqaREX4QX9rZC3m5CJi2wbM0x0IF0KyAzjY6cbXLR6X0
         uUEtrQvbtTNw7i46f6/DnvOd9thBySFhmZYYyW0K5zQMRkXEYCkXCajNhy4suuOONizh
         mU0s1RUpgoXAbd0d8tTg0rQ0md2BOEwHsGqqQoWaO5kYl3B8YZjsQTNfRsCw8uzY/j2M
         NE381oBN8SRtUpkh4gXyPEqYbyRtC+UujtfF6V9hFmGm0goi4OBP48vOVsjm4AyLIJQd
         JyVueB4M/bunyroFE5fHwD0fbelOwSKDNSrHNaoYBl6JjsX4T4ES9PMsIxSTL9RxpoeF
         yhJw==
X-Gm-Message-State: ANoB5pkLFe3AO+i4go/opUp+pUrNbNJNcEbVGoIxvdByIZGtOpWgLCnW
        dtqwFucH6ktAqj5oHl6DqhnKUb9WmrQjBf7aCpwdHg==
X-Google-Smtp-Source: AA0mqf6gRfFfYu+dHou0MOsrfZ3Kk7Ne2XNfijmAQ+m6/3UVcFQsCPe4RlKT4jq4SRiO/YekkPUrenaa1YpAWL6aE9M=
X-Received: by 2002:ac2:5442:0:b0:4b5:1e8:9594 with SMTP id
 d2-20020ac25442000000b004b501e89594mr20417185lfn.583.1671059699364; Wed, 14
 Dec 2022 15:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
 <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
 <CAEXW_YRvSrD40WJ+8GicWB5NN8QyLLoUzRS9j8Tc9CMvojKO0g@mail.gmail.com>
In-Reply-To: <CAEXW_YRvSrD40WJ+8GicWB5NN8QyLLoUzRS9j8Tc9CMvojKO0g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Dec 2022 23:14:48 +0000
Message-ID: <CAEXW_YQx78ge_U7asX4YHcsi1EDZSRo_wGN_DJmWnXcAYjHWgQ@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Dec 14, 2022 at 11:10 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Dec 14, 2022 at 11:07 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, Dec 14, 2022 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > I also did not get why you care about readers that come and ago (you
> > > > mentioned the first reader seeing incorrect idx and the second reader
> > > > seeing the right flipped one, etc). Those readers are irrelevant
> > > > AFAICS since they came and went, and need not be waited on , right?.
> > >
> > > The comment is attempting to show (among other things) that we don't
> > > need to care about readers that come and go more than twice during that
> > > critical interval of time during the counter scans.
> >
> > Why do we need to care about readers that come and go even once? Once
> > they are gone, they have already done an unlock() and their RSCS is
> > over, so they need to be considered AFAICS.
> >
>
> Aargh, I meant: "so they need to be considered AFAICS".

Trying again: "so they need not be considered AFAICS".

Anyway, my 1 year old son is sick so signing off for now. Thanks.


 - Joel
