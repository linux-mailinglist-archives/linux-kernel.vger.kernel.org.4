Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05476C7E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCXNLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXNL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:11:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DADC95
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:11:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4046C6603103;
        Fri, 24 Mar 2023 13:11:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679663486;
        bh=cn5ABfRPzRRm47H1QPXFqbLMmYbYM/NLXxj00ObK1K8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g6v/poHYkAdzAmaG326QpOOKx/6qpZzzb+VHepSQD8cWD1Norqrzab8A4ZRoPEmdA
         uj5ePEa5Z49szVeeAPOeFczAEao3Q3+d6WI6VfVTAjTwv1i2S3n/9OawMl/M79slEU
         x2tkp+/QhYwEJNEKhZlVCSnt5y5gD8TrVTlESjEjGoKxJyu20YGx6YI8KGpx8/7Fk7
         8YzxAI2feB0GDT2+77o62U3kd0ZMNcUKgLvw9GjtrvpBUpI7qF9prtm9kpR9Iz7enB
         kZVXkFW05tszN7d1CxDGYwSQ3IpslaMDPZg65iiKsQBzrpOZOTX62lYbjpJEMWkAtF
         EupUqywUpCMWQ==
Message-ID: <b21a0a45-f203-249b-6ffd-abd1e27959f4@collabora.com>
Date:   Fri, 24 Mar 2023 14:11:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: raise proc/sram max voltage for
 MT8516
Content-Language: en-US
To:     "jia-wei.chang" <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com, Nick Hainke <vincent@systemli.org>,
        Dan Carpenter <error27@gmail.com>
References: <20230324101130.14053-1-jia-wei.chang@mediatek.com>
 <20230324101130.14053-4-jia-wei.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230324101130.14053-4-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/03/23 11:11, jia-wei.chang ha scritto:
> From: "Jia-Wei Chang" <jia-wei.chang@mediatek.com>
> 
> Since the upper boundary of proc/sram voltage of MT8516 is 1300 mV,
> which is greater than the value of MT2701 1150 mV, we fix it by adding
> the corresponding platform data and specify proc/sram_max_volt to
> support MT8516.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Fixes: ead858bd128d ("cpufreq: mediatek: Move voltage limits to platform data")
> Fixes: 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
> Reported-by: Nick Hainke <vincent@systemli.org>
> Link: https://lore.kernel.org/lkml/75216e0c-9d36-7ada-1507-1bb4a91a3326@systemli.org/T/

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


