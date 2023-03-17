Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535DE6BE840
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCQLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCQLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:35:50 -0400
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E45B048A;
        Fri, 17 Mar 2023 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:References:In-Reply-To:Message-Id:Cc:To:Subject:From:
        Date:From:To:Subject:Date:Message-ID:Reply-To;
        bh=C9aTotIjq9CWOwt4DF2OMCxQ6qxtlKTahgfE76R/yM0=; b=CrACuCukpK7g6mlA1qXPh4ez33
        cP2JDTsm1r5USG7iIs+6GjflMdwD7BK2BAko9fgaw9GkM75xNR/C/ErdF9CQKN6VjZV05BhCPRcqf
        byUE3ZMIFvH0x1MICINaZE+sYDQDBkYZK+X2xgTd9ewdoB/IQKn177JwR4BpU7bcZao19gqG82Fwr
        40yd6xz8ySFghLD4xr1b3HGXFbJHwU1duU3fg0KPKB+pSjaQjR+7YToyWfpMW0JFlG2Ut7AvvYQPf
        R2AsR3KpzucbcQWcXRbhVckS/ECVStVkGkj4YIL40xA3TvR6hhnRrSTB3W9y3ZxMpSIdXaXQblkIB
        RydEQpgg==;
Received: from [212.51.153.89] (helo=[192.168.12.42])
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1pd8LS-001ltX-35;
        Fri, 17 Mar 2023 11:34:02 +0000
Date:   Fri, 17 Mar 2023 12:33:57 +0100
From:   Lorenz Brun <lorenz@brun.one>
Subject: Re: [PATCH] hwmon: pwm-fan: set usage_power on PWM state
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <LGXNRR.0Q7OXCG5DVDQ2@brun.one>
In-Reply-To: <ec52f540-0f78-4cf0-ae61-314cab33ac80@roeck-us.net>
References: <20230309011009.2109696-1-lorenz@brun.one>
        <ec52f540-0f78-4cf0-ae61-314cab33ac80@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: lorenz@dolansoft.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, 15. M=E4r 2023 um 19:26:26 -07:00:00 schrieb Guenter Roeck=20
<linux@roeck-us.net>:
> This doesn't seem to be used anywhere else. I do not understand the
> rationale, and I do not understand the practical impact of this=20
> change.
> This needs to be confirmed by someone who understands what the flag is
> supposed to be used for, its impact, and if it is indeed appropriate
> in this context.
>=20
> Also, since in practice there is no such "less flexible hardware"
> in the upstream kernel, please describe the use case in more detail.
> The only pwm driver that supports usage_power is pwm-pca9685,
> and that driver uses the flag for EMI reasons, not because it is
> "less flexible hardware". I am not inclined to accept such a change
> without specific use case or need.

The reason for this is that I have a PWM-driven fan on a Mediatek=20
MT7986a whose PWM signal is inverted by a MOSFET.
The PWM peripheral of the MT7986a however doesn't support inverted=20
output, at least not in a strict sense (i.e. if inverted mathematically=20
it is out of phase). The maintainer of the PWM subsystem recommended=20
that I only mathematically invert if usage_power is set as this means=20
that phase doesn't matter.

See=20
https://lore.kernel.org/linux-pwm/20230309010410.2106525-1-lorenz@brun.one/=
=20
for the PWM-side patch.

Regards,
Lorenz


