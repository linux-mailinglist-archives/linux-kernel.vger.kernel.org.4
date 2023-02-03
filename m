Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225D168A0ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjBCRy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjBCRyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:54:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4351C4A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:54:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l4-20020a17090a850400b0023013402671so9483755pjn.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FglzRedEledpe7U/HZFQU5fjwrxpiFTlIoZfizmZKxo=;
        b=jbL6W/faZm4W+GkDNARtVIQSEx2ADO2QYfIC86h2ZMHc5o/ZEBFOY5YrRkhNg2iOpB
         /63HbsfHa9WGzx3zbFmY1UfIUIuxKXcouG1MM1zxPt90HwxBo5dELOThuq4wIWGKm/i2
         DiYYIrK7jDHD/1It501CO+Y9SysMFq67N+Mtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FglzRedEledpe7U/HZFQU5fjwrxpiFTlIoZfizmZKxo=;
        b=KPuD3m0q4LpI+8l7Q2nXxkCMvd3VuptcNYzUcgWX4VjYbki8c41wSLdAveogBVLHBN
         HsdMpywdzVjYJs0DQm3Xp8Onfuqqvck6IX3mvQXKOWnaK/fLMKV3Ayc/jmimeeJQeKMP
         hV6EOnkGcJw7CnnEJR1GGxvNGWigMQ6O+aHmLkRROMPvq8AirLPPapDYZUpKyqjdOlOF
         DZAWx9ep/YWkZ8UuxsE9KJRUrycITfFuPYLa+ptH/5Cj3fWPd65II6nFnicqpW1lxSEI
         9zo7jDr+AidJWDpTugiKcA9bR2iUdwIwIKz7SyuCpLraz2w9Q9S7/KLXrMgEdyKpUHAu
         GfKA==
X-Gm-Message-State: AO0yUKWcgkH2OGEVTSk5dU3QqsVAI0sOlMm5m8KArYSxbY/BW0uYZQ38
        lYTASujX3PlZPY5sdnSP2qBJU53MT2+Z7Eln
X-Google-Smtp-Source: AK7set/Z7WE5Ld13ny7sgCsxLEEjOYX9qnYiq/CIu1TV+5vNxcdynZYDJopTLqfhZ/z5xziON6sH4Q==
X-Received: by 2002:a17:902:c611:b0:194:5fc9:f55a with SMTP id r17-20020a170902c61100b001945fc9f55amr8907518plr.35.1675446854374;
        Fri, 03 Feb 2023 09:54:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b00192b23b8451sm1889641pln.108.2023.02.03.09.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:54:13 -0800 (PST)
Message-ID: <63dd4a45.170a0220.e6dee.365d@mx.google.com>
X-Google-Original-Message-ID: <202302031754.@keescook>
Date:   Fri, 3 Feb 2023 17:54:13 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xen: Replace one-element array with flexible-array
 member
References: <Y9xjN6Wa3VslgXeX@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xjN6Wa3VslgXeX@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 07:28:23PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct xen_page_directory.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/255
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
