Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12154699BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjBPSF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBPSFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:05:55 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560A4D626
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:05:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id j12so711394ila.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676570754;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIsYWDtVn/3TTL69Bzc66uketslFLcUy54JhmTT+JsU=;
        b=YDfyJNlJhFuVsi5yF2knqnejDfZKEcdNXMoVthiu5YT4Pt1MAw0C1kGdMiEujqgeCz
         2ckOnKfiI5V0HtfMoBQ/rosBX4a29a/aq/qEKyZhKHfuTo5sdJMVkcBZbLXVofE0YoV1
         jLl7f6Ddiuf9t4n3ujCJ9OiWbg1F4q3WWnwiAvJh6rVL1Ih6FkjyL/Y/XEd26fx7ibLP
         3G1IUmu2eBDn5BWKq5zvdFWJeh/CGYLyGAPBThKF94qanJz75EYrIkcD4IsdCWgTbCV6
         8KKySpD+LI0jztCN8kW410aNWpvYIDH6KPx/zRG5F5L7/657CB0w1IIwbDT4JKfkX5DE
         zEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676570754;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIsYWDtVn/3TTL69Bzc66uketslFLcUy54JhmTT+JsU=;
        b=6LsdfZ2pbpaiKCH+ye2sm8XoDBm68Afh1GoJMnA7fx5q3GpnRmA4L5Ri8yV9WFqT2Q
         BpUrGCR0zeB8boK9W/5p5NSWXIeRYtCnHO6YvCBvKDnjb4Oy++OYKeL6hVgF3KnnOeUB
         8OJ/S2OgWIKnxSw5UiskFfjtvPrT5Kqvmvv2/I6QitSfZPnmeexbH28LaVaP9Rr2BRlD
         3k5aPC6YQPAoWp8tjR0etbG2XrJ5TrzWqkPgSeALCUcC71aR7oeCD5Duuovmj+9shPTF
         bvzyWcz+T4Bod+eWAdFFfwfYeL+EiKLMFswJSDS0KTTAOA87OaDfWW6m9YXH3K6aItla
         BrDQ==
X-Gm-Message-State: AO0yUKVdphdxmX65U2F8fiI1rlM1YDArfck/ERobs5ecdA/gXruJ7JbP
        ID0XvHvxQDKQnGS1x/n0OEHBKaXQ7p+YjrPt
X-Google-Smtp-Source: AK7set/qdcxpQq9vu6N4oQCRsg1sP5mrb5w8zI/Qkzuj6zrOvq0fuQLc14NaSHZt3EBSFonMmbLvsQ==
X-Received: by 2002:a05:6e02:e0e:b0:314:16ea:103b with SMTP id a14-20020a056e020e0e00b0031416ea103bmr5455498ilk.3.1676570754273;
        Thu, 16 Feb 2023 10:05:54 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x12-20020a92d30c000000b0031406a0e1c0sm613738ila.57.2023.02.16.10.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:05:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, Jinke Han <hanjinke.666@bytedance.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev
In-Reply-To: <20230216032250.74230-1-hanjinke.666@bytedance.com>
References: <20230216032250.74230-1-hanjinke.666@bytedance.com>
Subject: Re: [PATCH] block: Fix io statistics for cgroup in throttle path
Message-Id: <167657075356.383926.13498048587945400623.b4-ty@kernel.dk>
Date:   Thu, 16 Feb 2023 11:05:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2023 11:22:50 +0800, Jinke Han wrote:
> In the current code, io statistics are missing for cgroup when bio
> was throttled by blk-throttle. Fix it by moving the unreaching code
> to submit_bio_noacct_nocheck.
> 
> 

Applied, thanks!

[1/1] block: Fix io statistics for cgroup in throttle path
      commit: 0f7c8f0f7934c389b0f9fa1f151e753d8de6348f

Best regards,
-- 
Jens Axboe



