Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533DE6DFB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDLQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDLQSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:18:34 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708297280
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:18:20 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PxSYj2B8gz3yPF;
        Wed, 12 Apr 2023 12:18:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1681316297; bh=EfKelFtoShfAhHqsoxi/BGgvCZiUEnz4TLFlAjiSo44=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=hf6+uHU714xRrWJOVS+5WY97gm61cgZRYHW15DTVO2hg9igUgERCcz5Bhmp/C7uPX
         oSPSd9Wp+NF7fC7Z5/HYWmHOjsr7ywut0ijR6zFNreDKYW5Oxa3ZRMBhr2IuTg/ytn
         vEPfmuMYEc7SnSE9tg2qYCLLIsN4/lappkOk/F/Q=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Wed, 12 Apr 2023 12:18:17 -0400
Message-ID: <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
In-Reply-To: <20230412150225.3757223-1-javierm@redhat.com>
References: <20230412150225.3757223-1-javierm@redhat.com>
Date:   Wed, 12 Apr 2023 12:18:17 -0400
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
From:   "Pierre Asselin" <pa@panix.com>
To:     "Javier Martinez Canillas" <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, "Pierre Asselin" <pa@panix.com>,
        "Jocelyn Falempe" <jfalempe@redhat.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The commit f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")
> fixed format selection, by calculating the bits-per-pixel instead of just
> using the reported color depth.
>
> But unfortunately this broke some modes because the stride is always set
> to the reported line length (in bytes), which could not match the actual
> stride if the calculated bits-per-pixel doesn't match the reported depth.
>
> Fixes: f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")
> Reported-by: Pierre Asselin <pa@panix.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  drivers/firmware/sysfb_simplefb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/sysfb_simplefb.c
> b/drivers/firmware/sysfb_simplefb.c
> index 82c64cb9f531..5dc23e57089f 100644
> --- a/drivers/firmware/sysfb_simplefb.c
> +++ b/drivers/firmware/sysfb_simplefb.c
>
> [patch elided]

NOOOOOO !  The 1024x768x32 screen is all garbled.
(gfxpayload=keep, gfxpayload=1024x768x32 or vga=0x318).

The other modes work as before (but the dmesg has less information;
I'll investigate.)

