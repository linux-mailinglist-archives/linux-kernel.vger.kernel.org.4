Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78456162CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKBMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:40:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B74B24952;
        Wed,  2 Nov 2022 05:40:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h14so16114292pjv.4;
        Wed, 02 Nov 2022 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHCEBjSk35W8v+qIx0wSklMRZE1O2YIm2XpIeOcui+w=;
        b=KzOU+DB+/NX2fybtdftG4qJ/FyhmlBW+oXWuZZpOzotfkVJQA8Yo02XWNjCEJ7E8tT
         CVAhew3y/xsV5yC/ZsjKV0N1E1NKU32NNEDNRtogBvVI783v6HVOnXORRz5oqyq8X9YC
         B8/vdo01PExUhKvG3TQSojafqe6KHbJUd+8a3IjwRFr5VnL7eWgdHWECHgS3qWh4UXXF
         nuz9Whq8NrHVc9M2Ex92YxPt97dpLb8QVZ+DIo8LeTTnUwX77jLfMb+y2FDj0gVswbSn
         jDzPmL3NeDVJKuTknqA7e5IbfeTPiGIJRmxySDaHRw6s4G+ye/HZB7G1DxmDmB6wIaQ2
         OYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHCEBjSk35W8v+qIx0wSklMRZE1O2YIm2XpIeOcui+w=;
        b=4nd8n5vLY7Ufhf51s0tor7yckOBuJ/nQWoKKTJIddAzn3xuPu6HZdbUQbeevotjweR
         CZJRd72rCcL984Hw09Jhw1YFwg6ClvN6w7HXs+S9kZYKsX2zeMXX0Dp79R39TUiA0vze
         JRMOrwxzMFbDKKJCgb6NKjTXDbxkQrvQO883zM+24PA3EDPV0TLKk95Yqoai1IdpumxX
         8ioxi5Ur9yD0Ck3HPgQn2ZoENBCw1jvzzz1bcfOUUSjdnx1ylGs43RvgS1MXQ+9OoRe5
         GUNHdsLR1XVGOrkCiqFCApFoFepfbOqIog0u3p9GOyz6xk79ShWBDl75HXJQ5xH233Ub
         IA1w==
X-Gm-Message-State: ACrzQf383PhcoZefF/4SD+5WCp/jVOVo39Px9HzShDZzwGQ2DBiwLrTA
        KmkiWBp+/M5HEnLC6vDVNbs=
X-Google-Smtp-Source: AMsMyM4hQpjdUDfRMpfRL9MeFrxvblEMLp8Dbwt4r+dcb/JrC97EhB/4Qw4eX0rsgmrqRdNF1FVNeg==
X-Received: by 2002:a17:902:dac7:b0:187:411c:4f19 with SMTP id q7-20020a170902dac700b00187411c4f19mr5492492plx.100.1667392808549;
        Wed, 02 Nov 2022 05:40:08 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id f19-20020aa79693000000b0056c003f9169sm8339360pfk.196.2022.11.02.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:40:08 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [PATCH 0/5] A few patches for block bfq_log_bfqq()
Date:   Wed,  2 Nov 2022 20:39:51 +0800
Message-Id: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

This series contains some patches for bfq_log_bfqq() to improve bfq log 
readability.


Yuwei Guan (5):
  block, bfq: remove unnecessary value print
  block, bfq: do bfq_set_next_ioprio_data() after setting sync mode and
    pid
  block, bfq: don't convert pid type in bfq_log_bfqq()
  block, bfq: change "secs" to "sects" for bfq log in bfq_bfqq_served()
  block, bfq: print bfqq addr for each bfq_log_bfqq log

 block/bfq-iosched.c | 27 ++++++++++++---------------
 block/bfq-iosched.h |  4 +++-
 block/bfq-wf2q.c    |  5 ++---
 3 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.34.1

