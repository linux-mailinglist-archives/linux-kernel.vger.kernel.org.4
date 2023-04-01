Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4749D6D33D0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjDAU3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDAU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:29:13 -0400
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Apr 2023 13:29:11 PDT
Received: from onstation.org (onstation.org [52.200.56.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CA72701D;
        Sat,  1 Apr 2023 13:29:10 -0700 (PDT)
Received: from localhost (c-73-214-169-22.hsd1.pa.comcast.net [73.214.169.22])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by onstation.org (Postfix) with ESMTPSA id 91AC24212BC;
        Sat,  1 Apr 2023 16:23:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 onstation.org 91AC24212BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onstation.org;
        s=default; t=1680380612;
        bh=8kDgeSe0XAJ1hw6nbgK0BQxOJVCl6IRIynQ8IhHYmk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HY5QSjvV487ajsKs1J3BFL5ZbLCSj/sg13x0hj1iBLJmFNWcCTucWpxDsojXfDCsH
         fPWKAsSTiY2bPfI9JHKklN+uv8hgD8jBa8OjCzzbyIZcSO0zrfOtDbQlAE9NmQfpPa
         ixg5wf5aS3cfwVpTOp/Gkfs6AuUCmsMcrIhduZoo=
Date:   Sat, 1 Apr 2023 16:23:32 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Rix <trix@redhat.com>, lars@metafoo.de, nathan@kernel.org,
        ndesaulniers@google.com, u.kleine-koenig@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Chuhong Yuan <hslester96@gmail.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH] iio: tsl2772: remove unused prox_diode_mask variable
Message-ID: <ZCiSxK5JgY6g+0X+@onstation.org>
References: <20230327120823.1369700-1-trix@redhat.com>
 <ZCGVJOSBjKO3FKD6@smile.fi.intel.com>
 <20230401152028.30344b48@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401152028.30344b48@jic23-huawei>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 03:20:28PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Mar 2023 16:07:48 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Mon, Mar 27, 2023 at 08:08:23AM -0400, Tom Rix wrote:
> > > clang with W=1 reports
> > > drivers/iio/light/tsl2772.c:576:24: error: variable
> > >   'prox_diode_mask' set but not used [-Werror,-Wunused-but-set-variable]
> > >         int i, ret, num_leds, prox_diode_mask;
> > >                               ^
> > > This variable is not used so remove it.  
> > 
> > While from the compilation point of view this is a correct fix, I think
> > we need to hear from the author (or interested stakeholders) about this
> > feature. Perhaps it should be enabled / fixed differently.
> > 
> 
> Superficially it looks like this value should have been stored to
> chip->settings.prox_diode
> 
> +CC people who might know...

Jonathan is correct about the proper fix and is this is my mistake. We
should just need to add this to the bottom of that function:

   chip->settings.prox_diode = prox_diode_mask;

Tom: I can fix this up next week, unless I hear from you otherwise that
you'll do it.

Brian
