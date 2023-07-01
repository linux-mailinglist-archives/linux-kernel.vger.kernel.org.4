Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4371A7445BF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 03:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjGABCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 21:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGABCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 21:02:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E830DD;
        Fri, 30 Jun 2023 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=sJ3VBkhz2c2rPWZ1lo+kvWg61crR7igZ2KfZF/vTU3M=; b=hWUmCAf+ZSjXyHVc7Tv8TU081e
        BJPW5N614euvKV42ljLmBc1WmvJIP9OpqQ8r53Rj+5M58wGSN7/Grj647zMFVXj3Mukb3FGQZXhIc
        6g3bbLmT8F1ykTP1Z5//BS6Ql+QqhtOihJ1DeHvpMOFfXCvo1zqT972VyRmj43qFcYDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qFP0C-000LTo-Pp; Sat, 01 Jul 2023 03:02:16 +0200
Date:   Sat, 1 Jul 2023 03:02:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Evan Quan <evan.quan@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, Alexander.Deucher@amd.com,
        Christian.Koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Mario.Limonciello@amd.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, Lijo.Lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V5 4/9] wifi: mac80211: Add support for ACPI WBRF
Message-ID: <3868dbae-79e5-470d-a144-0884659206d9@lunn.ch>
References: <20230630103240.1557100-1-evan.quan@amd.com>
 <20230630103240.1557100-5-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630103240.1557100-5-evan.quan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void get_chan_freq_boundary(u32 center_freq,
> +				   u32 bandwidth,
> +				   u64 *start,
> +				   u64 *end)
> +{
> +	bandwidth = MHZ_TO_KHZ(bandwidth);
> +	center_freq = MHZ_TO_KHZ(center_freq);
> +
> +	*start = center_freq - bandwidth / 2;
> +	*end = center_freq + bandwidth / 2;
> +
> +	/* Frequency in HZ is expected */
> +	*start = KHZ_TO_HZ(*start);
> +	*end = KHZ_TO_HZ(*end);
> +}

This seems pretty generic, so maybe it should be moved into the shared
code? It can then become a NOP when the functionality if disabled.

      Andrew

