Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EC66822F6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjAaDoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjAaDoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:44:07 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC09EFBF;
        Mon, 30 Jan 2023 19:44:06 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-15fe106c7c7so17848043fac.8;
        Mon, 30 Jan 2023 19:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDrLZ++5N+sw+ZK0t3EaqYJtg0ZAcMsbhUYSmXTMd7c=;
        b=LmvHYI/hQfhLg3zN+FbsCSdzogdn1isNJ7cfe5A8SziJ0bvJ4vA/w/WjkmevSMJudA
         apTco4buzXOoicguENtP2jyJMpgTCUC6j1qe8i0hxI8vw2ARr+qk5EChICslk6/naHxP
         AUBtIaO8bZ6l+xH2VR+43oyj5rhMi1JATwHEdgbZdE+y+Ig1gNZENTeemB+gHQgYtYPK
         kOzbYf5pph6G88FKH5izbeTA2IalyWJzz0NKvLbSaGgco+g1KKtIO9izbAqHYSI8BYVl
         vTMdnWF/w7wwCK4N6a3PL6VUp/xMxOtIXD4qgD4oIfx70JZ73r/fWu3UvVeq7G1iDdWl
         nM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDrLZ++5N+sw+ZK0t3EaqYJtg0ZAcMsbhUYSmXTMd7c=;
        b=GyZ0YU9T9mx9N9DWM3GfC/BIznjbyftaI8CEUABNkni+J9k26A43IMCo5seVQTb1aS
         tUvW2hdDpZEe/SM3XQ73woTLhD4A8qTm2XqWtWVmXKEZP54lY5v94QUzKBA1KKX1Xfgq
         K6kk+0sXGEwee4OORuTEYUzV1WrH/sU8XuzsCJbg4ywJO8w4DK3WxweBLBh/bjiuCXs1
         ANvF9BkZ2+LOBxYr9tNraUP7b66LX3QhBEzo+QwzvhELb8YFWp07ld5O7zsdVv/5doeC
         /GtPv68LMDkJBIY/0AmOSXqCsrcmZB2a55GHK+LLiVbHJtCWoFRg1UC192uN+8/Pp2oB
         hFsg==
X-Gm-Message-State: AO0yUKXIHiOWA1mSfS3HcdX9GNgH9DjkXSkxpoBY65d9r/x0ZpMVi4T6
        kHn2z/uygbl1ZHgje2FKk7uPvaZGADY=
X-Google-Smtp-Source: AK7set9TAOmFkF7TpbGY6qpBnEzhdcJtoG5aCtcO1Ay+7/w8nDVqK0QsofjJ7DpKeeUGBNXcEhHk0Q==
X-Received: by 2002:a05:6870:b00b:b0:163:98d1:ba0c with SMTP id y11-20020a056870b00b00b0016398d1ba0cmr5136904oae.49.1675136645990;
        Mon, 30 Jan 2023 19:44:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gq11-20020a056870d90b00b001435fe636f2sm6042847oab.53.2023.01.30.19.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 19:44:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 30 Jan 2023 19:44:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] Docs/hwmon/index: Add missing SPDX License
 Identifier
Message-ID: <20230131034404.GA837158@roeck-us.net>
References: <20230122213650.187710-1-sj@kernel.org>
 <20230122213650.187710-5-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122213650.187710-5-sj@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 09:36:46PM +0000, SeongJae Park wrote:
> Add missing SPDX License Identifier for hwmon documentation index file.
> 

I do not feel comfortable accepting this change without confirmation
that changing the license from <none> to an explicit <GPL v2.0> is
legally acceptable.

Guenter

> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/hwmon/index.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index c2b3c1a822dd..2186d732654f 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ===================
>  Hardware Monitoring
>  ===================
