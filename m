Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6E6A04B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjBWJYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjBWJYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C29D498A5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677144206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYz6ISRuw+w8lBnyEGitxPMfqFWhhqUz+9Ol5bQrc8s=;
        b=NhfCFFsCmNEbDmARrsk71nrpgrnpu/rRCPA1VcDbOPfYgzZXAyFV7XwhwsQiScArXQloXA
        ScxCmcXLi1+FX10R1kCdJrC1e0EJglPFtensjtm9cxNujsCCrsV/6ZKuKelDsTku2FroH/
        bmCTo17oHDnGl43q9vWGX1lMfm/+xa8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-a-KSXplhMni1Yrky9_hegg-1; Thu, 23 Feb 2023 04:23:25 -0500
X-MC-Unique: a-KSXplhMni1Yrky9_hegg-1
Received: by mail-qv1-f69.google.com with SMTP id ef20-20020a0562140a7400b004c72d0e92bcso5082788qvb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677144204;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYz6ISRuw+w8lBnyEGitxPMfqFWhhqUz+9Ol5bQrc8s=;
        b=fjt4UGar+wTf00V8tXnDlvZLgDF/4te4D0zyI2Z9oUP08X97Ns07BYY9I9HJoNifj7
         iGS7bvCRSdd0mODtVv/mMgE70jBUQpjgnzTv5aA1KxgTOE9huVsiu5bR9uhgt4eyFvok
         ifth44piXDXh+A/8oUBghixrogRw3HIrqjfiXd7i/FZ+QZEZj0imDpgWeUYi7GNCGuIp
         XxzOzE1s7flEyIl88Xk1+MVw2SqjJQZMFTw+MEhA4OVmtEdfiJ9XJjeO9ejSS8KdHx6I
         2xITgj/EJZDME3lsDYvrIFYqFe61+Khaq5YDforh1uZc/78M4L1zGxY5sTjKKetC+tCE
         5lxw==
X-Gm-Message-State: AO0yUKVjCZMXqliJatR2TON57s+Tg09PUC0lHGbmPpKiM+k7ijoy1IfV
        VJ9PcMsHnuzRb9JrzHGc8jhidHGzH+90dJSXlvMo+4/o7NXFrvcP4Su8M2OHuLhUp//mtzsPLuz
        fAR39QJJeXwV9/FAaduk9NmZDshRKJQ==
X-Received: by 2002:ac8:5a0c:0:b0:3bf:a60d:43b9 with SMTP id n12-20020ac85a0c000000b003bfa60d43b9mr12837873qta.4.1677144204538;
        Thu, 23 Feb 2023 01:23:24 -0800 (PST)
X-Google-Smtp-Source: AK7set+oLvF9ccKqkO5PBKUk+0jH2eXRorzWU+Wz3cNNqITHXihV4oheZdAbTLxGypVd92hXC5kTFg==
X-Received: by 2002:ac8:5a0c:0:b0:3bf:a60d:43b9 with SMTP id n12-20020ac85a0c000000b003bfa60d43b9mr12837859qta.4.1677144204225;
        Thu, 23 Feb 2023 01:23:24 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id z34-20020a05620a262200b0073b929d0371sm4181111qko.4.2023.02.23.01.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:23:23 -0800 (PST)
Message-ID: <4e85db8c0dd2ac32e404aa3a2ca24dfb503fbc64.camel@redhat.com>
Subject: Re: [PATCH net v333 0/4] net: phy: EEE fixes
From:   Paolo Abeni <pabeni@redhat.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Date:   Thu, 23 Feb 2023 10:23:20 +0100
In-Reply-To: <20230222055043.113711-1-o.rempel@pengutronix.de>
References: <20230222055043.113711-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2023-02-22 at 06:50 +0100, Oleksij Rempel wrote:
> changes v3:
> - add kernel test robot tags to commit log
> - reword comment for genphy_c45_an_config_eee_aneg() function
>=20
> changes v2:
> - restore previous ethtool set logic for the case where advertisements
>   are not provided by user space.
> - use ethtool_convert_legacy_u32_to_link_mode() where possible
> - genphy_c45_an_config_eee_aneg(): move adv initialization in to the if
>   scope.
>=20
> Different EEE related fixes.
>=20
> Oleksij Rempel (4):
>   net: phy: c45: use "supported_eee" instead of supported for access
>     validation
>   net: phy: c45: add genphy_c45_an_config_eee_aneg() function
>   net: phy: do not force EEE support
>   net: phy: c45: genphy_c45_ethtool_set_eee: validate EEE link modes
>=20
>  drivers/net/phy/phy-c45.c    | 54 ++++++++++++++++++++++++++++--------
>  drivers/net/phy/phy_device.c | 21 +++++++++++++-
>  include/linux/phy.h          |  6 ++++
>  3 files changed, 68 insertions(+), 13 deletions(-)
>=20
@Russel: I read your last reply to the v2 series as an ack here, am I
correct?

Thanks!

Paolo

