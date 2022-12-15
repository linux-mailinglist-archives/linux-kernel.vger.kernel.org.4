Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5AA64DF13
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiLOQ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiLOQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:55:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AEEF580
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:55:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso6509651pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26wecbxeZqysem2kCfPfSfQ1H20+x2gKeuxWkPpxmg8=;
        b=Gq5bD60P4xpIsZ5io6BpMqjE1WBULHLHaYLy1LXIMvLkkx2ogEmPyNDFxDGulZdrWz
         yqvITihxx0xLlJXcmaXAFvkm8CAMTUdb2BJ81Y1E1UBkXUukD2kJ/XYn3EyZc1yJcp9w
         Ko71/Icf0ONtGylu5AUpaBB8Nx3NLW+U8QSWAMuTLPlpjdm7mDyk0YUEJkNVa9eX9ACX
         3SQYx10oiuwVuiJHxI4fXwlbg+9Idib85lD+304i/mZSOi0Y+6N8B6uKb8lKX1I0VH+b
         txRQ8LgPe3riXDqfgGRjpwzqmCD0CKwT/p+Sj670U0z3TDtCLcT7I+KoNsGz+eaHwYRr
         GA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26wecbxeZqysem2kCfPfSfQ1H20+x2gKeuxWkPpxmg8=;
        b=F9o4KuQFtv/MC0JDk1iylL/5zydwhow8ZQtxrxKp471EJyp1pBNWNHt6nM/QE9gv7y
         gVsJNrkN0YtjVixtGzBDjlKwmxsCjkg9YRnhd2OMs5m7F8/pY0GKGga9wDqivN29lmDR
         QbOV6OGpHWso46bIwdfbpAFDAwM0sEo2doEoNidnR9xSoqhu97fR5/6Oc75ezYmpcL6z
         2X7ddU0xTtQXeRhYYPkz44SRjWmm9WwTScSM05Lr7VMhREB10DIyI3gH6QoVL/qyyaMr
         rRUiYRnEc+Nj7q8LY4lzkNA3vyq4yWayFPBB7FV6C9tVBa7jrYi5L4DrdQWuQF591B4l
         hrQQ==
X-Gm-Message-State: ANoB5pm5T4/yFcmhDmgSU0K5nEMO6vJ/5OUcKpEOGmoTl4b2ZtgvpJJ9
        L7nRSXVY8u3J1hgOV/39Gtb25agi5jj+LA==
X-Google-Smtp-Source: AA0mqf6M1Ak1Szoks0KcYUj1nIyvMVg0V/iBWvjN5O6zOnbJ3chidJX0z5PAH5OtAm/f6fHbGPSsFw==
X-Received: by 2002:a17:902:8487:b0:18f:9282:d8b0 with SMTP id c7-20020a170902848700b0018f9282d8b0mr16113658plo.53.1671123346468;
        Thu, 15 Dec 2022 08:55:46 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b00186a6b63525sm4059718ple.120.2022.12.15.08.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:55:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 15 Dec 2022 06:55:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Lingfeng <lilingfeng3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz, bingjingc@synology.com,
        ebiggers@google.com, james.smart@broadcom.com, houtao1@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH-next v2] lib: parser: optimize match_NUMER apis to use
 local array
Message-ID: <Y5tRkKwnJbfwUP/o@slm.duckdns.org>
References: <20221213141755.768643-1-lilingfeng3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213141755.768643-1-lilingfeng3@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:17:55PM +0800, Li Lingfeng wrote:
> Memory will be allocated to store substring_t in match_strdup(), which means
> the caller of match_strdup() may need to be scheduled out to wait for reclaiming
> memory.
> 
> Using local array to store substring_t to remove the restriction.
> 
> Link: https://lore.kernel.org/all/20221104023938.2346986-5-yukuai1@huaweicloud.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
