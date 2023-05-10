Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461036FE3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjEJSKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjEJSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:10:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F4E5B89
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:10:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24e14a24c9dso5474032a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683742199; x=1686334199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tiygZOTM/QauPyCMixB8V7aM36/db24ouJqobVB/VFw=;
        b=YxgWqyd+r+99dFYRRgD00VWEy1qOcxTAuAHqi3IHHkiXCGqMTNVXNDe3PLHp5+B0xY
         /AbjGykFWXc4vvD72bmluzjmewD2tJyMcp6bP7Pwxrbi+Ql4rE/pTyHebWfu+hjXDrjj
         eNTV5uGAgwvC/P/nMVz1q1n4T8jWN2QLdSaMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683742199; x=1686334199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiygZOTM/QauPyCMixB8V7aM36/db24ouJqobVB/VFw=;
        b=kznFMmzrtUFP+DwWGws7+H5aDSnIfI0JdT715SgrbQzqme7jKHrjoxfAGYIuezct2B
         b0Gsw4OHi/aWePf/73Y8UKBIQMK+qOYvMpt/KTlNxh+PGJMFP4IXsbXQd4AGREdEVgur
         kHFkXcWq/9SqODeYq7IV5NKOdUg/zQfpPVQagXcMpXdacXTA+UOZtBDy3SX+HdzQKfbA
         hnqlbdath+c35OASdiLUU/Une1dNW79FCYnLdl6qLVHHvTPMqU1abomgbJZJyhmvhZOV
         xYzpxHmk2Y7bp3AlkbW6HK/Xj2OOK7DTR2TDPiRYhch1TE3qjUwNhQJTTnEkz3GfEntD
         WKsQ==
X-Gm-Message-State: AC+VfDxgFYgOrS4ju1tiJPoeGsMoi1MScS3IUIU94KAmwCUcUMeJCeKT
        +774JfFYiP//oBI0Flru+p3B3g==
X-Google-Smtp-Source: ACHHUZ6+BjWagvevIinrLLujuzL7p6CVC5DXvppVsd1qgMDZjorehB2nrce6URDfl8DHzwf3JbZUtg==
X-Received: by 2002:a17:90b:1296:b0:246:af1f:62ef with SMTP id fw22-20020a17090b129600b00246af1f62efmr17995931pjb.5.1683742198966;
        Wed, 10 May 2023 11:09:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:17a2:4d38:332d:67a0])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090ad24300b00246be20e216sm13725577pjw.34.2023.05.10.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:09:58 -0700 (PDT)
Date:   Wed, 10 May 2023 11:09:55 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/13] wifi: mwifiex: Use default @max_active for
 workqueues
Message-ID: <ZFvd8zcPq4ijSszM@google.com>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509015032.3768622-3-tj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 03:50:21PM -1000, Tejun Heo wrote:
> These workqueues only host a single work item and thus doen't need explicit
> concurrency limit. Let's use the default @max_active. This doesn't cost
> anything and clearly expresses that @max_active doesn't matter.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Amitkumar Karwar <amitkarwar@gmail.com>
> Cc: Ganapathi Bhat <ganapathi017@gmail.com>
> Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>
> Cc: Xinming Hu <huxinming820@gmail.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Brian Norris <briannorris@chromium.org>

I'll admit, the workqueue documentation sounds a bit like "max_active ==
1 + WQ_UNBOUND" is what we want ("one work item [...] active at any
given time"), but that's more of my misunderstanding than anything --
each work item can only be active in a single context at any given time,
so that note is talking about distinct (i.e., more than 1) work items.

While I'm here: we're still debugging what's affecting WiFi performance
on some of our WiFi systems, but it's possible I'll be turning some of
these into struct kthread_worker instead. We can cross that bridge
(including potential conflicts) if/when we come to it though.

Thanks,
Brian
