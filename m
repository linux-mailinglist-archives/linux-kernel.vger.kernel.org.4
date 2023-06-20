Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C5173643B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjFTHPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjFTHPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:15:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82DE4D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:15:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so1275978e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687245341; x=1689837341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQ/7vwSwxnA7hS2MnkoZC9h+eLxfozOTX4SsBbSZfWo=;
        b=fDYE6VxQSDYEfGR/s2+rSpfd85/UxttrYKcTG6ef1zpy3/1yWRCflPfgahw3gougFE
         z5PFV4J0vBV9LTE14QT0Q8gkpOqT+lEfqjx3T3lVxgOyAnP+jkSezGAK9Lx2Wa+CB9vf
         Fu0I4+zYvf7cPUtlwqJHyPfr8ywptqw28mrBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687245341; x=1689837341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ/7vwSwxnA7hS2MnkoZC9h+eLxfozOTX4SsBbSZfWo=;
        b=jjKLjMsmBwvSR9FwqDXkGC4J43VDbD+6EBjSyH0FmlXOJM5CyOhkKGRSuL0qjhFSXF
         /CzhlfG9Rg0RiS3BW1B864ByG/DQZgTXPAYDJdz7PduoGvk4EnESnFq1zkEMv28E4xf+
         Xfu4CUlW/YDDi09fAMbCO1dQP9ozWjoN8U4amgAMYAOuZta7DbyWlNBug1Xt7j+4wZoF
         SMI1VvvJOILwqtPekJdvZT9CeWMvZMeQKY4WyJlTVtlfM57emmiQ2wv5pUZi4y7flnKh
         Q9vRtAUJLrAPf2EfYb30CWcUpehmWe+XtCarWRXK8TbqE88/wBHKMRX+op1DmUMvUiXR
         XdpQ==
X-Gm-Message-State: AC+VfDwMaAClyyaRR5Vie9bwRbjWQRVaIcDk8fbFfYPStAEzSRU0ivBS
        SG6RMUHK+pLGiV0HKFjd5n5RTw==
X-Google-Smtp-Source: ACHHUZ4xjBRoBVcpZUgDMrmHGOYDVKKcErV9moQOMZcQsZ+O61Oe50C+ZIBOJJqM7eOkUHzfXk8r2Q==
X-Received: by 2002:a19:e348:0:b0:4f6:1c08:e9bb with SMTP id c8-20020a19e348000000b004f61c08e9bbmr6827356lfk.63.1687245340636;
        Tue, 20 Jun 2023 00:15:40 -0700 (PDT)
Received: from [172.21.2.62] ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id i22-20020a056512007600b004f843f31fefsm243075lfo.281.2023.06.20.00.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 00:15:40 -0700 (PDT)
Message-ID: <423d2a3c-6b4d-449f-5fa6-5402467e1b6e@rasmusvillemoes.dk>
Date:   Tue, 20 Jun 2023 09:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next] net: dsa: microchip: ksz9477: follow errata
 sheet when applying fixups
To:     Robert Hancock <robert.hancock@calian.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "hancock@sedsystems.ca" <hancock@sedsystems.ca>,
        "woojung.huh@microchip.com" <woojung.huh@microchip.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230619081633.589703-1-linux@rasmusvillemoes.dk>
 <b91cc419988fe21723f948524c1d7e44e3953ee2.camel@calian.com>
Content-Language: en-US, da
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <b91cc419988fe21723f948524c1d7e44e3953ee2.camel@calian.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 19.31, Robert Hancock wrote:
> On Mon, 2023-06-19 at 10:16 +0200, Rasmus Villemoes wrote:
>>
>> Fixes: 1fc33199185d ("net: dsa: microchip: Add PHY errata
>> workarounds")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> While I do believe this is a fix, I don't think it's post-rc7
>> material, hence targeting net-next with cc stable.
> 
> I don't think this will apply to net-next as the relevant code has been
> moved to the Micrel PHY driver and removed from this one in the
> following commits, 

Ah, sorry about that. This code hadn't been touched in a very long time,
so I didn't actually think to check -next.

and effectively the same change to disable autoneg
> before the register writes and re-enable afterwards was incorporated:

Yes, except it seems to always enable autoneg, even if the phy was
strapped otherwise. That's not a problem for our use case.

> However, your patch may be reasonable to apply to -rc7 or stable as a
> more targeted change for those releases.

Well, yes, it could be backported, but then there'd be a (simple)
conflict when net-next is to be merged in the next window. So I don't
think it's worth it.

Unless the net maintainers decide otherwise, please just drop this patch.

Rasmus

