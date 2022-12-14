Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63B964D30B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLNXLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLNXK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:10:58 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F3F11146
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:10:56 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z4so8268731ljq.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vPbJtGVICGi21b9X/GDOOs7MaYuwlHUqxPV3Gfg7e4Q=;
        b=gv3hlHp4zhRp3YnpmtITYMaAdFQM73+9U3oC6Qvs0EwGGrZBjmyA40cyO6wfepz7vK
         XavMuYSKd+gNsL7dxIEyDLL9rixP9b6a7V2FOdZQvNp2eBV93QgO3RAW1elXvyyyVGYl
         EoO0nXr8CJjcku/eL7+eqQbssjsLzVkXf3bVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPbJtGVICGi21b9X/GDOOs7MaYuwlHUqxPV3Gfg7e4Q=;
        b=vGl70jaRU7LkQgMt1Tj+qZWFLBYcrzm9QR/I54O9R/B8SJAeuG03pyAz8Q7I4y6OHD
         11FdZ3Mqs3Kq0Sh/EG1LOrXhKzfyWNTvzTX54FeQhlRdedi5C5LW87/4uIR0dUFZP5OT
         WWxhHAxoHeIohVTlOPNU2fY7RvZ1Zz4mXLoIJc0tf1POUZCCbzYxwDHgg7RDWI2QqiFE
         Pw04DyUko0LaS0TPjZIB1s8SJZ9qmT8gXiZdiCd5Y8geh7VHw2PClJQZxA9BjYi2IF4d
         YMzuluLKTd3NBlxuI1HpuKDsSMlStwlfi7RPr0Ce/4rBVYardUoV0P0nbgFLQtDC6J3+
         8Vtw==
X-Gm-Message-State: ANoB5pnyDUOhK6+HqkEFfkDrSBhrDCGPN7YS+zWQj2BmBobIkimok2yq
        jgC0D6cG6UyBbRDZHi57s9Mu8HsyutxA2bGd5sxVaQ==
X-Google-Smtp-Source: AA0mqf5RsdGmKzoVfCYQZR6n2uhQzTyWAuO2oZHXdncJmKGSmczZztD8TtdaqkxDiYHFK6mABgeBC37/MsRZlOagtI0=
X-Received: by 2002:a05:651c:90a:b0:277:309:73cb with SMTP id
 e10-20020a05651c090a00b00277030973cbmr33192896ljq.371.1671059454605; Wed, 14
 Dec 2022 15:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
 <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
In-Reply-To: <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Dec 2022 23:10:43 +0000
Message-ID: <CAEXW_YRvSrD40WJ+8GicWB5NN8QyLLoUzRS9j8Tc9CMvojKO0g@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:07 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Dec 14, 2022 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > I also did not get why you care about readers that come and ago (you
> > > mentioned the first reader seeing incorrect idx and the second reader
> > > seeing the right flipped one, etc). Those readers are irrelevant
> > > AFAICS since they came and went, and need not be waited on , right?.
> >
> > The comment is attempting to show (among other things) that we don't
> > need to care about readers that come and go more than twice during that
> > critical interval of time during the counter scans.
>
> Why do we need to care about readers that come and go even once? Once
> they are gone, they have already done an unlock() and their RSCS is
> over, so they need to be considered AFAICS.
>

Aargh, I meant: "so they need to be considered AFAICS".

Thanks.
