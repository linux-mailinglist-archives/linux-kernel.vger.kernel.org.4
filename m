Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0640D674C95
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjATFhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjATFgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEFC3EFED;
        Thu, 19 Jan 2023 21:33:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CFBEB82487;
        Thu, 19 Jan 2023 14:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4A2C433EF;
        Thu, 19 Jan 2023 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674137743;
        bh=y0t6GNF97oojUan/jaNoYS+HcnhPuwYYN6KZoLbCUaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/jk/087duO+/BTUotk2esK9d/IyI7KDNb/PVilAxFldVI1vWXTGjKIQ6jhcq94BZ
         oVKUKykGi1vXyd3Cj3gH94op4ijiFpHwDv93aF5GVreNjiY3p4yzysjc+XTNnl6C2p
         ZJW6Q5z00CI1D60gm/i7XiQ03JbM4Y47gGMc82cI0w9VcFf/Vf0Qzjh8lcGoXs7APw
         7omYmPOQ3yC9ZS994xuNnZxEkwV7mJFnH9yLJpLHV7C0xqZNWE0XCBTCZdr4OfwT4f
         fxWEoEJ1RsAkpDSW5V6spvIcDjimilw4sn95KCxQkmWsYAR+FCjnNVnh7f1fN/Omvu
         MGOPXOktQatqw==
Date:   Thu, 19 Jan 2023 15:15:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        quic_neeraju@quicinc.com, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] rcu: Further comment and explain the state space of GP
 sequences
Message-ID: <Y8lQjKKDd0G2zt3F@lothringen>
References: <20230119141134.686626-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119141134.686626-1-frederic@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:11:35PM +0100, Frederic Weisbecker wrote:
> The state space of the GP sequence number isn't documented and the
> definitions of its special values are scattered. Try to gather some
> common knowledge near the GP seq headers.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 115616ac3bfa..fb95de039596 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -14,6 +14,39 @@
>  
>  /*
>   * Grace-period counter management.
> + *
> + * The two lowest significant bits gather the control flags.
> + * The higher bits form the RCU sequence counter.
> + *
> + * About the control flags, a common value of 0 means that no GP is in progress.
> + * A value of 1 means that a grace period has started and is in progress. When
> + * the grace period completes, the control flags are reset to 0 and the sequence
> + * counter is incremented.
> + *
> + * However some specific RCU usages make use of custom values.
> + *
> + * SRCU special control values:
> + *
> + * 	SRCU_SNP_INIT_SEQ	:	Invalid/init value set when SRCU node
> + * 							is initialized.
> + *
> + * 	SRCU_STATE_IDLE		:	No SRCU gp is in progress
> + *
> + * 	SRCU_STATE_SCAN1	:	State set by rcu_seq_start(). Indicates
> + *								we are scanning the inactive readers
> + *								index.
> + *
> + *		SRCU_STATE_SCAN2	:	State set manually via rcu_seq_set_state()
> + *								Indicates we are flipping the readers
> + *								index and then scanning the newly inactive
> + *								readers index.
> + *
> + * RCU polled GP special control value:
> + *
> + *	RCU_GET_STATE_COMPLETED :	State value indicating that a polled GP
> + *								has completed. It's an absolute value
> + *								covering both the state and the counter of
> + *								the GP sequence.
>   */
>  
>  #define RCU_SEQ_CTR_SHIFT	2
> -- 
> 2.34.1
> 

Ok perhaps this one got the tabs right:

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Thu, 19 Jan 2023 14:29:34 +0100
Subject: [PATCH v2] rcu: Further comment and explain the state space of GP
 sequences

The state space of the GP sequence number isn't documented and the
definitions of its special values are scattered. Try to gather some
common knowledge near the GP seq headers.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 115616ac3bfa..fb95de039596 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -14,6 +14,39 @@
 
 /*
  * Grace-period counter management.
+ *
+ * The two lowest significant bits gather the control flags.
+ * The higher bits form the RCU sequence counter.
+ *
+ * About the control flags, a common value of 0 means that no GP is in progress.
+ * A value of 1 means that a grace period has started and is in progress. When
+ * the grace period completes, the control flags are reset to 0 and the sequence
+ * counter is incremented.
+ *
+ * However some specific RCU usages make use of custom values.
+ *
+ * SRCU special control values:
+ *
+ * 	SRCU_SNP_INIT_SEQ	:	Invalid/init value set when SRCU node
+ * 					is initialized.
+ *
+ * 	SRCU_STATE_IDLE		:	No SRCU gp is in progress
+ *
+ *	SRCU_STATE_SCAN1	:	State set by rcu_seq_start(). Indicates
+ *					we are scanning the inactive readers
+ *					index.
+ *
+ *	SRCU_STATE_SCAN2	:	State set manually via rcu_seq_set_state()
+ *					Indicates we are flipping the readers
+ *					index and then scanning the newly inactive
+ *					readers index.
+ *
+ * RCU polled GP special control value:
+ *
+ *	RCU_GET_STATE_COMPLETED :	State value indicating that a polled GP
+ *					has completed. It's an absolute value
+ *					covering both the state and the counter of
+ *					the GP sequence.
  */
 
 #define RCU_SEQ_CTR_SHIFT	2
-- 
2.34.1

