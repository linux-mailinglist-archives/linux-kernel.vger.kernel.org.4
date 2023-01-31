Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313F68349F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjAaSD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjAaSDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:03:03 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF90B47E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:02:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k13so15962944plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zF5FBVNGpjtgxLS+bV3TsuLS5czo6abFNJe3eVmeQhM=;
        b=PongnsqZrFWa+7otFndotY2MGP9DEsZFJlPJX5CWuujuLb+Mi8aAXK4tZ6Oeg90O5V
         0j5mZad1meeJgu2FCFyt46ddqs/NYA/3jGvrV02oB34cwsCxrvsofLOBZXpK6AnnTUdn
         KD6pMDzDVzR6BbDCBYhSjFosYFLNRmN/s9R8lVZTlGKhGLSCYd+2rvu+69yT3qCRrhQU
         F97t6zzBXoWhW+VbBFkqHIrkk5lFzMd9O/1O5YtTwAUTtbJumbUhJf/wYyFp+5PRkEgJ
         6v0ghDut1HgGcNed1suhlEaTrdg7ZyT82F2Ll4ssPEhB5Bis51EZj9oYv8PGHaYoi8mH
         2JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zF5FBVNGpjtgxLS+bV3TsuLS5czo6abFNJe3eVmeQhM=;
        b=bCz7shiXHIcyfjOOMvVODwkRj3hC6C3MCF8apUZxe+Lv/P6dOhKQtRaAyz1EYVDnpt
         omdiy6FKzgrs/wx1BEeMZYZaoY0fx7k51CZbqLcbVAB7G1OFkMQANS6OKPjGktFjvHEw
         GpCgLQT/N2iX+XIelBfZbDZcMl9ONWs7Uz8r7nN0c7uabC7LifMWP9kXgkLruiC/Up2U
         +YflOlvZhw+AqotYopBGHcsNN1BJvHVOlHDV+pPKRAqnD4jvsQTv3ng4CTbDP7YBokNz
         3pu15UaPBGorMTsuwibPU8+qcJp7DW9ZsflkZ9GaNWWNlV3fNzeahy6n2CWtykTsxoG+
         F1sQ==
X-Gm-Message-State: AFqh2koH+MkG/lX334pML8mJynLPXIJeIyiO42pxaOz6l5/u/KPl6S23
        YRe5R5D76ZOg7sKbEpL23mK3AA==
X-Google-Smtp-Source: AMrXdXvezqFwgLDeT6M06pfBrzmly8Jw4gE3tWkEi9LAhdjldWOIDY8v0K3SeZi+fLsG8SDpqjSnqw==
X-Received: by 2002:a05:6a20:2d12:b0:b8:b9e7:6d4 with SMTP id g18-20020a056a202d1200b000b8b9e706d4mr16854163pzl.0.1675188175049;
        Tue, 31 Jan 2023 10:02:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z92-20020a17090a6d6500b0022c2e29cadbsm8825260pjj.45.2023.01.31.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:02:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
In-Reply-To: <20230131050132.2627124-1-willy@infradead.org>
References: <20230131050132.2627124-1-willy@infradead.org>
Subject: Re: [PATCH] block: Remove mm.h from bvec.h
Message-Id: <167518817431.121439.15195663136772829300.b4-ty@kernel.dk>
Date:   Tue, 31 Jan 2023 11:02:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Jan 2023 05:01:32 +0000, Matthew Wilcox (Oracle) wrote:
> This was originally added for the definition of nth_page(), but we no
> longer use nth_page() in this header, so we can drop the heavyweight
> mm.h now.
> 
> 

Applied, thanks!

[1/1] block: Remove mm.h from bvec.h
      commit: 2d97930d74b12467fd5f48d8560e48c1cf5edcb1

Best regards,
-- 
Jens Axboe



