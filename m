Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B61683852
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjAaVHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjAaVHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:07:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F557C154;
        Tue, 31 Jan 2023 13:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B459B81ED8;
        Tue, 31 Jan 2023 21:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D89DC433D2;
        Tue, 31 Jan 2023 21:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675199234;
        bh=4H4iBjRwVxioiqKFCxXizJYSV6KoeP6hWEgfnJdkrEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oy9jqjN3LqiTDGhC2GGlKK4sF1VMrdmttEVIY6Lx0hops8uEGrRqAZGqXAn4rP+vy
         pHPSBcpJC7x4yU5vNGkGICeLVcihx07bHo5W+mmmIPt6AIlQOb7FScmO9rxUGcaiRK
         ozrQLvmGaUnhG2Cp5cPM/HRlhqsCgWzd4cWGXEng=
Date:   Tue, 31 Jan 2023 13:07:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/mmap: Fix vma_merge() offset when expanding the next
 vma
Message-Id: <20230131130713.5d6a5bc9eb0ec957c5d1ba26@linux-foundation.org>
In-Reply-To: <72dfedd2-a26a-17f4-87c2-3d71ab3f55b4@redhat.com>
References: <20230130195713.2881766-1-Liam.Howlett@oracle.com>
        <97ea66a4-54a0-68a3-c42b-f3c36c69768e@redhat.com>
        <20230131142452.sfrmubta4ojejct2@revolver>
        <72dfedd2-a26a-17f4-87c2-3d71ab3f55b4@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 15:29:59 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 31.01.23 15:24, Liam R. Howlett wrote:
> > * David Hildenbrand <david@redhat.com> [230131 03:35]:
> >> On 30.01.23 20:57, Liam R. Howlett wrote:
> >>> The vm_pgoff was being set incorrectly when expanding the next VMA to a
> >>> lower address.  Fix the issue by using the mid->vm_pgoff value for this
> >>> merge case (aka case 8).  Note that this does not change case 3's
> >>> vm_pgoff as next and mid are the same VMA.
> >>>
> >>> Reported-by: Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
> >>> Link: https://lore.kernel.org/linux-mm/IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com/
> >>> Cc: Matthew Wilcox <willy@infradead.org>
> >>> Cc: David Hildenbrand <david@redhat.com>
> >>> Cc: Hugh Dickins <hughd@google.com>
> >>
> >> Fixes: ?
> > 
> > Fixes: (soon to be invalid git id :) ("mm/mmap: remove __vma_adjust()")
> 
> Ah, right, upstream was not affected ... :)
> 
> ... so this should be squashed into that commit instead as long as it 
> doesn't have a stable ID.

Yup, I queued this as mm-mmap-remove-__vma_adjust-fix.patch so it's
to-be-squished.

Generally, please let's tell people when a patch fixes something which
is staged in mm-unstable - to save a few brain cycles and to hopefully
improve review.  A Fixes: with no SHA works, or simply "this fixes X".

