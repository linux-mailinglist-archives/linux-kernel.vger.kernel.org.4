Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8D56E721F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjDSEL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjDSELW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:11:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151506583;
        Tue, 18 Apr 2023 21:11:21 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7CB95660318E;
        Wed, 19 Apr 2023 05:11:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681877479;
        bh=+hanj7Q1swnKed11IeyTq8b1CM+HtKVvSWiDT+29coU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aJiO3fMKzh9JimsXRIro2BeBxQ6xW5z93Tbb3JJKwH7kv/j5Jq3yeVElsL20nYOuu
         P5AslUsgkveiQtPvqGo0LxG14Re9yQvg8ioid682ih3AhaYU1kl0V3kohUm401xCn/
         zjsxQ9TjKcDD1kIES9I00cvLtjw2vVpID3RTOy2Vw7PjZ+8H8Svax2zqrgrcwvAvLW
         WFGymcXcyKwX0zVzCpxqWWoFQUbZXQ1b8lNp38W+ZD/HIxEwaEi63JGAuEdpWSHTGQ
         icWlwtoso6iq77QpolG1Gx1a507om9+vAYnPfJiJA8gm96B1kYDdTzvjviD5B4E2fS
         Lb0e8CXArgTGw==
Message-ID: <6f4a2c1b-4e37-a760-e6fd-2af285190a76@collabora.com>
Date:   Wed, 19 Apr 2023 06:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Revert "media: mediatek: vcodec: Fix bitstream crop
 information error"
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230418215052.2371755-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230418215052.2371755-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/04/23 23:50, Nícolas F. R. A. Prado ha scritto:
> This reverts commit cd61f3c6794bea2b717fe6083ca2ad189db75418. That
> commit's purpose was to prevent the padding from being decoded when
> userspace didn't set a selection, relying on the default one.
> 
> However, as described in the Step 6 of the Initialization procedure for
> the Memory-to-Memory Stateful Video Encoder Interface [1]:
> 
> "Set the visible resolution for the stream metadata via
> VIDIOC_S_SELECTION() on the OUTPUT queue if it is desired to be
> different than the full OUTPUT resolution."
> 
> And from the Note:
> 
> "To avoid encoding the padding, the client needs to explicitly configure
> this selection target"
> 
> Hence the behavior in the original commit doesn't follow the interface
> and needs to be reverted.
> 
> This fixes the following v4l2-compliance failure observed on
> mt8192-asurada-spherion:
> 
> 		fail: v4l2-test-formats.cpp(924): sel.r.width != fmt.g_width()
> 	test VIDIOC_S_FMT: FAIL
> 
> [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-encoder.html#initialization
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

On MT8192 Asurada Spherion and MT8195 Cherry Tomato:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

