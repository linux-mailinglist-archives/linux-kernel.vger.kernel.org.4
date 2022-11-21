Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A7C632D00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiKUT3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiKUT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:29:19 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816B9C4B41
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:29:18 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w23so11464907ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzvtVuNglXyu4UOyfN1Z0GnwKotPCftRcxGUhfnWdZ4=;
        b=KBv3TbGb31lasXQhnisiP2c/fUubrfPHb4TJLALdhefPiWvtx3Y4liN17fNgKEp8i0
         KSzmUAvJt8/cqRX9HFrqZtFtx67Y5OajTfEBdjjo4VwXKWQBdYA3SSP93rOzAni1jnug
         pAK02W+IwBOPQ/+vSHcXCdWKhiC2WEwW0htS927F4khyDUd3T/84iF1KGTmUhCNkLdeT
         tv/pkAe44lRZuSfLcQTdfUqwLaaEHX1W4Fm9Jtzi6oVapHvYCv8GgmTSFq3Dih6D5RNS
         Tejl6omxHzTg7/3nHBb2KUAJLF8NDRUq5hN7kLEvwaEWs8ETvclaMjMA5xgm6Rpn5CX3
         IMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzvtVuNglXyu4UOyfN1Z0GnwKotPCftRcxGUhfnWdZ4=;
        b=GAROpmGGZbmRSeRll9WtQ2DmR1cuFtXijMXHBgY7p65albnQi0Z9sG/ZHq2bZHkn5C
         81uN9RsT5Q/oiJdnose8BwFBre9qI/OYceYCtx6zzO1UNaNbZEPFCbrCa4bo1pEVTqv0
         93QiWRjSf/bTOwHiCEuO2SbASeKPHS1+Kg5tTA+aZGp9WuO3gjhqICD1iCOws7zrB+BL
         s6qPq1FWDRwe/W9WcBGJvqT58L5q3UjS3TwniSYZrP3eeJRGTKWUyjZxgj6fe2iI8GdY
         1nDXIFnwQvhBo0hZeeeZn0GPSStDSPv2GgQmX94u+Lm9J4fvt+SfjPTQc4rFSnsYJK1O
         RMJg==
X-Gm-Message-State: ANoB5pk9ku6L5wAOlxwcKOWWbbiPDrEjoISC2dL7FxCW3n8zNlZlm5Dl
        wKoBtcyGzimXdGHKbZsMzRc=
X-Google-Smtp-Source: AA0mqf6Bqkw8Iw5x28r8BMrI/GPw4MQQ57RYSdazs6YTxZLmY/y8o5AzjOdwWf65b1idqpI3239Hjg==
X-Received: by 2002:a17:90a:7646:b0:213:5e6e:5d28 with SMTP id s6-20020a17090a764600b002135e6e5d28mr21828149pjl.60.1669058958031;
        Mon, 21 Nov 2022 11:29:18 -0800 (PST)
Received: from localhost (fwdproxy-prn-010.fbsv.net. [2a03:2880:ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id d125-20020a623683000000b0056da8c41bbasm9007537pfa.161.2022.11.21.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 11:29:17 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 0/6] Implement writeback for zsmalloc
Date:   Mon, 21 Nov 2022 11:29:16 -0800
Message-Id: <20221121192916.1157438-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119001536.2086599-1-nphamcs@gmail.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, looks like Minchan is on board with the series - the concerns
with the latter patches have been resolved. Feel free to cherry-pick
this series back to your mm-unstable branch!
