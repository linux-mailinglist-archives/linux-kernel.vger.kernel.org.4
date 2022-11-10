Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92DB624DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKJWsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:48:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5292213F6F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:48:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so3208752pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myDk/lYGLu7o49r3666PllQAH7/uxJEgb7b7To5JD6U=;
        b=Ou3dCUHB3cHz6ogbr6KnA15osAOsahg0uwLQ8OZhro5lFANuW2UnFbxtJ/vNBh8CiZ
         tI13ggx275xQ1OG2j5LOu7k+w9coqzmAzps2KgizvZDJUt9hJ2TIHP0cSqHyGO7EVO2h
         lisG6QbCT21i2+0huPRpK3VrJ966KjN3WdakH2ZUwsepsvk0fv/oQBGHtaZCCsKrzQTB
         Plww51rLc7cXR/0Qc9wYdzwHg5zxIZTIE52LK4FVcUc/jx+I0n6xfWG9J4Wf4Z+agTVP
         Aj+9lckvfvjdmalIHOsEoZdh41xGhsvHFOTh6QaXqozhEZDK92lzbBbM+K5ilx82Iu7U
         BHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myDk/lYGLu7o49r3666PllQAH7/uxJEgb7b7To5JD6U=;
        b=mOAHjFRvM31GDpo9IOHa+aiM2jcfYzefLyCkEDkHijGRfuH1pGhrzH207z51qRg+tr
         AcL1BLxWe9NOnEJDGQq2X8gp3CXt9UvcpDTEFMbCIA7vQh7mp+oPGfUyXmrzz2Cn5TrF
         x+ZLRq382IQp/c5r0ugltyRyy4tMmexoF0DIEIkBc0wKenMCP001oTKzsodPP56ym0G4
         LjEtlo1+AdVAtWCn/hvfcCxl33cTgxxvOnKPxHNQTrZmszooMKGRjxlLxjd4jCSXJurH
         ot6IIqP1zVlUuApeOoKKdLJI6O6UzM8xfH95TXjWMpTvrMXd6g8AzrlzhV3RH2dMJ2WD
         DDRQ==
X-Gm-Message-State: ANoB5pn1UxxLHYEvJZy5TBFuSdGtQSv2OZDL+tKhBs6x0BLtTi9cmpDB
        p4WszcRf2EnDVaMUZdnxQxo=
X-Google-Smtp-Source: AA0mqf4D2IAdlpJwCtBKx5pmIo5p/Y5r2PI+tyZId8kUXamyae8Zx1hu2Vj2at4GRfX8TIMB9R2zng==
X-Received: by 2002:a17:90a:9486:b0:217:ff37:2fe9 with SMTP id s6-20020a17090a948600b00217ff372fe9mr1144237pjo.242.1668120514759;
        Thu, 10 Nov 2022 14:48:34 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8c0b:3260:c81c:119d])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00186e2123506sm170934plg.300.2022.11.10.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:48:34 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Nov 2022 14:48:32 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v3 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y21/wAkXt7IH/tXN@google.com>
References: <Y2wh4b3oMaknNqGP@google.com>
 <20221110171831.19176-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110171831.19176-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:18:31AM -0800, Nhat Pham wrote:
> > Please put the LRU logic under config ZSMALLOC_LRU since we don't need the
> > additional logic to others.
> 
> I think the existing CONFIG_ZPOOL would be a good option for this purpose. It
> should disable the LRU behavior for non-zswap use case (zram for e.g). The
> eviction logic is also currently defined under this. What do you think,
> Minchan?

That sounds good.

Sergey and I are working to change zsmalloc zspage size.
https://lore.kernel.org/linux-mm/20221031054108.541190-1-senozhatsky@chromium.org/

Could you send a new version once we settle those change down
in Andrew's tree to minimize conflict?
(Feel free to join the review/discussion if you are also interested ;-))

Thanks.
