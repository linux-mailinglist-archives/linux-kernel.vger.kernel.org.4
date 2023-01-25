Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A71667B50F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjAYOqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbjAYOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:45:53 -0500
Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A80246BC;
        Wed, 25 Jan 2023 06:45:40 -0800 (PST)
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h7.fbrelay.privateemail.com (Postfix) with ESMTPS id A076A6043A;
        Wed, 25 Jan 2023 09:37:20 -0500 (EST)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 7B14018000AD;
        Wed, 25 Jan 2023 09:36:49 -0500 (EST)
Received: from pappasbrent.com (rrcs-24-173-168-34.se.biz.rr.com [24.173.168.34])
        by mta-13.privateemail.com (Postfix) with ESMTPA id D950B18000A5;
        Wed, 25 Jan 2023 09:36:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1674657409;
        bh=PbvZ1odo1oP/yBqbXfOr0eqNv09YjB8du1ZosZ2PEho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1nwQXuWITg+Cio0nlnrTLzC+3/vvLkblscPhaiUP8QPgYEUk1ecvU4tVlfgWjQg6
         X5SMEfL4IIKen53Nn6XBDkvYG172efPdees0D0on6S7XnEkZ0DW3/6zL34TjXdu4HL
         ZIURAtAplvjGGRFuKSwsdiZ0oRQscJ9pQbom0YIPLUaQxwoL2HhSI1nZCX7R+pXe1E
         1MHGzAn3qulPwvtnKfO9IJDGZanQHe5H/OM9OpqMyZc2nX7f1+oEPBMlnJzjQA0KZq
         4+06rG+lxFTdIiJM+wNnTA9vnF97mf+M1pxuCJpX0mm70TP3IS1AwOD4KqfqmyKvyr
         eai5npi4tZsWA==
Date:   Wed, 25 Jan 2023 09:36:36 -0500
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdeia: ipu3: ipu33-mmu: Replace macro IPU3_ADDR2PTE()
 with a function
Message-ID: <Y9E+dGgQXFUQnIb8@pappasbrent.com>
References: <20230124135554.13787-1-bpappas@pappasbrent.com>
 <Y8/uTYK7qmYD5MSA@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8/uTYK7qmYD5MSA@kadam>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> When you say "Linux coding style standards" what exactly does that mean?

I am specifically referring to this line of
Documentation/process/coding-style.rst, from the section "Macros, Enums,
and RTL":

> Generally, inline functions are preferable to macros resembling
> functions.

This is the first reason I chose this specific macro.
IPU3_ADD2PTE() would behave the same as a function, so based on my
reading of coding-style.rst, I thought it would be appropriate to
proprose turning it into a function.

Full disclosure, I am university student, and my current research
project is on creating a static analysis framework for finding macros
that can be easily turned into functions.
I want this project to have an impact on widely-used code,
and so I have been using this framework to find such macros in Linux.
That is why I have recently been submitting patches to turn macros into
functions.
So the second reason I chose this macro was because my framework
identifies it as transformable.

> This code is in the middle of a big section full of macros.  Why did you
> pick this particular macro?  Now it doesn't mirror the IPU3_PTE2ADDR()
> so this patch hurts readability.

The reason why I did not try to turn the macro IPU3_PTE2ADDR() into a
function is that it is never invoked, and my framework does not identify
uninvoked macros as transformable.

There are more macros in drivers/staging that I think could be turned
into functions, and I would like to continue submitting patches to do
so.
However, if you would rather I change the way I am doing this,
or that I stop submitting these sorts of patches altogether,
please let me know.

Thank you,
Brent

