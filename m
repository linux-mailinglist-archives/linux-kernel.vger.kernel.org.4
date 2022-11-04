Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C482618E97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKDDLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKDDLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:11:47 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C61FCF8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 20:11:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g129so3314969pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vqS/yz0aw2H8laNC7qyVrEjItnxNWWPJNDD2KyB5XOc=;
        b=ira7ETQhGBo1xK1mfWU+o97eA9SnMiBm//tP8O/hreuUL1grlsaayJwcTYk44NiV9U
         MjlcTXe8CQDguqjrcKQziyBeSNfzFURjrJHSgV9tCqouz4Mz4oXojBmWtwnVX9f7YUHC
         zW3xm1cYFk1AVk1Ts98oqJz+vGDhxbvE6S+MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqS/yz0aw2H8laNC7qyVrEjItnxNWWPJNDD2KyB5XOc=;
        b=I1Ogn+Kx2JUofnx2L5ZD58G6xItCQo3Hpt/H+YVx9FqEGiQeQkJrjU3DlPfXkCWDCY
         qg2/I9ai+adW572l9NvWvcr6R5gjOX2bsKTrg/XUS6YM81mz6MgXsyfp4OuhiHBVVsbR
         atSGiFPPC5TrvHC5TvCqz9/Rr4e3uTWclxBChRsz4Pt5lk7Z6Yv8P6ZDgqcP801rIEhm
         Mpqd0K1069wbkEdRbOY/ZxGu6u+kDdrfsYFRus0UxHu3dNkzj54CBb6VgmQ6Slex/Acb
         5sLO+9unU5TnI+BsJodocTToXxLM6Ms1kWdGkQWWpZ7/qF8oOg6WMZV2qVrJ3THFbtz2
         gWjA==
X-Gm-Message-State: ACrzQf0xPwBRKf/xNyU1SNaWi4hK6mluI+6Y0eFaCzy7zeb4A3i9t00k
        +Y4s3YU9mJhaU0TvFHVuMV4D3bGLS1o4Vw==
X-Google-Smtp-Source: AMsMyM5wBdxcNp6ncALzrrN8eB8FDrP6lbH+A3h+sbG0l48kVb+qEH1X5DQlzVVm7Zlt9rbe3BllCA==
X-Received: by 2002:a05:6a00:4c93:b0:56e:55de:986e with SMTP id eb19-20020a056a004c9300b0056e55de986emr5506341pfb.42.1667531506328;
        Thu, 03 Nov 2022 20:11:46 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ea8300b00176ab6a0d5fsm1424596plb.54.2022.11.03.20.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:11:45 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:11:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
        senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zsmalloc: replace IS_ERR() with IS_ERR_VALUE()
Message-ID: <Y2SC7UMxQq0Vvzs9@google.com>
References: <20221104023818.1728-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104023818.1728-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/03 22:38), Deming Wang wrote:
> Avoid typecasts that are needed for IS_ERR() and use IS_ERR_VALUE()
> instead.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
