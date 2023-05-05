Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3786F895C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjEETOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjEETOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5198A65
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18A22612ED
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A1CC433EF;
        Fri,  5 May 2023 19:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683314042;
        bh=4jYgePMhwPc9Dims/nrzw+Gr6MqL3fFrp9uR0NeldDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GiVZFooZFKlm2eBJ0yl4stLGsdbaO2zL2nrnRdvEQs9gHL01jH8OQ6UAtGJgJwO9D
         7tomHzm2P1nqxq4MS9PnfoFA9HbaCA+yeRynxD1pBTVwhekwj2TaStxdJ/mBFDqvRe
         VVsf7Eo5rFMN7rZwmoUdOwmQp8npdCzWp+hKnARg=
Date:   Fri, 5 May 2023 12:14:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to
 zs_malloc()
Message-Id: <20230505121401.31826e1251fb8792fe64f675@linux-foundation.org>
In-Reply-To: <20230505185054.2417128-1-nphamcs@gmail.com>
References: <20230505185054.2417128-1-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 May 2023 11:50:54 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> Under memory pressure, we sometimes observe the following crash:
> 
> [ 5694.832838] ------------[ cut here ]------------
> [ 5694.842093] list_del corruption, ffff888014b6a448->next is LIST_POISON1 (dead000000000100)
> 
> ...
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Am I correct in believing that we should backport this fix into earlier
kernels?

And that a suitable Fixes: target is 64f768c6b32e ("zsmalloc: add a LRU
to zs_pool to keep track of zspages in LRU order)"?

