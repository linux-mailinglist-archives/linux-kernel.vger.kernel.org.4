Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7A72CA10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjFLP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjFLP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D81738
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686583703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BX+Ma33nBxxjF/8MZMG5YZCp8D2YlmQXE4UFiVBdJUU=;
        b=Rq79Z/m7WAb2+nwcVy5Chj6Om3T8ZCQSnIt7sWJa+48NRTSGZybbA/l1TMoEoN2WcQcUfx
        14N0gfm6EBN2FjQNyevvTOuCbYZxP/1uSkKujzmeKUR5x+/adQ5JJp62aoV/lhXJ6OMYy9
        W8U5MHxyFVwg97FRiU0kYznXy9KYsDw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-KE07oRFdPa6XGwCkuI4eNw-1; Mon, 12 Jun 2023 11:28:19 -0400
X-MC-Unique: KE07oRFdPa6XGwCkuI4eNw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30fc7ab9ff3so231261f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583699; x=1689175699;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX+Ma33nBxxjF/8MZMG5YZCp8D2YlmQXE4UFiVBdJUU=;
        b=Y97m1fwKrm7rA2rELEFiSVmSTk7eazkkLZwbbbN2ydS/6zQ2F1BJT+ck5MBtGA8mH0
         IzydoYd4YMgiYgVpTtNgr8aFTjZr/KayhAw89TjZioILaAaVCXCKhC8iTTjydDsWohLP
         StWHil+dOG+X/KkZPVZdWHqWmUOqmpSd+ewam2S3bDcjIlVBcM/nq/g4gdn2lZ4mrGf5
         L0Ywo45owzpERpHwsCKuqamT+XOwcO3tZ6G2S+bDmdIjqGv0WXPYfmqMA9r68SOBNn+L
         UfJmeyHDHnWA74eDwtuF2Ezr1J9f+CSO24FlaKHVdKkbKC5OZ//vaf5Q46+0CQxD+UT+
         nmlg==
X-Gm-Message-State: AC+VfDwjynNHakfFWtQAuBYI0Wczb4+uGjEbPidsGToXiMj2Cipffxi8
        erVPdeDksqcw6DeGJ6L4MBNBCXLummEoN9kjOq9GNnAsHX4NhPLewMepvLs4cpA3nZgOMZnCQQv
        snuWA16ZG6OlfYrWfsFL+QyqI
X-Received: by 2002:adf:d0c1:0:b0:30e:455d:930c with SMTP id z1-20020adfd0c1000000b0030e455d930cmr4700823wrh.6.1686583698835;
        Mon, 12 Jun 2023 08:28:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5XJF1iicqVdwYskYIHL5hSohDzgJqNsuxo39HlEPPhMTMK+fmWXwAXWP/XWeMHe4eovnBVaQ==
X-Received: by 2002:adf:d0c1:0:b0:30e:455d:930c with SMTP id z1-20020adfd0c1000000b0030e455d930cmr4700811wrh.6.1686583698464;
        Mon, 12 Jun 2023 08:28:18 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id g26-20020a7bc4da000000b003f60e143d38sm11706261wmk.11.2023.06.12.08.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:28:18 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        android-kernel-team <android-kernel-team@google.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RESEND][PATCH v2] sched/wait: Fix a kthread_park race with
 wait_woken()
In-Reply-To: <20230602212350.535358-1-jstultz@google.com>
References: <20230602212350.535358-1-jstultz@google.com>
Date:   Mon, 12 Jun 2023 16:28:07 +0100
Message-ID: <xhsmho7lkya2g.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/23 21:23, John Stultz wrote:
> From: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
>
> kthread_park and wait_woken have a similar race that
> kthread_stop and wait_woken used to have before it was fixed in
> commit cb6538e740d7 ("sched/wait: Fix a kthread race with
> wait_woken()"). Extend that fix to also cover kthread_park.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: android-kernel-team <android-kernel-team@google.com>
> Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> [jstultz: Made changes suggested by Peter to optimize
>  memory loads]
> Signed-off-by: John Stultz <jstultz@google.com>

Funny one, IIUC this will happen with any wakeup of a wait_woken()-user
that doesn't touch the wait_queue entry.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

I do have on question: what about signals? Browsing through wait_woken()
users, it looks like a few of them have a wait-loop break condition hinging
on signal_pending() (iio_buffer_read() is one of them). signal_wake_up()
doesn't touch the wait_queue entry, so is that a similar issue or am I
looking at a non-problem?

