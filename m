Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A79673477
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjASJbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjASJbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD123683C2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674120651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ams7vLzB8Gv2qSwCKtf+hsxsWc+b/evQM7rgX5cWtg8=;
        b=SQ+UtcnKle+gk9jeNua+wBzKQlJ6gmPxks8Zn2TM/uipPlydcM1BMGPvzoxib97EQItbBX
        Sx86eACdmzKRoDFkGQ/feAvIysCGKZJ/mp5C8EZiXrykq3LzPyjLqvJ1iEOgwCRPBjkxzp
        EQAKnSIhqqahx43jXuII4UG0+2ppg3c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-eYuIsclpNmCyC0L1CaDCbQ-1; Thu, 19 Jan 2023 04:30:49 -0500
X-MC-Unique: eYuIsclpNmCyC0L1CaDCbQ-1
Received: by mail-qk1-f198.google.com with SMTP id w17-20020a05620a425100b00706bf3b459eso1038233qko.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ams7vLzB8Gv2qSwCKtf+hsxsWc+b/evQM7rgX5cWtg8=;
        b=fcDm5errpmeGzrPD1bf5rwFc00i8R1fs0vfZRrb6GQKFnTbnc68l95BfyusC2DmkE6
         jxbU/IwotybrYJ1KIYTH1k4xE5AQNVI3r1kXQwpOcgcaAZZxTDEkwajvO7ihtWxmIX/k
         XfLID/muwiMZXnSZTOhKROS6KWhT4wYDD28g/bJbhk3mkM/H7Rd2WSHzkskBdXA+J1p6
         fET8A4itlm4tw8YXB3dBAO1MNfKCX9zy97MTybxdiPKkxsuxq9x1NtM4YH7YiVwSNea9
         M569aVzZXQktqBRVPZoRX3MixX8/xd3eD1U4wiyc5B2GFMur1QsYkbsCWsVualRdnzr5
         XJ4A==
X-Gm-Message-State: AFqh2krs20w+SFrMTebYqHeLwTd2+s9bXrBHq1HqEA5A2rB0128hJ7c0
        W/oq/+hv6NQob6RHtp4OZu7nVWBA9am7JdIbC64KLlfP/BoGT61RXPGiuXhPBGVOlP3y09m7qxe
        o6f+zYxQnf9hiNMzvxOQZnXI+
X-Received: by 2002:ac8:70a:0:b0:3b1:c477:eb65 with SMTP id g10-20020ac8070a000000b003b1c477eb65mr14127024qth.60.1674120648703;
        Thu, 19 Jan 2023 01:30:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvUao/zZ2iOFk4JZhJ5Vdo68S+Jy5X6Mm5+rIukHBNnoJQp0iBpGE5xH0CHlDVd8vHuJNic0Q==
X-Received: by 2002:ac8:70a:0:b0:3b1:c477:eb65 with SMTP id g10-20020ac8070a000000b003b1c477eb65mr14126996qth.60.1674120648320;
        Thu, 19 Jan 2023 01:30:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-124-97.dyn.eolo.it. [146.241.124.97])
        by smtp.gmail.com with ESMTPSA id g27-20020ac8775b000000b003ab1ee36ee7sm4787749qtu.51.2023.01.19.01.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 01:30:47 -0800 (PST)
Message-ID: <d7e0f9de056d754d03c828742a8106125358821a.camel@redhat.com>
Subject: Re: [Patch net-next 2/2] net: dsa: microchip: add support for
 credit based shaper
From:   Paolo Abeni <pabeni@redhat.com>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux@armlinux.org.uk, Tristram.Ha@microchip.com
Date:   Thu, 19 Jan 2023 10:30:43 +0100
In-Reply-To: <20230117143252.8339-3-arun.ramadoss@microchip.com>
References: <20230117143252.8339-1-arun.ramadoss@microchip.com>
         <20230117143252.8339-3-arun.ramadoss@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Tue, 2023-01-17 at 20:02 +0530, Arun Ramadoss wrote:
> KSZ9477, KSZ9567, KSZ9563, KSZ8563 and LAN937x supports Credit based
> shaper. To differentiate the chip supporting cbs, tc_cbs_supported
> flag is introduced in ksz_chip_data.
> And KSZ series has 16bit Credit increment registers whereas LAN937x has
> 24bit register. The value to be programmed in the credit increment is
> determined using the successive multiplication method to convert decimal
> fraction to hexadecimal fraction.
> For example: if idleslope is 10000 and sendslope is -90000, then
> bandwidth is 10000 - (-90000) =3D 100000.
> The 10% bandwidth of 100Mbps means 10/100 =3D 0.1(decimal). This value ha=
s
> to be converted to hexa.
> 1) 0.1 * 16 =3D 1.6  --> fraction 0.6 Carry =3D 1 (MSB)
> 2) 0.6 * 16 =3D 9.6  --> fraction 0.6 Carry =3D 9
> 3) 0.6 * 16 =3D 9.6  --> fraction 0.6 Carry =3D 9
> 4) 0.6 * 16 =3D 9.6  --> fraction 0.6 Carry =3D 9
> 5) 0.6 * 16 =3D 9.6  --> fraction 0.6 Carry =3D 9
> 6) 0.6 * 16 =3D 9.6  --> fraction 0.6 Carry =3D 9 (LSB)
> Now 0.1(decimal) becomes 0.199999(Hex).
> If it is LAN937x, 24 bit value will be programmed to Credit Inc
> register, 0x199999. For others 16 bit value will be prgrammed, 0x1999.
>=20
> Signed-off-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz9477.c      |   7 ++
>  drivers/net/dsa/microchip/ksz9477.h      |   1 +
>  drivers/net/dsa/microchip/ksz9477_reg.h  |  27 +-----
>  drivers/net/dsa/microchip/ksz_common.c   | 105 +++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz_common.h   |  20 +++++
>  drivers/net/dsa/microchip/lan937x.h      |   1 +
>  drivers/net/dsa/microchip/lan937x_main.c |   5 ++
>  drivers/net/dsa/microchip/lan937x_reg.h  |   3 +
>  8 files changed, 144 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
> index 5a66d0be2876..f7a6050ddb74 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -1170,6 +1170,13 @@ u32 ksz9477_get_port_addr(int port, int offset)
>  	return PORT_CTRL_ADDR(port, offset);
>  }
> =20
> +int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
> +{
> +	val =3D val >> 8;
> +
> +	return ksz_pwrite16(dev, port, REG_PORT_MTI_CREDIT_INCREMENT, val);
> +}
> +
>  int ksz9477_switch_init(struct ksz_device *dev)
>  {
>  	u8 data8;
> diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microc=
hip/ksz9477.h
> index 7c5bb3032772..50d82bf0cb59 100644
> --- a/drivers/net/dsa/microchip/ksz9477.h
> +++ b/drivers/net/dsa/microchip/ksz9477.h
> @@ -51,6 +51,7 @@ int ksz9477_mdb_del(struct ksz_device *dev, int port,
>  		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
>  int ksz9477_change_mtu(struct ksz_device *dev, int port, int mtu);
>  void ksz9477_config_cpu_port(struct dsa_switch *ds);
> +int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val);
>  int ksz9477_enable_stp_addr(struct ksz_device *dev);
>  int ksz9477_reset_switch(struct ksz_device *dev);
>  int ksz9477_dsa_init(struct ksz_device *dev);
> diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/mi=
crochip/ksz9477_reg.h
> index 4f27dadb4add..1656656a0d16 100644
> --- a/drivers/net/dsa/microchip/ksz9477_reg.h
> +++ b/drivers/net/dsa/microchip/ksz9477_reg.h
> @@ -1483,33 +1483,10 @@
> =20
>  /* 9 - Shaping */
> =20
> -#define REG_PORT_MTI_QUEUE_INDEX__4	0x0900
> +#define REG_PORT_MTI_QUEUE_CTRL_0__4   0x0904
> =20
> -#define REG_PORT_MTI_QUEUE_CTRL_0__4	0x0904
> +#define MTI_PVID_REPLACE               BIT(0)
> =20
> -#define MTI_PVID_REPLACE		BIT(0)
> -
> -#define REG_PORT_MTI_QUEUE_CTRL_0	0x0914
> -
> -#define MTI_SCHEDULE_MODE_M		0x3
> -#define MTI_SCHEDULE_MODE_S		6
> -#define MTI_SCHEDULE_STRICT_PRIO	0
> -#define MTI_SCHEDULE_WRR		2
> -#define MTI_SHAPING_M			0x3
> -#define MTI_SHAPING_S			4
> -#define MTI_SHAPING_OFF			0
> -#define MTI_SHAPING_SRP			1
> -#define MTI_SHAPING_TIME_AWARE		2
> -
> -#define REG_PORT_MTI_QUEUE_CTRL_1	0x0915
> -
> -#define MTI_TX_RATIO_M			(BIT(7) - 1)
> -
> -#define REG_PORT_MTI_QUEUE_CTRL_2__2	0x0916
> -#define REG_PORT_MTI_HI_WATER_MARK	0x0916
> -#define REG_PORT_MTI_QUEUE_CTRL_3__2	0x0918
> -#define REG_PORT_MTI_LO_WATER_MARK	0x0918
> -#define REG_PORT_MTI_QUEUE_CTRL_4__2	0x091A
>  #define REG_PORT_MTI_CREDIT_INCREMENT	0x091A
> =20
>  /* A - QM */
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/mic=
rochip/ksz_common.c
> index fbb107754057..53f4286a2c22 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_net.h>
>  #include <linux/micrel_phy.h>
>  #include <net/dsa.h>
> +#include <net/pkt_cls.h>
>  #include <net/switchdev.h>
> =20
>  #include "ksz_common.h"
> @@ -31,6 +32,10 @@
>  #include "ksz9477.h"
>  #include "lan937x.h"
> =20
> +#define KSZ_CBS_ENABLE ((MTI_SCHEDULE_STRICT_PRIO << MTI_SCHEDULE_MODE_S=
) | \
> +			(MTI_SHAPING_SRP << MTI_SHAPING_S))
> +#define KSZ_CBS_DISABLE ((MTI_SCHEDULE_WRR << MTI_SCHEDULE_MODE_S) |\
> +			 (MTI_SHAPING_OFF << MTI_SHAPING_S))
>  #define MIB_COUNTER_NUM 0x20
> =20
>  struct ksz_stats_raw {
> @@ -250,6 +255,7 @@ static const struct ksz_dev_ops ksz9477_dev_ops =3D {
>  	.change_mtu =3D ksz9477_change_mtu,
>  	.phylink_mac_link_up =3D ksz9477_phylink_mac_link_up,
>  	.config_cpu_port =3D ksz9477_config_cpu_port,
> +	.tc_cbs_set_cinc =3D ksz9477_tc_cbs_set_cinc,
>  	.enable_stp_addr =3D ksz9477_enable_stp_addr,
>  	.reset =3D ksz9477_reset_switch,
>  	.init =3D ksz9477_switch_init,
> @@ -286,6 +292,7 @@ static const struct ksz_dev_ops lan937x_dev_ops =3D {
>  	.change_mtu =3D lan937x_change_mtu,
>  	.phylink_mac_link_up =3D ksz9477_phylink_mac_link_up,
>  	.config_cpu_port =3D lan937x_config_cpu_port,
> +	.tc_cbs_set_cinc =3D lan937x_tc_cbs_set_cinc,
>  	.enable_stp_addr =3D ksz9477_enable_stp_addr,
>  	.reset =3D lan937x_reset_switch,
>  	.init =3D lan937x_switch_init,
> @@ -1081,6 +1088,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.port_cnt =3D 3,		/* total port count */
>  		.port_nirqs =3D 3,
>  		.num_tx_queues =3D 4,
> +		.tc_cbs_supported =3D true,
>  		.ops =3D &ksz9477_dev_ops,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
> @@ -1219,6 +1227,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.port_cnt =3D 7,		/* total physical port count */
>  		.port_nirqs =3D 4,
>  		.num_tx_queues =3D 4,
> +		.tc_cbs_supported =3D true,
>  		.ops =3D &ksz9477_dev_ops,
>  		.phy_errata_9477 =3D true,
>  		.mib_names =3D ksz9477_mib_names,
> @@ -1342,6 +1351,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.port_cnt =3D 3,		/* total port count */
>  		.port_nirqs =3D 3,
>  		.num_tx_queues =3D 4,
> +		.tc_cbs_supported =3D true,
>  		.ops =3D &ksz9477_dev_ops,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
> @@ -1368,6 +1378,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.port_cnt =3D 7,		/* total physical port count */
>  		.port_nirqs =3D 3,
>  		.num_tx_queues =3D 4,
> +		.tc_cbs_supported =3D true,
>  		.ops =3D &ksz9477_dev_ops,
>  		.phy_errata_9477 =3D true,
>  		.mib_names =3D ksz9477_mib_names,
> @@ -1399,6 +1410,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.port_cnt =3D 5,		/* total physical port count */
>  		.port_nirqs =3D 6,
>  		.num_tx_queues =3D 8,
> +		.tc_cbs_supported =3D true,
>  		.ops =3D &lan937x_dev_ops,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
> @@ -1424,6 +1436,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.port_cnt =3D 6,		/* total physical port count */
>  		.port_nirqs =3D 6,
>  		.num_tx_queues =3D 8,
> +		.tc_cbs_supported =3D true,
>  		.ops =3D &lan937x_dev_ops,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
> @@ -1449,6 +1462,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.port_cnt =3D 8,		/* total physical port count */
>  		.port_nirqs =3D 6,
>  		.num_tx_queues =3D 8,
> +		.tc_cbs_supported =3D true,
>  		.ops =3D &lan937x_dev_ops,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
> @@ -1478,6 +1492,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.port_cnt =3D 5,		/* total physical port count */
>  		.port_nirqs =3D 6,
>  		.num_tx_queues =3D 8,
> +		.tc_cbs_supported =3D true,
>  		.ops =3D &lan937x_dev_ops,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
> @@ -1507,6 +1522,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.port_cnt =3D 8,		/* total physical port count */
>  		.port_nirqs =3D 6,
>  		.num_tx_queues =3D 8,
> +		.tc_cbs_supported =3D true,
>  		.ops =3D &lan937x_dev_ops,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
> @@ -2982,6 +2998,94 @@ static int ksz_switch_detect(struct ksz_device *de=
v)
>  	return 0;
>  }
> =20
> +/* Bandwidth is calculated by idle slope/transmission speed. Then the Ba=
ndwidth
> + * is converted to Hex-decimal using the successive multiplication metho=
d. On
> + * every step, integer part is taken and decimal part is carry forwarded=
.
> + */
> +static int cinc_cal(s32 idle_slope, s32 send_slope)
> +{
> +	int cinc =3D 0;
> +	u32 txrate;
> +	u32 rate;
> +	u8 temp;
> +	u8 i;
> +
> +	txrate =3D idle_slope - send_slope;
> +
> +	rate =3D idle_slope;
> +
> +	/* 24 bit register */
> +	for (i =3D 0; i < 6; i++) {
> +		rate =3D rate * 16;
> +
> +		temp =3D rate / txrate;

idle_slope and  send_slope come directly from user-space. You must
explicitly check the values are reasonable (do not lead to divide by
0).


Cheers,

Paolo

