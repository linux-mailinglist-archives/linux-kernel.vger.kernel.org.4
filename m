Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD9663F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbjAJLSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjAJLRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B595F6E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673349426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7R6k4XeSSfrouTet4Pl7FYt1MDO+biHA3LgQPUZKzOM=;
        b=c2uS+JooQAbLZMtzL6pOeJ7FDpMbaTd6WDJzYG/AsdaWjFvJL7TvgEwlmTSWxFbNtbJNXI
        bl1MLteORMcfQzY+GSyHGyimBWxRcxyFhk3uumiRrs3bAxH0jwqRrgvhuhx4uoaK80ln3e
        9vOtSDNq/oFJDS3tsJ5BRJNMeDG5OyA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-57-5V-BIPyjM9WtzyO8snj4YA-1; Tue, 10 Jan 2023 06:17:00 -0500
X-MC-Unique: 5V-BIPyjM9WtzyO8snj4YA-1
Received: by mail-qk1-f197.google.com with SMTP id y6-20020a05620a44c600b00704d482d3a0so8612169qkp.21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7R6k4XeSSfrouTet4Pl7FYt1MDO+biHA3LgQPUZKzOM=;
        b=g4Hb6tCExon9QOl1IWWgSyumdEx+qduql2+3oeyQpOu9bA+HL7g1M6ffYbdeGe9rK0
         W9AfmuDNtnoajBi3rEByEkvicjctAsglUJZYixPHkSBCw8Hc8uAVbW/5pGKFCh7eC0RO
         xzipY22mXAsJ+K6+JZ3dEJv9UCtEMHUijKqqp/JTqgeKQTi01K+V/Ci/6VeIKudsXhXP
         QdYLZxfGxaoeXvusC/J9Pg90kCpPaQKKUvIA1WyNouJyEiyOnpyrzPVTqHm7KWSZwzqu
         TdEyZDbZGQfd2R9Nm6NR2ye401tFztjJK0iccAYiEKrGneCs1VqpWpLYz/2eX3+sErL6
         tedQ==
X-Gm-Message-State: AFqh2kpsVHWmqTfkBIlJP8JwCZhbPxjRWjx45ENRW0DJYlZtoBhQYACH
        bkyG1PD5fVg9fhqwpLym+4zjrn1353WgEMU6y+RKWpy+8De2Le0zRiI7W4qzFqEBI45K4CWOL3w
        V2mFTjzRRnBmqlLXAMWFWRJN9
X-Received: by 2002:ac8:520c:0:b0:3a8:1079:b844 with SMTP id r12-20020ac8520c000000b003a81079b844mr89443423qtn.46.1673349419766;
        Tue, 10 Jan 2023 03:16:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt7LAw0VjeSUK8wkVXMaLsnRFvPYmNquEuKr7XZHAByB6NkEWLdJSItXvzP6gLV6c7Tmr1r8Q==
X-Received: by 2002:ac8:520c:0:b0:3a8:1079:b844 with SMTP id r12-20020ac8520c000000b003a81079b844mr89443387qtn.46.1673349419493;
        Tue, 10 Jan 2023 03:16:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-128.dyn.eolo.it. [146.241.120.128])
        by smtp.gmail.com with ESMTPSA id k8-20020ac80748000000b0038b684a1642sm5839964qth.32.2023.01.10.03.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:16:58 -0800 (PST)
Message-ID: <5bd7ee34ead313785951defbf3069b64d4338a45.camel@redhat.com>
Subject: Re: [PATCH net-next v3 01/11] net: mdio: Add dedicated C45 API to
 MDIO bus drivers
From:   Paolo Abeni <pabeni@redhat.com>
To:     Michael Walle <michael@walle.cc>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Tue, 10 Jan 2023 12:16:53 +0100
In-Reply-To: <20221227-v6-2-rc1-c45-seperation-v3-1-ade1deb438da@walle.cc>
References: <20221227-v6-2-rc1-c45-seperation-v3-0-ade1deb438da@walle.cc>
         <20221227-v6-2-rc1-c45-seperation-v3-1-ade1deb438da@walle.cc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-09 at 16:30 +0100, Michael Walle wrote:
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 6378c997ded5..65844f0a7fb3 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -364,6 +364,11 @@ struct mii_bus {
>  	int (*read)(struct mii_bus *bus, int addr, int regnum);
>  	/** @write: Perform a write transfer on the bus */
>  	int (*write)(struct mii_bus *bus, int addr, int regnum, u16 val);
> +	/** @read: Perform a C45 read transfer on the bus */

Minor nit: s/@read/@read_c45/ 

> +	int (*read_c45)(struct mii_bus *bus, int addr, int devnum, int regnum);
> +	/** @write: Perform a C45 write transfer on the bus */

Mutatis mutandis, same thing here.

Thanks!

Paolo

