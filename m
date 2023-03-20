Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7796C21AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCTThl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCTThL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:37:11 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014BE6EB6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:31:37 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l15so5502062ilv.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679340697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVP0YkpWhYSYuvkOPAOY0bbcXnkGvHyM33oWwvtqnw8=;
        b=gAXoMAoA/LwEeAIQEyvlSukoThnf2mCeS6Sy0WhL0a6QfMr1x4M5MPArtT5ztQtov1
         UWWi5Cel20I9IblUDD0iTi6a24PujKM26P4qJQKoWUxvlTS0gx6aVWFR9mAdqSURLZES
         wVqWkoS3rBAQbDcA70pXTBRWz8FsTOl1It4dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679340697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVP0YkpWhYSYuvkOPAOY0bbcXnkGvHyM33oWwvtqnw8=;
        b=Yc8YbZk+dW3OqxklpFtO+u/Hg0E/pnb8zVXAiHuF0YwW7QDDJ9+7u7Lsx+oP37XPfk
         ZHZsUxsHib5yAe8GQxJXCj0Vz8ZNjkasj67gpig5RTRaT0w7VJj/UZVgUMHwQDy00cM0
         SHqJsnjfooPP3xmck678axQt7a51Hw+AiqjW+OUuFhSoSwVS58f1jcJzbVzrpJRLvaET
         dLACzEvYj8moXqEyoGvRHMoeDsfnZKnY1ppccWhjOWrO699VZLEMjzp+rUyGDGhiVlUC
         /7XMea/i4k2A1WtlVhsxIApkBcjUqiwvh1kB/ubX0ElgxIxC+Bf6E4CrBU9oneZrCYsc
         igjA==
X-Gm-Message-State: AO0yUKWTunOgGSL1yKOmS/b1VnxLqFDc7sI7TZ31zOkn+SEX9DF7oCKR
        xgNpreC6SzVyC0Mf3C99mlFlMA==
X-Google-Smtp-Source: AK7set8LaNKyKUmLiT+RGpi7UWOXp4sRL6BZ7BxmiTeyyXPTeErFf5lOjonpPO8DqZ4atMuYHyjKRg==
X-Received: by 2002:a92:da84:0:b0:323:277c:4cea with SMTP id u4-20020a92da84000000b00323277c4ceamr459603iln.17.1679340697318;
        Mon, 20 Mar 2023 12:31:37 -0700 (PDT)
Received: from markhas1.roam.corp.google.com (71-218-36-105.hlrn.qwest.net. [71.218.36.105])
        by smtp.gmail.com with ESMTPSA id m7-20020a026a47000000b003c5178055fdsm3575990jaf.62.2023.03.20.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 12:31:37 -0700 (PDT)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     markhas@chromium.org
Cc:     Felix.Held@amd.com, Rijo-john.Thomas@amd.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        gjb@semihalf.com, herbert@gondor.apana.org.au,
        jarkko.nikula@linux.intel.com, jsd@semihalf.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, mika.westerberg@linux.intel.com
Subject: [PATCH v4 8/8] i2c: designware: Add doorbell support for Skyrim
Date:   Mon, 20 Mar 2023 13:31:24 -0600
Message-Id: <20230320193124.55807-1-markhas@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230320190407.51252-1-markhas@chromium.org>
References: <20230320190407.51252-1-markhas@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int psp_send_i2c_req_skyrim(enum psp_i2c_req_type i2c_req_type)
> +{
> +	return psp_ring_platform_doorbell(i2c_req_type);
> +}
Should this function retry acquiring the I2C bus while it is busy?  Similar to
how the cezanne variant works. Also wondering if the function should be named
psp_send_i2c_req_mendocino for consistency.

Sorry about the repost, the quoted code wasn't included originally.
