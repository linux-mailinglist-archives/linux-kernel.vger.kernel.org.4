Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E140F65B3FB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbjABPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjABPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:15:44 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B148FE2;
        Mon,  2 Jan 2023 07:15:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5D93C3FB17;
        Mon,  2 Jan 2023 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672672540; bh=iZW6tLtouobgnoxpUTyXMCa03RZst5ZEH6lroN+uc9o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=s7XGR/2xRCumFQ0zJpclQSQ6w/tdenUPDmwZMQ9f76akYXYHpilkzGSbhvXIrw6k0
         aIm268yyIV9CT/47wb4RtrOWDZYZB89KS4gkkCLpUNpveWFbxZ1aUHG8Yz7XnKBHQG
         I3fzPoQzVSN/OjuR4ABrCNXyvcUNuDsHfEZxr/9m2M2wY5Rs9Fgz768B6P4GJ/p5nz
         rfJcMfiwJFQcvYYti8OTRqn2ZHPSCLVtEpihwt36ZY+uZ9s5MucUGa7LpKRwu9sIY5
         PU5q2s1F/u/7wOAOO4N/mBZYO5W07nd3lf2Rn+evh3OXRzsf4LsXaPpUgagYllO7Sj
         XNXrLp2W+bCnw==
Message-ID: <9c5bdb0a-0877-ed16-f09f-164a9dab16d4@marcan.st>
Date:   Tue, 3 Jan 2023 00:15:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
Content-Language: en-US
To:     Aditya Garg <gargaditya08@live.com>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
 <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 23.40, Aditya Garg wrote:
> From: Aditya Garg <gargaditya08@live.com>
> 
> Commit 'dce45ded7619' added support for 89459 chip pcie device. It uses the
> BRCM4355 chip which is also found in Apple hardware. However this commit
> causes conflicts in the firmware naming between Apple hardware, which
> supports OTP and other non-Apple hardwares. So, this patch makes these
> Apple chips use their own firmware table so as to avoid possible conflicts
> like these in the future.
> 

I think my reply to Arend flew over your head.

My point was that I'd rather have the Broadcom/Cypress people actually
answer my question so we can figure out how to do this *properly*,
instead of doing "safer-but-dumb" things (like this patch) because we
just don't have the information to do it properly.

- Hector
