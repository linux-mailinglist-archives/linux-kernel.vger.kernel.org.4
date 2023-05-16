Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F3705927
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEPUzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEPUz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:55:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34065B83
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:55:23 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-528dd896165so10550356a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684270523; x=1686862523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ej71yRmPRu8z2W7e0T8QvzS/1x48yctizGgEV8AzVJw=;
        b=N1gLcB0OyN5P/6560cO03tcoXuunorDDRv8/T4ScocezDogLnisXjQRFXeEWIPaZNE
         stvLqWsvqikUbOXMJQGdbb3NxGCGiZHtczbS/auERzUjSFl53q5J/HNhyLHJpxCM2BXz
         KK9sMEAK94ZcYKUw4QSDoQUSsGVywLhBFCyDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270523; x=1686862523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej71yRmPRu8z2W7e0T8QvzS/1x48yctizGgEV8AzVJw=;
        b=Gu/j7FpRKXXQB1vPM0krJp/yxNOu16Z4wSy8Qvt42KBZgZiY03yycqPyacaIGRtalp
         O3eAb2cZy9eIyx0o4pFwRQGFrcUuUzTm7FMz36Q1yhRV9ROXK3hu+u1d09Eb7wXE8G7S
         MS4ZrAcWPFChFqn3PWDy6GP+U2nblJ0TX3Ti8B7nNrSKuo9Q770XQALnzo3oKFXRkZV1
         XQ7sWNEIZ4/nZMbqs4FmbbGMxt2d96ZrN/l1JrQfVeRERR6q/FH/l+P3SCtV4oaT+sSI
         Lyv5JozwPsMFE2w5Xkn1kboZnlqZFxsAj9PwxjPjV1KoFj2IY0qRRgIc5abHjX50Hag1
         x8Fg==
X-Gm-Message-State: AC+VfDzKzIpkLngoXVZv2zJ7cIjCRCnuw0KPNdEqDvtqJoSL8QTB/z6U
        Gx2lGNd56fiwl+Zc/lPFr445mg==
X-Google-Smtp-Source: ACHHUZ6w9wbKEGcdydgn0Ey6n7k6IZJ4OF5ycSXaYOoNrr5tDJZEyh1wKJB0NUIZQbaSs10wq8HRmQ==
X-Received: by 2002:a05:6a20:9184:b0:100:d4ee:ba80 with SMTP id v4-20020a056a20918400b00100d4eeba80mr29367876pzd.27.1684270523147;
        Tue, 16 May 2023 13:55:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u17-20020a62ed11000000b00649ac17779csm9633763pfh.160.2023.05.16.13.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:55:22 -0700 (PDT)
Date:   Tue, 16 May 2023 13:55:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     gregkh@linuxfoundation.org, tony.luck@intel.com,
        gpiccoli@igalia.com, johannes@sipsolutions.net, rafael@kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_shashim@quicinc.com, quic_pkondeti@quicinc.com
Subject: Re: RFC design of device coredump collection on panic in Pstore
Message-ID: <202305161353.0F771E0@keescook>
References: <1683561060-2197-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683561060-2197-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 09:21:00PM +0530, Mukesh Ojha wrote:
> 1. Device_coredump allocates some configurable contigous memory that can be controlled
>    via CONFIG or bootargs and later registers for panic notifiers.
> 2. Notifier gets added.
> 3. Pstore adds device_coredump as its front-end via dumper registration similar
>    to kmsg being dump today.
> 4. Successful registration of dumper.
> 5. A device driver(A-Z) can register their buffer to be dumped as part of panic.
> 6. buffer gets added to the dump list.
> 7. Panic occurs.
> 8. iterate over registered drivers and copy their dump list to its own memory and if
>    it crosses device core dump memory log an error stop iterating.
> 9. Similar to devcore_dump() inline with kmsg_dump()
> 10.Copy the content to pstore region and this could be elf or raw binary that can be
>    discussed.

Yeah, I think having something like the panic dump handlers for
driver-specific data sounds like a fine idea (as long as we have actual
users of such an interface).

I think it would be easy to add another front-end to pstore (via the
enums, etc), and expose it via a new template filename in the pstorefs.

-- 
Kees Cook
