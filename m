Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D6F6FDCE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjEJLid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjEJLic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362F030F4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683718666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6W2Dw41SOm3qVvAWDDmCFfV0SEGNy54raIoegI7jQ0=;
        b=SRj/IcOj77KAZZy6OCBrqbTe3QtAFLk9PTeIcSxXd4wHr05lrwBommZ6BRW2XSGUHz/pCH
        r3Xt/Hx9YQXnPwoZlrj6UQamludmB1GuHKr+7CIQ2jn5TgUYu4GcTbWdcjkF8bSAPnJdcJ
        qrJ0nYm5NMarks8O3AZCGsWKgn1wqnU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-aous2K8HOeqPA54T8Q7MSw-1; Wed, 10 May 2023 07:37:45 -0400
X-MC-Unique: aous2K8HOeqPA54T8Q7MSw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30641258c9eso2454267f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683718663; x=1686310663;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6W2Dw41SOm3qVvAWDDmCFfV0SEGNy54raIoegI7jQ0=;
        b=SkqxfFPpEqaChJocDFeroIvmhNXE0o+l2NJewPwNW637qo+rXVOv1K9WxI42lko5oE
         BOQshFuUXbjSLulFbe8cdQ7Nf7M4N+hSqx1YEfRfoSFqr6/yaeYig2j0Ym+dHriv4qgA
         u/3I9zSdJsn713tz46CDEqaL3cQ0B6kr0Fc+9IhxEL/Vb9klic6hhKq6YN9re5UwMpVv
         cXx8H3ner2b98sqghKAwZuchg4GKFfR3e2jdDR01T45RzjFoBQNHXzZHn1UwG4PE8ovP
         CQwwnFuf6H5X6zonUyr1v2f5P/ZnM1PD2Hh/YmAPdr4ZizQ/mkzeq8iSXwfpqkgiKnlR
         vrkg==
X-Gm-Message-State: AC+VfDwBLcN061z52s2SqdM67+6SPWS7sTkAgKg+uLZD/oZdRVNUpATr
        XAoJ4rQ/hV4dKfVXTQpIdlxWilUCK/g0v6dFMWDjQvehtEQhSylCtO+niyWPEZg6WZYDiwgYrqH
        kkf7PPlYGc+KuOv9Am9j0Qi4mZyQfD5sW
X-Received: by 2002:adf:ee46:0:b0:306:26d7:3805 with SMTP id w6-20020adfee46000000b0030626d73805mr12746643wro.63.1683718663783;
        Wed, 10 May 2023 04:37:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55hv52rdA9ePi18bMW8pKcGBFLT/tiSzgCXsRLDdbk5GEk3fHYjtKTRQQdDL62Wkv1T/cUPg==
X-Received: by 2002:adf:ee46:0:b0:306:26d7:3805 with SMTP id w6-20020adfee46000000b0030626d73805mr12746627wro.63.1683718663512;
        Wed, 10 May 2023 04:37:43 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id q18-20020a056000137200b003063176ef09sm17328517wrz.6.2023.05.10.04.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:37:43 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [ANNOUNCE] v6.3.1-rt13
In-Reply-To: <20230509164640.-aaZNrjH@linutronix.de>
References: <20230509164640.-aaZNrjH@linutronix.de>
Date:   Wed, 10 May 2023 12:37:42 +0100
Message-ID: <xhsmhy1lwifi1.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/23 18:46, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v6.3.1-rt13 patch set.
>
> Changes since v6.3.1-rt12:
>
>   - Two posix-timers picked-up from the list. They are scheduled for
>     upstream inclusion. One of prevents a livelock on PREEMPT_RT in
>     itimer_delete(). Patches by Thomas Gleixner.
>
>   - A softirq handling patch from the list 'revert: "softirq: Let
>     ksoftirqd do its job' from Paolo Abeni. This revert should reduce a
>     lot of trouble which start once ksoftirqd is woken up.
>     The 6.1-RT series has the ktimersd thread which mitigates some of
>     the pain. This patch should render the patch obsolete.
>     Should everything work out as expected I intend to backport this
>     patch the earlier RT series and revert the ktimersd patch in the
>     v6.1 series.

The ktimersd threads solved some priority inversion problem we were seeing,
IIRC it looked something like so:
- GP kthread is waiting on swait_event_idle_timeout_exclusive(...)
- p0 (CFS NICE0) did spin_lock(L) then got throttled by CFS bandwidth
- p1 (CFS NICE0) did local_bh_disable() + did spin_lock(L)

So p0 owns L, but cannot get bandwidth replenished since local softirqs are
disabled, and the GP kthread can't be woken up by timeout to initiate
boosting either.

Even if ksoftirqd has its priority tuned to ensure timers can be expired,
the above never wakes ksoftirqd due to:

static inline bool should_wake_ksoftirqd(void)
{
        return !this_cpu_read(softirq_ctrl.cnt);
}

on the other hand, ktimersd are woken up unconditionally, so in this
scenario it gets to run and donate its priority via

  ksoftirqd_run_begin()
  `\
    local_lock(&softirq_ctrl.lock)

(note that this only solves the CFS bandwidth issue if ktimersd are FIFO or
above, but they are spawned as FIFO1)


TL;DR: for RT, I think we should also kill should_wake_ksoftirqd()

