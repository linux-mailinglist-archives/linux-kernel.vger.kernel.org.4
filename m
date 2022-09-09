Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F655B31BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIIIag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiIIIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:30:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B83CD474B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:30:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t3so1139457ply.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Ou6wa1PVBMpfkqq+3IOtn1cL4mqN7hg0CTIQr6+JHrE=;
        b=k29S8AxGMHFWQb8aV9I9jiOP+bcF2zGv0IToTdNBof3ybIaNO4T6jnm1tS6/8PRK5h
         3d/fYkpeUDTrLk8Ce9Pq4l80ZF7UWQlvgqCy1KGM7ZC2+o5myGT6mfr6UnHP+3Dqp9aA
         JUz/khEdoZI7lF6+uXIfRouWlO4OLPMQC8HPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ou6wa1PVBMpfkqq+3IOtn1cL4mqN7hg0CTIQr6+JHrE=;
        b=HAsQa0eX1dl55EG8FXtlsdDkk7y0jZDwyfN9P27O9aT3s8f0FlIEuOSxJOLxYns3RE
         XkFJ4n7g6Z4oyS5NCIbANzYqhPWlKkepXAS7BTyYH25Rmw8F5oX/MT7iX9QbL7O1iCiF
         JG7XYUSOKj1xPTTT5q499BwEhdQheBgSHWSIhMxv9qH8Khp9eg0XkubOiJAzcQV/JLeS
         kPitA8VN+I8sXCgMrrZUTrur5/2ZldiY2JfRygHteXZu/m6uxprnuyE9ElvuWaw5ohyv
         8teKdipeMy2iaOkAGFS+JfpSdfraM+kU+QQvqD/E9mLeGEK5HufLFMzk0rvSxTmvYeMR
         47bQ==
X-Gm-Message-State: ACgBeo3VKUAGIYSHcduGkt3GnyCu2/scJ7t46mh1qnSshKxKg+JHUrmx
        gXkAbYyOF8siL8L5XKpfEmyxSQ==
X-Google-Smtp-Source: AA6agR4REQKERpKP0UCk9dLv0Tcg8I1xeCZhKyCdHUjFT3qh8cSkvjXT/9g5ibSPuPgdd7nAKJ1YNQ==
X-Received: by 2002:a17:902:d58a:b0:177:f86c:4456 with SMTP id k10-20020a170902d58a00b00177f86c4456mr5545162plh.171.1662712230384;
        Fri, 09 Sep 2022 01:30:30 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:48ca:975b:3395:bf])
        by smtp.gmail.com with ESMTPSA id e125-20020a621e83000000b0052dbad1ea2esm1054354pfe.6.2022.09.09.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 01:30:29 -0700 (PDT)
Date:   Fri, 9 Sep 2022 17:30:24 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Rom Lemarchand <romlem@google.com>, linux-mm@kvack.org
Subject: Re: [RESEND RFC] zram: Allow rw_page when page isn't written back.
Message-ID: <Yxr5oNaCwjn8cdFF@google.com>
References: <20220908125037.1119114-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908125037.1119114-1-bgeffon@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/08 08:50), Brian Geffon wrote:
[..]
> +++ b/drivers/block/zram/zram_drv.h
> @@ -50,6 +50,7 @@ enum zram_pageflags {
>  	ZRAM_UNDER_WB,	/* page is under writeback */
>  	ZRAM_HUGE,	/* Incompressible page */
>  	ZRAM_IDLE,	/* not accessed page since last idle marking */
> +	ZRAM_NO_WB,	/* Do not allow page to be written back */
>  
>  	__NR_ZRAM_PAGEFLAGS,
>  };

Unrelated but somehow related.

I wonder if it's time for us to introduce a dedicated, say u16,
flags member to struct zram_table_entry. Unless my calculations
are extremely wrong, we are about to run out of spare bits in
zram_table_entry::flags on 32-bit systems.
