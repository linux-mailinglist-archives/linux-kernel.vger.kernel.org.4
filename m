Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933A8690B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjBIOB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBIOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD802D6F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675951236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ep0l3RFT6HgP7uVH5P8Qr5yrUde04DIjfwDSf2qc+AE=;
        b=eOwplVkHQMFyWo56dey5yfDwe/7M+LipwcwmXj2UhvqmLLXBP1ooIHLEt+HEnffUoMHgG+
        odILbI61GmIxsV3WTsGkx6mBT+36nrDRgnNJAxEqQkh5oCPTIaLZRxeFggENMJWbUj9nEW
        ZpPRt3FyA5yHrSvAHen/HgL6umNs5QY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-5enmB-m4NpSDdLkbw07pOw-1; Thu, 09 Feb 2023 09:00:35 -0500
X-MC-Unique: 5enmB-m4NpSDdLkbw07pOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C171830F57;
        Thu,  9 Feb 2023 14:00:33 +0000 (UTC)
Received: from plouf.local (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BD7818EC1;
        Thu,  9 Feb 2023 14:00:31 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Allen Ballway <ballway@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Y+LYwu3Zs13hdVDy@google.com>
References: <Y+LYwu3Zs13hdVDy@google.com>
Subject: Re: [PATCH v2] HID: retain initial quirks set up when creating HID
 devices
Message-Id: <167595123098.340563.10071613529739823229.b4-ty@redhat.com>
Date:   Thu, 09 Feb 2023 15:00:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2023 15:03:30 -0800, Dmitry Torokhov wrote:
> In certain circumstances, such as when creating I2C-connected HID
> devices, we want to pass and retain some quirks (axis inversion, etc).
> The source of such quirks may be device tree, or DMI data, or something
> else not readily available to the HID core itself and therefore cannot
> be reconstructed easily. To allow this, introduce "initial_quirks" field
> in hid_device structure and use it when determining the final set of
> quirks.
> 
> [...]

Applied to hid/hid.git (for-6.3/multitouch), thanks!

[1/1] HID: retain initial quirks set up when creating HID devices
      https://git.kernel.org/hid/hid/c/03a86105556e

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

