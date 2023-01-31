Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839276830DE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjAaPGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjAaPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:06:27 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED9539A7;
        Tue, 31 Jan 2023 07:03:42 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so1071076otq.13;
        Tue, 31 Jan 2023 07:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsnDPQM4B0QKOQ6uYZT1z5VR6q1vjdQ5vLL7x8NaaD4=;
        b=Xpq2kQptQht2RH7BxsFGtMCYL2ip5WMVlqOa/K89moYZkrzjSpazUIwQSl7vVhBz4W
         yCaGemw9AQjR90Spg2K4+V+9Alekp+nDQ4SmPo7Ak4vSOv/HqHc8s3pyttxLNF+Wp6a0
         Di6A94ytQU29+MTeNu5G6N+OGn88ZW9mChc+3aTLXLWSBB0EWeYuU/GETx2h263bfKGQ
         eKXtnfrGSW0YNHqy5oY2KneFbmm7aNfPjEOO9/lRXoA+RfKNC518hgEXQn8Kzqh36Tae
         nd+9sHZbCTica68sIXECUQGPRxywWV1JxeiJZUulXfSToHP9+UMhuMnmRwZlawJHLC70
         6GKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsnDPQM4B0QKOQ6uYZT1z5VR6q1vjdQ5vLL7x8NaaD4=;
        b=mGfXXEYg1Ksva7QutSVPEpnICBvr/UzycRmjgDEDQd3L/88zGKUHO7ELnJBDJLlMBE
         ypaxSmSVS9VQRv0FJLgzh5QeLMej7DANK9PKQ6g/BtyrY55B9UHeAWrAhgTv2d0xsKkT
         N/Pwo2L9i5Mt8DZwrOnLfq3H1D6oyfBDW2tYOhNwvHDj8RATPoWynM5TP8d/aRrULUpB
         ThGVU3Zr57oACWHRt85NMfPPPiFhbe9jxRTMcmhOgajx3FkPsvd61dgJ1z2iZt7nZZ0s
         4czwfQBNBBjV5bWOuAypLISf+CpX59JMRGhJ/H1ITiquPz/V5nM0WZ4yp3oCbta6Z4L+
         S3Iw==
X-Gm-Message-State: AO0yUKXw+xba1x01fzcVH3fu0EZm9OqP/ycjLltIGfcuzZ97kNzWIcw5
        LryG18NdA3Q1WWeFi7I4CCo=
X-Google-Smtp-Source: AK7set8NCDNMemSi5MBtRJlA5xcY1coTxXR2AN3JhWwcH5EDNPI/P3gDYJFtH5WfjyNSxePBqlHWfA==
X-Received: by 2002:a9d:1b4b:0:b0:68a:bc9d:f245 with SMTP id l69-20020a9d1b4b000000b0068abc9df245mr10041725otl.6.1675177323141;
        Tue, 31 Jan 2023 07:02:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6-20020a056830134600b0068bb36e8c22sm5101249otq.39.2023.01.31.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:02:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 07:02:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] Docs/hwmon/index: Add missing SPDX License
 Identifier
Message-ID: <20230131150201.GA3591412@roeck-us.net>
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
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

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
