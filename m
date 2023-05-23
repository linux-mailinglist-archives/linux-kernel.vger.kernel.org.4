Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9770D934
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbjEWJf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjEWJfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:35:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2620E138;
        Tue, 23 May 2023 02:35:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B6BD41FF45;
        Tue, 23 May 2023 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684834512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAYq7YJVS2Hlnl42uVu2goasTRVPRgZ4NqjKSyNxGrQ=;
        b=KU08sltoiXCpoxueN/xTm1Dj8XgBHSTDWuL90uW147a2/O/Mr6ZoeLyNLFpVJWdIVW5kxX
        qqA4ifcAtaWSIWN6bnayexKSUglQmxet+EFMnoKUKq4Izsg5nga9Xy+G/qI4h+1EzPAbdY
        lsmjo1AyUZ4F7lDFhMIZqs6iohgJ0mY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 46EBC2C141;
        Tue, 23 May 2023 09:35:07 +0000 (UTC)
Date:   Tue, 23 May 2023 11:35:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 02/18] watchdog/perf: More properly prevent false
 positives with turbo modes
Message-ID: <ZGyIxvKhVjr-L8-I@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.2.I843b0d1de3e096ba111a179f3adb16d576bef5c7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101840.v5.2.I843b0d1de3e096ba111a179f3adb16d576bef5c7@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-19 10:18:26, Douglas Anderson wrote:
> Currently, in the watchdog_overflow_callback() we first check to see
> if the watchdog had been touched and _then_ we handle the workaround
> for turbo mode. This order should be reversed.
> 
> Specifically, "touching" the hardlockup detector's watchdog should
> avoid lockups being detected for one period that should be roughly the
> same regardless of whether we're running turbo or not. That means that
> we should do the extra accounting for turbo _before_ we look at (and
> clear) the global indicating that we've been touched.

The ideal solution would be to reset the turbo-mode-related
variables when the watchdog is touched. And keep checking
watchdog_nmi_touch first.

But this ordering change should be good enough. It causes that
we always check watchdog_nmi_touch when the turbo-more-related
variables are already reset.

> NOTE: this fix is made based on code inspection. I am not aware of any
> reports where the old code would have generated false positives. That
> being said, this order seems more correct and also makes it easier
> down the line to share code with the "buddy" hardlockup detector.
> 
> Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo modes")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
