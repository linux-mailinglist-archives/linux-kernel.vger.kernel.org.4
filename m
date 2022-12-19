Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A021650B69
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiLSMZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiLSMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:25:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB5DF8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:25:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay40so6294500wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xtO909pl0UcIRvFN9l1f5KN/TIemT+O1LrAgXX9vkU=;
        b=Ffa7ivEpXIQxyuhbHNnuIhTTaUiL9Qm3+HHnhXbhrFXeKPK5eFZschrDSKZ0xGVwFN
         9hLdF28WWz+WJh0rT3PXLBQuRIXx/MunX2vPlZfZRXM0C9FPfvgIl6FZfZJKzypnhJD6
         e3Cm9ezccmpKNSPjZA+ZkU9k84TS0tA835cmlQMijCSvJ/dA2q/jlo16sRnIAuB5fNs9
         z2NrorlBblpuGiomjS+cnI2/g6SMIXTwwRVKkcwEq/GDpvCpqls/FpP6e6U/9L5z34FM
         HMEfFHtrzzHoB6Uexgzcvfkfo6Ms70k8h/ei2l1m4PBwUiBjyfMXKpFAUGF1fdz9FhU0
         VYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xtO909pl0UcIRvFN9l1f5KN/TIemT+O1LrAgXX9vkU=;
        b=ucZrVls+JrB/c6SL0BNr14C+xtuAj4jdr8TkfNO016YY280mYUyhCnKkIVhCrINf5n
         Rsw8eUs1hmb4uZU+RarxhlLHwLFVAzrco6NGmNHIuCPtyiAEmHEdlIKVqPyzedCFU9Jo
         xXDg6wqUKqG6d0cAqgVac7yKW6Rs0AI4rKrCv2rQxYTVNWxLO8Sv8MKTB53x7t1Mdyi/
         LHw6P142vc3+PwhJGdS6gijaTN7OcFpPNSzcFz+Zl1t3mbiuprGv0J73YrClYdtz6hF+
         U7OVJQvT07kNXP36PdVHvJi1dSEgu3CYXnoKNOq553kSPoTT3SLP5H0pkX5HNt06fItR
         W2pQ==
X-Gm-Message-State: AFqh2krRDNXGHXBO7xSkdoYGaSjMG1Nhmq5Ex6p0A8TPUW+76MbZlOEI
        YdhtAGAUuIc1A0RTkuU4gNQ=
X-Google-Smtp-Source: AMrXdXvMz7fHiAQBvJj1E2uBu3Iwl/b1kWUnGXJKxWkItdRJIZIZ6KmVIO+inEq8eoNz5V4R8qzZmA==
X-Received: by 2002:a05:600c:3d85:b0:3d3:59a8:252d with SMTP id bi5-20020a05600c3d8500b003d359a8252dmr2390600wmb.9.1671452742017;
        Mon, 19 Dec 2022 04:25:42 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c2cd400b003c70191f267sm19325099wmc.39.2022.12.19.04.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 04:25:40 -0800 (PST)
Date:   Mon, 19 Dec 2022 12:25:40 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] mm: vmalloc: correct use of __GFP_NOWARN mask in
 __vmalloc_area_node()
Message-ID: <Y6BYRDbprdAeE0IZ@lucifer>
References: <20221216234659.493794-1-lstoakes@gmail.com>
 <Y6BUhXwswQTsfp0E@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6BUhXwswQTsfp0E@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 01:09:41PM +0100, Uladzislau Rezki wrote:
> There are three more warn_alloc()s below. Those are explicitly disabled.
> Could you please rework the patch and make it working also?

Ah yes, sorry missed those, I think then the simplest solution then would be to
simply yank the __GFP_NOWARN specifier at the top of the function and restore
the explicit flag being passed to vm_area_alloc_pages() you added in
c3d77172dfc0.

This whole thing does make me wonder if this function is due a more general
refactor.

Will spin up a v2!
