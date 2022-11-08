Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07236620944
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiKHF6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiKHF6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:58:48 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0DC634A;
        Mon,  7 Nov 2022 21:58:46 -0800 (PST)
Received: from [192.168.1.143] (unknown [101.137.78.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8666B431C4;
        Tue,  8 Nov 2022 05:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667887124;
        bh=V2zROnPLRUpBV12B+DzsNZEJxdYMydhYr4Rcli6yCRk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=t7Paf2B8nqZUL1PaQ+ugKDlQR61uL26KYt/G15tGE4ZW7u5KSpv45x6iVmjIEHRPz
         IVVydP8XBL8Q8F4MPebdXiyxvv8KBkaFWDlEzwVE6dl50LD/JKEULcKfNyHIPnntvJ
         1K97uUyUKVe/v3MVcX04bL2hhmeGoYgxTKxh559fpRaUt9wpxsvzPp+5qgWr6EctqW
         KFp1qPKOh7cV44+vuwrfjD/Z+Y5WOwJb/n653ONYI4JdLBnyyDThH4ZB3SoJunKr1R
         6DoNYIw9D7tWtOyOJ0cj/wzMU5oEtBjYLhW5RbMTq6pEFp1Ng4XScClwr3pLFH2X6q
         xoFxlCY0AtSJw==
Message-ID: <0bbca08c-6caf-e830-ca3d-105cf72015d5@canonical.com>
Date:   Tue, 8 Nov 2022 13:58:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Fix fn-lock LED on Yoga
 14ITL5 laptops
Content-Language: en-US
To:     "Rawat, Arnav" <arnavr3@illinois.edu>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4785687.31r3eYUQgx@fedora>
From:   Ike Panhc <ike.pan@canonical.com>
In-Reply-To: <4785687.31r3eYUQgx@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 07:25, Rawat, Arnav wrote:
> From 5bce4f5860d54e125715d896f144add831d19483 Mon Sep 17 00:00:00 2001
> From: Arnav Rawat <arnavr3@illinois.edu>
> Date: Mon, 7 Nov 2022 17:12:41 -0600
> Subject: [PATCH] platform/x86: ideapad-laptop: Fix fn-lock LED on Yoga 14ITL5
>  laptops
> 
> The commit 3ae86d2d4704796ee658a34245cb86e68c40c5d7: Fix Legion 5 Fnlock LED
> set the WMI id for the fn-lock event on some Legion 5 laptops. However,
> the same WMI ID is also sent on some Yoga laptops. Here, setting the fn-lock
> state is not valid behavior, and causes the ec to spam interrupts until the
> laptop is rebooted, so include a check for this line of laptops.
> 
> Signed-off-by: Arnav Rawat <arnavr3@illinois.edu>

Thanks.

But I will be more comfortable if we also check DMI_BOARD_NAME or
DMI_PRODUCT_VERSION, not just DMI_PRODUCT_NAME.

and it will be good to create a table like ideapad_dytc_v4_allow_table.
I have a feeling that your ideapad is not the only one has this issue.

--
Ike
