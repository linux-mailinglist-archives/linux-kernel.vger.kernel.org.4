Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8174E37C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGKBhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGKBhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:37:00 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F51ADB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:36:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C9107100C30
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:36:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 72AE1100A4F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:36:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689039418; a=rsa-sha256;
        cv=none;
        b=UD3O9u4n99Fu05nraQIakrj4U+9LLYZisQT0XKfdV4j5Kgtp4dVwus10mPBxWa3aWYa31T
        GBu2n4gQfB5Ir71H54q2wX84rNBblQRm+Nkyq3JLlvZmRZxUqwVDblvC61iRMXlu3k6vqn
        7fmVm42X1DHbFIbIWiJU6uhyOOk+yU6WLDjOESDq+NDIQ7Ckh2ccA2OJAPvwgJx8I7W6FH
        DP+9XTC3wpPcXbcUyJwKzsOnb6pWQ65ODTbAHlymgjfT7AaPfV/On43v/zXhksC1o5ptUn
        ByI+CMqVXNgEIA5lDg2QiKAR2ohe5pv2oAjbvuORJMbCsUmdGhcpLSL/nOpEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689039418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=9C09DFYjbkA3qX/xOCH7vHdTDVOZKKI2r2CDGzvM66s=;
        b=moAaFgwcuVytf5G9hRyEtHAENX8KR0sW0pD6kNo85kxJbr8VPY9xM+9wqslGnrfBBM7AnE
        K5aRLeWudiG/B7GOZaSzWIIZyuNxs9k45yVnMxb6MPc61EaARNMyfrNqeBKfm0lYvo3W+9
        0Q6BPmUvPCwwHKUh2QSX1Oi6EoRKB9lW59qmp7dRrUBvna9gF6l/cjnpdQbwNvbH4OX6Pz
        5Hs4TmDBK7edqx2TPLztxbXJSwp/wUDSLGxi1bFtxjE1Q8X0zfavTM2bSdMTkQTWKglb6g
        XCBlADaSxuivQdROVNcBuXLhxtBhM6AaNjlN0hHsJ4gyMei+tdavJvdmt8RNyA==
ARC-Authentication-Results: i=1;
        rspamd-5595f87fc9-5plst;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Versed-Unite: 72f12bbe2c3094ce_1689039418677_295868261
X-MC-Loop-Signature: 1689039418677:908452368
X-MC-Ingress-Time: 1689039418677
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.185.6 (trex/6.9.1);
        Tue, 11 Jul 2023 01:36:58 +0000
Received: from kmjvbox (unknown [71.198.86.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4R0NlF62Tnz10Z
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1689039417;
        bh=9C09DFYjbkA3qX/xOCH7vHdTDVOZKKI2r2CDGzvM66s=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=XxxE/XQ3lwRN4gW4IwCC7Rc0XyOVile4FxwTjmf2dgJ2hK7imiwXYWJE/iaIsz9dN
         5BbsegwtyAAhzu5nF7JCfHSuL7vAD3n5PDUveGRTTbu+5PgUgzUeiX/24HlpWfjLJm
         bZkkFqS1kOIm/U3u39HJB4c9TYJu5ooNajp/i0PM=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0085
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 10 Jul 2023 18:36:21 -0700
Date:   Mon, 10 Jul 2023 18:36:21 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: ena: fix shift-out-of-bounds in exponential backoff
Message-ID: <20230711013621.GE1926@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ENA adapters on our instances occasionally reset.  Once recently
logged a UBSAN failure to console in the process:

  UBSAN: shift-out-of-bounds in build/linux/drivers/net/ethernet/amazon/ena/ena_com.c:540:13
  shift exponent 32 is too large for 32-bit type 'unsigned int'
  CPU: 28 PID: 70012 Comm: kworker/u72:2 Kdump: loaded not tainted 5.15.117
  Hardware name: Amazon EC2 c5d.9xlarge/, BIOS 1.0 10/16/2017
  Workqueue: ena ena_fw_reset_device [ena]
  Call Trace:
  <TASK>
  dump_stack_lvl+0x4a/0x63
  dump_stack+0x10/0x16
  ubsan_epilogue+0x9/0x36
  __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
  ? __const_udelay+0x43/0x50
  ena_delay_exponential_backoff_us.cold+0x16/0x1e [ena]
  wait_for_reset_state+0x54/0xa0 [ena]
  ena_com_dev_reset+0xc8/0x110 [ena]
  ena_down+0x3fe/0x480 [ena]
  ena_destroy_device+0xeb/0xf0 [ena]
  ena_fw_reset_device+0x30/0x50 [ena]
  process_one_work+0x22b/0x3d0
  worker_thread+0x4d/0x3f0
  ? process_one_work+0x3d0/0x3d0
  kthread+0x12a/0x150
  ? set_kthread_struct+0x50/0x50
  ret_from_fork+0x22/0x30
  </TASK>

Apparently, the reset delays are getting so large they can trigger a
UBSAN panic.

Looking at the code, the current timeout is capped at 5000us.  Using a
base value of 100us, the current code will overflow after (1<<29).  Even
at values before 32, this function wraps around, perhaps
unintentionally.

Cap the value of the exponent used for this backoff at (1<<16) which is
larger than currently necessary, but large enough to support bigger
values in the future.

Cc: stable@vger.kernel.org
Fixes: 4bb7f4cf60e3 ("net: ena: reduce driver load time")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 451c3a1b6255..633b321d7fdd 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -35,6 +35,8 @@
 
 #define ENA_REGS_ADMIN_INTR_MASK 1
 
+#define ENA_MAX_BACKOFF_DELAY_EXP 16U
+
 #define ENA_MIN_ADMIN_POLL_US 100
 
 #define ENA_MAX_ADMIN_POLL_US 5000
@@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
 
 static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
 {
+	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
 	delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
 	delay_us = min_t(u32, delay_us * (1U << exp), ENA_MAX_ADMIN_POLL_US);
 	usleep_range(delay_us, 2 * delay_us);
-- 
2.25.1

