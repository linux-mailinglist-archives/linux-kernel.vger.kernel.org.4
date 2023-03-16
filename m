Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450376BCA46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCPJDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCPJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:03:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58EBB5FD1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:03:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36FEC66003B0;
        Thu, 16 Mar 2023 09:03:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678957418;
        bh=EpLAQhKe/JmigVZzxVHT7Ip5Ff3Z539uGU8VPw07mAU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bZEHI4+DqI61fKr3sXHlQior2URWzKF8jlQKDBGAMMaHnPG67TS7TrWYhuyEpr0pn
         bJOJJlYXLez2PHstNwVypr3K6MjZwqnXFriu0Yecb8MpfygMIEl2mBZRYsL7N009Vm
         8nKg8JbAwybAOdtvXToydhCFrkdJVkatXZfzHRI8JVEm5gv+fLVbO8Z6XnUoYFtmIR
         uYrRnk5KfmUAxhTt20RnEWWhrTI3UmfhmFjsi4RcBrT7Car1lwXtp/Assku79V+Zf2
         1xO/wbzdYDtT/o9KtqmOEaj2MGhePCF26n0bCCMUCIUXji2Ri3Pk95bhZM+e9Fj7Y3
         WnChMGh5nepLg==
Message-ID: <490e5a70-885d-4214-c6b4-91ddd59db883@collabora.com>
Date:   Thu, 16 Mar 2023 10:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 0/2] Change mmsys compatible for mt8195 mediatek-drm
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230306080659.15261-1-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230306080659.15261-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/03/23 09:06, Jason-JH.Lin ha scritto:
> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> pipelines binding to 1 mmsys with the same power domain, the same
> clock driver and the same mediatek-drm driver.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.
> 
> Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture Quality)
> and they makes VDOSYS0 supports PQ function while they are not
> including in VDOSYS1.
> 
> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> component). It makes VDOSYS1 supports the HDR function while it's not
> including in VDOSYS0.
> 
> To summarize0:
> Only VDOSYS0 can support PQ adjustment.
> Only VDOSYS1 can support HDR adjustment.
> 
> Therefore, we need to separate these two different mmsys hardwares to
> 2 different compatibles for MT8195.


Hello Chun-Kuang, Matthias,

Since this series is ready, can you please pick it?

I would imagine that commit [1/2] would go through CK and commit [2/2] goes
through Matthias.

Thanks,
Angelo

