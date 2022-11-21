Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BD7632B92
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKUR5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKUR45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:56:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6547BD06E6;
        Mon, 21 Nov 2022 09:56:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0143B61374;
        Mon, 21 Nov 2022 17:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE74BC433D6;
        Mon, 21 Nov 2022 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669053416;
        bh=GAP9lZfZvw9SH0sTlqysmIgXbX9sAMna+OEKuPsLI2k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BbZP6mzKyM0ZOHwkukBlO9k5XDMMjiwg+Ds8zBt1IoylrtKQtAdTrY9Z6EJ9fVkGX
         btdhBAQlbIy1LiVLIgqxC1Vhp8XN+VxgQFd0mZ/U3V/HE81OseVlTKxVPvoPHR5qIr
         0IcRVascHSK+/4nLKmMDm+QiXpnQERoQ5pj7H4qo9NC3ySDXXyCf1OwtF4pKrAXwVf
         6a+mGJjPQWDau31DcpmCebJcvgUaqcRDlOvrql/VSXu3eD/0TgOV9EvVbxI5KAI9ua
         OobOHz64SeuNJUWDmQXCPFlXYfAAg7HAtW22F4pzVXHstd8vRJP/9m+R1YUo61b0Lt
         mXfxpJNvapMmQ==
Date:   Mon, 21 Nov 2022 18:56:54 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marge Yang <Marge.Yang@tw.synaptics.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: i2c: let RMI devices decide what constitutes wakeup
 event
In-Reply-To: <Y3e6tcmg1YAKsj9c@google.com>
Message-ID: <nycvar.YFH.7.76.2211211856450.6045@cbobk.fhfr.pm>
References: <Y3e6tcmg1YAKsj9c@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, Dmitry Torokhov wrote:

> HID-RMI is special in the sense that it does not carry HID events
> directly, but rather uses HID protocol as a wrapper/transport for RMI
> protocol.  Therefore we should not assume that all data coming from the
> device via interrupt is associated with user activity and report wakeup
> event indiscriminately, but rather let HID-RMI do that when appropriate.
> 
> HID-RMI devices tag responses to the commands issued by the host as
> RMI_READ_DATA_REPORT_ID whereas motion and other input events from the
> device are tagged as RMI_ATTN_REPORT_ID. Change hid-rmi to report wakeup
> events when receiving the latter packets. This allows ChromeOS to
> accurately identify wakeup source and make correct decision on the mode
> of the resume the system should take ("dark" where the display stays off
> vs normal one).
> 
> Fixes: d951ae1ce803 ("HID: i2c-hid: Report wakeup events")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thanks Dmitry.

-- 
Jiri Kosina
SUSE Labs

