Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A125E9ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiIZHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiIZHof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:44:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5570E18;
        Mon, 26 Sep 2022 00:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77D37B80E0E;
        Mon, 26 Sep 2022 07:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC0DC4347C;
        Mon, 26 Sep 2022 07:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664178272;
        bh=zBd0nArrnoxpH7BK8G59CVIeT52Rmoc4NPF1f78MmAU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mevbU99/eYutUpCn1H9p1DPCf79291EqQRj1MRmDDpWnPEaMJbWCxqmKRWpB5ybmp
         rpKBvILUtYi4W6N7bI/kUmv6hlXNcML6Xs1ZD/ji012sDLEhQnDSAvdykmM+pNo1Km
         e5Y4yKJ+bM4AYYMisnkTeDOywfDt3lDHdavQAZeKvGAqWIzx+dokm3kTgGh6UmqnJ6
         S7ujFPSP7OUAgWfuuelJvpMPsvNzaHRgUwq0EMN99C04k7RoM0OgViq/rYpTUw9j6R
         oUOVGx/siC1s4xEZNHjVksSgMnra1sLsRGB8FVIeh0qZeDVPISU6Pufpkx7u4yZfKY
         PJWIfK90Uud7Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/3] coding-style.rst: document BUG() and WARN() rules ("do not crash the kernel")
References: <20220920122302.99195-1-david@redhat.com>
        <20220920122302.99195-2-david@redhat.com> <87pmfp8hnj.fsf@kernel.org>
        <d1ceedca-b28e-c47e-aa0d-aa1cb36d12b9@redhat.com>
Date:   Mon, 26 Sep 2022 10:44:23 +0300
In-Reply-To: <d1ceedca-b28e-c47e-aa0d-aa1cb36d12b9@redhat.com> (David
        Hildenbrand's message of "Thu, 22 Sep 2022 16:12:05 +0200")
Message-ID: <87leq64m20.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

>>> +Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
>>> +**************************************************
>>> +
>>> +WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it
>>> +is common for a given warning condition, if it occurs at all, to occur
>>> +multiple times. This can fill up and wrap the kernel log, and can even slow
>>> +the system enough that the excessive logging turns into its own, additional
>>> +problem.
>>
>> FWIW I have had cases where WARN() messages caused a reboot, maybe
>> mention that here? In my case the logging was so excessive that the
>> watchdog wasn't updated and in the end the device was forcefully
>> rebooted.
>>
>
> That should be covered by the last part, no? What would be your suggestion?

I was just thinking that maybe make it more obvious that even WARN_ON()
can crash the system, something along these lines:

"..., additional problem like stalling the system so much that it causes
a reboot."

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
