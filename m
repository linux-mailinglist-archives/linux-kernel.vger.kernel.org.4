Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669BF72EFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjFMXPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFMXPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:15:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1F199A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:15:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b1b51ec3e9so72685ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686698129; x=1689290129;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uyQg9FJf1ujfXr9f268eDNpOT0Va/5nApJsu9c/ceI=;
        b=ZU1TKS+Chn34vLFJwibDHRoEMvmMiSzpf0ZDVkri5ROYoqs8V2zaY2gNqlFnh3FM9W
         DAfgIDaZfN+2aLQtYCYtmoYPiN7JOh7oTfXWyO/zsl4jhbkkwuJgb7gGO9atdO9mcjGz
         xeycv9Kjlo2A2wW73U+OW03nshU6dNBbPmU1NS9CvyIgiPMHPEkbB3U9BtZlVx5oqvMj
         6fLUMYeML4SdpsgO8ChyciHmoZnlyyxqL8fsGl8FExrKWpb+z83m0JOw3AxJdvkM//Yd
         UgEAXqhcEFtsBq5fHl5j1MGD/WK2Vg/xSiB3L6ZdStIV9vrh9oia48S+bPbcnTMZg0cp
         LA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686698129; x=1689290129;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uyQg9FJf1ujfXr9f268eDNpOT0Va/5nApJsu9c/ceI=;
        b=DrJ7J13vbst/Sv1ImcavJwHfKsLGi/3HS23arD1lEFY6hoGK5eZA7Vt7/YndCv6T6U
         ecXuOtbHwog14l7v5pN4JQp0qpUjk2Jvvadxj6l8U+w/6muAM4V6AnFc6mif4KdHfF3y
         p51praN8psEdI422iuPfyLN9kCezC9B4+I5km/MPxJdKHWIu7gxgKEUar+xywh6maawE
         hUkBg+d02/q6D0dd0ZELw9NlHV2JD+59VaTP3dZBD4dlrQAmzsvkzpKwNohg/6xCW8fd
         b/K9416AaJkKBOQqkpP78Vqu2/Qfp0GCiGVgXWoNWMA2cBSMHWiX1hsKSiMDZRWCj+aQ
         UmHA==
X-Gm-Message-State: AC+VfDz4tp9u6QyHtWHwCIAkJCdkPuaF3wofjzCQNsV0sshfgyfhcY1t
        bExLfqibYqh1IqakdBaEzBco7w==
X-Google-Smtp-Source: ACHHUZ48GxbxKpQWOMS+G+8jVGNcR3YlGU7DNqyZtqK/fyTpBYFnk38p2ckYqoGkswYn/FM3bj+NDA==
X-Received: by 2002:a17:902:cf0b:b0:1b3:c97a:1e90 with SMTP id i11-20020a170902cf0b00b001b3c97a1e90mr98471plg.4.1686698129085;
        Tue, 13 Jun 2023 16:15:29 -0700 (PDT)
Received: from [2620:0:1008:15:18be:6c84:11a2:b54] ([2620:0:1008:15:18be:6c84:11a2:b54])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b002599ef80ab9sm11613374pjb.3.2023.06.13.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:15:28 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:15:27 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common: use SLAB_NO_MERGE instead of negative
 refcount
In-Reply-To: <20230613102820.19153-2-vbabka@suse.cz>
Message-ID: <11b6e080-8820-87bb-2686-1c78debad4c5@google.com>
References: <20230613102820.19153-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023, Vlastimil Babka wrote:

> When CONFIG_MEMCG_KMEM is enabled, we disable cache merging for
> KMALLOC_NORMAL so they don't end up merged with a cache that uses ad-hoc
> __GFP_ACCOUNT. This was implemented by setting refcount to -1, but now
> we have a proper SLAB_NO_MERGE flag, so use that instead.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>
