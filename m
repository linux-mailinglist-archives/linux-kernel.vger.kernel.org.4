Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A876D926B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjDFJNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjDFJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28D65BC;
        Thu,  6 Apr 2023 02:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DAA56436B;
        Thu,  6 Apr 2023 09:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4555BC4339B;
        Thu,  6 Apr 2023 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680772415;
        bh=vbMbCGgTsG/EZ7Md1sa2L63/OfODcU0xFJC9drgHnHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6nrtJsVDgsTMyfmw+R/5sknEu3XZtabIHqNWopiwiSHZSNHW/7ANPYneemPFOIuL
         x4YGAKTGz2FBcVQ/Ww9xgSfO0D6FK+7zUStqeZLIEf99fBCvzyY9b4qlU3i1zjylxM
         t0ib0GmIkKnfDhoO9+3+g1cFvYJ2BXMFhbf/Zepcy9sKg6Q4qCiemW0x32yeGcZWSt
         WfaRjsMbeLAwHr8r7u+ZmJSMo4hreZ1Dawpe5Gq5EYjBdx0CgCckDnn3dzODkXh6Zl
         LNzV/virzkA9PR1/U4vT+jhfHTrRjDHGxnxyjj7hALO4RAZZ952lq+kedhXlrNTin5
         67ncvX6valRPw==
Date:   Thu, 6 Apr 2023 10:13:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] leds: lp55xx: configure internal charge pump
Message-ID: <20230406091329.GX8371@google.com>
References: <20230331114610.48111-1-maarten.zanders@mind.be>
 <20230331114610.48111-3-maarten.zanders@mind.be>
 <20230405152627.GO8371@google.com>
 <32c0a958-58bd-7476-c276-94c8f33ffbb3@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32c0a958-58bd-7476-c276-94c8f33ffbb3@mind.be>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2023, Maarten Zanders wrote:

>
> > Sorry Maarten, just a couple of small nits.
>
> No need to be sorry.
>
>
> > This fits on one line, no?  < 100-chars?
>
> I thought the line length was meant to be <80 chars according to:
>
> https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
>
> Happy to adapt if this shouldn't be taken as strict as I tried to do. Either
> way I'll post an update with a cleanup.

checkpatch.pl now checks for >100-chars.

> > > --- a/include/linux/platform_data/leds-lp55xx.h
> > > +++ b/include/linux/platform_data/leds-lp55xx.h
> > > @@ -73,6 +73,9 @@ struct lp55xx_platform_data {
> > >   	/* Clock configuration */
> > >   	u8 clock_mode;
> > >
> > > +	/* Charge pump mode */
> > > +	u32 charge_pump_mode;
> > That's a lot of data.  Does it need to be u32?
>
> No, it luckily doesn't get that big. This is to avoid an intermediate
> variable & casting as the DT parameter has to be 32bit (which I learned from
> an earlier comment). It was changed from u8 in v5 of the patch.

Fair enough.

--
Lee Jones [李琼斯]
