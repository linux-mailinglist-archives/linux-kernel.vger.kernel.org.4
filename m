Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC77637E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKXRt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKXRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:49:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9421448EB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:49:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v1so3425158wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B10j3V+GxgQiKsCJeBTTKhDiyZHL/sxxWTGkoYcMNCw=;
        b=fwnDBujO5+bO+iP+Qg31zN2vcuV6A9LNuRWeGwf5qJxN6hBWm975RltUrWxB9/X6TZ
         ps6xRTNl0157q4xufHVEpcBjAc8yk96/sdgQaKWeGS3F82Msgh1yvklsryX967Ws1Vwd
         gre6wZUlLatN+d8GzgHBKERBCd10Rh7sTQHpyJkQc6E/6Qb0ERS+CFN9DMv9MLmc5n0z
         7VmmvmbnyqkiTaH3LA4Y+8xUWhWJ7II1B+m/O0A7KLgIM5YWCRSXfDmcKaUQxeEZs+bf
         RmxcKL9y1QZ9u49Vr7cllUpyBiSGgxuw/2MjqmYYm2HlmRPcj+a327F48AdMBSdNpt9/
         qzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B10j3V+GxgQiKsCJeBTTKhDiyZHL/sxxWTGkoYcMNCw=;
        b=udKwywu+wEf9LKVu2g+9Ep1nMFBtb8AE1HMcYlN8Xu9H7epYoVi/oLIjwoE02K4/6K
         ocd3zRLqQFK7aJuhyNBdQzH9Y5ySM/2IUAt41SFfmakUtl3TxIQTYB1bZRltnjfnSYtr
         KFSHu3+nzo6OffrNP82fLa92ckeleGGwg4WkxPJVk3v6Ib4plhEvnQhsz8ND+6hoBpVR
         S7XuMQYW5BjqYh6QkVeWuhb0O7p0ZC4UOGTXWCFGpT1iW1Cdw7oWwhYe9MOvgxydfFTd
         I0dxGnz1d/yB3RGdtPo1p5OqqCFqFNtmwQqIEzEwIn/9fi7acSzipzkWtRv6O5NCYpBY
         omPA==
X-Gm-Message-State: ANoB5pkSI6Y/EGyGF8886o4PcTrGulkJkC3luIYLBGhVXGJJZwQUjSv9
        SbAFSgzKEzSxROIrUF0wrzNECQ==
X-Google-Smtp-Source: AA0mqf7UqXeMVh+E4e+nX1hHS3spoTqQllMiRWlrTFYUATke6MWQl4sbVEpMT1bXFaeK5kkNbkClZw==
X-Received: by 2002:adf:db10:0:b0:236:58c8:2ba2 with SMTP id s16-20020adfdb10000000b0023658c82ba2mr20663206wri.224.1669312185118;
        Thu, 24 Nov 2022 09:49:45 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l11-20020a1c790b000000b003b4a699ce8esm6250863wme.6.2022.11.24.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:49:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] misc: fastrpc: fixes for 6.1
Date:   Thu, 24 Nov 2022 17:49:38 +0000
Message-Id: <20221124174941.418450-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are 3 fixes that were discovered during product stress testing, fixes are
around a race condtion resulting in use after free which are fixed with
using correct locking.

Am really not sure if you are taking fixes late in this cycle.
In case you are not could you please apply them for 6.2

Thanks,
Srini

Abel Vesa (2):
  misc: fastrpc: Fix use-after-free and race in fastrpc_map_find
  misc: fastrpc: Don't remove map on creater_process and device_release

Ola Jeppsson (1):
  misc: fastrpc: Fix use-after-free race condition for maps

 drivers/misc/fastrpc.c | 67 ++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

-- 
2.25.1

