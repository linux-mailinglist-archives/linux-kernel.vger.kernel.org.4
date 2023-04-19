Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790196E821E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjDSTtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDSTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68651BD8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 736AD64202
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9DFC433D2;
        Wed, 19 Apr 2023 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681933742;
        bh=tJAJOI4zNpAbAbSJ2yiWr+f0FAyzO0/dqLTfBJ1SAuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YZ6MVO3RRUTR+rziKBAQ2Slq8Tjj2nwPpk/s6NbJ25w8iAiaFw9c8aDVrmXDscW8Q
         ic0xEnsKEGMniLygHDocWC0YQtdfkMLVkJ2JquZUY4SCkkHYMbfR0hjIUSbmIled2o
         xxMKQ+QHowfWK2eJAk8cLimZAvft7Mf7r8XwNt7U=
Date:   Wed, 19 Apr 2023 12:49:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: Fix allocation in mas_sparse_area()
Message-Id: <20230419124902.7cb9b5c54afa37736e7b0e3a@linux-foundation.org>
In-Reply-To: <20230419093625.99201-1-zhangpeng.00@bytedance.com>
References: <20230419093625.99201-1-zhangpeng.00@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 17:36:25 +0800 Peng Zhang <zhangpeng.00@bytedance.com> wrote:

> In the case of reverse allocation, mas->index and mas->last do not point
> to the correct allocation range, which will cause users to get incorrect
> allocation results, so fix it. If the user does not use it in a specific
> way, this bug will not be triggered.

Please describe the user-visible effects of the bug.  I assume "none",
because there are presently no callers which can trigger it?

> Also re-checks whether the size is still satisfied after the lower bound
> was increased, which is a corner case and is incorrect in previous versions.

Again, what are the user-visible effects of the bug?


