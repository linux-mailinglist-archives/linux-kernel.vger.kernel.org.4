Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB58665C16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjAKNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjAKNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:03:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6F03A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:03:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82E0DB81BFB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A200C433D2;
        Wed, 11 Jan 2023 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673442221;
        bh=VlfO6Qwp55YL1PrQbphBkIA56AcamC+zqqLztNevUI4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=REhrvEf3KC5Ha+kBM52fG+E1sLDzGKvmZZ31OWF0fAjrRneseABYu6Djq6kA35uaj
         +IFM3FLexUVcRRa1mu4QnoP608uiBhthLOaMqrXnzTRC2MRHijB1NLGPIXsmtKlaC7
         NwuWeBfOW8SPDlTW9CGl0h2mg/KPT7Idy2t3smu0mVdxZP0CGzPre1Kz00d8PDNR0F
         2XyU1wyqRF/v0ux0vct6kmRnrIz5zDw6I9Mj4Wu4J6dGd5+Ong0caslne49YwnQSWe
         SuqIPJqcG6QLHkVGLChMoEV0OoGCDv6cA6sycYFeeu2VhR1d7bSyMmnZzesnbc73nd
         J5HDxRxAh9HTA==
Message-ID: <f1c1894e-2899-9b7d-edd9-bbb13864424f@kernel.org>
Date:   Wed, 11 Jan 2023 21:03:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: judge whether discard_unit is section only when
 have CONFIG_BLK_DEV_ZONED
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221129122928.23730-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221129122928.23730-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/29 20:29, Yangtao Li wrote:
> The current logic, regardless of whether CONFIG_BLK_DEV_ZONED
> is enabled or not, will judge whether discard_unit is SECTION,
> when f2fs_sb_has_blkzoned.
> 
> In fact, when CONFIG_BLK_DEV_ZONED is not enabled, this judgment
> is a path that will never be accessed. At this time, -EINVAL will
> be returned in the parse_options function, accompanied by the
> message "Zoned block device support is not enabled".
> 
> Let's wrap this discard_unit judgment with CONFIG_BLK_DEV_ZONED.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
