Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B37738D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFUR0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFUR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:26:34 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA65E2;
        Wed, 21 Jun 2023 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=NF4zBEcDJi5tK0sppmgQglo0yCtgkMekDJXsqP9rEWE=; b=Bj
        wtzUPDYzEuK/cPE63zmLaBg+84ZmbmNgB6BNQFl+zDi7yR3PBotkqT5cO0Rw4Zs01JumJhGvsda8M
        hfsFwp2aUhIyOyM/tKJcRB1AH20PAn3ZFxI0O58LMFr0UKnetCw5PNAO7I7RWUWS48DtfqURQaQji
        ngzUFUlEIePNV/o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qC1ar-00HAax-FK; Wed, 21 Jun 2023 19:26:09 +0200
Date:   Wed, 21 Jun 2023 19:26:09 +0200
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
Message-ID: <9159c3a5-390f-4403-854d-9b5e87b58d8c@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
 <20230621054603.1262299-2-evan.quan@amd.com>
 <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
 <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
 <b1abec47-04df-4481-d680-43c5ff3cbb48@amd.com>
 <36902dda-9e51-41b3-b5fc-c641edf6f1fb@lunn.ch>
 <33d80292-e639-91d0-4d0f-3ed973f89e14@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33d80292-e639-91d0-4d0f-3ed973f89e14@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think what you're asking for is another layer of indirection
> like CONFIG_WBRF in addition to CONFIG_ACPI_WBRF.
> 
> Producers would call functions like wbrf_supported_producer()
> where the source file is not guarded behind CONFIG_ACPI_WBRF,
> but instead by CONFIG_WBRF and locally use CONFIG_ACPI_WBRF within
> it.  So a producer could look like this:
> 
> bool wbrf_supported_producer(struct device *dev)
> {
> #ifdef CONFIG_ACPI_WBRF
>     struct acpi_device *adev = ACPI_COMPANION(dev);
> 
>     if (adev)
>         return check_acpi_wbrf(adev->handle,
>                        WBRF_REVISION,
>                        1ULL << WBRF_RECORD);
> #endif
>     return -ENODEV;
> 
> }
> EXPORT_SYMBOL_GPL(wbrf_supported_producer);
> 
> And then adding/removing could look something like this
> 
> int wbrf_add_exclusion(struct device *dev,
>                struct wbrf_ranges_in *in)
> {
> #ifdef CONFIG_ACPI_WBRF
>     struct acpi_device *adev = ACPI_COMPANION(dev);
> 
>     if (adev)
>         return wbrf_record(adev, WBRF_RECORD_ADD, in);
> #endif
>     return -ENODEV;
> }
> EXPORT_SYMBOL_GPL(wbrf_add_exclusion);
> 
> int wbrf_remove_exclusion(struct device *dev,
>                struct wbrf_ranges_in *in)
> {
> #ifdef CONFIG_ACPI_WBRF
>     struct acpi_device *adev = ACPI_COMPANION(dev);
> 
>     if (adev)
>         return wbrf_record(adev, WBRF_RECORD_REMOVE, in);
> #endif
>     return -ENODEV;
> }
> EXPORT_SYMBOL_GPL(wbrf_remove_exclusion);

Yes, this looks a lot better.

But what about notifications?

    Andrew
