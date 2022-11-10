Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B97624DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKJWo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJWoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:44:25 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30024509E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:44:24 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q71so2932931pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuSKrl+/DV5Kj4welJmVDK8XOamSFjC5ydfR3wdWhcU=;
        b=nesWlNg6phzKngSp4sCx7/sF3vGW7h63W0IURGzR1Xjy4EQPpEMaC4d9lchWGizDU4
         OxAMm/ZBTwTwTKz1Rki4j815EMVa0uvOSDKXtK68D8YsJ4OyuUqbanVTNQoipTMHCAhw
         vVANyA7GzNRWY8iqZ5xK4K0Cfz5JjcHVb4VWxfAg7MvsJ4sqgoqSOUqZ+7i/dAS2jukX
         s/XJe4C5rGw1sJTk1oR+q/1EDU69yN06QixBRhFp9DWs4bYlsh1pDYdHbEi7YZdCPv3M
         n3HnqjqHPMcylqrlg7MkWqCFrZhpA7TAf4Om3Q1dLwQUMfdMMeOYT6Cwbjerl7H1n4lV
         oLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuSKrl+/DV5Kj4welJmVDK8XOamSFjC5ydfR3wdWhcU=;
        b=dpSLkJbPPsBiL5zgwBMN/f07LqL3AjvNn6Bd+dkuutjaxBJnG6/07oDoacAS0diPJi
         MruCIlgzJLs6/Vdbso41AYX8M5Yp9sVbRcF646cU2gZ00/Y1OvvEvoRQMv7GcDuLrQQl
         uA7cBMEW/aUR7xPcxQIVDLO8LG93cycHDcDqlRQvGCSc4BYDTI/3nWN84+HU8qUCuxOP
         rHbA+Y0jN9c8EQciS1441ANqP/M/EGxLmnMrzwbzpXoxCOnv5IZy+4KrokZ6WOZsDbu9
         fwUAoRJdWyLo6s+85D620vCxlVsBvm6Es8/NlnL8kpPRtofjYqK0M6OFSNQ8J9zrAdEz
         aoMA==
X-Gm-Message-State: ACrzQf3xfiYeyxYLSVQ0ToRmxYacpJMyU6spsf/ViFjvlDan2ugVB4BO
        1Tm89OPw+ZP+iAewkXDPvV6ErjeN+gI=
X-Google-Smtp-Source: AMsMyM5ZlSfxNkT1wVmc6LzBzQEpADhgMFuyx8d2PgN/uZc+KwMjCEbWZw0xeb1TP2N0EJQB632OWA==
X-Received: by 2002:a62:d401:0:b0:56b:676e:1815 with SMTP id a1-20020a62d401000000b0056b676e1815mr3880392pfh.66.1668120264246;
        Thu, 10 Nov 2022 14:44:24 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8c0b:3260:c81c:119d])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00180daa59314sm198221pls.125.2022.11.10.14.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:44:23 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Nov 2022 14:44:22 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y21+xp52OQYi/qjQ@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031054108.541190-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:40:59PM +0900, Sergey Senozhatsky wrote:
> 	Hello,
> 
> 	Some use-cases and/or data patterns may benefit from
> larger zspages. Currently the limit on the number of physical
> pages that are linked into a zspage is hardcoded to 4. Higher
> limit changes key characteristics of a number of the size
> classes, improving compactness of the pool and redusing the
> amount of memory zsmalloc pool uses. More on this in 0002
> commit message.

Hi Sergey,

I think the idea that break of fixed subpages in zspage is
really good start to optimize further. However, I am worry
about introducing per-pool config this stage. How about
to introduce just one golden value for the zspage size?
order-3 or 4 in Kconfig with keeping default 2?

And then we make more efforts to have auto tune based on
the wasted memory and the number of size classes on the
fly. A good thing to be able to achieve is we have indirect
table(handle <-> zpage) so we could move the object anytime
so I think we could do better way in the end.
