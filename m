Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69EE652647
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiLTSb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiLTSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:30:58 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94961E3E2;
        Tue, 20 Dec 2022 10:30:24 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c7so9052885pfc.12;
        Tue, 20 Dec 2022 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFul2piKoOn4GgC+2pw875qXMJqBOKHFpKQIXO36SXM=;
        b=qELjIaIRXg4xWIc7aVjnv+T7xE//R23dslwzmRIF2UCKr/pDKC5nOd+8aQBe3hnmdm
         iSHCLhZHWMCPBI5jIG3BLjraizJzWRzeX5pFmyh6K9kQwQkprsAyrlEKlAL6oiwpPat3
         Fe62dea+66WCvu3GuMCtCE1zzaMFxkxEep5evLP2m3HQH4akVAyTWuWCvM0PBxlgNHcX
         ZYo+d3vVs07l+JSN4mD+mNx7ROzaoVwY0H0InsjgGiKhYXunbvZhge4Nm3hjdj+5cUhx
         7wT5QORArZHpPKsvmPgXry6tjyfC1Tcixq3zzJWjl3giydUqmaSL//z+Cm1SjeER3P1W
         xsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFul2piKoOn4GgC+2pw875qXMJqBOKHFpKQIXO36SXM=;
        b=hd4K23CLMsJv6MqJvDVWVB7evEdc2UBU8bTqWdQfMsnOZ1+pxpwyWitlvw1uP9KFNO
         7WmfVPmvx6Cflbq+H/6r7Wmc6FRkIVOMCv4SAyRtGVavMxitH/CR+mdd7F1d2CSYSOBL
         LBrw1Vw9H/PW2BGkPYnr/y8D+xSHkQLqgMpF45B7ZtBWojLUXXyqXUjuJ8jiiPNeA3qE
         ljz9DZwodOeTv6Cz5Pi1ymAa1IG3X5q/6X1RIIheliWUPbhF7ZB86xxSxJ7LXa1u3RrW
         R32JwdYxYcsmVabxm5nIpcg1FZlPOK7Wm5lpnmlV5hh2CBVB2Hho6t5+pwBRU4IIUdWS
         eAsQ==
X-Gm-Message-State: ANoB5pkqhNXrXnMjfq83IkCHvRxjYeo6bwoCRSUy1/+Pb/GUjoDc6mRp
        kATm1D5Dm4HlsUulMuw2BC0=
X-Google-Smtp-Source: AA0mqf7n7+L65qrQuRCXFfBhi1Y/xRHdhn8gIL0qUNup1d0TQWRGuJPfaBs2mcbLbTA/+lHn8d4Uwg==
X-Received: by 2002:aa7:8554:0:b0:578:5b4:49a6 with SMTP id y20-20020aa78554000000b0057805b449a6mr43329353pfn.12.1671561024158;
        Tue, 20 Dec 2022 10:30:24 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7206:404e:4820:d175])
        by smtp.gmail.com with ESMTPSA id v18-20020a62a512000000b0057622e8e82csm8942573pfm.191.2022.12.20.10.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:30:23 -0800 (PST)
Date:   Tue, 20 Dec 2022 10:30:20 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] gpiolib: of: remove [devm_]gpiod_get_from_of_node()
 APIs
Message-ID: <Y6H/PLIxpZmNUaOS@google.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
 <20221219192016.1396950-5-dmitry.torokhov@gmail.com>
 <Y6HAJCBs3MQxNP29@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6HAJCBs3MQxNP29@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 04:01:08PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 19, 2022 at 11:20:16AM -0800, Dmitry Torokhov wrote:
> > Now that everyone is using [devm_]fwnode_gpiod_get[_index]() APIs,
> > remove OF-specific [devm_]gpiod_get_from_of_node().
> 
> I very much in favour of this change!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> But the same question reminds, how this is possible to exists with the removed
> of_get_named_gpiod_flags()?

As I mentioned in the other email of_get_named_gpiod_flags() is still
present, it is of_get_named_gpio_flags (without the "d") that was
removed.

Thanks.

-- 
Dmitry
