Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB99A69AC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBQNQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQNQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:16:41 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E5639B86
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:16:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jk12so1545742plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676639799;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K0akdtqajPllo5ScKnvujdeLBphCx9T2fsnMIt5ZP8=;
        b=upGVA4Mp117b59Pfk2iccuQdFPLyrCvXYU228PcO3R3/TOZaiVYVlB6gVwyuM1N2+5
         2qSpNc9k0pSgNAEQlD1yRMSClu3hmEV/0hH6BKmqGkl42G+eEI+s+knoEDSj7xZ2l03e
         RiW0hidyLX8LABGkn/l5E2gw/cgGLyvaCHanRVkv4CfZ0a6caLDnnnx5a36UZegnuM8O
         /fdyvt6IoOpXecGTv9BV/ABdtDOAe1JY6xaT0Au+0h71i1ANg8/wOxse9ZjqfzquIB+U
         VNvvAdX6ZrZ5ltbbWBlwNxU7/YDLG8wtK1CBom8MPDeNYUaOUvuHfLB53e3SwgzAx1xz
         731w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676639799;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K0akdtqajPllo5ScKnvujdeLBphCx9T2fsnMIt5ZP8=;
        b=Zh//6+YeILVs/HDr9AaUPTJcSNL9NE1cTHCFAToISr6sWBg5uAKbMnphUzvzXdC54H
         0ZAy7h2mScEf7ibWA58fN8Hb5rSpbAryDNFWgeKHKL9ieCUksUWxb3/al56NkVxPARUn
         tZljd2VGqidhC2LtbiP3WaNpMgRHVR4pil/LxVCtyp7iBYIYkAPqloAbN0tgdm62OCYn
         y02IDTwN1xEO919V9Fbyjih/6uHJx7hrKFZ6yisOWiP51prAzqme4epw7xDdhyGTCCoY
         cCY7z++g7CP3td1zr54m4df3GgyT0/co6vD4yP8u57kXvO4xw6TaQ+hYNyBXvVuvzPls
         nziA==
X-Gm-Message-State: AO0yUKW0NM4jwQHrNHQmNLX9tRUOQbcwe+R+9CCn3PLv4F8oa7GFy/Am
        09Ug9Y2y1lbhDbbBUpzc6qHr9w==
X-Google-Smtp-Source: AK7set/6AZMY7K0y5hGyd8CgV6VexmHNKifzn1k+3IpHscyl7MqBukO9NyOHnlBwrCJ4X1WVFa4Gtw==
X-Received: by 2002:a17:902:ecce:b0:196:56c8:cfab with SMTP id a14-20020a170902ecce00b0019656c8cfabmr1748808plh.1.1676639799097;
        Fri, 17 Feb 2023 05:16:39 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jf5-20020a170903268500b001991f07f41dsm3103259plb.297.2023.02.17.05.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:16:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, hare@suse.de, hch@infradead.org,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next 0/2] block: fix scan partition for exclusively
 open device again
Message-Id: <167663979814.50803.631094084616425348.b4-ty@kernel.dk>
Date:   Fri, 17 Feb 2023 06:16:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2023 10:21:58 +0800, Yu Kuai wrote:
> Changes from RFC:
>  - remove the patch to factor out GD_NEED_PART_SCAN
> 
> Yu Kuai (2):
>   block: Revert "block: Do not reread partition table on exclusively
>     open device"
>   block: fix scan partition for exclusively open device again
> 
> [...]

Applied, thanks!

[1/2] block: Revert "block: Do not reread partition table on exclusively open device"
      commit: 0f77b29ad14e34a89961f32edc87b92db623bb37
[2/2] block: fix scan partition for exclusively open device again
      commit: e5cfefa97bccf956ea0bb6464c1f6c84fd7a8d9f

Best regards,
-- 
Jens Axboe



