Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98F6637135
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKXDnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKXDm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:42:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09B1B780
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:42:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A78EA61FCC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B738EC433D6;
        Thu, 24 Nov 2022 03:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669261364;
        bh=AgsUT7s3Sfpy8dQlDo9iTeQkBb6g2g+CWfKBFi93034=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c7VhyZP1qUOd+j90j3hwiwpQRfbAE8387q93npYgBe3S8Kf4ZOD91F+UJ+DHeEoDY
         79SNkHzitnc2GlL2xJHYX2kH700c23IuprIGL0GQuNDaMhiryDYHNn5g54SMArSpLB
         YZeDvZOK/1yJuWNyJtvrgNXC78oR7I+p7qqHgQxg=
Date:   Wed, 23 Nov 2022 19:42:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not allocate from atomic pool
Message-Id: <20221123194243.4031e6918c55437071d3a344@linux-foundation.org>
In-Reply-To: <Y37l3Xxb172q632L@google.com>
References: <20221122013338.3696079-1-senozhatsky@chromium.org>
        <Y3w/DFTAypX7L2mp@cmpxchg.org>
        <Y3xCTr6ikbtcUr/y@google.com>
        <Y37l3Xxb172q632L@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 12:32:45 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Folks, how do we want to proceed with this? One of the hunks here
> conflicts with https://lore.kernel.org/lkml/20221119001536.2086599-2-nphamcs@gmail.com/
> 
> Do we want to remove conflicting hunk from "[PATCH 1/6] zswap: fix writeback
> lock ordering for zsmalloc" and pick this patch up?
> 

The "Implement writeback for zsmalloc" series is clearly due for one or
more new versions, so I will drop that series and I will apply "zswap: do
not allocate from atomic pool".  Let's ask Nhat Pham to prepare future
revisions of the "Implement writeback for zsmalloc" series against
mm-unstable.
