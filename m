Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1A6A50AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjB1BZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB1BZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:25:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFE028856
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:25:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41794B80DD2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640A6C433EF;
        Tue, 28 Feb 2023 01:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677547544;
        bh=kmjqpySMhE16uFWHoYoNjT55OARJoXTSrw91rhPkC5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xg1djx+zsnCP1WarW2dmdsY73vCUduoAuuLQRd+ITn9BZDhj+v11d50C0+lqDQwl2
         ey8geH/KKNwFgPtESRt/iW/nggiHrWaqlw1hxCNNvdRRkf1wvzKPa+jpZkeC7siU16
         CttMYv4mIYaAWCYztCa0+UImhtGn4oXH78tV+EuaYljFZ1yv3BR9/ZAyEM8sqkhYsH
         scwuWIsdTH3UJREcUlm/gQ8eoYXa6bDKMVObQGY8FcYI0Ev4SdmQDsgeakmC9/ngde
         mrGaGjdiu9hlZysBoVkkbITZ8OzTL+4fZ+Jrfr6ND9r4AsgZFGxLw7fCUX6OGtp+6U
         4f2OTpaq/qyGQ==
Date:   Mon, 27 Feb 2023 18:25:41 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
Message-ID: <Y/1YFV49T/wJ6ndd@kbusch-mbp.dhcp.thefacebook.com>
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

Okay, I think this is good to go to merge now. My local testing also show this
fixes the megaraid issue that Guenter reported on the other thread, so I
believe this does indeed fix the only reported issues with the dmapool
enhancements.
.
