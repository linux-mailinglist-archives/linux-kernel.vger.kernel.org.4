Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6498B6417B6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiLCQTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLCQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:19:43 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40986B865
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 08:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=rU8hhiprT8CYsbXv+YRlVVvrMt5l/XRlgxYcVoRn68w=; b=PKwq7R/CyL+ykC+SRCuDyQwh+T
        iyS9DtYqmKQxDFutA3NkPJuQdgO+gAHhhdgCP6iF1qx2iyusvlmP985SqsE0GtTl9jmHvV/NRN9n9
        pxa2zWi/mkB5hSoQgcHY2q6eAe+dZaoq4r7Ioh7nrwNfUMp2vjBh1V79SLLe45Q5Vsm30fvDy8PUY
        CVT2T3KvRWmuUC72EnBnZgWyxrDd/Rzl6JwHVuIKCKYO5NodWdNA8kZ8Xji4NRXS44l2wOg5+exXs
        +VTl3eNJbsScTsCkuy5wWcwvVwqm8kXpvP7BoWguf2KpPXHK25kP981xlw2s31Fr/W2bA6laDJIgA
        egcEHxWw==;
Received: from [2a01:799:95e:1700:6395:ccbd:d000:d42b] (port=57034)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1p1VEp-0003Ix-4J; Sat, 03 Dec 2022 17:19:39 +0100
Message-ID: <b3d762e7-0541-18b9-ed5e-e9aef788dae8@tronnes.org>
Date:   Sat, 3 Dec 2022 17:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/3] drm/mipi-dbi: Support separate I/O regulator
To:     =?UTF-8?Q?Otto_Pfl=c3=bcger?= <otto.pflueger@abscue.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221201160245.2093816-1-otto.pflueger@abscue.de>
 <20221201160245.2093816-2-otto.pflueger@abscue.de>
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221201160245.2093816-2-otto.pflueger@abscue.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 01.12.2022 17.02, skrev Otto Pflüger:
> The MIPI DBI specification defines separate vdd (panel power) and
> vddi (I/O voltage) supplies. Displays that require different voltages
> for the different supplies do exist, so the supplies cannot be
> combined into one as they are now. Add a new io_regulator property to
> the mipi_dbi_dev struct which can be set by the panel driver along
> with the regulator property.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---

Thanks for fixing this, I'll apply the patches in a few days.

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
