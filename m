Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6672D141
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbjFLVBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbjFLVBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B174217
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403636201C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385EFC4339B;
        Mon, 12 Jun 2023 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686603403;
        bh=esReKupd2Q+U5e9D0ZPlm+IOx1guVso/zouKmwF3zzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P040Znj9FzEMglCMnBVGZir5sagKiKHndrVQsaGA97kyKvJBxSn8vGGtUGpZNa5Fw
         oMyscfCKZohaDzoOTiB/BljqzZTwJ11IwcAjr9k28wpbOtyTllOLvhc3h8yHifZBTi
         Cpv3uMykHs4jyagg3LWyk5o2kWwbfd/6TXfOQ7yI=
Date:   Mon, 12 Jun 2023 13:56:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCHv5] mm: skip CMA pages when they are not available
Message-Id: <20230612135642.24cef34a2925cdde257c1a50@linux-foundation.org>
In-Reply-To: <b72118b0-47dc-86c4-15fb-fb5ea72bcf30@redhat.com>
References: <1685501461-19290-1-git-send-email-zhaoyang.huang@unisoc.com>
        <20230609153519.ff01046ef0faff00a74bd5b0@linux-foundation.org>
        <a562bae0-d779-620a-98bc-6102468aecae@redhat.com>
        <CAGWkznFv=LjrjdqvepYtMP-e5JRp2wuWakd=CGLQQZ7aBx36Hg@mail.gmail.com>
        <b72118b0-47dc-86c4-15fb-fb5ea72bcf30@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 12:01:20 +0200 David Hildenbrand <david@redhat.com> wrote:

> ...
>
> >>
> >> If it's a performance improvement, it would be good to show that it is
> >> an actual improvement worth the churn ...
> > Sorry for the confusion. As for the OOM issue, the previous
> > commit(https://lkml.kernel.org/r/1683782550-25799-1-git-send-email-zhaoyang.huang@unisoc.com)
> > helps to decrease the fail rate from 12/20 to 2/20, which it turn to
> > be 0 when applying this patch.
> 
> Thanks! Can we make that clearer in the patch description? I'm 
> struggling a bit my self to find the right words.
> 
> Something like
> 
> "This change further decreases the chance for wrong OOMs in the presence 
> of a lot of CMA memory."
> 

Great, I added that.

> 
> In any case
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

And I'll move this patch into mm-stable.
