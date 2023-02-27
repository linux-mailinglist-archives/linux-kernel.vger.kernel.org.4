Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E0E6A47C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjB0RU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjB0RUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:20:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE421A3F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:20:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3CBA2CE10DC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45196C433D2;
        Mon, 27 Feb 2023 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677518420;
        bh=Iw8IA0xQQ6AWO/IvDcxiYcoAIZ0+/X2ORKoy7fxd9R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfHE9dQJA+fi/a6rj+FkG5uCY9I4N+Hv+12M5kXlY2wvkbFawLfuQrIrZyG0F56q0
         qj8WLDAS4Hw98wkwmXBxWTFBwVimMxXMg6dd8T5CohOFbdLXntL7pMPd2WjjTdL89H
         8poPADCalqEfgSxj5NSmR9ooBzrfGCaUocIeA1kMXcn0w/2yrLKjTgmPU6W/suftRx
         tzySlTHscNplKZZF0pj4BKdgNC1OXy1VaL9l7W7oRo/21Im5rfZcF786Vc+x+vko7E
         pqgBjL+uHdB47wsQUYYOvwe39nWNNKpMBYKAtQHGe9BXkLViNR2eMlkmXpYDKL+3BG
         scuGjOMJ08dng==
Date:   Mon, 27 Feb 2023 10:20:17 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
Message-ID: <Y/zmUXrAiNujjoib@kbusch-mbp.dhcp.thefacebook.com>
References: <20230221165400.1595247-1-kbusch@meta.com>
 <20230225204239.21f1e1ab9c9523f803d9624c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225204239.21f1e1ab9c9523f803d9624c@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 08:42:39PM -0800, Andrew Morton wrote:
> On Tue, 21 Feb 2023 08:54:00 -0800 Keith Busch <kbusch@meta.com> wrote:
> 
> > Some users of the dmapool need their allocations to happen in ascending
> > order. The recent optimizations pushed the blocks in reverse order, so
> > restore the previous behavior by linking the next available block from
> > low-to-high.
> 
> As I understand it, this fixes the only known issues with patch series
> "dmapool enhancements", v4.  So we're good for a merge before 6.3-rc1,
> yes?

I was going to say "yes", but Guenter is reporting a new error with the
original series. I working on that right now.
