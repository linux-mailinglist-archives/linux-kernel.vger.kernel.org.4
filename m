Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB56FEF9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbjEKKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjEKKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:04:34 -0400
X-Greylist: delayed 985 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 03:04:28 PDT
Received: from pop31.abv.bg (pop31.abv.bg [194.153.145.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9367EF6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:04:28 -0700 (PDT)
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop31.abv.bg (Postfix) with ESMTP id 107DD1805D3E;
        Thu, 11 May 2023 12:48:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1683798481; bh=LZ4Y9nJPMiQS3y3P4lBVVcTQ6iCin38FwuoDsVu7+/o=;
        h=From:Subject:Date:Cc:To:From;
        b=OI2CZ1VgVrDQtbRrhNicTZ6MNVaZ041m26w+MzmOJt1Lfg0qad9n0GY3MWC2/Z4e/
         CLgkSAoAqo+Tp+nhsfP7UBR1D46xK0D16FCzOo13b6jf66k3JsCUZHFERaoxhyk6tv
         MFlLxMvsxdqKJbzAcMxUP7+raNnp8DWi9GDoQK/0=
X-HELO: smtpclient.apple
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=gvalkov@abv.bg
Received: from 212-39-89-168.ip.btc-net.bg (HELO smtpclient.apple) (212.39.89.168)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Thu, 11 May 2023 12:48:01 +0300
From:   Georgi Valkov <gvalkov@abv.bg>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_E1CEB9A7-9EC3-493B-A739-1B859D0B4C9F"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: net: usb: ipheth: add CDC NCM support
Message-Id: <0A1C2108-75F2-46B7-8712-616FE6464294@abv.bg>
Date:   Thu, 11 May 2023 12:47:56 +0300
Cc:     =?utf-8?B?0JPQtdC+0YDQs9C4INCT0LXQvtGA0LPQuNC10LIg0JLRitC70LrQvtCy?= 
        <gvalkov@abv.bg>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Foster Snowhill <forst@pen.gy>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_E1CEB9A7-9EC3-493B-A739-1B859D0B4C9F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Can you please review, and accept the following patch. I=E2=80=99ve been =
using it for one year.
I added the author Foster Snowhill to this mail, as well as a link to =
his Github [1].
If needed, we can ask him to add the tag Signed-off-by:


=46rom 257d843a7f90e4e519635f82fe5b73fba918ec33 Mon Sep 17 00:00:00 2001
From: Foster Snowhill <Forst@users.noreply.github.com>
Date: Fri, 22 Apr 2022 23:50:09 +0200
Subject: [PATCH] net: usb: ipheth: add CDC NCM support (PoC)

Recent iOS releases support CDC NCM encapsulation on RX. This mode is
the default on macOS and Windows.

When reconnecting a device from a macOS/Windows machine to a Linux
machine, the device stays in NCM mode. Therefore to correctly support
such a device, the driver has to either support the NCM mode too, or
somehow put the device back into legacy mode.

To match the behaviour of the macOS/Windows driver, and since there
are no documented control commands to revert to legacy mode, I chose
to implement basic NCM support.

With this change, the device is attempted to be put into NCM mode by
default, and falls back to legacy mode if said attempt failed.

Tested-by: Georgi Valkov <gvalkov@abv.bg>



[1] =
https://github.com/Forst/linux-stable/commit/257d843a7f90e4e519635f82fe5b7=
3fba918ec33#diff-d13f85b8acc1204f31e7abc538e9fdb1faa07b94cd928800b6b976561=
d32f6e3

This can be applied directly to Linux master, as well as 5.10 and 5.15 =
stable.

--Apple-Mail=_E1CEB9A7-9EC3-493B-A739-1B859D0B4C9F
Content-Disposition: attachment;
	filename=0001-net-usb-ipheth-add-CDC-NCM-support-PoC.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-net-usb-ipheth-add-CDC-NCM-support-PoC.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=207d530b3969fb1a3eb34bcf83cbf1da86e9224a85=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Foster=20Snowhill=20=
<Forst@users.noreply.github.com>=0ADate:=20Fri,=2022=20Apr=202022=20=
23:50:09=20+0200=0ASubject:=20[PATCH]=20net:=20usb:=20ipheth:=20add=20=
CDC=20NCM=20support=20(PoC)=0A=0ARecent=20iOS=20releases=20support=20CDC=20=
NCM=20encapsulation=20on=20RX.=20This=20mode=20is=0Athe=20default=20on=20=
macOS=20and=20Windows.=0A=0AWhen=20reconnecting=20a=20device=20from=20a=20=
macOS/Windows=20machine=20to=20a=20Linux=0Amachine,=20the=20device=20=
stays=20in=20NCM=20mode.=20Therefore=20to=20correctly=20support=0Asuch=20=
a=20device,=20the=20driver=20has=20to=20either=20support=20the=20NCM=20=
mode=20too,=20or=0Asomehow=20put=20the=20device=20back=20into=20legacy=20=
mode.=0A=0ATo=20match=20the=20behaviour=20of=20the=20macOS/Windows=20=
driver,=20and=20since=20there=0Aare=20no=20documented=20control=20=
commands=20to=20revert=20to=20legacy=20mode,=20I=20chose=0Ato=20=
implement=20basic=20NCM=20support.=0A=0AWith=20this=20change,=20the=20=
device=20is=20attempted=20to=20be=20put=20into=20NCM=20mode=20by=0A=
default,=20and=20falls=20back=20to=20legacy=20mode=20if=20said=20attempt=20=
failed.=0A=0ATested-by:=20Georgi=20Valkov=20<gvalkov@abv.bg>=0A---=0A=20=
drivers/net/usb/ipheth.c=20|=20175=20=
+++++++++++++++++++++++++++++++--------=0A=201=20file=20changed,=20142=20=
insertions(+),=2033=20deletions(-)=0A=0Adiff=20--git=20=
a/drivers/net/usb/ipheth.c=20b/drivers/net/usb/ipheth.c=0Aindex=20=
6a769df0b421..4d05d8d6b5bc=20100644=0A---=20a/drivers/net/usb/ipheth.c=0A=
+++=20b/drivers/net/usb/ipheth.c=0A@@=20-52,6=20+52,7=20@@=0A=20#include=20=
<linux/ethtool.h>=0A=20#include=20<linux/usb.h>=0A=20#include=20=
<linux/workqueue.h>=0A+#include=20<linux/usb/cdc.h>=0A=20=0A=20#define=20=
USB_VENDOR_APPLE=20=20=20=20=20=20=20=200x05ac=0A=20=0A@@=20-59,8=20=
+60,11=20@@=0A=20#define=20IPHETH_USBINTF_SUBCLASS=20253=0A=20#define=20=
IPHETH_USBINTF_PROTO=20=20=20=201=0A=20=0A-#define=20IPHETH_BUF_SIZE=20=20=
=20=20=20=20=20=20=201514=0A=20#define=20IPHETH_IP_ALIGN=09=092=09/*=20=
padding=20at=20front=20of=20URB=20*/=0A+#define=20IPHETH_NCM_HEADER_SIZE=20=
=20(12=20+=2096)=20/*=20NCMH=20+=20NCM0=20*/=0A+#define=20=
IPHETH_TX_BUF_SIZE=20=20=20=20=20=20ETH_FRAME_LEN=0A+#define=20=
IPHETH_RX_BUF_SIZE=20=20=20=20=20=2065536=0A+=0A=20#define=20=
IPHETH_TX_TIMEOUT=20=20=20=20=20=20=20(5=20*=20HZ)=0A=20=0A=20#define=20=
IPHETH_INTFNUM=20=20=20=20=20=20=20=20=20=202=0A@@=20-71,6=20+75,7=20@@=0A=
=20#define=20IPHETH_CTRL_TIMEOUT=20=20=20=20=20(5=20*=20HZ)=0A=20=0A=20=
#define=20IPHETH_CMD_GET_MACADDR=20=20=200x00=0A+#define=20=
IPHETH_CMD_ENABLE_NCM=20=20=20=200x04=0A=20#define=20=
IPHETH_CMD_CARRIER_CHECK=200x45=0A=20=0A=20#define=20=
IPHETH_CARRIER_CHECK_TIMEOUT=20round_jiffies_relative(1=20*=20HZ)=0A@@=20=
-84,6=20+89,8=20@@=20static=20const=20struct=20usb_device_id=20=
ipheth_table[]=20=3D=20{=0A=20};=0A=20MODULE_DEVICE_TABLE(usb,=20=
ipheth_table);=0A=20=0A+static=20const=20char=20ipheth_start_packet[]=20=
=3D=20{=200x00,=200x01,=200x01,=200x00=20};=0A+=0A=20struct=20=
ipheth_device=20{=0A=20=09struct=20usb_device=20*udev;=0A=20=09struct=20=
usb_interface=20*intf;=0A@@=20-97,6=20+104,7=20@@=20struct=20=
ipheth_device=20{=0A=20=09u8=20bulk_out;=0A=20=09struct=20delayed_work=20=
carrier_work;=0A=20=09bool=20confirmed_pairing;=0A+=09int=20=
(*rcvbulk_callback)(struct=20urb=20*urb);=0A=20};=0A=20=0A=20static=20=
int=20ipheth_rx_submit(struct=20ipheth_device=20*dev,=20gfp_t=20=
mem_flags);=0A@@=20-116,12=20+124,12=20@@=20static=20int=20=
ipheth_alloc_urbs(struct=20ipheth_device=20*iphone)=0A=20=09if=20(rx_urb=20=
=3D=3D=20NULL)=0A=20=09=09goto=20free_tx_urb;=0A=20=0A-=09tx_buf=20=3D=20=
usb_alloc_coherent(iphone->udev,=20IPHETH_BUF_SIZE,=0A+=09tx_buf=20=3D=20=
usb_alloc_coherent(iphone->udev,=20IPHETH_TX_BUF_SIZE,=0A=20=09=09=09=09=20=
=20=20=20GFP_KERNEL,=20&tx_urb->transfer_dma);=0A=20=09if=20(tx_buf=20=3D=3D=
=20NULL)=0A=20=09=09goto=20free_rx_urb;=0A=20=0A-=09rx_buf=20=3D=20=
usb_alloc_coherent(iphone->udev,=20IPHETH_BUF_SIZE=20+=20=
IPHETH_IP_ALIGN,=0A+=09rx_buf=20=3D=20usb_alloc_coherent(iphone->udev,=20=
IPHETH_RX_BUF_SIZE,=0A=20=09=09=09=09=20=20=20=20GFP_KERNEL,=20=
&rx_urb->transfer_dma);=0A=20=09if=20(rx_buf=20=3D=3D=20NULL)=0A=20=09=09=
goto=20free_tx_buf;=0A@@=20-134,7=20+142,7=20@@=20static=20int=20=
ipheth_alloc_urbs(struct=20ipheth_device=20*iphone)=0A=20=09return=200;=0A=
=20=0A=20free_tx_buf:=0A-=09usb_free_coherent(iphone->udev,=20=
IPHETH_BUF_SIZE,=20tx_buf,=0A+=09usb_free_coherent(iphone->udev,=20=
IPHETH_TX_BUF_SIZE,=20tx_buf,=0A=20=09=09=09=20=20tx_urb->transfer_dma);=0A=
=20free_rx_urb:=0A=20=09usb_free_urb(rx_urb);=0A@@=20-146,9=20+154,9=20=
@@=20static=20int=20ipheth_alloc_urbs(struct=20ipheth_device=20*iphone)=0A=
=20=0A=20static=20void=20ipheth_free_urbs(struct=20ipheth_device=20=
*iphone)=0A=20{=0A-=09usb_free_coherent(iphone->udev,=20IPHETH_BUF_SIZE=20=
+=20IPHETH_IP_ALIGN,=20iphone->rx_buf,=0A+=09=
usb_free_coherent(iphone->udev,=20IPHETH_RX_BUF_SIZE,=20iphone->rx_buf,=0A=
=20=09=09=09=20=20iphone->rx_urb->transfer_dma);=0A-=09=
usb_free_coherent(iphone->udev,=20IPHETH_BUF_SIZE,=20iphone->tx_buf,=0A+=09=
usb_free_coherent(iphone->udev,=20IPHETH_TX_BUF_SIZE,=20iphone->tx_buf,=0A=
=20=09=09=09=20=20iphone->tx_urb->transfer_dma);=0A=20=09=
usb_free_urb(iphone->rx_urb);=0A=20=09usb_free_urb(iphone->tx_urb);=0A@@=20=
-160,14=20+168,96=20@@=20static=20void=20ipheth_kill_urbs(struct=20=
ipheth_device=20*dev)=0A=20=09usb_kill_urb(dev->rx_urb);=0A=20}=0A=20=0A=
-static=20void=20ipheth_rcvbulk_callback(struct=20urb=20*urb)=0A+static=20=
int=20ipheth_consume_skb(char*=20buf,=20int=20len,=20struct=20=
ipheth_device=20*dev)=0A=20{=0A-=09struct=20ipheth_device=20*dev;=0A=20=09=
struct=20sk_buff=20*skb;=0A-=09int=20status;=0A+=0A+=09skb=20=3D=20=
dev_alloc_skb(len);=0A+=09if=20(!skb)=20{=0A+=09=09=
dev->net->stats.rx_dropped++;=0A+=09=09return=20-ENOMEM;=0A+=09}=0A+=0A+=09=
skb_put_data(skb,=20buf,=20len);=0A+=09skb->dev=20=3D=20dev->net;=0A+=09=
skb->protocol=20=3D=20eth_type_trans(skb,=20dev->net);=0A+=0A+=09=
dev->net->stats.rx_packets++;=0A+=09dev->net->stats.rx_bytes=20+=3D=20=
len;=0A+=09netif_rx(skb);=0A+=0A+=09return=200;=0A+}=0A+=0A+static=20int=20=
ipheth_rcvbulk_callback_legacy(struct=20urb=20*urb)=0A+{=0A+=09struct=20=
ipheth_device=20*dev;=0A=20=09char=20*buf;=0A=20=09int=20len;=0A=20=0A+=09=
dev=20=3D=20urb->context;=0A+=0A+=09if=20(urb->actual_length=20<=3D=20=
IPHETH_IP_ALIGN)=20{=0A+=09=09dev->net->stats.rx_length_errors++;=0A+=09=09=
return=20-EINVAL;=0A+=09}=0A+=09len=20=3D=20urb->actual_length=20-=20=
IPHETH_IP_ALIGN;=0A+=09buf=20=3D=20urb->transfer_buffer=20+=20=
IPHETH_IP_ALIGN;=0A+=0A+=09return=20ipheth_consume_skb(buf,=20len,=20=
dev);=0A+}=0A+=0A+static=20int=20ipheth_rcvbulk_callback_ncm(struct=20=
urb=20*urb)=0A+{=0A+=09struct=20ipheth_device=20*dev;=0A+=09struct=20=
usb_cdc_ncm_nth16=20*ncmh;=0A+=09struct=20usb_cdc_ncm_ndp16=20*ncm0;=0A+=09=
struct=20usb_cdc_ncm_dpe16=20*dpe;=0A+=09char=20*buf;=0A+=09int=20len;=0A=
+=09int=20retval=20=3D=20-EINVAL;=0A+=0A+=09dev=20=3D=20urb->context;=0A=
+=0A+=09if=20(urb->actual_length=20<=20IPHETH_NCM_HEADER_SIZE)=20{=0A+=09=
=09dev->net->stats.rx_length_errors++;=0A+=09=09return=20retval;=0A+=09}=0A=
+=0A+=09ncmh=20=3D=20(struct=20usb_cdc_ncm_nth16=20=
*)(urb->transfer_buffer);=0A+=09if=20(ncmh->dwSignature=20!=3D=20=
cpu_to_le32(USB_CDC_NCM_NTH16_SIGN)=20||=0A+=09=20=20=20=20=
le16_to_cpu(ncmh->wNdpIndex)=20>=3D=20urb->actual_length)=20{=0A+=09=09=
dev->net->stats.rx_errors++;=0A+=09=09return=20retval;=0A+=09}=0A+=0A+=09=
ncm0=20=3D=20(struct=20usb_cdc_ncm_ndp16=20*)(urb->transfer_buffer=20+=20=
le16_to_cpu(ncmh->wNdpIndex));=0A+=09if=20(ncm0->dwSignature=20!=3D=20=
cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN)=20||=0A+=09=20=20=20=20=
le16_to_cpu(ncmh->wHeaderLength)=20+=20le16_to_cpu(ncm0->wLength)=20>=3D=20=
urb->actual_length)=20{=0A+=09=09dev->net->stats.rx_errors++;=0A+=09=09=
return=20retval;=0A+=09}=0A+=0A+=09dpe=20=3D=20ncm0->dpe16;=0A+=09while=20=
(le16_to_cpu(dpe->wDatagramIndex)=20!=3D=200=20&&=20=
le16_to_cpu(dpe->wDatagramLength)=20!=3D=200)=20{=0A+=09=09buf=20=3D=20=
urb->transfer_buffer=20+=20le16_to_cpu(dpe->wDatagramIndex);=0A+=09=09=
len=20=3D=20le16_to_cpu(dpe->wDatagramLength);=0A+=0A+=09=09retval=20=3D=20=
ipheth_consume_skb(buf,=20len,=20dev);=0A+=09=09if=20(retval=20!=3D=200)=0A=
+=09=09=09return=20retval;=0A+=0A+=09=09dpe++;=0A+=09}=0A+=0A+=09return=20=
0;=0A+}=0A+=0A+static=20void=20ipheth_rcvbulk_callback(struct=20urb=20=
*urb)=0A+{=0A+=09struct=20ipheth_device=20*dev;=0A+=09int=20retval,=20=
status;=0A+=0A=20=09dev=20=3D=20urb->context;=0A=20=09if=20(dev=20=3D=3D=20=
NULL)=0A=20=09=09return;=0A@@=20-187,29=20+277,24=20@@=20static=20void=20=
ipheth_rcvbulk_callback(struct=20urb=20*urb)=0A=20=09=09return;=0A=20=09=
}=0A=20=0A-=09if=20(urb->actual_length=20<=3D=20IPHETH_IP_ALIGN)=20{=0A-=09=
=09dev->net->stats.rx_length_errors++;=0A-=09=09return;=0A-=09}=0A-=09=
len=20=3D=20urb->actual_length=20-=20IPHETH_IP_ALIGN;=0A-=09buf=20=3D=20=
urb->transfer_buffer=20+=20IPHETH_IP_ALIGN;=0A-=0A-=09skb=20=3D=20=
dev_alloc_skb(len);=0A-=09if=20(!skb)=20{=0A-=09=09=
dev_err(&dev->intf->dev,=20"%s:=20dev_alloc_skb:=20-ENOMEM\n",=0A-=09=09=09=
__func__);=0A-=09=09dev->net->stats.rx_dropped++;=0A+=09/*=20The=20very=20=
first=20frame=20we=20receive=20from=20device=20has=20a=20fixed=204-byte=20=
value=0A+=09=20*=20We=20can=20safely=20skip=20it=0A+=09=20*/=0A+=09if=20=
(unlikely(=0A+=09=09urb->actual_length=20=3D=3D=20=
sizeof(ipheth_start_packet)=20&&=0A+=09=09memcmp(urb->transfer_buffer,=20=
ipheth_start_packet,=20sizeof(ipheth_start_packet))=20=3D=3D=200=0A+=09=
))=0A+=09=09goto=20rx_submit;=0A+=0A+=09retval=20=3D=20=
dev->rcvbulk_callback(urb);=0A+=09if=20(retval=20!=3D=200)=20{=0A+=09=09=
dev_err(&dev->intf->dev,=20"%s:=20callback=20retval:=20%d\n",=0A+=09=09=09=
__func__,=20retval);=0A=20=09=09return;=0A=20=09}=0A=20=0A-=09=
skb_put_data(skb,=20buf,=20len);=0A-=09skb->dev=20=3D=20dev->net;=0A-=09=
skb->protocol=20=3D=20eth_type_trans(skb,=20dev->net);=0A-=0A-=09=
dev->net->stats.rx_packets++;=0A-=09dev->net->stats.rx_bytes=20+=3D=20=
len;=0A+rx_submit:=0A=20=09dev->confirmed_pairing=20=3D=20true;=0A-=09=
netif_rx(skb);=0A=20=09ipheth_rx_submit(dev,=20GFP_ATOMIC);=0A=20}=0A=20=0A=
@@=20-310,6=20+395,27=20@@=20static=20int=20ipheth_get_macaddr(struct=20=
ipheth_device=20*dev)=0A=20=09return=20retval;=0A=20}=0A=20=0A+static=20=
int=20ipheth_enable_ncm(struct=20ipheth_device=20*dev)=0A+{=0A+=09struct=20=
usb_device=20*udev=20=3D=20dev->udev;=0A+=09int=20retval;=0A+=0A+=09=
retval=20=3D=20usb_control_msg(udev,=0A+=09=09=09=09=20=
usb_sndctrlpipe(udev,=20IPHETH_CTRL_ENDP),=0A+=09=09=09=09=20=
IPHETH_CMD_ENABLE_NCM,=20/*=20request=20*/=0A+=09=09=09=09=200x40,=20/*=20=
request=20type=20*/=0A+=09=09=09=09=200x00,=20/*=20value=20*/=0A+=09=09=09=
=09=200x02,=20/*=20index=20*/=0A+=09=09=09=09=20NULL,=0A+=09=09=09=09=20=
0,=0A+=09=09=09=09=20IPHETH_CTRL_TIMEOUT);=0A+=0A+=09=
dev_info(&dev->intf->dev,=20"%s:=20usb_control_msg:=20%d\n",=0A+=09=09=
__func__,=20retval);=0A+=0A+=09return=20retval;=0A+}=0A+=0A=20static=20=
int=20ipheth_rx_submit(struct=20ipheth_device=20*dev,=20gfp_t=20=
mem_flags)=0A=20{=0A=20=09struct=20usb_device=20*udev=20=3D=20dev->udev;=0A=
@@=20-317,7=20+423,7=20@@=20static=20int=20ipheth_rx_submit(struct=20=
ipheth_device=20*dev,=20gfp_t=20mem_flags)=0A=20=0A=20=09=
usb_fill_bulk_urb(dev->rx_urb,=20udev,=0A=20=09=09=09=20=20=
usb_rcvbulkpipe(udev,=20dev->bulk_in),=0A-=09=09=09=20=20dev->rx_buf,=20=
IPHETH_BUF_SIZE=20+=20IPHETH_IP_ALIGN,=0A+=09=09=09=20=20dev->rx_buf,=20=
IPHETH_RX_BUF_SIZE,=0A=20=09=09=09=20=20ipheth_rcvbulk_callback,=0A=20=09=
=09=09=20=20dev);=0A=20=09dev->rx_urb->transfer_flags=20|=3D=20=
URB_NO_TRANSFER_DMA_MAP;=0A@@=20-365,7=20+471,7=20@@=20static=20=
netdev_tx_t=20ipheth_tx(struct=20sk_buff=20*skb,=20struct=20net_device=20=
*net)=0A=20=09int=20retval;=0A=20=0A=20=09/*=20Paranoid=20*/=0A-=09if=20=
(skb->len=20>=20IPHETH_BUF_SIZE)=20{=0A+=09if=20(skb->len=20>=20=
IPHETH_TX_BUF_SIZE)=20{=0A=20=09=09WARN(1,=20"%s:=20skb=20too=20large:=20=
%d=20bytes\n",=20__func__,=20skb->len);=0A=20=09=09=
dev->net->stats.tx_dropped++;=0A=20=09=09dev_kfree_skb_any(skb);=0A@@=20=
-373,12=20+479,10=20@@=20static=20netdev_tx_t=20ipheth_tx(struct=20=
sk_buff=20*skb,=20struct=20net_device=20*net)=0A=20=09}=0A=20=0A=20=09=
memcpy(dev->tx_buf,=20skb->data,=20skb->len);=0A-=09if=20(skb->len=20<=20=
IPHETH_BUF_SIZE)=0A-=09=09memset(dev->tx_buf=20+=20skb->len,=200,=20=
IPHETH_BUF_SIZE=20-=20skb->len);=0A=20=0A=20=09=
usb_fill_bulk_urb(dev->tx_urb,=20udev,=0A=20=09=09=09=20=20=
usb_sndbulkpipe(udev,=20dev->bulk_out),=0A-=09=09=09=20=20dev->tx_buf,=20=
IPHETH_BUF_SIZE,=0A+=09=09=09=20=20dev->tx_buf,=20skb->len,=0A=20=09=09=09=
=20=20ipheth_sndbulk_callback,=0A=20=09=09=09=20=20dev);=0A=20=09=
dev->tx_urb->transfer_flags=20|=3D=20URB_NO_TRANSFER_DMA_MAP;=0A@@=20=
-450,6=20+554,7=20@@=20static=20int=20ipheth_probe(struct=20=
usb_interface=20*intf,=0A=20=09dev->net=20=3D=20netdev;=0A=20=09=
dev->intf=20=3D=20intf;=0A=20=09dev->confirmed_pairing=20=3D=20false;=0A=
+=09dev->rcvbulk_callback=20=3D=20ipheth_rcvbulk_callback_legacy;=0A=20=09=
/*=20Set=20up=20endpoints=20*/=0A=20=09hintf=20=3D=20=
usb_altnum_to_altsetting(intf,=20IPHETH_ALT_INTFNUM);=0A=20=09if=20=
(hintf=20=3D=3D=20NULL)=20{=0A@@=20-481,6=20+586,10=20@@=20static=20int=20=
ipheth_probe(struct=20usb_interface=20*intf,=0A=20=09if=20(retval)=0A=20=09=
=09goto=20err_get_macaddr;=0A=20=0A+=09retval=20=3D=20=
ipheth_enable_ncm(dev);=0A+=09if=20(retval=20=3D=3D=200)=0A+=09=09=
dev->rcvbulk_callback=20=3D=20ipheth_rcvbulk_callback_ncm;=0A+=0A=20=09=
INIT_DELAYED_WORK(&dev->carrier_work,=20ipheth_carrier_check_work);=0A=20=
=0A=20=09retval=20=3D=20ipheth_alloc_urbs(dev);=0A--=20=0A2.40.1=0A=0A=

--Apple-Mail=_E1CEB9A7-9EC3-493B-A739-1B859D0B4C9F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii






--Apple-Mail=_E1CEB9A7-9EC3-493B-A739-1B859D0B4C9F--
