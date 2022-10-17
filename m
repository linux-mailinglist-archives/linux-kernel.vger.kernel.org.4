Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EFF60172D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJQTQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJQTQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:16:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE16F26D;
        Mon, 17 Oct 2022 12:16:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gf8so11823372pjb.5;
        Mon, 17 Oct 2022 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2usuImTOwSTSPWCl2rjsAjZSmk5BJVuUNFuBhSjLvf4=;
        b=d3+MViL99jObTA7U0IFUbTLl5pcPrn5z1SzIt/E31b/0hek5m9JUuTrTQQ3mMoujmH
         P+8I4iXHS1Zc/mTg30fk27WxiQ4g5oq8/Eofz5mWISsagGdP0n4i0oKttVFJ3Z4wpo3T
         nC+7IgCK9SBRjjcNRfawC01cKR9HqZhZriW7IihHYJnQk+FUuBwYhj7lqGtx7Xs37kQm
         2auyPTCBU0b3R8Dl4xKt5W8KsRJn5ONayurWEkieQcH24i9x2ANFjRJmofKNfRpZoOs6
         5eMo/92Ha1+M6U0LfSe5qz/4FmmAYGOTDUdBYZoSI95Y6yHwlkAI26hvIF2ARHnc9//P
         oqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2usuImTOwSTSPWCl2rjsAjZSmk5BJVuUNFuBhSjLvf4=;
        b=kaEayabqf9RXxeP+nMzzm6aYPFKlnTswHB0/UH3WIko99Nepe++GJJMlBn6uvYq66Q
         rt41Hab1dIzRAGkrL9bm64FHitsHRl+nhHKDOu+HukceOXSiMEoFgVeMhJ8AzkK+rypz
         IU0BduZNsEaXSQpQ90DrInNUoYhnOP70buYEW11mTzhQnOtUHQTvd21cTats1n2I4ksa
         D5NwSiWZzdVtxQNL/LCrGf86JrG8w0oJqxzkp+X52NmfXfTNWKM7JVz+3KfgvaUBS31I
         5v/aSiVQ8jdpdc9SXaDidN4SCoAoH2vjkCfSzCR8Pe4tYgNx/kWqgfe1gvAP93Nd5eBz
         Ob6A==
X-Gm-Message-State: ACrzQf01ps13KC90bkQyM1PI3tjW6yBp7BYddR73/NkywexV8BULnWvj
        uqss6L7fq7oyxAa5w/DzvDI=
X-Google-Smtp-Source: AMsMyM4prjS4UUXRlWFeaiLWTyvz3CTf2QKfQIbktqQpvR2V7vnqI+JPh3kMxgEL0DtcLbe5xjsMWA==
X-Received: by 2002:a17:902:d4c6:b0:180:bdd5:1275 with SMTP id o6-20020a170902d4c600b00180bdd51275mr13764261plg.121.1666034192742;
        Mon, 17 Oct 2022 12:16:32 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y69-20020a62ce48000000b0054124008c14sm7470240pfg.154.2022.10.17.12.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:16:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 09:16:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] blk-iocost: Remove redundant initialization of
 struct ioc_gq
Message-ID: <Y02qD1dWzU5ZSDEj@slm.duckdns.org>
References: <20221017020011.25016-1-shikemeng@huawei.com>
 <20221017020011.25016-8-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017020011.25016-8-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:00:10AM +0800, Kemeng Shi wrote:
> Some member of struct ioc_gq will not be accessed before it's
> first activation and will be initialized again in it's first
> activation after ioc_pd_init. To be more specific:
> 1)Member iocg->vtime and iocg->done_vtime will set to target in
> activation which only expects vtime is equal to done_vtime in
> first activation.
> 2)Member iocg->active_period will be set with ioc->cur_period
> again in first activation.
> 
> Remove the redundant initialization to improve ioc_pd_init a
> littile bit.
> 
> The parameter now of weight_updated will not be used if iocg is
> not active, so pass NULL to weight_update here is safe and we
> can remove call to ioc_now.

This isn't a meaningful optimization and makes the code fragile for no
practical gain. Let's not do this.

Thanks.

-- 
tejun
