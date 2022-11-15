Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B19A62A357
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiKOUtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiKOUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:49:08 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41AF7D;
        Tue, 15 Nov 2022 12:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=USwSRFESZzf+4Lm757bVfbPV8dteEKJuMeMsGiYUTng=; b=Az8gETdCuJDCVCYZTqc0emOvy5
        S8JcspxVFRr7xQZ+6S2yvPP9FxvyAYrqrOW76JIv9Dr8EplAnCrJYmfTRhS9moibRlpwHeW09M+Cz
        X3RVi3ljuMOLn7+etzlIX0ijUJAqsW1qntk8UZwH3WzygkgCC/IsbWWOLEznLviLJCGao/tW7fFAp
        mMHdsPSeq7RoLUI6VpIuMKzc6RV7KZ0JujWfdlpLJecg2ymvEAOVMNoUin2refCPnq51OKv2eCE6y
        KLfIP8ZxBDg1N5ipZr4s6sJqIvFIpiOUSSWybS6XqJa+6fpbEFiRHi61YcAifW5/3ZtSmoyLIyhLG
        DY4AXV7g==;
Received: from [179.232.147.2] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ov2rc-001Qk7-2d; Tue, 15 Nov 2022 21:49:00 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org
Cc:     rcu@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
Date:   Tue, 15 Nov 2022 17:48:47 -0300
Message-Id: <20221115204847.593616-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function match_records() may take a while due to a large
number of string comparisons, so when in PREEMPT_VOLUNTARY
kernels we could face RCU stalls due to that.

Add a cond_resched() to prevent that.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org> # from RCU CPU stall warning perspective
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

Hi Steve / Paul, thanks for the discussions on the first thread [0],
much appreciated! Here is the "official" version.

Steve: lemme know if it's good for you, and in case you prefer to
send it yourself (since you proposed it on IRC), fine by me!

Paul: kept your ACK (thanks for that BTW) even though I changed the
place of cond_resched() to align with Steve's preference. Lemme know
in case you want to drop this ACK.

Cheers,

Guilherme


[0] https://lore.kernel.org/lkml/1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com/


 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7dc023641bf1..80639bdb85f6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4192,6 +4192,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 			}
 			found = 1;
 		}
+		cond_resched();
 	} while_for_each_ftrace_rec();
  out_unlock:
 	mutex_unlock(&ftrace_lock);
-- 
2.38.0

