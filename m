Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4061173D141
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjFYOBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFYOB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:01:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBCFE4C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:01:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b5585e84b4so3051575ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687701684; x=1690293684;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81hUfeigYJdMFcea0oHNmqYrI7BM6QQbtVqGrjtpVcw=;
        b=omJ60U9Qa+EzsyrYGCEYVm7rpu9bSuvkuuFwvdy+o9XQXcz6Gn3wNKLQoPwPsKHU/T
         LLEcea6iFpOYaYujaAt6zQv2cjHlvilSbazMzJSb2CPn2Pd+FS+Z/jkXf/aZGYkmCeVp
         R4Ox3wKFBv73f8gYU1G+ATs/2DFRCnDjCGHvJ+fAhIh1JER2+kOFZTQILWhlWkjyhhMD
         uqR+oPbHY+cTdQW0Oz3aeMuZGTHDjhCadDMaQEhQgKaCq/MyUyo0Jrh5cPAvN5a5uXJl
         NorS5USW7yLstX0sh3xaEPnAso4GSPACcMW7/zF73tdc331xKHrHks1xVMLafI9kzziR
         ykuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687701684; x=1690293684;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81hUfeigYJdMFcea0oHNmqYrI7BM6QQbtVqGrjtpVcw=;
        b=kutb8+cOgCsNE1Txb7Hk/EX002CWus+rOgGonC0PYQo3lG8tnT+VbzVzk6DpODZmGr
         /KbuUSY9L1OXUDrz7HYMX0koII4RBaI9TyJ4Fu34RvHgunKgvI+E4YsfvatDkc0pooLd
         9GVpIfgws4UOFP3r1UvorwH+p4tLWvGDxf1sQMr9PeahxoqIOdOaZGv0rlySztmhrl50
         48YHQXqG6JOAEStFpg/jKWFXKr2f4+XzRO58yDeyrYmDxbsWbNrytJ/sN2lwOegVj/8q
         iQhsbQz/osNgiEhu+uJzvO+vLjyh/3DuPQOcC89Xt5FaLIqRyBaAwTX7uzb/Cx6BDj5j
         BgRg==
X-Gm-Message-State: AC+VfDyY+ehLv+7Rzm4BdEmtGDDMhx4VAPAo7ik2fAfgLSRIfR3jZImk
        k1LALILvs9liIwj5B1VbPNdhZA==
X-Google-Smtp-Source: ACHHUZ4NtXmYjXC6gk6M/Zcmg980PXGb0bbhzuMJ95KyNK3lhIayA5GEmmuIejXzrzN9S6JbCAmIfg==
X-Received: by 2002:a17:902:d489:b0:1b4:ddef:841e with SMTP id c9-20020a170902d48900b001b4ddef841emr32828094plg.4.1687701684393;
        Sun, 25 Jun 2023 07:01:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w24-20020a170902d71800b001b7fa017498sm868215ply.124.2023.06.25.07.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 07:01:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com,
        Jinke Han <hanjinke.666@bytedance.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrea.righi@canonical.com,
        Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230507170631.89607-1-hanjinke.666@bytedance.com>
References: <20230507170631.89607-1-hanjinke.666@bytedance.com>
Subject: Re: [PATCH v3] blk-throttle: Fix io statistics for cgroup v1
Message-Id: <168770168286.14597.14477909506148885094.b4-ty@kernel.dk>
Date:   Sun, 25 Jun 2023 08:01:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 08 May 2023 01:06:31 +0800, Jinke Han wrote:
> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
> the only stable io stats interface of cgroup v1, and these statistics
> are done in the blk-throttle code. But the current code only counts the
> bios that are actually throttled. When the user does not add the throttle
> limit, the io stats for cgroup v1 has nothing. I fix it according to the
> statistical method of v2, and made it count all ios accurately.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: Fix io statistics for cgroup v1
      commit: ad7c3b41e86b59943a903d23c7b037d820e6270c

Best regards,
-- 
Jens Axboe



