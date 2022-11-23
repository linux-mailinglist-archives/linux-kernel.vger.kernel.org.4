Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EE635ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiKWK6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiKWK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E09A27E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669200497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q21XGGIV0kLQZIROdqS+QQLvwJnTsCRdjio/ZDAURPE=;
        b=I/Cqn6tphTOnZKuPfmZO48Qx/xEjc8Y9bRdBjBnhTB8cIpmPBJajyGlqKtNwuHHeAAQQ2l
        od94yORS6PIyTCxmGDMvXKBqwGMfiVxad6lrvyIf6b0xXSptRxIYsqwq8D/Gzt74gnjx3a
        DLfm62Ac+BGxvx1WRA3iquuW9ZAik+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-8tkKkYFnM7KhQMAhkJOAEQ-1; Wed, 23 Nov 2022 05:48:12 -0500
X-MC-Unique: 8tkKkYFnM7KhQMAhkJOAEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC42C85A59D;
        Wed, 23 Nov 2022 10:48:11 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EC231400B15;
        Wed, 23 Nov 2022 10:48:10 +0000 (UTC)
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
Date:   Wed, 23 Nov 2022 11:48:06 +0100
In-Reply-To: <20221121152909.3414096-3-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Mon, 21 Nov 2022 16:29:08 +0100")
Message-ID: <87r0xulzfd.fsf@oldenburg.str.redhat.com>
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

>   static void *vgetrandom_alloc(size_t *num, size_t *size_per_each, unsigned int flags)
>   {
>     unsigned long ret = syscall(__NR_vgetrandom_alloc, num, size_per_each, flags);
>     return ret > -4096UL ? NULL : (void *)ret;
>   }

The traditional syscall function returns -1 on error and set errors, so
using unsing long and the 4096 is quite misleading.

Thanks,
Florian

