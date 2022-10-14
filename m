Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCFB5FF3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiJNS6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJNS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:58:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEC21D3A55;
        Fri, 14 Oct 2022 11:58:51 -0700 (PDT)
Received: from [IPV6:2804:431:c7c2:614d:1e72:1ebe:1da0:adb9] (unknown [IPv6:2804:431:c7c2:614d:1e72:1ebe:1da0:adb9])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADA086602374;
        Fri, 14 Oct 2022 19:58:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665773930;
        bh=w5tCG0PCgpm5rqkO5qJrYz3YWsrGRktxZ3+TQEPwUak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UYu4GLSSuy4BnwFuENkS+CvxAS0BiLA5kCbW/jeORGNJ2/KjM1UVpfdHXC8b40lNn
         TjLGqckcUc2dEgEmfMvllEfZAtgLY63//eeJRG99CtJWGa31ngkQBvSU2mAPckLrNX
         B4AoWgTF0gnsliKBrAHIbgdZN6Znt1RIwWCppplk7WaCR4pjGxDjYB3Q7G9daa7OtO
         ayAJUMQAqSaZfVXsR1qsyWa29+tPdbYZz6xGPLFO121z/BZZqC0gK1ALlgidiaXdEq
         FbHL8iqbaN84MeXzeT64Y6Z1k03QnDLG/ROE9kaYf0OOPgEzfIKXTX0J4kEskJvOaF
         k/WUnUxtFqJiw==
Message-ID: <de4738ec-5362-aa8c-1d4f-a08a4ab3cfc2@collabora.com>
Date:   Fri, 14 Oct 2022 15:58:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH v5] media: mediatek: vcodec: support stateless AV1
 decoder
Content-Language: en-US
To:     Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     Irui Wang <irui.wang@mediatek.com>,
        George Sun <george.sun@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20221001012915.8974-1-xiaoyong.lu@mediatek.com>
From:   Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20221001012915.8974-1-xiaoyong.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaoyong!

I have tested this and arrived at the same Fluster score:

173/239 - AOM
11/13 - Chromium 8bit

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
