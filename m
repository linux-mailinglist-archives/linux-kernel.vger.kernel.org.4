Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E920624458
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiKJOcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKJOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:31:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E610FF2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:31:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so5572016pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKZ49Hq5cxRBRGuGWZmrWmyUCChzQiTYq0wPx6wHlvc=;
        b=EHHqa2wvLN4L0h+BDA+s7vsVb5mNPysYohstSXuowrBlnagzJejUduUwbh+UwOJGma
         sPx4kJMLuI/Sf5LBbDMOPEtM8+HvB+lA5eUWBNSuFFS6a/c0nCaYcGxerABB3rMzLRDY
         npaxx1QtDVmujfUgvXcRQclUJek9MYBes323s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKZ49Hq5cxRBRGuGWZmrWmyUCChzQiTYq0wPx6wHlvc=;
        b=rH1hpRXYLnt2ydBPz4hE7PFZBdF0F9cYIqaQrVoobSKt/cKDf68Hn7mYQVnQ4M0emp
         7ETkExwuqIQ1EW+nDApP3EtUXHaDXqk3GFA58knWbj89JGIp1qshxjytg9W+p/fRM6Ai
         07FA5grT46WPBMuVW8A9MffgQ11thr60xPlbM92WnvTv3vVds4mfhRAbBdMNZyffE6XO
         pL6IC1oMOvyf8DzvKVSW9+1smte0sZlNwP09OcTysLVVnp0yfLLu1Ti4r1iZJ+OAqIWl
         GeKuedJxRtMd+xk6IvKz9Qh7vuoT3HjJlfTeGxdUJRSqnCRbD3XNTcke15E9WHh6dDNo
         eNkQ==
X-Gm-Message-State: ACrzQf2gaoSMNLlB5QMfBfUHBJFoZDPqdDu5iI4WupOU5rIr281tU5aS
        q4iLofp5+hhv2498cYBtQ5djYQ==
X-Google-Smtp-Source: AMsMyM5FM6+Inj4VnlE00+/2ySDhZb9ew7QK2Sfkx1aMTS/XaSkyEbT5L3/ntwCsotmKq8D+ABCOoQ==
X-Received: by 2002:a17:90a:784c:b0:213:5b03:62e with SMTP id y12-20020a17090a784c00b002135b03062emr65667417pjl.241.1668090716334;
        Thu, 10 Nov 2022 06:31:56 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:2129:96b6:e6b9:b930])
        by smtp.gmail.com with ESMTPSA id p189-20020a6229c6000000b0056c08c87196sm10192940pfp.48.2022.11.10.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:31:55 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:31:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev
Subject: Re: [PATCHv5 04/13] zram: Introduce recompress sysfs knob
Message-ID: <Y20LV+1jJMZ2FFnM@google.com>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
 <20221109115047.2921851-5-senozhatsky@chromium.org>
 <Y2z4DbuYgDJ/v8u+@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2z4DbuYgDJ/v8u+@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/10 06:09), Nathan Chancellor wrote:
[..]
> drivers/block/zram/zram_drv.c:1894:10: note: initialize the variable 'err' to silence this warning
>                 int err;
>                        ^
>                         = 0
> 7 errors generated.
> 
> Is the fix just to initialize err to 0 as it suggests or should there be
> a different fix?

Yes, that's the correct fix. Thanks for catching this. We had "err = 0"
in v4 of this patch set, but it somehow didn't make it to v5.
