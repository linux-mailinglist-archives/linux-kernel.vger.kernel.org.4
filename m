Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C360F39E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiJ0JXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiJ0JXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FEA4055D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666862594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBxCkJiySEo1+7aZs/UOh2TcHCjQMbCYKkq8+3qYF14=;
        b=dDa//I6akrVmKUfxMlYFQ3YlobKe/YKvtv7czBbBGqUKaXCQBNckVbQbeBtWgVkWjWLOiG
        E4Mq8DfGpW8rKG4l+s27LWeR5GyVH1FM4Q/rhWHHr0ZAnfNmsiR/KlBG5O0Ye15HWthdcW
        JAqJJirbf4zhTfevODtgpoaznwyZvUo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-bvozvDD_NvqNn0jAAmSzeA-1; Thu, 27 Oct 2022 05:23:12 -0400
X-MC-Unique: bvozvDD_NvqNn0jAAmSzeA-1
Received: by mail-wm1-f69.google.com with SMTP id z10-20020a05600c220a00b003c6ecad1decso324835wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBxCkJiySEo1+7aZs/UOh2TcHCjQMbCYKkq8+3qYF14=;
        b=5Efsysrl9G2x7mcaNVkZzUII64/r5SZFtJ61YCMasBhGkcvrmcSJEIO8Ljl8nldGIP
         GlhtpbbVVkQh+e85sfmDWUiULR5aFxcphCulbecc8lUe1/4TLYp29pxkL85BS375c7zV
         sqbgVDdADi5MyXE6qE50RX7lCR/X1u7EGP06pR8su9ly61Qtt2mWYfUUvMdMr49xEUuN
         lWCkabe8V/6XzFC1ZeTTPbR3W9LTyBa80bxPxYBs0fgEO2F49Euea3TSqcfbfIKfu0RF
         imY7UmGdIyE4AUulBrAzB9IIug13KpCikPkYlYK6l2OoLz3D08hi08iqTTIdY+r4YgyR
         theQ==
X-Gm-Message-State: ACrzQf2Vd9JRqUY8Ugia7nFjXX8uH70UzdZaz6El93Hg/utaCWqGyTNM
        LJzxrkcyQHR6ewAx7BJJjTkvHc0LGq1lH3dr4poFAfAvOudqYdfHMhwZrh8BkG0E4KfIn2mt3m1
        OxFzNu6vWWRD+leozdSegbD+M
X-Received: by 2002:adf:ba01:0:b0:22e:7318:4e94 with SMTP id o1-20020adfba01000000b0022e73184e94mr32097692wrg.330.1666862591427;
        Thu, 27 Oct 2022 02:23:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6FI1Mv/Hrt6d0+GZfcE0mcgytCHWfH1c6PRyC9uCfVRV1tFG4aIZ1F/3D1pVAAus4cOJsVzg==
X-Received: by 2002:adf:ba01:0:b0:22e:7318:4e94 with SMTP id o1-20020adfba01000000b0022e73184e94mr32097676wrg.330.1666862591145;
        Thu, 27 Oct 2022 02:23:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c2ca500b003b435c41103sm5672043wmc.0.2022.10.27.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 02:23:10 -0700 (PDT)
Message-ID: <6b50b9996faffe9fbddb54ed6a407b037a8509ff.camel@redhat.com>
Subject: Re: [PATCH net-next v8.1] net: phy: Add driver for Motorcomm yt8521
 gigabit ethernet phy
From:   Paolo Abeni <pabeni@redhat.com>
To:     Frank <Frank.Sae@motor-comm.com>, Peter Geis <pgwipeout@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     yinghong.zhang@motor-comm.com, fei.zhang@motor-comm.com,
        hua.sun@motor-comm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Oct 2022 11:23:09 +0200
In-Reply-To: <20221025064532.1595-1-Frank.Sae@motor-comm.com>
References: <20221025064532.1595-1-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2022-10-25 at 14:45 +0800, Frank wrote:
[...]
> +/**
> + * yt8521_read_status_paged() -  determines the speed and duplex of one page
> + * @phydev: a pointer to a &struct phy_device
> + * @page: The reg page(YT8521_RSSR_FIBER_SPACE/YT8521_RSSR_UTP_SPACE) to
> + * operate.
> + *
> + * returns 1 (utp or fiber link),0 (no link) or negative errno code
> + */
> +static int yt8521_read_status_paged(struct phy_device *phydev, int page)
> +{
> +	int fiber_latch_val;
> +	int fiber_curr_val;
> +	int old_page;
> +	int ret = 0;
> +	int status;
> +	int link;
> +
> +	linkmode_zero(phydev->lp_advertising);
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->asym_pause = 0;
> +	phydev->pause = 0;
> +
> +	/* YT8521 has two reg space (utp/fiber) for linkup with utp/fiber
> +	 * respectively. but for utp/fiber combo mode, reg space should be
> +	 * arbitrated based on media priority. by default, utp takes
> +	 * priority. reg space should be properly set before read
> +	 * YTPHY_SPECIFIC_STATUS_REG.
> +	 */
> +
> +	page &= YT8521_RSSR_SPACE_MASK;
> +	old_page = phy_select_page(phydev, page);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	/* Read YTPHY_SPECIFIC_STATUS_REG, which indicates the speed and duplex
> +	 * of the PHY is actually using.
> +	 */
> +	ret = __phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +	status = ret;
> +	link = !!(status & YTPHY_SSR_LINK);
> +
> +	/* When PHY is in fiber mode, speed transferred from 1000Mbps to
> +	 * 100Mbps,there is not link down from YTPHY_SPECIFIC_STATUS_REG, so
> +	 * we need check MII_BMSR to identify such case.
> +	 */
> +	if (page == YT8521_RSSR_FIBER_SPACE) {
> +		ret = __phy_read(phydev, MII_BMSR);
> +		if (ret < 0)
> +			goto err_restore_page;
> +
> +		fiber_latch_val = ret;
> +		ret = __phy_read(phydev, MII_BMSR);
> +		if (ret < 0)
> +			goto err_restore_page;
> +
> +		fiber_curr_val = ret;
> +		if (link && fiber_latch_val != fiber_curr_val) {
> +			link = 0;
> +			phydev_info(phydev,
> +				    "%s, fiber link down detect, latch = %04x, curr = %04x\n",
> +				    __func__, fiber_latch_val, fiber_curr_val);
> +		}
> +	} else {
> +		/* Read autonegotiation status */
> +		ret = __phy_read(phydev, MII_BMSR);
> +		if (ret < 0)
> +			return ret;

You need to restore the page even on this error path.



[...]


> +/**
> + * yt8521_modify_bmcr_paged - bits modify a PHY's BMCR register of one page
> + * @phydev: the phy_device struct
> + * @page: The reg page(YT8521_RSSR_FIBER_SPACE/YT8521_RSSR_UTP_SPACE) to operate
> + * @mask: bit mask of bits to clear
> + * @set: bit mask of bits to set
> + *
> + * NOTE: Convenience function which allows a PHY's BMCR register to be
> + * modified as new register value = (old register value & ~mask) | set.
> + * YT8521 has two space (utp/fiber) and three mode (utp/fiber/poll), each space
> + * has MII_BMCR. poll mode combines utp and faber,so need do both.
> + * If it is reset, it will wait for completion.
> + *
> + * returns 0 or negative errno code
> + */
> +static int yt8521_modify_bmcr_paged(struct phy_device *phydev, int page,
> +				    u16 mask, u16 set)
> +{
> +	int max_cnt = 500; /* the max wait time of reset ~ 500 ms */
> +	int old_page;
> +	int ret = 0;
> +
> +	old_page = phy_select_page(phydev, page & YT8521_RSSR_SPACE_MASK);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	ret = __phy_modify(phydev, MII_BMCR, mask, set);
> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +	/* If it is reset, need to wait for the reset to complete */
> +	if (set == BMCR_RESET) {
> +		while (max_cnt--) {
> +			usleep_range(1000, 1100);
> +			ret = __phy_read(phydev, MII_BMCR);
> +			if (ret < 0)
> +				goto err_restore_page;
> +
> +			if (!(ret & BMCR_RESET))
> +				return phy_restore_page(phydev, old_page, 0);
> +		}
> +		if (max_cnt <= 0)

The above check is not needed, the loop can terminate only when such
condition is true.



Cheers,

Paolo

