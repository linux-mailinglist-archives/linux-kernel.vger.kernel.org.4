Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C737570F2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbjEXJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbjEXJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:28:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61873130;
        Wed, 24 May 2023 02:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB94763B4B;
        Wed, 24 May 2023 09:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8B2C433D2;
        Wed, 24 May 2023 09:28:00 +0000 (UTC)
Message-ID: <b5c45ac7-64ad-ddc1-a7a2-99d9d1c27ca7@xs4all.nl>
Date:   Wed, 24 May 2023 11:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7,0/2] media: mediatek: vcodec: add hevc stateless
 decoder driver in MT8195
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230524080739.17264-1-yunfei.dong@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230524080739.17264-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

On 24/05/2023 10:07, Yunfei Dong wrote:
> Add hevc stateless decoder driver to support hardware decode in MT8195, and the driver
> need num_delta_pocs_of_ref_rps_idx value to parse slice header short_term_ref_pic_set().
> 
> patch 1 add num_delta_pocs_of_ref_rps_idx field.
> patch 2 add hevc stateless decoder driver.

This series clashes with this older series from you:

https://patchwork.linuxtv.org/project/linux-media/cover/20230424060130.18395-1-yunfei.dong@mediatek.com/

Can you post a v8 that sits on top of that older series?

Regards,

	Hans

> ---
> Changed from v6:
> - fix AngeloGioacchino's suggestion.
> 
> Changed from v5:
> - checkpatch/kernel-doc pass/build pass.
> - fix warning: struct vdec_av1_slice_fb -> struct vdec_hevc_slice_fb.
> - fix warning: remove unused comment for param "trans_start" and "trans_end"
> 
> Changed from v4:
> - fix some comments according to Nathan's suggestion.
> 
> Changed from v3:
> - add the dependency patch to this patch series for patch 1.
> 
> Changed from v2:
> - fix one build warning.
> - add the dependency patch link.
> 
> Changed from v1:
> - fix build error when build 32bit system.
> - hevc fluster test result: 132/147 (not support: 10bit => 11 and resolution => 4).
> ---
> Benjamin Gaignard (1):
>   media: uapi: HEVC: Add num_delta_pocs_of_ref_rps_idx field
> 
> Yunfei Dong (1):
>   media: mediatek: vcodec: support stateless hevc decoder
> 
>  .../media/v4l/ext-ctrls-codec-stateless.rst   |    7 +
>  .../media/platform/mediatek/vcodec/Makefile   |    1 +
>  .../vcodec/mtk_vcodec_dec_stateless.c         |   59 +-
>  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |    1 +
>  .../vcodec/vdec/vdec_hevc_req_multi_if.c      | 1097 +++++++++++++++++
>  .../platform/mediatek/vcodec/vdec_drv_if.c    |    4 +
>  .../platform/mediatek/vcodec/vdec_drv_if.h    |    1 +
>  include/uapi/linux/v4l2-controls.h            |    6 +-
>  8 files changed, 1174 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
> 

