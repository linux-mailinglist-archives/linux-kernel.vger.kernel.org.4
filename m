Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA5742772
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjF2Ncs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjF2Nc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:32:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA8E72;
        Thu, 29 Jun 2023 06:32:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso7028905e9.0;
        Thu, 29 Jun 2023 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688045543; x=1690637543;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCNFfEAbLHyMqZFM6llkFTJRY+kQekzRP0RrqaYUy78=;
        b=HskV4C783dd9XjnLO3UPWQNHPOEgfdNsuYPbJAE7KjgNp8FtRl9zpGOg6Lsh8aUZmS
         ftJgw15Hd2cnAwy6Gqo1x690oceBY+OoZ9OuP8RcBLnjmMcU3mzslAxeI8R1lsscUj/8
         2lIQ/gf6nD4S6lMoq97jYGx0KMl2w9GoJ0+ONiS2X9WsmEC2liizlirxd5agDu7asJ3m
         oQ79nmS/VM0UUmu2kFclu8oHLD0Gd6aWQryU3vAZWeAPx/k9rATpYABsusWzfelb2Kpi
         Skq8P4m7DmZWUFg6qNxjmeZqsA2rH0xW0GvGITrZ/5V2ixqTwiddwuQQik0y9b/+YgZX
         A4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688045543; x=1690637543;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCNFfEAbLHyMqZFM6llkFTJRY+kQekzRP0RrqaYUy78=;
        b=cBJg9KnNXjnoMUgZQmTUl2NSc+GxkEVCE6ftlUOWVf36yIohQoLlWVE9037t6wRrUi
         zs3JW4sTAQxXTqVJxDgGePTXr2ATzChlPD30vbkZhhrG9i0ikXioCHFcXMmV8Q40t9CF
         1EvLKkqpLe+4pn14lSIXSEs1Ryb+hIN/KOFf99SelqTUEskGYDyRhTaOBKl4iY2t4bI4
         A05U8M5yhK23xvu87WV8u+B2bfV4OI/CNbP6MpsvI3SdH8QVtFjcnUVbG1IEB6+b8abc
         mU7ady1j0MwDFADEj5w+KTFEY96mFGbT3pHklNQ+xsrMxzuO3Fp76RZVvfIqvcFfZCws
         Nstw==
X-Gm-Message-State: AC+VfDyzOuemeuseytOeonOGCVdX6eRcTHC11hxIUvOfP6lhbv/sPIkR
        CwindHEnV6OPO1Z3ZHWCQS4qT7aKLufh1Q==
X-Google-Smtp-Source: ACHHUZ6nJLsWqU4SPC+H50CZgItQBxSSpPEPOrwQtTyPsyZwAstUdKLEPtJpZvNoI90rcQnh3WcdGQ==
X-Received: by 2002:a1c:e90d:0:b0:3f8:fc2a:c7eb with SMTP id q13-20020a1ce90d000000b003f8fc2ac7ebmr27588599wmc.5.1688045542818;
        Thu, 29 Jun 2023 06:32:22 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id m9-20020adff389000000b00313f551b032sm10122946wro.53.2023.06.29.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:32:22 -0700 (PDT)
Date:   Thu, 29 Jun 2023 14:32:20 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Subject: mainline build failure due to 8295efbe68c0 ("md/raid1-10: factor out
 a helper to submit normal write")
Message-ID: <ZJ2H5FWuo9oDMgPm@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build x86_64, arm64 and arm allmodconfig
with clang (version 16.0.1), and the error is:

In file included from drivers/md/raid1.c:52:
drivers/md/raid1-10.c:119:25: error: casting from randomized structure pointer type 'struct block_device *' to 'struct md_rdev *'
        struct md_rdev *rdev = (struct md_rdev *)bio->bi_bdev;
                               ^

git bisect pointed to 8295efbe68c0 ("md/raid1-10: factor out a helper to submit normal write").

Reverting the commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.

#regzbot introduced: 8295efbe68c080047e98d9c0eb5cb933b238a8cb

-- 
Regards
Sudip
