Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1EA69FFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjBWAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWAFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:05:39 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A836FD1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:05:38 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 76so4278365iou.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgrFNSuf34jbNpz3PEJghPmkNt6YOqZyHs66V60GvNY=;
        b=dmuypTWNxR5hndIsnbz1GwRwVLYiQ/+uKQgrIpLxAcdFGeu+t4MYTdMrqvk0/qWj6X
         D0LsEIAm6qjNOp4LrZFR56gDcaYPhe33sKYWnrNTxD6PI3kL5+as7NF8YQ9aGNwH5oub
         jjP5LtbcO5iXrtjbVK7j47ExnrRe5uG6gbx48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgrFNSuf34jbNpz3PEJghPmkNt6YOqZyHs66V60GvNY=;
        b=W4bPJdXPEJnmnPeNnYkOB2IkBjep6OONFby88guKMlba28YQ91v8Ley9fOfJpTcH/5
         tn6E3l6aXfup0d9CdQq0G4Jw7+6eHC2W/mfPlsWRW79EL0p6scsrDtt9aKeu7zMK+xgN
         KHKX5HalSppA/KDDqmqC9UwiGyADyEKLstPErrLeNUm8Zh90qRF7T3q52s5kcWTuGwGj
         9CflClle8jVoPx4tbOqR4IKGSwWap9udOBpQFZP3qR0cNsqmY1tuol2hwJGRbtMf3ZCt
         0HKT2tzlpeldsgDsOjYAC9dtXBBHgX3vU7ejgk6MBPlxGfpSbX74fT+O67kZF7UYulB/
         y2ew==
X-Gm-Message-State: AO0yUKUMl9QKmmhVfdTCSzpPKnYD2ltZQJVQ2RD33j2Lm+e4zXbMw0sc
        uMwME/BsfsLwxMfSQ85rQtmzzg==
X-Google-Smtp-Source: AK7set/Z0RlD4bIBUoxcAs3D7T9MbOgQ9R0Ibfy95mgsWYXG4eNOd9ajL6uIa6Eov1FlwSI5FC9Wnw==
X-Received: by 2002:a05:6602:3149:b0:723:fa7:fb6a with SMTP id m9-20020a056602314900b007230fa7fb6amr6545960ioy.2.1677110738088;
        Wed, 22 Feb 2023 16:05:38 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id a13-20020a5d89cd000000b007457f5ab197sm1475082iot.38.2023.02.22.16.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 16:05:37 -0800 (PST)
Date:   Thu, 23 Feb 2023 00:05:37 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Use ktime_get_boottime() to determine
 how long a regulator was off
Message-ID: <Y/at0SrG+q2AOtuZ@google.com>
References: <20230222191537.1.I9719661b8eb0a73b8c416f9c26cf5bd8c0563f99@changeid>
 <CAE-0n51P-nXPKmcN9K5RtdFJh5EQ3M_hm2LjBicfegWKUda2Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE-0n51P-nXPKmcN9K5RtdFJh5EQ3M_hm2LjBicfegWKUda2Dw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 03:46:39PM -0500, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2023-02-22 11:15:46)
> > For regulators with 'off-on-delay-us' the regulator framework currently
> > uses ktime_get() to determine how long the regulator has been off
> > before re-enabling it (after a delay if needed). A problem with using
> > ktime_get() is that it doesn't account for the time the system is
> > suspended. As a result a regulator with a longer 'off-on-delay' (e.g.
> > 500ms) that was switched off during suspend might still incurr in a
> > delay on resume before it is re-enabled, even though the regulator
> > might have been off for hours. ktime_get_boottime() accounts for
> > suspend time, use it instead of ktime_get().
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> 
> Is it fixing something in stable kernels? Should it be tagged for
> stable?

It's not a super-critical fix, but it could improve resume time for
some devices with stable kernels, so it might be worth adding it to
stable. I'll send out a a v2 with the corresponding tags.
