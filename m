Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768CA611A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ1SjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJ1SjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:39:17 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9F16386E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PWiV8j5n/RdXGJuppn6+le1V0xVgkNZA349ibTs5MvQ=;
  b=nE/yAeICbF56Vj0acAgXSQsqQc/EJrv5ychSxlNWEjnl7FAYBxlyeKiI
   R4j464tWvtg2SC3ayXBhhVf1YPy/BlrMrMaeuoXX2DZ363YxUOfaMv+Pp
   PfgPR7BWBTPYtZ2Yw0OSwS2xKp4e6z4fnxkldSompK8qj33TPbcnHHLQH
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,221,1661810400"; 
   d="scan'208";a="35863678"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 20:39:14 +0200
Date:   Fri, 28 Oct 2022 20:39:12 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Emily Peri <eperi1024@gmail.com>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Replace ternary statement with min
 function
In-Reply-To: <Y1wWwZdlXNil/lug@marshmallow>
Message-ID: <alpine.DEB.2.22.394.2210282038450.2987@hadrien>
References: <Y1neXqVYZ8mq8jH+@marshmallow> <Y1oz/w9qfwQ+8gWt@kadam> <Y1wWwZdlXNil/lug@marshmallow>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Oct 2022, Emily Peri wrote:

> On Thu, Oct 27, 2022 at 10:32:15AM +0300, Dan Carpenter wrote:
> > On Wed, Oct 26, 2022 at 06:26:54PM -0700, Emily Peri wrote:
> > > Ternary statements that pick the min of two values can be replaced by
> > > the built-in min() function. This improves readability, since its quicker
> > > to understand min(x, y) than x < y ? x : y. Issue found by coccicheck.
> > >
> > > Signed-off-by: Emily Peri <eperi1024@gmail.com>
> >
> > This breaks the build.  Use min_t(uint, wps_ielen, MAX_WPS_IE_LEN);
> >
> > regards,
> > dan carpenter
>
> Oh! Thanks for the feedback, that makes sense! When you say 'breaks the
> build,' do you mean it didn't compile, or the module didn't load (or
> something else)? I'm trying to figure out what I did wrong when testing
> it.

Normally it means that it didn't compile.  Check that you actually have a
.o file for the affected file.

julia
