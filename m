Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6032D65724C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiL1DY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1DY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:24:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51671121
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:24:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so11764317pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wjec9fKGLxWwB74B9SSi+YQbUlxipxrkqTSePS5dtzw=;
        b=OrgEFujap2ABGQUBOQEvUvm4GyDANl0gVhrw6079EulPi/6MxSYOpPKbWLg8ButqJ1
         t59gVXJTIUWJozGjsO0zzkC3ZAGEetf6LYJK4a2i2cx0ky7EV0bz5zNSXohT9c4fziEf
         /+GcwfbVSGN3E7AjaW47Ue60FWvBkuQk3EeTHxkEBP95PU/0VkixG7sHJaOtpL14B2Gi
         TKajJNiYKbM2ewBSIeWOFGH6ccShLjyrOJMIdtTwT4HNnK8RAWT28KpV3cWVpDQCsyBq
         HtShtYZbXgFZduGbffHLhHAh6zpfvVA353K5uYX2VlJGU2se6aOFQA7oNM8creWDZXFM
         ybdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wjec9fKGLxWwB74B9SSi+YQbUlxipxrkqTSePS5dtzw=;
        b=MV5lu6rpEGSAcjgAXxZH3WfA1H3UeszRUYOZuZqgZwIGc2dgLKxRiTYAqLxpkI0dK6
         sIw8B/H6hSVQLgh2gKbKWsOFg7YB48CqdbpR67XoloxOQXxwUypqr5lOo6j5AMG+r0qb
         MEKxP+w53pVvCJu15ZjxMn2ElWGkYR7pmmJOva2zq2v9N1OL3d9E09VqRcrrJ/o7WUv8
         TjqywQIwAhMUMqbxzSQ9ADn/HBSHtgosfxpOpHO7C54PoCzTGAHSGbe4Vetu0qWyXduF
         L+6SauS95T2hzvVxqkWWDpb/4y33KuIDHqISSc4fpZ8i0VALbZSAKyYoqVnqfxyEXdxS
         vpKw==
X-Gm-Message-State: AFqh2kre/WekBGu6I2K+//Z5GSGcebqI8VEA+5FwyXgQm+2nOeEbeQ3P
        HQrUt4kCfWiz/oJPtAy7MjpR92aMPFgr/+8g
X-Google-Smtp-Source: AMrXdXulF9H2WvKu8TsMdSGPsGZfhfOUkZHDWlVaqjJvPs6HhzxWC+0vw4JFy6l5rUE9CHPRGxB79w==
X-Received: by 2002:a17:90b:3555:b0:219:e38b:5079 with SMTP id lt21-20020a17090b355500b00219e38b5079mr28258669pjb.38.1672197865121;
        Tue, 27 Dec 2022 19:24:25 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m7-20020a17090a668700b0020aacde1964sm7289925pjj.32.2022.12.27.19.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 19:24:24 -0800 (PST)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH -next v3 0/1] drivers: base: cacheinfo: fix shared_cpu_map
Date:   Wed, 28 Dec 2022 03:24:18 +0000
Message-Id: <20221228032419.1763-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Pierre for the semicolon ;)

Changelog:
--- v3 ---
Remove unneeded semicolon

--- v2 ---
Rebase to the latest Linux codebase

Yong-Xuan Wang (1):
  drivers: base: cacheinfo: fix shared_cpu_map

 drivers/base/cacheinfo.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.17.1

