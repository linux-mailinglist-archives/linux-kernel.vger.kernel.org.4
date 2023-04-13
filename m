Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E506E0F09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjDMNmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjDMNlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:41:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF1B47A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:39:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b5312bd34so69900b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681393160; x=1683985160;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5GBQ/viuKe150LzqNRyQRtgZN+m/HG81zsds+v56TE=;
        b=e5mMFdgjV9Ay+CSDa0PrCQedxFnxymfPfiK+ktQyOb5laFRVAX19ZPcS4K+ykI/lBP
         pgh82gPWxhGL2Jk0vIPETxAf3QOqzohaObKaxy0VqipqUDPyFDeSnnjIk99O5kH9O9Tx
         rBkEeGhmTV16C8CQSHZ2q47rG7dXAeEIoAwwJ7U3m8d/FG0w3Syq61/TMdCqZFjWcw/T
         R0SamOYhfUM/W9QoPu/no1ftaCJifUO1GCwZgUxpRSYnJT0R8HhlvIuYGeEf8+58KCFj
         SRLWTtTdduBacBLr9tjwZDsfJNmlbo1zB2mm39EQHUTDwFW2zbRz1lytncBl+WzEzNAk
         BGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393160; x=1683985160;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5GBQ/viuKe150LzqNRyQRtgZN+m/HG81zsds+v56TE=;
        b=OxWkBEWdZpt/TdCmUnECwwDcEkcvpi7JBEi+3NBeZa4id1bkN5Eg3tWzV23syESEH3
         IEDkR+0QSZ/MmmF/3TvMPhgW0r6bg7MtGbJtVEEfbuVXMFgLPzjrtc1agNgU/aL9/EmV
         QhDq87mPT9z6usz+kJSdTx6AX0gU9Pu4V1UCdXCnwWu0ZwOeUbcM044Oo0z1PGnFy5VA
         DaHf8mFZkHHLQFs2/K9HvuWzxV//cjeAPXSjBCHvu/sKcNBbcJDJbAkQ6DDxkL6Iu++/
         XXXUchHCsg1nv9BWicu09kwlP0T+TYtZKTjBAznaHCt7MxBfAkviNOwsk6QwKPOaaKki
         DYUg==
X-Gm-Message-State: AAQBX9f8uiQuE4wH1PZp9qLm8CFchXcROQD7GTEVpIaSFv1TqxPeUdnH
        WVLtS/0nKQwNxHMlcGNJ9lz5xUtzEECUI9gORgg=
X-Google-Smtp-Source: AKy350a80gAga1CBrAWGU9/NoXp+AD6PiDbJRqU4qPSs3VAk4bvAhuizY6pNRojoASbeFBg4GAB7nw==
X-Received: by 2002:a05:6a21:339a:b0:d7:3c1a:6c9a with SMTP id yy26-20020a056a21339a00b000d73c1a6c9amr2448161pzb.4.1681393160059;
        Thu, 13 Apr 2023 06:39:20 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a11-20020a655c8b000000b0050bd4bb900csm1373954pgt.71.2023.04.13.06.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:39:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <20230327143733.14599-1-akinobu.mita@gmail.com>
References: <20230327143733.14599-1-akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] block: null_blk: make fault-injection configurable
 via configfs
Message-Id: <168139315928.27943.13141882986699075665.b4-ty@kernel.dk>
Date:   Thu, 13 Apr 2023 07:39:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2023 23:37:31 +0900, Akinobu Mita wrote:
> This patch set makes null_blk driver-specific fault-injection dynamically
> configurable per device via configfs.
> 
> Since the null_blk driver supports configuration such as device creation
> via configfs, it is natural to configure fault-injection via configfs as
> well.
> 
> [...]

Applied, thanks!

[1/2] fault-inject: allow configuration via configfs
      commit: 4668c7a2940d134bea50058e138591b97485c5da
[2/2] block: null_blk: make fault-injection dynamically configurable per device
      commit: bb4c19e030f45c5416f1eb4daa94fbaf7165e9ea

Best regards,
-- 
Jens Axboe



