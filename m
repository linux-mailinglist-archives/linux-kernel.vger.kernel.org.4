Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AD16C8797
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjCXVnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjCXVns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:43:48 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D7D10265;
        Fri, 24 Mar 2023 14:43:45 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id y184so2274237oiy.8;
        Fri, 24 Mar 2023 14:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679694225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHSbB1SCTNjgkFNr2EH/UUZJ6o73g7xDpL0a/bfAGW4=;
        b=SxPvXNrq5qpvJtUkizuYz+a5h+wTHWTvoDEWx9K4cukPNYMUPbqQqbQyl0Mv8CfMgR
         xI9qjO3YKgGzrurAhWJPXJTzG4aA8aew+YNFJvL3QRXDK6nAHWL6F+z832IciWqZspiD
         wa2HZsnYYWiMZFfzfHQc+VB7XqEk/5cV1CbzrMzoQLNP35kLH/ShNJI+YEBC9KHuGPc8
         2W0KjvnDh/gVFsfw/NfipFcdcFIDbMWYhVbmy/QvMXM9mbh4lGIpERO6PD18wHoJpUKD
         /RzbSzZdlVLZ04i08LVfJ6kb2I4sN9U0l8EdcVqHxtQQee/eEnr/Ni7Y53h6n553Bmmm
         /MvA==
X-Gm-Message-State: AO0yUKXAqGO9ZWYxzJcntnG7/SkEST3oenEtOkWQC9G+HQx8U+1/b/7Y
        FyfxU4PSG1HWRIacuNkjwsRKvN6eEA==
X-Google-Smtp-Source: AK7set/oeSAd7/XsFdatBuszhN1GZKNz6UbweX/12Q4XUIcikQgrV85TeiISLjYEDNk5No5DqZVBpA==
X-Received: by 2002:a54:4406:0:b0:387:3239:61f3 with SMTP id k6-20020a544406000000b00387323961f3mr1756696oiw.21.1679694224727;
        Fri, 24 Mar 2023 14:43:44 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80f9:92f0:b372:78c0:69c1:66d6])
        by smtp.gmail.com with ESMTPSA id j7-20020acab907000000b0038478923768sm8688314oif.3.2023.03.24.14.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 14:43:44 -0700 (PDT)
Received: (nullmailer pid 33223 invoked by uid 1000);
        Fri, 24 Mar 2023 21:43:41 -0000
Date:   Fri, 24 Mar 2023 16:43:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] of: unittest: option to allow tests that trigger
 kernel stack dump
Message-ID: <20230324214341.GA20080-robh@kernel.org>
References: <20230301012116.1488132-1-frowand.list@gmail.com>
 <20230301012116.1488132-2-frowand.list@gmail.com>
 <018f54ee-55cc-e30b-4595-ce555fff1708@roeck-us.net>
 <96cfd1ee-768d-cc03-53dd-35ccf2396863@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96cfd1ee-768d-cc03-53dd-35ccf2396863@gmail.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 10:01:36AM -0600, Frank Rowand wrote:
> On 2/28/23 22:07, Guenter Roeck wrote:
> > On 2/28/23 17:21, Frank Rowand wrote:
> >> Commit 74df14cd301a ("of: unittest: add node lifecycle tests") added
> >> some tests that trigger a kernel stack dump.  Filtering the boot
> >> messages with scripts/dtc/of_unittest_expect detects that the stack
> >> dump is expected instead of being a test error.
> >>
> >> Test beds might interpret the stack dumps as errors, resulting in
> >> needless debugging and error reports.  These test beds are likely
> >> to remove unittests due to these stack dumps. To avoid these problems,
> >> have unittest default to skip the tests that trigger a stack dump.
> >>
> >> Add a kernel cmdline option to not skip those tests.  This option can
> >> be used by testers who are able to interpret the stack dumps as not
> >> an error.
> >>
> >> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> >> ---
> >>   drivers/of/unittest.c | 54 ++++++++++++++++++++++++++++++++++++++++---
> >>   1 file changed, 51 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> >> index b5a7a31d8bd2..3a9bc2bc4ba1 100644
> >> --- a/drivers/of/unittest.c
> >> +++ b/drivers/of/unittest.c
> >> @@ -70,6 +70,36 @@ static struct unittest_results {
> >>   #define EXPECT_NOT_END(level, fmt, ...) \
> >>       printk(level pr_fmt("EXPECT_NOT / : ") fmt, ##__VA_ARGS__)
> >>   +/*
> >> + * Some tests will cause the kernel to emit a stack dump, aka back trace,
> >> + * when the test is successful.  The tests should make it possible for
> >> + * test beds to detect that the trace is not an error via EXPECT_BEGIN().
> >> + *
> >> + * Most test beds do not process the EXPECT_BEGIN() information and may
> >> + * flag the stack dump as an error, thus reporting a false failure.  It
> >> + * is hoped that the KTAP version 4 specification will add the EXPECT_BEGIN()
> >> + * processing to test beds.
> >> + *
> >> + * By default, skip tests that cause a stack dump.  Test beds that process
> >> + * EXPECT_BEGIN() information should enable these tests via a kernel boot
> >> + * command line option.
> >> + */
> >> +static int stackdump_tests_enabled;
> >> +
> >> +static int __init enable_unittest_stackdump(char *str)
> >> +{
> >> +    stackdump_tests_enabled = 1;
> >> +    return 0;
> >> +}
> >> +
> >> +static int __init disable_unittest_stackdump(char *str)
> >> +{
> >> +    stackdump_tests_enabled = 0;
> >> +    return 0;
> >> +}
> >> +early_param("of_unittest_stackdump", enable_unittest_stackdump);
> >> +early_param("no_of_unittest_stackdump", disable_unittest_stackdump);
> > 
> > Does no_of_unittest_stackdump have any benefit or value ?
> 
> I would say no, but it is a common pattern to provide both
> foo and no_foo.

It is? I see one documented example. I see numerous ones that are 
'no_foo'.

This doesn't scale well if lots of tests need to disable it. Perhaps it 
should be more generic (at least documentation/naming wise even if the 
implmentation lives in DT unittest for now).

Rob
