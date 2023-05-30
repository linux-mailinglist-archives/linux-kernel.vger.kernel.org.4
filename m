Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5FC716A03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjE3Qr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjE3Qr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:47:26 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EEFC5;
        Tue, 30 May 2023 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:
        Content-ID:Content-Description;
        bh=rVinOhgR75QulUBW1f7bzGI1blZj2qzt/ZZKzq28TKU=; b=jbnLdOvt+jLXZQCmZuK3VThqrg
        DB1gQA9bSiDicKt0/EAFK8Gyt8npuiKfFI8yBTmErRMdWR5/xCasmAZuFQhHWw4H/Tp4+xpnSyG/W
        JbfiJqivfNcDv5uLnSRV1fgFTmbDRHOXm79z4ICfC9gTCcMxECyqPDzxlEr5PhRGjtAuD0/T2KzCe
        gaci//8iJVAAOruXFD3TrH6yM2ynTt/uO6wugpAEdc65/WTsMsESpD82vYORIvyBqqEaqhq6YSLuV
        DiaGS/2EfiXMSi3T/+PJ5iUhBbz1nXU5aBcrtuV+g6mHCL7lfWDevHx9X0tOWEOQ9FneFwSBuFmFF
        3G72XZ+w==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q42V9-003k7A-MZ; Tue, 30 May 2023 18:47:15 +0200
Date:   Tue, 30 May 2023 18:47:11 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] opp: Fix use-after-free in lazy_opp_tables after probe
 deferral
Message-ID: <ZHYoj7NHKVIpUceK@kernkonzept.com>
References: <20230524-opp-lazy-uaf-v1-1-f5f95cb4b6de@kernkonzept.com>
 <20230529053148.xuhuv6skg2xqworr@vireshk-i7>
 <ZHW0YY4xoUmR_UPg@kernkonzept.com>
 <20230530091330.e3nawo6ey2an4ir2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530091330.e3nawo6ey2an4ir2@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 02:43:30PM +0530, Viresh Kumar wrote:
> On 30-05-23, 10:31, Stephan Gerhold wrote:
> > Thanks, this seems to fix the crash as well. Are you going to handle it
> > or should I send a v2 with this diff?
> 
> Please send a V2 :)
> 

Done!

> > During _allocate_opp_table() it's accessed without the opp_table_lock,
> > because of
> > 
> > 	/* Drop the lock to reduce the size of critical section */
> > 	mutex_unlock(&opp_table_lock);
> > 
> > 	if (opp_table) {
> > 		/* ... */
> > 		mutex_lock(&opp_table_lock);
> > 	} else {
> > 		opp_table = _allocate_opp_table(dev, index);
> > 
> > 		mutex_lock(&opp_table_lock);
> > 		/* ... */
> > 	}
> > 
> > This doesn't seem to cause any problems in my case though so it's
> > unrelated to the crash I observed.
> 
> Hmm, right. Maybe we need a lock for that list, want to take that up ?
> 

Yeah, a lock would probably be good to be safe. I would appreciate if
you or someone else could create a patch for this though, since I'm not
too familiar with the overall OPP implementation. I would be happy to
test that it works properly for my apparently quite special use case
(I have several OPP tables with interconnects and required-opps).

Thanks!
Stephan
-- 
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth
