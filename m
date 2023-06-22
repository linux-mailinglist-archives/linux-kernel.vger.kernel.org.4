Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A0B73AB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjFVVVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjFVVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:21:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067341BCA;
        Thu, 22 Jun 2023 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=VKG6+IdxFzEQrIUTUFzRlQOgrRogYWFGqz3oYumqx6I=; b=Sj
        1FzTXwjoVTPbttMFRbQevVbcmtxiZBogtoMjVDlnwbvNzXZx+KRtkQRdN18Laanb58dXxNu7kKlC/
        OAWP5E4COJhQ2oaKefv+cnoiU2IquPGVhx3vu1Ownp4f48y8KFzGfX3zQ1f7BnS/n+a05eecR3Le/
        sgjnaYDSd7oMRf4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCRj8-00HIwp-Jy; Thu, 22 Jun 2023 23:20:26 +0200
Date:   Thu, 22 Jun 2023 23:20:26 +0200
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
Message-ID: <e4168f82-f750-4917-b319-85bb7fe71ce4@lunn.ch>
References: <20230621054603.1262299-2-evan.quan@amd.com>
 <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
 <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
 <b1abec47-04df-4481-d680-43c5ff3cbb48@amd.com>
 <36902dda-9e51-41b3-b5fc-c641edf6f1fb@lunn.ch>
 <33d80292-e639-91d0-4d0f-3ed973f89e14@amd.com>
 <9159c3a5-390f-4403-854d-9b5e87b58d8c@lunn.ch>
 <a80c215a-c1d9-4c76-d4a8-9b5fd320a2b1@amd.com>
 <8d3340de-34f6-47ad-8024-f6f5ecd9c4bb@lunn.ch>
 <07ad6860-8ffb-cc6c-a8e5-e8dc4db4e87a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07ad6860-8ffb-cc6c-a8e5-e8dc4db4e87a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:50:34PM -0500, Limonciello, Mario wrote:
> So if we go down this path of CONFIG_WBRF and CONFIG_WBRF_ACPI, another
> question would be where should the new "wbrf.c" be stored?  The ACPI only
> version most certainly made sense in drivers/acpi/wbrf.c, but a generic
> version that only has an ACPI implementation right now not so much.
> 
> On 6/21/2023 1:30 PM, Andrew Lunn wrote:
> > > And consumer would need to call it, but only if CONFIG_WBRF_ACPI isn't set.
> > Why? How is ACPI special that it does not need notifiers?
> ACPI core does has notifiers that are used, but they don't work the same.
> If you look at patch 4, you'll see amdgpu registers and unregisters using
> both
> 
> acpi_install_notify_handler()
> and
> acpi_remove_notify_handler()
> 
> If we supported both ACPI notifications and non-ACPI notifications
> all consumers would have to have support to register and use both types.

I took a quick look at this:

#define CPM_GPU_NOTIFY_COMMAND		0x55
+static void amdgpu_acpi_wbrf_event(acpi_handle handle, u32 event, void *data)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+
+	if (event == CPM_GPU_NOTIFY_COMMAND &&
+	    adev->wbrf_event_handler)
+		adev->wbrf_event_handler(adev);
+}

handle is ignored, All you need is the void * data to link back to
your private data.

I find it interesting that CPM_GPU_NOTIFY_COMMAND is defined here. So
nothing else can use it. Should it maybe be called
CPM_AMDGPU_NOTIFY_COMMAND?

Overall, looking at this, i don't see anything which could not be made
abstract:

static void amdgpu_wbrf_event(u32 event, void *data)
{
       struct amdgpu_device *adev = (struct amdgpu_device *)data;

       if (event == WBRF_GPU_NOTIFY_COMMAND &&
           adev->wbrf_event_handler)
               adev->wbrf_event_handler(adev);
}

int amdgpu_register_wbrf_notify_handler(struct amdgpu_device *adev,
					wbrf_notify_handler handler)
{
	struct device *dev = adev->dev);

	adev->wbrf_event_handler = handler;

	return wbrf_install_notify_handler(dev, amdgpu_wbrf_event, adev);
}

	Andrew
