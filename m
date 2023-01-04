Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE86765CAC5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbjADAZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbjADAZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:25:13 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50E17072;
        Tue,  3 Jan 2023 16:25:10 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E0BF94BF;
        Wed,  4 Jan 2023 00:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E0BF94BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672791910; bh=S3spks9Z3wmS5gxYl1y0L64CJtVZjwQ9VVkqSNfKJcY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rMJ28Ezh6hVPz4pqbvWt/cRGjev4V/e1ApD+kqTclK6+wfPPXmeI79ArQTtFY/zUD
         tY9T5ICDW57fs9/ERtWFvTMcgcY0EW3jJ1U8EMI7In7uQzzg+rI/9qUe2eSFeo7R0H
         mSiZrffgtILUlLR4rRLQfKaUDV7zBbreSbwzauUK2DmlSiyT61+iAiVG8Covd6YEjm
         kGV+5z7UjSOOJrCpZf7NvxzMXoHd4ILJ6Zv+ceFd2ciaLsckWbhRoTXj3UBASivXfn
         Fetk6h9QLaikn8xLRFqd31dfyWnpAtXSE3ndWHVa5R6+6lfWJv/73Fao5YyNLLiQRK
         t4CCvJjB7r7zg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        akiyks@gmail.com, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org
Subject: Re: [PATCH v5 0/2] docs: Integrate rustdoc into Rust documentation
In-Reply-To: <CANiq72mC+WzOxhZVtEvnsFYzuBPkd51=TYXK01ztcTZ-CAcUiw@mail.gmail.com>
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221228174623.144199-1-carlos.bilbao@amd.com>
 <87wn64fq7d.fsf@meer.lwn.net>
 <CANiq72mC+WzOxhZVtEvnsFYzuBPkd51=TYXK01ztcTZ-CAcUiw@mail.gmail.com>
Date:   Tue, 03 Jan 2023 17:25:09 -0700
Message-ID: <87h6x7cfiy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

>> - It did a bunch of other building, starting with objtool - again, never
>>   needed for the docs build before.
>
> Yeah, rustdoc, like the compiler, requires dependencies to be
> available to understand the code. Thus some things need to be
> compiled, like for the normal build.

Does it really need objtool?

A certain amount of extra building is OK as long as it doesn't radically
slow down the (already glacial) docs build.  I'd like it to not *break*
the docs build if the right dependencies aren't there, though.

>> version is really supported, but it would be nice to fail a bit more
>> gracefully if at all possible.
>
> Do you mean failing in the `scripts/rust_is_available.sh` step instead
> of warning? We could also add versioning information to that script,
> so that it knows more about which versions work etc., but I guess at
> that point it would be best to simply start supporting several
> versions, which may be a bit too early to split CI runs on that since
> it would require some degree of testing.

It seems like that step should fail regardless, not just for the docs
build, no?

Otherwise, though, it would suffice to turn a failure to build the Rust
docs into a warning-level event for the docs build; I'm mostly concerned
about it breaking the build as a whole.  Supporting multiple Rust
versions would be nice, but it's up to you to decide when you think you
can do that; I don't think the docs build should drive it.

Thanks,

jon
