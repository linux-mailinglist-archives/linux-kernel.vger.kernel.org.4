Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C08662EC7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjAISXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbjAISWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:22:42 -0500
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:403::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43801765A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=wZxH/nDf40/5XX4K0N7bveQXBer/ZTbSo4stXhMD1MQ=;
        b=xr+iUWmfOB1CLBr6Qsy2YZMDRotm12WBZ/zh+3qIGnqD+WW38gq16Rl6LS9taWAIgXP2llv2ueyF0
         fA3iIIxYnmuPGkwiK+SGk3l7yHRvIxggcTtT7x2q0+wwF6fVIQkEzPtcW04Q4A6X4SKS9m56vo7D0o
         hLzfG7GraTS31Ch8FAtoGue7T76SmYvTnNeZNZkj0/5oK6YNNivj7Wo0ExtjbmvCmHRBteAPdkj/Eg
         NkDkGI6lGIPAVh39LbMkR8Ej5M2GsnANIVRaeRashpzz54gdLod6v1ri7V6JrPjvdhVHIVaCwftjs+
         2rttIhFTMoveJDSDeM23dX3GpjUJUVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=wZxH/nDf40/5XX4K0N7bveQXBer/ZTbSo4stXhMD1MQ=;
        b=nxcQ2DNweooGl9o3PknXxmGKMXudrM7A8yocezPtlLEgBpQEu7WtSwjxUTWj2HhN7+D5H3vtKKz4P
         oB6b4GmAA==
X-HalOne-ID: 5e23647e-904a-11ed-85ce-87783a957ad9
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4 (Halon) with ESMTPSA
        id 5e23647e-904a-11ed-85ce-87783a957ad9;
        Mon, 09 Jan 2023 18:21:02 +0000 (UTC)
Date:   Mon, 9 Jan 2023 19:21:00 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Stephen Kitt <steve@sk2.org>, Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Jason Yan <yanaijie@huawei.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/15] video: fbdev: atyfb: Introduce
 backlight_get_brightness()
Message-ID: <Y7xbDAwLEeCJ4L54@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-2-1bd9bafb351f@ravnborg.org>
 <04f0f8c7-43cd-f774-c952-eb1cf3494bd8@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04f0f8c7-43cd-f774-c952-eb1cf3494bd8@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,
On Mon, Jan 09, 2023 at 05:44:46PM +0000, Christophe Leroy wrote:
> 
> 
> Le 07/01/2023 à 19:26, Sam Ravnborg via B4 Submission Endpoint a écrit :
> > From: Sam Ravnborg <sam@ravnborg.org>
> > 
> > Introduce backlight_get_brightness() to simplify logic
> > and avoid direct access to backlight properties.
> 
> When I read 'introduce' I understand that you are adding a new function.
> 
> In fact backlight_get_brightness() already exists, so maybe replace 
> 'introduce' by 'use'

Thanks for your feedback. A similar patch is already applied to the
fbdev tree, so this patch can be ignored.

	Sam
