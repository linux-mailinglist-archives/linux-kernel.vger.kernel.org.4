Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E29767491C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjATCAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjATCAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:00:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD53A501D;
        Thu, 19 Jan 2023 18:00:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso7713357pjg.2;
        Thu, 19 Jan 2023 18:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRJ0AvCA7jxvP9hH13X6SrrE1Ee5xHATb9NhsOelXA0=;
        b=JQEe5EU3/1qcH6Js22EDxwOVz1RtS5j7JqHKPKAJeexyaq01sniHLYFMG4jk6liK5l
         RJpn0M2eulQd35Kj00mE/xRONgVS38m2Odq+gxn5yEgOkkCe3vws4QPktouJHCcYRznS
         Qv66S7W0AKtOQXyE8xVaaD4lU8HO7FrUAoSNJBJscuWTotUBUk1um9+QHFBu8kWxOmyl
         PEPVpSf6tTBw/sbPyN4jZrgpKGDWgRkkGp87cBQBy7OL43NwP2KiJFrLl5FAqne0UQfX
         hGBHSLtm0T0R098KomqwM8uYzcQmYCN+nzlh+ylGaiLtRqrnKHByxDTc+P7syR/7zrzk
         /xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRJ0AvCA7jxvP9hH13X6SrrE1Ee5xHATb9NhsOelXA0=;
        b=uslhlxTCEADp8DYdsHOGvpBL2vAWy98jgkqQ36Z/WSNFqYdzON9cKTtaJ69AXXav9w
         koGhueU5diEpMn/h0ZZgdzxNHhN3gcS0zOtHoRg7ydU9UORE+DKqYcOHIGsgiQ30xMiS
         S42V4dHM75rkQO7biRNYI7qcHCVodfe1m8ZIqewEXcGfvEZzDCiVXDQUz+1/bghuQxQV
         8iV9CCAn7cv/GbJOpukIe8rP52iDrPzTR2Roi3wlxmcJwxniIrlS6lG9qKXGLHQ5HMaQ
         h/DA7ELnokbIKkNpUZF+Pjaw0ubIIsTp8fZ8L8DNSd2QsOyxMbPA91QzypSTtSWIA60K
         RbHQ==
X-Gm-Message-State: AFqh2koq7zVpfEzOpkm2R56wWkoe0hm9Y7Gn497oPT8JAw/pOwCwAkau
        0/wdWV2ZQ7if1Z4xniiFNh8=
X-Google-Smtp-Source: AMrXdXu9wBPZ3qJ8Tao1NsJmLu+7hnqmRA5vfwmEUVW6eUH0blm+Uow5VEgXuxCCAqgoF1ub+F7r/A==
X-Received: by 2002:a17:902:8a98:b0:194:9c0d:9732 with SMTP id p24-20020a1709028a9800b001949c0d9732mr13437141plo.46.1674180014619;
        Thu, 19 Jan 2023 18:00:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902680400b0019488a36e2esm9669108plk.266.2023.01.19.18.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 18:00:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 Jan 2023 16:00:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Lingfeng <lilingfeng3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, akpm@linux-foundation.org, jack@suse.cz,
        bingjingc@synology.com, ebiggers@google.com,
        james.smart@broadcom.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH-next v3] lib: parser: optimize match_NUMER apis to use
 local array
Message-ID: <Y8n1rOLdMGDfOgpe@slm.duckdns.org>
References: <20230120021304.5773-1-lilingfeng3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120021304.5773-1-lilingfeng3@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:13:04AM +0800, Li Lingfeng wrote:
> Memory will be allocated to store substring_t in match_strdup(), which means
> the caller of match_strdup() may need to be scheduled out to wait for reclaiming
> memory.
> 
> Using local array to store substring_t to remove the restriction.
> 
> Link: https://lore.kernel.org/all/20221104023938.2346986-5-yukuai1@huaweicloud.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

 Acked-by: Tejun Heo <tj@kernel.org>

This fixes a sleep-while-atomic splat in blk-iocost, so it'd be a good idea to add:

 Fixes: 2c0647988433 ("blk-iocost: don't release 'ioc->lock' while updating params").

The mm tree likely is the best fit but given the splat the block tree can
work too. Andrew, Jens, what do you think?

Thanks.

-- 
tejun
