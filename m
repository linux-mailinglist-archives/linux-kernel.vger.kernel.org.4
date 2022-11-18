Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4086762EA2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbiKRAYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbiKRAYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:24:17 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0354C70A1E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=hgtyWgrVOpmdmBa6/UWlG/v6XpfBN1v67jaf5tLg9qg=; b=SED0Ys76AN59Hhjl7xEtkgFU77
        W8zDTGxY/zNGqf6rFnlu+XLYHRVgv8Uk/q2UXS04NipZJCa/S1omiuOrS3cQMiVZYNSJudypVHnov
        0Xzvj0UGZUDIfifRlTzQC3SS1oKPOgDo/n3YROybZdFhsari44CexGBzR/BdKUUZ0xdo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ovpAO-002kGK-91; Fri, 18 Nov 2022 01:23:36 +0100
Date:   Fri, 18 Nov 2022 01:23:36 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 2/3] vc04_services: mmal-vchiq: Use bool for
 vchiq_mmal_component.in_use
Message-ID: <Y3bQiDw11t4pRokP@lunn.ch>
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
 <20221117160015.344528-3-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117160015.344528-3-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  struct vchiq_mmal_component {
> -	u32 in_use:1;
> +	bool in_use:1;
>  	bool enabled:1;

The patch you referenced says:

+If a structure has many true/false values, consider consolidating them into a
+bitfield with 1 bit members, or using an appropriate fixed width type, such as
+u8.

The code did exactly this, using two bits fields, in one u32. A bool
probably takes up 4 bytes, maybe 8 bytes, so this change probably
doubles the storage size for these two fields. Are these fields on the
hot path, where an extra AND instruction would make a difference?

    Andrew
