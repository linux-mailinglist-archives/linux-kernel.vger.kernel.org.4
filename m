Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F94766B84C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjAPHhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjAPHh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:37:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C563A449C
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30BB8CE0EAF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A505C433EF;
        Mon, 16 Jan 2023 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673854644;
        bh=Tl6jLwg9ODlFWmZcwhzVGr7C/u1X+6fbamRRbNhBmw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8qsO75donOoh2XLqMaXotNJX+0a2mfQExgIP8AZfyfLQq+yD1Pf5CP6Ni/T3XcQh
         OSVostHbcmVZ+jGtmz48pdlDvQxZ2LUemKCczVSjotUr0/9Jhg45YQVmtKexP9aIxv
         K9qRj+aTgdwXZjAE8uzkFKmQWsVNA8QhLG3jBQpbvldFXLOBIzIWEG9VN+yDzyz/MV
         PNIIJ5O1NDAuXhQIvEnCHve3RNz+3DWRvzFsyUojqcZv9mCB1yGfp8fE5/PsdUdCNZ
         NC2k15EYGjFGsKiaEk+rmQuLfL8LbyvLwIgjmfrsJSqNMCRaUDV4hT69fsKqotbLFU
         gj5yF0jfEkHvA==
Date:   Mon, 16 Jan 2023 09:37:13 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] memblock: Make finding index faster when modify
 regions.
Message-ID: <Y8T+qWlUT1KTeFNI@kernel.org>
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
 <20230113082659.65276-3-zhangpeng.00@bytedance.com>
 <Y8QHehG1L+kuyqoR@kernel.org>
 <acbfecf4-e3ee-4df2-6685-6cefca38bde6@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acbfecf4-e3ee-4df2-6685-6cefca38bde6@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:17:40AM +0800, Peng Zhang wrote:
> 
> 
> 在 2023/1/15 22:02, Mike Rapoport 写道:
> > Hi,
> > 
> > On Fri, Jan 13, 2023 at 04:26:58PM +0800, Peng Zhang wrote:
> > > We can use binary search to find the index to modify regions in
> > > memblock_add_range() and memblock_isolate_range(). Because the
> > > arrangement of regions is ordered. It may be faster when there are
> > > many regions. So implemented a binary search and a new macro to walk
> > > regions.
> > 
> > Did you see a measurable speedup with this optimization?
> > I'm not in favor of micro-optimizations that complicate code.
> > 
> Thank you for your reply. I haven't measured this patch yet, theoretically
> this small optimization might be difficult to observe.
> If you think this patch complicates the code, you can ignore this patch.
> 
> These three patches are independent and they can be applied independently.
> The logic of the third patch is very simple. It will not complicate the
> code. It is tested by the default configuration of qemu. The total number of
> iterations of memblock_merge_regions() in the third patch is reduced from
> more than one thousand to more than one hundred, this is only in the case of
> a small number of regions. Can you consider the third patch?

Can you please send the numbers and show how did you obtained them?

> Sincerely yours,
> Peng.

-- 
Sincerely yours,
Mike.
