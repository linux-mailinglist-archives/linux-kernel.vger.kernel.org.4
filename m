Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A569FA89
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjBVRyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBVRyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:54:46 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D493139BA8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:54:44 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C31EA8C102C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:54:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a307.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5BE768C0696
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:54:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677088480; a=rsa-sha256;
        cv=none;
        b=jmg76X9+FLQzb6lmU53wQqbxNZJgZTxqormwBuZyr4t3hAJ4PQhiZQv+MfmpmS7df23dYc
        wXU3bUw+zJXcZ4oDgjl07MdPJxqIL3NJAeTRIz5XWDI/Tvl0FbfNA1eXX4fz8vuXOXWS48
        IcXEFy6OI7IkJotk4VRvrlZfkt5mjCztrNERjJGG7kEe97Da2qq05AQwcej/Z2FLQkWba4
        FKZcr+z7cNIqeHNqDz8SBI6hcHT3VBWRxgdU2fbrodCITo0J22da4IP3FYkKdoU7Jirtv/
        43fjl0ppdQKHjKtYNaKYh/dpGqBoZ7CruRN1zUNIEc7kWzfORyZaclxzPhuE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677088480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=ukKEaiyitO8JgQ7lcfjsogM/CK+0CQFsiEgPLxhpECQ=;
        b=JzfjlsIOhH2KkeyeN72yGiuFv60ZNGOT7F4TJ8VvD4YCHfqKMzc62Vw0mFWtN/G6DY+Yai
        AB8k6RsB7CVSW+dXlNiS475fqsPvBFScaOoCaSApW8rzB392NSLIeMWq1XQ+9/WVnYj9Le
        b+x/NOKEHgEp9TyrJY4MtdNFFEZPIBwZ08oamMUeF8v3StSQso1cSylIg4ugeA8uPz3cbw
        LVLnjVqhplt6R2UePcOPewBGxHzo+O+5DjyZ34E4uewVRdcW09DpM6bygGqpPKwoV+JK2C
        eTY9eU/FoEaD4oBs0s6G8EzIIip9Z5Ss8sedM4mFUxeYhpKvos52dLmQWuspww==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-pxv92;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Exultant: 5de39a6360c8653b_1677088480647_2138549284
X-MC-Loop-Signature: 1677088480647:830589782
X-MC-Ingress-Time: 1677088480647
Received: from pdx1-sub0-mail-a307.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.241 (trex/6.7.1);
        Wed, 22 Feb 2023 17:54:40 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a307.dreamhost.com (Postfix) with ESMTPSA id 4PMP1W20Nrz2J
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1677088479;
        bh=ukKEaiyitO8JgQ7lcfjsogM/CK+0CQFsiEgPLxhpECQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=LxOvNo4dAzon93EELQlfV+Z2Pxcfjq4PdAWJUXTgikHJVB7rH00AsoqYzilxB1CcS
         dn4Xn0pFuu5vAeEDxSOZvI4NiFR744p5iXreS7/JODUN4z0ur7mzq4jJKuVFQRMymL
         ab3u4ZuH2SevO+R+ScPBnstQqTP3PrPmsih00/Us=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e004a
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 22 Feb 2023 09:54:29 -0800
Date:   Wed, 22 Feb 2023 09:54:29 -0800
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
Subject: [PATCH linux-next v2 0/2] x86/xen TSC related cleanups
Message-ID: <cover.1677038165.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Enclosed please find a pair of patches that perform some additional cleanup
that was suggested by Boris, Jan and Thomas.

Specifically: this resync's arch/x86/include/asm/xen/cpuid.h from its
upstream source in the Xen tree, and then uses one of the new #define-s to
replace a constant in x86/xen/time.c that was previously only numerically
defined.  Pedantic code from v1 is dropped in favor of a more appropriate
return statement.

Changes from v1:

- Coding style fixup in arch/x86/xen/time.c (Feedback from Thomas Gleixner)


Krister Johansen (2):
  xen: update arch/x86/include/asm/xen/cpuid.h
  x86/xen/time: cleanup xen_tsc_safe_clocksource

 arch/x86/include/asm/xen/cpuid.h | 22 ++++++++++++++++++----
 arch/x86/xen/time.c              |  7 ++-----
 2 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.25.1

