Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1B6A2E38
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBZEmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZEmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:42:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F7A267
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A29BB80B4A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FCAC433EF;
        Sun, 26 Feb 2023 04:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677386560;
        bh=7soadUqF8bqnJkkIfos9CWXrTcoTBNE1BqinRtt4eGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H8W7SOGN0a6ut0/2Hf5Bjj+jwJgDv+DMFReZVxNbT3n6edsVmX8a19TkNS8B1rLs1
         X/DWp7GUpeyTMzm77hgMw4Miv3J6JBGeJ+sa2NN7LGJaSE2uavuIvhx6AJ4DH/m8ZQ
         IuxQxzvPVR2DBq9ScXF3SVC7+k5G3zPN/rJYKlJ8=
Date:   Sat, 25 Feb 2023 20:42:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
Message-Id: <20230225204239.21f1e1ab9c9523f803d9624c@linux-foundation.org>
In-Reply-To: <20230221165400.1595247-1-kbusch@meta.com>
References: <20230221165400.1595247-1-kbusch@meta.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 08:54:00 -0800 Keith Busch <kbusch@meta.com> wrote:

> Some users of the dmapool need their allocations to happen in ascending
> order. The recent optimizations pushed the blocks in reverse order, so
> restore the previous behavior by linking the next available block from
> low-to-high.

As I understand it, this fixes the only known issues with patch series
"dmapool enhancements", v4.  So we're good for a merge before 6.3-rc1,
yes?
