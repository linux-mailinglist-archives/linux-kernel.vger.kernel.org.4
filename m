Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D25861DAB7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKEODM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKEODJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:03:09 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A780620F46
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vkJyUHspYVBI8d4xmQXiYhBB25JJbBz5SwbIECTzjwk=; b=PQ/38iArWF2TvY7aq2dDwtCXIE
        Sy5HUSeJOc4udUGP7IHPwWf2c96y3qM2hMuPgAmPAnXCjpeNIrsSYwH8lfyfN/Nl6oWl+RmLdDtBO
        +AitpLQIVu0i1L+4o4RQ03RKHmFDtmzeL6RR8o+12jBVNHpmceCtSdAGqkB4QkL5eFcDD85mZGab0
        VTTyhaaXVk0GJ18x6ZRfFvoqsCFp4W4QnxKjrLhoVSx9BsBiAnLBiWAdw1CZXPH/OaWlztf8qbP+B
        mbrAEog9/m7vNN6mz72yqDcI54A4GI8k96PH/iZOi7WqRN7wz+xj0wn7O13VXrG2DlzucfAF++FGO
        Liwq47ZA==;
Received: from [2a01:799:95a:cb00:a93e:4a2b:2c13:303] (port=51787)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1orJlH-0002wy-7A; Sat, 05 Nov 2022 15:03:03 +0100
Message-ID: <98526e41-a96f-c0b0-1531-ed7c401e094d@tronnes.org>
Date:   Sat, 5 Nov 2022 15:02:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 08/23] drm/modes: Move named modes parsing to a
 separate function
To:     maxime@cerno.tech, Karol Herbst <kherbst@redhat.com>,
        Emma Anholt <emma@anholt.net>, Ben Skeggs <bskeggs@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     linux-sunxi@lists.linux.dev, intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        nouveau@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-8-e7792734108f@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v6-8-e7792734108f@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 26.10.2022 17.33, skrev maxime@cerno.tech:
> The current construction of the named mode parsing doesn't allow to extend
> it easily. Let's move it to a separate function so we can add more
> parameters and modes.
> 
> In order for the tests to still pass, some extra checks are needed, so
> it's not a 1:1 move.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
