Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E646567420F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjASTFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjASTFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:05:17 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6448951A0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:04:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 12so422052plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lK1NIKrkWSVJySo5ySVaU+O2VgoLfd/S7FGV0rSbQ74=;
        b=QTn+X4kDogFDm06PTrlrVc2vNfFhO2XlOJ0qiZo24LxGEM/89sltLSXVJzttDD/cGk
         3ukNWOmfhe/7vdx/GMmJB1g61Nhhjyjos5lKhPMPKRrnv9RLNclDtHFSUbcxNdM0nFvE
         xDxJabbKiVPzKOnx37qj+i3cHJaDQwNVsALkIHCrY1yttQxxc9Hh/Z0uvgy7E0GTHsau
         7rCwmHJCgp9cPQbyX5wi6Ix9uXT6TL61jopXBLtm/Gfb4EexW9GREra0c8lYwRblnS24
         3O4jfs0GRWqYTOZ9wpswS2DBS2wFSHHjFeaHgq8Jwz4+iSKRslqQOHp6LNMN/WPaAOK2
         CPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK1NIKrkWSVJySo5ySVaU+O2VgoLfd/S7FGV0rSbQ74=;
        b=nb67/6ghPeLqvRHzGp8pVjSinDsieLn3EKrwvhki44fvAKultuP6Huoz8lpAO2nKgn
         BZdxkahMAcg6k9WEU2+6A3TRQeyqMw34RDoZ/skt3qjbJWXWSTJNH4z0H1xv2+TQ78K0
         +C9S6UFPPBydHRjfoyarUvhgMDSZkp13hmAUMqByTJjHa5ffqfMW9BjiqdaCTaqSfIal
         8BYbIKmWo2bQyPTOoI3nsiyIs2Kr/ZGQnE8ZxMgdpTmJNKa2E9F2C0YvHIWIwkHFZAPp
         P8Bn5gPIGikD+iPOGQwQ8wtnrUCdyUMPEgNE+1d0/qoP4Y8Km7iDSjxURkzQIhafsc49
         bJBw==
X-Gm-Message-State: AFqh2kprPDToCtpk/P8NictJLGRwzRj1HIX06CK2S5cPQM5sDke2B0TY
        v6gUD5LcPOVsvdHibH64eJs=
X-Google-Smtp-Source: AMrXdXslOK1iyghyiIbtzl9nS5k1IBppvDOwu8D8IdCN6zSPqWlgTe/WgBiH37ZjOqCXoTZjyMz40A==
X-Received: by 2002:a17:90a:3cc4:b0:225:d450:2ccc with SMTP id k4-20020a17090a3cc400b00225d4502cccmr11638474pjd.30.1674155026269;
        Thu, 19 Jan 2023 11:03:46 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q99-20020a17090a1b6c00b0021952b5e9bcsm3364479pjq.53.2023.01.19.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 11:03:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 Jan 2023 09:03:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Lingfeng <lilingfeng3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jack@suse.cz, bingjingc@synology.com, ebiggers@google.com,
        james.smart@broadcom.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH-next RESEND v2] lib: parser: optimize match_NUMER apis to
 use local array
Message-ID: <Y8mUEL3VrizxFika@slm.duckdns.org>
References: <20230111042215.4120156-1-lilingfeng3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111042215.4120156-1-lilingfeng3@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:22:15PM +0800, Li Lingfeng wrote:
> Memory will be allocated to store substring_t in match_strdup(), which means
> the caller of match_strdup() may need to be scheduled out to wait for reclaiming
> memory.
> 
> Using local array to store substring_t to remove the restriction.
> 
> Link: https://lore.kernel.org/all/20221104023938.2346986-5-yukuai1@huaweicloud.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> Acked-by: Tejun Heo <tj@kernel.org>

This will fix a sleep-in-atomic in #linus, so it'd be great if we can get it
merged. Can you please apply the suggested changes and repost? I think we
can route this through block too as the current breakage is there. So,
please cc Jens too.

Thanks.

-- 
tejun
