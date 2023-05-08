Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D984E6FA28A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjEHIo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjEHIoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB14A4ED3;
        Mon,  8 May 2023 01:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 604B162099;
        Mon,  8 May 2023 08:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC5FC433EF;
        Mon,  8 May 2023 08:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683535492;
        bh=4r3I/p321L24aAx0oFkvVjKBy4Ysck/E+5s0WPzJpB4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Idi0uxdhC0IAIqdFhRDaGnjKm6BtsAeoZxde4HBaCAGj0spmTGStkmr7e8SPNw8rp
         Nu3QMcgKRSvP1m4fTcff+oBGfiROJfCLvCF27uuKlSHDOjPB0A4pKZqhWCbmunFJMb
         eTmXv+aOLEvT0SLoNxKYjChy9TaxfsZXlIpTN1SeIDxO4OKSk3xASB0H1FeBzVxKLa
         Wuk7qx5qIQ8otkjmAUrArGp0Bhz71uBjmHEbG+SPtFR5g+YEyp5fbBgTfteLOxSg+e
         JwQYSksPZCHm3jVUueeJJeprPuDHMim7rJONUbR+kSr6rK7McAE1OfM4B0POrZ/xeW
         /QUr6qcr0r/WA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org
Subject: Re: [PATCH] wireless: ath: work around false-positive stringop-overread warning
References: <20230417205447.1800912-1-arnd@kernel.org>
Date:   Mon, 08 May 2023 11:44:44 +0300
In-Reply-To: <20230417205447.1800912-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 17 Apr 2023 22:54:20 +0200")
Message-ID: <87ttwnnrer.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> In a rare arm64 randconfig build, I got multiple warnings for ath11k
> and ath12k:
>
> In function 'ath11k_peer_assoc_h_ht',
>     inlined from 'ath11k_peer_assoc_prepare' at drivers/net/wireless/ath/ath11k/mac.c:2665:2:
> drivers/net/wireless/ath/ath11k/mac.c:1709:13: error: 'ath11k_peer_assoc_h_ht_masked' reading 10 bytes from a region of size 0 [-Werror=stringop-overread]
>  1709 |         if (ath11k_peer_assoc_h_ht_masked(ht_mcs_mask))
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This happens whenever gcc-13 fails to inline one of the functions
> that take a fixed-length array argument but gets passed a pointer.
>
> Change these functions to all take a regular pointer argument
> instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

s/wireless:/wifi:/ but I can fix that.

In a awat it's a shame to lose the explicit length but I guess there's
no other way to fix this?

Also I hope you find the time to add GCC 13 to crosstool :) Related to
this, last year we had a similar warning with GCC 11 for which I added this
not-so-pretty workaround:

abf93f369419 wifi: ath11k: mac: fix reading 16 bytes from a region of size 0 warning

https://git.kernel.org/linus/abf93f369419

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
