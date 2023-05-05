Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A589E6F7FB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjEEJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjEEJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:16:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5F5191D5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:16:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so15269265e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683278187; x=1685870187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8QM5puJROCr66b4Sdd07Ua1MuyFEDfA7m/IRGmTO5I=;
        b=ZqazEs3gI0yIF4d1sbz/+w07uVVu51V4eFrfD/ea8LUczOqIJp7PVSD9Btj04Oo9gQ
         JVNsu+M0X5qbSqSTNB08nOHUCoRurSJpEawAYWeQSbUhBlMGS419CS8Bz2oIrj1RFCIv
         ORhiZEWRykAh8Tq0NJTlxvnGPPmwlSpGQzrtIzvXCPOg+FZvdXRKzSEmgE2Y+4KLWk6f
         f5E+rHkTOfV0iiWefczv/4CmIDYnYif2ltcqJ+viEZ0aIvK08ciLV5otxFw9GR7dLXaB
         DoSXpiMirldQKiHg7JoTdilS/5ugdEFqM4FxMk/Ry4NoE/EpxU0vAqTnfbV3o97ne3pU
         IqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683278187; x=1685870187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8QM5puJROCr66b4Sdd07Ua1MuyFEDfA7m/IRGmTO5I=;
        b=Vd+/46Jt3edo/D5gdGCF6SKDPGckmR3B3hPftEjLHUqKBN45Q1p0fQbrs/JhtfqtGO
         ZNS1KHboqzp8hXoQSUyxjqOaqej638da13Jc5UsRbFCc0uB/6RT/LZGBb16fX4kYqcjU
         oEcavbsCkwH8AkQNwz7whLyC3RxIV0Gx1Sxk95HCJJHZPYbOYEsA+J4v8qEl7Ql3ekWZ
         bheFEnSHJRGrYKFcCpuG8pyzy8aInc2vJadkgD5G4T7mJ7TBliX5/BQR+8CASZXORO2V
         He4TAHl0LTS4cm8neev2Int1+jnuV+5IXe2mZKOpizb3qaPii9ICVkW8awMw+0udLiiF
         JgYw==
X-Gm-Message-State: AC+VfDwAFFnZ5+mNefxbqpF3TxnIoS0mcLJ2KEDMYtkFkH82Z3018Wd5
        U2fTveVVtKX7hsx4cTqHnzaIJg==
X-Google-Smtp-Source: ACHHUZ4B4N/FxcLqEkR6agepmE+jWYp6diDS8oVzqu4M9U5OQSZG+yuRxLBahAeE3t86XU17oZxTyw==
X-Received: by 2002:a05:600c:d7:b0:3f1:9be0:b39f with SMTP id u23-20020a05600c00d700b003f19be0b39fmr573250wmm.8.1683278187357;
        Fri, 05 May 2023 02:16:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t8-20020a7bc3c8000000b003ee9c8cc631sm7275167wmj.23.2023.05.05.02.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 02:16:25 -0700 (PDT)
Date:   Fri, 5 May 2023 12:16:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Drop DC395x list and site
Message-ID: <b86a4837-3c31-4bf4-aff3-67abd7a4f5f2@kili.mountain>
References: <20230505082704.16228-1-bagasdotme@gmail.com>
 <20230505082704.16228-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505082704.16228-2-bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 03:27:02PM +0700, Bagas Sanjaya wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bc223f3053b..35de3289a8af04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5692,10 +5692,8 @@ DC395x SCSI driver
>  M:	Oliver Neukum <oliver@neukum.org>
>  M:	Ali Akcaagac <aliakc@web.de>
>  M:	Jamie Lenehan <lenehan@twibble.org>
> -L:	dc395x@twibble.org
> +L:	linux-scsi@vger.kernel.org

Other people do this too, but is there really any reason to include
the linux-scsi@vger.kernel.org list?  drivers/scsi/ will already
include it.

regards,
dan carpenter

