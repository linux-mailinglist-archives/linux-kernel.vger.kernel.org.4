Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28C361318F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJaIRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaIRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7865FB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC27461031
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D6DC433B5;
        Mon, 31 Oct 2022 08:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667204224;
        bh=URxGX3rN0t4vDzNmnpRLGdtDfedX1xDpndmmWDxKjO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtizLyWTlicoIYLxEUip8appSngpFlGx70dK3zqlq3RovHYO7gKMpOQ4Mh5qXatxT
         LxEjp3/8Ndfqq6sCyMkIMc+2pk6Ds24u1eP0qb+/sHcWOTnq6kqFPeI1oUXN4ll+Fe
         vnMIUqPTjV6MzSAw5o0wMrNbEBEVPA0g+V2YbzqkF+KJa1AuOO8OPTt+Edd6K4Cgoo
         HB/ayGS9vDJnW5BIF9laUa8v6ZlPvSSO2hdCg6Cfk8VR89TPEfvu+bSwcEbIRbTWsd
         CokEf+FfcdErmqBzG3zdHwUSdBEnxzh1yY7nze9g4gzDI13JP4WdXp1D6MUCtakIEF
         Ex6+5XlAdWysQ==
Date:   Mon, 31 Oct 2022 10:16:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock: don't run loop in memblock_add_range() twice
Message-ID: <Y1+Ec0+S3du7dkGZ@kernel.org>
References: <20221025070943.363578-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025070943.363578-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:09:43PM +0800, Yajun Deng wrote:
> There is no need round twice in memblock_add_range().
> 
> We can call memblock_double_array() to extend the size if type->cnt
> greater or equal to type->max before memblock_insert_region(); otherwise,
> we can insert the new region directly.
> 
> v2:
>  - Add a comment when the allocation is required.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/memblock.c | 69 ++++++++++++++++++---------------------------------
>  1 file changed, 24 insertions(+), 45 deletions(-)

Applied, thanks!
