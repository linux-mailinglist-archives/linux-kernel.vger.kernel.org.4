Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C19688D71
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjBCCyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjBCCyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:54:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2455DC0E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 18:53:59 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id hv11-20020a17090ae40b00b002307b580d7eso107191pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 18:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKcitvSV09o42eigXh0NMo+0hVPhVTCx5CVz1DQckyQ=;
        b=JlIAI0RvRCC4ghb2fiRnFrHb7gdcJwVo9mgzNfrb7yueol3MId7aje1N+JTKXUw82+
         giokA5gODrYDKkGxaUPrG8Xa3EpNgf3l2R9YCs23ZOOXT0s7By/z0RAxjxPpabqO/tKe
         qdQXGYEaHDpOrZDduT279D4IPUw4zg7hYcVbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKcitvSV09o42eigXh0NMo+0hVPhVTCx5CVz1DQckyQ=;
        b=2vxKBzdBKxfA1IiX8g+KyKeNVtBqtpe7GX0OK1j7EMGeQx3NDHU6/eOXJRCqDBLBv7
         6GjaUyswbEu8gf4QHLo1EUlViylRg53yGrMFcYrSDzDpjF/EXuPZfMnb5cfefmXs7mxS
         d4n0xdVE4kx/1krszENhMBVsZZNGyauFFwbMimCzeRPYHchMVs98Jcle4gMxKWEQ5QlM
         7EJlq4W3Ajv12y0WLQoTOs1MaZqrOXacViv0Ry/KQi5eOzsQxELNqxLU39FfHE8+wb1+
         P22TNPy/A9uBJwGx9OUmyIBm3bG+/sP9PkwXtCb+62Y2FMSsu4Xhw6T+tTgYWVe222sq
         8Zkg==
X-Gm-Message-State: AO0yUKWuTSk1Gw5Y/mRsiPgVzPOL7Ei6YxcRmaYjZmbQS8vfE0V44W/v
        AM0JBqZ2yWV/5y73VJuBKNP+qgFSCYBUj2KL
X-Google-Smtp-Source: AK7set9/8Uv9kfhqyLm6y6aqVcv/yodJZocL9g9BQ1NdwbjpC11vFhu8gPhLeYUzOz4ehNGYzhf3tQ==
X-Received: by 2002:a17:90b:3881:b0:22b:e367:9b2a with SMTP id mu1-20020a17090b388100b0022be3679b2amr3479880pjb.44.1675392838942;
        Thu, 02 Feb 2023 18:53:58 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090a280900b002260cff0b2dsm217286pjd.26.2023.02.02.18.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 18:53:58 -0800 (PST)
Date:   Fri, 3 Feb 2023 11:53:53 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Chris Down <chris@chrisdown.name>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] kernel/printk/index.c: fix memory leak with using
 debugfs_lookup()
Message-ID: <Y9x3Qe5zATCXrbnN@google.com>
References: <20230202151411.2308576-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202151411.2308576-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/02 16:14), Greg Kroah-Hartman wrote:
> 
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
