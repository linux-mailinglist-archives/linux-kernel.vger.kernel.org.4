Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D4A6371BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 06:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKXF0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 00:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXF0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 00:26:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11101BF82B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 21:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669267551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1BJTv1yw1TZn6Ej/2m7IJg8ynAjrSeGYMGPtsYN1BeU=;
        b=JcqUWDvjZsZOIk+RWQDdIZfTRXiITLRjqhBYRY17XQsVFTeNSSFQcXOJnhYToYJlPb1Gom
        eh497hD3cVEA19l7LYFz8mCHV+vXfZ9YKVsbvt/tBBZWPWU1KwNVJqUUhxDxHvBxF8fPS+
        AP/0gRMUSLyr2VCf/WjrckAuDRwwnII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-EWPiQi1WPDiKMhuQin-LmQ-1; Thu, 24 Nov 2022 00:25:45 -0500
X-MC-Unique: EWPiQi1WPDiKMhuQin-LmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76EA6101A52A;
        Thu, 24 Nov 2022 05:25:45 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9086FC15BA5;
        Thu, 24 Nov 2022 05:25:43 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v6 1/3] random: add vgetrandom_alloc() syscall
References: <20221121152909.3414096-1-Jason@zx2c4.com>
        <20221121152909.3414096-2-Jason@zx2c4.com>
        <87v8n6lzh9.fsf@oldenburg.str.redhat.com> <Y37DDX5RtiGsV6MO@zx2c4.com>
Date:   Thu, 24 Nov 2022 06:25:39 +0100
In-Reply-To: <Y37DDX5RtiGsV6MO@zx2c4.com> (Jason A. Donenfeld's message of
        "Thu, 24 Nov 2022 02:04:13 +0100")
Message-ID: <87a64g7wks.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jason A. Donenfeld:

> Hi Florian,
>
> On Wed, Nov 23, 2022 at 11:46:58AM +0100, Florian Weimer wrote:
>> * Jason A. Donenfeld:
>> 
>> > + * The vgetrandom() function in userspace requires an opaque state, which this
>> > + * function provides to userspace, by mapping a certain number of special pages
>> > + * into the calling process. It takes a hint as to the number of opaque states
>> > + * desired, and returns the number of opaque states actually allocated, the
>> > + * size of each one in bytes, and the address of the first state.
>> > + */
>> > +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned long __user *, num,
>> > +		unsigned long __user *, size_per_each, unsigned int, flags)
>> 
>> I think you should make this __u64, so that you get a consistent
>> userspace interface on all architectures, without the need for compat
>> system calls.
>
> That would be quite unconventional. Most syscalls that take lengths do
> so with the native register size (`unsigned long`, `size_t`), rather
> than u64. If you can point to a recent trend away from this by
> indicating some commits that added new syscalls with u64, I'd be happy
> to be shown otherwise. But AFAIK, that's not the way it's done.

See clone3 and struct clone_args.  It's more common with pointers, which
are now 64 bits unconditionally: struct futex_waitv, struct rseq_cs and
struct rseq.

If the length or pointer is a system call argument, widening it to 64
bits is not necessary because zero-extension to the full register
eliminates the need for a compat system call.  But if you pass the
address to a size or pointer, you'll need compat syscalls if you don't
make the passed data __u64.

Thanks,
Florian

