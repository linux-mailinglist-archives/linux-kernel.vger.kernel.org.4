Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF756F9D11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjEHAq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 20:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHAqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 20:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1C5B6
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 17:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2220260B34
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B12C433EF;
        Mon,  8 May 2023 00:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683506813;
        bh=5yn9ON7IVdJ/bvAcxEMi2Npkf+JiVRbjTSIC0DjWjJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ThcfmBj4v4Mw/XTZzJfLCs+gUJLqbJYuBOxT0Vo1hD0ypQz7C+hGLV/aQzwMYKDty
         SUoXo3FkUIXxC1Pc3Dc39+zAOjiGh98EKV0B8W2pGl873l5JonyYB16gQb0diD5KHh
         eRt91zprdviMd9BVGQfcJGQwepkYyQ8zYFGoC7kM=
Date:   Sun, 7 May 2023 17:46:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peng Zhang <perlyzhang@gmail.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH] maple_tree: Fix potential out-of-bounds access in
 mas_wr_end_piv()
Message-Id: <20230507174652.65fb5725c3a72dd293d417b3@linux-foundation.org>
In-Reply-To: <1570feed-489c-82f7-8d6b-9f53e9ebb87e@gmail.com>
References: <20230504031422.47506-1-zhangpeng.00@bytedance.com>
        <20230506011447.2e47mf5kwwo4yz4r@revolver>
        <1570feed-489c-82f7-8d6b-9f53e9ebb87e@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 May 2023 09:48:19 +0800 Peng Zhang <perlyzhang@gmail.com> wrote:

> >> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> > 
> > Cc stable ?
> I don't know if it should be cc stable since Andrew says it
> always needs to describe user-visible impact.

I suppose we may as well backport it - there may be new users of maple
tree which *do* trigger this, and anyone who who tries to backport
those users into earlier kernels will get a nasty surprise.

So I'll add cc:stable to v3, but I won't queue it as a hotfix, so it's
well tested before we propose the backport.

