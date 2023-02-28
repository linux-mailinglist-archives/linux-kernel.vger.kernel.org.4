Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6356A588F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjB1LvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjB1LvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44571F5C3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677585021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FfScrIsI5x6rEVkEdrSdiYdcOjklUHQX5rbDlaigbQQ=;
        b=iCGOmmw6pA9RnhcOkeNaTZtmTaC3bjVffxjMtDd/HIT1rmEcGpUa3fc/LgV8fb6EAywDUP
        FtuHdEk4ZNrJXkIIFCtDMQcjczMY49oEM5fwLpGMj4C9BJ0DaSme+QbMtC2bF8awB6Wr3d
        VYFFm6giUDWl+Umby7NpkJH7aq5kgVo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-g7s1APMWNnCZ7Z8htErE4A-1; Tue, 28 Feb 2023 06:50:20 -0500
X-MC-Unique: g7s1APMWNnCZ7Z8htErE4A-1
Received: by mail-wr1-f70.google.com with SMTP id d14-20020adfa34e000000b002bfc062eaa8so1507442wrb.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfScrIsI5x6rEVkEdrSdiYdcOjklUHQX5rbDlaigbQQ=;
        b=7JVr9XbQmlrmltlqTF2GrpMhQ1UjXNP8sSOIZ0JFarsQwb7FUGYeQJCZeiJWsHJ750
         l8+QMg5+MejMPyVYqeIZzerKSQeRViaI/S9H6QKbG7p8/yXs+c6LLMmIoQRDWeQERmX6
         ndaxiTnaKx328kqem9LR0XUnTvZ2cqfbBLzkh/hB3jh2hxl+RpL88+7wWYKG8HZb4KPO
         orSzSM5sZZsA8Ko4gX0WInsj3sWx/F6DZM0Ydb8Hl0lhldqIwZCtPpRT9yU2CumRbVzA
         zIzLXIuCIvfM0+pcZ5f5hdnzgj7LzHhiTj2MfqVjsh4+Ii1nrnlD5sVnPaHLzcGbiM/W
         2WdA==
X-Gm-Message-State: AO0yUKXhuliHZru9TcxdsX6OBTeDmTrPdC1s6DXtW7D3/qIXdeSK19s/
        WfL6HHgqtAgMBPDAEC1MA1tdMVFNH78dR/cYNvbKSHE05W/VjoFmWC30xJ0cfskG81xlnMw2nfB
        JIG9wAwcex0jj3SFhATevehyR
X-Received: by 2002:a5d:5962:0:b0:2c9:8b81:bd04 with SMTP id e34-20020a5d5962000000b002c98b81bd04mr1598338wri.0.1677585019330;
        Tue, 28 Feb 2023 03:50:19 -0800 (PST)
X-Google-Smtp-Source: AK7set/WCwUQ3kuQSoUUChN/7DoXag2/WHh+Ag1Cof24ZSeYbEAZPY3yHLOgPqbpAD21sl85tNb6aA==
X-Received: by 2002:a5d:5962:0:b0:2c9:8b81:bd04 with SMTP id e34-20020a5d5962000000b002c98b81bd04mr1598321wri.0.1677585019011;
        Tue, 28 Feb 2023 03:50:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id z10-20020a5d44ca000000b002c6e8af1037sm9651101wrr.104.2023.02.28.03.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:50:18 -0800 (PST)
Message-ID: <192d72313269845fe19d6d8baecbecfb9d184f77.camel@redhat.com>
Subject: Re: [PATCH v2] net: lan743x: LAN743X selects FIXED_PHY to resolve a
 link error
From:   Paolo Abeni <pabeni@redhat.com>
To:     Tom Rix <trix@redhat.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, steen.hegelund@microchip.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Feb 2023 12:50:17 +0100
In-Reply-To: <20230227130535.2828181-1-trix@redhat.com>
References: <20230227130535.2828181-1-trix@redhat.com>
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

Hello,

On Mon, 2023-02-27 at 08:05 -0500, Tom Rix wrote:
> A rand config causes this link error
> drivers/net/ethernet/microchip/lan743x_main.o: In function `lan743x_netde=
v_open':
> drivers/net/ethernet/microchip/lan743x_main.c:1512: undefined reference t=
o `fixed_phy_register'
>=20
> lan743x_netdev_open is controlled by LAN743X
> fixed_phy_register is controlled by FIXED_PHY
>=20
> and the error happens when
> CONFIG_LAN743X=3Dy
> CONFIG_FIXED_PHY=3Dm
>=20
> So LAN743X should also select FIXED_PHY
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>

You are targeting the -net tree, but this lacks a 'Fixes' tag, please
post a new version with such info.

If instead the intended target was net-next (as I think it was agreed
on previous revision) please repost after that net-next re-opens (in
~1w from now).

Thanks,

Paolo

