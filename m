Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C06D723A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbjFFHqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjFFHo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:44:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4F10FE;
        Tue,  6 Jun 2023 00:41:53 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C1826602242;
        Tue,  6 Jun 2023 08:41:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686037312;
        bh=KA+QU0u/LvX1UydZ6WjqaFEqiIvHKIgAaYfilc7+HXQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=T2hRy8aLOAzXoZn6WTH8mqclRNea0ZG1A//zBARz5NjqpIqmdefUnpnkO1t62ugSd
         kusaupsDaIGBCo430RFwyJyZmKHPEbdypr4WT4dfbJh7eT+CvbN5dJVxIzs03oxNI9
         wT3rggsZmGzStDFsRWdVKIutYwETD9Nzabl5TX73ggXuca4jKb4w+mczfVrWJrU4AY
         Es653YgYU34aywLHnGSH3r3GW9fKpJJTWLQVpEtGAwoDVGemWkhAicdlAQKqJGK6o9
         a/9jid06gTdOQL7b/kVELenG9edNi+jnDWuvgUCct+68VgUzjJLrB/9NjZ0IhgIDUs
         8PrlV1qo3ZsZw==
Message-ID: <355198a9-c5f8-3caa-243a-bd0c544caf8d@collabora.com>
Date:   Tue, 6 Jun 2023 09:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] cpufreq: mediatek: correct voltages for MT7622 and MT7623
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <9d7e62049e3442582bd64dbc9e4d2a64f1ad0c1a.camel@mediatek.com>
 <ZH3umLU883eGbYBx@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ZH3umLU883eGbYBx@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/06/23 16:18, Daniel Golle ha scritto:
> The MT6380 regulator typically used together with MT7622 does not
> support the current maximum processor and SRAM voltage in the cpufreq
> driver (1360000uV).
> For MT7622 limit processor and SRAM supply voltages to 1350000uV to
> avoid having the tracking algorithm request unsupported voltages from
> the regulator.
> 
> On MT7623 there is no separate SRAM supply and the maximum voltage used
> is 1300000uV. Create dedicated platform data for MT7623 to cover that
> case as well.
> 
> Fixes: 0883426fd07e3 ("cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623")
> Suggested-by: Jia-wei Chang <Jia-wei.Chang@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


