Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6760162E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJQSXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJQSXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:23:19 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A5074CD6;
        Mon, 17 Oct 2022 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4sjMP/FaCWS6/v5Psiixs4qxgbGH/KhPN7NTx1p/cno=; b=WZ93flY+KU0E2pZufHWHm+W89T
        s9xuK5kqwtWxM2+s6XYSdN2S0ucx3V9zguClaM8SPzT3gIu8hvIcrUehDCurxD7/nGoQVDkY5ANqf
        Yt9SSets4ldeWBjviqX4Tizj18VgMGi/ulpR5L5++ldDu6s/667syAgRH+JjXf939w0k7WUuLBCAM
        8m/eq3mcd4rNa6PIS1PG5vroiQ583SHriA1MdGJH1F+h0sxpCRV6i+P6UYxEATaadgwvYzZobyJps
        V/3vN6Krf9i9Y2TX8Y9xRkj9LIGjp4RpaB0Zykw13RR1AheVKW8eZgTZ9KwRz4fSoRzz6sNlBFB57
        9Q+RrSqg==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1okUlR-000XXG-TA; Mon, 17 Oct 2022 20:23:01 +0200
Message-ID: <798f0911-5c54-ebe0-9d44-64bec0c96a72@igalia.com>
Date:   Mon, 17 Oct 2022 15:22:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
 <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 15:14, Ard Biesheuvel wrote:
> [...]
> 
> So at that point, I wondered what the point is of all this complexity.
> Do we really need 6 different algorithms to compress a couple of K of
> ASCII text on a code path that is ice cold by definition? Wouldn't it
> be better to drop the crypto API altogether here, and just use GZIP
> via the library interface?

Skipping all the interesting and more complex parts, I'd just want to
consider zstd maybe? Quite fast and efficient - it's what we're using by
default on Steam Deck.

I'm not sure what is the gzip library interface - you mean skipping the
scomp/legacy comp interface, and make use directly of gzip?

Cheers,


Guilherme
