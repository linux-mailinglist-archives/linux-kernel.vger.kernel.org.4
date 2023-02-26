Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF186A2E04
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBZD5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBZD5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:57:10 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AFD14993
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:56:42 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 16so1738820pge.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzJ5eFmoxtJDE8tPzMLwMNaPrtRMEcmDAZJuAcY/77g=;
        b=Pv5KaI39juy5PXhIT03OoqI8IzbO/dDYFD9lOFGTKEl5aBriR6YmbmGQJ2lTA+unpK
         O0WsZSlN3C8gYwLTsBJJqI3A8NUWJoleop/y3kqWh7DnhECisPjav0debRu7GqB0S6z+
         4v3h/8kbu1ZauPgqbGfl7iA+Hi6vrKf2VLmHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzJ5eFmoxtJDE8tPzMLwMNaPrtRMEcmDAZJuAcY/77g=;
        b=ea+y15av0WSoklpEgHoLxUcfgzDuvYNkhCL2v7r0q8ZUkVZIAo1F6sArUvCoJAom8k
         S5QxmF01QISegy0t77myhvEPUNxHFLcy2f2XMIHN+q76ubthSh2DmXPUZWy4s85VHp2x
         F1fdfV9OKMUC//TK6jU8LRbuvP1nJ1LuOoC/5NSXUGso1MyFK6jxTO3kMNFlsnX6L9aX
         1nCq9c+s0uqgx82z35fQQ83rfmOcdgiMoDHBUEWXd77RbQVzI/y4h3XQdlm5tiShPh+b
         rHxQvJcDPFXaq85e2FYJ812uyrV10KlXazFE3R9W31YyYFDtKnIWC1L3Fgh8L6qHsAMI
         pwfw==
X-Gm-Message-State: AO0yUKW/faJP4kqJNioOUIP77igwahz+MKCCNyVolH4BXc1WqL9BQR2Y
        aYPP3+0Oc0CwBtCIUjpkIG/SEw==
X-Google-Smtp-Source: AK7set96M9hMFvr4Zfedh1Y0waCQoYAvu8zpLYD7Qp0VufRtDmfXDasMRKbLqfmtnCjN5ageeK3UdQ==
X-Received: by 2002:aa7:9dce:0:b0:5e2:da34:4aaf with SMTP id g14-20020aa79dce000000b005e2da344aafmr6170883pfq.4.1677383749839;
        Sat, 25 Feb 2023 19:55:49 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b005e099d7c30bsm1795612pfc.205.2023.02.25.19.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 19:55:49 -0800 (PST)
Date:   Sun, 26 Feb 2023 12:55:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 5/6] zsmalloc: extend compaction statistics
Message-ID: <Y/rYQdUDNHDCJJTO@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-6-senozhatsky@chromium.org>
 <Y/f75fkcQg6m3cbG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/f75fkcQg6m3cbG@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/23 15:51), Minchan Kim wrote:
> On Thu, Feb 23, 2023 at 12:04:50PM +0900, Sergey Senozhatsky wrote:
> > Extend zsmalloc zs_pool_stats with a new member that
> > holds the number of objects pool compaction moved
> > between pool pages.
> 
> I totally understand this new stat would be very useful for your
> development but not sure it's really useful for workload tune or
> monitoring.
> 
> Unless we have strong usecase, I'd like to avoid new stat.

The way I see is that it *can* give some interesting additional data to
periodical compaction (the one is not triggeed by the shrinker): if the
number of moves objects is relatively high but the number of comapcted
(feeed) pages is relatively low then the system has fragmentation in
small size classes (that tend to have many objects per zspage but not
too many pages per zspage) and in this case the interval between
periodical compactions probably can be increased. What do you think?
