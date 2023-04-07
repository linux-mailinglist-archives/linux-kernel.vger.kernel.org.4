Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39D6DA67C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjDGAO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjDGAOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:14:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B861974D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 17:14:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l7so38617268pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680826487; x=1683418487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUpe4fyEON5BGY/Krg7UBwYk33mDfZbzhByBXKF1Op4=;
        b=m74H6gd95HlYt1gDFCvGLe/zXtZdmzdmmd0nLY+aZlBOnxkhnNMpUjH5Pp0l2xhk3e
         b67rp9yxFSMajvi/6fKrDU8mTpsWv0vkDELuKk1qmz/657hdT6n8oByT6zyswNB30tM7
         5eGJdfoqs9EoSrNZjD3GV/lIEdlwUdKm8IcpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826487; x=1683418487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUpe4fyEON5BGY/Krg7UBwYk33mDfZbzhByBXKF1Op4=;
        b=YPrmmUSsXceDYhRyCLGvA0/GwjA2tYTnodI2Wnbm5PmRdv5MIcAdwYN9JFG79o6/lI
         CaRCer+pWDpAoahn38X+i2RScP3VFNjmLgQYByjVP2G8OP7vc3PicpRDF8BJkrAFHdie
         u97LbAAYHrYsZxvrE0Rtzm6Mw7t/wZeUmZKcXR9GW3sCfCGeYZeBbx0ZBkhsI46rKYdR
         GwGnapVgKT8Sc8Jj2KoiMOxFghhwnZAJlqCPdOjJGjPiGWTXKDTcQs/COz6C8lxk1EJO
         RodnDQb01IjdgTV+Agm6gq8/JX94cxgWDGEZ1UTRJQwKfI66HzCjAfQmFB2Af6olGsUe
         /xQA==
X-Gm-Message-State: AAQBX9c5vJaHB2fFUzRAQeQYyzSfyMf8c4UIsyGqh9xtW0ZmEY0mIcGg
        8kl8ZT/cHUtoR8Kk+c8r52f0cw==
X-Google-Smtp-Source: AKy350ab+eYRqbZGGh2TuIO/xigh1TQ8o6ezz/1TWY1fsvV+Ukb/Gh4eTgZgIhkf4WaYuHS6fu0lnA==
X-Received: by 2002:a05:6a20:dc9f:b0:d9:7424:3430 with SMTP id ky31-20020a056a20dc9f00b000d974243430mr1007563pzb.15.1680826486769;
        Thu, 06 Apr 2023 17:14:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:2f1a:b18a:6c4:e53e])
        by smtp.gmail.com with ESMTPSA id d2-20020a655ac2000000b00513c549e98asm1612495pgt.68.2023.04.06.17.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:14:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        David Ober <dober6023@gmail.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Jean-Francois Le Fillatre <jflf_kernel@gmx.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] r8152: Add __GFP_NOWARN to big allocations
Date:   Thu,  6 Apr 2023 17:14:26 -0700
Message-Id: <20230406171411.1.I84dbef45786af440fd269b71e9436a96a8e7a152@changeid>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory is a little tight on my system, it's pretty easy to see
warnings that look like this.

  ksoftirqd/0: page allocation failure: order:3, mode:0x40a20(GFP_ATOMIC|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
  ...
  Call trace:
   dump_backtrace+0x0/0x1e8
   show_stack+0x20/0x2c
   dump_stack_lvl+0x60/0x78
   dump_stack+0x18/0x38
   warn_alloc+0x104/0x174
   __alloc_pages+0x588/0x67c
   alloc_rx_agg+0xa0/0x190 [r8152 ...]
   r8152_poll+0x270/0x760 [r8152 ...]
   __napi_poll+0x44/0x1ec
   net_rx_action+0x100/0x300
   __do_softirq+0xec/0x38c
   run_ksoftirqd+0x38/0xec
   smpboot_thread_fn+0xb8/0x248
   kthread+0x134/0x154
   ret_from_fork+0x10/0x20

On a fragmented system it's normal that order 3 allocations will
sometimes fail, especially atomic ones. The driver handles these
failures fine and the WARN just creates spam in the logs for this
case. The __GFP_NOWARN flag is exactly for this situation, so add it
to the allocation.

NOTE: my testing is on a 5.15 system, but there should be no reason
that this would be fundamentally different on a mainline kernel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/net/usb/r8152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index decb5ba56a25..0fc4b959edc1 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1943,7 +1943,7 @@ static struct rx_agg *alloc_rx_agg(struct r8152 *tp, gfp_t mflags)
 	if (!rx_agg)
 		return NULL;
 
-	rx_agg->page = alloc_pages(mflags | __GFP_COMP, order);
+	rx_agg->page = alloc_pages(mflags | __GFP_COMP | __GFP_NOWARN, order);
 	if (!rx_agg->page)
 		goto free_rx;
 
-- 
2.40.0.577.gac1e443424-goog

