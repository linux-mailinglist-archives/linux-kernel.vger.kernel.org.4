Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D44B6365DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiKWQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbiKWQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:30:47 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BA75A6EC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:30:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 130so17193007pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iViwIfECIqhBr9fvxYi0Xo/aU6bf+FR/xO4cSLXF8Bc=;
        b=RzbR+elNzGu5bIsu1/MfFDtI4kni7yJZZoVH9tIE8j3ZVC5EgnWMjLNVyoQMfZffgX
         dtD9hxMmaJtL0djAJ7GK6P4fW03HJqtSvHduWF9ysAraPNn4VHJnBZHbzNYy/AWo9maN
         OGSbkn/15tuCWLB/z3sklKUZ0k1mOLbtrwXpOM5zICSy2sJZGwwPQIuixuNsHrBzr6XS
         GzZMH8HH7kV9ZgkaZMHIQq2KA8bdC7HEbzD+x4kwK9MSaF3WIrV1LJ0PbPMKf0llTPxI
         J1QUWMHYodUqx/N1XONJdCq4fhC2DbIcix5M5twc2leTTzMwGQWGjKjEHyh+NpHmikFj
         ejlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iViwIfECIqhBr9fvxYi0Xo/aU6bf+FR/xO4cSLXF8Bc=;
        b=3Jr/LlOUnUEzHhZWJMZ2UudkYwtV7qRhyMLhUErcPmWKztadf4EiGBdaJerLyg5sUY
         wHbagrayYdDKHoIpEapBEWqxf7xnVjP6RzR1fUubZxzJyr//Jk4pqO9ARMSD+IciTZbq
         lM3XdFLWQ7Gey0JiiU5GS0fjHW3OaPIlZo1VS9CzCAqTlYu9tyWeqYcmJRS07exnSqF0
         ggOkUkTR2YEwoMOpRsLMDXWSQ5uDiN9jRyetXVIg8YfbTjw0mt1S2c3mzPEhdUd7hwAv
         JoskZrF5CtWHYeBCry+UBGAeRHD4HQLKgFIDVIrNjmQj1WrqZVER5TMPTbAAZ200ADIC
         T/IQ==
X-Gm-Message-State: ANoB5pnKCFdEqeIInJo3XgyAIARvCmsfArfaLAia7qzEwQTl/9FGwzci
        Aw/+mWIYA/ypjDsku7ACWW4=
X-Google-Smtp-Source: AA0mqf56HiyaKNWtbVUYLIP4BozP4wfIPlE8iDFyQN+KrIYyD50b3UMwczSOTW+Do4ZUyhJPcoRoFw==
X-Received: by 2002:a63:220c:0:b0:46a:e819:216c with SMTP id i12-20020a63220c000000b0046ae819216cmr14804255pgi.155.1669221045555;
        Wed, 23 Nov 2022 08:30:45 -0800 (PST)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id o31-20020a635d5f000000b004769f0fd385sm10979505pgm.52.2022.11.23.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 08:30:45 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     senozhatsky@chromium.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, akpm@linux-foundation.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for zsmalloc
Date:   Wed, 23 Nov 2022 08:30:44 -0800
Message-Id: <20221123163044.2029016-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y3xuKXmNjs87q3AW@google.com>
References: <Y3xuKXmNjs87q3AW@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments, Sergey!

> A nit: we usually call get_first_page() in such cases.

I'll use get_first_page() here in v7.

> We probably better to cond_resched() somewhere here. Or in zs_zpool_shrink()
> loop.

I'll put it right after releasing the pool's lock in the retry loop:

		/* Lock out object allocations and object compaction */
		remove_zspage(class, zspage, fullness);

		spin_unlock(&pool->lock);
		cond_resched();

		/* Lock backing pages into place */
		lock_zspage(zspage);

This will also appear in v7. In the meantime, please feel free to discuss all
the patches - I'll try to batch the changes to minimize the churning.
