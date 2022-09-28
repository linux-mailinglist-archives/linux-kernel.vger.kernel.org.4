Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5957E5EE6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiI1U52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiI1U5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:57:25 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAB75A3D0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=do3DkJZT4jWyws/1mfByy0PV8J8vHx2Y5d7gQrVQZHo=; b=loah5f3+LqNFDgpRwY2y/EahuM
        lFLAhTeCcVm9zIm+yszsVe1Qf1l5h/vZ637bv4YhsmRN0yRK8HsQ58R09x6uEztOJWHU4s66AMZke
        U2IRJBMC62Y8ISdPRlSELHFZ0CI070ICjU+cs2PLwNhEbCOnjLar3AlYTDQNF720bI/cxRxKus6op
        lEJ0pe99pWzk+6A34jOoKi7Y1VpSk6XT4KKzqit9KTLP8g2FptD2qiUuRwkqIhWmaNAlQmykS66XZ
        Z8ftr/QLi06rrAki9Cw4rwso85o0LVw31M6g7d+uoxNnOU6L+4sdILSn1NG/aEdrsr1LFiSvfbh9B
        8Ey4gUgw==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ode7E-00FElQ-VA; Wed, 28 Sep 2022 22:57:12 +0200
Message-ID: <9d9d2d5c-1b7a-721b-f0e2-f591bb170723@igalia.com>
Date:   Wed, 28 Sep 2022 17:56:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 17:24, Luck, Tony wrote:
> [...] 
> Why not just use the workaround suggested in that bug report:
> 
>    "so manual switching from default setting to split_lock_detect=off helps as workaround here"
> 
> If you add this extra mode, I'm going to argue that the kernel default
> should be "seq" rather than "warn". So these game players will need
> to add a split_lock_detect=off (or warn) option.
> 

Hi Tony, thanks for your response. The workaround is the way to
circumvent the issue for now, but not all users want (or know how) to
deal with the kernel parameters. If a distro wants to default to show a
warning only, but don't break performance so hard, this would be
currently impossible.

I understand that maybe the kernel default could be seq, I could
re-submit - not a deal breaker, at least distros are given a way to
collect split lock reports without breaking!

The main/big issues here are two: defaulting to the disruptive behavior
(with no way of building a kernel not defaulting to that without
patching), and not having a way to warn about split locking without
breaking the performance, hence the new mode "seq".

> Has a bug report been filed against the God Of War game? Probably worth fixing,
> the performance penalty for split lock is only going to get worse as numbers of
> cores keeps increasing.
> 

Definitely worth fixing! And the plan is always to report it -
meanwhile, we'd like to have all users of old/proprietary software/games
to continue using the kernel the way it was before :-)

Regarding God of War specifically, I'm not sure but I can verify - the
devels should be made aware, for sure.

Cheers,


Guilherme


