Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A6465CAB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjADAUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjADAUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:20:34 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F238AFD30;
        Tue,  3 Jan 2023 16:20:33 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 63D9B2C5;
        Wed,  4 Jan 2023 00:20:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 63D9B2C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672791633; bh=wkOUc+2g++Pq+InPdi6KFqlpBz+gBBIcqPDP6UnnbNc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oNgMlbTx3jU6ObQAJqhJP5W5fRdEKOX/HdImwzQjJyTARgt9IEz5HyQ7UEw2XAl4P
         PUsjFBpH/FXKyvoPcShmAQ44iPVsatFGreHzrbsHXYgQ4v8mFlM2TpPZHjWu2geIR/
         mMiKJz2VgE1koNrd1wMQoLrai+jG3A0yuGSrzm9Evibcd55HhZ+xd/EGCuPrUi5C8v
         MrgrOmaF5QxDZ6WA+k0GKnbDwbPOLPrjF/SktzSasRhtf45Kes+Nmc4kBnwr3F86Ai
         dIEY+wx13tZOPQe+00yymf/qKDY+QFqjZxtCdcBoyvlagtuTBafi/7ESal5D67AcVe
         hV/8iSvWnX+og==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        akiyks@gmail.com, jani.nikula@linux.intel.com,
        rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org
Subject: Re: [PATCH v5 0/2] docs: Integrate rustdoc into Rust documentation
In-Reply-To: <d37334f8-4c4c-467f-9ab0-a79914cbae3a@amd.com>
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221228174623.144199-1-carlos.bilbao@amd.com>
 <87wn64fq7d.fsf@meer.lwn.net>
 <d37334f8-4c4c-467f-9ab0-a79914cbae3a@amd.com>
Date:   Tue, 03 Jan 2023 17:20:32 -0700
Message-ID: <87lemjcfqn.fsf@meer.lwn.net>
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

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> On 1/2/23 17:53, Jonathan Corbet wrote:
>> Perhaps this is because I ignored the warnings about my Rust toolchain
>> being too new? (Rust 1.65.0, bindgen 0.63.0).  I get that only one
>
> Yes, it is important to have the expected Rust toolchain. You can try
> running:
>
> rustup override set $(scripts/min-tool-version.sh rustc)
>
> there's more information about this on the Rust Quick Start [1]. It may be
> annoying but you will need this for any future Rust-kernel work too.

I get this part.  I do wish it would fail a bit more gracefully, but I
*was* warned.

(I got away with building the 6.1 stuff with my out-of-spec toolchain,
but luck always runs out at some point :)

>> version is really supported, but it would be nice to fail a bit more
>> gracefully if at all possible.
>>
>> Anyway, I've unapplied these for now; thoughts on all this?
>
> My two cents is that these are limitations of Rust in the kernel, at least
> on its current state, and so adding rustdoc to the Documentation was
> going to come with them. But if someone has any ideas to make it less
> painful, I'm all ears too :)

I'm worrying now that I asked you to do the wrong thing, sorry.  If
building the Rust docs by default is going to make building the docs in
general harder (and break it for some people), then we need to not do
that.  Unless this can be made to work without forcing users to create a
kernel configuration or breaking the build if the right toolchain isn't
present, then we need to go back to having a separate make subcommand to
build the Rust docs.

My apologies, it wasn't my purpose to make extra useless work for you,
honest...

Thanks again for working on this,

jon
