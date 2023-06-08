Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F12728495
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjFHQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjFHQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:07:32 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5C1BEA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:07:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6263b2526a0so5286906d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686240449; x=1688832449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+t4pp004nh6H5J6kEKQ9eJHodu8jkZHk/HObzTTU2w=;
        b=kScJIOz78K7G3+W4AMp5+e+msjn85S1/ex/AYEQYf9FIXrsAYQH1TdHGhLguZGmO2G
         DFqS0MZxPlIM0oy/BQ07kANE4Ds6Rzrrz4Wg9WMQy9NPO36Xo8Q9wsFo3TDI2jE2jV2K
         F16oyU6hU6t2UjCy1MbQvfXeCUTISmWLPEEALR6thdByKwldCNVMj49wxcvJT3RPU3Sp
         W9hIlStRtyZJ28EfUUZoV/K5xGttGa01UpHH6Rzut6W+txxg+n8z6aC8hoW9QMGoBRF5
         sR1rMU9d7OqAH7koogczViEH/Hp8+SRcjBaCwm9zxv675CM8j/CgcePgSSYDCFeE4zDy
         OY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686240449; x=1688832449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+t4pp004nh6H5J6kEKQ9eJHodu8jkZHk/HObzTTU2w=;
        b=TJ4TkmneX/QpkeiYLJBlYdLptY2U8xklGnxWn8CI/tRkp2acAwRgvpwoLzbNckJ5vG
         /CFoF8cBo7JzNkFeghxvERoEjLWozN3cKuMBSE32B/PufnXCI159iO3988jErWZdXmKt
         n8R0TObjgUSseUMSFdceQ3otlW4oNM3NsNgmDwoNSL99wxjWosvK70Tg0Zwfia34UoZX
         VAtqAC/cak9J2Ill2h+F/VTmx4cnr6LiuWd9hGk1VMNYu3LDOwqYgTUyuvxyXqlDVSzK
         f4dSJVklOy7xL+gbfllulQ+x/aicekhcwfQL5RaaN3iDDchB/Es3YajMitHqqC9nJNjM
         1+/w==
X-Gm-Message-State: AC+VfDxulW/CQZeSp+CuJ5MNmes3WFpijPbTEXlqRFTcvQIfIjbrT0yj
        2IoqGaFgygL7RFt8DNrqT85jUg==
X-Google-Smtp-Source: ACHHUZ5DwpfO9OvKruEoBXcoC2H8LC6I9Y+nFD6dX0VhhLpNyolZwnvWeMR5yKtbrFNRSNIpD8WS6g==
X-Received: by 2002:ad4:4ee5:0:b0:625:aa48:fb77 with SMTP id dv5-20020ad44ee5000000b00625aa48fb77mr2069777qvb.65.1686240448578;
        Thu, 08 Jun 2023 09:07:28 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id l12-20020ad4452c000000b005ef5f8dc89esm492333qvu.88.2023.06.08.09.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:07:28 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:07:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 4/7] mm: zswap: remove page reclaim logic from
 zsmalloc
Message-ID: <20230608160727.GD352940@cmpxchg.org>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-5-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606145611.704392-5-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:56:08PM +0200, Domenico Cerasuolo wrote:
> With the recent enhancement to zswap enabling direct page writeback, the
> need for the shrink code in zsmalloc has become obsolete. As a result,
> this commit removes the page reclaim logic from zsmalloc entirely.
> 
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zsmalloc.c | 393 ++------------------------------------------------
>  1 file changed, 13 insertions(+), 380 deletions(-)

Yowsa.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
