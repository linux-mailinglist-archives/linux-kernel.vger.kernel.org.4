Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECA5EFBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiI2RPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiI2RPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:15:33 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4307147F27
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IXV18MOebWFMGlFHhzMjusA+9x187BRqzF/HBTVlDh0=; b=QEqAFeVc/75n0stI3gtZLrHkiF
        nDTOa2TXGQ3NWgwMxafegi410YdOwV2YsfhJxaTRR/pWJEI4SkHST0t6qehgfjEExV2mYOq7pfjZZ
        FQhqkzpzZpv4oXLQ3VUKg9Ecsea2Jt0OsvoT0pY54KPWgbMBKocdB9h2hSz4P2zdFhQH+90bkRKzU
        uUJDd/BXlbRLipjY+amr8M8Qet6J8miV0SP+3jCKQKQ1bLypYJOzESpiUP72yLg+broJkP7eqUkpn
        zGf/NjSo7i8IygzT/3B7jA+k5Y5NaOXeutKk5bl2ed/XlufAmeTXakm9V90WsUnQzc++/Ik2XASw7
        5R/kZX1w==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1odx87-00Gpee-5A; Thu, 29 Sep 2022 19:15:23 +0200
Message-ID: <4baa3654-9a1b-b60c-4a3c-55debe9e8044@igalia.com>
Date:   Thu, 29 Sep 2022 14:15:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, tony.luck@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
 <1c742ae1-98cb-a5c1-ba3f-5e79b8861f0b@igalia.com>
 <cc8d0101-73b9-b286-a7a7-e9305cdc1bd9@intel.com>
 <7917fde2-a381-5404-c5ae-6ffd433f85ec@igalia.com>
 <ecbc58bc-a250-cf39-dea6-9b0b1c3e6503@intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <ecbc58bc-a250-cf39-dea6-9b0b1c3e6503@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two responses in one:

First, I like Tony's idea - heuristic based on CPU number seems to make
sense. This number could be purely based on CPU number with a hardcoded
value, or based in a Kconfig (after N CPUs, add misery).


Now, second part below, inline:

On 29/09/2022 13:26, Dave Hansen wrote:
> [...]
> Let's be precise here, though.  It isn't that folks can't play.  It's
> that we *intentionally* put something in place that kept them from
> playing.  They can play just fine after disabling split lock detection.
>

Agreed with your wording, would just maybe "s/put something/added a
policy" heheh


>> [...]
> They don't have to live with it.  They can turn it off.  That's why the
> command-line disable is there.
> 

If they know how to do it, right? I'd rather have it as a new
non-default mechanism or at least, a Kconfig option in which gamer
distros could tune for their users, so we're not requiring them to tune
x86-specific parameters to play some game.
