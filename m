Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92F062CFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiKQAhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKQAhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:37:54 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF331355
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:37:53 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c203so195091pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHTtbDkv1vYx6HM+OhUN1cvfnP72ZEU2c3GERdvqEto=;
        b=Me/kAUqJXbEgRmIrwLuhOL7mnGhpySjwFkDbcd8XJ5goWHwic1j5KmVQHGU63IbedU
         2tN07aHtFC/8nx4dafhVnlDSzLWR/ME7sg26kykwszEvPwz0eLYouhIRxj43hLf0YMu/
         Z87qh9QXvNq8qaZiO6hBiIPJcebPYAoHKAQgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHTtbDkv1vYx6HM+OhUN1cvfnP72ZEU2c3GERdvqEto=;
        b=nkMD96mSAibWC20SXKbzz4jKKSmGLTy+q8RFEG/VWs3n2G43evJ4rHOZL5EoaMhTzd
         4gDG1utrtGme2mkdgYZxAjgVdDxAKqY2GnOd8AZ9RX3PmHl+jVxRihWD30V2Qu6AL0Og
         W+AoARdAAKuk6p/AhfP6WxTxj3droOcmZeNYdGLZ8/QUWSDYUC1FfPBoVvdwPTMMPbkx
         ruBKkoez8tTbVLq7Uowhw5qvy8H9wS1AkXDBjSPUJy3X5aOxVXzAZPQ57hgFWLTG1wi6
         5yIJKTNVXzPZNhUXVzu/PK6jbOWkaXIPTTPi+cPII6I5rIuK4yEwpNz3nscCYF0xfyVF
         jVjQ==
X-Gm-Message-State: ANoB5pmyApVeBauKla+9cEBUhJVdjRJZsAW2AtzpCHdLCIthCCQ6WdRe
        v8cQ6a52iA3Adya1mCYI399JyaDY3qDHOA==
X-Google-Smtp-Source: AA0mqf43hO6QOyiZjjTzR+FMSytxo0mJPO3ELuRsR3ArW8sTSl04pJmVcc04XcWtGPZZxdgvkc9aSA==
X-Received: by 2002:aa7:9243:0:b0:56d:dd2a:f6b6 with SMTP id 3-20020aa79243000000b0056ddd2af6b6mr554889pfp.30.1668645473025;
        Wed, 16 Nov 2022 16:37:53 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d87c:a39a:d965:288])
        by smtp.gmail.com with ESMTPSA id f21-20020a17090ace1500b00214247989dfsm2258633pju.13.2022.11.16.16.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:37:52 -0800 (PST)
Date:   Thu, 17 Nov 2022 09:37:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v3 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3WCW6IuoYcIz8SM@google.com>
References: <Y2wh4b3oMaknNqGP@google.com>
 <20221110171831.19176-1-nphamcs@gmail.com>
 <Y21/wAkXt7IH/tXN@google.com>
 <Y3VeEV5Qjbk0/t47@cmpxchg.org>
 <Y3V3CWM1LSGT61e/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3V3CWM1LSGT61e/@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/16 15:49), Minchan Kim wrote:
> > It doesn't sound like there was any more feedback (except the trivial
> > ifdef around the LRU), and the patches are otherwise ready to go.
> 
> In fact, I didn't start the review yet so please post it unless
> Sergey objects it.

I didn't start review yet, but if you have a new version then
we can take a look.
