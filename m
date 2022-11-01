Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8161435F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKACrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKACrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:47:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076C17894
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:47:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m6so12356304pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqRIQ062uuK/o+/WpcLxqow2YV5qT2kYhS0BBT+EteU=;
        b=DRCdy0I8Sl8TkVAgdeg/jvSKu+czCngr3cXev+Kwv7pfbBInABYASHoU8SEYDVqLXh
         9t5P0IzT1wYf8J6IHBJXbHTYPgwz8+YDH98zX0qa2JYt9gTxFPXJirGjAf1RQYL5+Bcj
         vEj9fzKQ5VULUFBRc5IoHXV6VlV3FxoAZHh61slEi18ElUUzetqNQv9QpitfRJv0UKqS
         ZtEBoOxaIFutjPJtWXsf5O1NTVGqyOjPR1jiHxiD4UBXXVsnft8hOTqEqz1OHBbv1KuO
         ByzGFheRm9rT3/yThkU5ExEyiBowAwR4X3CPCmfqZqfkwlPkeDi1edZilt2lwqRaw9WG
         +doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqRIQ062uuK/o+/WpcLxqow2YV5qT2kYhS0BBT+EteU=;
        b=pT2XBrnHW4BqwSWjEGUF6UAVPgzMnLL3Yp9QqcfQNhLl5Yoz8syj12DeD92rcUsB8j
         CdMrRJzpZfHHShsIyWvHhRSK5W2NxzyuN0xEdJVQEs+WEKKbwXG531f/ny86mkaM+vnm
         HeyU0mazaTaI4mBafw9HjxIu1veGYVH+9PQhBjcg9O/RP8E5y9MyVHnfO2kvB/qe9/a0
         buIGwcO08RLjhYVqBlCVmAbzG9nKeqdwxOQJKdxAU1b4HrMCWB/eoFgku1C21MKdnhrU
         8sVUC6x+F0UiGL7EcR1vW5VYxcbMcTJc8lrz0eJ4rdumh0Xcl4HX3/OQJGPkTOb2GRyq
         v4EA==
X-Gm-Message-State: ACrzQf1+R82GEoykvmqjVe7RFk3U0T02g8vPB3ZRj7vEMkSFiT4Irq+h
        mwPv1ZtIoOH9kTwE4ZUNvpdcjw==
X-Google-Smtp-Source: AMsMyM71feJVISISgariwLNWQfEM4he/JyNbNIKmkyIWnvZ2Qgt8Ponl4uP06pOBBoik59p0tmVFjA==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id b12-20020a056a00114c00b005282c7a6302mr17656095pfm.37.1667270867814;
        Mon, 31 Oct 2022 19:47:47 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001714c36a6e7sm5079570plb.284.2022.10.31.19.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 19:47:47 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/3] Manage domain power state for hibernate freeze
Date:   Tue,  1 Nov 2022 10:47:33 +0800
Message-Id: <20221101024736.1509207-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series tries to fix a hardware lockup issue caused by missing domain
power state management from hibernate .freeze[thaw]_noirq hooks.  The
detailed description of the issue can be found in commit log of patch
#3.

Changes for v2:
- Fix kernel doc of genpd_finish_resume() to use the new function name

Shawn Guo (3):
  PM: domains: Pass generic PM noirq hooks to genpd_finish_suspend()
  PM: domains: Consolidate genpd_restore_noirq() and
    genpd_resume_noirq()
  PM: domains: Power off[on] domain in hibernate .freeze[thaw]_noirq
    hook

 drivers/base/power/domain.c | 130 +++++++++++++++---------------------
 1 file changed, 52 insertions(+), 78 deletions(-)

-- 
2.25.1

