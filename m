Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1CE6A8EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCCBwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjCCBuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:50:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85D4206BB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:50:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5977EB81639
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D412BC433D2;
        Fri,  3 Mar 2023 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677808204;
        bh=ygNSzvL6CMybipvv1iTEmj2Hxqh5QV3leQ3C6IQ16qE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KFFPaCK3QbMh9lbtukWaKEZyx1kp1ha+avhNuGQEPfrx2rI+l1eyjhW5bJYCF4QSi
         0TMEke89VdeDX6Ow6BtBiIZrBsAneDoqJDzaIfX4tc6rom0bGjTREGxm+qL2YWBrvO
         td+LqAWNMchOxk+bh0cDSoDmrGbckgO5DFfIQ56Y=
Date:   Thu, 2 Mar 2023 17:50:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anish Moorthy <amoorthy@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: teach mincore_hugetlb about pte markers
Message-Id: <20230302175003.7772edcfc28cf0bd67f45e72@linux-foundation.org>
In-Reply-To: <ZAEkEDcoIZRrAIwX@x1n>
References: <20230302222404.175303-1-jthoughton@google.com>
        <ZAEkEDcoIZRrAIwX@x1n>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 17:32:48 -0500 Peter Xu <peterx@redhat.com> wrote:

> On Thu, Mar 02, 2023 at 10:24:04PM +0000, James Houghton wrote:
> > By checking huge_pte_none(), we incorrectly classify PTE markers as
> > "present". Instead, check huge_pte_none_mostly(), classifying PTE
> > markers the same as if the PTE were completely blank.
> > 
> > PTE markers, unlike other kinds of swap entries, don't reference any
> > physical page and don't indicate that a physical page was mapped
> > previously. As such, treat them as non-present for the sake of
> > mincore().
> > 
> > Fixes: 5c041f5d1f23 ("mm: teach core mm about pte markers")
> > Signed-off-by: James Houghton <jthoughton@google.com>
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 

I think I'll add cc:stable to this. 
