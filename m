Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE3467FA99
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 20:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjA1T5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 14:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjA1T5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 14:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A06233EE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674935815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNU2u372/7Sb65mBBFHPvq/vNgVTuST0kJLjueX9SFk=;
        b=dLtxH+p9abA8bVzEScWz7SBoOc/SlqwzVFWHADRBi/3iLQdK1QHpT5H2uva92XeG4sWjfo
        5dPy924EEdtADAlHqFtJZ4L5cH6YSNSgJmNj5GoW46t/FHOjEy2MsYFZEbYXovIUaMN/4b
        FJL48ZuvGhOLpJ8GeuEiZvtzBl2B7yM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-fpCfCplIM7irVfEIzo9Tqg-1; Sat, 28 Jan 2023 14:56:48 -0500
X-MC-Unique: fpCfCplIM7irVfEIzo9Tqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69FED101A521;
        Sat, 28 Jan 2023 19:56:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-101.brq.redhat.com [10.40.192.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id C490C1400B19;
        Sat, 28 Jan 2023 19:56:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 28 Jan 2023 20:56:44 +0100 (CET)
Date:   Sat, 28 Jan 2023 20:56:42 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20230128195641.GA14906@redhat.com>
References: <20230126105128.2249938-1-dvyukov@google.com>
 <20230126154118.2393850-1-dvyukov@google.com>
 <CANpmjNM=PVigDZKu-H_-cLECUJKSx7TH+kxSjfF=4UHdrGBj+g@mail.gmail.com>
 <87o7qlgjce.ffs@tglx>
 <CACT4Y+aMLeCo9+nwXrFWo8FLG8rKHDe8v2ppkZ+mOaKAF6qtgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aMLeCo9+nwXrFWo8FLG8rKHDe8v2ppkZ+mOaKAF6qtgw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

I agree with what you said, just one note...

On 01/27, Dmitry Vyukov wrote:
>
> After this change the test passes quickly (within a second for me).

yet perhaps it makes sense to slightly change it? It does

	+static void *distribution_thr(void *arg) {
	+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
	+	return NULL;
	+}

so distribution_thr() eats CPU even after this thread gets a signal and thus
(in theory) it can "steal" cpu_timer_fire() from other threads unpredictably
long ? How about

	-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
	+	while (__atomic_load_n(&got_signal, __ATOMIC_RELAXED));

?

Oleg.

