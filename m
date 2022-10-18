Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49794602FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiJRPfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJRPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA27695E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666107301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=949/Qi1pDpeDMTUI2Vsxrx0ghbk4aAqTjCByU1zx60Q=;
        b=XcOI/0lXGxMMs+9MGCtDoIkD5xYL/AJiAcjND9IQBxui0tL8nqwcHbMmx+aYHzN4iwMmg5
        yd7i4ncW8In50GY+6S0/P9JeQj9t2f3qXxu/+R1y6ro+TzzOKFE9zFaxmsjddCxzBI5+Pu
        bW5MH+/kDMW3ns7RTNUo7yeimx5Aj1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-WVrt5p-1PuaGMq31yPQtIQ-1; Tue, 18 Oct 2022 11:34:56 -0400
X-MC-Unique: WVrt5p-1PuaGMq31yPQtIQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E64A811E81;
        Tue, 18 Oct 2022 15:34:55 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BDF7C15BA4;
        Tue, 18 Oct 2022 15:34:52 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v4 01/25] rseq: Introduce feature size and alignment ELF
 auxiliary vector entries
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
        <20220922105941.237830-2-mathieu.desnoyers@efficios.com>
        <877d1726kd.fsf@oldenburg.str.redhat.com>
        <d128fb7d-6b24-5caf-8e3a-99d55922cd95@efficios.com>
        <0a4a1a2c-964e-dcc6-948a-fd252962aaff@efficios.com>
Date:   Tue, 18 Oct 2022 17:34:50 +0200
In-Reply-To: <0a4a1a2c-964e-dcc6-948a-fd252962aaff@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 17 Oct 2022 13:32:07 -0400")
Message-ID: <87fsfli1r9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> If we extend struct rseq to a size that makes the compiler use an
> alignment larger than 32 bytes in the future, and if the compiler uses 
> that larger alignment knowledge to issue instructions that require the
> larger alignment, then it would be incorrect for user-space to
> allocate the struct rseq on an alignment lower than the required
> alignment.
>
> Indeed, on rseq registration, we have the following check:
>
> if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq))
> [...]
>    return -EINVAL;
>
> Which would break if the size of struct rseq is large enough that the
> alignment grows larger than 32 bytes.

I never quite understood the reason for that check, it certainly made
the glibc implementation more complicated.  But to support variable
sizes internally, we'll have to put in some extra effort anyway, so that
it won't matter much in the end.  As long as the required alignment
isn't larger than the page size. 8-/

> You mentioned we could steal some high bits from AT_RSEQ_FEATURE_SIZE
> to put the alignment. What is the issue with exposing an explicit 
> AT_RSEQ_ALIGN ? It's just a auxv entry, so I don't see it as a huge
> performance concern to access 2 entries rather than one.

I don't mind too much, we already have a large on-stack array in the
loader so that we can decode the auxiliary vector without a humongous
switch statement.  But eventually that approach will stop working if the
set of interesting AT_* values become too large and discontinuous.

Thanks,
Florian

