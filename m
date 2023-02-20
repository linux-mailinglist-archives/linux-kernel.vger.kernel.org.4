Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69E469D204
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjBTRRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjBTRQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:16:57 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA99220D12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:16:49 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BF4C15C19CD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:16:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6064C5C0BD3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:16:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1676913408; a=rsa-sha256;
        cv=none;
        b=0ufW5SNpbvngzLTqBJXhVok3l5WGs/7JTxN7RyV3Zwhx7DSbbHoBIJ+hR1lmy096gTpQRP
        tZRnr+a1HTV8foXr8tJ19rUspStvGgAUODBzA/+7Wjh5DK2auLhdhC0C7z8XnYNyi9rloV
        k0Blo5CdrrEtxS5d8kp/m5xwNKHY2lSQwFq54PYnsiDuX3H+L0X2l1iu5vUKBboN8/wKDl
        n1sz53zApPvSht3zc+5LULX2FiqeO9X5HQX38O/c81W2ZNduQoPKhyQgTHLj13k5tRjXCK
        JXb12tf6d2wa3SKKuy7nhpdU54gg/DyU3rU8k0ubycZadpQwbUW+EvDqUgq72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1676913408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=fUu5dy7aqGfj6EXLkWJV8gzrUOJ39VlTABuiXGf/DAY=;
        b=dWv8T6EfGWnWfCcAqPLtxresHVmUaAPkwYmnChDuuSVqErJatinWWUOQF/yJts2O3nEF70
        37o9cn0f2OT+Cc5zD/ismISXQ8R4rKUUZVRUfL0BlCDvFLv4vmaU3UBikYYd/lWRNDxQ46
        9UACjHt8ZJGVCUa6UOx7PkF/M5rZLFEnvf9DpwaJ/OHcGGaf/8VeIxlBAavkjXT2Sh7COk
        wIX8lKZc1aosjm+8RXakqatGozKZrjfy8Z3BK89oV157AZm42OxsIXC5fK2o2ekt8Xybo+
        S4sDp/9sG2N/e6CJNE3xQShOha/lThI9+5PkydsJvanCEvFHI+JJrea8fokOMA==
ARC-Authentication-Results: i=1;
        rspamd-5db48964c-486rq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Macabre: 5e36eba47d340947_1676913408614_2560142400
X-MC-Loop-Signature: 1676913408614:1678862639
X-MC-Ingress-Time: 1676913408614
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.101 (trex/6.7.1);
        Mon, 20 Feb 2023 17:16:48 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4PL8Gl1mK9z1Dw
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1676913407;
        bh=fUu5dy7aqGfj6EXLkWJV8gzrUOJ39VlTABuiXGf/DAY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=oizMo8h8X0zgNVSz/6yhg8Unuwn+LyOASs/GaiBa5lJZoI4RqD5eNKfWf1+Vy+OX0
         yqFQoihSD0/b2C8QrM1J5naHejiLxMUA6Y10JbaEfZaqRunqILMW2/yVJoUWFMwHVl
         XovQOnLWQ6Drv/037PMZkbB6BymxPGFCm/tc4KRs=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0067
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 20 Feb 2023 09:16:43 -0800
Date:   Mon, 20 Feb 2023 09:16:43 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: [PATCH linux-next 0/2] x86/xen TSC related cleanups
Message-ID: <cover.1676610413.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Enclosed please find a pair of patches that perform some additional cleanup
that was suggested by Boris and Jan.

Specifically: this resync's arch/x86/include/asm/xen/cpuid.h from its
upstream source in the Xen tree, and then uses one of the new #define-s to
replace a constant in x86/xen/time.c that was previously only numerically
defined.

Krister Johansen (2):
  xen: update arch/x86/include/asm/xen/cpuid.h
  x86/xen/time: cleanup xen_tsc_safe_clocksource

 arch/x86/include/asm/xen/cpuid.h | 22 ++++++++++++++++++----
 arch/x86/xen/time.c              |  4 ++--
 2 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.25.1

