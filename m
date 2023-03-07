Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4C6AE26D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjCGOad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCGOaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:30:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179E9867ED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:25:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x34so13390768pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678199143;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pUswYY3Le5dkGBJavjaTXJzlJxNEqlgltV+DJqXPvw=;
        b=1LWzC+8UAs6FlIRiLot36g/KgonVVwrjkxPT3vTtd0keATf9iQIzz73sUwUNGBVSQF
         HqgkM5+FKLO/0Vp1LzIHue8IcBN6CxSECL9mz9Y6BEOKAaiefIxhBXoroLSz5WSi7grS
         Vr43G55SLD4RB1GTJOQOu4Ca8Yahxit1o0UYmTyE0mv3aFbcfU7VrGbuzAJzh+AS17/H
         ggA+RKCNBVaBu912vDZOoDv745/bc7A8/NM3XRVn94Lj/szi2JQK7mYoUZ1hz4BdD/kn
         rTO8uWBUgxnM017VkxPYr1W5mpvceXIURS6LGkWRriF6ZcBMLBDiixV4II1qCCRH0a3B
         Mcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678199143;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pUswYY3Le5dkGBJavjaTXJzlJxNEqlgltV+DJqXPvw=;
        b=wjH7kmy9MhNLEU0bHfPg1vIu7mnfs1+D8D9Fda+ug9PHRxtv3nGAUI7SamvmVsbpKc
         FujbIFq9AcNzXh/EbD4Ew+A9i5TzIGC8LpLTdLV5wnbmHe5ibr7I3+J71naFQp24UxLh
         l5S7y7L3/lZjK+r3eE+8OG3Pt8N7GEdrdNIcYeC2dxBBf2M75o2iplK5H5sj95y4kqxN
         QLmEl+U0RowExTUb7ds+9+I0UAcVvsBU9aoAH6cr0B7CTGIoS4X2C9J25DUMavCqOr6b
         u0Bs6DRl7O8QPfwOsXos2yihvZEUIs33PS+o/QbaJhBd7Tm7rClzmxOxkWcd5L/YHE24
         DF7Q==
X-Gm-Message-State: AO0yUKVruvZKoeRoxPlbxZLXwP7d9RPYGfk8cGoVabjUuhDSGzXZ+mwO
        HK5pCvFVy13XKrJCNMPJzz0EFw==
X-Google-Smtp-Source: AK7set/o5QYXytOiAl3gSKlbOjvNqp2qyoU8SqKy/N5JGMecO0kNZPEAEjXPmKeiPTE4loL+L6eZ7w==
X-Received: by 2002:a17:903:2304:b0:19e:d6f2:fefd with SMTP id d4-20020a170903230400b0019ed6f2fefdmr4933695plh.0.1678199143345;
        Tue, 07 Mar 2023 06:25:43 -0800 (PST)
Received: from [127.0.0.1] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b00198e12c499dsm8469198plh.282.2023.03.07.06.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 06:25:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, jack@suse.cz, julianr@linux.ibm.com,
        yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230307105552.1560439-1-yukuai1@huaweicloud.com>
References: <a3a4351375d51aa5e93e06bba212ba3637665885.camel@linux.ibm.com>
 <20230307105552.1560439-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block: fix wrong mode for blkdev_put() from
 disk_scan_partitions()
Message-Id: <167819914263.6301.8573680638025368165.b4-ty@kernel.dk>
Date:   Tue, 07 Mar 2023 07:25:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ebd05
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Mar 2023 18:55:52 +0800, Yu Kuai wrote:
> If disk_scan_partitions() is called with 'FMODE_EXCL',
> blkdev_get_by_dev() will be called without 'FMODE_EXCL', however, follow
> blkdev_put() is still called with 'FMODE_EXCL', which will cause
> 'bd_holders' counter to leak.
> 
> Fix the problem by using the right mode for blkdev_put().
> 
> [...]

Applied, thanks!

[1/1] block: fix wrong mode for blkdev_put() from disk_scan_partitions()
      commit: 428913bce1e67ccb4dae317fd0332545bf8c9233

Best regards,
-- 
Jens Axboe



