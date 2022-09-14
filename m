Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125EE5B8210
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiINHfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiINHfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:35:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFCF5A2E0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AhzMBhpxQIZGzblSGXJmT/FAJ97HThQ7oI5AhNR6LBA=; b=vz/ydC4NUg3N/inWnCZZctr8BL
        32yXu7cj0sdBK0ASYgQBmfeVlIDmIY2a/snafAqAM/BegoJgmMuq+a5wZ+MxSUqowSPx3kAUm8X8X
        kTosJJ//e1HTAFzap9kGN6tgkPNkBbXaM+WtNrHBIMyPljRtrFUS/5io4SNzyAHuRDmu8vBUGEjzk
        Gdgd39DQXxJalyDDpJEWcr4NVrLrUI4sS6PVa+E2jnjgBtr2sf7Xp4NZ0a3Oc3JnEcazcce8605xm
        DsEqicg4aWMehheYgkkuU8Yxao4bWgK/KhZJgeDsVkJs9tCLexX9/J4K2ZPJoU/xSSzRZDnhU319z
        ivpKtKcA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYMvo-00HZr5-SM; Wed, 14 Sep 2022 07:35:36 +0000
Date:   Wed, 14 Sep 2022 08:35:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCH 1/2] mm: fix logic error of page_expected_state
Message-ID: <YyGESKxm4eA7MSAG@casper.infradead.org>
References: <1663126621-26926-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663126621-26926-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 11:37:00AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> The page with special page type will be deemed as bad page wrongly since
> type share the same address with mapcount.

That's not wrongly.  You didn't clear the bit.  I told you you would
need to do that in the first version of the patch you sent.
