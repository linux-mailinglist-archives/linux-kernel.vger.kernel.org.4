Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480726C7077
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCWSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWSsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:48:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B13130E8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:48:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l27so13324445wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679597279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8FWNgQNPCC7D7xKGDpYpPeNQgBYQlnN/7rIkoHcrFk=;
        b=A3qhSSsUsD/lcphIMCN1rqn4spmYLqxOG8pKshDIEoxr8HVR/L+UzpNq5BOfMPIJlD
         B+5wR6AvIR2CuZIdGd/WKGkkXAscp6/88OntRjifaYmyNwSrb4gfjIYsp+wGqgcGbAig
         84j2hnha0Zr1scEZymEwQ5hztC7yaglGYdoV9scQ6HZJIQ2ZYWgrMoY4kXQax7P3S7BW
         a+jaAvwmRJDo6prhIBJYdpSCGEHUoS47IG7mjmzGoIX5t9YZ8nyk0FgpgVT/rcdZN7XR
         ssXBToTblWo9v1ALX+5Q685638iWGa+KYZf3azI0kGvK/Te7brV4PRbCVlHDE3R15THq
         +wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679597279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8FWNgQNPCC7D7xKGDpYpPeNQgBYQlnN/7rIkoHcrFk=;
        b=DVM1Li1Pp/UuKzvy1Dq/SAXqKYhqQeiJ7spN+pfKdsbRF3aG6Jok7cAuJNXyNA+5LK
         2VVjKwC716NXukJnM63ISpE2Pj5x/YpF58s5gDyA61+xDuR091lZtrXIlXcjTigOLxEy
         FV13bqUfW1N72j0ekAVM/E52i4YqmaljWrbIGKM4m8hSIdx00Hkdkl41kDBX4mvc98qJ
         umQqShd9uNrSQw0AQXYFaJm0/+ANmYs+9kZIPwOBQfiaSqHX7DJfNJRHyFFvUnEuPIja
         OX4RtkBiT2CmkPUF7GHFFhDpCDO0HT3gkb4gTaYqJSQ9H6vxoxY7m4Dc/3BdKmw5TQJr
         lrWA==
X-Gm-Message-State: AAQBX9cfAEh2vpTkJXAXeMAxRrsCqoVLw1MkXOuzImL8/Ef0xZDkkQKQ
        Nk8etjFmZhSoZPZG8NUMkCGdwsYtx14=
X-Google-Smtp-Source: AKy350aBvrFH/pBwHenW0d3ikefW7j6jxF4RZSJ9EpFvZkGt37FYUa2OgZABIV5NDF983nCS4QRhbQ==
X-Received: by 2002:a5d:6389:0:b0:2cf:e058:3ccc with SMTP id p9-20020a5d6389000000b002cfe0583cccmr119559wru.66.1679597278568;
        Thu, 23 Mar 2023 11:47:58 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id p5-20020adfce05000000b002d64fcb362dsm11489891wrn.111.2023.03.23.11.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 11:47:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     vkoul@kernel.org, ye.xingchen@zte.com.cn
Cc:     kishon@kernel.org, wens@csie.org, samuel@sholland.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: allwinner: Use dev_err_probe()
Date:   Thu, 23 Mar 2023 19:47:56 +0100
Message-ID: <2672110.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <202303231542125412125@zte.com.cn>
References: <202303231542125412125@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 23. marec 2023 ob 08:42:12 CET je ye.xingchen@zte.com.cn=
=20
napisal(a):
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>=20
> Replace the open-code with dev_err_probe() to simplify the code.
>=20
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


