Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6326FED1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbjEKHtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjEKHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:49:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CBC46A5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:49:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4eff50911bfso9166768e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683791379; x=1686383379;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ogUO1+9WQ0TMBvbp1ZdwZXcU/JKcXFgSqQBuNVE8KE=;
        b=pQlzFdrNeavWaUD6BVP6xR2FQqjg7PgSHyNLBMDYeP+jMg874tlg/EisF9Lk9YFmOB
         rnfHrVFIUH2lGirR9klG/K8sjNksCIvr6zvhyXIM46mdRdR7jhrKFQxGusJ2LWXqHVkS
         oOGYks8Qi7V+8a8puDCy6Vx/Zw6tL0Sd+a+YLZ9CjuSbVlb7J0KQmhq4Cvc0nG5oYVoy
         l2JT3D3k9+RClBVUxx7u5yxZXC20xVOPlHy3H2oinhMfTtlodcwhMqZN4J0NvIoizZWB
         XQv95ZjPvB/R/xpzM3Z4WnkaeKMOuzQisuAErJpLoSz6+UiFfAqj/C9kj4XgBvp6LM/Q
         D1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791379; x=1686383379;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ogUO1+9WQ0TMBvbp1ZdwZXcU/JKcXFgSqQBuNVE8KE=;
        b=dEwMuOekcZrol4K6PhgKiLR4fYK9cIs0+SQpeuM/jgSTuApNaVy67doz30a58F+e05
         Bmzyr7snBIjxfobJvkzGxdj8LjrJbCUuED3L8eRMu9mmzM2dzst5HNw7GTUDUeBrAW+E
         cxYDqnJ+Vdku+0O22nxtk+3I7RB3l6wl1/E3p4Ln3jg6S2qzFkGmuEQ9dI6mSJzAT1UD
         fisW3lNY2jyoSBOdFXI7QReKB01xXvQzVNzXyBuSKcO6oUlnK/KRLTbHj3jNTZTnRI+k
         rhT+j21s6wVBMtTHuBa4ZMqdniKzAcigxCbppXDdK0iBoRCpHiSPX0nFjYRSH+uz+WMU
         YjKA==
X-Gm-Message-State: AC+VfDwBWGkdfPf58HGaWgNotThNS/BIKpZk/tD7v0M0Pit/WQ+a7e6f
        YFeF4v+nY4LcETXcRVbSyUE=
X-Google-Smtp-Source: ACHHUZ4iSiIFbFUzjj4CY5kOAlevI8zQu0hPS09SydIKGPYiGdCMM0Ik3joyKTtNk2BPUW1So/roBw==
X-Received: by 2002:ac2:53ae:0:b0:4f1:44c0:a921 with SMTP id j14-20020ac253ae000000b004f144c0a921mr2816460lfh.55.1683791378978;
        Thu, 11 May 2023 00:49:38 -0700 (PDT)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id n21-20020ac242d5000000b004ec8b638115sm1012395lfl.193.2023.05.11.00.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 00:49:38 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 1F73F5A0020; Thu, 11 May 2023 10:49:37 +0300 (MSK)
Date:   Thu, 11 May 2023 10:49:37 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andrey Vagin <avagin@openvz.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [RFD] posix-timers: CRIU woes
Message-ID: <ZFyeEa87P903Orr1@grain>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de>
 <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx>
 <87v8h62vwp.ffs@tglx>
 <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx>
 <875y911xeg.ffs@tglx>
 <87ednpyyeo.ffs@tglx>
 <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 01:16:26AM -0700, Andrey Vagin wrote:
... 
> Hi Thomas,
> 
> If you give us a new API to create timers with specified id-s, we will
> figure out how to live with it. It isn't good to ask users to update
> CRIU to work on new kernels, but here are reasons and event improvements
> for CRIU, so I think it's worth it.
> 
> As for API, we can use one bit of sigevent.sigev_notify to request a
> timer with a specified id.

Which will do the trick but would look somehow strange I think, since signals
are not some how related to timer's ID. Another option might be to use output
`created_timer_id` parameter as an input cookie.

Say we describe input as

struct {
	u32 magic;
	timer_t timer_id;
};

Then if magic doesn't match we use `created_timer_id` for output only, and
otherwise we read `timer_id` from input and use it. Of course there is a
chance that some unitialized memory passed with existing old programs but
i think false positive gonna be very-very low if ever. Just IMHO.

	Cyrill
