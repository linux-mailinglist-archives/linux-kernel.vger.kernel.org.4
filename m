Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC845EFDDB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiI2TVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiI2TVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:21:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D320913F294;
        Thu, 29 Sep 2022 12:21:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5125A734;
        Thu, 29 Sep 2022 19:21:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5125A734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664479304; bh=bJcm9pawjNycjM+Nrq5TLidpXgcC/Xq62OwmjJR1/Ag=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VTHiSta6QeIia+XRQG8Jgoq59d62Ak+77NcNkEEQFhwf/do+hoo/kDrBpCb7E9aAq
         ffZYCfz3EqwR8VZrakRqJoIk+VlJcSyLogJ7edBgsY1P9ynbUqYzCqzqcwwRygEhg0
         znZ54jtB6CMNb9WIjbh4MwhX6XGc17YJh4ftpRCoz8f8kJgkmUlm1fnVBjBIX0Yivy
         vSuo7jeBRsOq/0DOZq6MZ9CndZ23DR1HTK72WvuXtCfV3RT7DKelhsdoD6JiE5WEqW
         wId3HIz+jvUATz0bQlia5OlL/mf8XpjrvHdVd6YiwaVvDc9t3vil0gbKq8WZkfiCVt
         TNazD9skBK6qg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, "Daniel K ." <daniel@cluded.net>
Subject: Re: [PATCH v2 0/2] coding-style.rst: document BUG() and WARN() rules
In-Reply-To: <20220923113426.52871-1-david@redhat.com>
References: <20220923113426.52871-1-david@redhat.com>
Date:   Thu, 29 Sep 2022 13:21:43 -0600
Message-ID: <87k05mgf5k.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> As it seems to be rather unclear if/when to use BUG(), BUG_ON(),
> VM_BUG_ON(), WARN_ON_ONCE(), ... let's try to document the result of a
> recent discussion.
>
> Details can be found in patch #1.
>
> v1 -> v2:
> * "coding-style.rst: document BUG() and WARN() rules ("do not crash the
>    kernel")"
>  -> Minor rephrasing / reference fix [John]
>  -> Compile fix [Akira]
> * "powerpc/prom_init: drop PROM_BUG()"
>  -> Dropped because it will go upstream via a different tree
> * "checkpatch: warn on usage of VM_BUG_ON() and other BUG variants"
>  -> Rephrase warning message and remove trailing period [John+Joe]
>
> RFC -> v1:
> * "coding-style.rst: document BUG() and WARN() rules ("do not crash the
>    kernel")"
>  -> Rephrase/extend according to John
>  -> Add some details regarding the use of panic()
> * powerpc/prom_init: drop PROM_BUG()
>  -> Added
> * "checkpatch: warn on usage of VM_BUG_ON() and other BUG variants"
>  -> Warn on more variants

It seems we've talked ourselves out on this one, so I've gone ahead and
applied it.

Thanks,

jon
