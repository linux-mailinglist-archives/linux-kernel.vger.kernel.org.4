Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B757195EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjFAIp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjFAIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:45:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822A6125;
        Thu,  1 Jun 2023 01:45:43 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E24FD660322C;
        Thu,  1 Jun 2023 09:45:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685609141;
        bh=b9IUPiW6SWyyXL2LT/U9gtQHuJcEEu15KtqA0O6EN+g=;
        h=Date:Cc:To:From:Subject:From;
        b=FgYlzH1lShmkSH8uSRNhevv1vPqgd9wvZu5AA/nzE4JiznqoIApbmO1DskeWRW1TS
         +7WItDIfI4PwQmtPaj5K9yRfB4PT4u27KSeVElekiPyx3MjLOXQ2+pDAmbPSKxjX53
         orIgwxM0sAz8HqGGmd4DKMQVKkQlnvy34MzXtU8aN2RHHndqdzEBLDhmXRg0cTszRm
         +D9QpZ3l023GAMRR867joNUWC2sWUFbTx9u7GgZ6yvim8HtSvkX38pJhPQVcVPECSs
         wo+rTWZNgIIIWTrkmkAEtIg9EcstmepusuzXASZYTohcDrO+z5bCWRIDrxKYDzvpA4
         o9cedIeKvcEzg==
Message-ID: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
Date:   Thu, 1 Jun 2023 13:45:35 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Steven Noonan <steven@uplinklabs.net>, kernel@collabora.com
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Direct rdtsc call side-effect
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been looking into a problem where Windows applications misbehave
across suspend/resume when run on Wine on x86. These applications see time
going backwards. The timestamp counter (TSC) is reset when system resumes.
In case of Windows on Intel and AMD, the timestamp is saved and restored
when the system resumes from suspend.

These applications read timestamp by rdtsc directly. These calls cannot be
intercepted by Wine. The application should be fixed such that it handles
these scenarios correctly. But there are hundreds of applications which
cannot be fixed. So some support is required in Wine or kernel. There isn't
anything which Wine can do as rdtsc call directly reads the timestamp. The
only option is that we support something in kernel.

As more and more things are being added to Wine, Windows application can be
run pretty easily on Linux. But this rdtsc is a big hurdle. What are your
thoughts on solving this problem?

We are thinking of saving and restoring the timestamp counter at suspend
and resume time respectively. In theory it can work on Intel because of
TSC_ADJUST register. But it'll never work on AMD until:
* AMD supports the same kind of adjust register. (AMD has said that the
adjust register cannot be implemented in their firmware. They'll have to
add it to their hardware.)
* by manual synchronization in kernel (I know you don't like this idea. But
there is something Windows is doing to save/restore and sync the TSC)

I really hope that you share some thoughts.

-- 
BR,
Muhammad Usama Anjum
