Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F62C64BCE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiLMTMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiLMTLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:11:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A14220E4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:11:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7F4AB815BB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBCDC433D2;
        Tue, 13 Dec 2022 19:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670958670;
        bh=/VeZtsI4jZz7Y++Dl+hs6w4K2j0s34Gujm/rr1i5/0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CwexaBGc4Uanr5oZfvr1a+liupkMwiLS8HTgnuvrJMxuRL8N7fHajOG3D9jOVdMSE
         0T8M4szF7ZcMocoKrz8KSmbxFRM2XL7Uwhr9tCjXWqZAPK7Jbsz2aQbdwh0f94Bb+7
         GGN5Hf9EsJzWP0NEIvcEtYph2rPdgy83eljNcCwUbPt+8GYnF6GDsNUiKjCS9iyoKg
         NxNDDeYY2gZN8tP9ZgY1ONKPwn2P3Y1l72BeWNthnYYMVFJXTQwAOOaHJJIfkkvcrZ
         +VFIjTAOD3SA3GuX/lur1fXMmFXRSjcFc0yFq34yQrZS0g3qc/ZRTiWgswSYEAk8/q
         t1FnCE5y4q6yg==
Date:   Tue, 13 Dec 2022 11:11:08 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix iostat parameter for discard
Message-ID: <Y5jOTL66ph3Nq/Hr@google.com>
References: <ddf243c9-f557-7f11-1964-8d2324f84092@kernel.org>
 <20221213115454.14885-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213115454.14885-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13, Yangtao Li wrote:
> > What do you think of extending this function to support io_counts?
> > 
> > void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
> > 			enum iostat_type type, unsigned long long io_bytes,
> > 			unsigned long long io_counts)
> 
> Support to have extra io_count.
> 
> But I don't think there is any need to add additional parameters to f2fs_update_iostat.
> IIUC, each call to f2fs_update_iostat means that the corresponding count increases by 1,
> so only the internal processing of the function is required.
> 
> BTW, let's type out the iocount of the additional record in the following way?
> 
> time:           1670930162
> [WRITE]
> app buffered data:      4096(1)

How about giving in another columns with additional stats like avg. len/call or max. len?

app buffered data:      4096	1

> 
> Thx,
> Yangtao
