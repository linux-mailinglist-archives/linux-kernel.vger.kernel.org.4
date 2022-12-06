Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60457644772
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiLFPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiLFPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:17 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108D2F009;
        Tue,  6 Dec 2022 07:02:10 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 55166385;
        Tue,  6 Dec 2022 15:02:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 55166385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1670338930; bh=0G2uh/bRc5rHaqR4/6WR1JTpOD3SXdpBKV+MrTwefuU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=d57n5x7czbaabIrvEpZHlETZfQDi7yH2Hy/iO8mPrZQwEBnFqE3berASi9sdkq02Z
         9gSifhWNMPEQlcq9RA4j6IBUtG+9Pa4jh5GXxYu0kpdFXSXmtFpUUlvQWF8X7XZUjm
         +uCYBPlrg3uFPapg9+zeB5rI6hEbmDzeRjjt9AS7qK5+UNL5StGSbBe951s6+r2uFh
         hdajF7nuGVI/2W+y0uY5QCyS3tr3ZKperADz9N21J0GS+0NpIcBS6Glyvk0eoRfK+a
         Jr/ohI65v+3A8muPojih4g2Cga3+PpRFDvAuCtJB/WFMmG3J3ItHU0GJOHdEVbmy6U
         uAOXAxF7Wk33g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2] docs: Integrate rustdoc into Rust documentation
In-Reply-To: <e3523f33-847b-81da-7b20-83ee54597d9f@gmail.com>
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
 <CANiq72=ud1EB+jcKE=iudFSgKNcqd=8Xe-M0YgxikmUuQ+TjGA@mail.gmail.com>
 <e3523f33-847b-81da-7b20-83ee54597d9f@gmail.com>
Date:   Tue, 06 Dec 2022 08:02:04 -0700
Message-ID: <87pmcwlgnn.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> Well, I'm actually worrying about additional TAT when I want to test
> a particular change in a .rst file and test-build under the relevant
> subdirectory using a command, e.g., "make SPHINXDIRS=doc-guide htmldocs".
>
> This completes almost instantly when CONFIG_RUST is not set.
>
> With CONFIG_RUST=y, in my test, it runs RUSTDOC even when rustdoc is
> already generated once, as shown below:

This is something that would be nice to avoid if we can; narrowing
things with SPHINXDIRS should avoid building anything that the user
isn't asking for.  I'm not sure how much makefile pain would be required
to make that happen...Documentation/Makefile is not the easiest place to
make changes, alas.

> I think you can add a new target in the top-devel Makefile which
> runs both rustdoc and htmldocs for CIs. Something like 'htmldocsboth'
> or 'htmldocsall'???
>
> htmldocs and other *docs targets are the most primitive ones for
> running Sphinx, so my gut feeling tells me _not_ to contaminate
> htmldocs with rustdoc or vice versa.

Well, I *would* like for a bare "make htmldocs" to make *all* of the
docs; I don't think Rust should be special in that regard.

>> (It is also why I wondered above about
>> `CONFIG_WARN_MISSING_DOCUMENTS`: if `Documentation/` intended to
>> require a config as a whole, then it would be fine. I assume that is
>> not the case, though, but not doing the sync is nevertheless a bit
>> confusing)
>
> I have no idea. (Note: I was not around when the kernel documentation
> transitioned to Sphinx.)

I think we're just seeing the implementation as was rammed in by
somebody in a hurry; I don't doubt it could be improved.

Thanks,

jon  (currently traveling and scrambling to get ready for the merge window)
