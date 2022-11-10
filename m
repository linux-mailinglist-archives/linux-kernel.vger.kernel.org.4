Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF8562447A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiKJOjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKJOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:39:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9715FDD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:39:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so1534246pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PGUxq/3jr/sRYtdOzve4iX/PaZyflMzPk7cd+r6fN8=;
        b=cfHSUeylFvDkPA50hnFYS1kPYhccS/gXTdhk7dZcWCY4605DOV1f4Xi273Lj/y6vOy
         m4h1gHDigu+arY2xQfOtUwQz988fUn9JRzenlO8tBvu/aFyi19PxZDBd86c+m7XEEfqY
         eURXFhAT5EqdnGpQoYJ901hNlQrk0pxuDqQbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PGUxq/3jr/sRYtdOzve4iX/PaZyflMzPk7cd+r6fN8=;
        b=D1Zh6yfelr4W6MGghf+xvzyFNUanBRAFiWQn1CutblPUvV8sEijRcFIzYpOzdsMMU5
         l+Z1266m/Dm14Bqoal2vuFCM4JFkQ7AEmJqrDE+Pph3/pbyfg4Gd1phFPxucUwR/1jvM
         Vy5xRSClDsHFBvqzEi/w/Y8xG7zgU62+Lm1qN9bWozSVcsC50t+QfGDRnyelaBPDnJGK
         DZZfssOcnuq0cH3HOjrFIzhmqmRac61VqebzLXVK7eokI5MZeunEnxWT6z/quLr/RxEO
         Nv7KXUYR6GCXOfBd22YVX96CEp1Ct1Hs3wokMDS4qFkQ94cBqeBbmBB1OppldUTPMKlm
         uFsA==
X-Gm-Message-State: ACrzQf1X05TAxiwPK5S9/AoKsQAGjfVxHo3lMfFDYiCgYL8WDunD2yB8
        qOYrreArxbJnVrgh1rPb+oYW5g==
X-Google-Smtp-Source: AMsMyM7cQ+Eg0HOXosvU60zj4qjXokv+g7kNRrpz9O7C0hdw5QOxrd11RmRIwahFoKAXxzBg023KCQ==
X-Received: by 2002:a17:90b:84:b0:213:de0c:1253 with SMTP id bb4-20020a17090b008400b00213de0c1253mr58789136pjb.74.1668091142796;
        Thu, 10 Nov 2022 06:39:02 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:2129:96b6:e6b9:b930])
        by smtp.gmail.com with ESMTPSA id w25-20020aa79559000000b0056b8181861esm10601355pfq.19.2022.11.10.06.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:39:02 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:38:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv5 04/13] zram: Introduce recompress sysfs knob
Message-ID: <Y20NAX4R6RgRpWnE@google.com>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
 <20221109115047.2921851-5-senozhatsky@chromium.org>
 <Y2z4DbuYgDJ/v8u+@dev-arch.thelio-3990X>
 <Y20LV+1jJMZ2FFnM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20LV+1jJMZ2FFnM@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/10 23:31), Sergey Senozhatsky wrote:
> On (22/11/10 06:09), Nathan Chancellor wrote:
> [..]
> > drivers/block/zram/zram_drv.c:1894:10: note: initialize the variable 'err' to silence this warning
> >                 int err;
> >                        ^
> >                         = 0
> > 7 errors generated.
> > 
> > Is the fix just to initialize err to 0 as it suggests or should there be
> > a different fix?
> 
> Yes, that's the correct fix. Thanks for catching this. We had "err = 0"
> in v4 of this patch set, but it somehow didn't make it to v5.

Nathan, I just sent a simple one-liner patch. If you don't mind,
may we ask Andrew to take it as a fixup (folded) patch?
