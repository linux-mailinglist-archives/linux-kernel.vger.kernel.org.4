Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56B73A05B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFVMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjFVMBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:01:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209CA1FDF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:01:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-988c30a540aso541351766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687435272; x=1690027272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJO36223izG+C9qQi7iamTccoqBJo/QNHYh7HXecRzA=;
        b=G6Dp7eTk94QKFAHD259XrKUe6Qkc1Moib9RTbUECpD8CK7w5ozkeV/iVXfAA68p4Ac
         aaEj7jIstcKWPftk0pZh6GnNpuTcJTyA+pWOVRqVVcLLEB7jO3omcn1chowFf9SLKQHT
         FFWlAWO87r2D3LzG8kedZKyeIjCXeQrm87cUfCcREgenIbMi0wzBwQ1WT8oCy0pN0ADt
         yPCAjFcj+8LkvOIHIBFcVaKfUw2zfZjnTmEimO/UfGfVlHhHctEperKt6Aug4KUOC9tp
         8C0xljUbvR8y6fRV66cFQ+xvHKnD25Cl0XLIOSe6RxF5zmcONVvPzldkle8tUg+NcptR
         zhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435272; x=1690027272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJO36223izG+C9qQi7iamTccoqBJo/QNHYh7HXecRzA=;
        b=NO6/W0o6yUvgSCmExPoI19/P1/PTcD/nF4m3aZViC9QDc/C5/1cGjP/QBtfaN1SH/T
         bhxAKbeQBEx0rFEE8bhFi23XaOPNwZUED28WE3U2GVxh3itwk2DHOP7AopjDf8GRVaxr
         H9WY3TJ8s72MC5MMcA3moVFF/kC6defr3c4S6V0TW0GHY6gFJDmnlQrC6FkKWReR3SJU
         g8MDm7u8SKE3yFhbMk4bQDbc333FigT29JUioGiWQtdF7TizJtP8j92R+WWbnO0qiotN
         TOlOgto0KAj9fXfQNA4w8M6Lq0Svt22F16wvRWFJ/z17RJjQ4+LZbbhMkn265RL1K2lT
         s80A==
X-Gm-Message-State: AC+VfDxnbndgrE8yq0AlFr1ElPTrT12Oa+wotpHPWZm7DpfPAC1A1iXl
        CEciCM8d4Emu9ta5BrnkYwM=
X-Google-Smtp-Source: ACHHUZ4HzGbtHbMLHa4pubZ1PFW/hPDlDPFZ8YSaf50fndXACzWoLhuv9P4ywl9FJ+EnYBC4ruvTIw==
X-Received: by 2002:a17:907:728d:b0:988:f2ad:73e9 with SMTP id dt13-20020a170907728d00b00988f2ad73e9mr7810771ejc.52.1687435272255;
        Thu, 22 Jun 2023 05:01:12 -0700 (PDT)
Received: from gmail.com (1F2EF3D5.nat.pool.telekom.hu. [31.46.243.213])
        by smtp.gmail.com with ESMTPSA id m25-20020a17090607d900b009883a3edcfcsm4620183ejc.171.2023.06.22.05.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:01:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 22 Jun 2023 14:01:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 08/15] sched: Commit to EEVDF
Message-ID: <ZJQ4A2Jm4VoGMKbl@gmail.com>
References: <20230531115839.089944915@infradead.org>
 <20230531124604.137187212@infradead.org>
 <20230616212353.GA628850@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616212353.GA628850@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joel Fernandes <joel@joelfernandes.org> wrote:

> On Wed, May 31, 2023 at 01:58:47PM +0200, Peter Zijlstra wrote:
> > EEVDF is a better defined scheduling policy, as a result it has less
> > heuristics/tunables. There is no compelling reason to keep CFS around.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/debug.c    |    6 
> >  kernel/sched/fair.c     |  465 +++---------------------------------------------
> 
> Whether EEVDF helps us improve our CFS latency issues or not, I do like the
> merits of this diffstat alone and the lesser complexity and getting rid of
> those horrible knobs is kinda nice.

To to be fair, the "removal" in this patch is in significant part an 
artifact of the patch series itself, because first EEVDF bits get added by 
three earlier patches, in parallel to CFS:

 kernel/sched/fair.c     |  137 +++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/fair.c     |  162 +++++++++++++++++++++++++++++++++++++-----------
 kernel/sched/fair.c     |  338 +++++++++++++++++++++++++++++++++++++++++-------

... and then we remove the old CFS policy code in this 'commit to EEVDF' patch:

 kernel/sched/fair.c     |  465 +++---------------------------------------------

The combined diffstat is close to 50% / 50% balanced:

 kernel/sched/fair.c              | 1105 ++++++++++++++++++--------------------

But having said that, I do agree that EEVDF as submitted by Peter is better 
defined, with fewer heuristics, which is an overall win - so no complaints 
from me!

Thanks,

	Ingo
