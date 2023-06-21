Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB27389CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjFUPjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjFUPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:38:55 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D731BC6;
        Wed, 21 Jun 2023 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=UNTcJ7CGT1Lez3ibsb1q0hENK9CgDCucVIYKxGl3TOA=; b=kX5Xr6VI87reS7/GA49etmzzJa
        8UkZZawMQsboaJaBH0eNpIzk1bR3EcbBbU0KF6jAsbQhofPO8pHw+ovgkoxLGGJjfHxE1vVFC+buE
        dyHRIxHy1ZMVaryyek2UvdEHqUuLiwmWXnN8UhABnjwmxx9ilAZZaPSduE0A55vaKMZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qBzsX-00H9mp-GK; Wed, 21 Jun 2023 17:36:17 +0200
Date:   Wed, 21 Jun 2023 17:36:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Evan Quan <evan.quan@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mario.limonciello@amd.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
Message-ID: <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
 <20230621054603.1262299-2-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621054603.1262299-2-evan.quan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:45:56PM +0800, Evan Quan wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Due to electrical and mechanical constraints in certain platform designs
> there may be likely interference of relatively high-powered harmonics of
> the (G-)DDR memory clocks with local radio module frequency bands used
> by Wifi 6/6e/7.
> 
> To mitigate this, AMD has introduced an ACPI based mechanism that
> devices can use to notify active use of particular frequencies so
> that devices can make relative internal adjustments as necessary
> to avoid this resonance.

Do only ACPI based systems have:

   interference of relatively high-powered harmonics of the (G-)DDR
   memory clocks with local radio module frequency bands used by
   Wifi 6/6e/7."

Could Device Tree based systems not experience this problem?

> +/**
> + * APIs needed by drivers/subsystems for contributing frequencies:
> + * During probe, check `wbrf_supported_producer` to see if WBRF is supported.
> + * If adding frequencies, then call `wbrf_add_exclusion` with the
> + * start and end points specified for the frequency ranges added.
> + * If removing frequencies, then call `wbrf_remove_exclusion` with
> + * start and end points specified for the frequency ranges added.
> + */
> +bool wbrf_supported_producer(struct acpi_device *adev);
> +int wbrf_add_exclusion(struct acpi_device *adev,
> +		       struct wbrf_ranges_in *in);
> +int wbrf_remove_exclusion(struct acpi_device *adev,
> +			  struct wbrf_ranges_in *in);

Could struct device be used here, to make the API agnostic to where
the information is coming from? That would then allow somebody in the
future to implement a device tree based information provider.

       Andrew
