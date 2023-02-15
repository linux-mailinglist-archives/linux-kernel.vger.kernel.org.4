Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFCD69832A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBOSV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjBOSV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:21:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8433D082
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676485233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WC9Wwf5nJ+WBPAJkiFgfrhcWlGghTPWvWl0GS1vSD8=;
        b=PnP39rb20usBcDKsTVCplH8e2QOw4i4q3NpwJGrLI3v2IFl80WGjAIKqcC9r5qmWqANmb9
        xO8NgRBhfjoY/bTX6bHU7+xLgL1+7mi103aJ8JNB3SW8x3gKvtBVCKkuJeQ8MfA1CfaQU/
        dxXHqiDg5Pzckxu9GQzK8GftW35JEZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-PTc1BFirO6eqOax3oG1Wtw-1; Wed, 15 Feb 2023 13:19:30 -0500
X-MC-Unique: PTc1BFirO6eqOax3oG1Wtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DD15800050;
        Wed, 15 Feb 2023 18:18:04 +0000 (UTC)
Received: from plouf.local (ovpn-194-191.brq.redhat.com [10.40.194.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E70E2026D4B;
        Wed, 15 Feb 2023 18:18:02 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Hanno Zulla <kontakt@hanno.de>,
        Hanno Zulla <abos@hanno.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230125-hid-unregister-leds-v4-0-7860c5763c38@diag.uniroma1.it>
References: <20230125-hid-unregister-leds-v4-0-7860c5763c38@diag.uniroma1.it>
Subject: Re: (subset) [PATCH v4 0/5] HID: use spinlocks to safely schedule
 led workers
Message-Id: <167648508201.1580939.291629021543169868.b4-ty@redhat.com>
Date:   Wed, 15 Feb 2023 19:18:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2023 18:59:58 +0000, Pietro Borrello wrote:
> I noticed a recurring pattern is present in multiple hid devices in the
> Linux tree, where the LED controller of a device schedules a work_struct
> to interact with the hardware.
> The work_struct is embedded in the device structure and thus, is freed
> at device removal.
> 
> The issue is that a LED worker may be scheduled by a timer concurrently
> with device removal, causing the work_struct to be accessed after having
> been freed.
> I was able to trigger the issue in hid-bigbenff.c and hid-asus.c
> where the work_structs may be scheduled by the LED controller
> while the device is disconnecting, triggering use-after-frees.
> I can attach the reproducer, but it's very simple USB configuration,
> using the /dev/raw-gadget interface with some more USB interactions
> to manage LEDs configuration and pass checks in asus_kbd_init()
> and asus_kbd_get_functions() in case of hid-asus.c.
> I triggered the issue by connecting a device and immediately
> disconnecting it, so that the remove function runs before the LED one
> which remains pending.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.3/asus), thanks!

[4/5] HID: asus: use spinlock to protect concurrent accesses
      https://git.kernel.org/hid/hid/c/315c537068a1
[5/5] HID: asus: use spinlock to safely schedule workers
      https://git.kernel.org/hid/hid/c/4ab3a086d10e

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

