Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08A718E04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjEaWE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjEaWE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB41134
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5174763881
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1ADC433EF;
        Wed, 31 May 2023 22:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685570690;
        bh=E5/Pkm2IA3yLb6KMRcBKL1HL9rp+KYOQDY1Wztemmok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=boFU7W24ENyLv+KnGSqNJ6KgamwUnRlVuV8d5nZvqsWBhVCkwUFJSBWLHuWbWf60k
         MlEROjGGlIC/++64aOKcziMgesowfakNWo7391xVk0NScrylPqfqVPPb8iw40jHYje
         b2yS9ZnSthYbry65TkrLZ+lJKywo4BPtXZKPNNeI=
Date:   Wed, 31 May 2023 15:04:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
Message-Id: <20230531150449.56311ca2ea6184b413517672@linux-foundation.org>
In-Reply-To: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 16:39:34 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> A folio turns into a Workingset during:
> 1) shrink_active_list() placing the folio from active to inactive list.
> 2) When a workingset transition is happening during the folio refault.
> 
> And when Workingset is set on a folio, PSI for memory can be accounted
> during a) That folio is being reclaimed and b) Refault of that folio.
> 
> There exists clients who can do the proactive reclaim using the system
> calls like madvise(), whose folios can be safely treated as inactive
> folios assuming the client knows that these folios are not needed in the
> near future thus wanted to reclaim them. For such folios psi is not
> accounted uniformly:
> a) A folio started at inactive and moved to active as part of accesses.
> Workingset is absent on the folio thus madvise(MADV_PAGEOUT) don't
> account such folios for PSI.
> 
> b) When the same folio transition from inactive->active and then to
> inactive through shrink_active_list(). Workingset is set on the folio
> thus madvise(MADV_PAGEOUT) account such folios for PSI.
> 
> c) When the same folio is part of active list directly as a result of
> folio refault and this was a workingset folio prior to eviction.
> Workingset is set on the folio thus madvise(MADV_PAGEOUT) account such
> folios for PSI.
> 
> As said about the MADV_PAGEOUT on a folio is accounted in b) and c) but
> not in a) which is inconsistent. Remove this inconsistency by always not
> considering the PSI for folios that are getting reclaimed through
> madvise(MADV_PAGEOUT) by clearing the Workingset on a folio. This
> consistency of clearing the workingset was chosen under the assumption
> that client knows these folios are not in active use thus reclaiming
> them hence not eligible as workingset folios. Probably it is the same
> reason why workingset is not set on a folio through MADV_COLD but during
> the shrink_active_list() though both the actions make the folio put onto
> the inactive list.
> 
> This patch is tested on Android, Snapdragon SoC with 8Gb RAM, 4GB swap
> mounted on zram which has 2GB of backingdev. The test case involved
> launching some memory hungry apps in an order and do the proactive
> reclaim for the app that went to background using madvise(MADV_PAGEOUT).
> We are seeing ~40% less total values of psi mem some and full when this
> patch is combined with [1].

Does this accounting inaccuracy have any perceptible runtime effects?


