Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4B571410E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 00:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjE1Wmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjE1Wmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 18:42:43 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CF1B9
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 15:42:41 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id f31d08a1-fda8-11ed-b972-005056bdfda7;
        Mon, 29 May 2023 01:42:39 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 29 May 2023 01:42:39 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v4 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
Message-ID: <ZHPY32XPGyc96jJS@surfacebook>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
 <20230522142621.1680563-4-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522142621.1680563-4-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 04:26:17PM +0200, Astrid Rost kirjoitti:
> Add illuminance integration time for vcnl4040 and vcnl4200.
> Add read/write attribute for illuminance integration time and read
> attribute for available integration times.
> Set scale and sampling rate according to the integration time.

...

> +	data->vcnl4200_al.sampling_rate = ktime_set(0, val * 1200000);
> +	if (data->id == VCNL4200)
> +		/* 24000 µlux/step * 50000 µs / val  */
> +		data->al_scale = div_u64(1200000000, val);

Without type these constant are integers. Is this okay with 32-bit builds?

> +	else
> +		/* 100000 µlux/step * 80000 µs / val */
> +		data->al_scale = div_u64(8000000000, val);

Ditto.

Also, can you use constants from units.h (KILO) and time.h (USEC_PER_MSEC)?

...

> +out:

out_unlock:

> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;

-- 
With Best Regards,
Andy Shevchenko


