Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A767DE37
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjA0HHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjA0HHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:07:10 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E10C1BC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:07:09 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3621568D09; Fri, 27 Jan 2023 08:07:05 +0100 (CET)
Date:   Fri, 27 Jan 2023 08:07:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        catalin.marinas@arm.com, will@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command
 line
Message-ID: <20230127070705.GA4180@lst.de>
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com> <dca84e05-e376-c593-74fa-37c58f30767a@intel.com> <20230127063555.GA3300@lst.de> <C7DCCCB1-AABE-4D3B-80B1-AB755A68D460@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7DCCCB1-AABE-4D3B-80B1-AB755A68D460@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 10:52:43PM -0800, H. Peter Anvin wrote:
> >If people want ZONE_DMA32 to go away we need something to replace
> >it first, like a large enough CMA region in the 32-bit addressable
> >range.
> 
> Not to mention all kinds of odd masks like 30, 31, 39, 40, 46, ... bits.

Yes.  Out of those all >= 32 are falling straight into ZONE_DM32,
the lower ones we do a first try in ZONE_DMA32 and then fall back to
ZONE_DMA.  <= 29 mask OTOH are really rate in modern systems for
actual devices.  So with a CMA region for what is currently ZONE_DMA
and one for the first 1G we'd probably cover most of what's actually
needed for x86_64.  Of course on 32-bit architetures things become
a lot more complicated due to highmem.
