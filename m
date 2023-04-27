Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F0F6EFE81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbjD0A0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242815AbjD0A0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:26:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A173ABD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:26:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a6a50dd62cso10068765ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682555179; x=1685147179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTOkRfNYIcCyobGPmwTR41HZBXplh4O+VdZT8qkDAZs=;
        b=SG/9x29S2i7UOgFAB9FBCxeDkY9UXuXY4AHfghZkPkuVh1BqDqug6ga/nRw2yuSZr1
         OWKsZtymxEJJAZVRwQPl5w//p/ZCSTV7WlIss3X6FnvHVdhZihsl4TX4GP9tbn4MVHRu
         Dop89EfFJqUvw6cq5UiqAWG+jVAUfM1UPZ8CXa0b38tIW5ieYECKsSzKm2fIDuDAdWrX
         7ejR+BN96Sgfvfe3ALjEz153NNL0t7FG4XoyuTjd4hFVsdAoiwp1o1B2NNwxv53cp+DQ
         8T/Q03QqC+N8/pFUW8XEXdVZInL1HFWP+a4r5XJF8uDw5LPlOpHmUTxn1lJ56h3+4k75
         djsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682555179; x=1685147179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTOkRfNYIcCyobGPmwTR41HZBXplh4O+VdZT8qkDAZs=;
        b=foIpuqfUDqmlMxrNs+s1nP/GFHa7nGrL8q1iHAq+GiydP0QmCRzdsYGCVlKMl0i+h7
         ziP9gwOpvddmS6hGQSKiEMr6QcTnrnYTboPoV1fMzLbJ4gLExwhENxsBknqsmEUGpA86
         7RNdOrYLp2jX8cPpTGE1A6LfL0g4Tn+EpbJoRpZ8c0ybzmOjoAF7L1545U0cXw9Xj6Ke
         +MOlw43xi9MTeyZNmyFOdSC4mvVzItri0PwRvMLWU2dquzG14d0e83wk00LVvTeTyokO
         919JITQVaG5n622zT/Aw+LYLxKvoobwSB+eVzIhH+Vo8DxiYTVr0bmQAO2Sq9arQAS92
         uDyg==
X-Gm-Message-State: AC+VfDxbg9RUMPfougli1wM4Zjmh4n69dJx8r+tU4soGvcQ444j5Q69s
        DUQh73PjjjWkK+N0wBhpVl1fXQ==
X-Google-Smtp-Source: ACHHUZ7q1W+ObQVu0dbQ+J+W3jj+iRhsLm6KT6rUgicarGzFDj0n8iSNF9dqH7imMUY1nISc44EC5w==
X-Received: by 2002:a17:902:ea12:b0:1a9:4167:5db7 with SMTP id s18-20020a170902ea1200b001a941675db7mr8985693plg.4.1682555179437;
        Wed, 26 Apr 2023 17:26:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902a9c500b001a6f6638595sm10403862plr.92.2023.04.26.17.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 17:26:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
Subject: Re: [PATCH v3 0/3] blk-integrity: drop integrity_kobj from gendisk
Message-Id: <168255517853.49697.6615983265026536560.b4-ty@kernel.dk>
Date:   Wed, 26 Apr 2023 18:26:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 18 Mar 2023 17:36:22 +0000, Thomas Weißschuh wrote:
> The embedded member integrity_kobj member of struct gendisk violates
> the assumption of the driver core that only one struct kobject should be
> embedded into another object and then manages its lifetime.
> 
> As the integrity_kobj is only used to hold a few sysfs attributes it can
> be replaced by direct device_attributes and removed.
> 
> [...]

Applied, thanks!

[1/3] blk-integrity: use sysfs_emit
      commit: 3315e169b446249c1b61ff988d157238f4b2c5a0
[2/3] blk-integrity: convert to struct device_attribute
      commit: 76b8c319f02715e14abdbbbdd6508e83a1059bcc
[3/3] blk-integrity: register sysfs attributes on struct device
      commit: ff53cd52d9bdbf4074d2bbe9b591729997780bd3

Best regards,
-- 
Jens Axboe



