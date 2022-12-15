Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12F764DA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiLOLKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLOLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:09:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921BD23E84;
        Thu, 15 Dec 2022 03:09:57 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 76AE26602C62;
        Thu, 15 Dec 2022 11:09:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671102596;
        bh=OiEexPLSc3VRGJggDVHCDD4pkJJ10eF0O12K6/3xdP0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FpQj6WOlDhF7nut5vD1Ey7TTuDdhPbAdMVE+vUMB43+yT16a+p3vjYZizvtpDP/94
         PIRaAqnT0issGZYkeVoOGXYM+TmeuL9k9FtQUImujf59jo9v3u1WurHxEh+EKzY8u1
         cODuFHqpM2MTjvtRxjmge0oEL2L/3KzNrduRLMo+oEVcHQDLE8EHUfEqSHl0LiaMS/
         5Qm/kVapBq4ZIahEsgXCVCE/A1P9FOR7hFVTmwlzxgoZ+8h1SJTv6+MEvx+vZsEm9m
         6C0ZFgvha2q+gfxlIKsbAOKqvIww3Tb4u37OlKlKN3uIrwAUF+8kXrrPGIquQYX4sk
         SAG4M/lZmRQlA==
Message-ID: <9a7434ba-2d42-cf15-334b-637b5f1b01a3@collabora.com>
Date:   Thu, 15 Dec 2022 12:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media: jpeg: refactor multi-hw judgement
Content-Language: en-US
To:     =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?UTF-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>,
        =?UTF-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?UTF-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?WGlhIEppYW5nICjmsZ/pnJ4p?= <Xia.Jiang@mediatek.com>
References: <20221215093026.12322-1-irui.wang@mediatek.com>
 <1895ff3f71fe7fe6c228d76dd046ea4f43b3dbf5.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1895ff3f71fe7fe6c228d76dd046ea4f43b3dbf5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/12/22 11:50, Johnson Wang (王聖鑫) ha scritto:
> On Thu, 2022-12-15 at 17:30 +0800, Irui Wang wrote:
>> From: kyrie wu <kyrie.wu@mediatek.com>
>>
>> some chips have multi-hw, but others have only one,
>> modify the condition of multi-hw judgement
>>
>> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
>> Signed-off-by: irui wang <irui.wang@mediatek.com>
>> ---
>>   drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c |  5 +++--
>>   drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h | 12 ++++++++++++
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>
> 
> This may conflict with kernel mainline since mtk-jpeg folder doesn't
> exist.
> Please fix it.
> 
> BRs,
> Johnson Wang

Ouch. I just noticed that the folder is mismatching; this didn't deserve
a R-b tag. I'll be more careful next time.

