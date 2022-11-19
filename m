Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6F6630F84
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiKSQie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiKSQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:38:31 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D1510B5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:38:26 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id l15so5005282qtv.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WSgz2nzJehsyTKRNYi+yiLi2lk7XHUxTG8Mz68ePwKQ=;
        b=4eFIquBW1bhKQKH+CUcHwN7HZI3d6/wCL5+hDv1zJxuiU0wJyXTorHUUzpCqkqTf46
         QiA750fOxovYnTS5HF3WnoMemWVO7naSohuj4pfxEwHHFJZbZUp5mHDsHhc4Nq6m0M1O
         F7vi30ZPxVxC6FoDcDLLHnVE2rL1hTMSjnvACHnbFHRCPOnx2UfZuptm8QXFEuMteGwu
         yfEveAvHri24J6xLUnJB0/FO8K5wn7iAEgeCBeBLIs3EUMqv5k/cSjwKLlOPAjIfBrAZ
         1+BqWy2AD250MWSAhu0RIPzUIDIsusYfqv2icQjYrdpexMQ7HmxaLBshr2Pt501TdeSg
         QLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSgz2nzJehsyTKRNYi+yiLi2lk7XHUxTG8Mz68ePwKQ=;
        b=KtQax1QLaaO1Rzw2n2BuWN+SjZGnkZUt2HKCl/4+1UkEZOWTXeS1HKbyXaGULf2oMm
         zGvZiMCy5Xn6CO3UtS4ZywggCAhSGkJxFeljIHcfSUG18w7adX7O9EPgERkzpShQZEaN
         +NnOuDiBt0fwfyc9au7pKz0Uk0xp3HZu7/8NmUvlJbkh2F+PiqYxRvWnhCvjzjeNS8Tq
         rqpieePFNulHCW2cLOZ8sGdPaJR2hs/dnIolD9QEflgCsDH+g2Jwara7u5H3a66v6mlN
         t4hDO7rcOaB9oIitk6JKCJzyInbVRyYTCYWQp/91F2pUU39nh3SWKGFfolSdQmKKQYfl
         QZYg==
X-Gm-Message-State: ANoB5pkrCRen4tmcWuTBlhROBnFfVbDTHhFvCdHNfJwvzd3EPjjGqMWh
        sfOctcoMWRDea7tQtQSxmDjR/g==
X-Google-Smtp-Source: AA0mqf6Y1pa1Wc0L1gf3W/Xl8P04bwsa9hyhvWfnERt68d2RkSmB2Gck70/uxCsfJD7tqzxkxAOiLQ==
X-Received: by 2002:ac8:5992:0:b0:3a6:7a7:b39d with SMTP id e18-20020ac85992000000b003a607a7b39dmr10866276qte.193.1668875905566;
        Sat, 19 Nov 2022 08:38:25 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id f5-20020a05620a280500b006ce76811a07sm4877677qkp.75.2022.11.19.08.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 08:38:25 -0800 (PST)
Date:   Sat, 19 Nov 2022 11:38:49 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3kGmZnkps8oZpPq@cmpxchg.org>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:15:34PM -0800, Nhat Pham wrote:
> This helps determines the coldest zspages as candidates for writeback.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

This looks good to me. The ifdefs are higher than usual, but in this
case they actually really nicely annotate exactly which hunks need to
move to zswap (as CONFIG_ZPOOL == CONFIG_ZSWAP) when we unify the LRU!
zbud and z3fold don't have those helpful annotations (since they're
zswap-only to begin with), which will make their conversion a bit more
laborious. But zsmalloc can be a (rough) guiding template for them.

Thanks
