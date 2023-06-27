Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630017403FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjF0TWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjF0TWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:22:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751C2E6C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:22:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AF7D61200
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F90C433C8;
        Tue, 27 Jun 2023 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687893722;
        bh=V2PFUe3PC1nqG6Bla8blg91P1IRyZEClVhV2gtLfjiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OdmvUc2kCOYkyZaOhjl8Yb6iNV+MHvldLV1TN4pN3SBVb5w6KpruNwn/YEaFUHukt
         YRnmjtqICXTjbftfqMtK+6ZfMHsWsIZct3rqdz7t/soSd+k5/mAKfwyNoRnaiH9eWo
         yMli74qo38xIXUmp9xpNrRX749yW4Mo3vj2Nehcw=
Date:   Tue, 27 Jun 2023 12:22:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nanyong Sun <sunnanyong@huawei.com>
Cc:     <xu.xin16@zte.com.cn>, <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/ksm: delete the redundant ksm_merging_pages
 interafce in proc
Message-Id: <20230627122201.6e25819493823dfc7cca4741@linux-foundation.org>
In-Reply-To: <20230627133542.2446285-1-sunnanyong@huawei.com>
References: <20230627133542.2446285-1-sunnanyong@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 21:35:42 +0800 Nanyong Sun <sunnanyong@huawei.com> wrote:

> Since the ksm_merging_pages information already included in
> /proc/<pid>/ksm_stat, we can delete /proc/<pid>/ksm_merging_pages to
> make the directory more clean, and can save a little bit resources.

Well, this is a non backward compatible change - any userspace
which depends on ksm_merging_pages will break.

Yes, we could remove this but it will be a lengthy process involving
emitting a "please use ksm_stat instead" message for a few
years before removal.
