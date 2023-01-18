Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ACF671F65
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjAROWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjAROVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:21:54 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D713D50;
        Wed, 18 Jan 2023 06:04:27 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6BFA920133;
        Wed, 18 Jan 2023 15:04:25 +0100 (CET)
Date:   Wed, 18 Jan 2023 15:04:23 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <20230118140423.y4ogqdkyti7vcwaz@SoMainline.org>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230118123528.oaxtjbdier3ojd3m@SoMainline.org>
 <Y8fyonSp49QoAb8v@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8fyonSp49QoAb8v@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-18 15:22:42, Andy Shevchenko wrote:
...
> > > +	name = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", fwnode);
> > 
> > Is this better/cleaner than copying the string from fwnode_get_name?
> 
> Coying to where? And what would be the lifetime of that string?
> 
> With devm_kasprintf():
> - we don't care how long the string is
> - we don't care about corner cases of lifetime as it's the same as
>   device itself (i.o.w. the same as the IIO device container)

Curious if there isn't a devm_strdup(name) or similar?  Main point is
that %pfwP seems like magic when fwnode_get_name is not (but returns a
const string that we cannot modify).  If there is not, let's stick with
devm_kasprintf().

> > > +	name[strchrnul(name, '@') - name] = '\0';
> > 
> > This is the same as *strchrnul(name, '@') = '\0'; if I'm not mistaken.
> 
> Yes, But it's harder to read and understand. I believe the compiler has
> enough power to optimize this to the same assembly code.

I find the latter clearer as it doesn't require the reader to figure out
that name - name cancels itself out.  Alternatively we can write
strchrnul(name, '@')[0].

- Marijn
