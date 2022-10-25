Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B405360CC04
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJYMiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiJYMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:38:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AAB188A9D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:38:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso1436968pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYUaukjgG6ZPIhZG6+5xi4ihALsr7hi5S92eDWaX9Js=;
        b=LPbQLK3/YEUNHpbsljFlrrNkHOjHg+b2Dl5khLYRIbkIc2Ok43F9bS7v9pNBFXrOvv
         phAIH/D60w4A/LMnQeL0X2hKEfTNDJzuv4KVe4V1nRRguqPe5/WvrDQRgGGf1MPYpQFX
         enIRpGTAZ3QI/yhZN2q44OAv6xXh726SC6qEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYUaukjgG6ZPIhZG6+5xi4ihALsr7hi5S92eDWaX9Js=;
        b=UxblsVERkb99obC/u8Zp8G17eMWyNE60VmdMsAJUnypo5oSXlEoaa5bs2pgdZfrrBh
         AdqJ/PTecxRFKPk0+sLX9Bp6oK7DcUb8Zhuz/+qcmJ6BPlEK8cizi7S/o9kzie5yz1zb
         eFpWFwL2sKCEaZT/ALa/SmMSQNaXXELwYNk1Qw0ogpiK97EN4jwAsqToI8I0BxZpu5ez
         bFdEEC7aAgRLjOohx8dVo7tYi1wT6qRyoG4v6SDjX1a+VYBDHZmu0KxWFJzhzdA/RYRZ
         ia5aul8mYGVlOYVSVH+ugWOY4MLU83xI8wG+LdrwfLoLhmZwMb9t5Qp2sL1Ys+VWffOe
         ezUA==
X-Gm-Message-State: ACrzQf0nF92QkwbGkQ8sECUsuH5akMhKf8vKBZJF3CcuY456PUxSX56G
        z591go/lXSdO2qBVoUuwptzqtQ==
X-Google-Smtp-Source: AMsMyM4MWOqMmrWGjwKGNIaaUovq7sl3ktd2m4jnMt70aw/tyTH0H7AFGOSXvkCh3E4d88EJYIykcw==
X-Received: by 2002:a17:90b:1e0c:b0:20f:bcbf:ab5 with SMTP id pg12-20020a17090b1e0c00b0020fbcbf0ab5mr42924589pjb.187.1666701489563;
        Tue, 25 Oct 2022 05:38:09 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:c493:65a6:2d64:1325])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902e74d00b0017a018221e2sm1177082plf.70.2022.10.25.05.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:38:09 -0700 (PDT)
Date:   Tue, 25 Oct 2022 21:38:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Aleksey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] zram: add size class equals check into recompression
Message-ID: <Y1fYrM3o2ZudjZ/7@google.com>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
 <Y1dBpLDf+mRH6cLf@google.com>
 <Y1dEOLjD+kpdz0Vo@google.com>
 <20221025094859.7kbcqknlkmo4hj2y@cab-wsm-0029881.lan>
 <Y1e1tvMMXU5+8JQP@google.com>
 <20221025115542.5o4igroslirn6cxy@cab-wsm-0029881.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025115542.5o4igroslirn6cxy@cab-wsm-0029881.lan>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/25 11:55), Aleksey Romanov wrote:
> >   Return: the index of the zsmalloc &size_class that hold objects of the
> >   provided size.
> > 
> > unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
> > {
> >         struct size_class *class = pool->size_class[get_size_class_index(size)];
> > 
> >         return class->index;
> > }
> 
> Sure. I think it would be more logical, and perhaps such a function
> would be more applicable in other cases, in the future.
> 
> Will you fix it in your cherry-pick?

For that I probably will ask you to send out v2, if possible.
