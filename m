Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7372EA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbjFMR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjFMR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD3113E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F8A461077
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 17:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9AFC433D9;
        Tue, 13 Jun 2023 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686679131;
        bh=SN1c/tgjkGIHNQlQuVRRt3ENTwVyc5rr1jQndTSnNPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gjuTLOWKQ0f0t1t+eXxvOqKAE5a5XSnWt8lZ4MGD6TnCVey0N+LZpf1M5cZnHssGN
         mtqJRyQbqJgW6Fe6DPq8FOSMsBsbUs2U8CKPisiFoMgmD57rOMe49ITPZZjX/VoF1U
         pshQi6kO0CAppFvNb3UACJHmYCpH2k9qTZHAKqD0rB7A3tUeAFYEsf76VX3Aoo5070
         nw2qnguYZVT6C7LIyDt0KAnHJmzdmNqeCu6Vmevg49PU8+1Sv5U7F/gjI+ZW2LF6BZ
         lNXO95czJ0577EXYUbAX8a+nkHLCL/b1JUN+LgZhVm1OoXwMDFzDRYptW3Ld+en6zU
         lUbesI7QbpKag==
Date:   Tue, 13 Jun 2023 10:58:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Message-ID: <20230613105850.30172085@kernel.org>
In-Reply-To: <ZDk83vpIarQ9jWa7@8bytes.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
        <ZDk83vpIarQ9jWa7@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 13:45:34 +0200 Joerg Roedel wrote:
> Thanks for working on this, I think this is good to go. But given the
> issues we had with last attempt I'd like to have this in linux-next for
> a few weeks before sending it upstream. Therefore I will defer this
> patch and merge it early in the next cycle.

Is this patch queued up? I don't see it in linux-next and we keep
hitting this issue in production. After a few NIC reconfigurations
IOMMU starts consuming 90+% of CPU time.
