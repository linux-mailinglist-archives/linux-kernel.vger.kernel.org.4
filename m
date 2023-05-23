Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77C70E74D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjEWVZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEWVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:25:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE1FA;
        Tue, 23 May 2023 14:25:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2555076e505so202713a91.0;
        Tue, 23 May 2023 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684877105; x=1687469105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5BYMWhz99ct1BVJqftSROHmQJIifrp7cLbNcxKiOt8=;
        b=NOf4c75/pXtCoI04Z7ozZU7to5hRCvzPdhpIFzwLn5/Aoa6VP62ntByUtTZE0bKvq2
         MxFSGkzim8yx7i+yDSgWmmhLglZOSSp76yp3bTRx5dCsF7ewX5nLVjVl0wmh6qOJKLyk
         unRRbWJC8ze0jEqBpFaZ2xZScz6mukqYZ8VmFHQxz4NTcDieTToYp1PbHtSFsGNjyGGm
         OWmJ2gMn8vBFNkOsGv5LzZuyesGNLtpmQd5HoKx9N34CpuSDbA60X3wS2vjLVBvokexw
         FJEGkd6YxyRwXM1rj/yZPl5qEImpqGtD1eX4dQ755oBEUgTJ3627G7KyXwcWo6uIUfMI
         mcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877105; x=1687469105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5BYMWhz99ct1BVJqftSROHmQJIifrp7cLbNcxKiOt8=;
        b=U1DirLro9K6dJdr8Hh9OFDYeDop5O4AF1T46Ot+upjtNyIcq90NOlAUuvk3xYIhiuU
         64t8+RHWAwsFLCYXI7t/EZYNSlnLTq4WaRpMb/NJia3ucyDc7VIriwKojsopppBT65I4
         FW/tbML/71JvGmEvO4CCT3OfLHs6fl9M0wY+MrZBIHbtZhZ7VwQpc9gLmGe1fQR5zO6I
         p+vq6a3P2kf/MNi7xsvzqab+VyKeVLJ8+MpaAIC/lMk/ecGLjijTle6thyTDEe7BtroV
         lR5YBDjN88p7Im15l17y1S90YeJmNY6cn9Afg/xlp3WbuvgZcblEYD4v58Sla8/jXCyl
         lElA==
X-Gm-Message-State: AC+VfDx+FBEHDPFec3YBwepKnTHZDJLs9khxNL3e5mEEndNb5eCPevWI
        oGoxK3M5bJpEWUcBT7q30NDjA2fdvUg=
X-Google-Smtp-Source: ACHHUZ4sEiXIC33OUovdcQu/CVTLLP+aqQjfG9eBiIxzP4xKmrwWvY5ptAtJshd2VvXgb49Sdl8u6g==
X-Received: by 2002:a17:90b:3555:b0:253:3b2b:2a3 with SMTP id lt21-20020a17090b355500b002533b2b02a3mr14014355pjb.43.1684877104523;
        Tue, 23 May 2023 14:25:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7a1e])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a348900b0024df6bbf5d8sm15643pjb.30.2023.05.23.14.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:25:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 May 2023 11:25:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 04/13] media: amphion: Use alloc_ordered_workqueue() to
 create ordered workqueues
Message-ID: <ZG0vLsNOf7nhQB6W@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-5-tj@kernel.org>
 <575f58b9-cf30-a152-8909-7cd827e4cc70@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575f58b9-cf30-a152-8909-7cd827e4cc70@xs4all.nl>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to wq/for-6.5-cleanup-ordered with the suggested description
updates.

Thanks.

-- 
tejun
