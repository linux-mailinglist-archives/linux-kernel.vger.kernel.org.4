Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F0A712B43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjEZQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjEZQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:59:14 -0400
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 May 2023 09:59:12 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00DDF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1685119764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aj1j1eWnCNHkS6D2DwM5Jr/0q4xT5pPG+Y73M+V83Ao=;
        b=PPtGipJ+XCfC1BdEMlL0wR14pV4KVlh6ULCXamLHvi7/yCy2Ee54zxE1Q/q3dXr8m2o6Ij
        qCodqHEpyEYzJrWzrbTjSZUFq1mO6UqMXdj1143hCwgibbfVPnYIiiuweiecv/IFx1PwR4
        +Bx1iRyCjH0IDgFHOD9aP0UPCL0DQKE=
From:   Sven Eckelmann <sven@narfation.org>
To:     Marek Lindner <mareklindner@neomailbox.ch>,
        Vladislav Efanov <VEfanov@ispras.ru>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] batman-adv: Broken sync while rescheduling delayed work
Date:   Fri, 26 May 2023 18:49:21 +0200
Message-ID: <5834562.MhkbZ0Pkbq@bentobox>
In-Reply-To: <20230526161632.1460753-1-VEfanov@ispras.ru>
References: <20230526161632.1460753-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1760861.VLH7GnMWUR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1760861.VLH7GnMWUR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 May 2023 18:49:21 +0200
Message-ID: <5834562.MhkbZ0Pkbq@bentobox>
In-Reply-To: <20230526161632.1460753-1-VEfanov@ispras.ru>
References: <20230526161632.1460753-1-VEfanov@ispras.ru>
MIME-Version: 1.0

On Friday, 26 May 2023 18:16:32 CEST Vladislav Efanov wrote:
> The reason for these issues is the lack of synchronization. Delayed
> work (batadv_dat_purge) schedules new timer/work while the device
> is being deleted. As the result new timer/delayed work is set after
> cancel_delayed_work_sync() was called. So after the device is freed
> the timer list contains pointer to already freed memory.

You are most likely right but could you please point out what in the worker is 
checked by the workqueue code that prevents it from being scheduled again?  
(and which seems to be overwritten as your patch seems to suggest)

I think __cancel_work_timer marked the work as canceling but 
batadv_dat_start_timer reinitialized the worked (thus removing this important 
state). Would be nice if you could either correct me or confirm what I think to 
remember.

Kind regards,
	Sven

--nextPart1760861.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmRw4xEACgkQXYcKB8Em
e0Zk4w/9EOOJrN9tg9/gQ5TCqm6SySIDZqpQW/AeUktUNl88NPsdjzOeJtKSqv4H
hvfTgoAiOsAEuB2HoHlumdo5OZkYWwZFLmYhYbNZUH5HXVcAciAkLLabK8dSUBTX
9EKzdDb3PY7+eGIAAMUn2CF4l2WEkOzBIdVHpV6iXyL7l+qOx/IeRPDLX/WKJKPX
kh6IOP/i/bqYDdOs62+p4MYboTh2CGrSjpLGz9yOiM4rndr4clemJDQsuhbVhJ5F
fbTNtJJUtu6u4fwgdj7yHMIpZy/rXGAtj4NruSC95eR7P4Jm8R9P2j023+pF3Shy
OtzFG52bCd7Gz4fIVS5Vjqi1OMwZvVDi/ufvRfD8mRWg7oGg+SauY6iBM45GhJUx
G9R3DUuC8WJ774iWhYa1ZGHltQ6t0xBZfWOAdA1YxCoNuNbFMPOetJHcPj4D8w1y
CLY3rKYINm3hSpNPVgmcnCYEbCOL8ZJ1pDDeZtZbhcGIE1PKUaJ+QcCOseoPRyAn
gi+uoidkcG3sMDBWUYqpbx/QTjpBTtS16D4LazRUyhyBg1qLTYdhhdv06QZ2Dq2x
XaSYVWsdvLcIAFXfBXuneoff3Kj+26DTo/qOizhMzjANDYVyzn/4na80xvrCfAZS
EZ1MzcWh1zbKpRlUfFzGnUP3ZllHxRlHPmiF5qx9NjqTI074om0=
=vwPk
-----END PGP SIGNATURE-----

--nextPart1760861.VLH7GnMWUR--



