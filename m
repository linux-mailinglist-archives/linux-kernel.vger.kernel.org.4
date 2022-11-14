Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A96285E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiKNQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiKNQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:47:17 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7442F028
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:47:16 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 136so10732683pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wp2r5sOKSPnFfxOe1YPv2WL/uyKGNGV64mrkimgTlg=;
        b=gpM8m2BfIZso6q+IPKgPD0qw6C+kQdQSbFy4mILSfdg+RulbnWvcJVkcNlZsPWMkCh
         wnkvNnUTfLidE1iDSgnBypT5GgLMDyorYORfeVCQC6lvh3bUi1YdpKdBTHRYiwA009/x
         nFUUA1UGJv5pLEUTGOTqjjWvg2uOUrXUpFryptZTmmCC1lj/iNdzlY4XGI1JeFoYJmx9
         z4aTvb/TghidrgBhWFgkKswU9wqOSVPGCMhUVHfYjC9JWLz7idm9+IuHUV8LpT5LW3FV
         DLtq3SNIQVaQSJgmma7uqigClNVKmJsyS49WrEOTd8XZeGNunf5UPuMYvflwvvgFRpWC
         QhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Wp2r5sOKSPnFfxOe1YPv2WL/uyKGNGV64mrkimgTlg=;
        b=AUia1Pc40txrG4FwhY8WZUdOurkyqO76hK+qQhoz1o3kKOU+W6IsLB9H29lWMNfc38
         2LezAa173DlUwLBX+IuYVN4KObKS5bt1mFkQGTuluWnEP6FZnikAEWLVJXwo5o0Ytiv0
         t4ZWdboms/Geg7Djqz+2IWMQezRhAZSUrRpUq/6C+OM2714xnYB+wxFKrLW/q1Ad/JnK
         tm8BTspOTJQosia8rlebzZ9BVYv62skJ2zdXs+3nzpW5c3l7qr+dxEtYxW94UB0pPPAw
         U768oFS/JCnCHfLAqeygwYI7vz+jcW3dM4VYCsn0sKQKKeoUDqfU1IosRLqRQbYvOEDv
         zGHA==
X-Gm-Message-State: ANoB5pls55aShEkrD9DOrrwblMHsk1Iy6dH4EnS+GUjtNEwaHsVeJ6zw
        kuYDPuHtV7v8M92qAH4HC9qNCA==
X-Google-Smtp-Source: AA0mqf776PClTG4ZL3d4AZ/tlQ56qkKBBRl4WmvFBBhthNyIyensC+HbnTeluhhSNEumuPiK2OHtYA==
X-Received: by 2002:a05:6a00:ad4:b0:56c:f16d:2f29 with SMTP id c20-20020a056a000ad400b0056cf16d2f29mr14841296pfl.53.1668444435526;
        Mon, 14 Nov 2022 08:47:15 -0800 (PST)
Received: from smtpclient.apple (c-208-53-111-167.customer.broadstripe.net. [208.53.111.167])
        by smtp.gmail.com with ESMTPSA id a30-20020aa78e9e000000b0056c702a370dsm6904367pfr.117.2022.11.14.08.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:47:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH] tty: synclink_gt: release resources when synclink_gt
 driver open failed
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <20221114010734.314910-1-shaozhengchao@huawei.com>
Date:   Mon, 14 Nov 2022 08:47:13 -0800
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, akpm@linux-foundation.org,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DFE07D7-B041-4C1C-8182-020066D4A5C2@microgate.com>
References: <20221114010734.314910-1-shaozhengchao@huawei.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch identifies two problems in the error path of hdlcdev_open():

1. module_get/put pairing
2. hdlc_open/close pairing

The module_get/put calls are not necessary. The synclink_gt driver is =
pinned on hardware enumeration which happens before registering as a =
generic hdlc device. I think this is cruft leftover from ancient code. =
The only other generic hdlc (network) driver I still see doing it is =
farsync.c.

The best solution is removing the module_get/put calls and balancing =
hdlc_open() with hdlc_close() in the error path of hdlcdev_open(). I =
will submit a patch to do so after I=E2=80=99ve had a chance to test it.





> On Nov 13, 2022, at 5:07 PM, Zhengchao Shao <shaozhengchao@huawei.com> =
wrote:
>=20
> When synclink_gt driver open failed, it doesn't release resources. =
Compile
> tested only.
>=20
> Fixes: d4c63b7c7450 ("synclink_gt fix module reference")
> Fixes: 705b6c7b34f2 ("[PATCH] new driver synclink_gt")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> drivers/tty/synclink_gt.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 25e9befdda3a..4dea52486410 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -1441,14 +1441,15 @@ static int hdlcdev_open(struct net_device =
*dev)
> 	/* generic HDLC layer open processing */
> 	rc =3D hdlc_open(dev);
> 	if (rc)
> -		return rc;
> +		goto err_open;
>=20
> 	/* arbitrate between network and tty opens */
> 	spin_lock_irqsave(&info->netlock, flags);
> 	if (info->port.count !=3D 0 || info->netcount !=3D 0) {
> 		DBGINFO(("%s hdlc_open busy\n", dev->name));
> 		spin_unlock_irqrestore(&info->netlock, flags);
> -		return -EBUSY;
> +		rc =3D -EBUSY;
> +		goto err_open_busy;
> 	}
> 	info->netcount=3D1;
> 	spin_unlock_irqrestore(&info->netlock, flags);
> @@ -1458,7 +1459,7 @@ static int hdlcdev_open(struct net_device *dev)
> 		spin_lock_irqsave(&info->netlock, flags);
> 		info->netcount=3D0;
> 		spin_unlock_irqrestore(&info->netlock, flags);
> -		return rc;
> +		goto err_open_busy;
> 	}
>=20
> 	/* assert RTS and DTR, apply hardware settings */
> @@ -1478,6 +1479,12 @@ static int hdlcdev_open(struct net_device *dev)
> 	else
> 		netif_carrier_off(dev);
> 	return 0;
> +
> +err_open_busy:
> +	hdlc_close(dev);
> +err_open:
> +	module_put(THIS_MODULE);
> +	return rc;
> }
>=20
> /**
> --=20
> 2.17.1
>=20

