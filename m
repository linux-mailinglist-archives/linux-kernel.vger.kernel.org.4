Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F966069FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJTVCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJTVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:02:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E6CABC0;
        Thu, 20 Oct 2022 14:02:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a3so1540312wrt.0;
        Thu, 20 Oct 2022 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xb9OuFfShbk1zmBdU9t2whIn89Cs7N05c9hSHXwNLbg=;
        b=Vjn+gBOxO00mhNYMVLOiGaVG772I20ExWGLjR2PfAwqYrX+NfyJ8/67fCRkI+vAo6a
         m5dPyHI7dqCzIHM4YD0cpeUop++eoFFWehwhb0iWsx/allnct96GpJjHyfkSvp/YpXoy
         auHGEbKFA6FEr/z0gGztBwKSTDCG6KGST93hAh+ecgQvIqXMn6CxYtmhGiS4bUpLcfPZ
         oZD2puw+zt/6y1Fx6sxuMU7HO4UlszkEFic8hm1c7ao2fDQt+xcCmgsceuxSBm6CB7Yh
         V8Lm3WYDwtax9aUeuM0GqvMAwig+4KRT6kL6EXcCd1Ij/IkXez29iV2Rz+8im5zAXe8u
         DeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xb9OuFfShbk1zmBdU9t2whIn89Cs7N05c9hSHXwNLbg=;
        b=4sagYl5UIje8Bcq9STn5K+JKpGViR6s6rtH2bSVVtmVlnZ3Qm7dH5zOStF7H1lTQx4
         YcpoGvsZYyqRb+GWCpC1e5ZEv2v2ldCwmZTvGIEJJ6gXeXBbN1b9O6PJvrD9/69JWjk2
         PlMtLaXrsm4x1e0RFGYZWcUg9wZCfgjPrkC750lIkL9CUcbukdtQ2B7L6QLb4NiO7ZKi
         3O4mCMiBQj4/v0XKOeuiEO5+6M8oWAfQnd9KVN+Pt2YFdxpwCR+VQnv4nZqh1BPMyzgn
         S7w12eBMlckf9vw3UcPoMALHOY+xQJfBM/+chAnJbxqMl4syewJxTYfmir28KX+jlmVd
         ZHZA==
X-Gm-Message-State: ACrzQf1N115JgMxVIFCuWLXrWRm/bzpsylB+h1lOpydupOazMhHNSQKW
        Mp5uvJFHmjjnybwfOMAqblQ=
X-Google-Smtp-Source: AMsMyM5NaTQoqsewNFR9sI+PSyt9Ke9RhPVAXOTiK5PjsWmhgGLCtl3uLs5s9V/N28WheaHc80flNg==
X-Received: by 2002:adf:f1c9:0:b0:236:49ee:8598 with SMTP id z9-20020adff1c9000000b0023649ee8598mr2243627wro.481.1666299740494;
        Thu, 20 Oct 2022 14:02:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b003c70191f267sm786923wmb.39.2022.10.20.14.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:02:20 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] hid: intel-ish-hid: ishtp: remove variable rb_count
Date:   Thu, 20 Oct 2022 22:02:19 +0100
Message-Id: <20221020210219.45131-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable rb_count is being incremented but it
is never referenced, it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: Fix commit message.
---
 drivers/hid/intel-ish-hid/ishtp/client.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index df0a825694f5..2d92fc129ce4 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -841,7 +841,6 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
 	unsigned char *buffer = NULL;
 	struct ishtp_cl_rb *complete_rb = NULL;
 	unsigned long	flags;
-	int	rb_count;
 
 	if (ishtp_hdr->reserved) {
 		dev_err(dev->devc, "corrupted message header.\n");
@@ -855,9 +854,7 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
 	}
 
 	spin_lock_irqsave(&dev->read_list_spinlock, flags);
-	rb_count = -1;
 	list_for_each_entry(rb, &dev->read_list.list, list) {
-		++rb_count;
 		cl = rb->cl;
 		if (!cl || !(cl->host_client_id == ishtp_hdr->host_addr &&
 				cl->fw_client_id == ishtp_hdr->fw_addr) ||
-- 
2.37.3

