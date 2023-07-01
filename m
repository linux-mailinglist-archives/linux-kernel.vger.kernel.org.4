Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AF274458C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 02:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGAAZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 20:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGAAZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 20:25:41 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6227111F;
        Fri, 30 Jun 2023 17:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2owrJhl/53WVtJVgmJGKRqOuXZ4S6pDn+bb6mrtUzX8=; b=iXIac+Icw9//iMR+dKqntn68Ys
        3WjdD0oasj+rLfco8DYyXIqQBQZvsx5eVG2e5Z1tblnlctWFnWV14lQkggQTMJzkVGloV8SpaDQ30
        j125QMDSEsfvXbeY9hDlaBWN/qh3yhZG36D/+PoEXAkd2qr7Y51ew23f/7lB81H6Z5J0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qFOQP-000LNE-R0; Sat, 01 Jul 2023 02:25:17 +0200
Date:   Sat, 1 Jul 2023 02:25:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mdaenzer@redhat.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, hdegoede@redhat.com, jingyuwang_vip@163.com,
        Lijo.Lazar@amd.com, jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V5 1/9] drivers core: Add support for Wifi band RF
 mitigations
Message-ID: <0f18f4bf-dc38-49e3-a484-ca2456549f0b@lunn.ch>
References: <20230630103240.1557100-1-evan.quan@amd.com>
 <20230630103240.1557100-2-evan.quan@amd.com>
 <3e095621-d7dc-9069-45dc-498c8f3bb4f4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e095621-d7dc-9069-45dc-498c8f3bb4f4@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Right now there are stubs for non CONFIG_WBRF as well as other patches are
> using #ifdef CONFIG_WBRF or having their own stubs.  Like mac80211 patch
> looks for #ifdef CONFIG_WBRF.
> 
> I think we should pick one or the other.
> 
> Having other subsystems #ifdef CONFIG_WBRF will make the series easier to
> land through multiple trees; so I have a slight leaning in that direction.

#ifdef in C files is generally not liked because it makes build
testing harder. There are more permutations to build. It is better to use

if (IS_ENABLED(CONFIG_WBTR)) {
}

so that the code is compiled, and them throw away because
IS_ENABLED(CONFIG_WBTR) evaluates to false.

However, if the stubs are done correctly, the driver should not
care. I doubt this is used in any sort of hot path where every
instruction counts.

	Andrew
