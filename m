Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FBF72C60F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjFLNek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjFLNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:34:38 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993EE9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:34:35 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-56d0dbbfc61so15224337b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686576875; x=1689168875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMMaef3Y60326NhZy/qWmHpGv13Bdt3/sfuPwhyQrG8=;
        b=qo/LCq3V6W9H8ZqcrKE+1BEpRtS3SQziChm1wZYHkNZHswS6VyxdrYu4tsmptGOQZD
         pLgwNRNsabIqLCE4eZLpgT4LEtvTKlxZ/1NsmA1Ys+hdB6Hx0ZAA/Ozm2kTo3x/GY0q3
         ZEi1p6YgnBtST2Jt05FFop2qwmGmbpgZKHVpc8Kyq57jKz2lAlWKYm4uKSql/1A9jpki
         vepdBAE7Z0CbRmoLiVqqQhLcP6iVxLLI+pzo8E1bAPi5RLgzectmiHI7sG7+A6UQCSDN
         ahEDASgtklR6wXvn8GoOfOhb87/KfKR50bAny/2xocKDfOz85y8aOx/VFQ0BVg9JaMVE
         7KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686576875; x=1689168875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMMaef3Y60326NhZy/qWmHpGv13Bdt3/sfuPwhyQrG8=;
        b=dPZRFVKLKOctWoW6cVhl7x1saRj912b2+g79gQsWsVrt1y13jJtFEiLqrOJXQ5nXpU
         6oILqTdR4po+olb85I+AwERdTsr7QLqJuIkUM3fFOmUyYrGFSQTtwfidFHfU8Wyvo4WT
         M4HVuWN02fzKX/mRriuSDYIeybl8lDc6z7ODB6sKrIIhGqX53801ZqdowMiupU0vAVzs
         1kYnLjR+Mp6NlAY1sCt4Om5PiyIsO4qsMcktfOkegXWICRJqszkV+BP5sVtYude5WHcr
         xgeqa1eBoPcVFYbOUSL67dzuSzlm1l7Ke8VEpLfHLArgP/QAtOp/F7QWRiu+caVF9K9G
         Mykw==
X-Gm-Message-State: AC+VfDw2X2T86aqlGVbN461aairsmatWENX5DnRlh4O3ezDiJgR6YSs4
        SLwJcAyFG2WPBHM0hv+YSsbo0g==
X-Google-Smtp-Source: ACHHUZ66qeBuLiP1Ymc3dOrLiebqS62YEcnWkWx+eDLbUv9eVOBQDzyDmiQAfTijmp2nvlkEZn4RjA==
X-Received: by 2002:a81:83c9:0:b0:56c:fe54:4183 with SMTP id t192-20020a8183c9000000b0056cfe544183mr5383352ywf.52.1686576875054;
        Mon, 12 Jun 2023 06:34:35 -0700 (PDT)
Received: from localhost ([2601:58a:8200:2b0::e699])
        by smtp.gmail.com with ESMTPSA id o124-20020a0dfe82000000b00555df877a4csm2466149ywf.102.2023.06.12.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:34:34 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:34:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/7] mm: zswap: add pool shrinking mechanism
Message-ID: <ZIce6TZchvLZsk5_@cmpxchg.org>
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
 <20230612093815.133504-2-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093815.133504-2-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:38:09AM +0200, Domenico Cerasuolo wrote:
> Each zpool driver (zbud, z3fold and zsmalloc) implements its own shrink
> function, which is called from zpool_shrink. However, with this commit,
> a unified shrink function is added to zswap. The ultimate goal is to
> eliminate the need for zpool_shrink once all zpool implementations have
> dropped their shrink code.
> 
> To ensure the functionality of each commit, this change focuses solely
> on adding the mechanism itself. No modifications are made to
> the backends, meaning that functionally, there are no immediate changes.
> The zswap mechanism will only come into effect once the backends have
> removed their shrink code. The subsequent commits will address the
> modifications needed in the backends.
> 
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Tested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
