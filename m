Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA2E730217
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbjFNOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbjFNOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:35:58 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC6184
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:35:56 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so668231276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686753356; x=1689345356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9Z6IG0vCORCL7uMKyEfYtFj48tS7lYgzWBfqeu+mFs=;
        b=xx2teS03CW5KJWU75jxzV7YiG4hTBqkmOz7B5HkSbr5PlrxEUG5yEO6XVOVw3T99oi
         OA3e2Qt4QsXpnHcY1NuP6a2uqm0zcIHKo/lrH2i3yrzvAWlRjFquQnngQgycI3ELzbI3
         4lyfO7N/Uq1D3v2L9nzeih5pdQyyx/D2wJm0pecNI90BNg/aa+g2EjC6GPbknzm9MUqB
         37eQgiQFlgl1CPcq09jkjCuzA5n5jPl7I8OtGaS3lEHYYMq9gMqfjGpiYm7udrmrct0g
         jC9a7ss9i5I4y86hrWEvyY2s9D3/8UWwcu682D2d4iM3Bpqj8xS/LDPIeLMWTxewOAaP
         DP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686753356; x=1689345356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9Z6IG0vCORCL7uMKyEfYtFj48tS7lYgzWBfqeu+mFs=;
        b=JrJIgDWZ2jdVpmTwe8rFcsiG4z/y6s4QyeD0ZvlX74M84/xp4WAGu/wOdA5xt2lJD7
         IpRZdS/M280AfzJm083HZLbEXv1inL6fYY/KgGyw5g553i+ccJbvb0yNGswpSxO8XYfE
         qTmfsKsANJMd5FFEYkp9YyJMfden0H17sVggl82Vj0uPIkyBOTaid1G07/zlxHHKl0s2
         fris4UfHfhjYC41pW3TQ5+SJiX7hyabBNvudyvK+o8Gk7bpL6vPfH1RCn+TXHxT9ak5R
         yur0RHMsi2DM5VUZ28tFR+KZMCbO00R5O0u/5JBdjPSB+UCmSeeugEuUe0A8jm/ectFn
         tVaQ==
X-Gm-Message-State: AC+VfDwyuHa7uiBORnoveW9oHa5XcWBQL2WR4/rmnc5iWjWisG+puh5S
        4R55KB3bZ9DyYLKEmpT7l0eyXQ==
X-Google-Smtp-Source: ACHHUZ5d2G3NOaoMVp4Qda9qzgyfBEi1CPzmWlDo+Bil33jjOyx/sPlm6k0no+yYlkAJS0YF5Xo9Mw==
X-Received: by 2002:a81:4645:0:b0:570:acd:4945 with SMTP id t66-20020a814645000000b005700acd4945mr1775407ywa.19.1686753355954;
        Wed, 14 Jun 2023 07:35:55 -0700 (PDT)
Received: from localhost (c-73-179-220-136.hsd1.fl.comcast.net. [73.179.220.136])
        by smtp.gmail.com with ESMTPSA id j142-20020a819294000000b0056d1de0a154sm2173381ywg.37.2023.06.14.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:35:55 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:35:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, nphamcs@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: zswap: invaldiate entry after writeback
Message-ID: <ZInQSg08lDyM_W-b@cmpxchg.org>
References: <20230614143122.74471-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614143122.74471-1-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:31:22PM +0200, Domenico Cerasuolo wrote:
> When an entry started writeback, it used to be invalidated with ref
> count logic alone, meaning that it would stay on the tree until all
> references were put. The problem with this behavior is that as soon as
> the writeback started, the ownership of the data held by the entry is
> passed to the swapcache and should not be left in zswap too.
> Currently there are no known issues because of this, but this change
> explicitly invalidates an entry that started writeback to reduce
> opportunities for future bugs.
> 
> This patch is a follow up on the series titled "mm: zswap: move
> writeback LRU from zpool to zswap" with message id
> <20230612093815.133504-1-cerasuolodomenico@gmail.com> in mm-unstable +
> commit f090b7949768("mm: zswap: support exclusive loads") that's in
> mm-unstable as well.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Domenico!
