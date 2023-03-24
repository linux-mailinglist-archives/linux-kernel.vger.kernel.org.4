Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02D66C82E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCXRIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCXRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:08:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5391C1A973
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03C88B825B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3361AC433D2;
        Fri, 24 Mar 2023 17:08:35 +0000 (UTC)
Date:   Fri, 24 Mar 2023 17:08:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZB3ZEBRKlCI9WIgK@arm.com>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com>
 <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com>
 <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
 <ZBSr/kIIuxmC/INY@arm.com>
 <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
 <ZByLga6FS5o8Syug@arm.com>
 <ZB2u0QAEU1P7qIZc@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB2u0QAEU1P7qIZc@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:08:17PM +0800, Baoquan He wrote:
> On 03/23/23 at 05:25pm, Catalin Marinas wrote:
> > On Mon, Mar 20, 2023 at 09:12:08PM +0800, Baoquan He wrote:
> > > crashkernel=size
> > > 1)first attempt:  low memory under arm64_dma_phys_limit
> > > 2)fallback:       finding memory above 4G
> > 
> > (2) should be 'finding memory above arm64_dma_phys_limit' to keep the
> > current behaviour for RPi4.
> 
> Then for RPi4, with case 2), it will find memory above
> arm64_dma_phys_limit, namely 1G. Then it will get two memory regions,
> one could be in [1G, 4G], another is below 4G. I am fine with this, as
> long as it won't cause confusion that people may think two low memory
> regions you mentioned earlier. Please help confirm if I understand your
> suggestioin correctly. I will start making patch with this clarified.

Yes, you understood correctly. While it may still be slightly confusing,
if the user is not specific about high and low on the cmdline, we just
allow the kernel to find the best places. I assume distros will just use
,high and get a consistent behaviour on all platforms.

-- 
Catalin
