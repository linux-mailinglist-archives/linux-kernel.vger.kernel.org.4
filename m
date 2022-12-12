Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D10649A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiLLI7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiLLI7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:59:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10205A455;
        Mon, 12 Dec 2022 00:59:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87CB460F36;
        Mon, 12 Dec 2022 08:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7D4C433F0;
        Mon, 12 Dec 2022 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670835591;
        bh=B2EDXjAKiY1kPZZAXNEN6nKHcQJ8k4xlc9/ZdVF+VZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/GkJyFmhLL+oB0gt4vKn5gOxBsyWPYuqCCngn8o7hSMxpEQERvpKgNmkAoocZ6dl
         XeRFX1DPsnaUEbe5gIdsvkplhYb6S2hNbM6GS6lUYl0XkYILkwFH4HvoDxgPiHl6dc
         1y4Q8tqIkdHLTNY+O4zC33Lsnu4fLUPPUC2mWEBA=
Date:   Mon, 12 Dec 2022 09:59:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Robinson <pbrobinson@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] driver core: Make driver_deferred_probe_timeout a
 static variable
Message-ID: <Y5bthMXYH1MuD9VY@kroah.com>
References: <20221116115348.517599-1-javierm@redhat.com>
 <20221116115348.517599-2-javierm@redhat.com>
 <CANDhNCoa+LRu8B4+M+uU4_m2kd=HriO0SyNP=n=XpXwXG2k9LA@mail.gmail.com>
 <549800ec-6da2-64ad-62a6-c8e4a35dc212@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549800ec-6da2-64ad-62a6-c8e4a35dc212@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 09:50:16AM +0100, Javier Martinez Canillas wrote:
> Hello Greg,
> 
> On 11/17/22 20:14, John Stultz wrote:
> > On Wed, Nov 16, 2022 at 3:54 AM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >>
> >> It is not used outside of its compilation unit, so there's no need to
> >> export this variable.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>  drivers/base/dd.c             | 6 ++----
> >>  include/linux/device/driver.h | 1 -
> >>  2 files changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> >> index 3dda62503102..040b4060f903 100644
> >> --- a/drivers/base/dd.c
> >> +++ b/drivers/base/dd.c
> >> @@ -257,13 +257,11 @@ static int deferred_devs_show(struct seq_file *s, void *data)
> >>  DEFINE_SHOW_ATTRIBUTE(deferred_devs);
> >>
> >>  #ifdef CONFIG_MODULES
> >> -int driver_deferred_probe_timeout = 10;
> >> +static int driver_deferred_probe_timeout = 10;
> >>  #else
> >> -int driver_deferred_probe_timeout;
> >> +static int driver_deferred_probe_timeout;
> >>  #endif
> >>
> >> -EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
> >> -
> > 
> > Yeah, I added the EXPORT for the regulator code to use it in
> > dca0b44957e5 but that got backed out when setting
> > driver_deferred_probe_timeout to 30s was reverted, and this bit was
> > forgotten.
> > 
> > Thanks for catching this!
> > 
> > Acked-by: John Stultz <jstultz@google.com>
> >
> 
> Could you please pick this patch? Is a fix independent of the other
> patches in the series and it has already been acked by John.

It is the middle of the merge window and I can't take anything now until
after 6.2-rc1 is out.  I also really can't take individual patches out
of a patch series easily, so please just resend it as a single patch
when 6.2-rc1 is out.

thanks,

greg k-h
