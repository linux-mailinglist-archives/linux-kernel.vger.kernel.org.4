Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8DD62AF73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiKOXcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKOXcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:32:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8E959E;
        Tue, 15 Nov 2022 15:32:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso705918pjc.0;
        Tue, 15 Nov 2022 15:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgz5o5DfbV3xr4Xq9yVshHOHM8PL4ue2OQGWIUkyU1s=;
        b=bvYH+xNXVvSAx6vKiudIS7G2gSJ2PXBec57nPAoCI7pb8hJJVorTvTe5Db4rDHP767
         0n9W2FIPaIYlx5/n/E3ALoMcbBc75QD7im8Xau1UITFiysk7f05bXYx7pfJRtEkec3SP
         Ho5R/aC2Yi7x7mnwtf7e7SFceKI5SJupC16pBGjlJvfrtnt5eYRs054Aqas/cB9A7Sbo
         ePWdhJaWPzkbfp49I9NvV3T6DypSO/ZcLa3fHE/ThfoMKidxs6M9DagoDpaVVtyyfsUl
         AgwZLLk3me+xp+Zqi2wWku4Yq10ZEGdRkjPCv34ylfieTD+GFlM+SxcHEk3E2wW2wwvm
         +wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgz5o5DfbV3xr4Xq9yVshHOHM8PL4ue2OQGWIUkyU1s=;
        b=J/qfq3RqCpgGKtU4h6tH/TFlbRaf2wBCSUhLWqcG2aZpiskqBwjLTzU0qPJw9VF7jj
         czDCaUdpLkR1TPfouRF16L1YQktLa6gOOZof7o/n5MhQYBMbqDQL5F1Vx7qBOIqlzR+1
         feJUaoI0vT3ZKkRC+B7E4mNe1ZA9pxQLR72VwBJ4zmBQxjVNkNSj4Hx9rXcNxYiGRo7Q
         hCvw/oBGCi1g5sBaYkPUjkGiDteP9Io9tdMECkChRcJj6FqZTYZJjQtBpcHE8xbSbOEi
         OIv9RjCIYcnci3uDzFpZlSwKHLDQFeT1Eo0i9sZ/uHTgnTvuNhQPNQQMAysWxR9UXjBS
         klKw==
X-Gm-Message-State: ANoB5plaSqgfvgQpNxW2c0s9qsY3F3CUIMble2LbSWwUDO5mld+g0T7S
        kyNXebECjYF5RtP05ZGE3vs=
X-Google-Smtp-Source: AA0mqf4ULM0GXAw7L905+KueIktR4Owb1uKikfXE00JzU8UHVdytaYIkBI6dzOEscrtWWbNl8x2LfQ==
X-Received: by 2002:a17:90b:3756:b0:20a:92d2:226a with SMTP id ne22-20020a17090b375600b0020a92d2226amr746946pjb.155.1668555168942;
        Tue, 15 Nov 2022 15:32:48 -0800 (PST)
Received: from google.com ([2620:15c:211:201:6ff2:4caf:5d97:1932])
        by smtp.gmail.com with ESMTPSA id b193-20020a621bca000000b0056ddd2ac8f1sm9351873pfb.211.2022.11.15.15.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:32:48 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 15 Nov 2022 15:32:46 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next v2] zram: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y3QhnpQQ/y58XyVh@google.com>
References: <202211152004478289568@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211152004478289568@zte.com.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 15, 2022 at 08:04:47PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> ---
> change for v2
>  - realign params of sysfs_emit().
> ---
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>

Recently, we added one more stat is using the scnprintf in mm-unstable
tree? recomp_algorithm_show 

Could you also change it?

Thanks!
