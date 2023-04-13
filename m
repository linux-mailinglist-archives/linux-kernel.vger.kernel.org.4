Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1156E1008
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDMOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDMOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577CE1BEA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD30B609FA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1B0C433D2;
        Thu, 13 Apr 2023 14:30:36 +0000 (UTC)
Date:   Thu, 13 Apr 2023 15:30:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDgSCfLMtL9heS8J@arm.com>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
 <ZDabRr/yyakrrDDO@arm.com>
 <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 03:45:50PM +0800, Baoquan He wrote:
> I am OK with this version, or the version with min(SZ_4G,
> arm64_dma_phys_limit), or v4. Please help point out if I got your idea
> correctly. Thanks a lot.

I think we should stick to this patch. The disabling of the ZONE_DMA(32)
is fairly specialised and you are right that we should not introduce an
artificial 4GB crashkernel boundary on such systems. The slight
confusion may be that ,high triggers a search above 4GB where there's
not such boundary but this would match the documentation anyway.

-- 
Catalin
