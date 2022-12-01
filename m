Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4956863E825
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLADF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLADF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:05:27 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA536900ED
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:05:26 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y6so261300iof.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghOflYgtAB0SuL/RMkdaiMq8+6Srw84LyKVkATdW1DU=;
        b=leZtn9cMG6mHIEirAPNxnJAGIm9nIhwRxjczYxnnvg47tacl5/lgr1+qfyrdk/1/xb
         ijRhx2I/Sbjef1cYO/LxwVkj8sFbranNXxg1+2fwEaK9PDb//VGuU3kbjY3HCFLUnwa+
         4Ac0Yt4xqJNoDabuWFWloAGzTOYmZm4EVWNUr0rH7eXds61BPld2sGnVmO2f6LnsmTg2
         2D5PvRg7BOvtacGXL3kSRi3P731vR5rO/lm6yuPPENXsKGi7dlqmwWriIEFb0tsSHl+D
         X25oWzq0JJczKdtfJ/PTmN8RRmye5j8rTrWFWLaLj/EepFIRG0f435DxT+57oOUVdfDN
         Rknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghOflYgtAB0SuL/RMkdaiMq8+6Srw84LyKVkATdW1DU=;
        b=VbvtTybvdUBKm8ciuRLcM9+8514hkoUApUac9RXgoGrQLXuWuxoIxguNIV7Tg/FLu3
         cnPYYEkrNf0IY9+IDeQjpAGJPVj5fnxt7WfHnGU1tiPWbz+lIVpNM5mpnJnHzTnD+ANs
         Aga1mZNQImrENaHrdTZ7U/nA9Kd+kJfHjVyBNwUWmzt1rrfpL4+ksShXKLuw6LsDGFdl
         OVhEf4Uddk9A63reOCEWUlZGHqeVlvHF7yHtaXz7xgMf0L6acniN9EONnzRfsBQnEtp3
         PieNQrRaRbnjTWlSTnKrZfm3vhwmP2YY4M7yJlg2wE+kSEeGpW1/oW2i6H7aomgUXsuG
         UVug==
X-Gm-Message-State: ANoB5pmAWPzDEOVQTIvgt3ktVGyhDMkiY6AGkO9HwcJOzfO4H6g3tzX0
        xpH7lsbaSJRD+f7+rWRgTm902grFMTs9Rz4/CJg=
X-Google-Smtp-Source: AA0mqf7n1B6tHyS8ZIe1xJLRNEHJhh71bS05gLk7NQ5XvhBIgPnDmUngjNdrFedKMygDf7R8L7ZPUBZANAQLNrhaCzk=
X-Received: by 2002:a02:2417:0:b0:376:e17:5eaf with SMTP id
 f23-20020a022417000000b003760e175eafmr30131856jaa.56.1669863925991; Wed, 30
 Nov 2022 19:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20221128183109.446754-1-vschneid@redhat.com> <Y4fF7/CtH+sq4KqC@slm.duckdns.org>
In-Reply-To: <Y4fF7/CtH+sq4KqC@slm.duckdns.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 1 Dec 2022 11:05:15 +0800
Message-ID: <CAJhGHyAZymt-17oRKogO287Oak9f28ni6E19qiq+E-6oA2bd6w@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] workqueue: destroy_worker() vs isolated CPUs
To:     Tejun Heo <tj@kernel.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 5:06 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> So, this generally looks great to me. Lai, what do you think?
>
> Thanks.
>

Hello,

It looks great to me too. (except for a defect in patch4)

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks
Lai
