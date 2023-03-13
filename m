Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F9D6B83B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCMVDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCMVCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:02:38 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C431F8DCFA;
        Mon, 13 Mar 2023 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1pIf+VierdJpmiI9zH5ye8/eQXEQAS3qYu1Hwf19Ncw=; b=R7d6Us7vCuOJReyceWdv+LWtTC
        5i5hHWzz00qZTY6FXaLcQvLmThPfgsZFYH8ZHjDYsJfo9Irpn6ZfsFegJq26hvKThLu4ldNwqWV2x
        kXkPgfw8xMXtp8RhxxIeSyFfwYYm3L3/OWn23Epm/H9l+tf+hh4OAMZ0Oa55d1CkdaIwcB8UZwAF9
        E2FIDJIqeoad+oXMaEmGmOP1JOXwbraz02PFER6uHfn8Wl8AijMeZi1X2OfcqS6uH5WzFMXcLUn5m
        c02De4I+TQkJQ8RROcqVoNvaXRHTVel+UYgbD1vI9b9oyumeuDwqyRXhQlJxXkhw7v92TgShtcZQ1
        yY7cxcAw==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pbodB-008NsZ-6k; Mon, 13 Mar 2023 21:18:53 +0100
Message-ID: <ba225af5-3729-32a4-318a-c1c4b8e8b37a@igalia.com>
Date:   Mon, 13 Mar 2023 17:18:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] alpha: Clean-up the panic notifier code
Content-Language: en-US
To:     linux-alpha@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Petr Mladek <pmladek@suse.com>
References: <20230220212245.153554-1-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230220212245.153554-1-gpiccoli@igalia.com>
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

On 20/02/2023 18:22, Guilherme G. Piccoli wrote:
> The alpha panic notifier has some code issues, not following
> the conventions of other notifiers. Also, it might halt the
> machine but still it is set to run as early as possible, which
> doesn't seem to be a good idea.
> 
> So, let's clean the code and set the notifier to run as the
> latest, following the same approach other architectures are
> doing - also, remove the unnecessary include of a header already
> included indirectly.
> 
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> 
> V4:
> - Rebased (and build-tested) against v6.2.
> 
> V3:
> - No changes.
> 
> V2:
> - Fixed rth email address;
> - Added Petr's review tag - thanks!
> 

Hi folks, just a gentle ping.
Lemme know if there's anything I could do in order to get this move forward.

Thanks in advance,


Guilherme
