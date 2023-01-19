Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781D2673232
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjASHOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjASHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:14:09 -0500
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF0B4ABE8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=RlajkAGLHHL3Oe4E2DuduVY0n/IKsX1RAqtwIkCDmfs=;
        b=Oasw9Ofl5K3CXDRcsiUEVUXL46ciEzVqtrAzQg4ErwlcxEwGcUIll/oFC9kMNlK7m/dwZM9HjTpJ2
         qEcsDfc49zG3uy1QOAJs0DUMrI3jqkomnjXtEy2WIIUh+0jWaSu30eS52t4wodqECnDOopdOyQgwvJ
         730Cz+7XQfVzu5Z23oQle+HgGHSnKAkVNfipzu6/jNoeGdpBeicnaX4/DUc+tKahiFkWmSApErmXna
         9wdJautTQlFSDI6XIXKeRAku7Dmmt385chGzhNRUqIi7vfFok3nSkOa1CxiA9rVuTrc1UjnOLOO02s
         PJKel5lFbS9xWpLDQFcVNotkDNP9zEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=RlajkAGLHHL3Oe4E2DuduVY0n/IKsX1RAqtwIkCDmfs=;
        b=NUSB8JZedqrcI0kjtit1ygo0qCxpxVUoHhaz+KLztMHdfl41rU6XEhW+XvimamGFIAKqEZjiv9lHJ
         WZMN2mbDA==
X-HalOne-ID: d884b2c6-97c8-11ed-9cfc-11abd97b9443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id d884b2c6-97c8-11ed-9cfc-11abd97b9443;
        Thu, 19 Jan 2023 07:14:03 +0000 (UTC)
Date:   Thu, 19 Jan 2023 08:14:01 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Mentz <danielmentz@google.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH v3 0/3] drm/mipi-dsi: 16-bit Brightness Endianness Fix
Message-ID: <Y8jtucG3MMk8Oqk8@ravnborg.org>
References: <20230116224909.23884-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116224909.23884-1-mailingradian@gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard.
On Mon, Jan 16, 2023 at 05:49:06PM -0500, Richard Acayan wrote:
> Changes since v2 (20230114010006.50471-1-mailingradian@gmail.com):
>  - patch vtdr6130 to use _large (3/3)
>  - remove Change-Id again (1/3)
>  - change patch subject (1-2/3)
>  - correct function name in patch description (2/3)
>  - add Tested-by tags (1-2/3)
> 
> Changes since v1 (20230113041848.200704-1-mailingradian@gmail.com):
>  - move 16-bit brightness handling to new functions and revert API
>    change (1/2)
>  - remove Change-Id in compliance with checkpatch.pl (1/2)
>  - separate panel driver changes (2/2)
> 
> This series adds proper support for 16-bit MIPI DSI brightness and
> cleans up existing panel drivers with 16-bit brightness.

The series is:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Neil - I hope you can land this in drm-misc.

	Sam
