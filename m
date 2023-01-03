Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08E65C041
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbjACMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbjACMtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:49:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2206106;
        Tue,  3 Jan 2023 04:49:51 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 305F76602CFA;
        Tue,  3 Jan 2023 12:49:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672750190;
        bh=kLb7ZxO/t10qRzNfWMcuhgJ9EXOlFXY8vbB18QInejQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dqiCSMgQvi/04qrMXM6nENACo5DfvsyNuLBxHdjm3iaDh+jiqP2f+pEGbpB5tKNMm
         CeNrXN8Miys+y2TnDxifNRqNSS5y91iRZxqE/syBbreZbXoH+PNCJ8rMkgUmIEF57y
         L2g5z5fVE3XQl6xV0WABHmbUM7H5HbXwnGQcRSe6y7klzW0CUmQxXbxC08ZJUR+Ozy
         hC8xuurNE4CWoffNSwqdp7SjhyDWmH4F4sgvrDdYbeWTvZ93GXvbuU5n9nFWnz4ice
         BbfrWupgmsJBDWGmNYV5bNxTXJ3pSbHGi/Y5/tXeW+CjoTCS5qbS7rrVLQUtT1WZlX
         G97ur71uMRGmg==
Message-ID: <ce7698f3-8b40-1394-342e-e6b099f9f77e@collabora.com>
Date:   Tue, 3 Jan 2023 13:49:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 10/13] soc: mediatek: mtk-svs: restore default voltages
 when svs init02 fail
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221226094248.4506-1-roger.lu@mediatek.com>
 <20221226094248.4506-11-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221226094248.4506-11-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/12/22 10:42, Roger Lu ha scritto:
> If svs init02 fail, it means we cannot rely on svs bank voltages anymore.
> We need to disable svs function and restore DVFS opp voltages back to the
> default voltages for making sure we have enough DVFS voltages.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

This needs a Fixes tag... and it also needs to apply to older kernels, as
MT8183 does use SVS in previous versions.

Perhaps you can send a different patch, without the cleanups, only for the
backport?
Otherwise you'll have to duplicate svs_bank_disable_and_restore_default_volts()
again before cleaning up...

I'll leave the choice to you.

Regards,
Angelo
