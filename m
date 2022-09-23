Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971455E79AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiIWLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiIWLes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7C1A3A5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663932882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyNBxWgFoArZ2NuuMCWnr7T1TxVSCSMUVgndhDD4Izo=;
        b=PmtnKdF651/Nm6kR/Cs1uih3Rh6oQAV9MT1+KrFSLs4bD/83YyZV1L5tjhWlJoCLZsk6GT
        pZ5VdFVWkpxRZ4xCgew9wRb3RO8htDAnuHALP+H1NQwIMVS9PWOSH61RJMO3JB1M5Ere+v
        PxOiuo16aeG/t5wqdG34v2IT5EJ4E34=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-FN5GlbaTPdGdXsoQkpQlRA-1; Fri, 23 Sep 2022 07:34:39 -0400
X-MC-Unique: FN5GlbaTPdGdXsoQkpQlRA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF86429AA3BB;
        Fri, 23 Sep 2022 11:34:37 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05FCC492B06;
        Fri, 23 Sep 2022 11:34:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Kalle Valo <kvalo@kernel.org>,
        "Daniel K ." <daniel@cluded.net>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/2] coding-style.rst: document BUG() and WARN() rules ("do not crash the kernel")
Date:   Fri, 23 Sep 2022 13:34:24 +0200
Message-Id: <20220923113426.52871-2-david@redhat.com>
In-Reply-To: <20220923113426.52871-1-david@redhat.com>
References: <20220923113426.52871-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus notes [1] that the introduction of new code that uses VM_BUG_ON()
is just as bad as BUG_ON(), because it will crash the kernel on
distributions that enable CONFIG_DEBUG_VM (like Fedora):

    VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
    no different, the only difference is "we can make the code smaller
    because these are less important". [2]

This resulted in a more generic discussion about usage of BUG() and
friends. While there might be corner cases that still deserve a BUG_ON(),
most BUG_ON() cases should simply use WARN_ON_ONCE() and implement a
recovery path if reasonable:

    The only possible case where BUG_ON can validly be used is "I have
    some fundamental data corruption and cannot possibly return an
    error". [2]

As a very good approximation is the general rule:

    "absolutely no new BUG_ON() calls _ever_" [2]

... not even if something really shouldn't ever happen and is merely for
documenting that an invariant always has to hold. However, there are sill
exceptions where BUG_ON() may be used:

    If you have a "this is major internal corruption, there's no way we can
    continue", then BUG_ON() is appropriate. [3]

There is only one good BUG_ON():

    Now, that said, there is one very valid sub-form of BUG_ON():
    BUILD_BUG_ON() is absolutely 100% fine. [2]

While WARN will also crash the machine with panic_on_warn set, that's
exactly to be expected:

    So we have two very different cases: the "virtual machine with good
    logging where a dead machine is fine" - use 'panic_on_warn'. And
    the actual real hardware with real drivers, running real loads by
    users. [4]

The basic idea is that warnings will similarly get reported by users
and be found during testing. However, in contrast to a BUG(), there is a
way to actually influence the expected behavior (e.g., panic_on_warn)
and to eventually keep the machine alive to extract some debug info.

Ingo notes that not all WARN_ON_ONCE cases need recovery. If we don't ever
expect this code to trigger in any case, recovery code is not really
helpful.

    I'd prefer to keep all these warnings 'simple' - i.e. no attempted
    recovery & control flow, unless we ever expect these to trigger.
    [5]

There have been different rules floating around that were never properly
documented. Let's try to clarify.

[1] https://lkml.kernel.org/r/CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com
[2] https://lore.kernel.org/r/CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com
[3] https://lkml.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com
[4] https://lore.kernel.org/r/CAHk-=wgF7K2gSSpy=m_=K3Nov4zaceUX9puQf1TjkTJLA2XC_g@mail.gmail.com
[5] https://lore.kernel.org/r/YwIW+mVeZoTOxn%2F4@gmail.com

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/process/coding-style.rst | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 03eb53fd029a..007e49ef6cec 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1186,6 +1186,68 @@ expression used.  For instance:
 	#endif /* CONFIG_SOMETHING */
 
 
+22) Do not crash the kernel
+---------------------------
+
+In general, the decision to crash the kernel belongs to the user, rather
+than to the kernel developer.
+
+Avoid panic()
+*************
+
+panic() should be used with care and primarily only during system boot.
+panic() is, for example, acceptable when running out of memory during boot and
+not being able to continue.
+
+Use WARN() rather than BUG()
+****************************
+
+Do not add new code that uses any of the BUG() variants, such as BUG(),
+BUG_ON(), or VM_BUG_ON(). Instead, use a WARN*() variant, preferably
+WARN_ON_ONCE(), and possibly with recovery code. Recovery code is not
+required if there is no reasonable way to at least partially recover.
+
+"I'm too lazy to do error handling" is not an excuse for using BUG(). Major
+internal corruptions with no way of continuing may still use BUG(), but need
+good justification.
+
+Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
+**************************************************
+
+WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it
+is common for a given warning condition, if it occurs at all, to occur
+multiple times. This can fill up and wrap the kernel log, and can even slow
+the system enough that the excessive logging turns into its own, additional
+problem.
+
+Do not WARN lightly
+*******************
+
+WARN*() is intended for unexpected, this-should-never-happen situations.
+WARN*() macros are not to be used for anything that is expected to happen
+during normal operation. These are not pre- or post-condition asserts, for
+example. Again: WARN*() must not be used for a condition that is expected
+to trigger easily, for example, by user space actions. pr_warn_once() is a
+possible alternative, if you need to notify the user of a problem.
+
+Do not worry about panic_on_warn users
+**************************************
+
+A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
+available kernel option, and that many users set this option. This is why
+there is a "Do not WARN lightly" writeup, above. However, the existence of
+panic_on_warn users is not a valid reason to avoid the judicious use
+WARN*(). That is because, whoever enables panic_on_warn has explicitly
+asked the kernel to crash if a WARN*() fires, and such users must be
+prepared to deal with the consequences of a system that is somewhat more
+likely to crash.
+
+Use BUILD_BUG_ON() for compile-time assertions
+**********************************************
+
+The use of BUILD_BUG_ON() is acceptable and encouraged, because it is a
+compile-time assertion that has no effect at runtime.
+
 Appendix I) References
 ----------------------
 
-- 
2.37.3

