Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387736424ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiLEIou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiLEIoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:44:34 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FCB13EB3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:44:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so19035817ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qbDaGH7SxSOuNbBpoFU+Fv5BbMKCKWXUuqKmkohWi8=;
        b=cPmFGuam2aBecAMlmcUyuOsMDwpOJSwj8E0eek914Ml1didv0+EWnvtYZZWII2G1bZ
         E/cI2iocc/oiHCsHP3ftqYOCy0Fm9OsdD3JUkLFg0UnaGeISpI6f0C5wKDM+yr5QkyHD
         KhOvBQwTMiB2VFYVyB1VWYoEzhG6nFqJiBV24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qbDaGH7SxSOuNbBpoFU+Fv5BbMKCKWXUuqKmkohWi8=;
        b=sAn7B1KNbRcse8sRdw+pOsgPUaOZM2r1qFG4elVPXVRRlY3frlFXpZ51lUUztJ71K9
         iY6DsowVm1MJvyCYq55Ns+VsPsaIixMGApTgInAJqsCogKXo4X3XF5/sYVojxGsECBIX
         WTOkucbnWNSsFmE3tQUU6Ub12xIgbbcVPLlNu0q6zpGRkBMEzUAObFIut+8FIdEPe8gu
         /Hn1oUVoRwHg4TuO0srktiGm+QCyYuM81fLDhtKHe9WuuSWK3cFY76IPgEfIjTiMENSC
         TZ27pFOqgqtNJKnPQsTpqPYAbfZKqdWqs0D9dq0O5zFub238cQo6VcY2ZZ0UiF1tJolP
         QNIg==
X-Gm-Message-State: ANoB5pkJUm1A3NzrYTJ2KaQ4p3Ps8X4Hucer9Vysz+H63vhy9L1czakA
        DgX9c7QOpnHGkbs9TTsEzvtkWg==
X-Google-Smtp-Source: AA0mqf7lJgHVP1pyjxKeNHDLtPiEH8H5wuWg1bz9gEmSrNV2ECuG2KP8KE8IDweCzAPH+3h3pygDag==
X-Received: by 2002:a17:907:8dcc:b0:7b2:b5aa:f1e0 with SMTP id tg12-20020a1709078dcc00b007b2b5aaf1e0mr7199260ejc.54.1670229871432;
        Mon, 05 Dec 2022 00:44:31 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090646c900b0072af4af2f46sm5958974ejs.74.2022.12.05.00.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 00:44:30 -0800 (PST)
Message-ID: <72eb4e63-10a8-702b-1113-7588fcade9fc@rasmusvillemoes.dk>
Date:   Mon, 5 Dec 2022 09:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] net: fec: don't reset irq coalesce settings to defaults
 on "ip link up"
Content-Language: en-US, da
To:     Greg Ungerer <gregungerer@westnet.com.au>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c69c1ff1-4da9-89f8-df2e-824cb7183fe9@westnet.com.au>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <c69c1ff1-4da9-89f8-df2e-824cb7183fe9@westnet.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 08.15, Greg Ungerer wrote:
> Hi Rasmus,
> 
> On 23 Nov 2022, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>> Currently, when a FEC device is brought up, the irq coalesce settings
>> are reset to their default values (1000us, 200 frames). That's
>> unexpected, and breaks for example use of an appropriate .link file to
>> make systemd-udev apply the desired
>> settings
>> (https://www.freedesktop.org/software/systemd/man/systemd.link.html),
>> or any other method that would do a one-time setup during early boot.
>>
>> Refactor the code so that fec_restart() instead uses
>> fec_enet_itr_coal_set(), which simply applies the settings that are
>> stored in the private data, and initialize that private data with the
>> default values.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> This breaks The ColdFire parts that use the FEC hardware module at the
> very least. It results in an access to a register (FEC_TXIC0) that does
> not exist in the ColdFire FEC. Reverting this change fixes it.
> 
> So for me this is now broken in 6.1-rc8.

Sorry about that.

Since we no longer go through the same path that ethtool would, we need
to add a check of the FEC_QUIRK_HAS_COALESCE bit before calling
fec_enet_itr_coal_set() during initialization. So something like

diff --git a/drivers/net/ethernet/freescale/fec_main.c
b/drivers/net/ethernet/freescale/fec_main.c
index 93a116788ccc..3df1b9be033f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1186,7 +1186,8 @@ fec_restart(struct net_device *ndev)
                writel(0, fep->hwp + FEC_IMASK);

        /* Init the interrupt coalescing */
-       fec_enet_itr_coal_set(ndev);
+       if (fep->quirks & FEC_QUIRK_HAS_COALESCE)
+               fec_enet_itr_coal_set(ndev);
 }

Or perhaps it's even better to do the check inside
fec_enet_itr_coal_set() and just return silently?

Either way, I don't know if it's too late to apply this fix, or if
df727d4547 should just be reverted for 6.1 and then redone properly?
Greg, can you check if the above fixes it for you?

Rasmus

