Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6617163003D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiKRWiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiKRWii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:38:38 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F31F32B8B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:38:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p21so5780435plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HS7sEulacmj3f+9ywrtjJQQzrLADk3rwjiT5beC2f0A=;
        b=ilPjNnL61iiMSRQcVrqjQNVK2HQ0z98UghwmpFG6kKdemCWTQ3omDqFLckmIRrC3LX
         ukyfT6CrliV4ZXQtptfuUUAubD0pmzcgt2wUrAYIK1L7hpCa9z6Uz2N8G7Aprst0wkW1
         +2ZHNxKq0/UdfKfAEFjzIsIwwHkQFzH+c7IAwwXhx6IEfI+Gj0t71+p3ZaJEbLPp27H+
         tSR86vL8/rWWVNY0EMw7xI6aZjfzV1cJlpp+x++D7+Oyqan5pbYnuezjZpGPhOOjp0X7
         GhoCZNNHv5rEGHN+ZbQ+/cASHKP519nxabD47EXTjTRk4PXXG3Ahp57mBE98lniEOXD9
         j94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS7sEulacmj3f+9ywrtjJQQzrLADk3rwjiT5beC2f0A=;
        b=NGgR8o9JoR2L3y2xJ81vzFNuQpekZbtzdTAnryvD0YqftEMWK4kIH+7o130p2rJk04
         +2yAzpacUcAG6p34gi5q9X7ueceUghK41e9NM+HpDJNZeYn1XcwXkS4rMprxqbNKhP3g
         v1g9uBUuaDPkw6emep2cgL/nFzyf3g5Dy6tDucVEE7Jro76IbzGq75zS73nZLTeCXmiw
         L7G9z2rVG9CAJ9KwNSDJYpzWLQjrr2DaThgs12la985ZU/FXdE5ZSx2Kpa8wrtC8/Fmm
         vD8M3w/vO0wQk97SzTfKoqP4syDIvf03CTXSFGDJydSo7hXGD8eprTiDuZpC/IWUqhyE
         ugKQ==
X-Gm-Message-State: ANoB5pkxfptcuMe5cHxaThxG/+sAQNoskDTdTDZF+F+QrvgY+ENAaVgR
        uM3/MG/lVl6qvSOwRfT3U3k=
X-Google-Smtp-Source: AA0mqf5UNNKxewq5WGgPNmPe78Ytew11k0tjQAADMAM9wB6Qoot7fw+MqwX2ndiEAp2QV8Kig2NtBw==
X-Received: by 2002:a17:90b:a15:b0:212:8f7:acf with SMTP id gg21-20020a17090b0a1500b0021208f70acfmr9570913pjb.13.1668811113557;
        Fri, 18 Nov 2022 14:38:33 -0800 (PST)
Received: from google.com ([2620:15c:211:201:bba9:9f92:b2cc:16a4])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0016be834d54asm4218422plh.306.2022.11.18.14.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:38:33 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Nov 2022 14:38:31 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v5 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3gJZxm3OlXmlTVj@google.com>
References: <Y3fyon7v00ABtU6M@google.com>
 <20221118220808.1194168-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118220808.1194168-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:08:08PM -0800, Nhat Pham wrote:
> Thanks a lot for the suggestions so far and for the review, Minchan!
> Quick question about your last comment:
> 
> >> +#ifdef CONFIG_ZPOOL
> >
> > Let's remove the ifdef machinery here.
> >
> >> +     /* Free all deferred handles from zs_free */
> >> +     free_handles(pool, zspage);
> >> +#endif
> 
> free_handles() here is for the deferred handle freeing, which is also
> under CONFIG_ZPOOL now, so I don't think we should remove the #ifdef
> CONFIG_ZPOOL here, no? Let me know if I'm misunderstanding your
> suggestion, or if you have any further comments regarding this patch.


What I meant is

#ifdef CONFIG_ZPOOL
/*
 * Free all the deferred handles whose objects are freed in zs_free.
 */
static void free_handles(struct zs_pool *pool, struct zspage *zspage)
{
       unsigned long handle = (unsigned long)zspage->deferred_handles;

       while (handle) {
               unsigned long nxt_handle = handle_to_obj(handle);

               cache_free_handle(pool, handle);
               handle = nxt_handle;
       }
}
#else
static inline void free_handles(struct zs_pool *pool, struct zspage *zspage) {}
#endif


And then we could do

__free_zspage
     free_handles(pool, zspage);


So without CONFIG_ZPOOL, the free_nandles function will be void.
