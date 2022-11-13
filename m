Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5480C626D58
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 02:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiKMBrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 20:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKMBrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 20:47:35 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479AFD01;
        Sat, 12 Nov 2022 17:47:32 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AA5ED5413B7;
        Sun, 13 Nov 2022 01:47:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B368E54158A;
        Sun, 13 Nov 2022 01:47:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668304047; a=rsa-sha256;
        cv=none;
        b=C/a36Lue2+xlU0Gx9n1S0GpQ0v4+aZ8BpvKLAlsf3ggjP5DhZCIsN422eKbk7vnBTx3XXy
        y6TwInxnqI8W4SzxEFz0+p/93VNcjcGyN4jdGr+WmgmvNVlvkChgDtHmpsBpMIfCJAVT+c
        LQ11wMeRqv57migfpoj3mFP/vx6wenrrXwSl0noWmQkacn8ZVWt8WfEeIjwcQVb4AEF3z4
        CZjB4Z4OESe0sWncIhCCMKfm/YDTePZR2EkwPzw+1pq0/4Y1CnY9notLiAIuHKDwlifzBM
        91eTtydt5bI+/D0fNM+v2Bok2y1EVdR3phM0353k0UnG/TgX0loYOQjQwPVfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668304047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=8MXI6eMFhlcVW6d8iIhtDQvZaOjaIpdiHvOtU2ZUZ2k=;
        b=8gNzcAmAMRLYd9WAdv0nnXm39tWnCpVxkrT106iK/w+JV0k/5H15k+Nr3k1SYHyPF7nYWj
        asp57fNAU/ttWiZBfvvzFuMBWuyAjbaS6ht12ivF2ac4y6IuT5yAgyn92l2gpWkI72YKm5
        9TTQmbIql+JUCVHvzgwKOPCIAzxadM82tHrUi07I0p9KRNQiS8YvwUdNSgvvzRAFXUAX92
        vIgufc2EK40X5gQZOq303CeuEjuCHpHAflmicZ8W1PRn/I83XHxImgMRMsQHr7aUr4T7dF
        5jaohrsnVv7O/1XPffvSE+xBXH6fiyvKbI0WUtB2Y/iIDK0eS/myAQwooB1wUg==
ARC-Authentication-Results: i=1;
        rspamd-5cb65d95c4-2vfk6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Stop-Belong: 35b1dff75189b88b_1668304048091_1075577376
X-MC-Loop-Signature: 1668304048091:1382251446
X-MC-Ingress-Time: 1668304048091
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.13 (trex/6.7.1);
        Sun, 13 Nov 2022 01:47:28 +0000
Received: from rhino.lan (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4N8wL61ZxCz6K;
        Sat, 12 Nov 2022 17:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668304047;
        bh=8MXI6eMFhlcVW6d8iIhtDQvZaOjaIpdiHvOtU2ZUZ2k=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=T0kmReoQTSo7nU70DDaPYP0Wxyngq1XNDels0E30wwdp9eZGCN80MxxoQ4UePHVnx
         SEGQnotwSFaURglPuBQyrWplp5YSHRwVRFKd5UtDhb/omQNEKvoIwV4ZD4DSF6PiWJ
         fYIvGDI6+CO0NbDgtxrE7OGsziycHjMNuvIeKuxQwe4dIEYISMgPb8EpEXVo0qWImL
         vLxNP/r3nYJCP3THqwG/acvLmpSbA0Zz3GHObTRIcfF3/LzBypzBqMLbSBjemuXXhP
         mYaJg1EaWNY5bH64PMGWyQp8m/k7Y6yvfbhda3V6yzE8wiWk3zitAhRMqYUeLGwlJr
         LjbtzR+T1tvfQ==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH] staging: media: sunxi: cedrus: make vb2_ops struct definition const
Date:   Sat, 12 Nov 2022 20:47:03 -0500
Message-Id: <20221113014703.138717-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up a checkstyle warning where the vb2_ops struct definitions
should be const.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/sunxi/cedrus/cedrus_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index 66714609b577..0664b4a4fdac 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -548,7 +548,7 @@ static void cedrus_buf_request_complete(struct vb2_buffer *vb)
 	v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->hdl);
 }
 
-static struct vb2_ops cedrus_qops = {
+static const struct vb2_ops cedrus_qops = {
 	.queue_setup		= cedrus_queue_setup,
 	.buf_prepare		= cedrus_buf_prepare,
 	.buf_queue		= cedrus_buf_queue,
-- 
2.38.1

