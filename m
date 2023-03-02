Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7156A7862
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 01:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCBA2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 19:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjCBA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:28:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087901B9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 16:28:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso1080165pjr.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 16:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677716906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6MSs4JhTicNv1RSJUVEYiuAWhf/shzkoon291NbD+s=;
        b=XbAsdWAxXE1xxvdye4FEAafU+kg2XcJZd4UAfM2F/gMNfhKpMAlYvAEctKg1W7Zr7C
         aQXz4L4OAi5CdJz2p73HTOZBmcrOsWOANKBpPJYBr8hhhmX932CknmnV1rS9DHZaHP5X
         LYJy5/WgTvr2qn5ja3rkSy+RYR2PSbDsBD4XKOWLDk2UbQIT7ZG4CpyKNf9n7xRsLYwY
         FrYF8e39DEIckzd4TnGyJ48yxZsu44N15JWicwBvdLPE48Yo0EBkhgV2h5qZS5B5hJ7p
         qaVIiGTSjwPa0AyQIfLfxRnGyRs+nqRmwqzvUxwryjVktGv+pJCxCjAnJEMcM7AeeoDK
         ZLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677716906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6MSs4JhTicNv1RSJUVEYiuAWhf/shzkoon291NbD+s=;
        b=q77NWKw6TY+ytzz4hcBFmhSh1eOHVmn2CnW+nMlT+ozJM72OWfMN7p35kQdujVN2OT
         vcdrwQtUofiXvnAbnzXOCwdLLXDxf5/kCPYUc7YGhOU34Zgyvw19iREW9hgzGJbPTOrk
         eOxgeaH7d/3xNxuEhS98gweJPnTNtQR2CZDNpp7Jk+XGMdvXzSTwByxZWELWkKoqgSjo
         QlAyQfZ7vjZGM5scBa7PTH34LgFxZRqWdsIJVmkIxtedUkQttyIEhjdCeOw1Sfam0vzF
         b2tzCwHyA+CXAStKQduXcIWtYPeiTTe0fsjcU5jVeL/GDr9a6SEw/wNyD/xKBH86K0Mt
         ExSA==
X-Gm-Message-State: AO0yUKVINJPrYUhvnxqAo6eHxGcg5yAX/vrBeqJYV+1JGPGh8+Yj+DOU
        0mCI/FHB7hFaRU5Q2hzcjSYTyChf5Wg=
X-Google-Smtp-Source: AK7set+VnE3hhih39oN83eGdcDUSgVF2hYkW9hqkdwKojEI3f5njwQvRhZeRisDZPXQfLnAtJS1BWg==
X-Received: by 2002:a17:903:40c6:b0:19c:d6d0:7887 with SMTP id t6-20020a17090340c600b0019cd6d07887mr7060079pld.30.1677716906532;
        Wed, 01 Mar 2023 16:28:26 -0800 (PST)
Received: from google.com ([2620:15c:211:201:a524:71b8:ce7e:745d])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902b58700b0019c2b1c4db1sm8938483pls.239.2023.03.01.16.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 16:28:25 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 1 Mar 2023 16:28:24 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y//tqFQgsCeMimg5@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
 <Y/6GAYJ4c9W0bPzp@google.com>
 <Y/8TENp78WSQ0UW3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/8TENp78WSQ0UW3@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 05:55:44PM +0900, Sergey Senozhatsky wrote:
> On (23/02/28 14:53), Minchan Kim wrote:
> > BTW, I still prefer the enum instead of 10 define.
> > 
> > enum fullness_group {
> >     ZS_EMPTY,
> >     ZS_INUSE_RATIO_MIN,
> >     ZS_INUSE_RATIO_ALMOST_FULL = 7,
> >     ZS_INUSE_RATIO_MAX = 10,
> >     ZS_FULL,
> >     NR_ZS_FULLNESS,
> > }
> 
> For educational purposes, may I ask what do enums give us? We
> always use integers - int:4 in zspage fullness, int for arrays
> offsets and we cast to plain integers in get/set stats. So those
> enums exist only at declaration point, and plain int otherwise.
> What are the benefits over #defines?

Well, I just didn't like the 12 hard coded define *list* values
and never used other places except zs_stats_size_show since
I thought we could handle zs_stats_size_show in the loop without
the specific each ratio definary.

Furthermore, above example, the special ZS_INUSE_RATIO_MAX will
be definary instead of hard coded 10.

    ZS_INUSE_RATIO_MAX = ZS_INUSE_RATIO_MIN + ZS_INUSER_RATIO_CLASS_SIZE

so, if we want to change the ratio later, we would need minimal
changes all the places instead of changing all the hard codeded
definary.
