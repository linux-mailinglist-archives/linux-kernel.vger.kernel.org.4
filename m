Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D133E5EB659
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiI0Ajf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI0Ajc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:39:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514682F1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:39:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id jm5so7673962plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=VX2MaE9LikBhqm6H7NNpI0lGV1JO9WgBYPEB/xrhSCo=;
        b=YwtHnhJceFnNIVilGBVx9cSvCigPxI59ZkQ1T0nGE0v1mNNFb2G5Hz1qzcj9ujfxgI
         c9vpPUYgPJQ+qzKRsFIZ2Yd1YH+r04WMIDBsSKrTO6myvpcZLQl9f6gzAx3cclMr25jc
         Hwsrg2mnYMRCu9fy9IGbdt+ajb4PDfLs7xRlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VX2MaE9LikBhqm6H7NNpI0lGV1JO9WgBYPEB/xrhSCo=;
        b=1hrv7fvbO1P86fQQOji9y/a+Eq2OfVO+Xh8k4PU1SyaG7ZB3ukkHpLPatcIgNo4Gz3
         Y6HjBh9Boie0qPcPQKsJJsV9DRJhLfXFxn/Fe2HaGoV+ufDvLdYdSvuYbn9N0J5lxPFk
         4PM/3DsZ4C82dIK7QlKyzLRsobxXHtbgBgtaAIjQhzaWp/l80vwK+phMpI4/6v/55FFy
         4N3Z/Ph91sy3l8+qn6dusQAIgIHWiOpDlu7zeFQFNe4yn592R/NY3yN1qLdxfCHTd2bW
         tmj07/P7FqG5Js91i9fBcGJ86HCC1RoSCTO86Zz+mbqZeVbHPOKa/ay3SXbDGqu3wB/V
         Sh1Q==
X-Gm-Message-State: ACrzQf1UZHGhr8rCd/vNUtFKUH755Yr9s8TqJL93igLckVql6HYJ5+nn
        jWn0l8IbPGqTVxLj4QrBBsFlbj2cWqAepQ==
X-Google-Smtp-Source: AMsMyM5DVURFTCAOIIMHItb2UrnHwYT2a0/eoTPPSiuYYk+8kcKUVmLnzZHx/NHQdiEOvoh+g8qfdA==
X-Received: by 2002:a17:902:d4ce:b0:177:fe49:19d2 with SMTP id o14-20020a170902d4ce00b00177fe4919d2mr24786788plg.4.1664239169812;
        Mon, 26 Sep 2022 17:39:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k129-20020a628487000000b0053e5daf1a25sm139467pfd.45.2022.09.26.17.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 17:39:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] w1: Split memcpy() of struct cn_msg flexible array
Date:   Mon, 26 Sep 2022 17:39:27 -0700
Message-Id: <20220927003927.1942170-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; h=from:subject; bh=S5QP3TPQ007bwTwLGs3iHsjr0YjJtqD/x5tIisFrd8k=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjMkY+50POBINt2mFF6tH8OhzUmiluofkXebM++j5G Vgtu0j2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzJGPgAKCRCJcvTf3G3AJquWEA CNazGUUbkJni6TliGwbV4IEgK1WC1RFd1apveljb1lfn3tDGpufcLn4Q9V94nilYf8GeNi3qbg95/y S9lwOAF74Jg1+34s7K/Wzz5/J07EQtndDPEoMZ+JUxt8MoG9E9JW+0rEJmBJ8jLPNQPkqklgo+8ep1 8QETDirCbP1PNhcqS2nHr9dO4JJRaNJcP4RnId/TTdb88i4foxxu0p0kQRX8IB8EvzL777eoMA70gR omlaTJJOKJS5+ZUnM4mOoZPbXbhGT9pewc038LA7092mIGTip9LhWY9FxUlAuMMPu4R6bp9tKrHPPm lEqgKo76aSqOre1c/TiyXRSMgd27XjoyEjN5AUWQm1iKyg0tTo2rCH1VEqK9+F0Ns0qEW3bXAN0AMH rqoFVZ8kKp6Ebo08CfC5P6LlQjJxdi4Ix3qE0ZHOg1MQvE7RjvdMLVoN8iI29hvfBsPKsdyza1MdZz e9Hgy7rJg9PF8VjT2SxDRPvp6cORUf8lBUMPigf4ejrKb5mOjNdZImir0WpQFBXgGxmhtWLuG1E9VI 8uV2GvFBvRymlgoJczQ5e+fAjaAS3diFMnnH9tNm4yrdJZTXTEtZjyGqT8QdhYVJw6+SRhDvL/c1Wm DbmfhGedHB35z+BhSKXKf10xmRJAsJjCxnmYuHm8X9xP0IIvjyIPfgbUIhrQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To work around a misbehavior of the compiler's ability to see into
composite flexible array structs (as detailed in the coming memcpy()
hardening series[1]), split the memcpy() of the header and the payload
so no false positive run-time overflow warning will be generated.

[1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/

Cc: Evgeniy Polyakov <zbr@ioremap.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/w1/w1_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index fa490aa4407c..db110cc442b1 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -611,7 +611,8 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 		}
 		atomic_set(&block->refcnt, 1);
 		block->portid = nsp->portid;
-		memcpy(&block->request_cn, cn, sizeof(*cn) + cn->len);
+		block->request_cn = *cn;
+		memcpy(block->request_cn.data, cn->data, cn->len);
 		node = (struct w1_cb_node *)(block->request_cn.data + cn->len);
 
 		/* Sneeky, when not bundling, reply_size is the allocated space
-- 
2.34.1

