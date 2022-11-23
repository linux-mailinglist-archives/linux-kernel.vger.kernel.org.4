Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45178634ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiKWERC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiKWEQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:16:09 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E4ECCEF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 20:14:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so776302pjj.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 20:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3R5kXJm+KR5AiX1AMlOLzMKVuj1Y3Ygn0JJmuEOZJmQ=;
        b=IcZNfrgnIfrSdc0FW6pTw+GOdenTQ0AMdj4QQDRF8juwbMbOhL1zuSQD8SPdZGzMgv
         HNGnqJ5XNUpE3knxp9Tz+3QzOsZ+ALPtsHqerBWlb4ISDc/uNyXhwa8bz0Em/P3uwLzj
         Kn0dx8Dx9jpx8OHB2nl4mh2P5mq+yvQVsX8gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R5kXJm+KR5AiX1AMlOLzMKVuj1Y3Ygn0JJmuEOZJmQ=;
        b=edkTbF7uS9HazKPckLRoTLlL+I+jgYBaKBv1u2vQdNmjMvAvR8mhmAJbjxMJx6kTnB
         aqLpDUF7CUjI+p7ZKNnciy5xTDwSart0ADpSH5xyX/j4jSrJf5dxnq8nOb2/qQGS9M4h
         520uEaWkrDZEtv2Kc5DqLKleAHixgpN+MHbPl1p4jm7kcDeg1Yh30FaG+76sj8BRlaHb
         XgpRivRZIHcIKUbHdOuR+7a5FoXVcZo52eWBCb5z0bdoX8WgiRM2cF9UkrhIjUOHdrth
         w/uyL1rTK16EkmIPkGrA9iGBh7xRBw2YAHUGAvLg/lITKjCqgGIXfP/k1FOV7oQL3cnw
         mtyw==
X-Gm-Message-State: ANoB5pkrse33h7A5+l+zszYIs249p44pxG6bgtK8ReLjFvWZ4HiKGBir
        pHfX7lSIjBi9JyhrrD4LNfArlCQLbemFeQ==
X-Google-Smtp-Source: AA0mqf5j3OSa939puKpzv39BJknnN9wAwCiahUryDGlII3vo5W17YQ5PIAZOjXOH7jAU/DnQqFgWvg==
X-Received: by 2002:a17:902:6847:b0:183:6555:38ef with SMTP id f7-20020a170902684700b00183655538efmr10593669pln.157.1669176840983;
        Tue, 22 Nov 2022 20:14:00 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:b570:e8d2:6522:6054])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090341cf00b0018930dbc560sm3096288ple.96.2022.11.22.20.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 20:14:00 -0800 (PST)
Date:   Wed, 23 Nov 2022 13:13:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Aleksey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Message-ID: <Y32eA93V7w1Wu3VH@google.com>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
 <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com>
 <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/22 12:14), Aleksey Romanov wrote:
> > IIRC that was patent in question:
> > 
> > https://patentimages.storage.googleapis.com/e2/66/9e/0ddbfae5c182ac/US9977598.pdf
> 
> I think the patent is talking about "mapping the virtual address" (like
> in KSM). But zram works with the "handle" abstraction, which is a boxed
> pointer to the required object. I think my implementation and the patent
> is slightly different. 
> 
> Also, the patent speaks of "compressing" pages. In this case, we can add
> zs_merge() function (like zs_compact()), that is, remove the merge logic
> at the allocator level. zsmalloc doesn't say anything about what objects
> it can work with. Implementation at the zsmalloc level is possible,
> though more complicated that at the zram level. 
> 
> I believe that we can implement at least one of the options I proposed.
> 
> What do you think?

Oh, yeah, I'm not saying that we cannot have something like that
in zram/zsmalloc, just wanted to give some historical retrospective
on this and point at some implementation details that should be
considered.
