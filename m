Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D39738ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjFUSbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:30:58 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D55198;
        Wed, 21 Jun 2023 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=wbqS0dqLdsnGgfOnL91hu55tI6N00q9JeL9Dt8+bbtk=; b=y9Y5o9ZOPVdyNd0f/8z8mo1CWF
        XkhXM+i69HTv3SFPqxk6v7EmMBdE5flxZ9WQanyW/HrM7W28qVJ66H0vtH7C9pz49swW5KNMWcCL+
        3Zwgc4Ge14YT7QZNlatyjc9AHoer54a6qwK7h7cC0GTMQO2OPRl1KgAcCIRDo5mjB+uc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qC2az-00HB0y-DN; Wed, 21 Jun 2023 20:30:21 +0200
Date:   Wed, 21 Jun 2023 20:30:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Evan Quan <evan.quan@amd.com>, rafael@kernel.org,
        lenb@kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mdaenzer@redhat.com,
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
Message-ID: <8d3340de-34f6-47ad-8024-f6f5ecd9c4bb@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
 <20230621054603.1262299-2-evan.quan@amd.com>
 <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
 <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
 <b1abec47-04df-4481-d680-43c5ff3cbb48@amd.com>
 <36902dda-9e51-41b3-b5fc-c641edf6f1fb@lunn.ch>
 <33d80292-e639-91d0-4d0f-3ed973f89e14@amd.com>
 <9159c3a5-390f-4403-854d-9b5e87b58d8c@lunn.ch>
 <a80c215a-c1d9-4c76-d4a8-9b5fd320a2b1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80c215a-c1d9-4c76-d4a8-9b5fd320a2b1@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And consumer would need to call it, but only if CONFIG_WBRF_ACPI isn't set.

Why? How is ACPI special that it does not need notifiers?

> I don't see why it couldn't be a DT/ACPI hybrid solution for ARM64.

As said somewhere else, nobody does hybrid. In fact, turn it
around. Why not implement all this in DT, and make X86 hybrid? That
will make arm, powerpc, risc-v and mips much simpler :-)

	Andrew
