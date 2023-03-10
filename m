Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2C6B3AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCJJeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCJJdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:33:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD521BAE9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:31:13 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60F0766015B7;
        Fri, 10 Mar 2023 09:30:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678440640;
        bh=anAnXUH8k8fWDdcQIPAeMoI3QMLGvBbOpupaFI/MzqE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GqsU9O3jYzyR0UnXH1zX990qMWFapbr7UyWGjYB9BvdJMgv6jUHygAMv4WPMhwlGt
         YTQ245JA38azxW4YoVMcQF5zcznUQWCsibEfirB6eGGzi1RdvWdyYaQwTRP42sYF69
         OZ8b8Byw1E8sQUlr1XYJPOuep6JmGprz+2erV4aoL8TaoZCZ4OOBP/BZqXZoBDMoMw
         3qJFE7ZVnYHhOgmgSOWUDTdMlwM8Pr1uPAdSSvPaG97H2oJZLB1x7nlM8uz8gcXv2r
         Va5RuQSieq1PFHDwbpYdzt9I0CUV/aYu+PLT9hmbAP8qyNRoo+/+x+w5a6vmY+IJUc
         hSxSqU38EWw5w==
Message-ID: <12e8e7e5-36c9-9eaf-89a7-1913755b8b77@collabora.com>
Date:   Fri, 10 Mar 2023 10:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/3] cpufreq: mediatek: fix KP caused by handler usage
 after regulator_put/clk_put
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
        hsinyi@google.com, Nick <vincent@systemli.org>,
        Dan Carpenter <error27@gmail.com>
References: <20230310051750.4745-1-jia-wei.chang@mediatek.com>
 <20230310051750.4745-3-jia-wei.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230310051750.4745-3-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/03/23 06:17, jia-wei.chang ha scritto:
> From: "Jia-Wei Chang" <jia-wei.chang@mediatek.com>
> 
> Any kind of failure in mtk_cpu_dvfs_info_init() will lead to calling
> regulator_put() or clk_put() and the KP will occur since the regulator/clk
> handlers are used after released in mtk_cpu_dvfs_info_release().
> 
> To prevent the usage after regulator_put()/clk_put(), the regulator/clk
> handlers are reassigned to NULL value for validation check afterwards.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Fixes: 4b9ceb757bbb ("cpufreq: mediatek: Enable clocks and regulators")
> Reported-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Link: https://lore.kernel.org/linux-arm-kernel/20220921071913.p7kwsjnnuad2jgvk@vireshk-i7/T/

Actually, it's not just Reported-by, but also please add:
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Anyway, apart from that:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

