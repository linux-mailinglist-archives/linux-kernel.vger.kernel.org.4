Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61295EFC29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiI2Rke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiI2Rk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:40:28 -0400
X-Greylist: delayed 981 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 10:40:26 PDT
Received: from mail.codeweavers.com (mail.codeweavers.com [65.103.31.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2812C1CE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jSP2l9Ne93VpHz0BTQhYyRVteY6/xdhlxQqeMAsedbI=; b=keTvKVK9k+RXFSR6LJmAxSAWJu
        tezEvELDSZpCcmRvziAgFPOuq7MNzDM/8JTr8DAx+M62e7Dj7r8BCKzsXdQlU6dmq4d/azELoIAlH
        9fEd3JWeDnui8ga9v9FBX3kF1WyOvcw/j1Gu+FS+1fbP23gZnGxm/xJmBMIlVnP5b6sI=;
Received: from cw141ip123.vpn.codeweavers.com ([10.69.141.123])
        by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pgofman@codeweavers.com>)
        id 1odxGT-000Nw1-8X; Thu, 29 Sep 2022 12:24:01 -0500
Message-ID: <90ec75f7-f094-b7ac-a635-0c320cc94bcb@codeweavers.com>
Date:   Thu, 29 Sep 2022 12:23:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
To:     Dave Hansen <dave.hansen@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, tony.luck@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>, Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
 <1c742ae1-98cb-a5c1-ba3f-5e79b8861f0b@igalia.com>
 <cc8d0101-73b9-b286-a7a7-e9305cdc1bd9@intel.com>
 <7917fde2-a381-5404-c5ae-6ffd433f85ec@igalia.com>
 <ecbc58bc-a250-cf39-dea6-9b0b1c3e6503@intel.com>
Content-Language: en-GB
From:   Paul Gofman <pgofman@codeweavers.com>
In-Reply-To: <ecbc58bc-a250-cf39-dea6-9b0b1c3e6503@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 11:26, Dave Hansen wrote:
> Let's be precise here, though. It isn't that folks can't play. It's
> that we *intentionally* put something in place that kept them from
> playing.  They can play just fine after disabling split lock detection.

I guess that the statement that they can play is arguable. To do it, the 
player (even capabale and willing to go as far as tweaking kernel 
options, which alone may be a showstopper for the game to be called 
playable) should get aware that the issue they are having can be solved 
this way. IMO such level of involvement effectively means that a user 
who is not technically advanced and not perceiving troubleshooting Linux 
specific issues as a part of game play just can't play it.
