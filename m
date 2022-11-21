Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C638632130
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKULtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiKULtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:49:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8572A2035E;
        Mon, 21 Nov 2022 03:49:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D798B80ED0;
        Mon, 21 Nov 2022 11:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49026C433C1;
        Mon, 21 Nov 2022 11:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669031340;
        bh=hEe5obcGne0U90s9+lAPprjcYQ8Jw5h37tfxbPTIQsk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TvywWYJBFq+75v8AhpPGULDju92sa8F9+mmk7gqSBbnGaItoU1PqRjIFWgEE5eCFW
         kQS43BZcBzNMMpmaqHOOMOEXyCliEixlp+kRcRgwTQYZoKVJZkiwvVNbO3FDerFjuv
         x/wGtud8a9sPC5s9g4GW0lutTswTlumIKFziafdxs22reH43/OrdOWXSvdcRezoQHC
         k6uOd8u2HFOFp7ixhyPaP6a4G3g3BoagO7+QzGLJsyN5d8hABd0bKoatdokA1BmWf9
         x8AqCAPncZdjiPLNnMpykw9HDE5nry2iZ9YM4xvzCF3utGlRpAroP0S7mY0PsWEQyV
         xJjPAo0J/gwow==
Message-ID: <f04e9d91-f953-6f75-2f17-a4054384ef75@kernel.org>
Date:   Mon, 21 Nov 2022 12:48:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/5] media: fsd: add MIPI CSI2 Rx controller driver
Content-Language: en-US
To:     Sathyakam M <sathya@samsung.com>, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hverkuil-cisco@xs4all.nl,
        jernej.skrabec@gmail.com, ming.qian@nxp.com, digetx@gmail.com,
        jacopo@jmondi.org, pankaj.dubey@samsung.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1668963790.git.sathya@samsung.com>
 <CGME20221121044855epcas5p3ef93576acdcdb6e4feba63c15917d9de@epcas5p3.samsung.com>
 <7e7832c16925386b771ddb7e00e08661115aa0ea.1668963790.git.sathya@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <7e7832c16925386b771ddb7e00e08661115aa0ea.1668963790.git.sathya@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 05:53, Sathyakam M wrote:
> The FSD MIPI CSI2 Rx controller is compliant to MIPI CSI2 v1.3 and
> D-PHY v1.2 specifications.
> 
> There are up to maximum 4 data lanes (default).
> Controls are provided for User to change number of lanes if needed.
> 
> Both the video and v4l-subdev instances are exposed to the user
> under /dev directory.
> 
> The driver can be built as a loadable module or as a platform_driver.
> 
> Signed-off-by: Sathyakam M <sathya@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Sathyakam M <sathya@samsung.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Ming Qian <ming.qian@nxp.com>
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Cc: Pankaj Kumar Dubey <pankaj.dubey@samsung.com>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../media/drivers/fsd-csis-uapi.rst           |   78 +
>  MAINTAINERS                                   |    1 +
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/fsd/Kconfig            |   73 +
>  drivers/media/platform/fsd/Makefile           |    1 +
>  drivers/media/platform/fsd/fsd-csis.c         | 2664 +++++++++++++++++
>  drivers/media/platform/fsd/fsd-csis.h         |  785 +++++

drivers/media/platform/samsung/

Plus we have drivers for it, so please integrate with existing ones.
Samsung is known of heavily reusing its IP core designs, so they are
usually similar.

Best regards,
Krzysztof

