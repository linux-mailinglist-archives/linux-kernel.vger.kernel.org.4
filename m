Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338A865CF7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjADJYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbjADJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:24:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF13CB61;
        Wed,  4 Jan 2023 01:23:44 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 99F646602D08;
        Wed,  4 Jan 2023 09:23:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672824223;
        bh=KhOX2w723U9MDxXjgpSqxzBYpJpo6f2ZaBSs3BkVG0A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k2QGO6wH6NDcH0KYP2ItX+v1+vvNEfC7ywZlnWkRFHC9nKNt6io3pHA+pcBkrrg1d
         J6siWl7SqVO5m7gCO5iWCTZDfyJi52OP0R0GKYNp4Kc8aFqddl7cizD6EAyeyaP7vq
         jWFsnABHt7ejCo3DE+55FHcIgqV7Q1mTFGy9owS6Wwffd1K/d/l80JGK2vwmkpjZVz
         YR1W/zxqwLR0xQJW8Xs08DILsvT9wUW5p845el0HvwSc7Dxn5JpaklT2TKaz+YLhc7
         HYEt398f8a7z1shQzg4r9/NOgX2EVsFqRq3N8h2hGjEkILBE+dj7+SeYel+/7vj+N8
         oaCPoHYXooDvA==
Message-ID: <fd660017-b502-f72d-c1d7-f94170057fc6@collabora.com>
Date:   Wed, 4 Jan 2023 10:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] remoteproc/mtk_scp: Move clk ops outside send_lock
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
References: <20230104083110.736377-1-wenst@chromium.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230104083110.736377-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/01/23 09:31, Chen-Yu Tsai ha scritto:
> Clocks are properly reference counted and do not need to be inside the
> lock range.
> 
> Right now this triggers a false-positive lockdep warning on MT8192 based
> Chromebooks, through a combination of mtk-scp that has a cros-ec-rpmsg
> sub-device, the (actual) cros-ec I2C adapter registration, I2C client
> (not on cros-ec) probe doing i2c transfers and enabling clocks.
> 
> This is a false positive because the cros-ec-rpmsg under mtk-scp does
> not have an I2C adapter, and also each I2C adapter and cros-ec instance
> have their own mutex.
> 
> Move the clk operations outside of the send_lock range.
> 
> Fixes: ("63c13d61eafe remoteproc/mediatek: add SCP support for mt8183")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Nice catch.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


