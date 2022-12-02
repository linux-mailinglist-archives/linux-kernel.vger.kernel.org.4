Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3955763FD9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiLBBXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiLBBW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:22:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0375254442
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:22:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so3808715pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 17:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfArFpI4a8R+b20KyasbiTdOtc7N2bQ1wdu7RJkkhko=;
        b=Cb8jMoLSfDnJGI9Pp33XdZXlJvDDfcMbz3oDrUJLziJarvhGWpFLrKZAAyoLNDVtvx
         jqO7+iWRdzqJYKLL+CyQgt6GEH8V/G2frXfIYxVeR+1FVT5B3jdhcvpTsUvVkUl0N3oD
         8TVFe40JPZgJ0fBFDt3dE7RRExTcSYjq2Qno38tbDtL2tX0VOwDTUgtoOE6hd8w0W9VZ
         n5ELhE8nZFhNtEkn0tPxZhAEjfHMWPsspeJVxt10lkJX4smRqMOpQRfgvF3CMr+YoMk6
         Ityq+JjMXg85AJcC/vWX5CPFwE/KMKTJPXVgvGeQGc1KyaArklIMAo8hRNPezrSGfNfk
         4j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfArFpI4a8R+b20KyasbiTdOtc7N2bQ1wdu7RJkkhko=;
        b=rCG5pxKNgopmvV1FMobyf7XLdf8vAjqFhz37fCFVEDG7LT5Abk1MnqlzE5hHTiMsT3
         Tr98NuGRFrpd28pFcE129+8Rz19U4b4qzErdbuLUPKyWeIgZ5iI+GrUTOcM8VxrZxEFI
         /Z20ItOs3Ge5Q8eSWQfudPx06LTAyD8D/uRbEIHb/PEMdpPyPC48LXPw70gCWthS4qAE
         q9MTOcr0NhB0IBV6c2D0TI6zYIxB0+5XWaSbiMWL1jHvfmjh6ChJ6j+z0k/eMordOntP
         mRPsrkYd8bO2RY4RwbhEu+N8dUSx1bBuyXcuBgLluBmvHDz/1QuiNz5h3lx5u1+Z09aF
         F6JA==
X-Gm-Message-State: ANoB5plLDEKzjHBaZy3aA0V5vUT4S8pLL1HtYqWk7uNsD4mMRipCrSz2
        7LJHtlHDdVWgGJZQP40hLAQ+LQ==
X-Google-Smtp-Source: AA0mqf4SlVzbyxVzO55poMNBTlzJ3qqx67RwC/iohUq/55qYNicOtE463AWnygQojnZJv6xU4RxfoA==
X-Received: by 2002:a17:902:f7ca:b0:189:a884:1ea0 with SMTP id h10-20020a170902f7ca00b00189a8841ea0mr11088540plw.92.1669944175417;
        Thu, 01 Dec 2022 17:22:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b00189b2b8dbedsm2282448plh.228.2022.12.01.17.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:22:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Cc:     josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20221202011713.14834-1-yang.lee@linux.alibaba.com>
References: <20221202011713.14834-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] blk-cgroup: Fix some kernel-doc comments
Message-Id: <166994417436.875585.12360362062569377229.b4-ty@kernel.dk>
Date:   Thu, 01 Dec 2022 18:22:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 02 Dec 2022 09:17:13 +0800, Yang Li wrote:
> Make the description of @gendisk to @disk in blkcg_schedule_throttle()
> to clear the below warnings:
> 
> block/blk-cgroup.c:1850: warning: Function parameter or member 'disk' not described in 'blkcg_schedule_throttle'
> block/blk-cgroup.c:1850: warning: Excess function parameter 'gendisk' description in 'blkcg_schedule_throttle'
> 
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Fix some kernel-doc comments
      commit: 1d6df9d352bb2a3c2ddb32851dfcafb417c47762

Best regards,
-- 
Jens Axboe


