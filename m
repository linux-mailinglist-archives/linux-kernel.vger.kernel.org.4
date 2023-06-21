Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E04738E32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjFUSIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjFUSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EB1995;
        Wed, 21 Jun 2023 11:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F13926163E;
        Wed, 21 Jun 2023 18:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2E6C433C8;
        Wed, 21 Jun 2023 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687370905;
        bh=Ilmbq3lRTsDXxIeuCsvSBkem45vmJYvfQqpkYO6UnhA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LLa4z57eFw6O8Z8Tbs4K+hqhYfPCTMrCkeeifGikvfq7fJ0nLbWrwgPn/zLzC+Owb
         bg8J+7X+KbQzuSquLX1BrG5ebFlbdjvTwHfp4vwssLSyhvhMmFOkzsL7JE+8S6faMa
         Gd+j0ZIyD/V/9XLhUnqhO7E/LHcaizXV1OEQHlmbZdj6cY3G2wIFm7v51HPm+m0tEI
         RhAAm2cnUFk8z1rGvjfxTuUqmnfm3LUFzCuMI1GfLiHZB9yHjdyqTTxaph65j29N49
         fc4Y45OkmSmW+X42N8sp3fbne/Nxtum9uoqP92R5G26MpTQnEGyeQrDV09Xx+WkYgs
         FTWy0U3bFGeDQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: improve structure padding
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230616090439.2484857-1-arnd@kernel.org>
References: <20230616090439.2484857-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168737090122.871827.14684779188680131550.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 18:08:22 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

> Including an aligned structure inside of a packed one is ambiguous
> and can lead to misaligned data, as pointed out by this clang warning:
> 
> drivers/net/wireless/ath/ath10k/htt.h:715:34: error: field prefix within 'struct htt_rx_indication' is less aligned than 'struct htt_rx_indication_prefix' and is usually due to 'struct htt_rx_indication' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
>         struct htt_rx_indication_prefix prefix;
>                                         ^
> drivers/net/wireless/ath/ath10k/htt.h:736:34: error: field prefix within 'struct htt_rx_indication_hl' is less aligned than 'struct htt_rx_indication_prefix' and is usually due to 'struct htt_rx_indication_hl' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
>         struct htt_rx_indication_prefix prefix;
>                                         ^
> drivers/net/wireless/ath/ath10k/htt.h:1564:2: error: field  within 'struct htt_tx_fetch_ind' is less aligned than 'union htt_tx_fetch_ind::(anonymous at drivers/net/wireless/ath/ath10k/htt.h:1564:2)' and is usually due to 'struct htt_tx_fetch_ind' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
>         union {
>         ^
> drivers/net/wireless/ath/ath10k/htt.h:1702:2: error: field  within 'struct htt_resp' is less aligned than 'union htt_resp::(anonymous at drivers/net/wireless/ath/ath10k/htt.h:1702:2)' and is usually due to 'struct htt_resp' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
> 
> These structures appear to actually need the packing since they
> are embedded at misaligned offsets. Add even more such annotations
> here to enforce bytewise access throughout the driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

12ec37be3faf wifi: ath10k: improve structure padding

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230616090439.2484857-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

