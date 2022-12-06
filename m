Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15AC644547
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiLFOGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiLFOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:06:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9124E2CC88
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2832861773
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A433BC433D6;
        Tue,  6 Dec 2022 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670335570;
        bh=6zLPU/OP1JWlfpeQndEkK8OuCR2c+jVhP4zLqlVSafw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CqoPJECp4snefzmLN8YHf4xDiaVTGO/ocKknsuyfYBHcFXuv57J7QJJOp56+4RCYo
         SpABtmiT+8iB596flQZ8vkNI4HWfGsYxIxLttX1Q6YHkqzVCaqSJ80ge3idl9enchL
         DaeyHWh263fs7Bd3brizd/CYY+JQu48SEbi7YzLW56CLJD6TCkITAwB1cucgZkMLlb
         T0md7P/PediemqfQt6CBlJYC2aEz9kVkxCEu5j2YSkybm3tpzUXRESwMDhkN8uw5eT
         v3IaFlbA6DjiSA67YyibRFiaKsLT5W/Qu5S9HVEXVVk5y3J+eUW1U4gkguITQTR2vV
         7AOM+SgTjEkvw==
Message-ID: <50922c87-3415-7986-c8ce-67d16754b442@kernel.org>
Date:   Tue, 6 Dec 2022 22:06:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] erofs: enable large folios for iomap mode
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20221130060455.44532-1-jefflexu@linux.alibaba.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221130060455.44532-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/30 14:04, Jingbo Xu wrote:
> Enable large folios for iomap mode.  Then the readahead routine will
> pass down large folios containing multiple pages.
> 
> Let's enable this for non-compressed format for now, until the
> compression part supports large folios later.
> 
> When large folios supported, the iomap routine will allocate iomap_page
> for each large folio and thus we need iomap_release_folio() and
> iomap_invalidate_folio() to free iomap_page when these folios get
> recalimed or invalidated.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
