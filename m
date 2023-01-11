Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62222666369
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjAKTRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbjAKTRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:17:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7120F15733
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:17:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6BC61DF5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC93C433D2;
        Wed, 11 Jan 2023 19:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673464632;
        bh=sRbHWzESzzQyqWDjoUMBpL3B16QI+DxrTxxVS41/8zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jnkstjhlof3uqxsUvMvQBHcGW0Joc5n8nRCU94fH+bOz2sEQNrZdLTcuRMQNWErCe
         2jHY/o6bwftD6irMTeZnOTBUxo52JyTxqx5EqKkGtYgpuvgzZwqjmFYqNkwucb51ZB
         cPw139UJS0UjvEIMp03OFaor2vGrSjv4CjYNFJyhwRRD/s0JnnTOx3Ljp5h4fTJlxp
         G3MyK/pee9aEzbQgHCpj9hvEQMFXgUx0F+V2HOt/nFpP+XRDvRSQA/WMlKQQ7WFDXT
         ggaLzvmDZUuZ1zmvJnltWKxUsknBngyDhSEmaMeTDuovCiAVWa9DQJkwLWgsIV5tk8
         kpyofALbBt0Nw==
Date:   Wed, 11 Jan 2023 11:17:10 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] f2fs: reset iostat_count in f2fs_reset_iostat()
Message-ID: <Y78LNobSXGF5N3tn@google.com>
References: <20230104112158.15844-1-frank.li@vivo.com>
 <Y7XRc+UiLBF/m3KW@google.com>
 <7378f01b-3f02-a81c-7266-c743381131fb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7378f01b-3f02-a81c-7266-c743381131fb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11, Chao Yu wrote:
> On 2023/1/5 3:20, Jaegeuk Kim wrote:
> > Hi Yangtao,
> > 
> > These are all in dev-test branch, which means you don't need to stack up more
> > patches on top of it. I just integrated most of them into two original patches.
> > Could you please take a look at this?
> > 
> > c1706cc0cd72 f2fs: add iostat support for flush
> > acd6f525e01c f2fs: support accounting iostat count and avg_bytes
> 
> +#define IOSTAT_INFO_SHOW(name, type)					\
> +	seq_printf(seq, "%-23s %-16llu %-16llu %-16llu\n",	\
> +			name":", sbi->iostat_bytes[type],			\
> +			sbi->iostat_count[type],					\
> +			iostat_get_avg_bytes(sbi, type))			\
> 
> '\' doesn't align in column, otherwise it looks good to me.

Applied with the fix.

> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
