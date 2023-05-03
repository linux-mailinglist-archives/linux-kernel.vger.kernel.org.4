Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ACA6F5CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjECRHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjECRHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:07:38 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742B310F1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:07:03 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51f7638a56fso4874954a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683133613; x=1685725613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDoI23BY5xrud/SA1nFxDTQ7jEhWWSx2h+6na99FhRk=;
        b=adfD6lZbeMzlxiHHteeYiJRSnsfUj++6CQgcJDVTWq4FBex4VY3jYCmIZdBElKeeWv
         gvgvS6m7jdv/c4Usm9E6TOL3GDCMVzfkry7Eo50UZiPdXAZ/sNAfwFQgN7znxwtlvFDL
         e3ybYuak3yZ0V4PBhJa9izBB0RX1b+HwkIGop3QwRfyeAoT1ZABJN+ezMmf3K55GGD0h
         cWYjrqD6JSH3NH7yoRlfuTEPlyNc0pi2szAJLzTl/NsX9eqJe0cZw5dBef4wt67PFWfU
         jp8wDrNkh9Zs26GpaBgBpUuRCFyiGJeDVmI06LAhu7oIjq3NkfbMccsJHs9s1DJPljpM
         KiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683133613; x=1685725613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDoI23BY5xrud/SA1nFxDTQ7jEhWWSx2h+6na99FhRk=;
        b=d3nGJ3WvTwMtVe5dvVp+tG4vg18r4PYvYf6Ia2P9cuNpLGcTZ74ce1h1JroKMaItIM
         SXtEIViZu72dis25ntBMeqrQ3gYhIzVA3l5feBBUUE8cxLyUpNVckD273WleshNtkLmR
         IHVjWkz+9NCfq8dXKakylRNUCKzTf4RO7oKsDVusOe/nGCTGuzNF491YTgW/yD7pD2s9
         mjd0ch2B4xzK7hbCX6fFb1wsXASDDp2uJsEdGDaWU1xObfPFxyWGinhHaIwmpLeUlMG8
         QewCqNQZI9/CdU4WP8QzV0LZDvgdy+Ke6FZviRzy8nx4F+pHx+bcUl2Sa/uoKLHpylQO
         XIQw==
X-Gm-Message-State: AC+VfDwrSP3X8Y8sl3WjAWBUchEI+FZs5kJNFZ2ZdRITgWDpB2FB76k5
        l+579FuaI8X7UyA+sUPfM+qmkw+YC/Ipzg==
X-Google-Smtp-Source: ACHHUZ5eLvo9p9gkPoiGzNaTncBZwyV1ILFr1Jfusyuq5i5KqidoIiAoy2ayVD9+qMvlof/GwYtfvRllNBeGBg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:2b09:0:b0:52c:63a3:9f23 with SMTP id
 r9-20020a632b09000000b0052c63a39f23mr606175pgr.0.1683133613387; Wed, 03 May
 2023 10:06:53 -0700 (PDT)
Date:   Wed, 3 May 2023 17:06:51 +0000
In-Reply-To: <20230502160839.361544-2-roman.gushchin@linux.dev>
Mime-Version: 1.0
References: <20230502160839.361544-1-roman.gushchin@linux.dev> <20230502160839.361544-2-roman.gushchin@linux.dev>
Message-ID: <20230503170651.cw5omegmm3piumxf@google.com>
Subject: Re: [PATCH v2 2/2] mm: memcg: use READ_ONCE()/WRITE_ONCE() to access stock->cached
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 09:08:39AM -0700, Roman Gushchin wrote:
> A memcg pointer in the percpu stock can be accessed by drain_all_stock()
> from another cpu in a lockless way.
> In theory it might lead to an issue, similar to the one which has been
> discovered with stock->cached_objcg, where the pointer was zeroed
> between the check for being NULL and dereferencing.
> In this case the issue is unlikely a real problem, but to make it
> bulletproof and similar to stock->cached_objcg, let's annotate all
> accesses to stock->cached with READ_ONCE()/WTRITE_ONCE().
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
