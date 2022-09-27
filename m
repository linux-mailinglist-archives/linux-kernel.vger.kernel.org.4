Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6635EC82D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiI0PjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiI0Pik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:38:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16B046234;
        Tue, 27 Sep 2022 08:37:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l9-20020a17090a4d4900b00205e295400eso1099657pjh.4;
        Tue, 27 Sep 2022 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cmt0eMWNfX8OUSwEQSelWdpbi8qk4MVQc0RBniLF4Xo=;
        b=W8DrBPruBXMLkVnVFB29PwTYOFKdbQOinAZ+9e1PqE12Y8uxzABhDe4aNbfn0xH0NB
         zuR4cil7heql8kYKnlj4cQY+JJgrBecE1epnPEia9Q47LU6uf0qhn/9WUOZ2oiWsyYv9
         BBeNeH1GvEHhxSY1b/aa6LZEXF0FybVycHbwyZ2JkAlZZoe20f1OlN8UHprRdjCTJkUk
         xdIh0ISkX68CXFQ423t5QGQZSnQF9bYDERy8L1LAS+YocSMN/cx1wFyW9b6h6RzVhjCJ
         W6ljRqpDtw2SXkiGWMfaRsCa776GNNigI9ee7+XBCpz6N2kjPGT/F4+LH0nBBYO8Dx65
         I2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cmt0eMWNfX8OUSwEQSelWdpbi8qk4MVQc0RBniLF4Xo=;
        b=Re33H63u5L0cjVFw/zbTl7CRaFcEQXthTWlhdl8N0dHVvqIpyW02aTjgk2hi0hMfAu
         40TdQvAH0ai1n0xazlx52+XqWZY6OtYXEJZWQZcM18zp6pbhTjLhBd4BN6X28/MntxeY
         3HwPtQ2oB3jI6OhyseRtnxl626lBnI2PX2AyEKTL0zmDlIAKmFCJI+WT+2On7H2C2UUm
         pQAgE6G3Lm/RjsvPVaPPwVSgPWe8fmgQYhgUeLcbiZOzjn4Ax0M6zntwqdYUVZ280A8h
         dSCOuHcjiHtw+9Xe7MHUOLUWH3eTZZqOVod+hOhKZCPEg4GGDt9Ubwztp4NRPQU7YB5A
         EHhg==
X-Gm-Message-State: ACrzQf26D6GkWtaTbsqr1exsuB0/KlfNXZg8rnqiF4F7mb5QKKFfCd2C
        DaRSTcBks8Lvb8cEUZi2YEY=
X-Google-Smtp-Source: AMsMyM4CRrAwOrNFm/enSykRt5LftO6BdgUkkyFkjUDun+k1o6NqMYagce5erod7ZcLFLUjDiYOrig==
X-Received: by 2002:a17:902:ab58:b0:179:fbd2:2303 with SMTP id ij24-20020a170902ab5800b00179fbd22303mr1077482plb.120.1664292986295;
        Tue, 27 Sep 2022 08:36:26 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709029a4600b00172b87d97cbsm1714107plv.67.2022.09.27.08.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:36:25 -0700 (PDT)
Date:   Tue, 27 Sep 2022 08:36:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: twl4030-madc: add missing of.h include
Message-ID: <YzMYdoQmDt6YAvdr@google.com>
References: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
 <20220927052217.2784593-4-dmitry.torokhov@gmail.com>
 <YzLreedzM3/+2gBh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLreedzM3/+2gBh@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:24:25PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 26, 2022 at 10:22:16PM -0700, Dmitry Torokhov wrote:
> > The driver is using of_device_id and therefore needs to include
> > of.h header.
> 
> As per patch 2 comment, mod_devicetable.h is needed for that.

It also uses of_match_ptr(), so of.h is the one that is needed. I'll
adjust the patch description.

Thanks.

-- 
Dmitry
