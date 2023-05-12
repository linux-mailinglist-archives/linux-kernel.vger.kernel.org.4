Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594F1701251
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbjELXJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbjELXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:09:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FB06A64
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E55263BA8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 23:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49237C433EF;
        Fri, 12 May 2023 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683932938;
        bh=Mk0cOSfhCixEuDzvt2XiRg0i4N/m7HIfr5wXU41qV0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c0MRyYLX6acmKF76NQOtyZWZ9eRLBl4A06U2rk+oVL2P9zyDaObrSP7IdDzbnbF0+
         iDssMPwLUZTXENtU80yA+bqatKc+THPd/I/uQv0Kpr7wn81R8cxMFIucaB7RCbqq7f
         5Q2a4Y0kTItOMXArku6gJoTnGpKBrIgcWIamEAbQ=
Date:   Fri, 12 May 2023 16:08:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 28/35] maple_tree: Add mas_next_range() and
 mas_find_range() interfaces
Message-Id: <20230512160857.820fc7a14256c1031c586113@linux-foundation.org>
In-Reply-To: <20230512182036.359030-29-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
        <20230512182036.359030-29-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 14:20:29 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> Some users of the maple tree may want to move to the next range in the
> tree, even if it stores a NULL.  This family of function provides that
> functionality by advancing one slot at a time and returning the result,
> while mas_contiguous() will iterate over the range and stop on
> encountering the first NULL.
> 
> ...
>  
> +/**
> + * mas_contiguous() - Iterate over a contiguous range of the maple tree.
> + * @__mas: Maple Tree operation state (maple_state)
> + * @__entry: Entry retrieved from the tree
> + * @__max: maximum index to retrieve from the tree
> + *
> + * When returned, mas->index and mas->last will hold the entire range of the
> + * entry.  The loop will terminate on the first NULL encountered.
> + *
> + * Note: may return the zero entry.
> + */
> +#define mas_contiguous(__mas, __entry, __max) \
> +	while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
>  

I can's say I'm a fan of this.  The name doesn't imply that this is a
looping construct.  I can't say much more because mas_contiguous() has
no users..


