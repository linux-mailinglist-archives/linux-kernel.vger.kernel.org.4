Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2497262FE29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiKRTop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiKRTom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:44:42 -0500
Received: from forward502o.mail.yandex.net (forward502o.mail.yandex.net [37.140.190.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BEF7818F;
        Fri, 18 Nov 2022 11:44:37 -0800 (PST)
Received: from myt6-9bdf92ffd111.qloud-c.yandex.net (myt6-9bdf92ffd111.qloud-c.yandex.net [IPv6:2a02:6b8:c12:468a:0:640:9bdf:92ff])
        by forward502o.mail.yandex.net (Yandex) with ESMTP id 824F825D4753;
        Fri, 18 Nov 2022 22:44:34 +0300 (MSK)
Received: by myt6-9bdf92ffd111.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id cb4WW6nS5o-iWV82vUV;
        Fri, 18 Nov 2022 22:44:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clicknet.pro; s=mail; t=1668800673;
        bh=X2hlUUTmy+wdL5CZtSmKqk3Z0B9hgsCkGcalUOd2Vbw=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=BVh1Ji6Vp0PNRo/uwwJw2SrG5NAjQe+7Kwdcbtz/Pfp+xFvl+Vjb+ApeZ6gqfFtpV
         +MoHAd1E+mVaInB0lnj1Jdz7h1UVJ34Qy0g9Bh86PMrhZC8zpjJcmwaonX64Wl1L1+
         pWwTuxnvfVI98u9rbQIwZitCeRwR71lE33+ixxhE=
Authentication-Results: myt6-9bdf92ffd111.qloud-c.yandex.net; dkim=pass header.i=@clicknet.pro
Message-ID: <536ede34-e360-78a5-ef6f-df032fa30154@clicknet.pro>
Date:   Fri, 18 Nov 2022 22:44:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Coverity: zblock_alloc(): Memory - illegal accesses
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
References: <202211171419.FCDC8EE@keescook>
 <74337ebd-0222-2e78-9149-8fa40b0c815e@clicknet.pro>
 <202211180841.39558B5E5@keescook>
From:   Ananda Badmaev <a.badmaev@clicknet.pro>
In-Reply-To: <202211180841.39558B5E5@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_PDS_PRO_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.11.2022 19:43, Kees Cook пишет:
> Ah-ha, understood. Well, if you do want to catch it if there is ever a
> typo in the block_desc values (which are not obviously >4096 without
> sitting down and calculating them), perhaps add:
> 
>          if (WARN_ON(block_type >= ARRAY_SIZE(block_desc))
>                  return -ENOSPC;
> 
> 

Probably it would be better to add a single check on the largest 
slot_size >= PAGE_SIZE at pool creation time.

