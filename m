Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912946371C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 06:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKXF3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 00:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXF3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 00:29:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E517BC052A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 21:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669267734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGhflT7lV91BCnp7NtGE7AqpEj9layA6kO876k2xPIw=;
        b=VNqOSRZnUovPkwQKAd8Kxr5+cPWRlprTo2RxY2UW5AHQZDGIHK/wgsJk12kmri+ZXSgIQf
        JBCcaj+r3vE2icH0b1BrhP5E32i4Fzu5iDhmNQMTJVyWV4Ylx7PKsT0jUun6wzLyLwf1Wa
        oNYkOOeTKpqxQSAIfWhYLtoMvX6aZpg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-_rHe_3x8NNe4hAAvHdr-eQ-1; Thu, 24 Nov 2022 00:28:50 -0500
X-MC-Unique: _rHe_3x8NNe4hAAvHdr-eQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02B45101A528;
        Thu, 24 Nov 2022 05:28:50 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 318811401C20;
        Thu, 24 Nov 2022 05:28:48 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v6 2/3] random: introduce generic vDSO getrandom()
 implementation
References: <20221121152909.3414096-1-Jason@zx2c4.com>
        <20221121152909.3414096-3-Jason@zx2c4.com>
        <87r0xulzfd.fsf@oldenburg.str.redhat.com> <Y37EHHq41KBvgr8z@zx2c4.com>
Date:   Thu, 24 Nov 2022 06:28:44 +0100
In-Reply-To: <Y37EHHq41KBvgr8z@zx2c4.com> (Jason A. Donenfeld's message of
        "Thu, 24 Nov 2022 02:08:44 +0100")
Message-ID: <875yf47wfn.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
> On Wed, Nov 23, 2022 at 11:48:06AM +0100, Florian Weimer wrote:
>> * Jason A. Donenfeld:
>> 
>> >   static void *vgetrandom_alloc(size_t *num, size_t *size_per_each, unsigned int flags)
>> >   {
>> >     unsigned long ret = syscall(__NR_vgetrandom_alloc, num, size_per_each, flags);
>> >     return ret > -4096UL ? NULL : (void *)ret;
>> >   }
>> 
>> The traditional syscall function returns -1 on error and set errors, so
>> using unsing long and the 4096 is quite misleading.
>
> Not sure I have any idea at all whatsoever about what you're talking
> about. Firstly, the function you quoted is from the "sample userspace
> code" in the commit message, so it might not be code for the context you
> have in mind.

I'm talking about the syscall function that is available through
userspace via <sys/syscall.h>.

> Secondly, it's just doing the thing to figure out if the return value is
> an error value or a pointer. Were we in glibc, we'd write this as:
>
>     return INTERNAL_SYSCALL_ERROR_P(r) ? NULL : (void *) r;
>
> Right? And if you look at the expansion of that glibc macro, it's just:
>
>   #define INTERNAL_SYSCALL_ERROR_P(val) \
>     ((unsigned long int) (val) > -4096UL)
>
> So it looks like the same exact thing?

syscall already does internally (with a translation to -1, not NULL), so
the caller shouldn't do it again.  The userspace syscall function does
*not* return an error code.

Thanks,
Florian

