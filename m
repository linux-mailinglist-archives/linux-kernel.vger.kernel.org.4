Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B26172B2AF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 18:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjFKQCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjFKQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 12:01:53 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5309C7;
        Sun, 11 Jun 2023 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=eQiKgV73IgBgADqrP03dx8TvrgyjD34GIMENMF2shSc=; b=pZBI8m2IPwHYP/eRDEUM9Iww/2
        afWTyO0lDzqpk7D6lphotaNog/E8mfWKOycg5HVUD8gGfNHXw8uICuj3FdE3osR1BKuo1i2L0Gts7
        9pH+/MVU1JZZsKCf/iSnZj5s9IOEInPybfTRVU4QwlsTdZR2fej1wyOkdGswXRjPjz5M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q8NVi-00FVrz-A4; Sun, 11 Jun 2023 18:01:46 +0200
Date:   Sun, 11 Jun 2023 18:01:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: trigger: netdev: add additional specific
 link duplex mode
Message-ID: <bc342289-5008-490d-b98f-6826a11574b3@lunn.ch>
References: <20230610041616.21141-1-ansuelsmth@gmail.com>
 <20230610041616.21141-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610041616.21141-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static ssize_t device_name_show(struct device *dev,
> @@ -230,6 +241,7 @@ static int set_device_name(struct led_netdev_data *trigger_data,
>  
>  	trigger_data->carrier_link_up = false;
>  	trigger_data->link_speed = 0;
> +	trigger_data->duplex = 0;

/* Duplex, half or full. */
#define DUPLEX_HALF		0x00
#define DUPLEX_FULL		0x01
#define DUPLEX_UNKNOWN		0xff

You probably want to initialise it to DUPLEX_UNKNOWN, not DUPLEX_HALF.

There is also SPEED_UNKNOWN, which might be good to use, rather than
0.

	Andrew
