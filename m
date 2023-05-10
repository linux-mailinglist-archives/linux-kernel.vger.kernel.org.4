Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B985B6FE4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjEJUOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjEJUN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:13:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0428B6A78;
        Wed, 10 May 2023 13:13:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643b60855c8so5585399b3a.2;
        Wed, 10 May 2023 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683749633; x=1686341633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhjamj7N/hY3TKIMtd4AQuu2hFu84G2lwr7mPIcX/EA=;
        b=jZjE5mZtEgIAKq4X5yfdYzQKtK6OCg4F8Nt3Yv9eDn251RHu1WFYhnFtLmPNr/TmNA
         AhRHgzS2TJXnisk+4J7kyCs2kYc7xXUEgV0+0kS/npvj+5/Ln+vnZOjoWiep/PRXFtah
         K56iB81DfIJNhee9Np7mdKkCaM7xUIX9MbwOXKNMBZy7DnT0zz2QGNwW+ELfRWqiOUaJ
         gB136fFKj7Areoa9FgWsMhMMTyxlOE7A+eT2JnVZ+WsGgdCAHHN4bCz3xGnugPlD4Qd3
         8qDZ+4znuFO/cGbOFZYYZzFE7u9K9BirdjJhgvnTsezxUIYnsxcbX6DvwZwHeWZd6SCl
         spRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683749633; x=1686341633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhjamj7N/hY3TKIMtd4AQuu2hFu84G2lwr7mPIcX/EA=;
        b=c9zw9IykRPsG2jGQ+TMdxAbfXh+ICpx7mZLzjX2OvrAJSunUhiLOBaklP3x8CCOoud
         lPWmZHymCaGuxbXmoO/GznDRizH1WquVHGBFZ75t7EZZ5aiiz5Uva0Mdd/u/cE7ANvzL
         jVUFsQlipokCXbjrQ5j0BvUhgiSKTBAFkFwrvEoIUeI6BGm0p5IEBzlozNch7ivsVL/A
         ahBL59RAQYCKeTP/N98brEDUuIeAMWHOibIHSCIIgfEcoR7PMHaiExvTTxweKaevkWbr
         /c9h1f3KZkbOT9BHNoVZ2d9umlXykJTwqJzWzDzlco9NvwOvqVW2JG0QO8G3z4BrqN24
         xsxg==
X-Gm-Message-State: AC+VfDxL2YEWZNjolXU8BgE2pIBKkvBghrGhMbJLuvIQb5hOM13yjTfN
        pWzuRCEcbxBeRitv3sLtCAA=
X-Google-Smtp-Source: ACHHUZ4SwUbwsrVJ88mTjXH07dQxZ4tcYYPQFUqFY4wXD21RIUSyoWWeyoFhDX/g5wlKID35aBKF5A==
X-Received: by 2002:a05:6a20:7d8c:b0:ef:e240:b552 with SMTP id v12-20020a056a207d8c00b000efe240b552mr25118752pzj.46.1683749632988;
        Wed, 10 May 2023 13:13:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q18-20020a62ae12000000b005e0699464e3sm3855909pff.206.2023.05.10.13.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:13:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 May 2023 10:13:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH v2 1/3] workqueue: support pausing ordered workqueues
Message-ID: <ZFv6_8rJxPid0gdd@slm.duckdns.org>
References: <20230510201205.308542-1-johannes@sipsolutions.net>
 <20230510220918.1dc654070530.Ia49f779e11c2814294ea7f8bb29f825fb840be51@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510220918.1dc654070530.Ia49f779e11c2814294ea7f8bb29f825fb840be51@changeid>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:12:03PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Add some infrastructure to support pausing ordered
> workqueues, so that no work items are executing nor
> can execute while the workqueue is paused.
> 
> This can be used to simplify locking between work
> structs and other processes (e.g. userspace calls)
> when the workqueue is paused while other code is
> running, where we can then more easily avoid issues
> in code paths needing to cancel works.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I'd be happy to apply this once the rest of the patchset is ready.

Thanks.

-- 
tejun
