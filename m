Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23616724B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbjFFS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbjFFS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:29:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11851712
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:29:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so25511745e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686076154; x=1688668154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JSdrg+UUFQJRbBaT65t9KQ0k6wnVcWDvrdEoLF/qj3w=;
        b=TjbNAs5eMwUHdtHoS35R2Dg2L8xWx1/jmWIkC2AcnZcWafaM0RToQXl+enz4B83MWV
         bYJC1LhCRD4PXWbh5GyYb7tl9KVsARHZx/BVirT5IsUjZkMOv+FRYDDfhDxvGXg7Ae7J
         f+E1fRGRsyZ1Z5tKfgWz3bL4OuE1w9bZTv+MD9r8gyYoylTsy0rDjWRcu+lv2QM0jD3Q
         0UC1nbAT60mtNmsM/+NVtRL5+GF4maumi46cLoScJy/VGCzFh/0sm2msxAw5dMrlLfZZ
         qAd4X/PnJaUM4KvZUh+vFPcXtxQ8tvM8cd4K2CPf86xj5XFpE2uZ2yeke6dymTMqEJSP
         ctEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686076154; x=1688668154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSdrg+UUFQJRbBaT65t9KQ0k6wnVcWDvrdEoLF/qj3w=;
        b=bmO3irNathScVBWAQJzzOmBfQxvfqpEvz3ns909EppMh167BRremc31dLx4V3nENwg
         X/8L1t7GUWlexcyaY9GIk0ejS7BselKsJVuxtlY+EQnB2HWbirvIOaHxGwCbZwUhFdcS
         KlEr9uWS+H2/m5PsvSXg6tyAsSgpLeBxF7FUR6jhWKPVFbj/vZGfG+0jZaReQ4TNVOb4
         GZJP2Cm3KGVa0L+byYK4fMXCa+EdMbt3C3agjHJ2tPPBk9qI6mkQhL+ZhSqN3qa6TLo/
         msfZFvvh6Xlu9Q8HmceSxEvaedPb3LvL04gMl8hYrY4RjhyxWPzGp4zwuNSffvVi1RMo
         AFUA==
X-Gm-Message-State: AC+VfDyr9ducXnsJeGW4tX826Jrdx7vdEgnjkX9tm2XjcyFMXsrRRh2r
        5MBfEqojGvCy1HZhJNcxft473w==
X-Google-Smtp-Source: ACHHUZ6tnE3ZQrR14O8GiKBB5dGR00syzyGfixjm4MzBP0Syxdz4Y/iAzcQs0+KLT6/Sfa/QUIjZnQ==
X-Received: by 2002:adf:ea48:0:b0:2ce:d84d:388f with SMTP id j8-20020adfea48000000b002ced84d388fmr2824604wrn.40.1686076154172;
        Tue, 06 Jun 2023 11:29:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d458c000000b00307acec258esm13353778wrq.3.2023.06.06.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:29:12 -0700 (PDT)
Date:   Tue, 6 Jun 2023 21:29:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Franziska =?iso-8859-1?Q?N=E4pelt?= 
        <franziska.naepelt@googlemail.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>, keyrings@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
Message-ID: <93f96b93-2f2e-4c98-8ffd-1bd0bd441347@kadam.mountain>
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com>
 <ZH8mhIrjyBvTF4oZ@debian.me>
 <e39efb7f-5d8f-4433-83b3-8eea8a6c0486@kadam.mountain>
 <CT5NH4XXIYQF.5XXJE6JA5FZP@suppilovahvero>
 <e44d03cf-9993-483c-b3d4-6185f5c028cc@kadam.mountain>
 <CT5P0JH7NOTO.3P08AWR6O128R@suppilovahvero>
 <CAAUT3iPVFZEQE+bFk4HhWbaAtnsbQLYrzggeD2Va4mC0Q09SNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAUT3iPVFZEQE+bFk4HhWbaAtnsbQLYrzggeD2Va4mC0Q09SNQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 07:59:02PM +0200, Franziska Näpelt wrote:
> Am Di., 6. Juni 2023 um 18:03 Uhr schrieb Jarkko Sakkinen <jarkko@kernel.org>:
> > On Tue Jun 6, 2023 at 6:25 PM EEST, Dan Carpenter wrote:
> > > On Tue, Jun 06, 2023 at 05:51:09PM +0300, Jarkko Sakkinen wrote:
> > > > On Tue Jun 6, 2023 at 4:38 PM EEST, Dan Carpenter wrote:
> > > > > On Tue, Jun 06, 2023 at 07:28:52PM +0700, Bagas Sanjaya wrote:
> > > > > > On Fri, Jun 02, 2023 at 10:59:02AM +0200, Franziska Naepelt wrote:
> > > > > > > The following issues are fixed:
> > > > > > > - WARNING: Missing or malformed SPDX-License-Identifier tag
> > > > > > > - ERROR: trailing statements should be on next line
> > > > > > > - WARNING: braces {} are not necessary for single statement blocks
> > > > > > > - ERROR: space required before the open parenthesis '('
> > > > > > > - ERROR: code indent should use tabs where possible
> > > > > > > - WARNING: please, no spaces at the start of a line
> > > > > > > - WARNING: Missing a blank line after declarations
> > > > > >

[ snip ]

> 
> I'm a bit puzzled now since there are different opinions on my patch.
> I'm struggling to draw a conclusion whether to split the patch into smaller
> single line patches or not.
> 
> I'd propose to split it into two patches:
> * One for SPDX license tag fix
> * One for spacing, tab, blank line, unnecessary braces etc.

You should definitely pull the SPDX change into its own patch because
it's sightly controversial and important.

In drivers/staging/ we would say pull each type of checkpatch warning
into its own patch so it would be something like 6 patches.  But I don't
know how it's done in this subsystem.  I feel like Greg maybe goes
overboard on splitting patches up, but the advantage of Greg's system is
that it's easy to explain the rules to newbies.  There is a lot about
staging/ which designed around newbies.

If I'm totally honest, in a lot of subsystems the policy is just leave
it alone.  Don't bother cleaning up checkpatch stuff because it just
creates more work and makes the git log noisier.

regards,
dan carpenter
