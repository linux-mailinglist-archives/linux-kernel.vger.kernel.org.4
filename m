Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6171770E76B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjEWVhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjEWVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:37:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96765126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:37:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d3578c25bso5121b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684877837; x=1687469837;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VO6eLPU/aA233thOtId6HlTxErgTCHCdwyM9bTKsmZk=;
        b=iuQxrhXE9Bupo9hGLnd39Ks6KE5M1W+KY/nOLwboBl9xB/yUF+a9HiogBfwxYNBY3o
         YVMxop0Dv5Pq3mI4ywtXKtJJ1EiYS9qOuZGhy8ACXpQZtwfR2Dr+BcU//aWZ62tcBQ2k
         P9ei5/z7sKRQ/YSMCwU8devVd2JLG8yhevJ7lV86+T9DhPegiZCeDB2tDXQtXoyl0IDM
         sjQI8pW7IA5pZ2ILYHuQCNtsvhlAtw9H2X0uBPG33jxI5kHLwkpgNikm3XvBJCsVjp7w
         +ZY6dEdIEsZZsKCgXrLLpzQFw252YeWZjCy3P3YpiAo+cME2OZTMDt59GHqO5uQLOOl1
         VHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877837; x=1687469837;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VO6eLPU/aA233thOtId6HlTxErgTCHCdwyM9bTKsmZk=;
        b=RSzX5YWdZl9O+KAwf2wpDCiun8zM0RnvmGY2ihnfrZYZrq3jVVk7M8cSc2MTEM+2JQ
         3klpd9JXDI/yp6IZKp+zyTR4rUtgrgQuwkHtMQIRb1/VAJDTAf9JzGm9MCfXSK+aj+N5
         wbfhNDH2QG8z6CpTeOCchZXs1gb+onB7GxE5Or7Dlk3gkpNXGb/Pkwc9jSCRLvwW4scl
         cOePfb+Zd31kwitzjc1/G8ijpuEJp4fr8JXk+UVaFd2my/4Y1ueVogNT/YBFWZcxjI2d
         K20aAYyvZ/GjYyPCz9XCWfc1Hp48AmHMb/nIJp3Uaoyb/idhyNvAKos4gZvC3uMVyCPN
         UG2w==
X-Gm-Message-State: AC+VfDynB8TVhfGrva4rjz409jDVE439jBlAHfWn+Bc3SAVgz2YIKXBP
        +kEAD1QwmpJJRAhVIXDNLuk=
X-Google-Smtp-Source: ACHHUZ7UPjE5UqO6gHP6XwMr57d+KMb5iZkIqTVrHAKugXgIlKCfQ/xdt/6ornZbMPmwBp/9hf2Nzg==
X-Received: by 2002:a05:6a20:8e15:b0:10d:b12:cc9 with SMTP id y21-20020a056a208e1500b0010d0b120cc9mr129279pzj.24.1684877836870;
        Tue, 23 May 2023 14:37:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7a1e])
        by smtp.gmail.com with ESMTPSA id w124-20020a636282000000b00528e0b1dd0bsm6508891pgb.82.2023.05.23.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:37:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 May 2023 11:37:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
Subject: Re: [PATCH 03/24] workqueue: Not all work insertion needs to wake up
 a worker
Message-ID: <ZG0yCiRI8apvfWkq@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-4-tj@kernel.org>
 <CAJhGHyCdgfNY83ddpQRpsCVvPQF9HtuNXXFFbpJuxYLL+mYcZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyCdgfNY83ddpQRpsCVvPQF9HtuNXXFFbpJuxYLL+mYcZQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 05:54:10PM +0800, Lai Jiangshan wrote:
> On Fri, May 19, 2023 at 8:17 AM Tejun Heo <tj@kernel.org> wrote:
> 
> > +       pool = pwq->pool;
> > +
> >         /*
> >          * If @work was previously on a different pool, it might still be
> >          * running there, in which case the work needs to be queued on that
> >          * pool to guarantee non-reentrancy.
> >          */
> >         last_pool = get_work_pool(work);
> > -       if (last_pool && last_pool != pwq->pool) {
> > +       if (last_pool && last_pool != pool) {
> >                 struct worker *worker;
> >
> >                 raw_spin_lock(&last_pool->lock);
> > @@ -1638,13 +1636,14 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
> >
> >                 if (worker && worker->current_pwq->wq == wq) {
> >                         pwq = worker->current_pwq;
> > +                       pool = pwq->pool;
> 
> The code above does a "raw_spin_lock(&last_pool->lock);", and
> the code next does a "raw_spin_unlock(&pool->lock);".
> 
>                             WARN_ON_ONCE(pool != last_pool);
> 
> can be added here and served as a comment.

Yeah, this is a bit confusing. Added WARN_ON_ONCE().

Thanks.

-- 
tejun
