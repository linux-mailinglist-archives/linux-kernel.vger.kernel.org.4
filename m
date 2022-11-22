Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288806333B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKVDHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKVDHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:07:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A6AAE55
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:07:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p21so12359639plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKC44xNtMBTTI03PsQfb3At/7mJh1Wd3rUBR7H0i12E=;
        b=kC0Bt7l3kahpt0PbuQCuay1yRbm20Fj2Bt0YFvmUvw+NUEwtk8EzVvHbbK1H+UHOJg
         gavysDY0jprhHkZN4GWzMRlWSZ8zTeboN3aJ/N+0pg4uXxuRa/2X/SVQwevv6E5t1a5D
         ExH9JPTBxhiQ9gTxuiK80EbdQ81HrKYOKXBbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKC44xNtMBTTI03PsQfb3At/7mJh1Wd3rUBR7H0i12E=;
        b=7q3b8r6HeVzS34hceHbJZkz9oahU3l1LwTZEvre3S+FF8Evv5lK0QAP9ym0GFT4F2t
         mUBGMDlsR/lMSLL66vMG0zfGgBMZc/BWWmVTqAHcAv4FyZHgjDegBq8y21wh4r1p56ZE
         esG1rYfJaTHaynwtKfxyMdrI9lrD0Jvo1mV0cpsYfG1IlAHpIWbd1trjpcKQbXqBS1n0
         4rhxJ+vvGqrwQdNWJ8k29c92+smKklbAl4iZ4TocxGzXgKwngiuckMFtBZY8L8VT8D1C
         OOGmJo6r21Iyc6muOUl+HzOhbbSGm8pLeiv7FK291lK3dfJQlSMVmfTBi5gifJpyBLb/
         U1mA==
X-Gm-Message-State: ANoB5pld9PIVR4Fsh2wSDv06qRuJ+AbbuGpkZySCYcHF/Aszw5fW7ZGp
        V58y4QPMEMtcVlMrrHPUdZoX7g==
X-Google-Smtp-Source: AA0mqf4i3JZ2WBQ8evqssiGnJFuhf6MNAtNpZd4DjY7+b4eZUr81cQcLKxvgLXjLkreXDViFjxJQIw==
X-Received: by 2002:a17:90a:a003:b0:214:1a8a:a415 with SMTP id q3-20020a17090aa00300b002141a8aa415mr23232123pjp.197.1669086467200;
        Mon, 21 Nov 2022 19:07:47 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id u17-20020a170903125100b00186dcc37e17sm10451421plh.210.2022.11.21.19.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:07:46 -0800 (PST)
Date:   Tue, 22 Nov 2022 12:07:42 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>, minchan@kernel.org,
        ngupta@vflare.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        ddrokosov@sberdevices.ru,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Message-ID: <Y3w8/q/HoSbqamoD@google.com>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
 <Y3w7VP5CKvm6XmoJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3w7VP5CKvm6XmoJ@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/22 12:00), Sergey Senozhatsky wrote:
> On (22/11/21 15:44), Johannes Weiner wrote:
> > This looks pretty great.
> > 
> > However, I'm curious why it's specific to zram, and not part of
> > zsmalloc? That way zswap would benefit as well, without having to
> > duplicate the implementation. This happened for example with
> > page_same_filled() and zswap_is_page_same_filled().
> > 
> > It's zsmalloc's job to store content efficiently, so couldn't this
> > feature (just like the page_same_filled one) be an optimization that
> > zsmalloc does transparently for all its users?
> 
> Yea, that's a much needed functionality, but things may be "complicated".
> We had that KSM-ish thing in the past in zram. Very briefly as we quickly
> found out that the idea was patented by some company in China and we couldn't
> figure our if it was safe to land that code upstream. So we ended up dropping
> the patches.
> 
> https://lore.kernel.org/lkml/1494556204-25796-1-git-send-email-iamjoonsoo.kim@lge.com/

IIRC that was patent in question:

https://patentimages.storage.googleapis.com/e2/66/9e/0ddbfae5c182ac/US9977598.pdf
