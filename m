Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362506032FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJRTFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJRTFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:05:47 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88CB6D847
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:05:45 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o13so7966768ilc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NvzPrSaZfa3ceXOG8MzxaBj8/gxmb/VsuOFjciM5eVk=;
        b=MwyIxjtNwXGJIkL1oFalmkQzo56zPYegOXEjRP8Vg+KRvEj2FlFh7pZ4kWhKGER+Hm
         qxvw5dNgPBGTppXvQGCBjam0hnOXkoJotuQ9mm0d7/wAcq1WCaG3pqIhLGG5acw8i+UA
         yXUxdQ6+ANs5E8vyy377kvZQW8zd7T4ZqHo1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvzPrSaZfa3ceXOG8MzxaBj8/gxmb/VsuOFjciM5eVk=;
        b=YWGu7hetis5nEwm7sojI6tDtGdaKKFw+Ry9n+14RppkaPhcRVLZ8JshkBgYMnYSNda
         L6E/OCj4Z0e/lfk0zraajA90+l9OSDdoTGNGbgV/45g2+YjGtpXv3Va1/NuZTaZiGVGI
         Jg3NIA8KeI2Uw9SGOLAJ8UKCYtq7hj/e4eTP08kEDIo4pvXJyLp80BOHUGgsfvK5Yblo
         lWFPTQ1lKbx4dYEuurNbGaBqxaRgaxODnkuisYAPDk8wmSiAPsJNzgcBEioTxI+hVQsK
         0kjQJ2GNoQ4bdBkL9Pzf2s60lkLGb20oeiaMhXvSwCOHyO38N07Fc2kJ48OeP72sMdwm
         e7UA==
X-Gm-Message-State: ACrzQf1JlCy0i41byg0KPPi/goRb2v1JoA1m/Iz9f+S45HGGbV6o654E
        QB189cN8DV3MZunE/PDsBNvSeyPQB+uJJpOxglq4Sw==
X-Google-Smtp-Source: AMsMyM4JG7oLiNEOYaeGnE9AjJMa/amTHZn9vjIAuIXbxdposRNZe6t2767GGvHO/Tn3iDihAW4WYh3n8aHrKsXhMuU=
X-Received: by 2002:a05:6e02:1c47:b0:2fc:2672:d9c6 with SMTP id
 d7-20020a056e021c4700b002fc2672d9c6mr2665032ilg.35.1666119945229; Tue, 18 Oct
 2022 12:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221018013906.3890007-1-qiang1.zhang@intel.com>
 <20221018104533.GC1166572@lothringen> <20221018175034.GU5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221018175034.GU5600@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 18 Oct 2022 15:05:33 -0400
Message-ID: <CAEXW_YSaFKb7uv+wQnfdEEm41tAiXjEb=bge_0AtNFsQ2s-6Ug@mail.gmail.com>
Subject: Re: [PATCH] srcu: Export srcu_check_nmi_safety() to modules
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 1:50 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Oct 18, 2022 at 12:45:33PM +0200, Frederic Weisbecker wrote:
> > On Tue, Oct 18, 2022 at 09:39:06AM +0800, Zqiang wrote:
> > > When enable CONFIG_PROVE_RCU and built modules, the following
> > > error appear:
> > >
> > > ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefined!
> > > ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!
> > >
> > > This commit fix it by exporting the srcu_check_nmi_safety().
> > >
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> > Paul, whichever way you prefer, editing the commit or adding this
> > one on top.
> >
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> Thank you all!
>
> This is what I currently have, folded into Frederic's original.
>
> Thoughts?

Looks good to me, has this caught any issues yet?

Thanks.
