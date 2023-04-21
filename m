Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD916EA887
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjDUKpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDUKo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:44:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043F49E1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:44:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so5393405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682073897; x=1684665897;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmqSgoVn+4GYHbRCGkxih6mgI9KXrJS4qZaVx99YBF0=;
        b=FTOGGLy/4aVVYGpSAWcxoSFoKy7NS1c2I4lPWKmOr+cOGefYqCAripq+GvJz0clFvc
         gdD/ZSwGjGsoiQa4M4qnk4eQ6o+oJj+yYItNqCY3FXuDVQcVzGHOUAXMXKkth89GctPQ
         DNmYACDMfspf2v+ljSPoWQG+S4BUzXpw/z9RMmNBYw9+D8EQe60F+m2RdU48JhipyJNu
         KjiD9hDj7MJAGsfXrIzxlFM2N0D1u4HnNshGC49W64Bm8/R98GFr/4fg1D9TDZF4IDgx
         1WgS3afclE8xJWSc+iqu9sJq29VdfKLAvTVcvAgnriEM/lX+qshDkUWZuf5f1rfzKAKC
         FyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682073897; x=1684665897;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmqSgoVn+4GYHbRCGkxih6mgI9KXrJS4qZaVx99YBF0=;
        b=d1vhqLnsmwAgguX+yH5GI2e0bIxSN/zbjNgEgiAENNL3UDufAY+XR7VU73NmgOCOZ5
         YNzWU6iGXNwadud4mpk31xvoiNx+gY9A3GYW67i8QWG6s00OxxVGV9kr6NLb2o2QG0Nh
         fj+6YuvqJ3xX4noJaNRK+5bUJBZMiXMJyXV03V/GVUjruHOQ4fLDw9QBkB2NLYppqr0J
         Vl4ILkHiUGo6z/R7wb/st1nXMY1BenbTcOsk9aoHNHoWcWyrhD40Eo1RTMcLNP1IjjA1
         Qli8BDaMDiw9bChLdYOnH1UgvDLZ0QpPuoN3YBQAS5ouvB2NSRSArgyKodJ5gC69e8Ns
         PvEA==
X-Gm-Message-State: AAQBX9caKxXBUCgAIATrlOYscxbUtEsmSmxCqFZeM4acZgGl+5xdkUNU
        D5f57eT8w9/YFmwi9E8FpPEteQ==
X-Google-Smtp-Source: AKy350ZaT1G0S2zY1VUe0Yq2m3hK6Ma2A+K1oVpKfU0a6Bwjve9Lz1EVu8IMAzOCGQdABY03xmatBQ==
X-Received: by 2002:a5d:6a11:0:b0:2f6:661:c03c with SMTP id m17-20020a5d6a11000000b002f60661c03cmr4068864wru.28.1682073896851;
        Fri, 21 Apr 2023 03:44:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002fda1b12a0bsm4192642wrx.2.2023.04.21.03.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 03:44:56 -0700 (PDT)
Date:   Fri, 21 Apr 2023 13:44:54 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] driver: soc: xilinx: use _safe loop iterator to avoid a use
 after free
Message-ID: <761e0e4a-4caf-4a71-8f47-1c6ad908a848@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hash_for_each_possible() loop dereferences "eve_data" to get the
next item on the list.  However the loop frees eve_data so it leads to
a use after free.  Use hash_for_each_possible_safe() instead.

Fixes: c7fdb2404f66 ("drivers: soc: xilinx: add xilinx event management driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Found by static analysis and not tested.

 drivers/soc/xilinx/xlnx_event_manager.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index c76381899ef4..f9d9b82b562d 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -192,11 +192,12 @@ static int xlnx_remove_cb_for_suspend(event_cb_func_t cb_fun)
 	struct registered_event_data *eve_data;
 	struct agent_cb *cb_pos;
 	struct agent_cb *cb_next;
+	struct hlist_node *tmp;
 
 	is_need_to_unregister = false;
 
 	/* Check for existing entry in hash table for given cb_type */
-	hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
+	hash_for_each_possible_safe(reg_driver_map, eve_data, tmp, hentry, PM_INIT_SUSPEND_CB) {
 		if (eve_data->cb_type == PM_INIT_SUSPEND_CB) {
 			/* Delete the list of callback */
 			list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
@@ -228,11 +229,12 @@ static int xlnx_remove_cb_for_notify_event(const u32 node_id, const u32 event,
 	u64 key = ((u64)node_id << 32U) | (u64)event;
 	struct agent_cb *cb_pos;
 	struct agent_cb *cb_next;
+	struct hlist_node *tmp;
 
 	is_need_to_unregister = false;
 
 	/* Check for existing entry in hash table for given key id */
-	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
+	hash_for_each_possible_safe(reg_driver_map, eve_data, tmp, hentry, key) {
 		if (eve_data->key == key) {
 			/* Delete the list of callback */
 			list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
-- 
2.39.2

