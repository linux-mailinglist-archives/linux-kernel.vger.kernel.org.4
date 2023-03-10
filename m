Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BA66B45C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjCJOhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjCJOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:36:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD811A2EC;
        Fri, 10 Mar 2023 06:36:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D16AB822DD;
        Fri, 10 Mar 2023 14:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD339C433EF;
        Fri, 10 Mar 2023 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678458993;
        bh=qyc4HtAfs0oFkSh7TiVFkSvvHVwKqZYdZrQDv4CKMfo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=he4Spk3glwq8JDawOjY7kt/f4Yr/NEkiMXYrgkpR4R5jEv7ZQgCQUdPAf3emcg/+x
         otfpJUBp6QID2Ysfe6HcaNOAq88I0gA6NYOneQwNwrVmutesv+ciSfncC97CPuTaiq
         XVvDAIOF5PWuJUjepSUeZqgRMkQXc7sOklwWoRUbES9Oy6bAsdOkcaOV0X9p01m0UO
         pZIGyUsvvPIWnuI0JEoTY++4RqfH9EhJzZj6xfZuRmUTG/OkYRIx2xGNKYBO6ZrqPC
         XPaaA9o93Uejfkb0PuZHACWIMayPn38CGZjjyJXULBvjGDXsKv3XEvRxzDCwxL7FIS
         6KnYmCmpYXEDw==
Date:   Fri, 10 Mar 2023 15:36:34 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
cc:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v5 0/2] Apple Magic Keyboard Backlight
In-Reply-To: <20230220115203.76154-1-orlandoch.dev@gmail.com>
Message-ID: <nycvar.YFH.7.76.2303101535440.1142@cbobk.fhfr.pm>
References: <20230220115203.76154-1-orlandoch.dev@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023, Orlando Chamberlain wrote:

> This patchseries adds support for the internal keyboard backlight of
> Macs with Apple's "Magic" keyboard (MacBookPro16,* and MacBookAir9,1),
> and also documents what names should be used for keyboard backlight
> leds in Documentation/leds/well-known-leds.txt.
> 
> v4->v5:
> - use <tab><space><space> for help in Kconfig
> - prepend "hid-" to filename in MAINTAINERS
> 
> v3->v4:
> - collect reviews from Andy and Thomas
> - remove now unused hdev member of apple_magic_backlight
> 
> v2->v3:
> - remove unneeded header inclusion
> - use s32 for report value type
> - remove unneeded null check
> - don't set drvdata as its never used
> - prepend "hid-" to module name
> 
> v1->v2:
> - drop unneeded remove function
> - combine set functions
> - add missing header inclusions
> - avoid char as argument in favour of u8
> - handful of style/formatting fixes
> - use standard led name ":white:kbd_backlight"
> - rename USAGE_MAGIC_BL to HID_USAGE_MAGIC_BL
> - New patch documenting preferred keyboard backlight names
> 
> v1: https://lore.kernel.org/linux-input/7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com/
> v2: https://lore.kernel.org/linux-input/20230216041224.4731-1-orlandoch.dev@gmail.com/
> v3: https://lore.kernel.org/linux-input/20230217102319.3419-1-orlandoch.dev@gmail.com/
> v4: https://lore.kernel.org/linux-input/20230218090709.7467-1-orlandoch.dev@gmail.com/
> 
> Orlando Chamberlain (2):
>   Documentation: leds: standardise keyboard backlight led names
>   HID: hid-apple-magic-backlight: Add driver for keyboard backlight on
>     internal Magic Keyboards
> 
>  Documentation/leds/well-known-leds.txt  |   8 ++
>  MAINTAINERS                             |   6 ++
>  drivers/hid/Kconfig                     |  13 +++
>  drivers/hid/Makefile                    |   1 +
>  drivers/hid/hid-apple-magic-backlight.c | 120 ++++++++++++++++++++++++
>  5 files changed, 148 insertions(+)
>  create mode 100644 drivers/hid/hid-apple-magic-backlight.c

Hi,

thanks for creating the support for backlight.

Is there any reason why not to fold all this into existing hid-apple? I 
don't think we need separate driver for the backlist, separated from the 
rest of hid-apple support.

Thanks,

-- 
Jiri Kosina
SUSE Labs

