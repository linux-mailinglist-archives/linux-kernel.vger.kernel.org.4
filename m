Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF45F6FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiJFU7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJFU7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:59:02 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7002BBE12
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xGpzazBwlz0spQbdrF4eip+m3l0NgjNZFpLpj/2e12w=; b=RtgRcIVy4utfbqQVrOX/dTiXas
        OdI2qYC3R894Fpb0qzL859LwZ0oKd2zYZGYny9/ADUJ2IccsfTk9prgy20cPFUQCzv1u6UX/sutZT
        uJczEY/R1FlwKuEMuPbAu9PeJj3M+kg2Mb23st1O6jm+jccUBSI4YvBcdzs+7GwLiL/MdQMZBP8vl
        iCE4vVNwn6p1avITN89fsoEMzyjn0TJjmQfe//YeTosEVtQkk+yPYdo9jX1QehXRi5up/5b45iIhp
        e0fbfMh0mk5D+Xc4OFU2SF5RLMdChymtRUKVLBn+WMWxGmyBGzSyndQRI+gjvEm0CzdE5rNxBVXdI
        nydla+Gg==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ogXws-00BzYE-Ow; Thu, 06 Oct 2022 22:58:31 +0200
Message-ID: <5b8e4b64-2e9c-4cbe-0a56-83043d8de113@igalia.com>
Date:   Thu, 6 Oct 2022 17:58:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <9d9d2d5c-1b7a-721b-f0e2-f591bb170723@igalia.com> <87pmf4bter.ffs@tglx>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <87pmf4bter.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 17:15, Thomas Gleixner wrote:
> [...]
> 
> But a way better solution is to add a sysctl knob which allows to
> disable the slowdown mechanics and that allows distros to give the user
> an trivial knob in the GUI to switch to "I don't care. My broken game is
> more important!" mode, while still maintaining the only sensible default
> of preventing damage for the general use case of the generic distro
> kernel.

OK, if nobody opposes I'll work on that sysctl approach then.
Cheers,


Guilherme
