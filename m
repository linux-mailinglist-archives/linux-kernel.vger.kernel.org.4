Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BEC736D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjFTNUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjFTNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:19:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC90B1BFA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66872dbc2efso759334b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687267104; x=1689859104;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGyDV6BAlg2AW/b3jzXgRhCmGRr6ZLpwHtOc10fjN3o=;
        b=j+JSnZaHENkk6/gyOUztdn3Bz7GVJiGgbR2rn91th1p+H5cIq6OskGo/CrHrzH9r0J
         3Q1kk3beuF8Ihyxzi2rUZMUPd18f9Xb0O0Y9TxLQOYvOky1Ko3gULNob6mFcjeBSc0vb
         5ANtL2EhMJaAg+0fY1UoylFmGteRl/0e8eV6bcU9L9t/K80CpFtePvT2e94HOplf6w9b
         OZJymRSOdf+uLxDObA6QxLhzb+gc6CLrf/CBJ4Bj271Ifma7t6oZzp2qPqhDijr90syL
         tyzXj/Slr11cRhbQt/iMIKclr3q+y1FhNqAcKNhPPq4TH1fzw7E4NNz1d3NAxjupdPXC
         zgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267104; x=1689859104;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGyDV6BAlg2AW/b3jzXgRhCmGRr6ZLpwHtOc10fjN3o=;
        b=SM11lrx7nbSWr1fIrAHfmaZRihRBcTIsB/Nb59OKEAvURxZrx+Y0kruMJjr29oAmLp
         xL7K2Yobq5ZHNCuBGqhTPN2Js2KSmhJiEZjVhSlVmY5nEyM2hdt+/IACwsLxD+MvcbDT
         znXjeS/xA+0y6WxrRljUJQknKUocWNIn+cQ2uC5e1MRJ74I8R+vGU7YwyzV9mS1keuq+
         UlkXNP9eRMRemwCK5U2Y67hlAu0FAjIvh8IFnsEJzfjn/P2q4XpC87AQfGsAxqKA1pO3
         bwNcxafu1+XEyA1U1ndJu+LJyg5/6VJYntOGjw87yKpHpfRwXhrPaPCcAIoyiGCukAAv
         xEhg==
X-Gm-Message-State: AC+VfDzP4ohCtZQqdbR1voN2ZHL9jUXUPS96ZMEqmeeNCPMj5uTntW94
        lvbeLbu6Fd9NrTIEUvv4zCbOsg==
X-Google-Smtp-Source: ACHHUZ5gYPvoG00x00nmpR0yqB5Lt+RQG9FPGP61KvB/cZ+yjJBGT7Mb+6dVhaCB8APIEa2UxlxcJQ==
X-Received: by 2002:a05:6a20:a10d:b0:121:84ce:c629 with SMTP id q13-20020a056a20a10d00b0012184cec629mr8053947pzk.0.1687267104438;
        Tue, 20 Jun 2023 06:18:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r23-20020a634417000000b005143448896csm1399994pga.58.2023.06.20.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:18:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, brauner@kernel.org, dsterba@suse.com, hare@suse.de,
        jinpu.wang@ionos.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230618140402.7556-1-yukuai1@huaweicloud.com>
References: <20230618140402.7556-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v2] block: fix wrong mode for blkdev_get_by_dev()
 from disk_scan_partitions()
Message-Id: <168726710308.3595534.13269294720973239157.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 07:18:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Jun 2023 22:04:02 +0800, Yu Kuai wrote:
> After commit 2736e8eeb0cc ("block: use the holder as indication for
> exclusive opens"), blkdev_get_by_dev() will warn if holder is NULL and
> mode contains 'FMODE_EXCL'.
> 
> holder from blkdev_get_by_dev() from disk_scan_partitions() is always NULL,
> hence it should not use 'FMODE_EXCL', which is broben by the commit. For
> consequence, WARN_ON_ONCE() will be triggered from blkdev_get_by_dev()
> if user scan partitions with device opened exclusively.
> 
> [...]

Applied, thanks!

[1/1] block: fix wrong mode for blkdev_get_by_dev() from disk_scan_partitions()
      commit: 985958b8584cc143555f1bd735e7ab5066c944a7

Best regards,
-- 
Jens Axboe



