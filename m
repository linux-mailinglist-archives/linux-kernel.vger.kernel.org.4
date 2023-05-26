Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A6712CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbjEZSm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEZSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:42:23 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EC2E4E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:41:54 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f805d07040so4933191cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685126502; x=1687718502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1d8XnTVO4Vn00aOuBkVK7/kieiB45IAfX4W9kP1Vwbc=;
        b=PX2MLp4raJTgop6HrP5pOOyIsEm90+qMZYEqKbzn1PhfKtmXjmGoYOYGf6MsJL+N2q
         GGs5RiV7R72hElZZxdIq32yJIKvTWvTrblS2Lh8v032hORJ3FOZ5FyOqtzuorcNiStj7
         uqeQ1du6WPa/oKAkZJUyscfA0SWJDJh4b0SsPs6gKk8J2YFrZs5J8Zb9nmPPFmWLy83O
         bAzSZZSdQdHvg9ARXINj74bpGAiyewwc3XYp1n6nDZqhVV9IKWGH5n5QoR+aRXUmisD8
         s+F2x7xcxsbw8QcoRnfqTFvxEJG2GUvwegJiGKspa9gdgbdTIjc2LMSQCzDbsq7YaXST
         wQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126502; x=1687718502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1d8XnTVO4Vn00aOuBkVK7/kieiB45IAfX4W9kP1Vwbc=;
        b=lCM0dAE7MIo3QeUk9hEkJdAg5MpBUTt64Z8CUsvDXwFxuzaYBI7edxrUsy1Ev3N6Io
         gzGbc0NBnRXUu/hfuoVqUjAYn1wZjIAZATKdK/+X/tg5PGPDYSi/X1/uQ4rHwf69Ghn9
         JrqS6YdyzL86GhPC47jTYhJFEhF9PROufXY+F2j0UKs2HAy9unGgwYf/qwM+7o6SIRjG
         7KKZydo2DCB6FljgegdQrqhGQh6cGAMazA4IMv9RKHFvwj2vmXbVEamzeeJBubJOmxaj
         ubyK0qn+7rmLLqpbE+e2nJCQ6wFaJ58Qr5NE7a5LcyRfHwiHX9XDnvhukodFODGxThul
         jnFQ==
X-Gm-Message-State: AC+VfDy8C/0ztYOfuH8Shmx79WAPMSscMB1ye7r64o2GjO1XHYOeOsou
        QPQ8hNdmS2f3GFl4GKyXS8gZ5g==
X-Google-Smtp-Source: ACHHUZ7qozx1ADiijpzYGhWjgdMW35UxJ9aTa1HEh8bez4k0P1dLeXSgjsGq2EE9Q6pTpa3TCTiq6w==
X-Received: by 2002:a05:622a:190d:b0:3f5:3d3d:d1b5 with SMTP id w13-20020a05622a190d00b003f53d3dd1b5mr3333870qtc.27.1685126502608;
        Fri, 26 May 2023 11:41:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a191000b003ef13aa5b0bsm1458247qtc.82.2023.05.26.11.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:41:42 -0700 (PDT)
Date:   Fri, 26 May 2023 14:41:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Subject: Re: [PATCH v3] mm: zswap: shrink until can accept
Message-ID: <20230526184141.GB49039@cmpxchg.org>
References: <20230526183227.793977-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526183227.793977-1-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:32:27PM +0200, Domenico Cerasuolo wrote:
> This update addresses an issue with the zswap reclaim mechanism, which
> hinders the efficient offloading of cold pages to disk, thereby
> compromising the preservation of the LRU order and consequently
> diminishing, if not inverting, its performance benefits.
> 
> The functioning of the zswap shrink worker was found to be inadequate,
> as shown by basic benchmark test. For the test, a kernel build was
> utilized as a reference, with its memory confined to 1G via a cgroup and
> a 5G swap file provided. The results are presented below, these are
> averages of three runs without the use of zswap:
> 
> real 46m26s
> user 35m4s
> sys 7m37s
> 
> With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> system), the results changed to:
> 
> real 56m4s
> user 35m13s
> sys 8m43s
> 
> written_back_pages: 18
> reject_reclaim_fail: 0
> pool_limit_hit:1478
> 
> Besides the evident regression, one thing to notice from this data is
> the extremely low number of written_back_pages and pool_limit_hit.
> 
> The pool_limit_hit counter, which is increased in zswap_frontswap_store
> when zswap is completely full, doesn't account for a particular
> scenario: once zswap hits his limit, zswap_pool_reached_full is set to
> true; with this flag on, zswap_frontswap_store rejects pages if zswap is
> still above the acceptance threshold. Once we include the rejections due
> to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
> 1478 to a significant 21578266.
> 
> Zswap is stuck in an undesirable state where it rejects pages because
> it's above the acceptance threshold, yet fails to attempt memory
> reclaimation. This happens because the shrink work is only queued when
> zswap_frontswap_store detects that it's full and the work itself only
> reclaims one page per run.
> 
> This state results in hot pages getting written directly to disk,
> while cold ones remain memory, waiting only to be invalidated. The LRU
> order is completely broken and zswap ends up being just an overhead
> without providing any benefits.
> 
> This commit applies 2 changes: a) the shrink worker is set to reclaim
> pages until the acceptance threshold is met and b) the task is also
> enqueued when zswap is not full but still above the threshold.
> 
> Testing this suggested update showed much better numbers:
> 
> real 36m37s
> user 35m8s
> sys 9m32s
> 
> written_back_pages: 10459423
> reject_reclaim_fail: 12896
> pool_limit_hit: 75653
> 
> V2:
> - loop against == -EAGAIN rather than != -EINVAL and also break the loop
> on MAX_RECLAIM_RETRIES (thanks Yosry)
> - cond_resched() to ensure that the loop doesn't burn the cpu (thanks
> Vitaly)
> 
> V3:
> - fix wrong loop break, should continue on !ret (thanks Johannes)
> 
> Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
