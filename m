Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68D5E829D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiIWTm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIWTm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:42:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F711CB3E;
        Fri, 23 Sep 2022 12:42:56 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B15EE1EC0662;
        Fri, 23 Sep 2022 21:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663962170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rcKw2nU28ALH0/BoWD8Ilfo8eZ1xifTiRKKgZbuGLLg=;
        b=R3uewgC2MArOT4kW+9iHES+qt3awZDL60kB9NUf/V8/rQa373DCGapWaHtfTwuR4okujpX
        GOG1h9QajOuXvZGM5ZesTX+ZFh+xXSoGZlfb5uJ/Aks7uipBnNlAV/4NF1nBaJdvpSESWT
        JneZ9wSCzVu9Km0sRxOKmqGjRHMLI1c=
Date:   Fri, 23 Sep 2022 21:42:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: INFO: task systemd-udevd:94 blocked for more than 120 seconds.
Message-ID: <Yy4MNp6yiRTJxeXa@zn.tnic>
References: <Yy4B+9yH8oT0F8nQ@zn.tnic>
 <Yy4GoMMwiBaq3oJf@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy4GoMMwiBaq3oJf@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:18:56PM -0700, Nathan Chancellor wrote:
> I have not seen a stacktrace like this on my machines (although I
> suspect that is because I don't have CONFIG_DETECT_HUNG_TASK enabled in
> my configs) but my Honeycomb LX2 hangs while booting after commit
> 78ffa3e58d93 ("thermal/core: Add a generic thermal_zone_get_trip()
> function") according to my bisect, which certainly seems like it could
> be related to the trace you are seeing.

Don't you just love how well our community works - one reports a bug and
someone else has already bisected it and thus saves one the work?!

:-)))

Thanks Nathan, I can confirm your bisection. The commit above doesn't
revert cleanly ontop of linux-next so I tried it and the patch before
it:

78ffa3e58d93 ("thermal/core: Add a generic thermal_zone_get_trip() function")	<- BAD
62022c15f627 ("Merge branch 'pm-opp' into linux-next")				<- GOOD

so it looks like that one is somehow b0rked.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
