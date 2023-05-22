Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB0070CC65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjEVVaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEVVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:30:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D1100
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:29:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae408f4d1aso49973485ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684790995; x=1687382995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBLyvMJIXVEoPILXi5pTygeAcZW5DafmkS3+kdAf2Kc=;
        b=X82Q2HodtT8g9HraWMIl6WRHWVTb82m3RSWbgXxmB7cWHpQ/9EMmYZZIsVjf9DaLD8
         SCAMWIwbtqwUg4HoPylm8ZEiqw1RJfD9rED4QOx8TyhkjCC33fQN6VzHYNghySnyMAB7
         MGGfYIqkq2GjXt67wofcPVZ+leITFGwe2m8y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684790995; x=1687382995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBLyvMJIXVEoPILXi5pTygeAcZW5DafmkS3+kdAf2Kc=;
        b=K1T/FgpXn2bl9S0QbDZ5AyUA/LOIzjeyS7uGm64yhWHEFBSeaNXRYBdxM9lHbDwhIq
         pZMUTsezIyEatBUbRxhOfR4HgtvcfF90X60ZhbcbwQWgWl+vGjez8wIW8r/Apu/RjERD
         jhapMdk1HeXH6QldRO9lwK7gttBrH4AwPufzvnapxyDQNjcOjICCfxj+If3betPp+Bs2
         VwPhvEpGGS/YHtqh6NN85OO5HbK7YJI8KVJTS4BvpeK73RimABI1fABMr9oVg0J6ZljX
         JQILv9bz1eCi6NVnq7D7vLuOPi02fBYRXDG28k3Scl8jOUBSY7VNz3mAocePuk8g68VT
         cFaQ==
X-Gm-Message-State: AC+VfDwsVeWej7eZNGuob/Ot6Q+sXQSkpTAWrSmiJ8kjTaaWPfGVnJIt
        l18Yd/cccMykRAj0wx5Z6d0hTUQjz8vDnJ/sQx4=
X-Google-Smtp-Source: ACHHUZ5KVf25c93mzqpzXVDAq4yl6joAPQnJgMH8lV5GMMJly5FJ0vAZt87hVF+Dyj3qhc2UMaYElA==
X-Received: by 2002:a17:902:fe18:b0:1aa:e5cd:6478 with SMTP id g24-20020a170902fe1800b001aae5cd6478mr11818786plj.58.1684790995120;
        Mon, 22 May 2023 14:29:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b001ae5044c2aasm5277702plg.145.2023.05.22.14.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 14:29:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/bugs: Switch from 1-element array to flexible array
Date:   Mon, 22 May 2023 14:29:53 -0700
Message-Id: <20230522212949.never.283-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; h=from:subject:message-id; bh=y81tjhfBvnUmPtitkb7B7N9eatfqA8YTYmeHZOhOfxU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBka97QZrwNn2mIbVBJBSpfEndS4xU/2XPiI0Wr+S0L Kun4w4mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGve0AAKCRCJcvTf3G3AJhfoD/ 42C/6DH/maDdsB2RoaWdC8ev+KyoGozc+vS5p1KDZ3iuw3IdatQX6VB19FAmC02Qfft/ityZtkUckj DyVfyVg19qbMD1BkB/qgdU8WXc8RkzbQvg3iBKVBA1WpCqo9IHzANU04bMYIFxH8gUXwM6qGdu6qTa hMGJEOG4ux3t7KkFPZeooTAsE2P+AfGD7Smctm/qEYdORFqp5bNrMNLZmwNR6szCNIYY5GjALFX4Ts FoZcxWAfoNOHT/LhIiSbsV9GftsB5mp/ifmu1jhd2Ttq3rYiQaH1seUxZkpUmRgElpA6KgcAI78Icp hqfYvhzGH03caTMr+GntC7w1V64N5w7Yr+Sv4taGCJ2YE3UJ3WFRUmQv4MvnMlxn0jqxhCZ7S4ew2J XtqhvQE8OwRE9icsBdehtRH5j+tcyVEn5Fc5Bw0rHaHvySqkhLsieKO8Lu8ja5zcekuK5Wk7E3CfRO U5Ceud1NDAdSdg57fvIDDrqsQDK0HYqgDP7QgeNFLcTYE7l6OEHvOwZApnOGpOygPTwMlYw+364roT jJZW6H1q8ZNH8ViIbM/d4y/xfeE2MFg+HlakXFQJfX6neJ2aYReVrOa65MS/IsSz5fkg7ut33y82zH JGxSuqXQZ3FB4ZaUIji8Q0OVcq00PQ6E8xX57dH1rzE5rZjFOUMISwSXQkHw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The testing for ARRAY_BOUNDS just wants an uninstrumented array,
and the proper flexible array definition is fine for that.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 48821f4c2b21..224f42cdddf2 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -305,11 +305,10 @@ static void lkdtm_OVERFLOW_UNSIGNED(void)
 	ignored = value;
 }
 
-/* Intentionally using old-style flex array definition of 1 byte. */
 struct array_bounds_flex_array {
 	int one;
 	int two;
-	char data[1];
+	char data[];
 };
 
 struct array_bounds {
-- 
2.34.1

