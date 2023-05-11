Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825AC6FF4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbjEKOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbjEKOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:44:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28142106E6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1F5464E5F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1E5C433EF;
        Thu, 11 May 2023 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683816025;
        bh=lhI97CHH+r3JLmZwQJ+lLCcnnkyzDi2iG/AZXvbQjXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZdBmPpHIb8oTFwPtVIEBrQYjKulFQ1kqFvAU/1y0pI/YnrmjrbnhcwFtHauRSfVK0
         /XseV5P7UuUg6bPX0HHU+0tidaa0C9WejyTgx7aDDDKmyvfn173UsQbizB/G1E364I
         D2G0tNBR8XiKfKjvhVIq10rtGfbapR9/6wnJITsh212J4t/mQ8PJxwkolh1XqlY1FK
         TuT89fjKxpktCG90Gf860PxN35BAd7s+jvV/pBNal/zdWFpkVf/dK3h1rqFLjH77Qo
         nmncdrXyFyzXmhLwzQL4VNi9M7z3gt7tNAdapUtTamYssWfk9ROsaCxY9t/2HU+oHA
         cs0aEz0lR/2ow==
Date:   Thu, 11 May 2023 07:40:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Georgi Valkov <gvalkov@abv.bg>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Foster Snowhill <forst@pen.gy>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: net: usb: ipheth: add CDC NCM support
Message-ID: <20230511074023.5217e972@kernel.org>
In-Reply-To: <0A1C2108-75F2-46B7-8712-616FE6464294@abv.bg>
References: <0A1C2108-75F2-46B7-8712-616FE6464294@abv.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 12:47:56 +0300 Georgi Valkov wrote:
> Can you please review, and accept the following patch. I=E2=80=99ve been =
using it for one year.
> I added the author Foster Snowhill to this mail, as well as a link to his=
 Github [1].
> If needed, we can ask him to add the tag Signed-off-by:
>=20
>=20
> From 257d843a7f90e4e519635f82fe5b73fba918ec33 Mon Sep 17 00:00:00 2001
> From: Foster Snowhill <Forst@users.noreply.github.com>
> Date: Fri, 22 Apr 2022 23:50:09 +0200
> Subject: [PATCH] net: usb: ipheth: add CDC NCM support (PoC)
>=20
> Recent iOS releases support CDC NCM encapsulation on RX. This mode is
> the default on macOS and Windows.
>=20
> When reconnecting a device from a macOS/Windows machine to a Linux
> machine, the device stays in NCM mode. Therefore to correctly support
> such a device, the driver has to either support the NCM mode too, or
> somehow put the device back into legacy mode.
>=20
> To match the behaviour of the macOS/Windows driver, and since there
> are no documented control commands to revert to legacy mode, I chose
> to implement basic NCM support.
>=20
> With this change, the device is attempted to be put into NCM mode by
> default, and falls back to legacy mode if said attempt failed.
>=20
> Tested-by: Georgi Valkov <gvalkov@abv.bg>

Take a look at submitting patches, the best way to send a change is
with git send-mail. And make sure you CC the right lists
(./scripts/get_maintainer.pl)
