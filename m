Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7874CF43
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjGJH6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjGJH6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:58:04 -0400
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [IPv6:2001:41d0:1004:224b::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F16D123
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:58:02 -0700 (PDT)
Date:   Mon, 10 Jul 2023 16:57:54 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688975879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N49N5zz7PJN8d+71h+5mF4vSm+C4rcP6xT4u+oKd/Og=;
        b=kZwcshxcfisGNakXAiOWcwE2dZ36F5epybU6sT2TAr2Gzq2MEK6aBJ/Sc1ef29Dkvo8Kxe
        rAJO6GBnHJwBlrgMayM3GlGy7SgVf79c5kaZyPhERgesYKEPDIPZiQ3FEJpvLw34nb815O
        Vji1UMCcnHw9liV+Ct9/cSntK+8/Hqs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] mm: memory-failure: fetch compound head after extra
 page refcnt is held
Message-ID: <20230710075754.GG1686200@ik1-406-35019.vs.sakura.ne.jp>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
 <20230708085744.3599311-8-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230708085744.3599311-8-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 04:57:43PM +0800, Miaohe Lin wrote:
> Page might become thp, huge page or being splited after compound head
> is fetched but before page refcnt is bumped. So hpage might be a tail
> page leading to VM_BUG_ON_PAGE(PageTail(page)) in PageTransHuge().
> 
> Fixes: 415c64c1453a ("mm/memory-failure: split thp earlier in memory error handling")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
