Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCA639B20
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 14:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiK0NgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 08:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiK0NgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 08:36:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA0311462
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 05:35:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ABE7B80AF9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2F4C433D6;
        Sun, 27 Nov 2022 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669556125;
        bh=G4G6WX6djSr8V364KenjtdxlbWifLcMCgt7yqzLrGiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzbGU4xVeipL+oXAGmaJNxDh3A7bqCgcMCqh+dwgFT0KHf5hpINM6uOZtDenF9tQA
         rLRGjSCr+biUsmgaTOJVcKWL6O4rW48P6ZXVzUs0DG9A1N/VfjD2d8hbna1k5dhYjn
         0SIUqSP6mYct3xIpVs0hggzcpdfv6mSFDFIJ+T4+Hib3BcQ3ccXd1Imrrqgp4kRhU3
         jiKBxPojrIBQwWJTF+M4nYElSr64/9vZa373dOY6BEJ933rDg7EAvXu3RZcjHQdVMD
         hlyL+UpHkAWoa09pwjqLot1DSc2VgpUFV80GkhIZwzdDZaHE9bHIfvPqkNBBJ8qL6Q
         jVoWgjWQuc37w==
Date:   Sun, 27 Nov 2022 21:35:19 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: enable large folio in device-based mode
Message-ID: <Y4Nnl9YXSjDbN8xs@debian>
Mail-Followup-To: JeffleXu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org
References: <20221110074023.8059-1-jefflexu@linux.alibaba.com>
 <315099ec-b6c3-1aa0-c83e-86f6074bd674@linux.alibaba.com>
 <Y23taS26HMwhkdhN@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y23taS26HMwhkdhN@B-P7TQMD6M-0146.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:36:25PM +0800, Gao Xiang wrote:
> Hi,
> 
> On Thu, Nov 10, 2022 at 03:59:14PM +0800, JeffleXu wrote:
> > 
> > 
> > On 11/10/22 3:40 PM, Jingbo Xu wrote:
> > > Enable large folio in device-based mode. Then the radahead routine will
> > > pass down large folio containing multiple pages.
> > > 
> > > Enable this feature for non-compressed format for now, until the
> > > compression part supports large folio later.
> > > 
> > > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > > ---
> > > I have tested it under workload of Linux compiling. I know it's not a
> > > perfect workload testing this feature, because large folio is less
> > > likely hit in this case since source files are generally small. But I
> > > indeed observed large folios (e.g. 16 pages) by peeking
> > > readahead_count(rac) in erofs_readahead().
> > 
> > Sorry, readahead_count(rac) returns the whole number of pages inside the
> > rac, which can not prove large folio passed in.
> > 
> > I retired later and observed large folio (e.g. with order 2) by peeking
> > folio_order(ctx->cur_folio) inside iomap_readahead_iter()
> 
> I will test it as well after I send out all bug fixes for this cycle.

I've updated the subject and commit message as:
"
erofs: enable large folios for iomap mode
Enable large folios for iomap mode.  Then the readahead routine will
pass down large folios containing multiple pages.

Let's enable this for non-compressed format for now, until the
compression part supports large folios later.
"

Thanks,
Gao Xiang

