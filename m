Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB300606ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJUERo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJUERg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:17:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A587F144E22
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E85161D9D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29841C433C1;
        Fri, 21 Oct 2022 04:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666325854;
        bh=pHUX7kQhg+qJZIQCthaob3/LECmst3jbCdEp9qpk9tA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GDu9CVVG8Jxiy18xdfkINdxM/4UphCMFnRgUFQkHKeG3xCR+hzR1EqLE4+TCeVcZw
         30ljUr8xk9N8l2hixS5QhG+0w/nQyIm6B9aT7GCxahqS4Jxn+49OCaK1mBdaBFMqys
         BnYKneLphVG+Hfl1wTc0m/uT8qwMxUQhtageyPW0=
Date:   Thu, 20 Oct 2022 21:17:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Matthew Wilcox <willy@infradead.org>, <ziy@nvidia.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mike.kravetz@oracle.com>,
        <opendmb@gmail.com>
Subject: Re: [PATCH] mm/page_isolation: fix clang deadcode warning
Message-Id: <20221020211733.31b2ee4f81805186367304b0@linux-foundation.org>
In-Reply-To: <23081249-229b-b745-50f5-53e394b623c9@quicinc.com>
References: <20221021030953.34925-1-quic_aiquny@quicinc.com>
        <Y1IPqhVpiehRBGNS@casper.infradead.org>
        <23081249-229b-b745-50f5-53e394b623c9@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 11:26:22 +0800 "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com> wrote:

> > Honestly, the cure is worse than the disease.  I'd rather not have a
> > line that's this long.
> I don't like this long either. While the current Deadcode warning is 
> also annoying for our clang tidy check.
> 
> will the CONFIG check can be acceptable?
> like:
> 	#ifdef CONFIG_DEBUG_VM
> or
> 	if (IS_ENABLED(CONFIG_DEBUG_VM))
> 
> Any good ideas?

Put a newline in there?

Although the shortly following lines are nearly as long...
