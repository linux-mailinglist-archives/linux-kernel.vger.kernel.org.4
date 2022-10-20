Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9C605505
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJTBbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiJTBbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:31:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A18FF243
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:30:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pq16so18437698pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BDKoCuiX9gLdyLhtKOYiwtgCSx3wnswv+GarFhOTZU=;
        b=JHS0tpXqLX5GdsoQR5MFjpSHLMbrcGQDL5yQISyBkWOTUWPO0WuLbO2XI4+GI76j4i
         p8YfWzmnFz32jjnoZqPPRsAtgOlNrcCWhOqSXINc49JKDAa9chl7qBcw66j6ZkQL1a+U
         SEWjGiRmPD2p+N+wS4HHHOXafEtOkdYUa53PSGWZJGKQX3Aw4Lzv/HftVgCc1NhnZ7yk
         kVLuSxoL0iGQOq+yVx+lP3Zpn9dGGgFUxt4HtIrbhTlsUPHS5D7FJFSmz61fKZ5BWwKu
         e/Cz0w9imbnAvZv/rua2FppYhGCTHHJ2iDwrCiciBcElkVm8X6WzCgQmko9CyCI8cQ/C
         dwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BDKoCuiX9gLdyLhtKOYiwtgCSx3wnswv+GarFhOTZU=;
        b=LilquEJwIBpgBfym1YmWVOdF/rI1bkdeMVZgRz5VgiV7IQO9Z9zaEfgAlQBRqgYkzi
         RB4uCzJavO+eDOk/OoGnujC+tpYELIgPUfBXAnvykldRK6SvhSIyMtFmESlz+Cotna3L
         60SnO+TRC3m7JNhpmLUWvLMUpGsHb+WQBrTjonypgXnr7cbHXk39FvEdYIh+PJSv8H7X
         YB9sIUW227O+67wkGAbM2XLssEXsMspN2gQh1BIpTZQ0FfREAlycnxh/8o0vp1zC9ryx
         nvshQXsMoQ3/CHALhzJngf64vkSM2ndr4joMV6NdI8bA8WuKZ89j466HZWg3aSJ8Xgg7
         X3/w==
X-Gm-Message-State: ACrzQf3gzJQ/czrNW2YWTC7Hxd0THrEJq0Y1ieyjzZL4H6aAC7qXAyWK
        mtkFhfbIOHdfPGfbDYKA3DO5BtvJRbKIlv7o
X-Google-Smtp-Source: AMsMyM7WDF8L7Gcohi5cKDVOBbvJUV/wbv2310vXAaOcpxqGAZO4eKF+4zl5qMZAfPZjQfR3gdSNqA==
X-Received: by 2002:a17:902:bf46:b0:179:eba5:90ba with SMTP id u6-20020a170902bf4600b00179eba590bamr11376463pls.16.1666229275351;
        Wed, 19 Oct 2022 18:27:55 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a2b8b00b0020ada6ed6c7sm521379pjd.41.2022.10.19.18.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:27:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, zys.zljxml@gmail.com
Cc:     Yushan Zhou <katrinzhou@tencent.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20221018100132.355393-1-zys.zljxml@gmail.com>
References: <20221018100132.355393-1-zys.zljxml@gmail.com>
Subject: Re: [PATCH] ublk_drv: use flexible-array member instead of zero-length array
Message-Id: <166622927442.148655.12986325074372768712.b4-ty@kernel.dk>
Date:   Wed, 19 Oct 2022 18:27:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 18:01:32 +0800, zys.zljxml@gmail.com wrote:
> From: Yushan Zhou <katrinzhou@tencent.com>
> 
> Eliminate the following coccicheck warning:
> ./drivers/block/ublk_drv.c:127:16-19: WARNING use flexible-array member instead
> 
> 

Applied, thanks!

[1/1] ublk_drv: use flexible-array member instead of zero-length array
      commit: 72495b5ab456ec9f05d587238d1e2fa8e9ea63ec

Best regards,
-- 
Jens Axboe


