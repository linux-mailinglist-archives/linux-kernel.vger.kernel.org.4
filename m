Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764716E6F06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjDRWCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjDRWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:02:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBA3A5FC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C095A6399E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64CCC433EF;
        Tue, 18 Apr 2023 22:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681855322;
        bh=JNP1xB5GIvgJJmSbKQabnxhJhbq3MlZMoGbPthN+Vlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dU3s35zGaGQzcQIfZFASfRNiGP2LdPGekM1pWmXlWZWgaUS9hn+0/k1HvMtL7uR1X
         kyh2TcXFLCX/PC+aWFRFmbDBTtbsC9VkH2l5BRRhbn5dPTAsrgzmlRn9Tjc9n+EMBk
         0BDCNKFs9eKooI+KQaHxVeapVFr8SM6tVJLQrX5E=
Date:   Tue, 18 Apr 2023 15:02:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-Id: <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
In-Reply-To: <20230320180332.102837832@redhat.com>
References: <20230320180332.102837832@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 20 Mar 2023 15:03:32 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:

> This patch series addresses the following two problems:
> 
> 1. A customer provided evidence indicating that a process
>    was stalled in direct reclaim:
> 
> ...
>
>  2. With a task that busy loops on a given CPU,
>     the kworker interruption to execute vmstat_update
>     is undesired and may exceed latency thresholds
>     for certain applications.
> 

I don't think I'll be sending this upstream in the next merge window. 
Because it isn't clear that the added complexity in vmstat handling is
justified.

- Michal's request for more clarity on the end-user requirements
  seems reasonable.

- You have indicated that additional changelog material is forthcoming.

- The alternative idea of adding a syscall which tells the kernel
  "I'm about to go realtime, so please clear away all the pending crap
  which might later interrupt me" sounds pretty good.

  Partly because there are surely other places where we can use this.

  Partly because it moves all the crap-clearing into special
  crap-clearing code paths while adding less burden to the
  commonly-executed code.

  And I don't think this alternative has been fully investigated and
  discussed.

