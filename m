Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26AC624120
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKJLOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiKJLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:14:03 -0500
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A3A51145B;
        Thu, 10 Nov 2022 03:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cGk22
        Zp1+F+f6aDzuUCxsSzPaEXA+AcZCWLYNZlBsKk=; b=ajQo8pjHbcUWdj+8eQFq3
        W7sNSZNu2oS7IJD5RcUsOnyM5PBeeIL64FqQSOCsahs/2uJiYW2/WG1rAO4seg9/
        jPjO873cflSo3yFcilAxRHfy7l1ZPgtE+U8zrQLxVqKN5exeRdTsFZ/fmoTaZx0X
        TuKd5lNMH0Ugrv3mZpGNnk=
Received: from duke.localdomain (unknown [220.180.239.56])
        by smtp9 (Coremail) with SMTP id DcCowADnY8q33GxjBd8OKA--.24564S2;
        Thu, 10 Nov 2022 19:13:05 +0800 (CST)
From:   =?UTF-8?q?Duke=20Xin=28=E8=BE=9B=E5=AE=89=E6=96=87=29?= 
        <duke_xinanwen@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dukexinaw <602659072@qq.com>
Subject: [PATCH] =?UTF-8?q?=20=20=20=20Author:=20Duke=20Xin(=E8=BE=9B?= =?UTF-8?q?=E5=AE=89=E6=96=87)<duke=5Fxinanwen@163.com>=20=20=20=20=20Date?= =?UTF-8?q?:=20=20=20Thu,=20Nov=2010=2015:25:01=202022=20+0800?=
Date:   Thu, 10 Nov 2022 19:12:50 +0800
Message-Id: <20221110111250.3360-1-duke_xinanwen@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: DcCowADnY8q33GxjBd8OKA--.24564S2
X-Coremail-Antispam: 1Uf129KBjv_XoW8JF47KF15uF4fXFW8uFWUZry7p5X_Ww47Zr
        1rpF4xC34F9r18GFy7X34fA3W09Fy3J3WfXFy3K3sIy3s5XF98ZFy5Jr1Y9FyrXFZrXrWx
        WF42vFn7WrWjgF98AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nx
        nvy29KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jieOJUUUUU=
X-Originating-IP: [220.180.239.56]
X-CM-SenderInfo: 5gxnvsp0lqt0xzhqqiywtou0bp/1tbiyAK1e1p7IWBL+QAAsW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dukexinaw <602659072@qq.com>

    USB: serial: option: add Quectel EM05-G modem

    The EM05-G modem has 2 USB configurations that are configurable via the=
 AT
    command AT+QCFG=3D"usbnet",[ 0 | 2 ] which make the modem enumerate with
    the following interfaces, respectively:

    "RMNET" : AT + DIAG + NMEA + Modem + QMI
    "MBIM"  : MBIM + AT + DIAG + NMEA + Modem

    The detailed description of the USB configuration for each mode as foll=
ows:

    RMNET Mode
    --------------
    T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D 21 Spd=3D480=
  MxCh=3D 0
    D:  Ver=3D 2.00 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
    P:  Vendor=3D2c7c ProdID=3D0311 Rev=3D 3.18
    S:  Manufacturer=3DQuectel
    S:  Product=3DQuectel EM05-G
    C:* #Ifs=3D 5 Cfg#=3D 1 Atr=3Da0 MxPwr=3D500mA
    I:* If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driv=
er=3Doption
    E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    I:* If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
    E:  Ad=3D83(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
    E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    I:* If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
    E:  Ad=3D85(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
    E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    I:* If#=3D 5 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
    E:  Ad=3D87(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
    E:  Ad=3D86(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    I:* If#=3D 6 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driv=
er=3D(none)
    E:  Ad=3D89(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D32ms
    E:  Ad=3D88(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms

   MBIM Mode
    --------------
    T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D 16 Spd=3D480=
  MxCh=3D 0
    D:  Ver=3D 2.00 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
    P:  Vendor=3D2c7c ProdID=3D0311 Rev=3D 3.18
    S:  Manufacturer=3DQuectel
    S:  Product=3DQuectel EM05-G
    C:* #Ifs=3D 6 Cfg#=3D 1 Atr=3Da0 MxPwr=3D500mA
    A:  FirstIf#=3D 0 IfCount=3D 2 Cls=3D02(comm.) Sub=3D0e Prot=3D00
    I:* If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driv=
er=3Doption
    E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    I:* If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
    E:  Ad=3D83(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
    E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    I:* If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
    E:  Ad=3D85(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
    E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    I:* If#=3D 5 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driv=
er=3Doption
    E:  Ad=3D87(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
    E:  Ad=3D86(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D02(comm.) Sub=3D0e Prot=3D00 Driv=
er=3Dcdc_mbim
    E:  Ad=3D89(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D32ms
    I:  If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3D0a(data ) Sub=3D00 Prot=3D02 Driv=
er=3Dcdc_mbim
    I:* If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3D0a(data ) Sub=3D00 Prot=3D02 Driv=
er=3Dcdc_mbim
    E:  Ad=3D88(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
    E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms

    Signed-off-by: Duke Xin<duke_xinanwen@163.com>
    Cc: stable@vger.kernel.org
    Signed-off-by: Johan Hovold <johan@kernel.org>

Signed-off-by: dukexinaw <602659072@qq.com>
---
 Next/SHA1s                  |  368 ++
 Next/Trees                  |  370 ++
 Next/merge.log              | 8938 +++++++++++++++++++++++++++++++++++
 drivers/usb/serial/option.c |    3 +
 localversion-next           |    1 +
 5 files changed, 9680 insertions(+)
 create mode 100644 Next/SHA1s
 create mode 100644 Next/Trees
 create mode 100644 Next/merge.log
 create mode 100644 localversion-next

diff --git a/Next/SHA1s b/Next/SHA1s
new file mode 100644
index 000000000000..719b1b8e8b74
--- /dev/null
+++ b/Next/SHA1s
@@ -0,0 +1,368 @@
+Name		SHA1
+----		----
+origin		f141df371335645ce29a87d9683a3f79fba7fd67
+fixes		9c9155a3509a2ebdb06d77c7a621e9685c802eac
+mm-hotfixes	5e4e46814fed3965123598e667dcbb002ccd8930
+kbuild-current	f0c4d9fc9cc9462659728d168387191387e903cc
+arc-current	30a0b95b1335e12efef89dd78518ed3e4a71a763
+arm-current	340a982825f76f1cff0daa605970fe47321b5ee7
+arm64-fixes	2081b3bd0c11757725dcab9ba5d38e1bddb03459
+arm-soc-fixes	5449cabd95bbf141e2b7471e8d3cedb6f3b92492
+davinci-current	9abf2313adc1ca1b6180c508c25f22f9395cc780
+drivers-memory-fixes	9abf2313adc1ca1b6180c508c25f22f9395cc780
+tee-fixes	98268f2a2a9f1dddf20984f79fdc7b655d0e35fe
+m68k-current	dc63a086daee92c63e392e4e7cd7ed61f3693026
+powerpc-fixes	02a771c9a68a9f08cce4ec5e324fb1bc4dce7202
+s390-fixes	80ddf5ce1c9291cb175d52ed1227134ad48c47ee
+sparc		2d2b17d08bfc3d98cf93622e8c6543eaaf02dabe
+fscrypt-current	ccd30a476f8e864732de220bd50e6f372f5ebcab
+net		ce9e57feeed81d17d5e80ed86f516ff0d39c3867
+bpf		eb86559a691cea5fa63e57a03ec3dc9c31e97955
+ipsec		7f57f8165cb6d2c206e2b9ada53b9e2d6d8af42f
+netfilter	7fb0269720d7d5359bc8349eef908a1c96866b65
+ipvs		7fb0269720d7d5359bc8349eef908a1c96866b65
+wireless	91018bbcc664b6c9410ddccacd2239a4acadcfc9
+rdma-fixes	f0c4d9fc9cc9462659728d168387191387e903cc
+sound-current	2f01a612d4758b45f775dbb88a49cf534ba47275
+sound-asoc-fixes	89cdb224f2abe37ec4ac21ba0d9ddeb5a6a9cf68
+regmap-fixes	157209ecce2bb83230222f7ce857406beadcb96c
+regulator-fixes	6555bf0ad52409fa06b13d429f229671312837d8
+spi-fixes	d1a0c45245aa7b0aa2360d29d99644294af06244
+pci-current	39a654f39efb035b961359db91f15a347e8d7fd8
+driver-core.current	54de93cd8740d52a83728802b4270f953d1a636f
+tty.current	7b7dfe4833c70a11cdfa51b38705103bd31eddaa
+usb.current	d68cc25b7c7fb3034c5a5b5f350a0b858c6d5a45
+usb-gadget-fixes	e49d033bddf5b565044e2abe4241353959bc9120
+usb-serial-fixes	df3414b0a245f43476061fddd78cee7d6cff797f
+phy		819b885cd886c193782891c4f51bbcab3de119a4
+staging.current	937ec9f7d5f2625d60077bb7824fee35dc447c6e
+iio-fixes	0aa60ff5d996d4ecdd4a62699c01f6d00f798d59
+counter-current	30a0b95b1335e12efef89dd78518ed3e4a71a763
+char-misc.current	38e9f21f648ed3f9125fe09378da9b2eb08b12d9
+soundwire-fixes	49a467310dc4fae591a3547860ee04d8730780f4
+thunderbolt-fixes	f0c4d9fc9cc9462659728d168387191387e903cc
+input-current	26c263bf1847d4dadba016a0457c4c5f446407bf
+crypto-current	9f6035af06b526e678808d492fc0830aef6cfbd8
+vfio-fixes	873aefb376bbc0ed1dd2381ea1d6ec88106fdbd4
+kselftest-fixes	89c1017aac67ca81973b7c8eac5d021315811a93
+modules-fixes	77d6354bd422c8a451ef7d2235322dbf33e7427b
+dmaengine-fixes	c47e6403fa099f200868d6b106701cb42d181d2b
+backlight-fixes	6dfad94814c7e1926a316a8dac7c50b0c1177f4b
+mtd-fixes	c717b9b7d6de9e024e47f7cd5bbff49f581d3db9
+mfd-fixes	a61f4661fba404418a7c77e86586dc52a58a93c6
+v4l-dvb-fixes	de547896aac606a00435a219757a940ece142bf0
+reset-fixes	ae358d71d4623ed0a466a7498f8ce25c7fda22d1
+mips-fixes	9abf2313adc1ca1b6180c508c25f22f9395cc780
+at91-fixes	cef8cdc0d0e7c701fe4dcfba4ed3fd25d28a6020
+omap-fixes	2a906db2824b75444982f5e9df870106982afca8
+kvm-fixes	f4298cac2bfcced49ab308756dc8fef684f3da81
+kvms390-fixes	b6662e37772715447aeff2538444ff291e02ea31
+hwmon-fixes	f0c4d9fc9cc9462659728d168387191387e903cc
+nvdimm-fixes	b3bbcc5d1da1b654091dad15980b3d58fdae0fc6
+cxl-fixes	8f401ec1c8975eabfe4c089de91cbe058deabf71
+btrfs-fixes	1741255d952d632aa544af678e46766af30e5464
+vfs-fixes	7ee47dcfff1835ff75a794d1075b6b5f5462cfed
+dma-mapping-fixes	3be4562584bba603f33863a00c1c32eecf772ee6
+i3c-fixes	fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
+drivers-x86-fixes	53eb64c88f17b14b324fbdfd417f56c5d3fa6fee
+samsung-krzk-fixes	9abf2313adc1ca1b6180c508c25f22f9395cc780
+pinctrl-samsung-fixes	9abf2313adc1ca1b6180c508c25f22f9395cc780
+devicetree-fixes	917c362b5f8a6e31ff35719b1bacfc1b76a1fd2f
+dt-krzk-fixes	9abf2313adc1ca1b6180c508c25f22f9395cc780
+scsi-fixes	ecb8c2580d37dbb641451049376d80c8afaa387f
+drm-fixes	6295f1d8b4503ad8a18519b781dd2d1fe5e88c52
+amdgpu-fixes	2c409ba81be25516afe05ae27a4a15da01740b01
+drm-intel-fixes	178e31ce82d0308a9e5f2f15bfb4493160136729
+mmc-fixes	162503fd1c3a1d4e14dbe7f399c1d1bec1c8abbc
+rtc-fixes	db4e955ae333567dea02822624106c0b96a2f84f
+gnss-fixes	247f34f7b80357943234f93f247a1ae6b6c3a740
+hyperv-fixes	e70af8d040d2b7904dca93d942ba23fb722e21b1
+soc-fsl-fixes	4b0986a3613c92f4ec1bdc7f60ec66fea135991f
+risc-v-fixes	8bc8824d30193eb7755043d5bb65fa7f0d11a595
+risc-v-mc-fixes	0dec364ffeb6149aae572ded1e34d4b444c23be6
+pidfd-fixes	03ba0fe4d09f2eb0a91888caaa057ed67462ae2d
+fpga-fixes	9abf2313adc1ca1b6180c508c25f22f9395cc780
+spdx		6cad1ecd4e3213d892b70afa999a81849d1f0206
+gpio-brgl-fixes	30a0b95b1335e12efef89dd78518ed3e4a71a763
+gpio-intel-fixes	9abf2313adc1ca1b6180c508c25f22f9395cc780
+pinctrl-intel-fixes	9abf2313adc1ca1b6180c508c25f22f9395cc780
+erofs-fixes	9473d22fbfca38a12d7182ca91a0a8bc193a72bf
+integrity-fixes	8433856947217ebb5697a8ff9c4c9cad4639a2cf
+kunit-fixes	618887768bb71f0a475334fa5a4fba7dc98d7ab5
+ubifs-fixes	c18a80c6861f14f572e4163d55388e5e2d3550a1
+memblock-fixes	c94afc46cae7ad41b2ad6a99368147879f4b0e56
+cel-fixes	50256e4793a5e5ab77703c82a47344ad2e774a59
+irqchip-fixes	6c9f7434159b96231f5b27ab938f4766e3586b48
+renesas-fixes	ab2866f12ca18747413ba41409231d44e0c6149b
+broadcom-fixes	9abf2313adc1ca1b6180c508c25f22f9395cc780
+perf-current	5aaef24b5c6d4246b2cac1be949869fa36577737
+efi-fixes	1bf039df2f63402adb365f59383fe9d34e2ef641
+zstd-fixes	88a309465b3f05a100c3b81966982c0f9f5d23a6
+battery-fixes	767e684367e4759d9855b184045b7a9d6b19acd2
+uml-fixes	bd71558d585ac61cfd799db7f25e78dca404dd7a
+asahi-soc-fixes	568035b01cfb107af8d2e4bd2fb9aea22cf5b868
+iommufd-fixes	30a0b95b1335e12efef89dd78518ed3e4a71a763
+drm-misc-fixes	e0b26b9482461e9528552f54fa662c2269f75b3f
+kbuild		2df76606db9de579bc96725981db4e8daa281993
+clang-format	781121a7f6d11d7cae44982f174ea82adeec7db0
+perf		96e6d929a6c3368ad6327a52f870294747888c77
+compiler-attributes	6cf1ab89c9e75ed8f3432563c212d688b6d3563b
+dma-mapping	8d58aa484920c4f9be4834a7aeb446cdced21a37
+asm-generic	2e21c1575208786f667cb66d8cf87a52160b81db
+arc		f2906aa863381afb0015a9eb7fefad885d4e5a56
+arm		0c52591d22e99759da3793f19249bbf45ad742bd
+arm64		f0c4d9fc9cc9462659728d168387191387e903cc
+arm-perf	aaaee7b55c9e58410abcef6e3e2fd80e4135d02e
+arm-soc		76b4abc1ae4b291ca70fbd35868b4a918211c96c
+actions		444d018d8d3874c9c3784a5df3ad2e5f554fbdb6
+amlogic		475701ff77efac421a912875f78c0f58313c058b
+asahi-soc	56fed763f6b2dc2578ea8c3e7d317722d8581cba
+aspeed		127646b2a4a319467bb866342614935340715b84
+at91		4fb3808be76857b241d11c96534be16de8f749d1
+broadcom	9abf2313adc1ca1b6180c508c25f22f9395cc780
+davinci		53ad523ac43500bc1ab3f8c4d757715a29885a13
+drivers-memory	1f1e46b83b7db08c8db31816c857e27da84d4ca3
+imx-mxs		89ca3fade6cb49d021514fce1ea2e929f18ad4bb
+keystone	cb293d3b430e35dbc1e8425869f27624355ff10a
+mediatek	25cc9975caadfba2cb901edcfb30c295147738e5
+mvebu		d5c48679d56c2a0d1832bf0dbba505937d4660aa
+omap		8efe5dea6753bc55111f256d6b401d2aa241b7c8
+qcom		e6466fbaad675d73d51582775083389078ca7b4b
+raspberrypi	c5915b53d4c2021fef3ceaa3c93ccd9ba67515ca
+renesas		cb7df0645f0f5f3d940190c323b56ce69718c418
+reset		d985db83622679fc496ed824088e066528b3a872
+rockchip	7771a384229fe8706329a5c7046c14b7812bd6de
+samsung-krzk	113aec13d45ecae4780dba871a2ae99d4c362b5a
+scmi		e7c94176ab905ef32bdab1154709c8c939711dc7
+stm32		7ad436adc788802875448c8279a908d155313968
+sunxi		1c50050ca1ebe46db27b016326c6c3508a161ee9
+tee		bd52407221b4702af690456b2b6006fa6440e893
+tegra		77bfb4481cf2461b8c728cdf355e393da07e3a95
+ti		b7897ec0b3d298eb6b1ee8ddc17a98e09fda6f02
+xilinx		0413dd4d95da9f743ff1e0337d413af5a84db515
+clk		5eeec1fd8360d57899d29a607ff81d0094e6cf59
+clk-imx		9abf2313adc1ca1b6180c508c25f22f9395cc780
+clk-renesas	523ed9442b997c39220ee364b07a8773623e3a58
+clk-samsung	b35f27fe73d8c86fe40125e063b28007e961b862
+csky		ce0ba954805e0783ceb7304d4fb357a02038e231
+loongarch	247f34f7b80357943234f93f247a1ae6b6c3a740
+m68k		550a998f37b4f9c243501f735aa283c79189ba9b
+m68knommu	f0c4d9fc9cc9462659728d168387191387e903cc
+microblaze	493ffd6605b2d3d4dc7008ab927dba319f36671f
+mips		9abf2313adc1ca1b6180c508c25f22f9395cc780
+nios2		7f7bc20bc41a4fbcd2db75b375ac95e5faf958ae
+openrisc	34a0bac084e49324c29e6d0984d24096e02c6314
+parisc-hd	247f34f7b80357943234f93f247a1ae6b6c3a740
+powerpc		247f34f7b80357943234f93f247a1ae6b6c3a740
+soc-fsl		4b0986a3613c92f4ec1bdc7f60ec66fea135991f
+risc-v		be79afc740b5a1b2048cd67580cdb9d76d7e6cc2
+risc-v-mc	d6105a8b7c160a73ae04054c8921eba80a294146
+s390		ccb7d9db01b97d3358dcb13d13d968bab1202939
+sh		8518e694203d0bfd202ea4a80356785b6992322e
+sparc-next	dd0d718152e4c65b173070d48ea9dfc06894c3e5
+uml		193cb8372424184dde28088a4230a5fed0afb0ad
+xtensa		b8c4f4db24368fb6ba6283b9c3a67da04db22751
+pidfd		6a857ab5b57cdeb16d7ea75591a0ae3c6ec0750a
+vfs-idmapping	4021e661a093bff360bd0697dc95ea0341de4594
+fscrypt		0e91fc1e0f5c70ce575451103ec66c2ec21f1a6e
+fscache		0885eacdc81f920c3e0554d5615e69a66504a28d
+afs		26291c54e111ff6ba87a164d85d4a4e134b7315c
+btrfs		4eb8c0548db12a30839fb9f8338d076f5c64b655
+ceph		ffc4d66a34bb5bd76d0a3f83bebf500d96a8e37c
+cifs		f0c4d9fc9cc9462659728d168387191387e903cc
+configfs	84ec758fb2daa236026506868c8796b0500c047d
+ecryptfs	c1cc2db216078f9b1e29c991b1b9177c26757162
+erofs		312fe643ad1153fe0337c46f4573030d0c2bac73
+exfat		3d0cdf1b32dc63955c4737013dd1c2d221f9941d
+ext3		ab7720a2b1175b21cace83757a9fd70408156bae
+ext4		0d043351e5baf3857f915367deba2a518b6a0809
+f2fs		3b21b794b5797d35f4fad930b53b1cd881c12dd3
+fsverity	8377e8a24bba1ae73b3869bc71ee9df16b6bef61
+fuse		cbed990fb81340cf9c67faad29edf54792a2fbfe
+gfs2		288fc86067620dcbec34a335b95b75635551e8fe
+jfs		25e70c6162f207828dd405b432d8f2a98dbf7082
+ksmbd		f0c4d9fc9cc9462659728d168387191387e903cc
+nfs		f0c4d9fc9cc9462659728d168387191387e903cc
+nfs-anna	7e8436728e22181c3f12a5dbabd35ed3a8b8c593
+nfsd		f15ab65c1bb72eb2250f3e825df2e301db6c17ba
+ntfs3		0d6d7c61ffeedc782b651a080ad6543ad45314b6
+orangefs	2ad4b6f5e1179f3879b6d4392070039e32ce55a3
+overlayfs	b337e5ae0e4249a6084b7647531a728da0222cb4
+ubifs		669d204469c46e91d99da24914130f78277a71d3
+v9fs		a8e633c604476e24d26a636582c0f5bdb421e70d
+xfs		4eb559dd15671cca355a61a4164e8f19e3952637
+zonefs		6bac30bb8ff8195cbcfc177b3b6b0732929170c1
+iomap		adc9c2e5a723052de4f5bd7e3d6add050ba400e1
+djw-vfs		49df34221804cfd6384135b28b03c9461a31d024
+file-locks	072e51356cd5a4a1c12c1020bc054c99b98333df
+iversion	2b3319b355731c721dd43a2735e08737299e426a
+vfs		3aca47127a646165965ff52803e2b269eed91afc
+printk		950a9751c1d1b48202c0e02fb04718f5b8d113b8
+pci		652ce11a7604cac4149ac20acaf145f93924e639
+pstore		38b91847c314f49c80e30062549d4709a3754ea6
+hid		29e97b78fbda13597aaedbeb1dc423784679fe57
+i2c		befeb20d38133cf0d227ae8251ab3d392f295f52
+i3c		9abf2313adc1ca1b6180c508c25f22f9395cc780
+dmi		13a0ac816d22aa47d6c393f14a99f39e49b960df
+hwmon-staging	4abf03c1fb6c1e2c347ae131b423d54c95983dc8
+jc_docs		07ab97fe7f8a9967fd4d13ea21bef47927034f6f
+v4l-dvb		f0c4d9fc9cc9462659728d168387191387e903cc
+v4l-dvb-next	1e284ea984d3705e042b6b07469a66f1d43371e3
+pm		fd856f9c4ef381398466a06b3480549368d90e2d
+cpufreq-arm	1313edfdcd79ac8f7aa92162db646eb0eb7a32c2
+cpupower	9abf2313adc1ca1b6180c508c25f22f9395cc780
+devfreq		9abf2313adc1ca1b6180c508c25f22f9395cc780
+opp		dba79b78ecc18f7788fd08eb998388e226817fb5
+thermal		9d2bc364f67793cdd115f3ab92a18eaf85fee66f
+ieee1394	54b3bd99f094b3b919de4078f60d722e62a767e3
+dlm		775af207464bd28a2086f8399c0b2a3f1f40c7ae
+rdma		692373d186205dfb1b56f35f22702412d94d9420
+net-next	8e18be7610aebea50e9327c11afcd5eeaaa06644
+bpf-next	e5659e4e19e49f1eac58bb07ce8bc2d78a89fe65
+ipsec-next	cc2bbbfd9a5064cb8fc2996962d90b782f906223
+mlx5-next	9abf2313adc1ca1b6180c508c25f22f9395cc780
+netfilter-next	677fb7525331375ba2f90f4bc94a80b9b6e697a3
+ipvs-next	677fb7525331375ba2f90f4bc94a80b9b6e697a3
+bluetooth	ab80b2cec05fec4b9f3f93d33cc78463b33e8a6c
+wireless-next	b8f6efccbb9dc0ff5dee7e20d69a4747298ee603
+mtd		077dc37db1e1da1f0e6a745328e4caa6d414e501
+nand		075e181fba721d7af83dd1f2b65aed64703f5a40
+spi-nor		bb0e9c600ce23a308b31e73d10b56e70a5721088
+crypto		329cfa42e5280decfc9247598b9996e13b28c380
+drm		49e8e6343df688d68b12c2af50791ca37520f0b7
+drm-misc	1a0257c352638916fdaffaac2ddedb8e049312f3
+amdgpu		d8ba9f202cd40b1780aafcf4b2748044fc150686
+drm-intel	882ecff709b50b36128e07a6b0035f476c769f50
+drm-tegra	8748f3219e032e5a9206d4fd9d9a6164d9ad3a19
+drm-msm		7f7a942c0a338c4a2a7b359bdb2b68e9896122ec
+drm-msm-lumag	ee417928fe0a3131b16bd22889fe85089d41760e
+imx-drm		927d8fd465adbaaad6cce82f840d489d7c378f29
+etnaviv		4bce244272513ebb4d13c570e9fbca28497015b2
+fbdev		d12d0c96794508a4042b1aa332f38b53cdf6e52a
+regmap		7c7aa42243cb4059ad5f1f11031eb578ceb6385c
+sound		d59b6f215aa8bf52f36f72235752177fb79cf5b3
+sound-asoc	23faebde20e35c6c9c18aad476a768b3467913b2
+modules		dd0338eef0d4b5f94bd63e26413da4046aeddb73
+input		60f07c29e035b2554db951b494dd804317c230d3
+block		72cc2f803da13ff0ee5c3138e5e62618726a968c
+device-mapper	5434ee8d28575b2e784bd5b4dbfc912e5da90759
+libata		de58fd3d80f884f7f322a06bfe08465e49b47c5d
+pcmcia		15e74c6c1ce2d388e967f32cdaa83ca034fa6452
+mmc		c615212f9e8ffaa48bd7fad79d05ba51c5bd17db
+mfd		2c99184635435710def3a5978af008e6365c50c6
+backlight	e7647de058cba3c05b0d4753d84cbc042d02956a
+battery		09b327c991d21f7b432ba7b88b2368a6970c3916
+regulator	3c952a2a06a2fa9de13e2884651d242bf729b04a
+security	b10b9c342f7571f287fd422be5d5c0beb26ba974
+apparmor	4295c60bbe9e63e35d330546eeaa1d2b62dae303
+integrity	8c1d6a050a0f16e0a9d32eaf53b965c77279c6f8
+keys		2d743660786ec51f5c1fefd5782bbdee7b227db0
+safesetid	64b634830c919979de4b18163e15d30df66e64a8
+selinux		e0d8259355cb846f9cf2e38f6ba3430aecb9ebcc
+smack		1a3065e92046e57f60d7c9a48acae0d0badefe36
+tomoyo		9abf2313adc1ca1b6180c508c25f22f9395cc780
+tpmdd		2d869f0b458547386fbcd8cf3004b271b7347b7f
+watchdog	f0c4d9fc9cc9462659728d168387191387e903cc
+iommu		7e8eec906b5b80030815e606824384162e5251df
+audit		50979953c0c41e929e5f955800da68e1bb24c7ab
+devicetree	c2741cbe7f8aba56a79a150536863eb1f62f9af6
+dt-krzk		2d27c3ae9666bc9022c0716b1dc0fc212255d7af
+mailbox		b8ae88e1e75e5cb7a6df5298ab75334362ed631c
+spi		5e2212c83adab6338db46ebd8a2a8cb5f9c78aaf
+tip		01d2077d0e550dc47418d27870786bf0aed5c92c
+clockevents	af246cc6d0ed11318223606128bb0b09866c4c08
+edac		b998a2babf4ed3006f7848293e9e533136cdf571
+irqchip		732d69c80cb04a587d9ec2935bcb63989e66eb92
+ftrace		0934ae9977c27133449b6dd8c6213970e7eece38
+rcu		75f97d8e607ceb54ed5fb2ffab09a35d1f5edcf0
+kvm		f4298cac2bfcced49ab308756dc8fef684f3da81
+kvm-arm		b302ca52ba8235ff0e18c0fa1fa92b51784aef6a
+kvms390		58635d6615f1e5a870548ae8999870fdfcdecec0
+xen-tip		4bff677b30156435afa2cc4c3601b542b4ddd439
+percpu		b9819165bb455bfdce37086c622a18cce2dd2f5e
+workqueues	c0feea594e058223973db94c1c32a830c9807c86
+drivers-x86	309e0a6ed6e3fdb4febacc3e91aeb268500b90c6
+chrome-platform	015e4b05c377dc5e066e88737bff9990d5ac358d
+hsi		9abf2313adc1ca1b6180c508c25f22f9395cc780
+leds		5f52a8ba7e91215c3d046d298fb328d1b9f7897d
+ipmi		0eb1762f3c77a20f4a93f29239f0cb0a52d41dd6
+driver-core	1662cea4623f75d8251adf07370bbaa958f0355d
+usb		a8bc8cc193c69e41df5e757d1a592346526e136d
+thunderbolt	a5cfc9d65879c0d377f732531a2e80ee3a9eebbc
+usb-gadget	e49d033bddf5b565044e2abe4241353959bc9120
+usb-serial	247f34f7b80357943234f93f247a1ae6b6c3a740
+tty		5c30f3e4a6e67c88c979ad30554bf4ef9b24fbd0
+char-misc	30a0b95b1335e12efef89dd78518ed3e4a71a763
+coresight	3c728e079d83f581a1f8b7755f6e26087b15c4fb
+fpga		ee31d5038c06b56ea515f4fe490274628c0f80e1
+icc		9abf2313adc1ca1b6180c508c25f22f9395cc780
+iio		b8bee0f98634cc1ce8cc8bf0e1db025734ee0c2b
+phy-next	846d479224537185768276dd4a84c1bda2bbcd4e
+soundwire	cf43cd33b67a291fadcd16b1ad2f435bd2e60749
+extcon		9abf2313adc1ca1b6180c508c25f22f9395cc780
+gnss		247f34f7b80357943234f93f247a1ae6b6c3a740
+vfio		b1b8132a651cf6a5b18a01d8f1bd304f5d210315
+staging		a37068715956111af1d49105d9e41b4cc8f69ea0
+counter-next	30a0b95b1335e12efef89dd78518ed3e4a71a763
+mux		0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
+dmaengine	4476ca4ca8dcd68c41757ca29e72bed519ddfa23
+cgroup		79a7f41f7f5ac69fd22eaf1fb3e230bea95f3399
+scsi		46c80503f387276e771ce83659684742e8acc5bb
+scsi-mkp	e56ca6bcd2136207868516f5a304fbb82cc0cb82
+vhost		be8ddea9e75e65b05837f6d51dc5774b866d0bcf
+rpmsg		1b09681fdc30991d35a458bed6d465bb90c91fa6
+gpio		e73f0f0ee7541171d89f2e2491130c7771ba58d3
+gpio-brgl	80280df758c1498485988b30cf6887fde7796056
+gpio-intel	8d259847243d1e21a866e828c4ce90d759f3d17b
+gpio-sim	0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
+pinctrl		bfe66c8bb35c9307bada60f9563c37fff5ca5d16
+pinctrl-intel	b14ef61314b37a4a720a1f5686627d5061387480
+pinctrl-renesas	96355be8f0a2a7a91aae2e66c0795a13444db5ba
+pinctrl-samsung	9abf2313adc1ca1b6180c508c25f22f9395cc780
+pwm		bf22908680cca3dd9f575335b5d7716d7b97f0d8
+userns		b5df013cd19427caddcd52c3bb0b4ff1b41740ff
+ktest		170f4869e66275f498ae4736106fb54c0fdcd036
+kselftest	d942f231afc037490538cea67bb0c667e6d12214
+livepatching	cad81ab739979d3d628250e763eace86ad2514e5
+rtc		9abf2313adc1ca1b6180c508c25f22f9395cc780
+nvdimm		305a72efa791c826fe84768ca55e31adc4113ea8
+at24		9abf2313adc1ca1b6180c508c25f22f9395cc780
+ntb		4fe89d07dcc2804c8b562f6c7896a45643d34b2f
+seccomp		4e92863862d17e5383b7245c0cb732c9b21cd0c4
+cisco		9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
+fsi		35af9fb49bc5c6d61ef70b501c3a56fe161cce3e
+slimbus		c3174a51dc361ceaeefee0a252f4a4763c774216
+nvmem		8425f515976121802cd9426cb7321d9bc44a8910
+xarray		69cb69ea55420388b444ee30b1530ec15ab584f7
+hyperv		c6984010648369c97173572b63abfb38794ffd2d
+auxdisplay	13de23494f387315c6cfab6fe78fbed7d1b25586
+kgdb		c1cb81429df462eca1b6ba615cddd21dd3103c46
+hmm		9abf2313adc1ca1b6180c508c25f22f9395cc780
+kunit		9abf2313adc1ca1b6180c508c25f22f9395cc780
+cfi		3123109284176b1532874591f7c81f3837bbdc17
+kunit-next	6fe1ad4a156095859721fef85073df3ed43081d4
+trivial		081c8919b02bc1077279cd03972d7ec6f53a6c6b
+mhi		d8425a8c3a8419dd505016951dd6393f21fb394e
+memblock	80c2fe022ef5d29f3bafee90c37dbcff18cab57a
+init		38b082236e77d403fed23ac2d30d570598744ec3
+cxl		9abf2313adc1ca1b6180c508c25f22f9395cc780
+folio-iomap	4d7bd0eb72e5831ddb1288786a96448b48440825
+zstd		2aa14b1ab2c41a4fe41efae80d58bb77da91f19f
+efi		27e80a1f89b1b7f6af2f6a46bcb4a3fd9c2b8a14
+unicode		b500d6d7243d2e0807a39a09c52fbe668b59b2c1
+slab		74db113e8571ac9afe30ad352a5beec9e8677b9a
+random		6cd0a8ecc0f4bb027e35063c0a4ec491c061bd27
+landlock	0b4ab8cd635e8b21e42c14b9e4810ca701babd11
+rust		fd9517a1603f083dfa88f3cf9dc67d26f6ba0ec0
+sysctl		c06a17fe056b84f5784b2f13753870eb65edc9ed
+folio		03b33c09ea22fa89dd204ad0a2058e512c691b9f
+execve		ef20c5139c3157b5c6eda46f496952bddffe9ad6
+bitmap		27bc50fc90647bbf7b734c3fc306a5e61350da53
+hte		9abf2313adc1ca1b6180c508c25f22f9395cc780
+kspp		0eaf29a032980c76957ffbaf6afeb7024a658770
+kspp-gustavo	0811296c55b7f0c5b038410828e37a1a1bf04463
+unsigned-char	97f7ffb4116920f0b47cccafec15d2d97a6c6777
+iommufd		65016290f146bb17d7762f4ee1b6e8e377eae3f5
+mm-stable	b742122b4e3682f618924af26ad14291a8f11e04
+mm-nonmm-stable	f0c4d9fc9cc9462659728d168387191387e903cc
+mm		fa2a6c31f1c08f26ecf229288d0bb421bd573953
diff --git a/Next/Trees b/Next/Trees
new file mode 100644
index 000000000000..b4145ee7db95
--- /dev/null
+++ b/Next/Trees
@@ -0,0 +1,370 @@
+Trees included into this release:
+
+Name		Type	URL
+----		----	---
+origin		git	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it#master
+fixes		git	git://git.kernel.org/pub/scm/linux/kernel/git/sfr/next-fixes.gi=
t#fixes
+mm-hotfixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm#mm-h=
otfixes-unstable
+kbuild-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy=
/linux-kbuild.git#fixes
+arc-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.g=
it#for-curr
+arm-current	git	git://git.armlinux.org.uk/~rmk/linux-arm.git#fixes
+arm64-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux#=
for-next/fixes
+arm-soc-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.gi=
t#arm/fixes
+davinci-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/brgl/lin=
ux.git#davinci/for-current
+drivers-memory-fixes	git	https://git.kernel.org/pub/scm/linux/kernel/git/k=
rzk/linux-mem-ctrl.git#fixes
+tee-fixes	git	https://git.linaro.org/people/jens.wiklander/linux-tee.git#f=
ixes
+m68k-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux=
-m68k.git#for-linus
+powerpc-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/li=
nux.git#fixes
+s390-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.gi=
t#fixes
+sparc		git	git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git#m=
aster
+fscrypt-current	git	git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git#fo=
r-stable
+net		git	git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git#mast=
er
+bpf		git	git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git#master
+ipsec		git	git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.gi=
t#master
+netfilter	git	git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git#m=
aster
+ipvs		git	git://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git#mas=
ter
+wireless	git	git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wirele=
ss.git#for-next
+rdma-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git=
#for-rc
+sound-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/soun=
d.git#for-linus
+sound-asoc-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie=
/sound.git#for-linus
+regmap-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/reg=
map.git#for-linus
+regulator-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/=
regulator.git#for-linus
+spi-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.gi=
t#for-linus
+pci-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.=
git#for-linus
+driver-core.current	git	git://git.kernel.org/pub/scm/linux/kernel/git/greg=
kh/driver-core.git#driver-core-linus
+tty.current	git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.g=
it#tty-linus
+usb.current	git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.g=
it#usb-linus
+usb-gadget-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/balbi/u=
sb.git#fixes
+usb-serial-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/johan/u=
sb-serial.git#usb-linus
+phy		git	git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git#f=
ixes
+staging.current	git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/s=
taging.git#staging-linus
+iio-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git#=
fixes-togreg
+counter-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/wbg/coun=
ter.git#counter-current
+char-misc.current	git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh=
/char-misc.git#char-misc-linus
+soundwire-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/so=
undwire.git#fixes
+thunderbolt-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/wester=
i/thunderbolt.git#fixes
+input-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input=
.git#for-linus
+crypto-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/herbert/c=
rypto-2.6.git#master
+vfio-fixes	git	git://github.com/awilliam/linux-vfio.git#for-linus
+kselftest-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/shuah/li=
nux-kselftest.git#fixes
+modules-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/lin=
ux.git#modules-linus
+dmaengine-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dm=
aengine.git#fixes
+backlight-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/lee/back=
light.git#for-backlight-fixes
+mtd-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git#=
mtd/fixes
+mfd-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git#fo=
r-mfd-fixes
+v4l-dvb-fixes	git	git://linuxtv.org/mchehab/media-next.git#fixes
+reset-fixes	git	https://git.pengutronix.de/git/pza/linux#reset/fixes
+mips-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.gi=
t#mips-fixes
+at91-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.gi=
t#at91-fixes
+omap-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-=
omap.git#fixes
+kvm-fixes	git	git://git.kernel.org/pub/scm/virt/kvm/kvm.git#master
+kvms390-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/li=
nux.git#master
+hwmon-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux=
-staging.git#hwmon
+nvdimm-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdi=
mm.git#libnvdimm-fixes
+cxl-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git#fi=
xes
+btrfs-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.=
git#next-fixes
+vfs-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git#f=
ixes
+dma-mapping-fixes	git	git://git.infradead.org/users/hch/dma-mapping.git#fo=
r-linus
+i3c-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git#=
i3c/fixes
+drivers-x86-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/=
platform-drivers-x86.git#fixes
+samsung-krzk-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/krzk/=
linux.git#fixes
+pinctrl-samsung-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/pi=
nctrl/samsung.git#fixes
+devicetree-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/robh/li=
nux.git#dt/linus
+dt-krzk-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux=
-dt.git#fixes
+scsi-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git#=
fixes
+drm-fixes	git	git://git.freedesktop.org/git/drm/drm.git#drm-fixes
+amdgpu-fixes	git	git://people.freedesktop.org/~agd5f/linux#drm-fixes
+drm-intel-fixes	git	git://anongit.freedesktop.org/drm-intel#for-linux-next=
-fixes
+mmc-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git#f=
ixes
+rtc-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux=
.git#rtc-fixes
+gnss-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.gi=
t#gnss-linus
+hyperv-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linu=
x.git#hyperv-fixes
+soc-fsl-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.=
git#fix
+risc-v-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux=
.git#fixes
+risc-v-mc-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/conor/li=
nux.git#dt-fixes
+pidfd-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linu=
x.git#fixes
+fpga-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fp=
ga.git#fixes
+spdx		git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git#sp=
dx-linus
+gpio-brgl-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/brgl/lin=
ux.git#gpio/for-current
+gpio-intel-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/andy/li=
nux-gpio-intel.git#fixes
+pinctrl-intel-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/pinc=
trl/intel.git#fixes
+erofs-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.=
git#fixes
+integrity-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/zohar/li=
nux-integrity#fixes
+kunit-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-=
kselftest.git#kunit-fixes
+ubifs-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git=
#fixes
+memblock-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memb=
lock.git#fixes
+cel-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux#for-=
rc
+irqchip-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-pl=
atforms.git#irq/irqchip-fixes
+renesas-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/geert/rene=
sas-devel.git#fixes
+broadcom-fixes	git	https://github.com/Broadcom/stblinux.git#fixes
+perf-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.=
git#perf/urgent
+efi-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git#ur=
gent
+zstd-fixes	git	https://github.com/terrelln/linux.git#zstd-linus
+battery-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-=
power-supply.git#fixes
+uml-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git#=
fixes
+asahi-soc-fixes	git	https://github.com/AsahiLinux/linux.git#asahi-soc/fixes
+iommufd-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommuf=
d.git#for-rc
+drm-misc-fixes	git	git://anongit.freedesktop.org/drm/drm-misc#for-linux-ne=
xt-fixes
+kbuild		git	git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-=
kbuild.git#for-next
+clang-format	git	https://github.com/ojeda/linux.git#clang-format
+perf		git	git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git#per=
f/core
+compiler-attributes	git	https://github.com/ojeda/linux.git#compiler-attrib=
utes
+dma-mapping	git	git://git.infradead.org/users/hch/dma-mapping.git#for-next
+asm-generic	git	git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-gen=
eric.git#master
+arc		git	git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git#for-=
next
+arm		git	git://git.armlinux.org.uk/~rmk/linux-arm.git#for-next
+arm64		git	git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux#for-n=
ext/core
+arm-perf	git	git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git#=
for-next/perf
+arm-soc		git	git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git#for=
-next
+actions		git	git://git.kernel.org/pub/scm/linux/kernel/git/mani/linux-acti=
ons.git#for-next
+amlogic		git	git://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.g=
it#for-next
+asahi-soc	git	https://github.com/AsahiLinux/linux.git#asahi-soc/for-next
+aspeed		git	git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git#for=
-next
+at91		git	git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git#at9=
1-next
+broadcom	git	https://github.com/Broadcom/stblinux.git#next
+davinci		git	git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git#=
davinci/for-next
+drivers-memory	git	https://git.kernel.org/pub/scm/linux/kernel/git/krzk/li=
nux-mem-ctrl.git#for-next
+imx-mxs		git	git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.=
git#for-next
+keystone	git	git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-=
keystone.git#next
+mediatek	git	git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/li=
nux.git#for-next
+mvebu		git	git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.gi=
t#for-next
+omap		git	git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.=
git#for-next
+qcom		git	git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git#for=
-next
+raspberrypi	git	git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux=
-rpi.git#for-next
+renesas		git	git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-d=
evel.git#next
+reset		git	https://git.pengutronix.de/git/pza/linux#reset/next
+rockchip	git	git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-roc=
kchip.git#for-next
+samsung-krzk	git	git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.=
git#for-next
+scmi		git	git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux=
.git#for-linux-next
+stm32		git	git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git=
#stm32-next
+sunxi		git	git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git#s=
unxi/for-next
+tee		git	https://git.linaro.org/people/jens.wiklander/linux-tee.git#next
+tegra		git	git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git#f=
or-next
+ti		git	git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git#ti-next
+xilinx		git	git://github.com/Xilinx/linux-xlnx.git#for-next
+clk		git	git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git#clk-n=
ext
+clk-imx		git	git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.=
git#for-next
+clk-renesas	git	git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesa=
s-drivers.git#renesas-clk
+clk-samsung	git	git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/cl=
k.git#for-next
+csky		git	git://github.com/c-sky/csky-linux.git#linux-next
+loongarch	git	git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/lin=
ux-loongson.git#loongarch-next
+m68k		git	git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.g=
it#for-next
+m68knommu	git	git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu=
.git#for-next
+microblaze	git	git://git.monstr.eu/linux-2.6-microblaze.git#next
+mips		git	git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git#mip=
s-next
+nios2		git	git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git#f=
or-next
+openrisc	git	git://github.com/openrisc/linux.git#for-next
+parisc-hd	git	git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-=
linux.git#for-next
+powerpc		git	git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.g=
it#next
+soc-fsl		git	git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git#n=
ext
+risc-v		git	git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git#=
for-next
+risc-v-mc	git	git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.gi=
t#dt-for-next
+s390		git	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git#for=
-next
+sh		git	git://git.libc.org/linux-sh#for-next
+sparc-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-n=
ext.git#master
+uml		git	git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git#next
+xtensa		git	git://github.com/jcmvbkbc/linux-xtensa.git#xtensa-for-next
+pidfd		git	git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git=
#for-next
+vfs-idmapping	git	git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapp=
ing.git#for-next
+fscrypt		git	git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git#master
+fscache		git	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-=
fs.git#fscache-next
+afs		git	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.g=
it#afs-next
+btrfs		git	git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git#f=
or-next
+ceph		git	git://github.com/ceph/ceph-client.git#master
+cifs		git	git://git.samba.org/sfrench/cifs-2.6.git#for-next
+configfs	git	git://git.infradead.org/users/hch/configfs.git#for-next
+ecryptfs	git	git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptf=
s.git#next
+erofs		git	git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git#d=
ev
+exfat		git	git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.=
git#dev
+ext3		git	git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git#=
for_next
+ext4		git	git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git#dev
+f2fs		git	git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git#d=
ev
+fsverity	git	git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git#fsverity
+fuse		git	git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#=
for-next
+gfs2		git	git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.gi=
t#for-next
+jfs		git	git://github.com/kleikamp/linux-shaggy.git#jfs-next
+ksmbd		git	https://github.com/smfrench/smb3-kernel.git#ksmbd-for-next
+nfs		git	git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git#linux-next
+nfs-anna	git	git://git.linux-nfs.org/projects/anna/linux-nfs.git#linux-next
+nfsd		git	git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux#for-next
+ntfs3		git	https://github.com/Paragon-Software-Group/linux-ntfs3.git#master
+orangefs	git	git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux#fo=
r-next
+overlayfs	git	git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.g=
it#overlayfs-next
+ubifs		git	git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git#next
+v9fs		git	git://github.com/martinetd/linux#9p-next
+xfs		git	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git#for-next
+zonefs		git	git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.g=
it#for-next
+iomap		git	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git#iomap-for-next
+djw-vfs		git	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git#vfs-for-next
+file-locks	git	git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux=
.git#locks-next
+iversion	git	git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.g=
it#iversion-next
+vfs		git	git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git#for-ne=
xt
+printk		git	git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git=
#for-next
+pci		git	git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git#next
+pstore		git	git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git#f=
or-next/pstore
+hid		git	git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git#for-next
+i2c		git	git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git#i2c/f=
or-next
+i3c		git	git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git#i3c/n=
ext
+dmi		git	git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.gi=
t#dmi-for-next
+hwmon-staging	git	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/lin=
ux-staging.git#hwmon-next
+jc_docs		git	git://git.lwn.net/linux.git#docs-next
+v4l-dvb		git	git://linuxtv.org/media_tree.git#master
+v4l-dvb-next	git	git://linuxtv.org/mchehab/media-next.git#master
+pm		git	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git#=
linux-next
+cpufreq-arm	git	git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.g=
it#cpufreq/arm/linux-next
+cpupower	git	git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git=
#cpupower
+devfreq		git	git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.g=
it#devfreq-next
+opp		git	git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git#opp/=
linux-next
+thermal		git	git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.g=
it#thermal/linux-next
+ieee1394	git	git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1=
394.git#for-next
+dlm		git	git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.=
git#next
+rdma		git	git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git#for-=
next
+net-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next=
.git#master
+bpf-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.gi=
t#for-next
+ipsec-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipse=
c-next.git#master
+mlx5-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux=
.git#mlx5-next
+netfilter-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-=
next.git#master
+ipvs-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs-nex=
t.git#master
+bluetooth	git	git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blue=
tooth-next.git#master
+wireless-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/wireless/w=
ireless-next.git#for-next
+mtd		git	git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git#mtd/n=
ext
+nand		git	git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git#nand=
/next
+spi-nor		git	git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git#s=
pi-nor/next
+crypto		git	git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptode=
v-2.6.git#master
+drm		git	git://git.freedesktop.org/git/drm/drm.git#drm-next
+drm-misc	git	git://anongit.freedesktop.org/drm/drm-misc#for-linux-next
+amdgpu		git	https://gitlab.freedesktop.org/agd5f/linux#drm-next
+drm-intel	git	git://anongit.freedesktop.org/drm-intel#for-linux-next
+drm-tegra	git	https://gitlab.freedesktop.org/drm/tegra.git#for-next
+drm-msm		git	https://gitlab.freedesktop.org/drm/msm.git#msm-next
+drm-msm-lumag	git	https://gitlab.freedesktop.org/lumag/msm.git#msm-next-lu=
mag
+imx-drm		git	https://git.pengutronix.de/git/pza/linux#imx-drm/next
+etnaviv		git	https://git.pengutronix.de/git/lst/linux#etnaviv/next
+fbdev		git	git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbde=
v.git#for-next
+regmap		git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.g=
it#for-next
+sound		git	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git#f=
or-next
+sound-asoc	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound=
.git#for-next
+modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.gi=
t#modules-next
+input		git	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git#ne=
xt
+block		git	git://git.kernel.dk/linux-block.git#for-next
+device-mapper	git	git://git.kernel.org/pub/scm/linux/kernel/git/device-map=
per/linux-dm.git#for-next
+libata		git	git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.g=
it#for-next
+pcmcia		git	git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git#=
pcmcia-next
+mmc		git	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git#next
+mfd		git	git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git#for-mfd=
-next
+backlight	git	git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.=
git#for-backlight-next
+battery		git	git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power=
-supply.git#for-next
+regulator	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regula=
tor.git#for-next
+security	git	git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git=
#next
+apparmor	git	git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparm=
or#apparmor-next
+integrity	git	git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-in=
tegrity#next-integrity
+keys		git	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.=
git#keys-next
+safesetid	git	https://github.com/micah-morton/linux.git#safesetid-next
+selinux		git	git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux=
.git#next
+smack		git	git://github.com/cschaufler/smack-next#next
+tomoyo		git	https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git#master
+tpmdd		git	git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmd=
d.git#next
+watchdog	git	git://www.linux-watchdog.org/linux-watchdog-next.git#master
+iommu		git	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git#ne=
xt
+audit		git	git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git=
#next
+devicetree	git	git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.gi=
t#for-next
+dt-krzk		git	git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.g=
it#for-next
+mailbox		git	git://git.linaro.org/landing-teams/working/fujitsu/integratio=
n.git#mailbox-for-next
+spi		git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git#for=
-next
+tip		git	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git#master
+clockevents	git	git://git.linaro.org/people/daniel.lezcano/linux.git#timer=
s/drivers/next
+edac		git	git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git#edac-f=
or-next
+irqchip		git	git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfor=
ms.git#irq/irqchip-next
+ftrace		git	git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trac=
e.git#for-next
+rcu		git	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.g=
it#rcu/next
+kvm		git	git://git.kernel.org/pub/scm/virt/kvm/kvm.git#next
+kvm-arm		git	git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.g=
it#next
+kvms390		git	git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.g=
it#next
+xen-tip		git	git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git#lin=
ux-next
+percpu		git	git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.gi=
t#for-next
+workqueues	git	git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git#for=
-next
+drivers-x86	git	git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platfo=
rm-drivers-x86.git#for-next
+chrome-platform	git	git://git.kernel.org/pub/scm/linux/kernel/git/chrome-p=
latform/linux.git#for-next
+hsi		git	git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git#f=
or-next
+leds		git	git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.g=
it#for-next
+ipmi		git	git://github.com/cminyard/linux-ipmi.git#for-next
+driver-core	git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/drive=
r-core.git#driver-core-next
+usb		git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git#usb-=
next
+thunderbolt	git	git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thun=
derbolt.git#next
+usb-gadget	git	git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git=
#next
+usb-serial	git	git://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-ser=
ial.git#usb-next
+tty		git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git#tty-=
next
+char-misc	git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-mi=
sc.git#char-misc-next
+coresight	git	git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linu=
x.git#next
+fpga		git	git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.gi=
t#for-next
+icc		git	git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git#icc-=
next
+iio		git	git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git#togreg
+phy-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.g=
it#next
+soundwire	git	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwir=
e.git#next
+extcon		git	git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.g=
it#extcon-next
+gnss		git	git://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git#gns=
s-next
+vfio		git	git://github.com/awilliam/linux-vfio.git#next
+staging		git	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.=
git#staging-next
+counter-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter=
.git#counter-next
+mux		git	https://gitlab.com/peda-linux/mux.git#for-next
+dmaengine	git	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengin=
e.git#next
+cgroup		git	git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git#fo=
r-next
+scsi		git	git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git#for-=
next
+scsi-mkp	git	git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git#fo=
r-next
+vhost		git	git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git#lin=
ux-next
+rpmsg		git	git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.=
git#for-next
+gpio		git	git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.=
git#for-next
+gpio-brgl	git	git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git=
#gpio/for-next
+gpio-intel	git	git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gp=
io-intel.git#for-next
+gpio-sim	git	git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git#=
gpio/gpio-sim
+pinctrl		git	git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pi=
nctrl.git#for-next
+pinctrl-intel	git	git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/in=
tel.git#for-next
+pinctrl-renesas	git	git://git.kernel.org/pub/scm/linux/kernel/git/geert/re=
nesas-drivers.git#renesas-pinctrl
+pinctrl-samsung	git	git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/=
samsung.git#for-next
+pwm		git	git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linu=
x-pwm.git#for-next
+userns		git	git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-na=
mespace.git#for-next
+ktest		git	git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-kte=
st.git#for-next
+kselftest	git	git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-ks=
elftest.git#next
+livepatching	git	git://git.kernel.org/pub/scm/linux/kernel/git/livepatchin=
g/livepatching#for-next
+rtc		git	git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git#=
rtc-next
+nvdimm		git	git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.gi=
t#libnvdimm-for-next
+at24		git	git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git#at2=
4/for-next
+ntb		git	https://github.com/jonmason/ntb.git#ntb-next
+seccomp		git	git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git#=
for-next/seccomp
+cisco		git	https://github.com/daniel-walker/cisco-linux.git#for-next
+fsi		git	git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git#next
+slimbus		git	git://git.kernel.org/pub/scm/linux/kernel/git/srini/slimbus.g=
it#for-next
+nvmem		git	git://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git#f=
or-next
+xarray		git	git://git.infradead.org/users/willy/xarray.git#main
+hyperv		git	git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git=
#hyperv-next
+auxdisplay	git	https://github.com/ojeda/linux.git#auxdisplay
+kgdb		git	git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git#=
kgdb/for-next
+hmm		git	git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git#hmm
+kunit		git	git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kself=
test.git#test
+cfi		git	git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git#cfi/n=
ext
+kunit-next	git	git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-k=
selftest.git#kunit
+trivial		git	git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.g=
it#for-next
+mhi		git	git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git#mhi-ne=
xt
+memblock	git	git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.g=
it#for-next
+init		git	git://git.infradead.org/users/hch/misc.git#init-user-pointers
+cxl		git	git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git#next
+folio-iomap	git	git://git.infradead.org/users/willy/linux.git#folio-iomap
+zstd		git	https://github.com/terrelln/linux.git#zstd-next
+efi		git	git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git#next
+unicode		git	git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode=
.git#for-next
+slab		git	git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git#fo=
r-next
+random		git	git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git#=
master
+landlock	git	git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git#n=
ext
+rust		git	https://github.com/Rust-for-Linux/linux.git#rust-next
+sysctl		git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git=
#sysctl-next
+folio		git	git://git.infradead.org/users/willy/pagecache.git#for-next
+execve		git	git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git#f=
or-next/execve
+bitmap		git	https://github.com/norov/linux.git#bitmap-for-next
+hte		git	git://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linu=
x.git#for-next
+kspp		git	git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git#for=
-next/kspp
+kspp-gustavo	git	git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/=
linux.git#for-next/kspp
+unsigned-char	git	git://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linu=
x.git#unsigned-char
+iommufd		git	git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git=
#for-next
+mm-stable	git	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm#mm-sta=
ble
+mm-nonmm-stable	git	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm#=
mm-nonmm-stable
+mm		git	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm#mm-everything
diff --git a/Next/merge.log b/Next/merge.log
new file mode 100644
index 000000000000..bf6176c7033b
--- /dev/null
+++ b/Next/merge.log
@@ -0,0 +1,8938 @@
+$ date -R
+Wed, 09 Nov 2022 08:30:27 +1100
+$ git checkout master
+Already on 'master'
+$ git reset --hard stable
+Updating files:  85% (4690/5482)=0DUpdating files:  86% (4715/5482)=0DUpda=
ting files:  87% (4770/5482)=0DUpdating files:  88% (4825/5482)=0DUpdating =
files:  89% (4879/5482)=0DUpdating files:  90% (4934/5482)=0DUpdating files=
:  91% (4989/5482)=0DUpdating files:  92% (5044/5482)=0DUpdating files:  93=
% (5099/5482)=0DUpdating files:  94% (5154/5482)=0DUpdating files:  95% (52=
08/5482)=0DUpdating files:  96% (5263/5482)=0DUpdating files:  97% (5318/54=
82)=0DUpdating files:  98% (5373/5482)=0DUpdating files:  99% (5428/5482)=
=0DUpdating files: 100% (5482/5482)=0DUpdating files: 100% (5482/5482), don=
e.
+HEAD is now at a1de832bd324 Merge tag 'platform-drivers-x86-v6.1-3' of git=
://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
+Merging origin/master (f141df371335 Merge tag 'audit-pr-20221107' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/torvalds/linux.git origin/master
+Updating a1de832bd324..f141df371335
+Fast-forward (no commit created; -m option ignored)
+ fs/userfaultfd.c                | 3 +++
+ include/uapi/linux/audit.h      | 2 +-
+ include/uapi/linux/capability.h | 2 +-
+ 3 files changed, 5 insertions(+), 2 deletions(-)
+Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git:/=
/anongit.freedesktop.org/drm/drm)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/sfr/next-fixes.git fixes/fixes
+Already up to date.
+Merging mm-hotfixes/mm-hotfixes-unstable (5e4e46814fed docs: kmsan: fix fo=
rmatting of "Example report")
+$ git merge -m Merge branch 'mm-hotfixes-unstable' of git://git.kernel.org=
/pub/scm/linux/kernel/git/akpm/mm mm-hotfixes/mm-hotfixes-unstable
+Merge made by the 'ort' strategy.
+ Documentation/dev-tools/kmsan.rst             |     1 +
+ arch/x86/kernel/traps.c                       |     7 +
+ arch/x86/lib/usercopy.c                       |     3 +
+ arch/x86/mm/hugetlbpage.c                     |     4 +
+ fs/btrfs/compression.c                        |    14 +-
+ fs/erofs/zdata.c                              |    18 +-
+ fs/hugetlbfs/inode.c                          |    13 +-
+ fs/nilfs2/segment.c                           |    15 +-
+ fs/nilfs2/super.c                             |     2 -
+ fs/nilfs2/the_nilfs.c                         |     2 -
+ include/linux/gfp.h                           |     2 -
+ include/linux/maple_tree.h                    |     7 +
+ include/linux/mm.h                            |     3 +
+ lib/Kconfig.debug                             |     6 +-
+ lib/Kconfig.kmsan                             |     1 +
+ lib/Makefile                                  |     1 +
+ lib/maple_tree.c                              |    58 +-
+ lib/test_maple_tree.c                         | 37926 +------------------=
-----
+ mm/compaction.c                               |    18 +-
+ mm/damon/dbgfs.c                              |     7 +
+ mm/huge_memory.c                              |     9 +-
+ mm/hugetlb.c                                  |    49 +-
+ mm/hugetlb_vmemmap.c                          |     1 +
+ mm/kmsan/kmsan.h                              |     2 +
+ mm/memory-failure.c                           |     5 +-
+ mm/memory.c                                   |    21 +-
+ mm/memremap.c                                 |     1 +
+ mm/mmap.c                                     |     6 +-
+ mm/userfaultfd.c                              |     2 +-
+ tools/testing/radix-tree/.gitignore           |     1 +
+ tools/testing/radix-tree/Makefile             |    19 +-
+ tools/testing/radix-tree/generated/autoconf.h |     2 +-
+ tools/testing/radix-tree/linux.c              |     4 +
+ tools/testing/radix-tree/maple.c              | 35770 +++++++++++++++++++=
+++
+ 34 files changed, 37168 insertions(+), 36832 deletions(-)
+Merging kbuild-current/fixes (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/masahiroy/linux-kbuild.git kbuild-current/fixes
+Already up to date.
+Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
+$ git merge -m Merge branch 'for-curr' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/vgupta/arc.git arc-current/for-curr
+Already up to date.
+Merging arm-current/fixes (340a982825f7 ARM: 9266/1: mm: fix no-MMU ZERO_P=
AGE() implementation)
+$ git merge -m Merge branch 'fixes' of git://git.armlinux.org.uk/~rmk/linu=
x-arm.git arm-current/fixes
+Merge made by the 'ort' strategy.
+ arch/arm/include/asm/perf_event.h    |  2 +-
+ arch/arm/include/asm/pgtable-nommu.h |  6 ------
+ arch/arm/include/asm/pgtable.h       | 16 +++++++++-------
+ arch/arm/mm/nommu.c                  | 19 +++++++++++++++++++
+ 4 files changed, 29 insertions(+), 14 deletions(-)
+Merging arm64-fixes/for-next/fixes (2081b3bd0c11 arm64: fix rodata=3Dfull =
again)
+$ git merge -m Merge branch 'for-next/fixes' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/arm64/linux arm64-fixes/for-next/fixes
+Merge made by the 'ort' strategy.
+ arch/arm64/mm/pageattr.c | 5 +++--
+ 1 file changed, 3 insertions(+), 2 deletions(-)
+Merging arm-soc-fixes/arm/fixes (5449cabd95bb Merge tag 'juno-fix-6.1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/f=
ixes)
+$ git merge -m Merge branch 'arm/fixes' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/soc/soc.git arm-soc-fixes/arm/fixes
+Already up to date.
+Merging davinci-current/davinci/for-current (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'davinci/for-current' of git://git.kernel.org/=
pub/scm/linux/kernel/git/brgl/linux.git davinci-current/davinci/for-current
+Already up to date.
+Merging drivers-memory-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'fixes' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux-mem-ctrl.git drivers-memory-fixes/fixes
+Already up to date.
+Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_fo=
r_v5.18' into fixes)
+$ git merge -m Merge branch 'fixes' of https://git.linaro.org/people/jens.=
wiklander/linux-tee.git tee-fixes/fixes
+Merge made by the 'ort' strategy.
+Merging m68k-current/for-linus (dc63a086daee m68k: Rework BI_VIRT_RNG_SEED=
 as BI_RNG_SEED)
+$ git merge -m Merge branch 'for-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/geert/linux-m68k.git m68k-current/for-linus
+Already up to date.
+Merging powerpc-fixes/fixes (02a771c9a68a powerpc/32: Select ARCH_SPLIT_AR=
G64)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/powerpc/linux.git powerpc-fixes/fixes
+Already up to date.
+Merging s390-fixes/fixes (80ddf5ce1c92 s390: always build relocatable kern=
el)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/s390/linux.git s390-fixes/fixes
+Merge made by the 'ort' strategy.
+ arch/s390/Kconfig                     |  6 ++--
+ arch/s390/Makefile                    |  2 --
+ arch/s390/boot/Makefile               |  3 +-
+ arch/s390/boot/startup.c              |  3 +-
+ arch/s390/configs/btf.config          |  1 +
+ arch/s390/configs/debug_defconfig     | 65 +++++++++++++++++-------------=
---
+ arch/s390/configs/defconfig           | 67 +++++++++++++++++-------------=
-----
+ arch/s390/configs/kasan.config        |  3 ++
+ arch/s390/configs/zfcpdump_defconfig  |  1 -
+ drivers/s390/crypto/zcrypt_msgtype6.c | 21 +++++++----
+ 10 files changed, 89 insertions(+), 83 deletions(-)
+ create mode 100644 arch/s390/configs/btf.config
+ create mode 100644 arch/s390/configs/kasan.config
+Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/davem/sparc.git sparc/master
+Auto-merging arch/sparc/mm/srmmu.c
+Merge made by the 'ort' strategy.
+Merging fscrypt-current/for-stable (ccd30a476f8e fscrypt: fix keyring memo=
ry leak on mount failure)
+$ git merge -m Merge branch 'for-stable' of git://git.kernel.org/pub/scm/f=
s/fscrypt/fscrypt.git fscrypt-current/for-stable
+Already up to date.
+Merging net/master (ce9e57feeed8 drivers: net: xgene: disable napi when re=
gister irq failed in xgene_enet_open())
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/netdev/net.git net/master
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/net/engleder,tsnep.yaml    |   2 +-
+ drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |   4 +-
+ drivers/net/ethernet/broadcom/Kconfig              |   2 +-
+ drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  54 +++++++--
+ drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   1 +
+ drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   2 +-
+ drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c     |   3 +-
+ drivers/net/ethernet/freescale/fman/mac.c          |   9 ++
+ .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   8 +-
+ drivers/net/ethernet/marvell/octeontx2/Kconfig     |   2 +
+ .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   1 +
+ .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 135 ++++++++++++++++=
-----
+ .../ethernet/marvell/octeontx2/nic/otx2_struct.h   |  57 +++++++++
+ .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  32 +++--
+ .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |   1 +
+ drivers/net/ethernet/mediatek/mtk_star_emac.c      |   2 +
+ .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |   8 +-
+ drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   2 +-
+ drivers/net/hamradio/bpqether.c                    |   2 +-
+ drivers/net/macsec.c                               |  50 +++-----
+ drivers/net/tun.c                                  |   1 +
+ drivers/net/wan/lapbether.c                        |   3 +-
+ drivers/net/wireless/ath/ath11k/qmi.h              |   2 +-
+ drivers/net/wireless/ath/ath11k/reg.c              |   6 +-
+ .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |   4 +
+ drivers/net/wireless/cisco/airo.c                  |  18 ++-
+ drivers/net/wireless/mac80211_hwsim.c              |   5 +
+ drivers/net/wireless/ralink/rt2x00/rt2400pci.c     |   8 +-
+ drivers/net/wireless/ralink/rt2x00/rt2400pci.h     |   2 +-
+ drivers/net/wireless/ralink/rt2x00/rt2500pci.c     |   8 +-
+ drivers/net/wireless/ralink/rt2x00/rt2500pci.h     |   2 +-
+ drivers/net/wireless/ralink/rt2x00/rt2500usb.c     |   8 +-
+ drivers/net/wireless/ralink/rt2x00/rt2500usb.h     |   2 +-
+ drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |  60 ++++-----
+ drivers/net/wireless/ralink/rt2x00/rt2800lib.h     |   8 +-
+ drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |   6 +-
+ drivers/net/wireless/ralink/rt2x00/rt61pci.c       |   4 +-
+ drivers/net/wireless/ralink/rt2x00/rt61pci.h       |   2 +-
+ drivers/net/wireless/ralink/rt2x00/rt73usb.c       |   4 +-
+ drivers/net/wireless/ralink/rt2x00/rt73usb.h       |   2 +-
+ drivers/net/wwan/iosm/iosm_ipc_wwan.c              |  43 ++-----
+ drivers/net/wwan/mhi_wwan_mbim.c                   |   1 +
+ include/linux/skmsg.h                              |   2 +-
+ include/uapi/linux/in.h                            |   1 +
+ kernel/bpf/verifier.c                              |  17 ++-
+ net/core/skbuff.c                                  |  36 +++---
+ net/core/skmsg.c                                   |   7 +-
+ net/core/sock_map.c                                |   7 +-
+ net/ipv4/tcp.c                                     |   2 +-
+ net/ipv4/tcp_bpf.c                                 |   8 +-
+ net/ipv6/addrlabel.c                               |   1 +
+ net/mac80211/main.c                                |   8 +-
+ net/mac80211/mesh_pathtbl.c                        |   2 +-
+ net/mac80211/s1g.c                                 |   3 +
+ net/mac80211/tx.c                                  |   5 +
+ net/sctp/outqueue.c                                |  13 +-
+ net/tipc/netlink_compat.c                          |   2 +-
+ net/wireless/reg.c                                 |  12 +-
+ net/wireless/scan.c                                |   4 +-
+ net/wireless/util.c                                |   6 +-
+ tools/bpf/bpftool/common.c                         |   3 +
+ tools/include/uapi/linux/in.h                      |   1 +
+ tools/include/uapi/linux/stddef.h                  |  47 +++++++
+ .../testing/selftests/bpf/verifier/ref_tracking.c  |  36 ++++++
+ tools/testing/selftests/net/udpgro.sh              |   4 +-
+ tools/testing/selftests/net/udpgro_bench.sh        |   2 +-
+ tools/testing/selftests/net/udpgro_frglist.sh      |   2 +-
+ 67 files changed, 549 insertions(+), 258 deletions(-)
+ create mode 100644 tools/include/uapi/linux/stddef.h
+Merging bpf/master (eb86559a691c bpf: Fix memory leaks in __check_func_cal=
l)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/bpf/bpf.git bpf/master
+Merge made by the 'ort' strategy.
+ arch/x86/net/bpf_jit_comp.c | 13 -----------
+ include/linux/bpf.h         | 56 ++++++++++++++++++++++++++++++----------=
-----
+ kernel/bpf/dispatcher.c     | 28 +++++++----------------
+ kernel/bpf/verifier.c       | 14 ++++++++----
+ net/bpf/test_run.c          |  1 +
+ 5 files changed, 55 insertions(+), 57 deletions(-)
+Merging ipsec/master (7f57f8165cb6 af_key: Fix send_acquire race with pfke=
y_register)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/klassert/ipsec.git ipsec/master
+Merge made by the 'ort' strategy.
+ net/core/lwtunnel.c     |  4 +++-
+ net/ipv4/esp4_offload.c |  3 +++
+ net/ipv4/ip_input.c     |  5 +++++
+ net/ipv6/esp6_offload.c |  3 +++
+ net/key/af_key.c        | 32 ++++++++++++++++++++++----------
+ net/xfrm/xfrm_device.c  | 15 ++++++++++++++-
+ net/xfrm/xfrm_replay.c  |  2 +-
+ 7 files changed, 51 insertions(+), 13 deletions(-)
+Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/pablo/nf.git netfilter/master
+Already up to date.
+Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://=
git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/horms/ipvs.git ipvs/master
+Already up to date.
+Merging wireless/for-next (91018bbcc664 Merge tag 'wireless-2022-11-03' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/wireless/wireless.git wireless/for-next
+Already up to date.
+Merging rdma-fixes/for-rc (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'for-rc' of git://git.kernel.org/pub/scm/linux=
/kernel/git/rdma/rdma.git rdma-fixes/for-rc
+Already up to date.
+Merging sound-current/for-linus (2f01a612d475 ALSA: usb-audio: Add quirk e=
ntry for M-Audio Micro)
+$ git merge -m Merge branch 'for-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/tiwai/sound.git sound-current/for-linus
+Merge made by the 'ort' strategy.
+ sound/arm/pxa2xx-ac97-lib.c   |  4 +++-
+ sound/pci/hda/hda_intel.c     | 11 +++++++----
+ sound/pci/hda/patch_ca0132.c  |  1 +
+ sound/pci/hda/patch_realtek.c |  1 +
+ sound/usb/card.c              | 29 +++++++++++++++++++---------
+ sound/usb/quirks-table.h      |  4 ++++
+ sound/usb/quirks.c            | 44 +++-----------------------------------=
-----
+ 7 files changed, 39 insertions(+), 55 deletions(-)
+Merging sound-asoc-fixes/for-linus (89cdb224f2ab ASoC: sof_es8336: reduce =
pop noise on speaker)
+$ git merge -m Merge branch 'for-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/broonie/sound.git sound-asoc-fixes/for-linus
+Auto-merging .mailmap
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ .mailmap                                           |  1 +
+ .../bindings/sound/google,cros-ec-codec.yaml       |  2 +-
+ .../devicetree/bindings/sound/realtek,rt1015p.yaml |  2 +-
+ MAINTAINERS                                        |  2 +-
+ include/sound/sof/info.h                           |  4 ++
+ sound/hda/intel-dsp-config.c                       |  5 ++
+ sound/soc/amd/yc/acp6x-mach.c                      |  7 +++
+ sound/soc/codecs/rt5514-spi.c                      | 15 +++---
+ sound/soc/codecs/rt5677-spi.c                      | 19 +++----
+ sound/soc/codecs/tas2764.c                         | 19 +++----
+ sound/soc/codecs/tas2770.c                         | 20 +++-----
+ sound/soc/codecs/tas2780.c                         | 19 +++----
+ sound/soc/fsl/fsl_asrc.c                           |  2 +-
+ sound/soc/fsl/fsl_esai.c                           |  2 +-
+ sound/soc/fsl/fsl_sai.c                            |  2 +-
+ sound/soc/intel/boards/bytcht_es8316.c             |  7 +++
+ sound/soc/intel/boards/sof_es8336.c                | 60 +++++++++++++++++=
-----
+ sound/soc/intel/common/soc-acpi-intel-icl-match.c  | 13 +++++
+ sound/soc/soc-core.c                               | 17 +++++-
+ sound/soc/soc-dapm.c                               |  2 +-
+ sound/soc/soc-utils.c                              |  2 +-
+ sound/soc/sof/ipc3-topology.c                      | 15 ++++--
+ sound/soc/sof/topology.c                           | 20 ++++----
+ 23 files changed, 162 insertions(+), 95 deletions(-)
+Merging regmap-fixes/for-linus (157209ecce2b Merge remote-tracking branch =
'regmap/for-6.0' into regmap-linus)
+$ git merge -m Merge branch 'for-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/broonie/regmap.git regmap-fixes/for-linus
+Merge made by the 'ort' strategy.
+Merging regulator-fixes/for-linus (6555bf0ad524 Merge remote-tracking bran=
ch 'regulator/for-6.0' into regulator-linus)
+$ git merge -m Merge branch 'for-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/broonie/regulator.git regulator-fixes/for-linus
+Auto-merging Documentation/devicetree/bindings/regulator/qcom,spmi-regulat=
or.yaml
+Auto-merging MAINTAINERS
+Auto-merging drivers/regulator/core.c
+Merge made by the 'ort' strategy.
+Merging spi-fixes/for-linus (d1a0c45245aa Merge remote-tracking branch 'sp=
i/for-6.0' into spi-linus)
+$ git merge -m Merge branch 'for-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/broonie/spi.git spi-fixes/for-linus
+Auto-merging MAINTAINERS
+Auto-merging MAINTAINERS
+Auto-merging drivers/spi/spi-cadence-quadspi.c
+Auto-merging drivers/spi/spi.c
+Auto-merging include/linux/spi/spi.h
+Merge made by the 'ort' strategy.
+ MAINTAINERS                     |  2 +-
+ drivers/spi/spi-amd.c           |  2 +-
+ drivers/spi/spi-intel.c         |  8 ++++----
+ drivers/spi/spi-meson-spicc.c   | 24 ++++++++++++++++++++++--
+ drivers/spi/spi-mt65xx.c        | 23 +++++++++++++----------
+ drivers/spi/spi-stm32.c         |  3 ++-
+ drivers/spi/spi-tegra210-quad.c |  6 ++++++
+ 7 files changed, 49 insertions(+), 19 deletions(-)
+Merging pci-current/for-linus (39a654f39efb MAINTAINERS: Add Manivannan Sa=
dhasivam as Qcom PCIe RC maintainer)
+$ git merge -m Merge branch 'for-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/helgaas/pci.git pci-current/for-linus
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+Merging driver-core.current/driver-core-linus (54de93cd8740 kernel/utsname=
_sysctl.c: Add missing enum uts_proc value)
+$ git merge -m Merge branch 'driver-core-linus' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/gregkh/driver-core.git driver-core.current/driver-co=
re-linus
+Merge made by the 'ort' strategy.
+Merging tty.current/tty-linus (7b7dfe4833c7 tty: n_gsm: fix sleep-in-atomi=
c-context bug in gsm_control_send)
+$ git merge -m Merge branch 'tty-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/gregkh/tty.git tty.current/tty-linus
+Merge made by the 'ort' strategy.
+ drivers/tty/n_gsm.c                 | 71 ++++++++++++++++++--------------=
--
+ drivers/tty/serial/8250/8250_omap.c | 52 ++++++++++++++-----------
+ drivers/tty/serial/fsl_lpuart.c     | 76 ++++++++++++++++++++++++--------=
-----
+ drivers/tty/serial/imx.c            |  1 +
+ 4 files changed, 118 insertions(+), 82 deletions(-)
+Merging usb.current/usb-linus (d68cc25b7c7f usb: dwc3: Do not get extcon d=
evice when usb-role-switch is used)
+$ git merge -m Merge branch 'usb-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/gregkh/usb.git usb.current/usb-linus
+Merge made by the 'ort' strategy.
+ drivers/extcon/extcon-usbc-tusb320.c  |  8 +++++++-
+ drivers/usb/dwc3/core.c               | 10 ++++++++++
+ drivers/usb/dwc3/gadget.c             |  2 +-
+ drivers/usb/dwc3/host.c               | 10 ----------
+ drivers/usb/host/bcma-hcd.c           | 10 ++++++----
+ drivers/usb/typec/mux/intel_pmc_mux.c | 15 +++++++++++++--
+ drivers/usb/typec/tipd/core.c         |  6 +++---
+ 7 files changed, 40 insertions(+), 21 deletions(-)
+Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/balbi/usb.git usb-gadget-fixes/fixes
+Already up to date.
+Merging usb-serial-fixes/usb-linus (df3414b0a245 USB: serial: option: add =
Sierra Wireless EM9191)
+$ git merge -m Merge branch 'usb-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/johan/usb-serial.git usb-serial-fixes/usb-linus
+Merge made by the 'ort' strategy.
+ drivers/usb/serial/option.c | 5 +++++
+ 1 file changed, 5 insertions(+)
+Merging phy/fixes (819b885cd886 phy: ralink: mt7621-pci: add sentinel to q=
uirks table)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/phy/linux-phy.git phy/fixes
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS                               |  2 +-
+ drivers/phy/qualcomm/phy-qcom-qmp-combo.c |  2 +-
+ drivers/phy/ralink/phy-mt7621-pci.c       |  3 ++-
+ drivers/phy/st/phy-stm32-usbphyc.c        |  2 ++
+ drivers/phy/sunplus/phy-sunplus-usb2.c    |  4 ++--
+ drivers/phy/tegra/xusb.c                  | 20 ++++++++++++++++----
+ 6 files changed, 24 insertions(+), 9 deletions(-)
+Merging staging.current/staging-linus (937ec9f7d5f2 staging: rtl8192e: rem=
ove bogus ssid character sign test)
+$ git merge -m Merge branch 'staging-linus' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/gregkh/staging.git staging.current/staging-linus
+Merge made by the 'ort' strategy.
+ drivers/staging/rtl8192e/rtllib_softmac_wx.c | 9 +--------
+ 1 file changed, 1 insertion(+), 8 deletions(-)
+Merging iio-fixes/fixes-togreg (0aa60ff5d996 iio: light: apds9960: fix wro=
ng register for gesture gain)
+$ git merge -m Merge branch 'fixes-togreg' of git://git.kernel.org/pub/scm=
/linux/kernel/git/jic23/iio.git iio-fixes/fixes-togreg
+Merge made by the 'ort' strategy.
+ drivers/iio/accel/bma400_core.c      | 24 ++++++++---------
+ drivers/iio/adc/at91-sama5d2_adc.c   |  6 ++---
+ drivers/iio/adc/at91_adc.c           |  4 ++-
+ drivers/iio/adc/mp2629_adc.c         |  5 ++--
+ drivers/iio/imu/bno055/bno055.c      |  2 +-
+ drivers/iio/light/apds9960.c         | 12 ++++-----
+ drivers/iio/pressure/ms5611.h        | 12 +++------
+ drivers/iio/pressure/ms5611_core.c   | 51 +++++++++++++++++++------------=
-----
+ drivers/iio/pressure/ms5611_spi.c    |  2 +-
+ drivers/iio/trigger/iio-trig-sysfs.c |  6 ++++-
+ tools/iio/iio_generic_buffer.c       |  4 +--
+ 11 files changed, 66 insertions(+), 62 deletions(-)
+Merging counter-current/counter-current (30a0b95b1335 Linux 6.1-rc3)
+$ git merge -m Merge branch 'counter-current' of git://git.kernel.org/pub/=
scm/linux/kernel/git/wbg/counter.git counter-current/counter-current
+Already up to date.
+Merging char-misc.current/char-misc-linus (38e9f21f648e Merge tag 'iio-fix=
es-for-6.1b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio i=
nto char-misc-linus)
+$ git merge -m Merge branch 'char-misc-linus' of git://git.kernel.org/pub/=
scm/linux/kernel/git/gregkh/char-misc.git char-misc.current/char-misc-linus
+Already up to date.
+Merging soundwire-fixes/fixes (49a467310dc4 soundwire: qcom: check for out=
anding writes before doing a read)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/vkoul/soundwire.git soundwire-fixes/fixes
+Merge made by the 'ort' strategy.
+ drivers/soundwire/intel.c | 1 +
+ drivers/soundwire/qcom.c  | 9 +++++++++
+ 2 files changed, 10 insertions(+)
+Merging thunderbolt-fixes/fixes (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/westeri/thunderbolt.git thunderbolt-fixes/fixes
+Already up to date.
+Merging input-current/for-linus (26c263bf1847 Input: i8042 - apply probe d=
efer to more ASUS ZenBook models)
+$ git merge -m Merge branch 'for-linus' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/dtor/input.git input-current/for-linus
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/input/goodix,gt7375p.yaml          |  5 ++++-
+ drivers/input/joystick/iforce/iforce-main.c                |  8 ++++----
+ drivers/input/misc/soc_button_array.c                      | 14 +++++++++=
++++-
+ drivers/input/mouse/synaptics.c                            |  1 +
+ drivers/input/serio/i8042-acpipnpio.h                      |  8 ++++----
+ drivers/input/touchscreen/goodix.c                         | 11 +++++++++=
++
+ 6 files changed, 37 insertions(+), 10 deletions(-)
+Merging crypto-current/master (9f6035af06b5 crypto: x86/polyval - Fix cras=
hes when keys are not 16-byte aligned)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/herbert/crypto-2.6.git crypto-current/master
+Already up to date.
+Merging vfio-fixes/for-linus (873aefb376bb vfio/type1: Unpin zero pages)
+$ git merge -m Merge branch 'for-linus' of git://github.com/awilliam/linux=
-vfio.git vfio-fixes/for-linus
+Already up to date.
+Merging kselftest-fixes/fixes (89c1017aac67 selftests/pidfd_test: Remove t=
he erroneous ',')
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/shuah/linux-kselftest.git kselftest-fixes/fixes
+Already up to date.
+Merging modules-fixes/modules-linus (77d6354bd422 module/decompress: gener=
ate sysfs string at compile time)
+$ git merge -m Merge branch 'modules-linus' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/mcgrof/linux.git modules-fixes/modules-linus
+Already up to date.
+Merging dmaengine-fixes/fixes (c47e6403fa09 dmaengine: at_hdmac: Check ret=
urn code of dma_async_device_register)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/vkoul/dmaengine.git dmaengine-fixes/fixes
+Merge made by the 'ort' strategy.
+ drivers/dma/apple-admac.c     |   2 +-
+ drivers/dma/at_hdmac.c        | 153 +++++++++++++++++--------------------=
-----
+ drivers/dma/at_hdmac_regs.h   |  10 +--
+ drivers/dma/idxd/cdev.c       |  18 +++++
+ drivers/dma/idxd/device.c     |  26 ++++---
+ drivers/dma/idxd/idxd.h       |  32 +++++++++
+ drivers/dma/idxd/init.c       |   4 +-
+ drivers/dma/idxd/sysfs.c      |   2 +-
+ drivers/dma/mv_xor_v2.c       |   1 +
+ drivers/dma/pxa_dma.c         |   4 +-
+ drivers/dma/stm32-dma.c       |  14 ++--
+ drivers/dma/stm32-mdma.c      |   1 +
+ drivers/dma/ti/k3-udma-glue.c |   3 +
+ include/uapi/linux/idxd.h     |   1 +
+ 14 files changed, 150 insertions(+), 121 deletions(-)
+Merging backlight-fixes/for-backlight-fixes (6dfad94814c7 dt-bindings: bac=
klight: qcom-wled: Add PMI8950 compatible)
+$ git merge -m Merge branch 'for-backlight-fixes' of git://git.kernel.org/=
pub/scm/linux/kernel/git/lee/backlight.git backlight-fixes/for-backlight-fi=
xes
+Merge made by the 'ort' strategy.
+ Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml | 1 +
+ drivers/video/backlight/ktd253-backlight.c                      | 9 +++--=
----
+ 2 files changed, 4 insertions(+), 6 deletions(-)
+Merging mtd-fixes/mtd/fixes (c717b9b7d6de mtd: onenand: omap2: add depende=
ncy on GPMC)
+$ git merge -m Merge branch 'mtd/fixes' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/mtd/linux.git mtd-fixes/mtd/fixes
+Merge made by the 'ort' strategy.
+ drivers/mtd/nand/onenand/Kconfig  |  1 +
+ drivers/mtd/nand/raw/nand_base.c  |  4 ++--
+ drivers/mtd/nand/raw/qcom_nandc.c | 12 +++++++-----
+ 3 files changed, 10 insertions(+), 7 deletions(-)
+Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: R=
evert "Constify static struct resources")
+$ git merge -m Merge branch 'for-mfd-fixes' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/lee/mfd.git mfd-fixes/for-mfd-fixes
+Already up to date.
+Merging v4l-dvb-fixes/fixes (de547896aac6 media: vivid.rst: loop_video is =
set on the capture devnode)
+$ git merge -m Merge branch 'fixes' of git://linuxtv.org/mchehab/media-nex=
t.git v4l-dvb-fixes/fixes
+Already up to date.
+Merging reset-fixes/reset/fixes (ae358d71d462 reset: npcm: fix iprst2 and =
iprst4 setting)
+$ git merge -m Merge branch 'reset/fixes' of https://git.pengutronix.de/gi=
t/pza/linux reset-fixes/reset/fixes
+Already up to date.
+Merging mips-fixes/mips-fixes (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'mips-fixes' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/mips/linux.git mips-fixes/mips-fixes
+Already up to date.
+Merging at91-fixes/at91-fixes (cef8cdc0d0e7 ARM: at91: pm: avoid soft rese=
tting AC DLL)
+$ git merge -m Merge branch 'at91-fixes' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/at91/linux.git at91-fixes/at91-fixes
+Merge made by the 'ort' strategy.
+ arch/arm/boot/dts/lan966x-pcb8291.dts | 20 ++++++++++++++++++++
+ arch/arm/boot/dts/sama7g5-pinfunc.h   |  2 +-
+ arch/arm/mach-at91/pm_suspend.S       |  7 ++++++-
+ include/soc/at91/sama7-ddr.h          |  5 ++++-
+ 4 files changed, 31 insertions(+), 3 deletions(-)
+Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixe=
s)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/tmlind/linux-omap.git omap-fixes/fixes
+Already up to date.
+Merging kvm-fixes/master (f4298cac2bfc Merge tag 'kvmarm-fixes-6.1-3' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/virt/=
kvm/kvm.git kvm-fixes/master
+Already up to date.
+Merging kvms390-fixes/master (b6662e377727 KVM: s390: pci: Fix allocation =
size of aift kzdev elements)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/kvms390/linux.git kvms390-fixes/master
+Merge made by the 'ort' strategy.
+ Documentation/virt/kvm/devices/vm.rst |  3 +++
+ arch/s390/kvm/kvm-s390.c              | 26 +++++++++++++++++---------
+ arch/s390/kvm/kvm-s390.h              |  1 -
+ arch/s390/kvm/pci.c                   |  2 +-
+ 4 files changed, 21 insertions(+), 11 deletions(-)
+Merging hwmon-fixes/hwmon (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'hwmon' of git://git.kernel.org/pub/scm/linux/=
kernel/git/groeck/linux-staging.git hwmon-fixes/hwmon
+Already up to date.
+Merging nvdimm-fixes/libnvdimm-fixes (b3bbcc5d1da1 Merge branch 'for-6.0/d=
ax' into libnvdimm-fixes)
+$ git merge -m Merge branch 'libnvdimm-fixes' of git://git.kernel.org/pub/=
scm/linux/kernel/git/nvdimm/nvdimm.git nvdimm-fixes/libnvdimm-fixes
+Already up to date.
+Merging cxl-fixes/fixes (8f401ec1c897 cxl/region: Recycle region ids)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/cxl/cxl.git cxl-fixes/fixes
+Already up to date.
+Merging btrfs-fixes/next-fixes (1741255d952d Merge branch 'misc-6.1' into =
next-fixes)
+$ git merge -m Merge branch 'next-fixes' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/kdave/linux.git btrfs-fixes/next-fixes
+Merge made by the 'ort' strategy.
+ fs/btrfs/ctree.c             | 16 ++++++++++++++++
+ fs/btrfs/ctree.h             | 11 +++++++----
+ fs/btrfs/disk-io.c           |  4 +++-
+ fs/btrfs/scrub.c             |  9 +--------
+ fs/btrfs/tests/btrfs-tests.c |  2 +-
+ fs/btrfs/volumes.c           | 39 +++++++++++++++++++++++++++++----------
+ fs/btrfs/volumes.h           |  2 +-
+ fs/btrfs/zoned.c             | 40 ++++++++++++++++++++++++++++++++++++++++
+ fs/btrfs/zoned.h             | 11 +++++++++++
+ 9 files changed, 109 insertions(+), 25 deletions(-)
+Merging vfs-fixes/fixes (7ee47dcfff18 fs: use acquire ordering in __fget_l=
ight())
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/viro/vfs.git vfs-fixes/fixes
+Merge made by the 'ort' strategy.
+ fs/file.c | 11 ++++++++++-
+ 1 file changed, 10 insertions(+), 1 deletion(-)
+Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corr=
ect size for dma_set_encrypted())
+$ git merge -m Merge branch 'for-linus' of git://git.infradead.org/users/h=
ch/dma-mapping.git dma-mapping-fixes/for-linus
+Already up to date.
+Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
+$ git merge -m Merge branch 'i3c/fixes' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/i3c/linux.git i3c-fixes/i3c/fixes
+Already up to date.
+Merging drivers-x86-fixes/fixes (53eb64c88f17 platform/x86: p2sb: Don't fa=
il if unknown CPU is found)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/pdx86/platform-drivers-x86.git drivers-x86-fixes/fixes
+Already up to date.
+Merging samsung-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/krzk/linux.git samsung-krzk-fixes/fixes
+Already up to date.
+Merging pinctrl-samsung-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/pinctrl/samsung.git pinctrl-samsung-fixes/fixes
+Already up to date.
+Merging devicetree-fixes/dt/linus (917c362b5f8a MAINTAINERS: of: collapse =
overlay entry into main device tree entry)
+$ git merge -m Merge branch 'dt/linus' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/robh/linux.git devicetree-fixes/dt/linus
+Already up to date.
+Merging dt-krzk-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/krzk/linux-dt.git dt-krzk-fixes/fixes
+Already up to date.
+Merging scsi-fixes/fixes (ecb8c2580d37 scsi: scsi_debug: Make the READ CAP=
ACITY response compliant with ZBC)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/mkp/scsi.git scsi-fixes/fixes
+Merge made by the 'ort' strategy.
+ drivers/scsi/ibmvscsi/ibmvfc.c    | 14 +++++++++++---
+ drivers/scsi/scsi_debug.c         |  7 +++++++
+ drivers/scsi/scsi_transport_sas.c | 13 +++++++++----
+ 3 files changed, 27 insertions(+), 7 deletions(-)
+Merging drm-fixes/drm-fixes (6295f1d8b450 Merge tag 'drm-intel-fixes-2022-=
11-03' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
+$ git merge -m Merge branch 'drm-fixes' of git://git.freedesktop.org/git/d=
rm/drm.git drm-fixes/drm-fixes
+Already up to date.
+Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc=
_cac() failed issue)
+$ git merge -m Merge branch 'drm-fixes' of git://people.freedesktop.org/~a=
gd5f/linux amdgpu-fixes/drm-fixes
+Already up to date.
+Merging drm-intel-fixes/for-linux-next-fixes (178e31ce82d0 drm/i915/userpt=
r: restore probe_range behaviour)
+$ git merge -m Merge branch 'for-linux-next-fixes' of git://anongit.freede=
sktop.org/drm-intel drm-intel-fixes/for-linux-next-fixes
+Merge made by the 'ort' strategy.
+ drivers/gpu/drm/i915/display/intel_psr.c    | 5 ++++-
+ drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c  | 4 ++--
+ drivers/gpu/drm/i915/gem/i915_gem_shmem.c   | 4 ++--
+ drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 5 +++--
+ 4 files changed, 11 insertions(+), 7 deletions(-)
+Merging mmc-fixes/fixes (162503fd1c3a mmc: sdhci_am654: Fix SDHCI_RESET_AL=
L for CQHCI)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/ulfh/mmc.git mmc-fixes/fixes
+Merge made by the 'ort' strategy.
+ drivers/mmc/host/sdhci-brcmstb.c   |  3 ++-
+ drivers/mmc/host/sdhci-cqhci.h     | 24 ++++++++++++++++++++++++
+ drivers/mmc/host/sdhci-esdhc-imx.c |  3 ++-
+ drivers/mmc/host/sdhci-of-arasan.c |  3 ++-
+ drivers/mmc/host/sdhci-tegra.c     |  3 ++-
+ drivers/mmc/host/sdhci_am654.c     |  7 ++++---
+ 6 files changed, 36 insertions(+), 7 deletions(-)
+ create mode 100644 drivers/mmc/host/sdhci-cqhci.h
+Merging rtc-fixes/rtc-fixes (db4e955ae333 rtc: cmos: fix build on non-ACPI=
 platforms)
+$ git merge -m Merge branch 'rtc-fixes' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/abelloni/linux.git rtc-fixes/rtc-fixes
+Already up to date.
+Merging gnss-fixes/gnss-linus (247f34f7b803 Linux 6.1-rc2)
+$ git merge -m Merge branch 'gnss-linus' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/johan/gnss.git gnss-fixes/gnss-linus
+Already up to date.
+Merging hyperv-fixes/hyperv-fixes (e70af8d040d2 PCI: hv: Fix the definitio=
n of vector in hv_compose_msi_msg())
+$ git merge -m Merge branch 'hyperv-fixes' of git://git.kernel.org/pub/scm=
/linux/kernel/git/hyperv/linux.git hyperv-fixes/hyperv-fixes
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS                         |  1 -
+ arch/x86/hyperv/hv_init.c           | 19 ++++++++++---------
+ drivers/clocksource/hyperv_timer.c  | 29 +++++++++++++++--------------
+ drivers/hv/hv_balloon.c             |  2 +-
+ drivers/pci/controller/pci-hyperv.c | 22 ++++++++++++++++------
+ include/asm-generic/hyperv-tlfs.h   |  9 +++++++++
+ 6 files changed, 51 insertions(+), 31 deletions(-)
+Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
+$ git merge -m Merge branch 'fix' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/leo/linux.git soc-fsl-fixes/fix
+Already up to date.
+Merging risc-v-fixes/fixes (8bc8824d3019 riscv: dts: sifive unleashed: Add=
 PWM controlled LEDs)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/riscv/linux.git risc-v-fixes/fixes
+Merge made by the 'ort' strategy.
+ .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 38 +++++++++++++++++=
+++++
+ 1 file changed, 38 insertions(+)
+Merging risc-v-mc-fixes/dt-fixes (0dec364ffeb6 riscv: dts: microchip: use =
an mpfs specific l2 compatible)
+$ git merge -m Merge branch 'dt-fixes' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/conor/linux.git risc-v-mc-fixes/dt-fixes
+Already up to date.
+Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ra=
nge())
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/brauner/linux.git pidfd-fixes/fixes
+Already up to date.
+Merging fpga-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/fpga/linux-fpga.git fpga-fixes/fixes
+Already up to date.
+Merging spdx/spdx-linus (6cad1ecd4e32 testing: use the copyleft-next-0.3.1=
 SPDX tag)
+$ git merge -m Merge branch 'spdx-linus' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/gregkh/spdx.git spdx/spdx-linus
+Merge made by the 'ort' strategy.
+ LICENSES/dual/copyleft-next-0.3.1        | 236 ++++++++++++++++++++++++++=
+++++
+ lib/test_kmod.c                          |  12 +-
+ lib/test_sysctl.c                        |  12 +-
+ tools/testing/selftests/kmod/kmod.sh     |  13 +-
+ tools/testing/selftests/sysctl/sysctl.sh |  12 +-
+ 5 files changed, 240 insertions(+), 45 deletions(-)
+ create mode 100644 LICENSES/dual/copyleft-next-0.3.1
+Merging gpio-brgl-fixes/gpio/for-current (30a0b95b1335 Linux 6.1-rc3)
+$ git merge -m Merge branch 'gpio/for-current' of git://git.kernel.org/pub=
/scm/linux/kernel/git/brgl/linux.git gpio-brgl-fixes/gpio/for-current
+Already up to date.
+Merging gpio-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/andy/linux-gpio-intel.git gpio-intel-fixes/fixes
+Already up to date.
+Merging pinctrl-intel-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/pinctrl/intel.git pinctrl-intel-fixes/fixes
+Already up to date.
+Merging erofs-fixes/fixes (9473d22fbfca erofs: fix use-after-free of fsid =
and domain_id string)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/xiang/erofs.git erofs-fixes/fixes
+Auto-merging fs/erofs/zdata.c
+Merge made by the 'ort' strategy.
+ fs/erofs/fscache.c  | 25 ++++++++++++++-----------
+ fs/erofs/internal.h |  6 ++++--
+ fs/erofs/super.c    | 39 ++++++++++++++++++++++-----------------
+ fs/erofs/sysfs.c    |  8 ++++----
+ fs/erofs/zdata.c    |  3 +++
+ 5 files changed, 47 insertions(+), 34 deletions(-)
+Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_=
desc())
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/zohar/linux-integrity integrity-fixes/fixes
+Already up to date.
+Merging kunit-fixes/kunit-fixes (618887768bb7 kunit: update NULL vs IS_ERR=
() tests)
+$ git merge -m Merge branch 'kunit-fixes' of git://git.kernel.org/pub/scm/=
linux/kernel/git/shuah/linux-kselftest.git kunit-fixes/kunit-fixes
+Already up to date.
+Merging ubifs-fixes/fixes (c18a80c6861f jffs2: correct logic when creating=
 a hole in jffs2_write_begin)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/rw/ubifs.git ubifs-fixes/fixes
+Merge made by the 'ort' strategy.
+ fs/jffs2/file.c | 15 +++++++--------
+ 1 file changed, 7 insertions(+), 8 deletions(-)
+Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to releas=
e kmalloced memblock regions)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/rppt/memblock.git memblock-fixes/fixes
+Already up to date.
+Merging cel-fixes/for-rc (50256e4793a5 nfsd: put the export reference in n=
fsd4_verify_deleg_dentry)
+$ git merge -m Merge branch 'for-rc' of git://git.kernel.org/pub/scm/linux=
/kernel/git/cel/linux cel-fixes/for-rc
+Auto-merging fs/nfsd/nfs4state.c
+Merge made by the 'ort' strategy.
+ fs/nfsd/filecache.c | 1 +
+ fs/nfsd/nfs4state.c | 1 +
+ 2 files changed, 2 insertions(+)
+Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI =
should depend on ARCH_MXC)
+$ git merge -m Merge branch 'irq/irqchip-fixes' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/maz/arm-platforms.git irqchip-fixes/irq/irqchip-fixes
+Already up to date.
+Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: F=
ix HSCIF0 interrupt number)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/geert/renesas-devel.git renesas-fixes/fixes
+Already up to date.
+Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'fixes' of https://github.com/Broadcom/stblinu=
x.git broadcom-fixes/fixes
+Already up to date.
+Merging perf-current/perf/urgent (5aaef24b5c6d Merge tag 'for-6.1-rc3-tag'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
+$ git merge -m Merge branch 'perf/urgent' of git://git.kernel.org/pub/scm/=
linux/kernel/git/acme/linux.git perf-current/perf/urgent
+Already up to date.
+Merging efi-fixes/urgent (1bf039df2f63 arm64: efi: Fix handling of misalig=
ned runtime regions and drop warning)
+$ git merge -m Merge branch 'urgent' of git://git.kernel.org/pub/scm/linux=
/kernel/git/efi/efi.git efi-fixes/urgent
+Merge made by the 'ort' strategy.
+ arch/arm64/kernel/efi.c | 52 ++++++++++++++++++++++++++++++++------------=
-----
+ 1 file changed, 34 insertions(+), 18 deletions(-)
+Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double wor=
d in comment.)
+$ git merge -m Merge branch 'zstd-linus' of https://github.com/terrelln/li=
nux.git zstd-fixes/zstd-linus
+Merge made by the 'ort' strategy.
+ include/linux/zstd_lib.h | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+Merging battery-fixes/fixes (767e684367e4 power: supply: ab8500: Defer the=
rmal zone probe)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/sre/linux-power-supply.git battery-fixes/fixes
+Merge made by the 'ort' strategy.
+ drivers/power/supply/ab8500_btemp.c  |  9 ++++++++-
+ drivers/power/supply/ip5xxx_power.c  |  2 +-
+ drivers/power/supply/rk817_charger.c | 14 ++++++--------
+ 3 files changed, 15 insertions(+), 10 deletions(-)
+Merging uml-fixes/fixes (bd71558d585a arch: um: Mark the stack non-executa=
ble to fix a binutils warning)
+$ git merge -m Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/=
kernel/git/uml/linux.git uml-fixes/fixes
+Already up to date.
+Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
+$ git merge -m Merge branch 'asahi-soc/fixes' of https://github.com/AsahiL=
inux/linux.git asahi-soc-fixes/asahi-soc/fixes
+Already up to date.
+Merging iommufd-fixes/for-rc (30a0b95b1335 Linux 6.1-rc3)
+$ git merge -m Merge branch 'for-rc' of git://git.kernel.org/pub/scm/linux=
/kernel/git/jgg/iommufd.git iommufd-fixes/for-rc
+Already up to date.
+Merging drm-misc-fixes/for-linux-next-fixes (e0b26b948246 drm/amdgpu: Fix =
the lpfn checking condition in drm buddy)
+$ git merge -m Merge branch 'for-linux-next-fixes' of git://anongit.freede=
sktop.org/drm/drm-misc drm-misc-fixes/for-linux-next-fixes
+Merge made by the 'ort' strategy.
+ drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c   |  2 +-
+ drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 +++++++
+ drivers/gpu/drm/vc4/vc4_drv.c                  |  7 +++-
+ drivers/gpu/drm/vc4/vc4_hdmi.c                 | 47 ++++++++++++++++++++-=
-----
+ drivers/gpu/drm/vc4/vc4_hdmi.h                 |  1 +
+ include/uapi/drm/panfrost_drm.h                |  2 +-
+ 6 files changed, 57 insertions(+), 14 deletions(-)
+Merging kbuild/for-next (2df76606db9d Merge tag 'kbuild-fixes-v6.1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/masahiroy/linux-kbuild.git kbuild/for-next
+Already up to date.
+Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space af=
ter for_each macros)
+$ git merge -m Merge branch 'clang-format' of https://github.com/ojeda/lin=
ux.git clang-format/clang-format
+Already up to date.
+Merging perf/perf/core (96e6d929a6c3 perf trace: Use sig_atomic_t to avoid=
 undefined behaviour in a signal handler)
+$ git merge -m Merge branch 'perf/core' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/acme/linux.git perf/perf/core
+Merge made by the 'ort' strategy.
+ tools/perf/Documentation/perf-annotate.txt         |   2 +-
+ tools/perf/Documentation/perf-diff.txt             |   2 +-
+ tools/perf/Documentation/perf-intel-pt.txt         |  12 +-
+ tools/perf/Documentation/perf-lock.txt             |   2 +-
+ tools/perf/Documentation/perf-probe.txt            |   2 +-
+ tools/perf/Documentation/perf-record.txt           |   2 +-
+ tools/perf/Documentation/perf-report.txt           |   2 +-
+ tools/perf/Documentation/perf-stat.txt             |   4 +-
+ tools/perf/Makefile.config                         |   2 +-
+ tools/perf/arch/arm/util/unwind-libdw.c            |   2 +-
+ tools/perf/arch/arm64/util/machine.c               |   1 +
+ tools/perf/arch/arm64/util/unwind-libdw.c          |   2 +-
+ tools/perf/arch/powerpc/util/event.c               |   1 +
+ tools/perf/arch/powerpc/util/unwind-libdw.c        |   2 +-
+ tools/perf/arch/riscv/util/Build                   |   1 +
+ tools/perf/arch/riscv/util/header.c                | 104 +++++
+ tools/perf/arch/s390/util/unwind-libdw.c           |   1 +
+ tools/perf/arch/x86/tests/sample-parsing.c         |   1 +
+ tools/perf/arch/x86/util/event.c                   |   2 +
+ tools/perf/arch/x86/util/tsc.c                     |   1 +
+ tools/perf/arch/x86/util/unwind-libdw.c            |   2 +-
+ tools/perf/bench/inject-buildid.c                  |   2 +-
+ tools/perf/bench/numa.c                            |   9 +-
+ tools/perf/builtin-annotate.c                      |   2 +-
+ tools/perf/builtin-daemon.c                        |   4 +-
+ tools/perf/builtin-diff.c                          |   2 +-
+ tools/perf/builtin-ftrace.c                        |   4 +-
+ tools/perf/builtin-kwork.c                         |   6 +
+ tools/perf/builtin-lock.c                          |  32 +-
+ tools/perf/builtin-mem.c                           |   1 +
+ tools/perf/builtin-probe.c                         |   7 +-
+ tools/perf/builtin-record.c                        |  10 +-
+ tools/perf/builtin-report.c                        |   2 +-
+ tools/perf/builtin-script.c                        |   4 +-
+ tools/perf/builtin-stat.c                          | 202 ++++++---
+ tools/perf/builtin-top.c                           |   4 +-
+ tools/perf/builtin-trace.c                         |   4 +-
+ tools/perf/pmu-events/arch/riscv/mapfile.csv       |  17 +
+ .../pmu-events/arch/riscv/riscv-sbi-firmware.json  | 134 ++++++
+ .../pmu-events/arch/riscv/sifive/u74/firmware.json |  68 +++
+ .../arch/riscv/sifive/u74/instructions.json        |  92 ++++
+ .../pmu-events/arch/riscv/sifive/u74/memory.json   |  32 ++
+ .../arch/riscv/sifive/u74/microarch.json           |  57 +++
+ tools/perf/scripts/python/intel-pt-events.py       |  65 ++-
+ tools/perf/tests/dlfilter-test.c                   |   1 +
+ tools/perf/tests/mmap-basic.c                      |   2 +
+ tools/perf/tests/openat-syscall-tp-fields.c        |   1 +
+ tools/perf/tests/parse-events.c                    |  13 +
+ tools/perf/tests/parse-metric.c                    |   2 +-
+ tools/perf/tests/parse-no-sample-id-all.c          |   1 +
+ tools/perf/tests/perf-record.c                     |   2 +
+ tools/perf/tests/perf-time-to-tsc.c                |   1 +
+ tools/perf/tests/pmu-events.c                      |   2 +-
+ tools/perf/tests/shell/record.sh                   | 180 +++++++-
+ tools/perf/tests/sw-clock.c                        |   1 +
+ tools/perf/tests/switch-tracking.c                 |   1 +
+ tools/perf/ui/util.c                               |   5 +
+ tools/perf/util/amd-sample-raw.c                   |   1 +
+ .../perf/util/arm64-frame-pointer-unwind-support.h |   6 +-
+ tools/perf/util/auxtrace.c                         |   1 +
+ tools/perf/util/bpf-prologue.h                     |   6 +-
+ tools/perf/util/bpf_kwork.c                        |   3 +
+ tools/perf/util/bpf_lock_contention.c              |  43 +-
+ tools/perf/util/bpf_map.h                          |   3 +-
+ tools/perf/util/branch.h                           |   6 +-
+ tools/perf/util/config.c                           |   4 +-
+ tools/perf/util/counts.c                           |   1 -
+ tools/perf/util/counts.h                           |   1 -
+ tools/perf/util/cpumap.c                           |  16 +-
+ tools/perf/util/cpumap.h                           |   8 +-
+ tools/perf/util/data-convert-bt.c                  |   1 +
+ tools/perf/util/dwarf-aux.c                        |  58 ++-
+ tools/perf/util/dwarf-aux.h                        |   3 +
+ tools/perf/util/event.h                            | 124 +-----
+ tools/perf/util/evlist.c                           |   2 +
+ tools/perf/util/evsel.c                            |  32 +-
+ .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   1 +
+ tools/perf/util/kwork.h                            |  12 +-
+ tools/perf/util/lock-contention.h                  |   2 +-
+ tools/perf/util/machine.h                          |   3 +
+ tools/perf/util/mmap.h                             |   5 -
+ tools/perf/util/parse-events.c                     |   1 +
+ tools/perf/util/perf_regs.c                        |   2 +-
+ tools/perf/util/pmu.c                              |   4 +
+ tools/perf/util/probe-finder.c                     |  37 +-
+ tools/perf/util/s390-cpumsf.c                      |   1 +
+ tools/perf/util/s390-sample-raw.c                  |   1 +
+ tools/perf/util/sample.h                           | 117 ++++++
+ .../util/scripting-engines/trace-event-python.c    |   7 +-
+ tools/perf/util/session.c                          |   3 +-
+ tools/perf/util/stat-display.c                     | 462 ++++------------=
-----
+ tools/perf/util/stat.c                             | 407 +++++++++++++++-=
--
+ tools/perf/util/stat.h                             |  41 +-
+ tools/perf/util/symbol.h                           |   2 +
+ tools/perf/util/thread.h                           |   3 +
+ tools/perf/util/trace-event-scripting.c            |   2 +-
+ 96 files changed, 1745 insertions(+), 809 deletions(-)
+ create mode 100644 tools/perf/arch/riscv/util/header.c
+ create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
+ create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.js=
on
+ create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.j=
son
+ create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructio=
ns.json
+ create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
+ create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.=
json
+ create mode 100644 tools/perf/util/sample.h
+Merging compiler-attributes/compiler-attributes (6cf1ab89c9e7 Compiler Att=
ributes: Introduce __access_*() function attribute)
+$ git merge -m Merge branch 'compiler-attributes' of https://github.com/oj=
eda/linux.git compiler-attributes/compiler-attributes
+Merge made by the 'ort' strategy.
+ include/linux/compiler_attributes.h | 30 ++++++++++++++++++++++++++++++
+ 1 file changed, 30 insertions(+)
+Merging dma-mapping/for-next (8d58aa484920 swiotlb: reduce the swiotlb buf=
fer size on allocation failure)
+$ git merge -m Merge branch 'for-next' of git://git.infradead.org/users/hc=
h/dma-mapping.git dma-mapping/for-next
+Merge made by the 'ort' strategy.
+ kernel/dma/swiotlb.c | 63 ++++++++++++++++++++++++++++++++---------------=
-----
+ 1 file changed, 39 insertions(+), 24 deletions(-)
+Merging asm-generic/master (2e21c1575208 alpha: fix marvel_ioread8 build r=
egression)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/arnd/asm-generic.git asm-generic/master
+Already up to date.
+Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/vgupta/arc.git arc/for-next
+Already up to date.
+Merging arm/for-next (0c52591d22e9 Merge branches 'misc' and 'fixes' into =
for-next)
+$ git merge -m Merge branch 'for-next' of git://git.armlinux.org.uk/~rmk/l=
inux-arm.git arm/for-next
+Auto-merging arch/arm/Kconfig
+Auto-merging arch/arm/Makefile
+Auto-merging arch/arm/kernel/Makefile
+Auto-merging arch/arm/mach-at91/pm_suspend.S
+Auto-merging arch/arm/mach-mvebu/Makefile
+Auto-merging arch/arm/mm/dump.c
+Auto-merging drivers/firmware/efi/arm-runtime.c
+Auto-merging drivers/memory/Makefile
+Merge made by the 'ort' strategy.
+ arch/arm/Kconfig                    |  1 +
+ arch/arm/Makefile                   | 78 ++++++++++++++++++++------------=
-----
+ arch/arm/boot/compressed/Makefile   |  2 +-
+ arch/arm/common/Makefile            |  2 -
+ arch/arm/common/mcpm_head.S         |  2 +
+ arch/arm/common/vlock.S             |  2 +
+ arch/arm/include/asm/module.h       |  5 +++
+ arch/arm/include/asm/ptdump.h       |  1 +
+ arch/arm/include/asm/stacktrace.h   |  2 +-
+ arch/arm/include/asm/xor.h          |  4 +-
+ arch/arm/kernel/Makefile            |  2 -
+ arch/arm/kernel/hyp-stub.S          |  2 +
+ arch/arm/kernel/machine_kexec.c     |  2 +
+ arch/arm/kernel/module-plts.c       | 14 +++++++
+ arch/arm/kernel/perf_callchain.c    |  9 ++---
+ arch/arm/kernel/return_address.c    |  8 ++--
+ arch/arm/kernel/smp.c               |  5 +--
+ arch/arm/kernel/stacktrace.c        | 13 +++----
+ arch/arm/kernel/swp_emulate.c       |  1 +
+ arch/arm/kernel/unwind.c            | 13 ++++++-
+ arch/arm/lib/Makefile               |  4 --
+ arch/arm/lib/delay-loop.S           |  4 ++
+ arch/arm/mach-at91/Makefile         |  3 --
+ arch/arm/mach-at91/pm_suspend.S     |  4 ++
+ arch/arm/mach-imx/Makefile          |  3 --
+ arch/arm/mach-imx/headsmp.S         |  2 +
+ arch/arm/mach-imx/resume-imx6.S     |  2 +
+ arch/arm/mach-imx/suspend-imx6.S    |  2 +
+ arch/arm/mach-mvebu/Makefile        |  3 --
+ arch/arm/mach-mvebu/coherency_ll.S  |  1 +
+ arch/arm/mach-mvebu/pmsu.c          |  1 +
+ arch/arm/mach-npcm/Makefile         |  2 -
+ arch/arm/mach-npcm/headsmp.S        |  2 +
+ arch/arm/mach-tegra/Makefile        |  2 -
+ arch/arm/mach-tegra/reset-handler.S |  2 +
+ arch/arm/mach-tegra/sleep-tegra20.S |  2 +
+ arch/arm/mach-tegra/sleep-tegra30.S |  2 +
+ arch/arm/mach-tegra/sleep.S         |  2 +
+ arch/arm/mm/Makefile                | 15 -------
+ arch/arm/mm/abort-ev6.S             |  1 +
+ arch/arm/mm/abort-ev7.S             |  1 +
+ arch/arm/mm/cache-v6.S              |  2 +
+ arch/arm/mm/cache-v7.S              |  2 +
+ arch/arm/mm/cache-v7m.S             |  2 +
+ arch/arm/mm/copypage-feroceon.c     |  1 +
+ arch/arm/mm/fault.c                 |  5 ++-
+ arch/arm/mm/proc-v6.S               |  2 +
+ arch/arm/mm/proc-v7-2level.S        |  2 +
+ arch/arm/mm/proc-v7.S               |  2 +
+ arch/arm/mm/tlb-v6.S                |  2 +
+ arch/arm/mm/tlb-v7.S                |  2 +
+ arch/arm/nwfpe/Makefile             |  6 +++
+ arch/arm/vdso/Makefile              |  1 +
+ arch/arm64/include/asm/ptdump.h     |  1 +
+ drivers/amba/bus.c                  |  6 ---
+ drivers/firmware/efi/arm-runtime.c  |  4 +-
+ drivers/memory/Makefile             |  2 -
+ drivers/memory/ti-emif-sram-pm.S    |  1 +
+ drivers/soc/bcm/brcmstb/pm/Makefile |  1 -
+ drivers/soc/bcm/brcmstb/pm/s2-arm.S |  1 +
+ 60 files changed, 165 insertions(+), 108 deletions(-)
+Merging arm64/for-next/core (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'for-next/core' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/arm64/linux arm64/for-next/core
+Already up to date.
+Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.=
rst in toctree to fix 'htmldocs' WARNING)
+$ git merge -m Merge branch 'for-next/perf' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/will/linux.git arm-perf/for-next/perf
+Already up to date.
+Merging arm-soc/for-next (76b4abc1ae4b Merge branch 'arm/drivers' into for=
-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/soc/soc.git arm-soc/for-next
+Merge made by the 'ort' strategy.
+ Documentation/devicetree/bindings/arm/apple.yaml   |   14 +-
+ .../devicetree/bindings/dma/apple,admac.yaml       |    3 +
+ .../bindings/interrupt-controller/apple,aic2.yaml  |   29 +
+ .../devicetree/bindings/iommu/apple,dart.yaml      |    4 +-
+ .../ddr/jedec,lpddr-channel.yaml                   |  146 ++
+ .../memory-controllers/ddr/jedec,lpddr-props.yaml  |   74 +
+ .../memory-controllers/ddr/jedec,lpddr2.yaml       |   48 +-
+ .../memory-controllers/ddr/jedec,lpddr3.yaml       |   44 +-
+ .../memory-controllers/ddr/jedec,lpddr4.yaml       |   35 +
+ .../memory-controllers/ddr/jedec,lpddr5.yaml       |   46 +
+ .../memory-controllers/mc-peripheral-props.yaml    |   38 +
+ .../memory-controllers/renesas,rpc-if.yaml         |    5 +
+ .../st,stm32-fmc2-ebi-props.yaml                   |  144 ++
+ .../memory-controllers/st,stm32-fmc2-ebi.yaml      |  138 +-
+ .../devicetree/bindings/net/micrel,ks8851.yaml     |    1 +
+ arch/arm/arm-soc-for-next-contents.txt             |   16 +
+ arch/arm/boot/dts/ste-dbx5x0.dtsi                  |    6 +-
+ arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts |    2 +-
+ arch/arm/boot/dts/ste-ux500-samsung-codina.dts     |    2 +-
+ arch/arm/boot/dts/ste-ux500-samsung-gavini.dts     |    2 +-
+ arch/arm/boot/dts/ste-ux500-samsung-janice.dts     |   16 +-
+ arch/arm/boot/dts/ste-ux500-samsung-kyle.dts       |   29 +
+ arch/arm64/boot/dts/apple/Makefile                 |    6 +
+ arch/arm64/boot/dts/apple/multi-die-cpp.h          |   22 +
+ arch/arm64/boot/dts/apple/t6000-j314s.dts          |   18 +
+ arch/arm64/boot/dts/apple/t6000-j316s.dts          |   18 +
+ arch/arm64/boot/dts/apple/t6000.dtsi               |   18 +
+ arch/arm64/boot/dts/apple/t6001-j314c.dts          |   18 +
+ arch/arm64/boot/dts/apple/t6001-j316c.dts          |   18 +
+ arch/arm64/boot/dts/apple/t6001-j375c.dts          |   18 +
+ arch/arm64/boot/dts/apple/t6001.dtsi               |   63 +
+ arch/arm64/boot/dts/apple/t6002-j375d.dts          |   50 +
+ arch/arm64/boot/dts/apple/t6002.dtsi               |  175 ++
+ arch/arm64/boot/dts/apple/t600x-common.dtsi        |  137 ++
+ arch/arm64/boot/dts/apple/t600x-die0.dtsi          |  361 ++++
+ arch/arm64/boot/dts/apple/t600x-dieX.dtsi          |  103 +
+ arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi     |   45 +
+ arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi     |  114 ++
+ arch/arm64/boot/dts/apple/t600x-j375.dtsi          |  117 ++
+ arch/arm64/boot/dts/apple/t600x-nvme.dtsi          |   42 +
+ arch/arm64/boot/dts/apple/t600x-pmgr.dtsi          | 2012 +++++++++++++++=
+++++
+ arch/arm64/boot/dts/apple/t8103-j456.dts           |    2 +-
+ arch/arm64/boot/dts/apple/t8103-j457.dts           |    2 +-
+ arch/arm64/boot/dts/apple/t8103-jxxx.dtsi          |    4 +
+ arch/arm64/boot/dts/apple/t8103-pmgr.dtsi          |    2 +-
+ arch/arm64/boot/dts/apple/t8103.dtsi               |   74 +
+ drivers/memory/renesas-rpc-if.c                    |   22 +-
+ drivers/memory/tegra/tegra186-emc.c                |   15 +-
+ drivers/memory/tegra/tegra20-emc.c                 |   15 +-
+ drivers/memory/tegra/tegra210-emc-core.c           |   15 +-
+ drivers/memory/tegra/tegra30-emc.c                 |   15 +-
+ drivers/soc/fsl/qe/gpio.c                          |   66 +-
+ include/memory/renesas-rpc-if.h                    |    1 +
+ 53 files changed, 4105 insertions(+), 325 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/memory-controllers/d=
dr/jedec,lpddr-channel.yaml
+ create mode 100644 Documentation/devicetree/bindings/memory-controllers/d=
dr/jedec,lpddr-props.yaml
+ create mode 100644 Documentation/devicetree/bindings/memory-controllers/d=
dr/jedec,lpddr4.yaml
+ create mode 100644 Documentation/devicetree/bindings/memory-controllers/d=
dr/jedec,lpddr5.yaml
+ create mode 100644 Documentation/devicetree/bindings/memory-controllers/m=
c-peripheral-props.yaml
+ create mode 100644 Documentation/devicetree/bindings/memory-controllers/s=
t,stm32-fmc2-ebi-props.yaml
+ create mode 100644 arch/arm/arm-soc-for-next-contents.txt
+ create mode 100644 arch/arm64/boot/dts/apple/multi-die-cpp.h
+ create mode 100644 arch/arm64/boot/dts/apple/t6000-j314s.dts
+ create mode 100644 arch/arm64/boot/dts/apple/t6000-j316s.dts
+ create mode 100644 arch/arm64/boot/dts/apple/t6000.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t6001-j314c.dts
+ create mode 100644 arch/arm64/boot/dts/apple/t6001-j316c.dts
+ create mode 100644 arch/arm64/boot/dts/apple/t6001-j375c.dts
+ create mode 100644 arch/arm64/boot/dts/apple/t6001.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t6002-j375d.dts
+ create mode 100644 arch/arm64/boot/dts/apple/t6002.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t600x-common.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t600x-die0.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t600x-dieX.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t600x-j375.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t600x-nvme.dtsi
+ create mode 100644 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
+Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add=
 ATC2603C PMIC)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/mani/linux-actions.git actions/for-next
+Auto-merging arch/arm/boot/dts/owl-s500-roseapplepi.dts
+Merge made by the 'ort' strategy.
+Merging amlogic/for-next (475701ff77ef Merge branch 'v6.2/arm64-dt' into f=
or-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/amlogic/linux.git amlogic/for-next
+Merge made by the 'ort' strategy.
+ arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |  1 +
+ arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  1 +
+ arch/arm64/boot/dts/amlogic/meson-g12a.dtsi        |  1 +
+ .../boot/dts/amlogic/meson-g12b-odroid-n2.dtsi     | 42 +++++++++++++++++=
+++++
+ arch/arm64/boot/dts/amlogic/meson-g12b.dtsi        |  1 +
+ arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |  1 +
+ arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 14 ++++++++
+ .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |  1 -
+ arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 14 ++++++++
+ .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |  1 -
+ .../boot/dts/amlogic/meson-gxm-minix-neo-u9h.dts   |  1 -
+ arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         |  1 +
+ drivers/firmware/meson/meson_sm.c                  |  6 ++--
+ 13 files changed, 79 insertions(+), 6 deletions(-)
+Merging asahi-soc/asahi-soc/for-next (56fed763f6b2 arm64: dts: apple: Add =
ADMAC resets on t8103/t600x)
+$ git merge -m Merge branch 'asahi-soc/for-next' of https://github.com/Asa=
hiLinux/linux.git asahi-soc/asahi-soc/for-next
+Already up to date.
+Merging aspeed/for-next (127646b2a4a3 ARM: dts: aspeed: bonnell: Update in=
correct eeprom address)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/joel/bmc.git aspeed/for-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS                                        |    1 +
+ arch/arm/boot/dts/Makefile                         |    2 +-
+ .../arm/boot/dts/aspeed-bmc-facebook-bletchley.dts |  213 ++-
+ arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts       |  921 +++++++++++++
+ arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |   57 +-
+ arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |  244 ++--
+ arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts        | 1381 ---------------=
-----
+ arch/arm/boot/dts/aspeed-g6.dtsi                   |    4 +
+ arch/arm/boot/dts/nuvoton-npcm730-gbs.dts          |    2 +-
+ arch/arm/boot/dts/nuvoton-npcm730-gsj.dts          |    2 +-
+ arch/arm/boot/dts/nuvoton-npcm730-kudo.dts         |    6 +-
+ arch/arm/boot/dts/nuvoton-npcm750-evb.dts          |    4 +-
+ .../boot/dts/nuvoton-npcm750-runbmc-olympus.dts    |    6 +-
+ .../dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts  |   18 +
+ arch/arm/configs/wpcm450_defconfig                 |  213 +++
+ drivers/soc/Kconfig                                |    1 +
+ drivers/soc/Makefile                               |    1 +
+ drivers/soc/nuvoton/Kconfig                        |   11 +
+ drivers/soc/nuvoton/Makefile                       |    2 +
+ drivers/soc/nuvoton/wpcm450-soc.c                  |  109 ++
+ 20 files changed, 1635 insertions(+), 1563 deletions(-)
+ create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
+ delete mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+ create mode 100644 arch/arm/configs/wpcm450_defconfig
+ create mode 100644 drivers/soc/nuvoton/Kconfig
+ create mode 100644 drivers/soc/nuvoton/Makefile
+ create mode 100644 drivers/soc/nuvoton/wpcm450-soc.c
+Merging at91/at91-next (4fb3808be768 Merge branch 'at91-defconfig' into at=
91-next)
+$ git merge -m Merge branch 'at91-next' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/at91/linux.git at91/at91-next
+Merge made by the 'ort' strategy.
+ arch/arm/boot/dts/at91-sam9x60ek.dts  |  4 ---
+ arch/arm/boot/dts/lan966x-pcb8290.dts | 16 +++++++++
+ arch/arm/boot/dts/sama7g5.dtsi        | 67 ++++++++++++++++++++++++++++++=
++++-
+ arch/arm/configs/sama7_defconfig      |  9 +++--
+ 4 files changed, 89 insertions(+), 7 deletions(-)
+Merging broadcom/next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'next' of https://github.com/Broadcom/stblinux=
.git broadcom/next
+Already up to date.
+Merging davinci/davinci/for-next (53ad523ac435 ARM: davinci: fix repeated =
words in comments)
+$ git merge -m Merge branch 'davinci/for-next' of git://git.kernel.org/pub=
/scm/linux/kernel/git/brgl/linux.git davinci/davinci/for-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS                             | 7 +++----
+ arch/arm/mach-davinci/board-dm365-evm.c | 2 +-
+ 2 files changed, 4 insertions(+), 5 deletions(-)
+Merging drivers-memory/for-next (1f1e46b83b7d dt-bindings: memory-controll=
ers: ti,gpmc: add wait-pin polarity)
+$ git merge -m Merge branch 'for-next' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/krzk/linux-mem-ctrl.git drivers-memory/for-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ .../{arm,pl353-smc.yaml =3D> arm,pl35x-smc.yaml}     |  80 +++++++++-----
+ .../bindings/memory-controllers/ti,gpmc-child.yaml |   7 ++
+ MAINTAINERS                                        |   2 +-
+ drivers/memory/omap-gpmc.c                         | 122 ++++++++++++++++=
++---
+ include/linux/platform_data/gpmc-omap.h            |   8 ++
+ 5 files changed, 178 insertions(+), 41 deletions(-)
+ rename Documentation/devicetree/bindings/memory-controllers/{arm,pl353-sm=
c.yaml =3D> arm,pl35x-smc.yaml} (65%)
+Merging imx-mxs/for-next (89ca3fade6cb Merge branch 'imx/defconfig' into f=
or-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/shawnguo/linux.git imx-mxs/for-next
+Auto-merging arch/arm/boot/dts/Makefile
+Merge made by the 'ort' strategy.
+ Documentation/devicetree/bindings/arm/fsl.yaml     |   2 +
+ .../bindings/clock/fsl,imx8m-anatop.yaml           |  51 ++
+ .../devicetree/bindings/spi/fsl-imx-cspi.yaml      |   4 +-
+ .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
+ arch/arm/boot/dts/Makefile                         |   1 +
+ arch/arm/boot/dts/imx6dl-colibri-aster.dts         |   1 -
+ arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |   1 -
+ arch/arm/boot/dts/imx6dl-colibri-iris.dts          |   1 -
+ arch/arm/boot/dts/imx6qdl-colibri.dtsi             |  22 +-
+ arch/arm/boot/dts/imx6sl-kobo-aura2.dts            | 555 ++++++++++++++++=
+++++
+ arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts       |  30 +-
+ arch/arm/boot/dts/imx6ull-colibri-aster.dts        |  40 ++
+ arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts      |  24 +
+ arch/arm/boot/dts/imx6ull-colibri-iris-v2.dts      |  48 +-
+ arch/arm/boot/dts/imx6ull-colibri-iris.dts         |  22 +-
+ arch/arm/boot/dts/imx6ull-colibri-iris.dtsi        |   4 +-
+ arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dts   |  40 ++
+ arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts |  24 +
+ arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dts |  32 +-
+ arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dts    |  20 +
+ arch/arm/boot/dts/imx6ull-colibri.dtsi             |   8 +-
+ arch/arm/boot/dts/imx7-colibri.dtsi                |   5 +-
+ arch/arm/boot/dts/imx7d-remarkable2.dts            |  62 +++
+ arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts        |  10 +-
+ arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |   2 +-
+ arch/arm/configs/imx_v6_v7_defconfig               |   4 +
+ arch/arm64/boot/dts/freescale/Makefile             |   1 +
+ arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |  39 ++
+ arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      |  44 ++
+ arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi |  10 +
+ arch/arm64/boot/dts/freescale/imx8dxl.dtsi         |   6 +
+ .../dts/freescale/imx8mm-data-modul-edm-sbc.dts    |  15 +-
+ .../dts/freescale/imx8mm-innocomm-wb15-evk.dts     | 146 ++++++
+ .../boot/dts/freescale/imx8mm-innocomm-wb15.dtsi   | 480 ++++++++++++++++=
++
+ .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi   |  24 +-
+ .../boot/dts/freescale/imx8mm-venice-gw7901.dts    |  48 +-
+ .../boot/dts/freescale/imx8mm-venice-gw7902.dts    |  48 +-
+ .../boot/dts/freescale/imx8mm-venice-gw7903.dts    |  36 +-
+ .../boot/dts/freescale/imx8mm-venice-gw7904.dts    |  48 +-
+ arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi   |  10 +-
+ arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   5 +-
+ .../boot/dts/freescale/imx8mn-venice-gw7902.dts    |  48 +-
+ arch/arm64/boot/dts/freescale/imx8mn.dtsi          |   6 +-
+ .../dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts    |  41 ++
+ .../boot/dts/freescale/imx8mp-venice-gw74xx.dts    |  48 +-
+ arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi   |   9 +-
+ arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  21 +-
+ .../boot/dts/freescale/imx8mq-librem5-devkit.dts   |  22 +-
+ arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi  |   2 +
+ arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   5 +-
+ .../dts/freescale/imx8qxp-colibri-eval-v3.dtsi     |   2 +-
+ arch/arm64/boot/dts/freescale/imx93.dtsi           | 111 +++++
+ arch/arm64/boot/dts/freescale/mba8mx.dtsi          |   1 +
+ arch/arm64/configs/defconfig                       |   2 +
+ drivers/firmware/imx/scu-pd.c                      |   1 +
+ drivers/soc/imx/gpcv2.c                            |   3 +
+ drivers/soc/imx/imx8m-blk-ctrl.c                   |  11 +-
+ drivers/soc/imx/imx8mp-blk-ctrl.c                  |  22 +
+ include/dt-bindings/firmware/imx/rsrc.h            | 302 +++++++----
+ 59 files changed, 2444 insertions(+), 188 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8m-anat=
op.yaml
+ create mode 100644 arch/arm/boot/dts/imx6sl-kobo-aura2.dts
+ create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-innocomm-wb15-evk=
.dts
+ create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-innocomm-wb15.dtsi
+Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' in=
to next)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/ssantosh/linux-keystone.git keystone/next
+Merge made by the 'ort' strategy.
+Merging mediatek/for-next (25cc9975caad erge branch 'v6.1-next/soc' into f=
or-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/matthias.bgg/linux.git mediatek/for-next
+Merge made by the 'ort' strategy.
+ arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  6 ++---
+ arch/arm64/boot/dts/mediatek/mt6779.dtsi           |  2 +-
+ .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |  1 -
+ arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |  1 -
+ arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |  6 -----
+ arch/arm64/boot/dts/mediatek/mt8186.dtsi           |  3 +++
+ arch/arm64/boot/dts/mediatek/mt8192.dtsi           |  3 +++
+ arch/arm64/boot/dts/mediatek/mt8195.dtsi           | 27 +++++++++++++++++=
+++++
+ drivers/gpu/drm/mediatek/mtk_dpi.c                 | 11 +++++++++
+ drivers/soc/mediatek/mt8186-mmsys.h                |  8 ++++---
+ drivers/soc/mediatek/mtk-mmsys.c                   | 27 +++++++++++++++++=
-----
+ include/linux/soc/mediatek/mtk-mmsys.h             |  7 ++++++
+ 12 files changed, 81 insertions(+), 21 deletions(-)
+Merging mvebu/for-next (d5c48679d56c Merge branch 'mvebu/dt64' into mvebu/=
for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/gclement/mvebu.git mvebu/for-next
+Merge made by the 'ort' strategy.
+Merging omap/for-next (8efe5dea6753 Merge branch 'omap-for-v6.1/dt' into f=
or-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/tmlind/linux-omap.git omap/for-next
+Merge made by the 'ort' strategy.
+ arch/arm/mach-omap1/Kconfig        | 22 +++++++++++-----------
+ arch/arm/mach-omap1/timer.c        |  2 +-
+ arch/arm/mach-omap2/omap4-common.c |  1 +
+ drivers/bus/ti-sysc.c              |  3 +++
+ 4 files changed, 16 insertions(+), 12 deletions(-)
+Merging qcom/for-next (e6466fbaad67 Merge branches 'arm64-defconfig-for-6.=
2', 'arm64-for-6.2', 'clk-for-6.2', 'defconfig-for-6.2', 'drivers-for-6.2',=
 'dts-for-6.2' and 'arm64-fixes-for-6.1' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/qcom/linux.git qcom/for-next
+Auto-merging Documentation/devicetree/bindings/vendor-prefixes.yaml
+Auto-merging MAINTAINERS
+Auto-merging arch/arm/boot/dts/Makefile
+Auto-merging arch/arm64/configs/defconfig
+Merge made by the 'ort' strategy.
+ Documentation/devicetree/bindings/arm/cpus.yaml    |    1 +
+ .../devicetree/bindings/arm/qcom-soc.yaml          |   66 +
+ Documentation/devicetree/bindings/arm/qcom.yaml    |  193 +++
+ Documentation/devicetree/bindings/arm/swir.txt     |   12 -
+ .../devicetree/bindings/clock/qcom,a53pll.yaml     |    2 +-
+ .../devicetree/bindings/clock/qcom,a7pll.yaml      |    2 +-
+ .../bindings/clock/qcom,aoncc-sm8250.yaml          |   11 +-
+ .../bindings/clock/qcom,audiocc-sm8250.yaml        |    7 +-
+ .../bindings/clock/qcom,camcc-sm8250.yaml          |    6 +-
+ .../bindings/clock/qcom,dispcc-sm6125.yaml         |    9 +-
+ .../bindings/clock/qcom,dispcc-sm6350.yaml         |    8 +-
+ .../bindings/clock/qcom,dispcc-sm8x50.yaml         |   14 +-
+ .../bindings/clock/qcom,gcc-apq8064.yaml           |   18 +-
+ .../bindings/clock/qcom,gcc-apq8084.yaml           |   10 +-
+ .../bindings/clock/qcom,gcc-ipq8064.yaml           |   27 +-
+ .../bindings/clock/qcom,gcc-ipq8074.yaml           |   40 +-
+ .../bindings/clock/qcom,gcc-msm8660.yaml           |   12 +-
+ .../bindings/clock/qcom,gcc-msm8909.yaml           |    9 +-
+ .../bindings/clock/qcom,gcc-msm8916.yaml           |   16 +-
+ .../bindings/clock/qcom,gcc-msm8976.yaml           |    9 +-
+ .../bindings/clock/qcom,gcc-msm8994.yaml           |    9 +-
+ .../bindings/clock/qcom,gcc-msm8996.yaml           |    7 +-
+ .../bindings/clock/qcom,gcc-msm8998.yaml           |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-other.yaml  |   33 +-
+ .../bindings/clock/qcom,gcc-qcm2290.yaml           |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-qcs404.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml |    9 +-
+ .../bindings/clock/qcom,gcc-sc8180x.yaml           |    9 +-
+ .../bindings/clock/qcom,gcc-sc8280xp.yaml          |    7 +-
+ .../devicetree/bindings/clock/qcom,gcc-sdm660.yaml |   61 +
+ .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sdx55.yaml  |    7 +-
+ .../devicetree/bindings/clock/qcom,gcc-sdx65.yaml  |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sm6115.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sm6125.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sm6350.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sm8150.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sm8350.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc-sm8450.yaml |    9 +-
+ .../devicetree/bindings/clock/qcom,gcc.yaml        |    6 +-
+ .../bindings/clock/qcom,gpucc-sdm660.yaml          |    4 +-
+ .../bindings/clock/qcom,gpucc-sm8350.yaml          |    9 +-
+ .../devicetree/bindings/clock/qcom,gpucc.yaml      |   22 +-
+ .../devicetree/bindings/clock/qcom,lcc.txt         |   22 -
+ .../devicetree/bindings/clock/qcom,lcc.yaml        |   86 +
+ .../devicetree/bindings/clock/qcom,lpasscc.txt     |   26 -
+ .../devicetree/bindings/clock/qcom,mmcc.yaml       |    4 +-
+ .../bindings/clock/qcom,msm8998-gpucc.yaml         |    8 +-
+ .../devicetree/bindings/clock/qcom,q6sstopcc.yaml  |    2 +-
+ .../bindings/clock/qcom,qcm2290-dispcc.yaml        |    8 +-
+ .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
+ .../bindings/clock/qcom,sc7180-camcc.yaml          |    9 +-
+ .../bindings/clock/qcom,sc7180-dispcc.yaml         |    8 +-
+ .../bindings/clock/qcom,sc7180-lpasscorecc.yaml    |    9 +-
+ .../devicetree/bindings/clock/qcom,sc7180-mss.yaml |    7 +-
+ .../bindings/clock/qcom,sc7280-camcc.yaml          |    6 +-
+ .../bindings/clock/qcom,sc7280-dispcc.yaml         |    8 +-
+ .../bindings/clock/qcom,sc7280-lpasscc.yaml        |    9 +-
+ .../bindings/clock/qcom,sc7280-lpasscorecc.yaml    |   12 +-
+ .../bindings/clock/qcom,sdm845-camcc.yaml          |    8 +-
+ .../bindings/clock/qcom,sdm845-dispcc.yaml         |    8 +-
+ .../bindings/clock/qcom,sdm845-lpasscc.yaml        |   47 +
+ .../bindings/clock/qcom,sm6115-dispcc.yaml         |    7 +-
+ .../devicetree/bindings/clock/qcom,sm6375-gcc.yaml |    9 +-
+ .../bindings/clock/qcom,sm8450-camcc.yaml          |    8 +-
+ .../bindings/clock/qcom,sm8450-dispcc.yaml         |    7 +-
+ .../devicetree/bindings/clock/qcom,videocc.yaml    |   20 +-
+ .../devicetree/bindings/firmware/qcom,scm.yaml     |    2 +
+ .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    1 +
+ .../devicetree/bindings/power/qcom,rpmpd.yaml      |    2 +
+ .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    1 +
+ .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   28 +-
+ .../devicetree/bindings/soc/qcom/qcom,smp2p.yaml   |    2 +-
+ .../devicetree/bindings/soc/qcom/qcom,spm.yaml     |    3 +
+ .../devicetree/bindings/sram/qcom,imem.yaml        |    1 +
+ .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |    6 +-
+ .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
+ MAINTAINERS                                        |    2 +-
+ arch/arm/boot/dts/Makefile                         |    2 +
+ arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts    |    2 +-
+ arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts |  376 +++++
+ arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts        |    9 +-
+ .../boot/dts/qcom-apq8026-samsung-matisse-wifi.dts |  453 +++++
+ arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     | 1754 ++++++++++-----=
----
+ arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  524 +++---
+ arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |  390 ++---
+ arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  561 +++---
+ .../dts/qcom-apq8064-sony-xperia-lagan-yuga.dts    |  650 ++++---
+ arch/arm/boot/dts/qcom-apq8064.dtsi                |  149 +-
+ arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |   18 +-
+ arch/arm/boot/dts/qcom-apq8084.dtsi                |   10 +-
+ arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi      |    2 +-
+ arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts        |    2 +-
+ arch/arm/boot/dts/qcom-ipq4019.dtsi                |    2 +-
+ arch/arm/boot/dts/qcom-ipq8064-rb3011.dts          |    5 +-
+ arch/arm/boot/dts/qcom-ipq8064.dtsi                |    7 +-
+ .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  |   59 +-
+ arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi         |   61 +-
+ arch/arm/boot/dts/qcom-mdm9615.dtsi                |  123 +-
+ arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts  |    1 +
+ arch/arm/boot/dts/qcom-msm8226.dtsi                |   78 +-
+ arch/arm/boot/dts/qcom-msm8660.dtsi                |   42 +-
+ arch/arm/boot/dts/qcom-msm8960-cdp.dts             |    2 +-
+ arch/arm/boot/dts/qcom-msm8960.dtsi                |   70 +-
+ .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |   35 +-
+ .../dts/qcom-msm8974-sony-xperia-rhine-amami.dts   |    1 +
+ .../dts/qcom-msm8974-sony-xperia-rhine-honami.dts  |    1 +
+ .../boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi   |   22 +-
+ arch/arm/boot/dts/qcom-msm8974.dtsi                |  168 +-
+ .../arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts |   25 +-
+ arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts |   39 +-
+ .../qcom-msm8974pro-sony-xperia-shinano-castor.dts |   36 +-
+ arch/arm/boot/dts/qcom-pm8226.dtsi                 |   12 +-
+ arch/arm/boot/dts/qcom-pm8941.dtsi                 |   33 +-
+ arch/arm/boot/dts/qcom-pma8084.dtsi                |   19 +-
+ arch/arm/boot/dts/qcom-pmx65.dtsi                  |    2 +-
+ arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts   |   45 +-
+ arch/arm/boot/dts/qcom-sdx55.dtsi                  |    1 +
+ arch/arm/boot/dts/qcom-sdx65.dtsi                  |    4 +-
+ arch/arm/configs/qcom_defconfig                    |    5 +
+ arch/arm64/boot/dts/qcom/Makefile                  |   17 +-
+ arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |   16 +-
+ arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |  114 +-
+ arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts       |   70 +-
+ arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts       |   11 +-
+ arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   22 +-
+ arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |   10 +-
+ arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts       |    3 +-
+ arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts       |    3 +-
+ arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi         |   21 +-
+ arch/arm64/boot/dts/qcom/ipq8074.dtsi              |  126 +-
+ .../boot/dts/qcom/msm8916-alcatel-idol347.dts      |   80 +-
+ arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     |   24 +-
+ arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     |   24 +-
+ .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |   22 +-
+ .../boot/dts/qcom/msm8916-longcheer-l8910.dts      |    8 +-
+ arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         |  276 +--
+ arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi       |    2 +-
+ .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |  112 +-
+ .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      |   14 +-
+ .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts      |   10 +-
+ .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |   28 +-
+ .../boot/dts/qcom/msm8916-samsung-grandmax.dts     |    2 +-
+ arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    |    2 +-
+ .../boot/dts/qcom/msm8916-samsung-serranove.dts    |   45 +-
+ .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     |   25 +-
+ arch/arm64/boot/dts/qcom/msm8916.dtsi              |   17 +-
+ arch/arm64/boot/dts/qcom/msm8953.dtsi              |  314 +++-
+ .../boot/dts/qcom/msm8992-lg-bullhead-rev-10.dts   |    3 +-
+ .../boot/dts/qcom/msm8992-lg-bullhead-rev-101.dts  |    3 +-
+ arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi  |   45 +-
+ arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts  |    4 +-
+ arch/arm64/boot/dts/qcom/msm8992.dtsi              |    3 +-
+ .../dts/qcom/msm8994-huawei-angler-rev-101.dts     |    3 +-
+ .../boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi  |   12 +-
+ .../dts/qcom/msm8994-sony-xperia-kitakami.dtsi     |   10 +-
+ arch/arm64/boot/dts/qcom/msm8994.dtsi              |  133 +-
+ .../boot/dts/qcom/msm8996-oneplus-common.dtsi      |  787 +++++++++
+ arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts      |   44 +
+ arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts     |   45 +
+ .../boot/dts/qcom/msm8996-sony-xperia-tone.dtsi    |   29 +-
+ .../arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi |   17 +-
+ arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts |   11 +-
+ arch/arm64/boot/dts/qcom/msm8996.dtsi              |  391 +++--
+ ...i-natrium.dts =3D> msm8996pro-xiaomi-natrium.dts} |    9 +-
+ ...i-scorpio.dts =3D> msm8996pro-xiaomi-scorpio.dts} |   13 +-
+ arch/arm64/boot/dts/qcom/msm8996pro.dtsi           |  291 ++++
+ arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi    |    9 +-
+ arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts    |   28 +-
+ .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      |    4 +-
+ arch/arm64/boot/dts/qcom/msm8998-mtp.dts           |   16 +-
+ .../boot/dts/qcom/msm8998-oneplus-cheeseburger.dts |   10 +-
+ .../boot/dts/qcom/msm8998-oneplus-common.dtsi      |   22 +-
+ .../boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi |   67 +-
+ arch/arm64/boot/dts/qcom/msm8998.dtsi              |   85 +-
+ arch/arm64/boot/dts/qcom/pm6125.dtsi               |  154 ++
+ arch/arm64/boot/dts/qcom/pm6150.dtsi               |    6 +-
+ arch/arm64/boot/dts/qcom/pm6150l.dtsi              |   44 +-
+ arch/arm64/boot/dts/qcom/pm6350.dtsi               |   41 +-
+ arch/arm64/boot/dts/qcom/pm660.dtsi                |    4 +-
+ arch/arm64/boot/dts/qcom/pm660l.dtsi               |    2 +-
+ arch/arm64/boot/dts/qcom/pm7325.dtsi               |    6 +-
+ arch/arm64/boot/dts/qcom/pm8005.dtsi               |    2 +-
+ arch/arm64/boot/dts/qcom/pm8150b.dtsi              |    2 +-
+ arch/arm64/boot/dts/qcom/pm8916.dtsi               |    2 +-
+ arch/arm64/boot/dts/qcom/pm8994.dtsi               |    2 +-
+ arch/arm64/boot/dts/qcom/pm8998.dtsi               |    4 +-
+ arch/arm64/boot/dts/qcom/pmi8994.dtsi              |    2 +-
+ arch/arm64/boot/dts/qcom/pmi8998.dtsi              |   10 +-
+ arch/arm64/boot/dts/qcom/pmp8074.dtsi              |  125 ++
+ arch/arm64/boot/dts/qcom/pms405.dtsi               |    4 +-
+ arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts       |    4 +-
+ arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts       |   24 +-
+ arch/arm64/boot/dts/qcom/qcs404-evb.dtsi           |   58 +-
+ arch/arm64/boot/dts/qcom/qcs404.dtsi               |   70 +-
+ arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   20 +-
+ arch/arm64/boot/dts/qcom/sa8155p-adp.dts           |   73 +-
+ arch/arm64/boot/dts/qcom/sa8295p-adp.dts           |   12 +
+ arch/arm64/boot/dts/qcom/sc7180-idp.dts            |  236 ++-
+ .../arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi |   36 +-
+ .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi     |   43 +-
+ .../boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts |   16 +-
+ .../boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi   |    8 +-
+ arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi |   16 +-
+ .../boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |   25 +-
+ .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi      |   72 +-
+ .../dts/qcom/sc7180-trogdor-parade-ps8640.dtsi     |   32 +-
+ .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi      |    8 +-
+ .../dts/qcom/sc7180-trogdor-pazquel360-lte.dts     |   22 +
+ .../dts/qcom/sc7180-trogdor-pazquel360-wifi.dts    |   17 +
+ .../boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi   |   50 +
+ .../arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |   14 +-
+ .../dts/qcom/sc7180-trogdor-quackingstick.dtsi     |   56 +-
+ arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts     |    8 +-
+ .../boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi |   16 +-
+ .../dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi  |   25 +-
+ .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  |   72 +-
+ arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  664 +++-----
+ arch/arm64/boot/dts/qcom/sc7180.dtsi               |  604 +++----
+ arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts         |    8 +-
+ .../qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi   |  195 +++
+ .../dts/qcom/sc7280-herobrine-audio-rt5682.dtsi    |  122 ++
+ arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts  |    1 +
+ .../boot/dts/qcom/sc7280-herobrine-evoker-lte.dts  |   14 +
+ .../boot/dts/qcom/sc7280-herobrine-evoker.dts      |   16 +
+ ...-evoker-r0.dts =3D> sc7280-herobrine-evoker.dtsi} |   23 +-
+ .../dts/qcom/sc7280-herobrine-herobrine-r1.dts     |    6 +-
+ .../boot/dts/qcom/sc7280-herobrine-villager.dtsi   |   11 -
+ arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |   71 +-
+ arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi     |   10 +-
+ arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |   34 +-
+ arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         |   22 +-
+ arch/arm64/boot/dts/qcom/sc7280.dtsi               |  408 +++--
+ arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |   18 +-
+ .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  213 ++-
+ arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi       |   84 +
+ arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  108 +-
+ .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts |   12 +-
+ .../boot/dts/qcom/sdm630-sony-xperia-nile.dtsi     |   24 +-
+ arch/arm64/boot/dts/qcom/sdm630.dtsi               |  140 +-
+ arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts  |   16 +-
+ .../dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts |    2 +-
+ .../arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts |   10 +-
+ arch/arm64/boot/dts/qcom/sdm660.dtsi               |    3 +-
+ arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |   49 +-
+ arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   84 +-
+ arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi     |    2 +-
+ .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi |   39 +-
+ .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   |  460 +++++
+ arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts  |    9 +
+ ...ium.dts =3D> sdm845-xiaomi-beryllium-common.dtsi} |   46 +-
+ .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts |   15 +
+ .../dts/qcom/sdm845-xiaomi-beryllium-tianma.dts    |   15 +
+ arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |   33 +-
+ arch/arm64/boot/dts/qcom/sdm845.dtsi               |  159 +-
+ .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |   10 +-
+ arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts   |   24 +-
+ .../arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts |  241 +++
+ arch/arm64/boot/dts/qcom/sm4250.dtsi               |   38 +
+ arch/arm64/boot/dts/qcom/sm6115.dtsi               |  854 ++++++++++
+ .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   |  164 +-
+ arch/arm64/boot/dts/qcom/sm6125.dtsi               |    8 +-
+ .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    |  337 ++++
+ arch/arm64/boot/dts/qcom/sm6350.dtsi               |   51 +-
+ .../dts/qcom/sm6375-sony-xperia-murray-pdx225.dts  |   86 +
+ arch/arm64/boot/dts/qcom/sm6375.dtsi               |  804 +++++++++
+ .../boot/dts/qcom/sm8150-microsoft-surface-duo.dts |    2 +-
+ .../boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   |    6 +
+ arch/arm64/boot/dts/qcom/sm8150.dtsi               |  392 ++---
+ arch/arm64/boot/dts/qcom/sm8250-mtp.dts            |   36 +-
+ .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |   35 +-
+ arch/arm64/boot/dts/qcom/sm8250.dtsi               |  639 +++----
+ arch/arm64/boot/dts/qcom/sm8350-hdk.dts            |   12 +
+ .../boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi   |   10 +-
+ arch/arm64/boot/dts/qcom/sm8350.dtsi               |   16 +-
+ arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |   19 +
+ arch/arm64/boot/dts/qcom/sm8450-qrd.dts            |   19 +
+ .../dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts  |   28 +-
+ arch/arm64/boot/dts/qcom/sm8450.dtsi               |  209 ++-
+ arch/arm64/configs/defconfig                       |    8 +-
+ drivers/clk/qcom/clk-rpmh.c                        |   13 +
+ drivers/clk/qcom/dispcc-sm6350.c                   |    4 +-
+ drivers/clk/qcom/dispcc-sm8250.c                   |   38 +-
+ drivers/clk/qcom/gcc-ipq806x.c                     |    4 +-
+ drivers/clk/qcom/gcc-ipq8074.c                     | 1781 +++++++++------=
-----
+ drivers/clk/qcom/gcc-sm6125.c                      |    1 -
+ drivers/clk/qcom/gcc-sm8250.c                      |    4 +-
+ drivers/soc/qcom/apr.c                             |   15 +-
+ drivers/soc/qcom/cmd-db.c                          |    2 +
+ drivers/soc/qcom/llcc-qcom.c                       |    2 +-
+ drivers/soc/qcom/pdr_internal.h                    |   20 +-
+ drivers/soc/qcom/qcom_stats.c                      |    2 +
+ drivers/soc/qcom/rpmhpd.c                          |   71 +-
+ drivers/soc/qcom/smd-rpm.c                         |    3 +-
+ drivers/soc/qcom/smp2p.c                           |    2 +-
+ drivers/soc/qcom/socinfo.c                         |  271 +--
+ drivers/soc/qcom/spm.c                             |   46 +
+ include/dt-bindings/arm/qcom,ids.h                 |  161 ++
+ include/dt-bindings/clock/qcom,dispcc-sm8250.h     |    1 +
+ include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h    |   90 +-
+ include/dt-bindings/power/qcom-rpmpd.h             |   16 +
+ include/soc/qcom/qcom-spmi-pmic.h                  |   17 +-
+ 304 files changed, 14594 insertions(+), 7684 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml
+ delete mode 100644 Documentation/devicetree/bindings/arm/swir.txt
+ create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdm66=
0.yaml
+ delete mode 100644 Documentation/devicetree/bindings/clock/qcom,lcc.txt
+ create mode 100644 Documentation/devicetree/bindings/clock/qcom,lcc.yaml
+ delete mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.t=
xt
+ create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-lp=
asscc.yaml
+ create mode 100644 arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
+ create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
+ create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
+ create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts
+ create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts
+ rename arch/arm64/boot/dts/qcom/{msm8996-xiaomi-natrium.dts =3D> msm8996p=
ro-xiaomi-natrium.dts} (97%)
+ rename arch/arm64/boot/dts/qcom/{msm8996-xiaomi-scorpio.dts =3D> msm8996p=
ro-xiaomi-scorpio.dts} (97%)
+ create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi
+ create mode 100644 arch/arm64/boot/dts/qcom/pm6125.dtsi
+ create mode 100644 arch/arm64/boot/dts/qcom/pmp8074.dtsi
+ create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte=
.dts
+ create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wif=
i.dts
+ create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
+ create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682=
-3mic.dtsi
+ create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682=
.dtsi
+ create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.d=
ts
+ create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
+ rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts =3D> sc72=
80-herobrine-evoker.dtsi} (94%)
+ create mode 100644 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+ rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts =3D> sdm845-=
xiaomi-beryllium-common.dtsi} (94%)
+ create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.=
dts
+ create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianm=
a.dts
+ create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+ create mode 100644 arch/arm64/boot/dts/qcom/sm4250.dtsi
+ create mode 100644 arch/arm64/boot/dts/qcom/sm6115.dtsi
+ create mode 100644 arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx=
225.dts
+ create mode 100644 arch/arm64/boot/dts/qcom/sm6375.dtsi
+ create mode 100644 include/dt-bindings/arm/qcom,ids.h
+Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert =
brcm,bcm2835-vchiq to json-schema)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/nsaenz/linux-rpi.git raspberrypi/for-next
+Auto-merging arch/arm/boot/dts/bcm2711-rpi-400.dts
+Merge made by the 'ort' strategy.
+Merging renesas/next (cb7df0645f0f Merge branch 'renesas-arm-dt-for-v6.2' =
into renesas-next)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/geert/renesas-devel.git renesas/next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ .../bindings/{arm =3D> soc/renesas}/renesas.yaml     |   5 +-
+ MAINTAINERS                                        |   1 -
+ arch/arm/boot/dts/r8a7742.dtsi                     |   2 +-
+ arch/arm/boot/dts/r8a7790.dtsi                     |   2 +-
+ arch/arm/boot/dts/r8a7791.dtsi                     |   2 +-
+ arch/arm/boot/dts/r8a7793.dtsi                     |   2 +-
+ arch/arm/boot/dts/r9a06g032.dtsi                   |  10 +-
+ arch/arm/mach-shmobile/Kconfig                     |   2 -
+ arch/arm64/Kconfig.platforms                       |   2 -
+ arch/arm64/boot/dts/renesas/condor-common.dtsi     |   1 +
+ arch/arm64/boot/dts/renesas/r8a779a0.dtsi          |  24 +-
+ arch/arm64/boot/dts/renesas/r8a779f0.dtsi          |  16 +-
+ .../boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi  |  89 ++-
+ arch/arm64/boot/dts/renesas/r8a779g0.dtsi          | 605 ++++++++++++++++=
++++-
+ arch/arm64/boot/dts/renesas/r9a07g043.dtsi         | 362 +++++-------
+ arch/arm64/boot/dts/renesas/r9a07g043u.dtsi        |  73 +++
+ arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts |   2 +-
+ arch/arm64/boot/dts/renesas/r9a07g044.dtsi         |  17 +-
+ arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts  |  30 +
+ arch/arm64/boot/dts/renesas/r9a07g054.dtsi         |  17 +-
+ arch/arm64/boot/dts/renesas/r9a09g011.dtsi         |   6 +-
+ arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi   |   5 -
+ arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi  |   5 -
+ arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi      |  28 -
+ .../boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi |   7 +
+ arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi  |   7 -
+ drivers/soc/renesas/Kconfig                        |   2 +
+ 27 files changed, 986 insertions(+), 338 deletions(-)
+ rename Documentation/devicetree/bindings/{arm =3D> soc/renesas}/renesas.y=
aml (98%)
+ create mode 100644 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistak=
e "Voltags" -> "Voltage")
+$ git merge -m Merge branch 'reset/next' of https://git.pengutronix.de/git=
/pza/linux reset/reset/next
+Already up to date.
+Merging rockchip/for-next (7771a384229f Merge branch 'v6.1-armsoc/dtsfixes=
' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/mmind/linux-rockchip.git rockchip/for-next
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/arm/rockchip.yaml          |  20 +
+ arch/arm/boot/dts/rk3036-evb.dts                   |   3 +-
+ arch/arm/boot/dts/rk3066a-mk808.dts                |   2 +-
+ arch/arm/boot/dts/rk3188-radxarock.dts             |   2 +-
+ arch/arm/boot/dts/rk3188.dtsi                      |   2 +-
+ arch/arm/boot/dts/rk3288-evb-act8846.dts           |   2 +-
+ arch/arm/boot/dts/rk3288-evb.dtsi                  |   6 +-
+ arch/arm/boot/dts/rk3288-firefly.dtsi              |   3 +-
+ arch/arm/boot/dts/rk3288-miqi.dts                  |   3 +-
+ arch/arm/boot/dts/rk3288-rock2-square.dts          |   3 +-
+ arch/arm/boot/dts/rk3288-vmarc-som.dtsi            |   1 -
+ arch/arm64/boot/dts/rockchip/Makefile              |   4 +
+ arch/arm64/boot/dts/rockchip/px30-evb.dts          |  10 +-
+ .../boot/dts/rockchip/px30-ringneck-haikou.dts     | 232 +++++++
+ arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi    | 382 +++++++++++
+ arch/arm64/boot/dts/rockchip/rk3308-evb.dts        |  12 +-
+ arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     |   2 +-
+ arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts    |   2 +-
+ arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts |   1 +
+ arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  11 +
+ .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |   3 +-
+ arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   3 +-
+ .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi      |   4 -
+ .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      |   2 +-
+ arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts  |   2 +-
+ arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts |   2 +-
+ arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |   1 +
+ arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts   |   4 +-
+ .../boot/dts/rockchip/rk3399-pinephone-pro.dts     |  76 +++
+ .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |   2 +-
+ .../arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts |   3 +-
+ arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi    |   2 +-
+ .../boot/dts/rockchip/rk3399-rock-4c-plus.dts      |   6 +
+ arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |   1 -
+ .../dts/rockchip/rk3399-sapphire-excavator.dts     |   4 +-
+ arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  20 +
+ .../boot/dts/rockchip/rk3399pro-vmarc-som.dtsi     |   3 +-
+ .../boot/dts/rockchip/rk3566-anbernic-rg353p.dts   | 109 +--
+ .../boot/dts/rockchip/rk3566-anbernic-rg353v.dts   | 114 ++++
+ .../boot/dts/rockchip/rk3566-anbernic-rg353vs.dts  |  87 +++
+ .../boot/dts/rockchip/rk3566-anbernic-rg353x.dtsi  |  60 ++
+ .../boot/dts/rockchip/rk3566-anbernic-rg503.dts    |  79 +++
+ .../boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi   |  47 +-
+ arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  |   2 +-
+ arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts |   7 +-
+ arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts     |  42 +-
+ arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts |   1 -
+ arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts  | 744 ++++++++++++++++=
+++++
+ arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts    | 133 +++-
+ arch/arm64/boot/dts/rockchip/rk356x.dtsi           |  50 +-
+ include/dt-bindings/clock/rk3399-cru.h             |   6 +-
+ 51 files changed, 2151 insertions(+), 171 deletions(-)
+ create mode 100644 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+ create mode 100644 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+ create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353v.dts
+ create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353vs.d=
ts
+ create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353x.dt=
si
+ create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+Merging samsung-krzk/for-next (113aec13d45e Merge branch 'next/clk' into f=
or-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux.git samsung-krzk/for-next
+Merge made by the 'ort' strategy.
+ .../bindings/clock/samsung,exynosautov9-clock.yaml |  2 +-
+ arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi         | 34 +++++++++++------=
-----
+ arch/arm64/boot/dts/tesla/fsd-pinctrl.h            |  6 ++--
+ drivers/clk/samsung/clk-exynos7885.c               |  4 +--
+ 4 files changed, 23 insertions(+), 23 deletions(-)
+Merging scmi/for-linux-next (52851e9f361e Merge branch 'for-next/scmi' of =
git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-l=
inux-next)
+$ git merge -m Merge branch 'for-linux-next' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/sudeep.holla/linux.git scmi/for-linux-next
+Merge made by the 'ort' strategy.
+ Documentation/ABI/testing/debugfs-scmi-raw         |   98 ++
+ arch/arm64/boot/dts/arm/corstone1000.dtsi          |    1 +
+ arch/arm64/boot/dts/arm/foundation-v8.dtsi         |    1 +
+ arch/arm64/boot/dts/arm/juno-r1.dts                |    2 +
+ arch/arm64/boot/dts/arm/juno-r2.dts                |    2 +
+ arch/arm64/boot/dts/arm/juno.dts                   |    2 +
+ arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |    1 +
+ .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |    1 +
+ drivers/firmware/arm_scmi/Kconfig                  |   23 +
+ drivers/firmware/arm_scmi/Makefile                 |    1 +
+ drivers/firmware/arm_scmi/common.h                 |   72 +-
+ drivers/firmware/arm_scmi/driver.c                 |  557 +++++---
+ drivers/firmware/arm_scmi/mailbox.c                |    4 +-
+ drivers/firmware/arm_scmi/optee.c                  |    4 +-
+ drivers/firmware/arm_scmi/protocols.h              |    2 +
+ drivers/firmware/arm_scmi/raw_mode.c               | 1340 +++++++++++++++=
+++++
+ drivers/firmware/arm_scmi/raw_mode.h               |   30 +
+ drivers/firmware/arm_scmi/smc.c                    |    4 +-
+ drivers/firmware/arm_scmi/virtio.c                 |    2 +-
+ 19 files changed, 1990 insertions(+), 157 deletions(-)
+ create mode 100644 Documentation/ABI/testing/debugfs-scmi-raw
+ create mode 100644 drivers/firmware/arm_scmi/raw_mode.c
+ create mode 100644 drivers/firmware/arm_scmi/raw_mode.h
+$ git reset --hard HEAD^
+HEAD is now at e16d85195e0e Merge branch 'for-next' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/krzk/linux.git
+Merging next-20221108 version of scmi
+$ git merge -m next-20221108/scmi e7c94176ab905ef32bdab1154709c8c939711dc7
+Merge made by the 'ort' strategy.
+Merging stm32/stm32-next (7ad436adc788 ARM: multi_v7_defconfig: enable Typ=
e-C UCSI and STM32G0 as modules)
+$ git merge -m Merge branch 'stm32-next' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/atorgue/stm32.git stm32/stm32-next
+Auto-merging arch/arm/boot/dts/Makefile
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/arm/stm32/stm32.yaml       |   6 +
+ arch/arm/boot/dts/Makefile                         |   1 +
+ arch/arm/boot/dts/stm32h743.dtsi                   |   2 -
+ arch/arm/boot/dts/stm32mp13-pinctrl.dtsi           |  14 ++
+ arch/arm/boot/dts/stm32mp131.dtsi                  | 128 ++++++++++++++-
+ arch/arm/boot/dts/stm32mp133.dtsi                  |  31 ++++
+ arch/arm/boot/dts/stm32mp135f-dk.dts               | 130 +++++++++++++++-
+ arch/arm/boot/dts/stm32mp151.dtsi                  |   3 -
+ arch/arm/boot/dts/stm32mp151a-dhcor-testbench.dts  |  17 ++
+ arch/arm/boot/dts/stm32mp157a-dhcor-avenger96.dts  |   1 -
+ arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi   |   2 +-
+ arch/arm/boot/dts/stm32mp157c-ev1.dts              |  15 +-
+ arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts          |   2 +-
+ arch/arm/boot/dts/stm32mp157c-odyssey.dts          |   2 +-
+ arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi      |   4 +-
+ arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi       |   2 +-
+ arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |   7 +-
+ .../boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi    |   2 +-
+ arch/arm/boot/dts/stm32mp15xx-dhcor-testbench.dtsi | 171 ++++++++++++++++=
+++++
+ arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |   6 +-
+ arch/arm/configs/multi_v7_defconfig                |   2 +
+ 21 files changed, 524 insertions(+), 24 deletions(-)
+ create mode 100644 arch/arm/boot/dts/stm32mp151a-dhcor-testbench.dts
+ create mode 100644 arch/arm/boot/dts/stm32mp15xx-dhcor-testbench.dtsi
+Merging sunxi/sunxi/for-next (1c50050ca1eb arm64: dts: allwinner: a64: ena=
ble Bluetooth on Pinebook)
+$ git merge -m Merge branch 'sunxi/for-next' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/sunxi/linux.git sunxi/sunxi/for-next
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/usb/generic-ehci.yaml      |   1 +
+ .../devicetree/bindings/usb/generic-ohci.yaml      |   1 +
+ arch/arm/boot/dts/axp22x.dtsi                      |   6 +
+ arch/arm/boot/dts/axp809.dtsi                      |   7 +
+ arch/arm/boot/dts/axp81x.dtsi                      |  14 --
+ arch/arm64/boot/dts/allwinner/axp803.dtsi          |  10 --
+ .../boot/dts/allwinner/sun50i-a64-pinebook.dts     |  14 ++
+ .../dts/allwinner/sun50i-h616-orangepi-zero2.dts   |  41 ++++++
+ .../boot/dts/allwinner/sun50i-h616-x96-mate.dts    |  25 ++++
+ arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     | 160 ++++++++++++++++=
+++++
+ 10 files changed, 255 insertions(+), 24 deletions(-)
+Merging tee/next (bd52407221b4 optee: Add __init/__exit annotations to mod=
ule init/exit funcs)
+$ git merge -m Merge branch 'next' of https://git.linaro.org/people/jens.w=
iklander/linux-tee.git tee/next
+Merge made by the 'ort' strategy.
+ drivers/tee/optee/core.c | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+Merging tegra/for-next (77bfb4481cf2 Merge branch for-6.2/arm64/defconfig =
into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/tegra/linux.git tegra/for-next
+Auto-merging arch/arm64/configs/defconfig
+Merge made by the 'ort' strategy.
+ .../bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml | 156 +++++
+ .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |   1 +
+ arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   2 +-
+ .../arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi |   7 +
+ .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  |  19 +
+ .../arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi |  14 +
+ arch/arm64/boot/dts/nvidia/tegra234.dtsi           | 565 +++++++++++-----=
--
+ arch/arm64/configs/defconfig                       |   3 +
+ drivers/firmware/tegra/bpmp-debugfs.c              |  62 +-
+ drivers/firmware/tegra/bpmp-tegra186.c             |  36 +-
+ drivers/firmware/tegra/bpmp-tegra210.c             |   7 +-
+ drivers/firmware/tegra/bpmp.c                      |  33 +-
+ drivers/firmware/tegra/ivc.c                       | 150 +++--
+ drivers/soc/tegra/Kconfig                          |   1 +
+ drivers/soc/tegra/fuse/fuse-tegra.c                | 112 +---
+ drivers/soc/tegra/fuse/fuse-tegra30.c              | 278 ++++++++-
+ drivers/soc/tegra/fuse/fuse.h                      |   4 +
+ drivers/thermal/tegra/tegra-bpmp-thermal.c         |  15 +-
+ include/dt-bindings/clock/tegra234-clock.h         | 639 ++++++++++++++++=
++++-
+ include/dt-bindings/memory/tegra234-mc.h           | 440 +++++++++++++-
+ include/dt-bindings/power/tegra234-powergate.h     |  15 +
+ include/dt-bindings/reset/tegra234-reset.h         | 111 +++-
+ include/soc/tegra/bpmp.h                           |  17 +-
+ include/soc/tegra/ivc.h                            |  11 +-
+ 24 files changed, 2214 insertions(+), 484 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/gpu/host1x/nvidia,te=
gra234-nvdec.yaml
+Merging ti/ti-next (b7897ec0b3d2 Merge branches 'ti-drivers-soc-next', 'ti=
-k3-config-next' and 'ti-k3-dts-next' into ti-next)
+$ git merge -m Merge branch 'ti-next' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/ti/linux.git ti/ti-next
+Auto-merging arch/arm64/configs/defconfig
+Merge made by the 'ort' strategy.
+ arch/arm/mach-keystone/Makefile                    |   4 +-
+ arch/arm/mach-keystone/keystone.c                  |   2 -
+ arch/arm/mach-keystone/keystone.h                  |   5 -
+ arch/arm/mach-keystone/platsmp.c                   |  41 ------
+ arch/arm/mach-keystone/smc.S                       |  26 ----
+ arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |  26 ++++
+ arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |   4 +
+ arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |   2 +
+ arch/arm64/boot/dts/ti/k3-am625-sk.dts             |  81 ++---------
+ arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  39 ++++-
+ arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi            |   6 +
+ arch/arm64/boot/dts/ti/k3-am642-evm.dts            | 119 ++--------------
+ arch/arm64/boot/dts/ti/k3-am642-sk.dts             | 142 ++--------------=
--
+ arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 101 ++-----------
+ arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  41 ++++++
+ arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  22 ++-
+ arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |   2 +
+ .../dts/ti/k3-am6528-iot2050-basic-common.dtsi     |   1 +
+ arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 113 ++++-----------
+ .../dts/ti/k3-am6548-iot2050-advanced-common.dtsi  |   4 -
+ .../boot/dts/ti/k3-j7200-common-proc-board.dts     |  48 ++-----
+ arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |  29 ++++
+ arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |   7 +-
+ arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  42 +-----
+ .../boot/dts/ti/k3-j721e-common-proc-board.dts     | 141 ++++------------=
--
+ arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  55 +++++++
+ arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  11 +-
+ arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 158 +++-------------=
-----
+ arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |  33 +----
+ .../boot/dts/ti/k3-j721s2-common-proc-board.dts    | 132 +----------------
+ arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |  58 ++++++++
+ arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |   7 +
+ arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |  98 +------------
+ arch/arm64/configs/defconfig                       |   1 +
+ drivers/firmware/ti_sci.c                          |  24 ++--
+ drivers/soc/ti/Kconfig                             |   2 +-
+ drivers/soc/ti/k3-ringacc.c                        |  28 +++-
+ drivers/soc/ti/knav_qmss_queue.c                   |   2 +-
+ 38 files changed, 477 insertions(+), 1180 deletions(-)
+ delete mode 100644 arch/arm/mach-keystone/platsmp.c
+ delete mode 100644 arch/arm/mach-keystone/smc.S
+Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller =
node)
+$ git merge -m Merge branch 'for-next' of git://github.com/Xilinx/linux-xl=
nx.git xilinx/for-next
+Merge made by the 'ort' strategy.
+ arch/arm/boot/dts/zynq-7000.dtsi | 12 ++++++++++++
+ 1 file changed, 12 insertions(+)
+Merging clk/clk-next (5eeec1fd8360 Merge branch 'clk-fixes' into clk-next)
+$ git merge -m Merge branch 'clk-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/clk/linux.git clk/clk-next
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/clock/ingenic,cgu.yaml     |   2 +
+ .../devicetree/bindings/clock/ti,cdce925.txt       |  53 ----
+ .../devicetree/bindings/clock/ti,cdce925.yaml      | 103 ++++++
+ drivers/clk/clk-bulk.c                             |   6 +-
+ drivers/clk/clk-cdce925.c                          |  21 +-
+ drivers/clk/clk-stm32mp1.c                         |   2 +-
+ drivers/clk/ingenic/Kconfig                        |  10 +
+ drivers/clk/ingenic/Makefile                       |   1 +
+ drivers/clk/ingenic/cgu.c                          |  42 ++-
+ drivers/clk/ingenic/cgu.h                          |  17 +-
+ drivers/clk/ingenic/jz4755-cgu.c                   | 346 ++++++++++++++++=
+++++
+ drivers/clk/ingenic/x1000-cgu.c                    | 119 +++++--
+ drivers/clk/keystone/syscon-clk.c                  |   9 +-
+ drivers/clk/mstar/Kconfig                          |   7 +
+ drivers/clk/mstar/Makefile                         |   1 +
+ drivers/clk/mstar/clk-msc313-cpupll.c              | 220 +++++++++++++
+ drivers/clk/qcom/gdsc.c                            |  61 +---
+ drivers/clk/qcom/gdsc.h                            |   2 -
+ drivers/clk/renesas/r8a779a0-cpg-mssr.c            |   2 +-
+ drivers/clk/renesas/r8a779f0-cpg-mssr.c            |  12 +-
+ drivers/clk/renesas/r8a779g0-cpg-mssr.c            |  22 +-
+ drivers/clk/renesas/r9a06g032-clocks.c             |   3 +-
+ drivers/clk/renesas/r9a07g043-cpg.c                |   5 -
+ drivers/clk/renesas/r9a07g044-cpg.c                |  10 +-
+ drivers/clk/renesas/rzg2l-cpg.c                    |  49 +--
+ drivers/clk/renesas/rzg2l-cpg.h                    |   4 +
+ drivers/clk/samsung/clk-exynos5-subcmu.c           |   4 +-
+ drivers/clk/x86/Kconfig                            |   5 +-
+ drivers/clk/x86/clk-cgu-pll.c                      |  23 +-
+ drivers/clk/x86/clk-cgu.c                          | 106 ++-----
+ drivers/clk/x86/clk-cgu.h                          |  46 +--
+ drivers/clk/x86/clk-lgm.c                          |  18 +-
+ drivers/clk/xilinx/Kconfig                         |   4 +-
+ include/dt-bindings/clock/ingenic,jz4755-cgu.h     |  49 +++
+ include/dt-bindings/clock/ingenic,x1000-cgu.h      |   4 +
+ 35 files changed, 1043 insertions(+), 345 deletions(-)
+ delete mode 100644 Documentation/devicetree/bindings/clock/ti,cdce925.txt
+ create mode 100644 Documentation/devicetree/bindings/clock/ti,cdce925.yaml
+ create mode 100644 drivers/clk/ingenic/jz4755-cgu.c
+ create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c
+ create mode 100644 include/dt-bindings/clock/ingenic,jz4755-cgu.h
+Merging clk-imx/for-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/abelvesa/linux.git clk-imx/for-next
+Already up to date.
+Merging clk-renesas/renesas-clk (523ed9442b99 clk: renesas: r8a779g0: Add =
CMT clocks)
+$ git merge -m Merge branch 'renesas-clk' of git://git.kernel.org/pub/scm/=
linux/kernel/git/geert/renesas-drivers.git clk-renesas/renesas-clk
+Merge made by the 'ort' strategy.
+ drivers/clk/renesas/r8a779f0-cpg-mssr.c | 16 ++++++++--------
+ drivers/clk/renesas/r8a779g0-cpg-mssr.c | 10 ++++++++++
+ 2 files changed, 18 insertions(+), 8 deletions(-)
+Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add=
 cmu_peric1 clock support)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/snawrocki/clk.git clk-samsung/for-next
+Already up to date.
+Merging csky/linux-next (ce0ba954805e csky: Kconfig: Fix spelling mistake =
"Meory" -> "Memory")
+$ git merge -m Merge branch 'linux-next' of git://github.com/c-sky/csky-li=
nux.git csky/linux-next
+Merge made by the 'ort' strategy.
+ arch/csky/Kconfig                 | 3 ++-
+ arch/csky/include/asm/processor.h | 2 ++
+ arch/csky/kernel/stacktrace.c     | 6 ++----
+ 3 files changed, 6 insertions(+), 5 deletions(-)
+Merging loongarch/loongarch-next (247f34f7b803 Linux 6.1-rc2)
+$ git merge -m Merge branch 'loongarch-next' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/chenhuacai/linux-loongson.git loongarch/loongarch-next
+Already up to date.
+Merging m68k/for-next (550a998f37b4 m68k: mac: Reword comment using double=
 "in")
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/geert/linux-m68k.git m68k/for-next
+Merge made by the 'ort' strategy.
+ arch/m68k/include/asm/mac_via.h | 8 --------
+ arch/m68k/mac/misc.c            | 2 +-
+ 2 files changed, 1 insertion(+), 9 deletions(-)
+Merging m68knommu/for-next (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/gerg/m68knommu.git m68knommu/for-next
+Already up to date.
+Merging microblaze/next (493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-f=
or-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-na=
mespace)
+$ git merge -m Merge branch 'next' of git://git.monstr.eu/linux-2.6-microb=
laze.git microblaze/next
+Already up to date.
+Merging mips/mips-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'mips-next' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/mips/linux.git mips/mips-next
+Already up to date.
+Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating=
 min_low_pfn)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/lftan/nios2.git nios2/for-next
+Already up to date.
+Merging openrisc/for-next (34a0bac084e4 MAINTAINERS: git://github -> https=
://github.com for openrisc)
+$ git merge -m Merge branch 'for-next' of git://github.com/openrisc/linux.=
git openrisc/for-next
+Already up to date.
+Merging parisc-hd/for-next (247f34f7b803 Linux 6.1-rc2)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/deller/parisc-linux.git parisc-hd/for-next
+Already up to date.
+Merging powerpc/next (247f34f7b803 Linux 6.1-rc2)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/powerpc/linux.git powerpc/next
+Already up to date.
+Merging soc-fsl/next (4b0986a3613c Linux 5.18)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/leo/linux.git soc-fsl/next
+Already up to date.
+Merging risc-v/for-next (be79afc740b5 riscv: Enable HAVE_ARCH_HUGE_VMALLOC=
 for 64BIT)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/riscv/linux.git risc-v/for-next
+Auto-merging arch/riscv/Kconfig
+Auto-merging arch/riscv/kernel/cpu.c
+Merge made by the 'ort' strategy.
+ .../features/vm/huge-vmap/arch-support.txt         |  2 +-
+ arch/riscv/Kconfig                                 |  2 +
+ arch/riscv/Kconfig.erratas                         | 13 ++++
+ arch/riscv/errata/thead/errata.c                   | 19 +++++
+ arch/riscv/include/asm/errata_list.h               | 16 ++++-
+ arch/riscv/include/asm/pgtable.h                   |  3 +
+ arch/riscv/include/asm/sbi.h                       |  5 ++
+ arch/riscv/include/asm/vdso.h                      |  2 +-
+ arch/riscv/include/asm/vmalloc.h                   | 18 +++++
+ arch/riscv/include/uapi/asm/ucontext.h             | 12 ++--
+ arch/riscv/kernel/cpu.c                            | 30 +++++++-
+ arch/riscv/mm/Makefile                             |  1 +
+ arch/riscv/mm/pgtable.c                            | 83 +++++++++++++++++=
+++++
+ drivers/perf/riscv_pmu_sbi.c                       | 34 ++++++---
+ scripts/head-object-list.txt                       |  1 -
+ 15 files changed, 220 insertions(+), 21 deletions(-)
+ create mode 100644 arch/riscv/mm/pgtable.c
+Merging risc-v-mc/dt-for-next (d6105a8b7c16 riscv: dts: microchip: fix mem=
ory node unit address for icicle)
+$ git merge -m Merge branch 'dt-for-next' of git://git.kernel.org/pub/scm/=
linux/kernel/git/conor/linux.git risc-v-mc/dt-for-next
+Merge made by the 'ort' strategy.
+ .../boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 31 ++++++++++-------=
--
+ arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts  | 36 +++++++++++++++++=
++++-
+ arch/riscv/boot/dts/microchip/mpfs.dtsi            | 32 +++++++++++++++++=
++
+ 3 files changed, 83 insertions(+), 16 deletions(-)
+Merging s390/for-next (ccb7d9db01b9 Merge branch 'features' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/s390/linux.git s390/for-next
+Merge made by the 'ort' strategy.
+ Documentation/admin-guide/kernel-parameters.txt |  11 +
+ arch/s390/Kconfig                               |   1 +
+ arch/s390/include/asm/pai.h                     |   6 +
+ arch/s390/kernel/perf_pai_crypto.c              |  48 ++---
+ arch/s390/kernel/perf_pai_ext.c                 |  12 +-
+ arch/s390/mm/init.c                             |   4 +-
+ drivers/s390/char/con3215.c                     | 275 +++++++++++++++----=
-----
+ 7 files changed, 222 insertions(+), 135 deletions(-)
+Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer =
from integer of different size)
+$ git merge -m Merge branch 'for-next' of git://git.libc.org/linux-sh sh/f=
or-next
+Already up to date.
+Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/davem/sparc-next.git sparc-next/master
+Already up to date.
+Merging uml/next (193cb8372424 uml: Remove the initialization of statics t=
o 0)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/uml/linux.git uml/next
+Already up to date.
+Merging xtensa/xtensa-for-next (b8c4f4db2436 xtensa: update config files)
+$ git merge -m Merge branch 'xtensa-for-next' of git://github.com/jcmvbkbc=
/linux-xtensa.git xtensa/xtensa-for-next
+Auto-merging MAINTAINERS
+Auto-merging arch/xtensa/configs/audio_kc705_defconfig
+Auto-merging arch/xtensa/configs/cadence_csp_defconfig
+Auto-merging arch/xtensa/configs/generic_kc705_defconfig
+Auto-merging arch/xtensa/configs/nommu_kc705_defconfig
+Auto-merging arch/xtensa/configs/smp_lx200_defconfig
+Auto-merging arch/xtensa/configs/xip_kc705_defconfig
+Merge made by the 'ort' strategy.
+ MAINTAINERS                                 | 2 +-
+ arch/xtensa/configs/audio_kc705_defconfig   | 1 -
+ arch/xtensa/configs/cadence_csp_defconfig   | 4 ----
+ arch/xtensa/configs/generic_kc705_defconfig | 1 -
+ arch/xtensa/configs/nommu_kc705_defconfig   | 1 -
+ arch/xtensa/configs/smp_lx200_defconfig     | 1 -
+ arch/xtensa/configs/xip_kc705_defconfig     | 1 -
+ 7 files changed, 1 insertion(+), 10 deletions(-)
+Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl=
' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/brauner/linux.git pidfd/for-next
+Auto-merging MAINTAINERS
+Auto-merging include/linux/fs.h
+Merge made by the 'ort' strategy.
+Merging vfs-idmapping/for-next (4021e661a093 Merge branch 'fs.xattr.simple=
.noaudit' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/vfs/idmapping.git vfs-idmapping/for-next
+Auto-merging fs/btrfs/ctree.h
+Auto-merging fs/jffs2/file.c
+Merge made by the 'ort' strategy.
+ Documentation/filesystems/locking.rst |  10 +-
+ Documentation/filesystems/porting.rst |   4 +-
+ Documentation/filesystems/vfs.rst     |   5 +-
+ Documentation/trace/ftrace.rst        |   2 +-
+ fs/9p/acl.c                           | 295 +++++++-------
+ fs/9p/acl.h                           |   8 +-
+ fs/9p/vfs_inode_dotl.c                |   4 +
+ fs/9p/xattr.c                         |   7 +-
+ fs/9p/xattr.h                         |   2 -
+ fs/attr.c                             |  74 +++-
+ fs/bad_inode.c                        |   4 +-
+ fs/btrfs/acl.c                        |   3 +-
+ fs/btrfs/ctree.h                      |   2 +-
+ fs/btrfs/inode.c                      |   8 +-
+ fs/ceph/acl.c                         |   3 +-
+ fs/ceph/dir.c                         |   2 +-
+ fs/ceph/inode.c                       |   4 +-
+ fs/ceph/super.h                       |   2 +-
+ fs/cifs/cifsacl.c                     | 139 +++++++
+ fs/cifs/cifsfs.c                      |   4 +
+ fs/cifs/cifsproto.h                   |  20 +-
+ fs/cifs/cifssmb.c                     | 206 ++++++----
+ fs/cifs/xattr.c                       |  68 +---
+ fs/coredump.c                         |   4 +-
+ fs/ecryptfs/inode.c                   |  32 ++
+ fs/erofs/inode.c                      |   6 +-
+ fs/erofs/namei.c                      |   2 +-
+ fs/exec.c                             |  16 +-
+ fs/ext2/acl.c                         |   3 +-
+ fs/ext2/acl.h                         |   2 +-
+ fs/ext2/file.c                        |   2 +-
+ fs/ext2/inode.c                       |   2 +-
+ fs/ext2/namei.c                       |   4 +-
+ fs/ext4/acl.c                         |   3 +-
+ fs/ext4/acl.h                         |   2 +-
+ fs/ext4/file.c                        |   2 +-
+ fs/ext4/ialloc.c                      |   2 +-
+ fs/ext4/inode.c                       |   2 +-
+ fs/ext4/namei.c                       |   4 +-
+ fs/f2fs/acl.c                         |   4 +-
+ fs/f2fs/acl.h                         |   2 +-
+ fs/f2fs/file.c                        |   4 +-
+ fs/f2fs/namei.c                       |   4 +-
+ fs/fuse/acl.c                         |   5 +-
+ fs/fuse/dir.c                         |   4 +-
+ fs/fuse/file.c                        |   2 +-
+ fs/fuse/fuse_i.h                      |   2 +-
+ fs/gfs2/acl.c                         |   3 +-
+ fs/gfs2/acl.h                         |   2 +-
+ fs/gfs2/inode.c                       |   6 +-
+ fs/inode.c                            |  72 ++--
+ fs/internal.h                         |  35 +-
+ fs/jffs2/acl.c                        |   3 +-
+ fs/jffs2/acl.h                        |   2 +-
+ fs/jffs2/dir.c                        |   2 +-
+ fs/jffs2/file.c                       |   2 +-
+ fs/jffs2/fs.c                         |   2 +-
+ fs/jfs/acl.c                          |   3 +-
+ fs/jfs/file.c                         |   4 +-
+ fs/jfs/jfs_acl.h                      |   2 +-
+ fs/jfs/namei.c                        |   2 +-
+ fs/ksmbd/smb2pdu.c                    |   8 +-
+ fs/ksmbd/smbacl.c                     |   6 +-
+ fs/ksmbd/vfs.c                        |  21 +-
+ fs/ksmbd/vfs.h                        |   4 +-
+ fs/namei.c                            |  44 +--
+ fs/namespace.c                        | 176 +++++++--
+ fs/nfs/nfs3_fs.h                      |   2 +-
+ fs/nfs/nfs3acl.c                      |   9 +-
+ fs/nfs/nfs3proc.c                     |   4 +-
+ fs/nfsd/nfs2acl.c                     |   8 +-
+ fs/nfsd/nfs3acl.c                     |   8 +-
+ fs/nfsd/nfs4acl.c                     |   4 +-
+ fs/nfsd/vfs.c                         |   4 +-
+ fs/ntfs3/file.c                       |   4 +-
+ fs/ntfs3/namei.c                      |   4 +-
+ fs/ntfs3/ntfs_fs.h                    |   4 +-
+ fs/ntfs3/xattr.c                      |   9 +-
+ fs/ocfs2/acl.c                        |   3 +-
+ fs/ocfs2/acl.h                        |   2 +-
+ fs/ocfs2/file.c                       |   8 +-
+ fs/ocfs2/namei.c                      |   2 +-
+ fs/open.c                             |   8 +-
+ fs/orangefs/acl.c                     |  47 +--
+ fs/orangefs/inode.c                   |  47 ++-
+ fs/orangefs/namei.c                   |   2 +-
+ fs/orangefs/orangefs-kernel.h         |   8 +-
+ fs/orangefs/orangefs-utils.c          |  10 +-
+ fs/overlayfs/copy_up.c                |  38 ++
+ fs/overlayfs/dir.c                    |  22 +-
+ fs/overlayfs/file.c                   |  28 +-
+ fs/overlayfs/inode.c                  | 187 +++++++--
+ fs/overlayfs/overlayfs.h              |  42 +-
+ fs/overlayfs/super.c                  | 107 +----
+ fs/overlayfs/util.c                   |   9 +-
+ fs/posix_acl.c                        | 725 +++++++++++++++++------------=
-----
+ fs/reiserfs/acl.h                     |   6 +-
+ fs/reiserfs/file.c                    |   2 +-
+ fs/reiserfs/inode.c                   |   2 +-
+ fs/reiserfs/namei.c                   |   4 +-
+ fs/reiserfs/xattr_acl.c               |  11 +-
+ fs/remap_range.c                      |   2 +-
+ fs/squashfs/super.c                   |   2 +-
+ fs/stat.c                             |   7 +-
+ fs/xattr.c                            | 118 +++---
+ fs/xfs/xfs_acl.c                      |   3 +-
+ fs/xfs/xfs_acl.h                      |   2 +-
+ fs/xfs/xfs_iops.c                     |  16 +-
+ include/linux/evm.h                   |  49 +++
+ include/linux/fs.h                    |  56 +--
+ include/linux/ima.h                   |  24 ++
+ include/linux/lsm_hook_defs.h         |   6 +
+ include/linux/lsm_hooks.h             |  12 +
+ include/linux/mnt_idmapping.h         | 108 ++---
+ include/linux/mount.h                 |   9 +-
+ include/linux/posix_acl.h             |  41 +-
+ include/linux/posix_acl_xattr.h       |  47 ++-
+ include/linux/security.h              |  29 ++
+ include/linux/xattr.h                 |   6 +
+ io_uring/xattr.c                      |   8 +-
+ kernel/capability.c                   |   4 +-
+ mm/shmem.c                            |   2 +-
+ security/apparmor/domain.c            |   8 +-
+ security/apparmor/file.c              |   4 +-
+ security/apparmor/lsm.c               |  25 +-
+ security/commoncap.c                  |  51 +--
+ security/integrity/evm/evm_main.c     | 146 ++++---
+ security/integrity/ima/ima_appraise.c |   9 +
+ security/integrity/ima/ima_policy.c   |  34 +-
+ security/security.c                   |  42 ++
+ security/selinux/hooks.c              |  22 ++
+ security/smack/smack_lsm.c            |  71 ++++
+ 132 files changed, 2292 insertions(+), 1441 deletions(-)
+Merging fscrypt/master (0e91fc1e0f5c fscrypt: work on block_devices instea=
d of request_queues)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/fs/fs=
crypt/fscrypt.git fscrypt/master
+Already up to date.
+Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
+$ git merge -m Merge branch 'fscache-next' of git://git.kernel.org/pub/scm=
/linux/kernel/git/dhowells/linux-fs.git fscache/fscache-next
+Already up to date.
+Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
+$ git merge -m Merge branch 'afs-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/dhowells/linux-fs.git afs/afs-next
+Already up to date.
+Merging btrfs/for-next (4eb8c0548db1 Merge branch 'for-next-next-v6.1-2022=
1104' into for-next-20221104)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/kdave/linux.git btrfs/for-next
+Auto-merging fs/btrfs/acl.c
+Auto-merging fs/btrfs/compression.c
+Auto-merging fs/btrfs/ctree.c
+Auto-merging fs/btrfs/ctree.h
+CONFLICT (content): Merge conflict in fs/btrfs/ctree.h
+Auto-merging fs/btrfs/disk-io.c
+Auto-merging fs/btrfs/inode.c
+Auto-merging fs/btrfs/scrub.c
+Auto-merging fs/btrfs/tests/btrfs-tests.c
+Auto-merging fs/btrfs/volumes.c
+Auto-merging fs/btrfs/volumes.h
+Auto-merging fs/btrfs/zoned.c
+Auto-merging fs/btrfs/zoned.h
+Resolved 'fs/btrfs/ctree.h' using previous resolution.
+Automatic merge failed; fix conflicts and then commit the result.
+$ git commit --no-edit -v -a
+[master 58158579704a] Merge branch 'for-next' of git://git.kernel.org/pub/=
scm/linux/kernel/git/kdave/linux.git
+$ git diff -M --stat --summary HEAD^..
+ fs/btrfs/Makefile                        |    6 +-
+ fs/btrfs/{struct-funcs.c =3D> accessors.c} |   10 +-
+ fs/btrfs/accessors.h                     | 1093 +++++++++
+ fs/btrfs/acl.c                           |    2 +-
+ fs/btrfs/acl.h                           |   27 +
+ fs/btrfs/backref.c                       |  987 +++++---
+ fs/btrfs/backref.h                       |  195 +-
+ fs/btrfs/block-group.c                   |  152 +-
+ fs/btrfs/block-group.h                   |   30 +-
+ fs/btrfs/block-rsv.c                     |   43 +-
+ fs/btrfs/block-rsv.h                     |    6 +-
+ fs/btrfs/btrfs_inode.h                   |  161 +-
+ fs/btrfs/check-integrity.c               |    2 +
+ fs/btrfs/compression.c                   |   12 +-
+ fs/btrfs/compression.h                   |    3 +-
+ fs/btrfs/ctree.c                         |   57 +-
+ fs/btrfs/ctree.h                         | 3901 ++-----------------------=
-----
+ fs/btrfs/defrag.c                        | 1376 +++++++++++
+ fs/btrfs/defrag.h                        |   22 +
+ fs/btrfs/delalloc-space.c                |   61 +-
+ fs/btrfs/delalloc-space.h                |    3 +
+ fs/btrfs/delayed-inode.c                 |   17 +-
+ fs/btrfs/delayed-inode.h                 |    2 +-
+ fs/btrfs/delayed-ref.c                   |   21 +-
+ fs/btrfs/dev-replace.c                   |    3 +
+ fs/btrfs/dev-replace.h                   |    8 +
+ fs/btrfs/dir-item.c                      |   60 +-
+ fs/btrfs/dir-item.h                      |   42 +
+ fs/btrfs/discard.c                       |  112 +-
+ fs/btrfs/disk-io.c                       |   93 +-
+ fs/btrfs/disk-io.h                       |   27 +-
+ fs/btrfs/export.c                        |   25 +-
+ fs/btrfs/export.h                        |    3 +-
+ fs/btrfs/extent-io-tree.c                |  115 +-
+ fs/btrfs/extent-io-tree.h                |   90 +-
+ fs/btrfs/extent-tree.c                   |   40 +-
+ fs/btrfs/extent-tree.h                   |   78 +
+ fs/btrfs/extent_io.c                     |  312 +--
+ fs/btrfs/extent_io.h                     |   28 +-
+ fs/btrfs/extent_map.c                    |  104 +-
+ fs/btrfs/extent_map.h                    |    2 +
+ fs/btrfs/file-item.c                     |   61 +-
+ fs/btrfs/file-item.h                     |   34 +
+ fs/btrfs/file.c                          |  480 +---
+ fs/btrfs/file.h                          |   32 +
+ fs/btrfs/free-space-cache.c              |   52 +-
+ fs/btrfs/free-space-cache.h              |   13 +
+ fs/btrfs/free-space-tree.c               |   15 +-
+ fs/btrfs/fs.c                            |   94 +
+ fs/btrfs/fs.h                            |  976 ++++++++
+ fs/btrfs/inode-item.c                    |   79 +-
+ fs/btrfs/inode-item.h                    |   20 +-
+ fs/btrfs/inode.c                         |  895 +++----
+ fs/btrfs/ioctl.c                         |  934 +------
+ fs/btrfs/ioctl.h                         |   17 +
+ fs/btrfs/locking.c                       |    1 +
+ fs/btrfs/locking.h                       |   76 +
+ fs/btrfs/lzo.c                           |    2 +
+ fs/btrfs/messages.c                      |  369 +++
+ fs/btrfs/messages.h                      |  245 ++
+ fs/btrfs/misc.h                          |   24 +-
+ fs/btrfs/ordered-data.c                  |   25 +-
+ fs/btrfs/ordered-data.h                  |    3 +-
+ fs/btrfs/orphan.c                        |    1 +
+ fs/btrfs/orphan.h                        |   11 +
+ fs/btrfs/print-tree.c                    |    6 +-
+ fs/btrfs/props.c                         |    8 +-
+ fs/btrfs/props.h                         |    2 +-
+ fs/btrfs/qgroup.c                        |   59 +-
+ fs/btrfs/qgroup.h                        |   11 +-
+ fs/btrfs/raid56.c                        | 1513 ++++++------
+ fs/btrfs/raid56.h                        |    2 +-
+ fs/btrfs/ref-verify.c                    |    3 +
+ fs/btrfs/reflink.c                       |   30 +-
+ fs/btrfs/relocation.c                    |   80 +-
+ fs/btrfs/relocation.h                    |   23 +
+ fs/btrfs/root-tree.c                     |   24 +-
+ fs/btrfs/root-tree.h                     |   34 +
+ fs/btrfs/scrub.c                         |   47 +-
+ fs/btrfs/scrub.h                         |   16 +
+ fs/btrfs/send.c                          |  488 +++-
+ fs/btrfs/send.h                          |    6 +-
+ fs/btrfs/space-info.c                    |   84 +-
+ fs/btrfs/space-info.h                    |   78 +
+ fs/btrfs/subpage.c                       |    1 +
+ fs/btrfs/super.c                         |  550 +----
+ fs/btrfs/super.h                         |   29 +
+ fs/btrfs/sysfs.c                         |   16 +-
+ fs/btrfs/tests/btrfs-tests.c             |    3 +-
+ fs/btrfs/tests/extent-buffer-tests.c     |    1 +
+ fs/btrfs/tests/extent-io-tests.c         |    4 +-
+ fs/btrfs/tests/free-space-tree-tests.c   |    3 +-
+ fs/btrfs/tests/inode-tests.c             |   58 +-
+ fs/btrfs/tests/qgroup-tests.c            |   52 +-
+ fs/btrfs/transaction.c                   |   92 +-
+ fs/btrfs/transaction.h                   |   22 +-
+ fs/btrfs/tree-checker.c                  |    5 +-
+ fs/btrfs/tree-defrag.c                   |  132 -
+ fs/btrfs/tree-log.c                      |  331 ++-
+ fs/btrfs/tree-log.h                      |    5 +-
+ fs/btrfs/tree-mod-log.c                  |   22 +-
+ fs/btrfs/tree-mod-log.h                  |    4 +-
+ fs/btrfs/ulist.c                         |   38 +-
+ fs/btrfs/ulist.h                         |    2 +-
+ fs/btrfs/uuid-tree.c                     |    5 +-
+ fs/btrfs/uuid-tree.h                     |   12 +
+ fs/btrfs/verity.c                        |    6 +
+ fs/btrfs/verity.h                        |   28 +
+ fs/btrfs/volumes.c                       |   68 +-
+ fs/btrfs/volumes.h                       |   10 +
+ fs/btrfs/xattr.c                         |    4 +
+ fs/btrfs/zlib.c                          |    4 +-
+ fs/btrfs/zoned.c                         |   18 +-
+ fs/btrfs/zoned.h                         |    1 +
+ fs/btrfs/zstd.c                          |    2 +-
+ include/trace/events/btrfs.h             |   27 +-
+ include/uapi/linux/btrfs_tree.h          |  234 ++
+ 117 files changed, 9581 insertions(+), 8512 deletions(-)
+ rename fs/btrfs/{struct-funcs.c =3D> accessors.c} (96%)
+ create mode 100644 fs/btrfs/accessors.h
+ create mode 100644 fs/btrfs/acl.h
+ create mode 100644 fs/btrfs/defrag.c
+ create mode 100644 fs/btrfs/defrag.h
+ create mode 100644 fs/btrfs/dir-item.h
+ create mode 100644 fs/btrfs/extent-tree.h
+ create mode 100644 fs/btrfs/file-item.h
+ create mode 100644 fs/btrfs/file.h
+ create mode 100644 fs/btrfs/fs.c
+ create mode 100644 fs/btrfs/fs.h
+ create mode 100644 fs/btrfs/ioctl.h
+ create mode 100644 fs/btrfs/messages.c
+ create mode 100644 fs/btrfs/messages.h
+ create mode 100644 fs/btrfs/orphan.h
+ create mode 100644 fs/btrfs/relocation.h
+ create mode 100644 fs/btrfs/root-tree.h
+ create mode 100644 fs/btrfs/scrub.h
+ create mode 100644 fs/btrfs/super.h
+ delete mode 100644 fs/btrfs/tree-defrag.c
+ create mode 100644 fs/btrfs/uuid-tree.h
+ create mode 100644 fs/btrfs/verity.h
+$ git am -3 ../patches/0001-btrfs-for-up-for-fs-pass-dentry-to-set-acl-met=
hod.patch
+Applying: btrfs: fix up for "fs: pass dentry to set acl method"
+$ git reset HEAD^
+Unstaged changes after reset:
+M	fs/btrfs/acl.h
+$ git add -A .
+$ git commit -v -a --amend
+[master 962e3351821a] Merge branch 'for-next' of git://git.kernel.org/pub/=
scm/linux/kernel/git/kdave/linux.git
+ Date: Wed Nov 9 09:31:43 2022 +1100
+$ git am -3 ../patches/0001-btrfs-fix-up-for-btrfs-don-t-print-stack-trace=
-when-.patch
+Applying: btrfs: fix up for "btrfs: don't print stack trace when transacti=
on is aborted due to ENOMEM"
+$ git reset HEAD^
+Unstaged changes after reset:
+M	fs/btrfs/ctree.c
+$ git add -A .
+$ git commit -v -a --amend
+[master eda7a1c063ce] Merge branch 'for-next' of git://git.kernel.org/pub/=
scm/linux/kernel/git/kdave/linux.git
+ Date: Wed Nov 9 09:31:43 2022 +1100
+Merging ceph/master (ffc4d66a34bb ceph: fix a NULL vs IS_ERR() check when =
calling ceph_lookup_inode())
+$ git merge -m Merge branch 'master' of git://github.com/ceph/ceph-client.=
git ceph/master
+Auto-merging MAINTAINERS
+Auto-merging fs/ceph/inode.c
+Merge made by the 'ort' strategy.
+ MAINTAINERS     | 6 +++---
+ fs/ceph/inode.c | 2 +-
+ 2 files changed, 4 insertions(+), 4 deletions(-)
+Merging cifs/for-next (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'for-next' of git://git.samba.org/sfrench/cifs=
-2.6.git cifs/for-next
+Already up to date.
+Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{=
,un}register_subsystem())
+$ git merge -m Merge branch 'for-next' of git://git.infradead.org/users/hc=
h/configfs.git configfs/for-next
+Already up to date.
+Merging ecryptfs/next (c1cc2db21607 ecryptfs: keystore: Fix typo 'the the'=
 in comment)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/tyhicks/ecryptfs.git ecryptfs/next
+Merge made by the 'ort' strategy.
+ fs/ecryptfs/crypto.c     | 8 ++++----
+ fs/ecryptfs/keystore.c   | 2 +-
+ fs/ecryptfs/read_write.c | 8 ++++----
+ 3 files changed, 9 insertions(+), 9 deletions(-)
+Merging erofs/dev (312fe643ad11 erofs: clean up erofs_iget())
+$ git merge -m Merge branch 'dev' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/xiang/erofs.git erofs/dev
+Already up to date.
+Merging exfat/dev (3d0cdf1b32dc exfat: hint the empty entry which at the e=
nd of cluster chain)
+$ git merge -m Merge branch 'dev' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/linkinjeon/exfat.git exfat/dev
+Merge made by the 'ort' strategy.
+ fs/exfat/dir.c   | 76 ++++++++++++++++++++++++++++++++++++---------------=
-----
+ fs/exfat/namei.c | 33 +++++++++++++++---------
+ 2 files changed, 70 insertions(+), 39 deletions(-)
+Merging ext3/for_next (ab7720a2b117 maintainers: Add ISOFS entry)
+$ git merge -m Merge branch 'for_next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/jack/linux-fs.git ext3/for_next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS    | 7 +++++++
+ fs/udf/namei.c | 8 ++++----
+ fs/udf/super.c | 4 ++--
+ 3 files changed, 13 insertions(+), 6 deletions(-)
+Merging ext4/dev (0d043351e5ba ext4: fix fortify warning in fs/ext4/fast_c=
ommit.c:1551)
+$ git merge -m Merge branch 'dev' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/tytso/ext4.git ext4/dev
+Already up to date.
+Merging f2fs/dev (3b21b794b579 f2fs: replace ternary operator with max())
+$ git merge -m Merge branch 'dev' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/jaegeuk/f2fs.git f2fs/dev
+Auto-merging fs/f2fs/file.c
+Auto-merging fs/f2fs/namei.c
+Merge made by the 'ort' strategy.
+ Documentation/ABI/testing/sysfs-fs-f2fs | 22 ++++++---
+ Documentation/filesystems/f2fs.rst      |  3 ++
+ fs/f2fs/checkpoint.c                    |  9 +++-
+ fs/f2fs/f2fs.h                          | 13 +++---
+ fs/f2fs/file.c                          |  6 ++-
+ fs/f2fs/gc.c                            | 40 ++++++++---------
+ fs/f2fs/namei.c                         |  4 +-
+ fs/f2fs/segment.c                       | 19 ++++----
+ fs/f2fs/super.c                         | 12 ++++-
+ fs/f2fs/sysfs.c                         | 79 ++++++++++++++++++----------=
-----
+ include/trace/events/f2fs.h             | 36 ++++++++-------
+ 11 files changed, 147 insertions(+), 96 deletions(-)
+Merging fsverity/fsverity (8377e8a24bba fs-verity: use kmap_local_page() i=
nstead of kmap())
+$ git merge -m Merge branch 'fsverity' of git://git.kernel.org/pub/scm/fs/=
fscrypt/fscrypt.git fsverity/fsverity
+Already up to date.
+Merging fuse/for-next (cbed990fb813 fuse: Rearrange fuse_allow_current_pro=
cess checks)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/mszeredi/fuse.git fuse/for-next
+Auto-merging fs/fuse/acl.c
+Auto-merging fs/fuse/dir.c
+Auto-merging fs/fuse/file.c
+Auto-merging fs/fuse/fuse_i.h
+Merge made by the 'ort' strategy.
+ fs/fuse/cuse.c            |  5 +----
+ fs/fuse/dev.c             |  7 +++----
+ fs/fuse/dir.c             | 43 +++++++++++++++++++++++++------------------
+ fs/fuse/file.c            | 43 ++++++++++++++++++++++++++++++++++++++++---
+ fs/fuse/fuse_i.h          |  4 ++--
+ fs/fuse/readdir.c         |  4 ++--
+ include/uapi/linux/fuse.h | 16 ++++++++++++++--
+ 7 files changed, 87 insertions(+), 35 deletions(-)
+Merging gfs2/for-next (288fc8606762 Merge tag 'gfs2-nopid-for-v6.1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/gfs2/linux-gfs2.git gfs2/for-next
+Already up to date.
+Merging jfs/jfs-next (25e70c6162f2 fs: jfs: fix shift-out-of-bounds in dbD=
iscardAG)
+$ git merge -m Merge branch 'jfs-next' of git://github.com/kleikamp/linux-=
shaggy.git jfs/jfs-next
+Auto-merging MAINTAINERS
+Auto-merging fs/jfs/namei.c
+Merge made by the 'ort' strategy.
+ MAINTAINERS         |  4 ++--
+ fs/jfs/jfs_dmap.c   | 27 +++++++++++++++++++++------
+ fs/jfs/jfs_extent.h |  2 --
+ fs/jfs/jfs_umount.c |  2 --
+ fs/jfs/jfs_xattr.h  |  2 +-
+ fs/jfs/jfs_xtree.h  |  4 ----
+ fs/jfs/namei.c      |  2 +-
+ fs/jfs/super.c      |  6 ++----
+ 8 files changed, 27 insertions(+), 22 deletions(-)
+Merging ksmbd/ksmbd-for-next (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'ksmbd-for-next' of https://github.com/smfrenc=
h/smb3-kernel.git ksmbd/ksmbd-for-next
+Already up to date.
+Merging nfs/linux-next (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'linux-next' of git://git.linux-nfs.org/projec=
ts/trondmy/nfs-2.6.git nfs/linux-next
+Already up to date.
+Merging nfs-anna/linux-next (7e8436728e22 nfs4: Fix kmemleak when allocate=
 slot failed)
+$ git merge -m Merge branch 'linux-next' of git://git.linux-nfs.org/projec=
ts/anna/linux-nfs.git nfs-anna/linux-next
+Already up to date.
+Merging nfsd/for-next (f15ab65c1bb7 nfsd: return error if nfs4_setacl fail=
s)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/cel/linux nfsd/for-next
+Auto-merging MAINTAINERS
+Auto-merging fs/nfsd/filecache.c
+Auto-merging fs/nfsd/nfs2acl.c
+Auto-merging fs/nfsd/nfs3acl.c
+Auto-merging fs/nfsd/nfs4state.c
+Auto-merging fs/nfsd/vfs.c
+Merge made by the 'ort' strategy.
+ MAINTAINERS                |   1 +
+ fs/exportfs/expfs.c        |   8 +-
+ fs/lockd/svcsubs.c         |  17 +-
+ fs/nfsd/Kconfig            |  19 +-
+ fs/nfsd/Makefile           |   5 +-
+ fs/nfsd/blocklayout.c      |   1 +
+ fs/nfsd/blocklayoutxdr.c   |   1 +
+ fs/nfsd/export.h           |   1 -
+ fs/nfsd/filecache.c        | 492 ++++++++++++++++++++++++++--------------=
-----
+ fs/nfsd/filecache.h        |   5 +-
+ fs/nfsd/flexfilelayout.c   |   1 +
+ fs/nfsd/nfs2acl.c          |  10 -
+ fs/nfsd/nfs3acl.c          |  30 +--
+ fs/nfsd/nfs3proc.c         |  10 +-
+ fs/nfsd/nfs4idmap.c        |   1 +
+ fs/nfsd/nfs4proc.c         |  44 ++--
+ fs/nfsd/nfs4state.c        | 217 +++++++++++---------
+ fs/nfsd/nfs4xdr.c          | 139 +++----------
+ fs/nfsd/nfsctl.c           |   6 +-
+ fs/nfsd/nfsd.h             |   3 +-
+ fs/nfsd/nfsfh.h            |  10 +-
+ fs/nfsd/nfsproc.c          |  62 ------
+ fs/nfsd/nfssvc.c           |   6 +
+ fs/nfsd/state.h            |   5 +-
+ fs/nfsd/trace.h            | 143 ++++++++++---
+ fs/nfsd/vfs.c              |  83 ++++++--
+ fs/nfsd/vfs.h              |   4 +-
+ include/linux/sunrpc/svc.h |   8 -
+ net/sunrpc/svc.c           |   1 -
+ 29 files changed, 717 insertions(+), 616 deletions(-)
+Merging ntfs3/master (0d6d7c61ffee fs/ntfs3: Don't use uni1 uninitialized =
in ntfs_d_compare())
+$ git merge -m Merge branch 'master' of https://github.com/Paragon-Softwar=
e-Group/linux-ntfs3.git ntfs3/master
+Auto-merging fs/ntfs3/bitmap.c
+Auto-merging fs/ntfs3/fslog.c
+Auto-merging fs/ntfs3/inode.c
+Auto-merging fs/ntfs3/namei.c
+Auto-merging fs/ntfs3/ntfs_fs.h
+Auto-merging fs/ntfs3/xattr.c
+CONFLICT (content): Merge conflict in fs/ntfs3/xattr.c
+Resolved 'fs/ntfs3/xattr.c' using previous resolution.
+Automatic merge failed; fix conflicts and then commit the result.
+$ git commit --no-edit -v -a
+[master ae312f2582c9] Merge branch 'master' of https://github.com/Paragon-=
Software-Group/linux-ntfs3.git
+$ git diff -M --stat --summary HEAD^..
+ fs/ntfs3/attrib.c   |  20 +++++++-
+ fs/ntfs3/attrlist.c |   5 ++
+ fs/ntfs3/bitmap.c   |   2 +-
+ fs/ntfs3/frecord.c  |  17 ++++++-
+ fs/ntfs3/fslog.c    |  33 ++++++++-----
+ fs/ntfs3/index.c    |   8 +++-
+ fs/ntfs3/inode.c    | 122 ++++++++++++++++++++++++++++++++++++++++++++++-
+ fs/ntfs3/namei.c    | 135 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++
+ fs/ntfs3/ntfs_fs.h  |   5 ++
+ fs/ntfs3/record.c   |  14 ++++++
+ fs/ntfs3/super.c    |  68 +++++++++++++++++---------
+ fs/ntfs3/upcase.c   |  12 +++++
+ fs/ntfs3/xattr.c    |  26 ++++------
+ 13 files changed, 409 insertions(+), 58 deletions(-)
+Merging orangefs/for-next (2ad4b6f5e117 Orangefs: change iterate to iterat=
e_shared)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/hubcap/linux orangefs/for-next
+Already up to date.
+Merging overlayfs/overlayfs-next (b337e5ae0e42 ovl: Kconfig: Fix spelling =
mistake "undelying" -> "underlying")
+$ git merge -m Merge branch 'overlayfs-next' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/mszeredi/vfs.git overlayfs/overlayfs-next
+Auto-merging fs/overlayfs/dir.c
+Auto-merging fs/overlayfs/file.c
+Auto-merging fs/overlayfs/namei.c
+Auto-merging fs/overlayfs/overlayfs.h
+Auto-merging fs/overlayfs/readdir.c
+Auto-merging fs/overlayfs/util.c
+Merge made by the 'ort' strategy.
+ fs/overlayfs/Kconfig     |  2 +-
+ fs/overlayfs/dir.c       | 46 +++++++++++++++++++++++++-------------
+ fs/overlayfs/export.c    |  8 +++----
+ fs/overlayfs/file.c      |  2 +-
+ fs/overlayfs/namei.c     | 12 +++++++---
+ fs/overlayfs/overlayfs.h | 11 ++++-----
+ fs/overlayfs/readdir.c   | 58 ++++++++++++++++++++++---------------------=
-----
+ fs/overlayfs/util.c      |  6 ++---
+ 8 files changed, 79 insertions(+), 66 deletions(-)
+Merging ubifs/next (669d204469c4 ubi: fastmap: Add fastmap control support=
 for 'UBI_IOCATT' ioctl)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/rw/ubifs.git ubifs/next
+Already up to date.
+Merging v9fs/9p-next (a8e633c60447 net/9p: clarify trans_fd parse_opt fail=
ure handling)
+$ git merge -m Merge branch '9p-next' of git://github.com/martinetd/linux =
v9fs/9p-next
+Already up to date.
+Merging xfs/for-next (4eb559dd1567 Merge tag 'refcount-cow-domain-6.1_2022=
-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux i=
nto xfs-6.1-fixesA)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/fs/=
xfs/xfs-linux.git xfs/for-next
+Already up to date.
+Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page =
acquired with GFP_KERNEL flag)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/dlemoal/zonefs.git zonefs/for-next
+Already up to date.
+Merging iomap/iomap-for-next (adc9c2e5a723 iomap: add a tracepoint for map=
pings returned by map_blocks)
+$ git merge -m Merge branch 'iomap-for-next' of git://git.kernel.org/pub/s=
cm/fs/xfs/xfs-linux.git iomap/iomap-for-next
+Already up to date.
+Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in iom=
ap_fiemap)
+$ git merge -m Merge branch 'vfs-for-next' of git://git.kernel.org/pub/scm=
/fs/xfs/xfs-linux.git djw-vfs/vfs-for-next
+Already up to date.
+Merging file-locks/locks-next (072e51356cd5 Merge tag 'nfs-for-5.20-2' of =
git://git.linux-nfs.org/projects/trondmy/linux-nfs)
+$ git merge -m Merge branch 'locks-next' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/jlayton/linux.git file-locks/locks-next
+Already up to date.
+Merging iversion/iversion-next (2b3319b35573 nfsd: remove fetch_iversion e=
xport operation)
+$ git merge -m Merge branch 'iversion-next' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/jlayton/linux.git iversion/iversion-next
+Auto-merging fs/ceph/inode.c
+Auto-merging fs/nfsd/nfs4xdr.c
+Auto-merging fs/nfsd/nfsfh.c
+Auto-merging fs/nfsd/nfsfh.h
+Auto-merging fs/nfsd/vfs.h
+Auto-merging fs/stat.c
+Merge made by the 'ort' strategy.
+ fs/ceph/inode.c          | 16 ++++++++-----
+ fs/libfs.c               | 36 ++++++++++++++++++++++++++++++
+ fs/nfs/export.c          |  7 ------
+ fs/nfs/inode.c           | 16 +++++++++----
+ fs/nfsd/nfs4xdr.c        |  4 +++-
+ fs/nfsd/nfsfh.c          | 42 +++++++++++++++++++++++++++++++++++
+ fs/nfsd/nfsfh.h          | 29 +-----------------------
+ fs/nfsd/vfs.h            |  7 +++++-
+ fs/stat.c                | 17 ++++++++++++--
+ include/linux/exportfs.h |  1 -
+ include/linux/iversion.h | 58 +++++++++++++++++--------------------------=
-----
+ include/linux/stat.h     |  9 ++++++++
+ 12 files changed, 155 insertions(+), 87 deletions(-)
+Merging vfs/for-next (3aca47127a64 fs: drop useless condition from inode_n=
eeds_update_time)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/viro/vfs.git vfs/for-next
+Auto-merging fs/inode.c
+Merge made by the 'ort' strategy.
+ fs/inode.c | 3 ---
+ 1 file changed, 3 deletions(-)
+Merging printk/for-next (950a9751c1d1 Merge branch 'for-6.2' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/printk/linux.git printk/for-next
+Merge made by the 'ort' strategy.
+ lib/test_printf.c | 26 ++++++++++++--------------
+ lib/vsprintf.c    |  2 +-
+ 2 files changed, 13 insertions(+), 15 deletions(-)
+Merging pci/next (652ce11a7604 Merge branch 'remotes/lorenzo/pci/tegra')
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/helgaas/pci.git pci/next
+Auto-merging drivers/pci/controller/pci-tegra.c
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |   7 +
+ .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |  20 ++
+ drivers/char/agp/amd-k7-agp.c                      |  24 +-
+ drivers/char/agp/amd64-agp.c                       |   6 +-
+ drivers/char/agp/ati-agp.c                         |  22 +-
+ drivers/char/agp/efficeon-agp.c                    |  16 +-
+ drivers/char/agp/intel-agp.c                       |  11 +-
+ drivers/char/agp/nvidia-agp.c                      |  24 +-
+ drivers/char/agp/sis-agp.c                         |   7 +-
+ drivers/char/agp/via-agp.c                         |   6 +-
+ drivers/pci/controller/dwc/pcie-designware-ep.c    |  19 +-
+ drivers/pci/controller/dwc/pcie-designware.c       |   2 +-
+ drivers/pci/controller/pci-tegra.c                 |   9 +-
+ drivers/pci/pci-driver.c                           |   8 +-
+ drivers/pci/pcie/Makefile                          |   2 +-
+ drivers/pci/pcie/{portdrv_core.c =3D> portdrv.c}     | 263 ++++++++++++++=
++++++-
+ drivers/pci/pcie/portdrv.h                         |  19 --
+ drivers/pci/pcie/portdrv_pci.c                     | 252 ----------------=
----
+ include/uapi/linux/pci_regs.h                      |   1 +
+ 19 files changed, 336 insertions(+), 382 deletions(-)
+ rename drivers/pci/pcie/{portdrv_core.c =3D> portdrv.c} (69%)
+ delete mode 100644 drivers/pci/pcie/portdrv_pci.c
+Merging pstore/for-next/pstore (38b91847c314 pstore: Alert on backend writ=
e error)
+$ git merge -m Merge branch 'for-next/pstore' of git://git.kernel.org/pub/=
scm/linux/kernel/git/kees/linux.git pstore/for-next/pstore
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS                       |  8 ++--
+ drivers/firmware/efi/efi-pstore.c |  2 +-
+ fs/pstore/platform.c              | 25 ++++++++--
+ fs/pstore/ram.c                   | 42 +++++++++--------
+ fs/pstore/ram_core.c              | 14 ++++--
+ fs/pstore/ram_internal.h          | 98 ++++++++++++++++++++++++++++++++++=
++++
+ fs/pstore/zone.c                  |  2 +-
+ include/linux/pstore_ram.h        | 99 ----------------------------------=
-----
+ 8 files changed, 158 insertions(+), 132 deletions(-)
+ create mode 100644 fs/pstore/ram_internal.h
+Merging hid/for-next (29e97b78fbda Merge branch 'for-6.2/uclogic' into for=
-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/hid/hid.git hid/for-next
+Merge made by the 'ort' strategy.
+ drivers/hid/Kconfig                     |   3 +-
+ drivers/hid/hid-apple.c                 | 118 ++++++------
+ drivers/hid/hid-asus.c                  |   4 +-
+ drivers/hid/hid-hyperv.c                |  33 ++--
+ drivers/hid/hid-input.c                 |   6 +
+ drivers/hid/hid-mcp2221.c               | 313 +++++++++++++++++++++++++++=
++---
+ drivers/hid/hid-uclogic-params.c        |  73 ++++++++
+ drivers/hid/hid-uclogic-rdesc.c         |  34 ++++
+ drivers/hid/hid-uclogic-rdesc.h         |   7 +
+ drivers/hid/hid-wiimote-core.c          |   7 +
+ drivers/hid/hid-wiimote-modules.c       | 225 +++++++++++++++++++++++
+ drivers/hid/hid-wiimote.h               |   1 +
+ drivers/hid/i2c-hid/i2c-hid-of-elan.c   |   5 +-
+ drivers/hid/i2c-hid/i2c-hid-of-goodix.c |   5 +-
+ drivers/hid/i2c-hid/i2c-hid-of.c        |   5 +-
+ drivers/hid/wacom_wac.c                 |  11 +-
+ 16 files changed, 719 insertions(+), 131 deletions(-)
+Merging i2c/i2c/for-next (befeb20d3813 Merge branch 'i2c/for-mergewindow' =
into i2c/for-next)
+$ git merge -m Merge branch 'i2c/for-next' of git://git.kernel.org/pub/scm=
/linux/kernel/git/wsa/linux.git i2c/i2c/for-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ .../bindings/i2c/hisilicon,ascend910-i2c.yaml      | 73 ++++++++++++++++++
+ .../devicetree/bindings/i2c/i2c-mt65xx.yaml        |  1 +
+ .../bindings/i2c/marvell,mv64xxx-i2c.yaml          |  1 +
+ MAINTAINERS                                        |  1 +
+ drivers/i2c/busses/Kconfig                         |  2 +-
+ drivers/i2c/busses/i2c-amd-mp2-pci.c               | 30 +++++---
+ drivers/i2c/busses/i2c-amd-mp2.h                   |  1 +
+ drivers/i2c/busses/i2c-hisi.c                      |  7 ++
+ drivers/i2c/busses/i2c-mt65xx.c                    | 14 ++++
+ drivers/i2c/busses/i2c-npcm7xx.c                   | 87 +++++++++++------=
-----
+ 10 files changed, 163 insertions(+), 54 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/i2c/hisilicon,ascend=
910-i2c.yaml
+Merging i3c/i3c/next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'i3c/next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/i3c/linux.git i3c/i3c/next
+Already up to date.
+Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point =
length checks)
+$ git merge -m Merge branch 'dmi-for-next' of git://git.kernel.org/pub/scm=
/linux/kernel/git/jdelvare/staging.git dmi/dmi-for-next
+Already up to date.
+Merging hwmon-staging/hwmon-next (4abf03c1fb6c docs: hwmon: (smpro-hwmon) =
Improve grammar and formatting)
+$ git merge -m Merge branch 'hwmon-next' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/groeck/linux-staging.git hwmon-staging/hwmon-next
+Merge made by the 'ort' strategy.
+ Documentation/hwmon/aquacomputer_d5next.rst |   1 +
+ Documentation/hwmon/index.rst               |   1 +
+ Documentation/hwmon/smpro-hwmon.rst         | 102 ++++++
+ drivers/hwmon/Kconfig                       |   9 +
+ drivers/hwmon/Makefile                      |   1 +
+ drivers/hwmon/adm1177.c                     |  27 +-
+ drivers/hwmon/aht10.c                       |   5 +-
+ drivers/hwmon/aquacomputer_d5next.c         |  88 +++++-
+ drivers/hwmon/emc2305.c                     |   4 +-
+ drivers/hwmon/fschmd.c                      |   4 +-
+ drivers/hwmon/it87.c                        |  18 +-
+ drivers/hwmon/jc42.c                        | 273 +++++++++-------
+ drivers/hwmon/lm90.c                        |  20 +-
+ drivers/hwmon/ltc2992.c                     |   4 +-
+ drivers/hwmon/max127.c                      |   5 +-
+ drivers/hwmon/occ/Kconfig                   |   2 -
+ drivers/hwmon/pmbus/ltc2978.c               |  17 +-
+ drivers/hwmon/sbrmi.c                       |   5 +-
+ drivers/hwmon/sbtsi_temp.c                  |   5 +-
+ drivers/hwmon/sht4x.c                       |   5 +-
+ drivers/hwmon/smpro-hwmon.c                 | 466 +++++++++++++++++++++++=
+++++
+ 21 files changed, 856 insertions(+), 206 deletions(-)
+ create mode 100644 Documentation/hwmon/smpro-hwmon.rst
+ create mode 100644 drivers/hwmon/smpro-hwmon.c
+Merging jc_docs/docs-next (07ab97fe7f8a Merge branch 'docs-mw' into docs-n=
ext)
+$ git merge -m Merge branch 'docs-next' of git://git.lwn.net/linux.git jc_=
docs/docs-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ Documentation/admin-guide/sysctl/fs.rst            | 240 ++++----
+ Documentation/admin-guide/sysctl/kernel.rst        |   2 +
+ Documentation/arm/marvell.rst                      |  12 +-
+ Documentation/conf.py                              | 207 +------
+ Documentation/doc-guide/sphinx.rst                 |  16 +-
+ Documentation/sphinx-static/custom.css             |  29 +
+ Documentation/sphinx/requirements.txt              |   1 -
+ Documentation/translations/index.rst               |   1 +
+ Documentation/translations/sp_SP/disclaimer-sp.rst |   6 +
+ Documentation/translations/sp_SP/howto.rst         | 617 ++++++++++++++++=
+++++
+ Documentation/translations/sp_SP/index.rst         |  80 +++
+ .../translations/zh_CN/core-api/errseq.rst         | 145 +++++
+ .../translations/zh_CN/core-api/index.rst          |   6 +-
+ .../translations/zh_CN/core-api/this_cpu_ops.rst   | 285 ++++++++++
+ Documentation/translations/zh_CN/index.rst         |  11 +-
+ .../translations/zh_CN/rust/arch-support.rst       |  23 +
+ .../translations/zh_CN/rust/coding-guidelines.rst  | 192 +++++++
+ .../zh_CN/rust/general-information.rst             |  75 +++
+ Documentation/translations/zh_CN/rust/index.rst    |  28 +
+ .../translations/zh_CN/rust/quick-start.rst        | 211 +++++++
+ Documentation/translations/zh_CN/staging/index.rst |  26 +
+ Documentation/translations/zh_CN/staging/xz.rst    | 100 ++++
+ .../zh_CN/userspace-api/ebpf/index.rst             |  22 +
+ .../zh_CN/userspace-api/ebpf/syscall.rst           |  29 +
+ .../translations/zh_CN/userspace-api/index.rst     |  50 ++
+ .../zh_CN/userspace-api/no_new_privs.rst           |  57 ++
+ .../zh_CN/userspace-api/sysfs-platform_profile.rst |  40 ++
+ MAINTAINERS                                        |   5 +
+ scripts/kernel-doc                                 |  54 +-
+ scripts/sphinx-pre-install                         |   8 -
+ 30 files changed, 2200 insertions(+), 378 deletions(-)
+ create mode 100644 Documentation/sphinx-static/custom.css
+ create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
+ create mode 100644 Documentation/translations/sp_SP/howto.rst
+ create mode 100644 Documentation/translations/sp_SP/index.rst
+ create mode 100644 Documentation/translations/zh_CN/core-api/errseq.rst
+ create mode 100644 Documentation/translations/zh_CN/core-api/this_cpu_ops=
.rst
+ create mode 100644 Documentation/translations/zh_CN/rust/arch-support.rst
+ create mode 100644 Documentation/translations/zh_CN/rust/coding-guideline=
s.rst
+ create mode 100644 Documentation/translations/zh_CN/rust/general-informat=
ion.rst
+ create mode 100644 Documentation/translations/zh_CN/rust/index.rst
+ create mode 100644 Documentation/translations/zh_CN/rust/quick-start.rst
+ create mode 100644 Documentation/translations/zh_CN/staging/index.rst
+ create mode 100644 Documentation/translations/zh_CN/staging/xz.rst
+ create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/in=
dex.rst
+ create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/sy=
scall.rst
+ create mode 100644 Documentation/translations/zh_CN/userspace-api/index.r=
st
+ create mode 100644 Documentation/translations/zh_CN/userspace-api/no_new_=
privs.rst
+ create mode 100644 Documentation/translations/zh_CN/userspace-api/sysfs-p=
latform_profile.rst
+Merging v4l-dvb/master (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'master' of git://linuxtv.org/media_tree.git v=
4l-dvb/master
+Already up to date.
+Merging v4l-dvb-next/master (1e284ea984d3 Merge git://linuxtv.org/sailus/m=
edia_tree into media_stage)
+$ git merge -m Merge branch 'master' of git://linuxtv.org/mchehab/media-ne=
xt.git v4l-dvb-next/master
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ Documentation/admin-guide/media/vimc.rst           |    8 +-
+ .../devicetree/bindings/media/i2c/imx290.txt       |   57 -
+ .../devicetree/bindings/media/i2c/ovti,ov4689.yaml |  134 +
+ .../devicetree/bindings/media/i2c/sony,imx290.yaml |  129 +
+ .../bindings/media/i2c/st,st-vgxy61.yaml           |  113 +
+ .../bindings/media/i2c/toshiba,tc358746.yaml       |  178 ++
+ .../bindings/media/mediatek,mt8195-jpegdec.yaml    |  168 +
+ .../bindings/media/mediatek,mt8195-jpegenc.yaml    |  147 +
+ .../bindings/media/mediatek-jpeg-decoder.yaml      |    1 +
+ .../bindings/media/mediatek-jpeg-encoder.yaml      |    1 +
+ .../userspace-api/media/drivers/st-vgxy61.rst      |   23 +
+ .../userspace-api/media/v4l/ext-ctrls-camera.rst   |    8 +
+ .../userspace-api/media/v4l/subdev-formats.rst     |   37 +
+ MAINTAINERS                                        |   27 +-
+ drivers/media/i2c/Kconfig                          |   53 +
+ drivers/media/i2c/Makefile                         |    4 +
+ drivers/media/i2c/ad5820.c                         |   10 +-
+ drivers/media/i2c/dw9768.c                         |   33 +-
+ drivers/media/i2c/hi846.c                          |   14 +-
+ drivers/media/i2c/imx290.c                         |  786 +++--
+ drivers/media/i2c/ov08x40.c                        | 3327 +++++++++++++++=
+++++
+ drivers/media/i2c/ov2640.c                         |    2 -
+ drivers/media/i2c/ov4689.c                         | 1018 ++++++
+ drivers/media/i2c/ov5645.c                         |    2 +-
+ drivers/media/i2c/ov5648.c                         |    1 +
+ drivers/media/i2c/ov7670.c                         |    1 -
+ drivers/media/i2c/ov8856.c                         |   33 +-
+ drivers/media/i2c/ov9650.c                         |   49 +-
+ drivers/media/i2c/st-vgxy61.c                      | 1962 ++++++++++++
+ drivers/media/i2c/tc358746.c                       | 1694 ++++++++++
+ drivers/media/platform/mediatek/jpeg/Makefile      |   14 +-
+ .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |  490 ++-
+ .../media/platform/mediatek/jpeg/mtk_jpeg_core.h   |  169 +-
+ .../media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c |  315 +-
+ .../media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h |    6 +-
+ .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h      |    1 +
+ .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |  255 ++
+ drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c  |    4 +-
+ drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |  610 +++-
+ drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h     |   10 +-
+ drivers/media/platform/qcom/camss/camss-vfe-170.c  |   20 +-
+ drivers/media/platform/qcom/camss/camss-vfe-480.c  |   20 +-
+ drivers/media/platform/qcom/camss/camss-video.c    |    3 +-
+ drivers/media/platform/qcom/camss/camss.c          |   61 +-
+ drivers/media/platform/qcom/camss/camss.h          |    1 +
+ .../media/platform/samsung/exynos4-is/media-dev.c  |    4 +-
+ drivers/media/v4l2-core/v4l2-ctrls-defs.c          |    2 +
+ drivers/media/v4l2-core/v4l2-subdev.c              |   15 +
+ drivers/phy/phy-core-mipi-dphy.c                   |   31 +-
+ drivers/staging/media/ipu3/ipu3-v4l2.c             |   57 +-
+ include/linux/phy/phy-mipi-dphy.h                  |    3 +
+ include/media/i2c/ov9650.h                         |   24 -
+ include/media/media-entity.h                       |    4 +-
+ include/media/v4l2-subdev.h                        |   11 +-
+ include/uapi/linux/media-bus-format.h              |    3 +-
+ include/uapi/linux/v4l2-controls.h                 |    2 +
+ 56 files changed, 11344 insertions(+), 811 deletions(-)
+ delete mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt
+ create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov468=
9.yaml
+ create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx29=
0.yaml
+ create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-vgxy=
61.yaml
+ create mode 100644 Documentation/devicetree/bindings/media/i2c/toshiba,tc=
358746.yaml
+ create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt819=
5-jpegdec.yaml
+ create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt819=
5-jpegenc.yaml
+ create mode 100644 Documentation/userspace-api/media/drivers/st-vgxy61.rst
+ create mode 100644 drivers/media/i2c/ov08x40.c
+ create mode 100644 drivers/media/i2c/ov4689.c
+ create mode 100644 drivers/media/i2c/st-vgxy61.c
+ create mode 100644 drivers/media/i2c/tc358746.c
+ delete mode 100644 include/media/i2c/ov9650.h
+Merging pm/linux-next (fd856f9c4ef3 Merge branch 'acpica' into linux-next)
+$ git merge -m Merge branch 'linux-next' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/rafael/linux-pm.git pm/linux-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS                              |   1 +
+ arch/loongarch/include/asm/acpi.h        | 142 ---------
+ drivers/acpi/acpica/Makefile             |   1 +
+ drivers/acpi/acpica/acglobal.h           |   1 +
+ drivers/acpi/acpica/actables.h           |   5 -
+ drivers/acpi/acpica/acutils.h            |  13 +
+ drivers/acpi/acpica/evevent.c            |  11 +
+ drivers/acpi/acpica/evregion.c           |   9 +
+ drivers/acpi/acpica/exconfig.c           |   4 +-
+ drivers/acpi/acpica/exfield.c            |   8 +-
+ drivers/acpi/acpica/exserial.c           |   6 +
+ drivers/acpi/acpica/hwsleep.c            |  14 +
+ drivers/acpi/acpica/tbdata.c             |   2 +-
+ drivers/acpi/acpica/tbfadt.c             |   2 +-
+ drivers/acpi/acpica/tbprint.c            |  77 +----
+ drivers/acpi/acpica/tbutils.c            |   2 +-
+ drivers/acpi/acpica/tbxfroot.c           |  32 +-
+ drivers/acpi/acpica/utcksum.c            | 170 +++++++++++
+ drivers/acpi/acpica/utglobal.c           |   4 +
+ drivers/acpi/acpica/utstring.c           |  10 +-
+ drivers/acpi/apei/ghes.c                 |  62 ++--
+ drivers/acpi/ec.c                        |  10 +
+ drivers/acpi/processor_idle.c            |   3 +
+ drivers/acpi/processor_throttling.c      |   4 +-
+ drivers/acpi/scan.c                      |   2 +-
+ drivers/acpi/sysfs.c                     |   3 +-
+ drivers/acpi/tables.c                    |  10 +
+ drivers/base/power/domain.c              | 114 +++----
+ drivers/cpufreq/acpi-cpufreq.c           |  36 +--
+ drivers/cpufreq/intel_pstate.c           |   9 +-
+ drivers/cpufreq/longhaul.c               |   4 +-
+ drivers/cpufreq/spear-cpufreq.c          |   2 +-
+ drivers/cpuidle/cpuidle-psci-domain.c    |   3 +-
+ drivers/cpuidle/dt_idle_states.c         |  11 +-
+ drivers/powercap/Kconfig                 |  13 +
+ drivers/powercap/Makefile                |   1 +
+ drivers/powercap/arm_scmi_powercap.c     | 509 ++++++++++++++++++++++++++=
+++++
+ drivers/powercap/powercap_sys.c          |   3 +-
+ drivers/thermal/gov_fair_share.c         |   6 +-
+ drivers/thermal/intel/intel_hfi.c        |   2 +-
+ drivers/thermal/thermal_core.c           |  16 +-
+ drivers/thermal/thermal_sysfs.c          |  37 +--
+ include/acpi/acconfig.h                  |   2 +
+ include/acpi/actbl1.h                    | 151 ++++++++-
+ include/acpi/actbl2.h                    | 162 +++++++++-
+ include/acpi/actypes.h                   |  10 +-
+ include/acpi/acuuid.h                    |   3 +-
+ include/linux/thermal.h                  |   1 +
+ kernel/power/snapshot.c                  |   4 +-
+ tools/power/acpi/tools/acpidump/Makefile |   1 +
+ tools/power/acpi/tools/acpidump/apdump.c |   4 +-
+ 51 files changed, 1263 insertions(+), 449 deletions(-)
+ create mode 100644 drivers/acpi/acpica/utcksum.c
+ create mode 100644 drivers/powercap/arm_scmi_powercap.c
+Merging cpufreq-arm/cpufreq/arm/linux-next (1313edfdcd79 arm64: dts: ti: k=
3-am625-sk: Add 1.4GHz OPP)
+$ git merge -m Merge branch 'cpufreq/arm/linux-next' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq-arm/cpufreq/arm/linux-ne=
xt
+Auto-merging arch/arm64/boot/dts/ti/k3-am625-sk.dts
+Merge made by the 'ort' strategy.
+ .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |  18 +++
+ arch/arm64/boot/dts/ti/k3-am625-sk.dts             |   9 ++
+ arch/arm64/boot/dts/ti/k3-am625.dtsi               |  51 +++++++++
+ drivers/cpufreq/Kconfig.arm                        |   4 +-
+ drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
+ drivers/cpufreq/mediatek-cpufreq-hw.c              |  14 ++-
+ drivers/cpufreq/qcom-cpufreq-hw.c                  | 123 +++++++++-------=
-----
+ drivers/cpufreq/ti-cpufreq.c                       |  36 ++++++
+ include/linux/cpufreq.h                            |  28 +++--
+ 9 files changed, 196 insertions(+), 88 deletions(-)
+Merging cpupower/cpupower (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'cpupower' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/shuah/linux.git cpupower/cpupower
+Already up to date.
+Merging devfreq/devfreq-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'devfreq-next' of git://git.kernel.org/pub/scm=
/linux/kernel/git/chanwoo/linux.git devfreq/devfreq-next
+Already up to date.
+Merging opp/opp/linux-next (dba79b78ecc1 dt-bindings: opp-v2: Fix clock-la=
tency-ns prop in example)
+$ git merge -m Merge branch 'opp/linux-next' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/vireshk/pm.git opp/opp/linux-next
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/opp/opp-v2-base.yaml       |   6 +-
+ Documentation/devicetree/bindings/opp/opp-v2.yaml  |   2 +-
+ drivers/opp/of.c                                   | 228 +++++++++-------=
-----
+ 3 files changed, 103 insertions(+), 133 deletions(-)
+Merging thermal/thermal/linux-next (9d2bc364f677 thermal/drivers/qcom/tsen=
s: Simplify debugfs init function)
+$ git merge -m Merge branch 'thermal/linux-next' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/thermal/linux.git thermal/thermal/linux-next
+Auto-merging drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+Auto-merging drivers/platform/x86/acerhdf.c
+Auto-merging drivers/thermal/gov_fair_share.c
+Auto-merging drivers/thermal/thermal_core.c
+Auto-merging drivers/thermal/thermal_netlink.c
+Auto-merging drivers/thermal/thermal_sysfs.c
+Auto-merging include/linux/thermal.h
+Merge made by the 'ort' strategy.
+ .../bindings/thermal/generic-adc-thermal.yaml      |  84 +++++++++
+ .../devicetree/bindings/thermal/qcom-tsens.yaml    |  77 ++++++--
+ .../bindings/thermal/thermal-generic-adc.txt       |  95 ----------
+ drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |   2 -
+ drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |  39 +---
+ drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 209 +++++-----------=
-----
+ drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   2 +-
+ drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |  71 ++-----
+ drivers/platform/x86/acerhdf.c                     |  73 +++----
+ drivers/thermal/armada_thermal.c                   |  37 ++--
+ drivers/thermal/broadcom/bcm2835_thermal.c         |   8 +-
+ drivers/thermal/da9062-thermal.c                   |  52 +----
+ drivers/thermal/gov_bang_bang.c                    |  37 ++--
+ drivers/thermal/gov_fair_share.c                   |  18 +-
+ drivers/thermal/gov_power_allocator.c              |  51 +++--
+ drivers/thermal/gov_step_wise.c                    |  22 +--
+ drivers/thermal/hisi_thermal.c                     |  11 +-
+ drivers/thermal/imx8mm_thermal.c                   |  12 +-
+ drivers/thermal/imx_thermal.c                      |  72 +++----
+ .../intel/int340x_thermal/int340x_thermal_zone.c   |  33 ++--
+ .../intel/int340x_thermal/int340x_thermal_zone.h   |   4 +-
+ .../int340x_thermal/processor_thermal_device.c     |  10 +-
+ drivers/thermal/intel/x86_pkg_temp_thermal.c       | 120 ++++++------
+ drivers/thermal/k3_j72xx_bandgap.c                 |   2 +-
+ drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  39 ++--
+ drivers/thermal/qcom/tsens-8960.c                  |   3 +
+ drivers/thermal/qcom/tsens-v0_1.c                  |   3 +
+ drivers/thermal/qcom/tsens-v1.c                    |   3 +
+ drivers/thermal/qcom/tsens-v2.c                    |  20 ++
+ drivers/thermal/qcom/tsens.c                       |  68 +++++--
+ drivers/thermal/qcom/tsens.h                       |   8 +-
+ drivers/thermal/rcar_gen3_thermal.c                |   2 +-
+ drivers/thermal/rcar_thermal.c                     |  53 +-----
+ drivers/thermal/samsung/exynos_tmu.c               |  62 +++---
+ drivers/thermal/st/st_thermal.c                    |  47 +----
+ drivers/thermal/tegra/soctherm.c                   |  35 ++--
+ drivers/thermal/tegra/tegra30-tsensor.c            |  17 +-
+ drivers/thermal/thermal_core.c                     | 160 +++++++++++++---
+ drivers/thermal/thermal_core.h                     |  24 +--
+ drivers/thermal/thermal_helpers.c                  |  28 +--
+ drivers/thermal/thermal_netlink.c                  |  19 +-
+ drivers/thermal/thermal_of.c                       | 124 +-----------
+ drivers/thermal/thermal_sysfs.c                    | 133 +++++--------
+ drivers/thermal/ti-soc-thermal/ti-thermal.h        |  15 --
+ drivers/thermal/uniphier_thermal.c                 |  27 ++-
+ include/linux/thermal.h                            |  10 +
+ 46 files changed, 869 insertions(+), 1172 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/thermal/generic-adc-=
thermal.yaml
+ delete mode 100644 Documentation/devicetree/bindings/thermal/thermal-gene=
ric-adc.txt
+Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_'=
 to 'dma_' API)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/ieee1394/linux1394.git ieee1394/for-next
+Already up to date.
+Merging dlm/next (775af207464b fs: dlm: use WARN_ON_ONCE() instead of WARN=
_ON())
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/teigland/linux-dlm.git dlm/next
+Merge made by the 'ort' strategy.
+ fs/dlm/ast.c               | 322 +++++++++++++++++++---------------------=
-----
+ fs/dlm/ast.h               |  17 ++-
+ fs/dlm/debug_fs.c          |   2 +-
+ fs/dlm/dlm_internal.h      |  25 ++--
+ fs/dlm/lock.c              | 190 +++++---------------------
+ fs/dlm/lockspace.c         |   9 +-
+ fs/dlm/lowcomms.c          |  24 ++--
+ fs/dlm/member.c            |   5 +-
+ fs/dlm/memory.c            |  30 ++++-
+ fs/dlm/memory.h            |   4 +-
+ fs/dlm/midcomms.c          |  71 +++++++---
+ fs/dlm/midcomms.h          |   3 +-
+ fs/dlm/rcom.c              |   4 +-
+ fs/dlm/user.c              |  75 ++++++-----
+ fs/dlm/user.h              |   2 +-
+ include/trace/events/dlm.h | 297 +++++++++++++++++++++++++++++++++++++++++
+ 16 files changed, 652 insertions(+), 428 deletions(-)
+Merging rdma/for-next (692373d18620 RDMA/rxe: cleanup some error handling =
in rxe_verbs.c)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/rdma/rdma.git rdma/for-next
+Auto-merging drivers/infiniband/core/device.c
+Auto-merging drivers/infiniband/hw/qedr/main.c
+Auto-merging drivers/infiniband/sw/rxe/rxe_resp.c
+Merge made by the 'ort' strategy.
+ drivers/infiniband/core/cache.c               |  2 +-
+ drivers/infiniband/core/device.c              |  2 +-
+ drivers/infiniband/core/uverbs_std_types_qp.c |  2 +-
+ drivers/infiniband/hw/qedr/main.c             |  2 +-
+ drivers/infiniband/hw/qib/qib_iba6120.c       |  7 +--
+ drivers/infiniband/hw/qib/qib_tx.c            |  5 +-
+ drivers/infiniband/hw/qib/qib_user_sdma.c     |  2 +-
+ drivers/infiniband/sw/rxe/rxe_comp.c          | 27 +++++---
+ drivers/infiniband/sw/rxe/rxe_mr.c            | 19 +++---
+ drivers/infiniband/sw/rxe/rxe_mw.c            |  3 +-
+ drivers/infiniband/sw/rxe/rxe_net.c           |  4 +-
+ drivers/infiniband/sw/rxe/rxe_qp.c            | 23 +++----
+ drivers/infiniband/sw/rxe/rxe_req.c           | 10 +--
+ drivers/infiniband/sw/rxe/rxe_resp.c          | 16 +++--
+ drivers/infiniband/sw/rxe/rxe_task.c          | 45 +++++++-------
+ drivers/infiniband/sw/rxe/rxe_task.h          | 19 ++----
+ drivers/infiniband/sw/rxe/rxe_verbs.c         | 88 ++++++++--------------=
-----
+ drivers/infiniband/sw/rxe/rxe_verbs.h         |  1 -
+ drivers/infiniband/ulp/iser/iser_verbs.c      | 67 +++++++++-----------
+ include/rdma/ib_verbs.h                       |  2 +-
+ include/rdma/opa_vnic.h                       |  2 +-
+ 21 files changed, 147 insertions(+), 201 deletions(-)
+Merging net-next/master (8e18be7610ae lib: Fix some kernel-doc comments)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/netdev/net-next.git net-next/master
+Auto-merging MAINTAINERS
+Auto-merging arch/x86/net/bpf_jit_comp.c
+Auto-merging drivers/net/ethernet/broadcom/bnxt/bnxt.c
+Auto-merging drivers/net/ethernet/broadcom/bnxt/bnxt.h
+Auto-merging drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+Auto-merging drivers/net/ethernet/freescale/fman/mac.c
+Auto-merging drivers/net/ethernet/ti/am65-cpsw-nuss.c
+Auto-merging drivers/net/macsec.c
+Auto-merging drivers/net/tun.c
+Auto-merging drivers/net/wireless/mac80211_hwsim.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt2500usb.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt61pci.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt73usb.c
+Auto-merging drivers/net/wwan/mhi_wwan_mbim.c
+Auto-merging include/linux/bpf.h
+Auto-merging kernel/bpf/verifier.c
+Auto-merging kernel/trace/ftrace.c
+Auto-merging net/core/skbuff.c
+Auto-merging net/ipv4/tcp.c
+Auto-merging net/mac80211/main.c
+Auto-merging net/mac80211/tx.c
+Auto-merging net/wireless/util.c
+Auto-merging tools/bpf/bpftool/common.c
+Merge made by the 'ort' strategy.
+ Documentation/bpf/map_cgrp_storage.rst             |   109 +
+ Documentation/bpf/maps.rst                         |   101 +-
+ .../devicetree/bindings/net/adi,adin1110.yaml      |     4 +
+ .../devicetree/bindings/net/asix,ax88178.yaml      |     4 +-
+ .../devicetree/bindings/net/dsa/dsa-port.yaml      |     3 +-
+ .../bindings/net/dsa/renesas,rzn1-a5psw.yaml       |     2 +-
+ .../bindings/net/ethernet-controller.yaml          |    11 +-
+ .../devicetree/bindings/net/fsl,fman-dtsec.yaml    |    53 +-
+ .../bindings/net/fsl,qoriq-mc-dpmac.yaml           |     2 +-
+ Documentation/devicetree/bindings/net/fsl-fman.txt |     5 +-
+ .../devicetree/bindings/net/marvell,pp2.yaml       |   305 +
+ .../devicetree/bindings/net/marvell-pp2.txt        |   141 -
+ .../devicetree/bindings/net/microchip,lan95xx.yaml |     4 +-
+ .../devicetree/bindings/net/pcs/fsl,lynx-pcs.yaml  |    40 +
+ .../net/renesas,r8a779f0-ether-switch.yaml         |   262 +
+ Documentation/devicetree/bindings/net/sff,sfp.yaml |     3 +-
+ .../devicetree/bindings/net/snps,dwmac.yaml        |   345 +-
+ Documentation/networking/can.rst                   |    33 +
+ .../device_drivers/ethernet/marvell/octeon_ep.rst  |     1 +
+ Documentation/networking/ethtool-netlink.rst       |     1 +
+ Documentation/networking/index.rst                 |     1 +
+ Documentation/networking/ip-sysctl.rst             |    75 +
+ Documentation/networking/tc-queue-filters.rst      |    37 +
+ MAINTAINERS                                        |     5 +-
+ arch/arm/boot/dts/armada-375.dtsi                  |    12 +-
+ arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi |    24 +
+ arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi |    25 +
+ arch/arm64/boot/dts/marvell/armada-cp11x.dtsi      |    17 +-
+ arch/arm64/net/bpf_jit_comp.c                      |     9 +-
+ arch/mips/configs/mtx1_defconfig                   |     1 -
+ .../dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi   |     3 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi |    10 +-
+ .../dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi   |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-2.dtsi |    45 +
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-3.dtsi |    45 +
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi  |     3 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi  |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi  |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi  |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi  |     3 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi  |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi  |     3 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi  |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi  |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi  |    10 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi  |     3 +-
+ arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi  |    10 +-
+ arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |     4 +-
+ arch/powerpc/configs/ppc6xx_defconfig              |     1 -
+ arch/x86/net/bpf_jit_comp.c                        |   128 +-
+ drivers/bcma/driver_gpio.c                         |     8 +-
+ drivers/bcma/sprom.c                               |     2 +-
+ drivers/hv/hv_util.c                               |     4 +-
+ drivers/net/bonding/bond_3ad.c                     |     9 +
+ drivers/net/bonding/bond_main.c                    |    13 +-
+ drivers/net/bonding/bond_options.c                 |    18 -
+ drivers/net/can/Kconfig                            |     8 -
+ drivers/net/can/Makefile                           |     1 -
+ drivers/net/can/c_can/Kconfig                      |     3 +-
+ drivers/net/can/m_can/m_can.c                      |    26 +-
+ drivers/net/can/m_can/m_can.h                      |     2 +-
+ drivers/net/can/pch_can.c                          |  1249 -
+ drivers/net/can/rcar/rcar_canfd.c                  |    22 +-
+ drivers/net/can/usb/Kconfig                        |     9 +-
+ drivers/net/can/usb/gs_usb.c                       |    74 +-
+ drivers/net/can/usb/kvaser_usb/Makefile            |     5 -
+ drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |    30 +-
+ drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   115 +-
+ drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |   160 +-
+ drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |   464 +-
+ drivers/net/can/usb/ucan.c                         |     5 +-
+ drivers/net/can/vxcan.c                            |     2 +-
+ drivers/net/dsa/mv88e6xxx/chip.c                   |     2 +
+ drivers/net/dsa/mv88e6xxx/port.c                   |     9 +
+ drivers/net/dsa/mv88e6xxx/port.h                   |     2 +
+ drivers/net/ethernet/Kconfig                       |    10 -
+ drivers/net/ethernet/Makefile                      |     1 -
+ drivers/net/ethernet/adi/adin1110.c                |    58 +-
+ drivers/net/ethernet/alacritech/slic.h             |    12 +-
+ drivers/net/ethernet/altera/altera_tse_main.c      |     1 -
+ drivers/net/ethernet/amazon/ena/ena_ethtool.c      |     4 +-
+ drivers/net/ethernet/amazon/ena/ena_netdev.c       |    12 +-
+ drivers/net/ethernet/amd/xgbe/xgbe-ptp.c           |    20 +-
+ drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |     8 +-
+ drivers/net/ethernet/asix/ax88796c_main.c          |     4 +-
+ drivers/net/ethernet/atheros/ag71xx.c              |     1 -
+ drivers/net/ethernet/broadcom/b44.c                |     8 +-
+ drivers/net/ethernet/broadcom/bcm4908_enet.c       |    57 +-
+ drivers/net/ethernet/broadcom/bcmsysport.c         |    23 +-
+ drivers/net/ethernet/broadcom/bcmsysport.h         |    11 +
+ drivers/net/ethernet/broadcom/bnx2.c               |     5 +-
+ drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    86 +-
+ drivers/net/ethernet/broadcom/bnxt/bnxt.h          |     3 +
+ drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   126 +-
+ drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |   281 +-
+ drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |    45 +-
+ drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |     7 +-
+ drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    31 +-
+ drivers/net/ethernet/brocade/bna/bfa_msgq.c        |     2 -
+ drivers/net/ethernet/cadence/macb_main.c           |    17 +-
+ drivers/net/ethernet/cisco/enic/enic.h             |    23 +-
+ drivers/net/ethernet/cisco/enic/enic_main.c        |    11 +-
+ drivers/net/ethernet/cortina/gemini.c              |    24 +-
+ drivers/net/ethernet/dlink/dl2k.c                  |     2 -
+ drivers/net/ethernet/emulex/benet/be_ethtool.c     |    12 +-
+ drivers/net/ethernet/emulex/benet/be_main.c        |    16 +-
+ drivers/net/ethernet/faraday/ftmac100.c            |    65 +-
+ drivers/net/ethernet/fealnx.c                      |  1953 --
+ drivers/net/ethernet/freescale/dpaa/Kconfig        |     4 +-
+ drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    89 +-
+ drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |    90 +-
+ drivers/net/ethernet/freescale/dpaa2/Makefile      |     2 +-
+ .../ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c   |    57 +-
+ .../ethernet/freescale/dpaa2/dpaa2-eth-devlink.c   |    11 +-
+ .../net/ethernet/freescale/dpaa2/dpaa2-eth-trace.h |   142 +-
+ drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   521 +-
+ drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |   101 +-
+ .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |    58 +-
+ drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c   |     6 +-
+ drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c   |   454 +
+ drivers/net/ethernet/freescale/dpaa2/dpni-cmd.h    |    19 +-
+ drivers/net/ethernet/freescale/dpaa2/dpni.c        |     6 +-
+ drivers/net/ethernet/freescale/dpaa2/dpni.h        |     9 +
+ drivers/net/ethernet/freescale/enetc/enetc_pf.c    |     1 -
+ drivers/net/ethernet/freescale/fec.h               |     6 +-
+ drivers/net/ethernet/freescale/fec_main.c          |   312 +-
+ drivers/net/ethernet/freescale/fec_ptp.c           |   164 +-
+ drivers/net/ethernet/freescale/fman/Kconfig        |     4 +-
+ drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   457 +-
+ drivers/net/ethernet/freescale/fman/fman_mac.h     |    10 -
+ drivers/net/ethernet/freescale/fman/fman_memac.c   |   744 +-
+ drivers/net/ethernet/freescale/fman/fman_tgec.c    |   130 +-
+ drivers/net/ethernet/freescale/fman/mac.c          |   168 +-
+ drivers/net/ethernet/freescale/fman/mac.h          |    23 +-
+ drivers/net/ethernet/fungible/funeth/funeth_main.c |    13 +-
+ drivers/net/ethernet/fungible/funeth/funeth_txrx.h |     4 +-
+ drivers/net/ethernet/google/gve/gve.h              |    26 +-
+ drivers/net/ethernet/google/gve/gve_ethtool.c      |    18 +-
+ drivers/net/ethernet/google/gve/gve_main.c         |    12 +-
+ drivers/net/ethernet/google/gve/gve_rx.c           |   544 +-
+ drivers/net/ethernet/google/gve/gve_rx_dqo.c       |     2 +-
+ drivers/net/ethernet/google/gve/gve_utils.c        |    30 +-
+ drivers/net/ethernet/google/gve/gve_utils.h        |     2 +-
+ drivers/net/ethernet/hisilicon/hns/hnae.c          |     3 -
+ drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |     4 +-
+ drivers/net/ethernet/huawei/hinic/hinic_dev.h      |     4 +
+ drivers/net/ethernet/huawei/hinic/hinic_hw_dev.h   |   170 +-
+ drivers/net/ethernet/huawei/hinic/hinic_main.c     |    13 +-
+ drivers/net/ethernet/huawei/hinic/hinic_port.c     |    50 +-
+ drivers/net/ethernet/huawei/hinic/hinic_port.h     |    12 +
+ drivers/net/ethernet/huawei/hinic/hinic_rx.c       |     4 +-
+ drivers/net/ethernet/huawei/hinic/hinic_sriov.c    |    18 +
+ drivers/net/ethernet/huawei/hinic/hinic_tx.c       |     4 +-
+ drivers/net/ethernet/ibm/ibmveth.c                 |    18 +-
+ drivers/net/ethernet/ibm/ibmveth.h                 |     1 -
+ drivers/net/ethernet/intel/e1000/e1000_main.c      |     9 +-
+ drivers/net/ethernet/intel/e1000e/Makefile         |     3 +
+ drivers/net/ethernet/intel/e1000e/e1000.h          |     4 +-
+ drivers/net/ethernet/intel/e1000e/e1000e_trace.h   |    42 +
+ drivers/net/ethernet/intel/e1000e/ethtool.c        |     2 +
+ drivers/net/ethernet/intel/e1000e/hw.h             |     9 +
+ drivers/net/ethernet/intel/e1000e/ich8lan.c        |    27 +
+ drivers/net/ethernet/intel/e1000e/netdev.c         |    51 +-
+ drivers/net/ethernet/intel/e1000e/ptp.c            |    17 +-
+ drivers/net/ethernet/intel/fm10k/fm10k_netdev.c    |     8 +-
+ drivers/net/ethernet/intel/i40e/i40e.h             |     1 +
+ drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    12 +-
+ drivers/net/ethernet/intel/i40e/i40e_main.c        |    21 +-
+ drivers/net/ethernet/intel/i40e/i40e_ptp.c         |    17 +-
+ drivers/net/ethernet/intel/i40e/i40e_trace.h       |    49 +
+ drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    27 +-
+ drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |     8 +-
+ drivers/net/ethernet/intel/iavf/iavf_main.c        |     4 +-
+ drivers/net/ethernet/intel/ice/ice.h               |    17 +
+ drivers/net/ethernet/intel/ice/ice_devlink.c       |    14 +-
+ drivers/net/ethernet/intel/ice/ice_ethtool.c       |   169 +
+ drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |     3 +
+ drivers/net/ethernet/intel/ice/ice_main.c          |    24 +-
+ drivers/net/ethernet/intel/ice/ice_ptp.c           |    18 +-
+ drivers/net/ethernet/intel/ice/ice_repr.c          |    12 +-
+ drivers/net/ethernet/intel/ice/ice_tc_lib.c        |   351 +-
+ drivers/net/ethernet/intel/ice/ice_tc_lib.h        |    40 +-
+ drivers/net/ethernet/intel/ice/ice_virtchnl.c      |    86 +
+ drivers/net/ethernet/intel/ice/ice_virtchnl.h      |     2 +
+ .../ethernet/intel/ice/ice_virtchnl_allowlist.c    |     6 +
+ drivers/net/ethernet/intel/igb/igb_ethtool.c       |    12 +-
+ drivers/net/ethernet/intel/igb/igb_main.c          |    18 +-
+ drivers/net/ethernet/intel/igb/igb_ptp.c           |    18 +-
+ drivers/net/ethernet/intel/igc/igc_defines.h       |     9 +
+ drivers/net/ethernet/intel/igc/igc_ethtool.c       |    12 +-
+ drivers/net/ethernet/intel/igc/igc_main.c          |    15 +-
+ drivers/net/ethernet/intel/igc/igc_regs.h          |     1 +
+ drivers/net/ethernet/intel/igc/igc_tsn.c           |    30 +
+ drivers/net/ethernet/intel/igc/igc_tsn.h           |     1 +
+ drivers/net/ethernet/intel/ixgbe/ixgbe.h           |    10 +-
+ drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |    61 +-
+ drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |     8 +-
+ drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |    26 +-
+ drivers/net/ethernet/intel/ixgbevf/ethtool.c       |    12 +-
+ drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |    25 +-
+ drivers/net/ethernet/marvell/mv643xx_eth.c         |    49 +-
+ drivers/net/ethernet/marvell/mvneta.c              |    13 +-
+ drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |     9 +-
+ .../net/ethernet/marvell/octeon_ep/octep_main.c    |    20 +-
+ .../net/ethernet/marvell/octeon_ep/octep_main.h    |     2 +
+ drivers/net/ethernet/marvell/octeontx2/af/npc.h    |     1 +
+ .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |     6 +
+ .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |    81 +-
+ .../ethernet/marvell/prestera/prestera_devlink.c   |    17 -
+ .../ethernet/marvell/prestera/prestera_devlink.h   |     5 -
+ .../net/ethernet/marvell/prestera/prestera_main.c  |     6 +-
+ drivers/net/ethernet/marvell/sky2.c                |     8 +-
+ drivers/net/ethernet/mediatek/mtk_eth_soc.c        |     9 +-
+ drivers/net/ethernet/mediatek/mtk_eth_soc.h        |    13 +-
+ drivers/net/ethernet/mediatek/mtk_sgmii.c          |   174 +-
+ drivers/net/ethernet/mellanox/mlx4/en_clock.c      |    29 +-
+ drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |     9 +-
+ drivers/net/ethernet/mellanox/mlx4/main.c          |     2 +-
+ .../net/ethernet/mellanox/mlx5/core/en/devlink.c   |    17 -
+ .../net/ethernet/mellanox/mlx5/core/en/devlink.h   |     2 -
+ drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |     4 +-
+ drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    44 +-
+ .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |    22 +-
+ .../mellanox/mlx5/core/steering/dr_buddy.c         |     2 -
+ .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |     7 +
+ .../mellanox/mlx5/core/steering/dr_domain.c        |    89 +-
+ .../mellanox/mlx5/core/steering/dr_icm_pool.c      |   174 +-
+ .../ethernet/mellanox/mlx5/core/steering/dr_rule.c |    92 +-
+ .../ethernet/mellanox/mlx5/core/steering/dr_send.c |   141 +-
+ .../ethernet/mellanox/mlx5/core/steering/dr_ste.c  |    12 +-
+ .../mellanox/mlx5/core/steering/dr_table.c         |     2 +-
+ .../mellanox/mlx5/core/steering/dr_types.h         |    16 +-
+ .../ethernet/mellanox/mlx5/core/steering/mlx5dr.h  |     9 +-
+ drivers/net/ethernet/mellanox/mlxsw/core.c         |    20 +-
+ drivers/net/ethernet/mellanox/mlxsw/core.h         |     7 +-
+ drivers/net/ethernet/mellanox/mlxsw/minimal.c      |    17 +-
+ drivers/net/ethernet/mellanox/mlxsw/reg.h          |     1 +
+ drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    20 +-
+ .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |    21 +
+ drivers/net/ethernet/microchip/Kconfig             |     1 +
+ drivers/net/ethernet/microchip/Makefile            |     1 +
+ drivers/net/ethernet/microchip/lan743x_ethtool.c   |    46 +
+ drivers/net/ethernet/microchip/lan743x_main.c      |     4 +-
+ drivers/net/ethernet/microchip/lan743x_main.h      |     2 +
+ drivers/net/ethernet/microchip/lan743x_ptp.c       |    54 +-
+ .../ethernet/microchip/lan966x/lan966x_phylink.c   |     2 -
+ drivers/net/ethernet/microchip/sparx5/Kconfig      |    12 +
+ drivers/net/ethernet/microchip/sparx5/Makefile     |    10 +-
+ drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c |   310 +
+ .../net/ethernet/microchip/sparx5/sparx5_main.c    |     9 +
+ .../net/ethernet/microchip/sparx5/sparx5_main.h    |    17 +
+ .../ethernet/microchip/sparx5/sparx5_main_regs.h   |   583 +-
+ .../net/ethernet/microchip/sparx5/sparx5_phylink.c |     1 -
+ .../net/ethernet/microchip/sparx5/sparx5_port.c    |    99 +
+ .../net/ethernet/microchip/sparx5/sparx5_port.h    |    42 +
+ drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |     4 +
+ drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |    46 +
+ drivers/net/ethernet/microchip/sparx5/sparx5_tc.h  |    14 +
+ .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |   217 +
+ .../ethernet/microchip/sparx5/sparx5_vcap_ag_api.c |  1351 ++
+ .../ethernet/microchip/sparx5/sparx5_vcap_ag_api.h |    18 +
+ .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |   527 +
+ .../ethernet/microchip/sparx5/sparx5_vcap_impl.h   |    20 +
+ drivers/net/ethernet/microchip/vcap/Kconfig        |    52 +
+ drivers/net/ethernet/microchip/vcap/Makefile       |     9 +
+ drivers/net/ethernet/microchip/vcap/vcap_ag_api.h  |   326 +
+ .../ethernet/microchip/vcap/vcap_ag_api_kunit.h    |   643 +
+ drivers/net/ethernet/microchip/vcap/vcap_api.c     |  1184 +
+ drivers/net/ethernet/microchip/vcap/vcap_api.h     |   272 +
+ .../net/ethernet/microchip/vcap/vcap_api_client.h  |   202 +
+ .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |   933 +
+ .../net/ethernet/microchip/vcap/vcap_model_kunit.c |  5570 +++++
+ .../net/ethernet/microchip/vcap/vcap_model_kunit.h |    10 +
+ drivers/net/ethernet/microsoft/mana/gdma.h         |     1 +
+ drivers/net/ethernet/microsoft/mana/gdma_main.c    |    30 +-
+ drivers/net/ethernet/microsoft/mana/mana_en.c      |     8 +-
+ drivers/net/ethernet/microsoft/mana/mana_ethtool.c |     8 +-
+ drivers/net/ethernet/mscc/ocelot_net.c             |    12 +-
+ drivers/net/ethernet/mscc/ocelot_vsc7514.c         |     9 -
+ .../net/ethernet/netronome/nfp/flower/lag_conf.c   |    52 +-
+ drivers/net/ethernet/netronome/nfp/flower/main.c   |     9 +
+ drivers/net/ethernet/netronome/nfp/flower/main.h   |    21 +-
+ .../ethernet/netronome/nfp/flower/tunnel_conf.c    |    53 +-
+ drivers/net/ethernet/netronome/nfp/nfp_app.h       |     2 -
+ drivers/net/ethernet/netronome/nfp/nfp_devlink.c   |    23 +-
+ .../net/ethernet/netronome/nfp/nfp_net_common.c    |    10 +-
+ .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |     8 +-
+ drivers/net/ethernet/netronome/nfp/nfp_net_main.c  |    11 +-
+ drivers/net/ethernet/netronome/nfp/nfp_net_repr.c  |     5 +-
+ drivers/net/ethernet/netronome/nfp/nfp_port.h      |     2 -
+ drivers/net/ethernet/nvidia/forcedeth.c            |     8 +-
+ drivers/net/ethernet/pensando/ionic/ionic_dev.c    |    14 +
+ drivers/net/ethernet/pensando/ionic/ionic_dev.h    |     3 +
+ .../net/ethernet/pensando/ionic/ionic_devlink.c    |     2 +-
+ drivers/net/ethernet/pensando/ionic/ionic_if.h     |    45 +-
+ drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   113 +-
+ drivers/net/ethernet/pensando/ionic/ionic_main.c   |     2 +-
+ drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |    31 +-
+ drivers/net/ethernet/qlogic/qed/qed_debug.c        |     3 +-
+ drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |     4 +-
+ drivers/net/ethernet/realtek/8139too.c             |     8 +-
+ drivers/net/ethernet/realtek/r8169_main.c          |     2 +-
+ drivers/net/ethernet/renesas/Kconfig               |    11 +
+ drivers/net/ethernet/renesas/Makefile              |     4 +
+ drivers/net/ethernet/renesas/ravb_ptp.c            |    17 +-
+ drivers/net/ethernet/renesas/rcar_gen4_ptp.c       |   181 +
+ drivers/net/ethernet/renesas/rcar_gen4_ptp.h       |    72 +
+ drivers/net/ethernet/renesas/rswitch.c             |  1840 ++
+ drivers/net/ethernet/renesas/rswitch.h             |   973 +
+ drivers/net/ethernet/rocker/rocker_ofdpa.c         |    15 +-
+ drivers/net/ethernet/sfc/ef100_ethtool.c           |     2 -
+ drivers/net/ethernet/sfc/ef100_tx.c                |     3 +-
+ drivers/net/ethernet/sfc/ethtool_common.c          |    37 -
+ drivers/net/ethernet/sfc/ethtool_common.h          |     2 -
+ drivers/net/ethernet/sfc/mae.c                     |   136 +-
+ drivers/net/ethernet/sfc/mcdi.h                    |    12 +
+ drivers/net/ethernet/sfc/net_driver.h              |     2 -
+ drivers/net/ethernet/sfc/tc.c                      |   180 +-
+ drivers/net/ethernet/sfc/tc.h                      |    32 +-
+ drivers/net/ethernet/smsc/Kconfig                  |    14 -
+ drivers/net/ethernet/smsc/Makefile                 |     1 -
+ drivers/net/ethernet/smsc/smc911x.c                |  2198 --
+ drivers/net/ethernet/smsc/smc911x.h                |   901 -
+ drivers/net/ethernet/socionext/sni_ave.c           |    14 +-
+ drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |     4 +-
+ drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    21 +-
+ drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |     1 -
+ drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   254 +-
+ drivers/net/ethernet/ti/am65-cpsw-nuss.h           |     6 +
+ drivers/net/ethernet/ti/am65-cpts.c                |    76 +
+ drivers/net/ethernet/ti/am65-cpts.h                |    10 +
+ drivers/net/ethernet/ti/cpsw_ale.c                 |    10 +
+ drivers/net/ethernet/ti/cpsw_ale.h                 |     1 +
+ drivers/net/ethernet/ti/netcp_core.c               |    10 +-
+ drivers/net/ethernet/via/via-rhine.c               |     8 +-
+ drivers/net/ethernet/wangxun/Kconfig               |     7 +
+ drivers/net/ethernet/wangxun/Makefile              |     1 +
+ drivers/net/ethernet/wangxun/libwx/Makefile        |     7 +
+ drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   938 +
+ drivers/net/ethernet/wangxun/libwx/wx_hw.h         |    28 +
+ drivers/net/ethernet/wangxun/libwx/wx_type.h       |   352 +
+ drivers/net/ethernet/wangxun/ngbe/Makefile         |     2 +-
+ drivers/net/ethernet/wangxun/ngbe/ngbe.h           |    55 +
+ drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c        |    87 +
+ drivers/net/ethernet/wangxun/ngbe/ngbe_hw.h        |    12 +
+ drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   368 +
+ drivers/net/ethernet/wangxun/ngbe/ngbe_type.h      |    99 +-
+ drivers/net/ethernet/wangxun/txgbe/Makefile        |     3 +-
+ drivers/net/ethernet/wangxun/txgbe/txgbe.h         |    23 +-
+ drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |   312 +
+ drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h      |    11 +
+ drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   465 +-
+ drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |    47 +-
+ drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    45 +-
+ drivers/net/geneve.c                               |     2 +-
+ drivers/net/hamradio/baycom_epp.c                  |     2 +-
+ drivers/net/hyperv/netvsc_drv.c                    |    32 +-
+ drivers/net/ieee802154/atusb.c                     |    33 +-
+ drivers/net/ieee802154/mac802154_hwsim.c           |   179 +-
+ drivers/net/ieee802154/mcr20a.c                    |     9 +-
+ drivers/net/ifb.c                                  |    12 +-
+ drivers/net/ipa/data/ipa_data-v3.1.c               |    19 +-
+ drivers/net/ipa/data/ipa_data-v3.5.1.c             |    27 +-
+ drivers/net/ipa/data/ipa_data-v4.11.c              |    17 +-
+ drivers/net/ipa/data/ipa_data-v4.2.c               |    17 +-
+ drivers/net/ipa/data/ipa_data-v4.5.c               |    17 +-
+ drivers/net/ipa/data/ipa_data-v4.9.c               |    17 +-
+ drivers/net/ipa/gsi_trans.c                        |     7 +-
+ drivers/net/ipa/ipa.h                              |    32 +-
+ drivers/net/ipa/ipa_cmd.c                          |    74 +-
+ drivers/net/ipa/ipa_cmd.h                          |    16 +-
+ drivers/net/ipa/ipa_data.h                         |     2 +
+ drivers/net/ipa/ipa_endpoint.c                     |   277 +-
+ drivers/net/ipa/ipa_endpoint.h                     |     2 +-
+ drivers/net/ipa/ipa_interrupt.c                    |    34 +-
+ drivers/net/ipa/ipa_main.c                         |    13 +-
+ drivers/net/ipa/ipa_mem.c                          |    19 +-
+ drivers/net/ipa/ipa_qmi.c                          |     9 +-
+ drivers/net/ipa/ipa_qmi_msg.c                      |    20 +-
+ drivers/net/ipa/ipa_qmi_msg.h                      |    20 +-
+ drivers/net/ipa/ipa_table.c                        |   343 +-
+ drivers/net/ipa/ipa_table.h                        |    30 +-
+ drivers/net/ipa/ipa_version.h                      |     3 +
+ drivers/net/ipa/reg/ipa_reg-v3.1.c                 |    13 +-
+ drivers/net/ipa/reg/ipa_reg-v3.5.1.c               |    13 +-
+ drivers/net/ipa/reg/ipa_reg-v4.11.c                |    13 +-
+ drivers/net/ipa/reg/ipa_reg-v4.2.c                 |    13 +-
+ drivers/net/ipa/reg/ipa_reg-v4.5.c                 |    13 +-
+ drivers/net/ipa/reg/ipa_reg-v4.9.c                 |    13 +-
+ drivers/net/ipvlan/ipvlan_main.c                   |     4 +-
+ drivers/net/loopback.c                             |     4 +-
+ drivers/net/macsec.c                               |    12 +-
+ drivers/net/macvlan.c                              |     4 +-
+ drivers/net/mhi_net.c                              |     8 +-
+ drivers/net/netdevsim/dev.c                        |     2 -
+ drivers/net/netdevsim/netdev.c                     |    14 +-
+ drivers/net/phy/Kconfig                            |     2 +-
+ drivers/net/phy/dp83822.c                          |     2 +
+ drivers/net/phy/micrel.c                           |    77 +
+ drivers/net/phy/motorcomm.c                        |  1635 +-
+ drivers/net/phy/mxl-gpy.c                          |    98 +-
+ drivers/net/phy/phy-core.c                         |    11 +-
+ drivers/net/phy/phy.c                              |     1 +
+ drivers/net/phy/phylink.c                          |    43 +-
+ drivers/net/phy/sfp.c                              |    85 +-
+ drivers/net/team/team.c                            |     4 +-
+ drivers/net/team/team_mode_loadbalance.c           |     4 +-
+ drivers/net/tun.c                                  |     2 +-
+ drivers/net/usb/asix_devices.c                     |     5 +-
+ drivers/net/usb/cdc_ncm.c                          |     3 +-
+ drivers/net/usb/qmi_wwan.c                         |     5 +-
+ drivers/net/veth.c                                 |   102 +-
+ drivers/net/virtio_net.c                           |    16 +-
+ drivers/net/vrf.c                                  |     4 +-
+ drivers/net/vxlan/vxlan_core.c                     |     4 +-
+ drivers/net/vxlan/vxlan_vnifilter.c                |     4 +-
+ drivers/net/wireless/admtek/adm8211.c              |     1 +
+ drivers/net/wireless/ath/ar5523/ar5523.c           |     1 +
+ drivers/net/wireless/ath/ath11k/mac.c              |     1 +
+ drivers/net/wireless/ath/ath5k/mac80211-ops.c      |     1 +
+ drivers/net/wireless/ath/ath9k/htc_drv_main.c      |     1 +
+ drivers/net/wireless/ath/carl9170/main.c           |     1 +
+ drivers/net/wireless/ath/wcn36xx/main.c            |     1 +
+ drivers/net/wireless/atmel/at76c50x-usb.c          |     1 +
+ drivers/net/wireless/atmel/atmel.c                 |   164 +-
+ drivers/net/wireless/broadcom/b43/main.c           |     1 +
+ drivers/net/wireless/broadcom/b43legacy/main.c     |     1 +
+ .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |     6 +
+ .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   546 +-
+ .../wireless/broadcom/brcm80211/brcmfmac/core.c    |     3 +-
+ .../wireless/broadcom/brcm80211/brcmfmac/core.h    |     1 +
+ .../wireless/broadcom/brcm80211/brcmfmac/feature.c |     3 +-
+ .../wireless/broadcom/brcm80211/brcmfmac/feature.h |     4 +-
+ .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   139 +-
+ .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |     2 -
+ .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |     1 +
+ drivers/net/wireless/intel/iwlegacy/3945-mac.c     |     1 +
+ drivers/net/wireless/intel/iwlegacy/4965-mac.c     |     1 +
+ drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |     1 +
+ drivers/net/wireless/intersil/p54/main.c           |     1 +
+ drivers/net/wireless/mac80211_hwsim.c              |     1 +
+ drivers/net/wireless/marvell/libertas_tf/main.c    |     1 +
+ drivers/net/wireless/marvell/mwl8k.c               |     1 +
+ drivers/net/wireless/mediatek/mt7601u/main.c       |     1 +
+ drivers/net/wireless/purelifi/plfxlc/mac.c         |     1 +
+ drivers/net/wireless/ralink/rt2x00/rt2400pci.c     |     1 +
+ drivers/net/wireless/ralink/rt2x00/rt2500pci.c     |     1 +
+ drivers/net/wireless/ralink/rt2x00/rt2500usb.c     |     1 +
+ drivers/net/wireless/ralink/rt2x00/rt2800pci.c     |     1 +
+ drivers/net/wireless/ralink/rt2x00/rt2800soc.c     |     1 +
+ drivers/net/wireless/ralink/rt2x00/rt2800usb.c     |     1 +
+ drivers/net/wireless/ralink/rt2x00/rt61pci.c       |     1 +
+ drivers/net/wireless/ralink/rt2x00/rt73usb.c       |     1 +
+ drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |     1 +
+ drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |     1 +
+ drivers/net/wireless/realtek/rtl8xxxu/Kconfig      |     7 +-
+ drivers/net/wireless/realtek/rtl8xxxu/Makefile     |     2 +-
+ drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |    64 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c |  1679 ++
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c |    11 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |    13 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c |     3 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c |    11 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   184 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h  |    19 +
+ drivers/net/wireless/realtek/rtlwifi/core.c        |     1 +
+ drivers/net/wireless/realtek/rtw89/Kconfig         |    14 +
+ drivers/net/wireless/realtek/rtw89/Makefile        |     9 +
+ drivers/net/wireless/realtek/rtw89/coex.c          |     9 +-
+ drivers/net/wireless/realtek/rtw89/core.c          |     3 +
+ drivers/net/wireless/realtek/rtw89/core.h          |    26 +-
+ drivers/net/wireless/realtek/rtw89/debug.c         |    33 +-
+ drivers/net/wireless/realtek/rtw89/fw.c            |    29 +-
+ drivers/net/wireless/realtek/rtw89/fw.h            |     1 +
+ drivers/net/wireless/realtek/rtw89/mac.c           |     3 +
+ drivers/net/wireless/realtek/rtw89/mac.h           |     5 +
+ drivers/net/wireless/realtek/rtw89/phy.c           |   198 +-
+ drivers/net/wireless/realtek/rtw89/phy.h           |    80 +-
+ drivers/net/wireless/realtek/rtw89/reg.h           |   192 +-
+ drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   159 +-
+ drivers/net/wireless/realtek/rtw89/rtw8852a.h      |     1 -
+ drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  2436 +-
+ drivers/net/wireless/realtek/rtw89/rtw8852b.h      |   137 +
+ drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |  4174 ++++
+ drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h  |    25 +
+ .../wireless/realtek/rtw89/rtw8852b_rfk_table.c    |   794 +
+ .../wireless/realtek/rtw89/rtw8852b_rfk_table.h    |    62 +
+ .../net/wireless/realtek/rtw89/rtw8852b_table.c    | 22877 ++++++++++++++=
+++++
+ .../net/wireless/realtek/rtw89/rtw8852b_table.h    |    30 +
+ drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    64 +
+ drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   208 +-
+ drivers/net/wireless/realtek/rtw89/rtw8852c.h      |     1 -
+ drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |     5 +-
+ .../net/wireless/realtek/rtw89/rtw8852c_table.c    |   988 +-
+ drivers/net/wireless/rsi/rsi_91x_mac80211.c        |     1 +
+ drivers/net/wireless/silabs/wfx/main.c             |     1 +
+ drivers/net/wireless/st/cw1200/main.c              |     1 +
+ drivers/net/wireless/ti/wl1251/main.c              |     1 +
+ drivers/net/wireless/ti/wlcore/main.c              |     1 +
+ drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |     1 +
+ drivers/net/wwan/Kconfig                           |     1 +
+ drivers/net/wwan/iosm/iosm_ipc_chnl_cfg.c          |     2 +-
+ drivers/net/wwan/mhi_wwan_mbim.c                   |     8 +-
+ drivers/net/wwan/t7xx/Makefile                     |     3 +
+ drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |     2 +
+ drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h            |    14 +-
+ drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c         |   218 +-
+ drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h         |     1 +
+ drivers/net/wwan/t7xx/t7xx_netdev.c                |    91 +-
+ drivers/net/wwan/t7xx/t7xx_netdev.h                |     5 +
+ drivers/net/wwan/t7xx/t7xx_pci.h                   |     3 +
+ drivers/net/wwan/t7xx/t7xx_port.h                  |     9 +-
+ drivers/net/wwan/t7xx/t7xx_port_proxy.c            |    12 +
+ drivers/net/wwan/t7xx/t7xx_port_proxy.h            |     4 +
+ drivers/net/wwan/t7xx/t7xx_port_trace.c            |   116 +
+ drivers/net/wwan/t7xx/t7xx_port_wwan.c             |    16 +-
+ drivers/net/wwan/wwan_core.c                       |     6 +-
+ drivers/net/xen-netfront.c                         |     8 +-
+ drivers/nfc/s3fwrn5/i2c.c                          |    19 +-
+ drivers/ptp/ptp_kvm_common.c                       |     4 +-
+ drivers/ptp/ptp_ocp.c                              |   563 +-
+ drivers/ptp/ptp_vmw.c                              |     4 +-
+ drivers/s390/net/ctcm_main.c                       |    11 +-
+ drivers/s390/net/lcs.c                             |     8 +-
+ drivers/s390/net/netiucv.c                         |     9 +-
+ drivers/staging/vt6655/device_main.c               |     1 +
+ drivers/staging/vt6656/main_usb.c                  |     1 +
+ include/linux/avf/virtchnl.h                       |    14 +-
+ include/linux/bpf.h                                |    33 +-
+ include/linux/bpf_local_storage.h                  |    17 +-
+ include/linux/bpf_types.h                          |     1 +
+ include/linux/bpf_verifier.h                       |    15 +-
+ include/linux/btf_ids.h                            |     1 +
+ include/linux/cgroup-defs.h                        |     4 +
+ include/linux/ethtool.h                            |    17 +
+ include/linux/ieee80211.h                          |    56 +-
+ include/linux/ieee802154.h                         |    24 +
+ include/linux/if_bridge.h                          |     1 +
+ include/linux/module.h                             |     9 +
+ include/linux/mv643xx_eth.h                        |     2 +
+ include/linux/net.h                                |     1 +
+ include/linux/netdevice.h                          |    31 +-
+ include/linux/netlink.h                            |    29 +-
+ include/linux/phy.h                                |     3 +
+ include/linux/phylink.h                            |    32 +
+ include/linux/ptp_clock_kernel.h                   |    53 +
+ include/linux/rcupdate.h                           |    12 +
+ include/linux/rtnetlink.h                          |     9 +-
+ include/linux/sfp.h                                |   189 +-
+ include/linux/skbuff.h                             |     7 -
+ include/linux/smc911x.h                            |    14 -
+ include/linux/socket.h                             |     5 +-
+ include/linux/tcp.h                                |     1 +
+ include/linux/udp.h                                |     3 +
+ include/linux/wwan.h                               |     2 +
+ include/net/act_api.h                              |     1 +
+ include/net/bond_alb.h                             |     4 +-
+ include/net/bonding.h                              |     4 -
+ include/net/cfg80211.h                             |    13 +-
+ include/net/cfg802154.h                            |    20 +-
+ include/net/dcbnl.h                                |     4 +
+ include/net/devlink.h                              |    32 +-
+ include/net/dropreason.h                           |    14 +
+ include/net/flow_offload.h                         |     2 +
+ include/net/genetlink.h                            |    76 +-
+ include/net/geneve.h                               |     2 +-
+ include/net/ieee802154_netdev.h                    |     8 +
+ include/net/inet_frag.h                            |     6 +-
+ include/net/ipv6_frag.h                            |     3 +-
+ include/net/mac80211.h                             |    73 +-
+ include/net/mac802154.h                            |    31 -
+ include/net/net_namespace.h                        |    30 +-
+ include/net/netfilter/nf_conntrack_helper.h        |     5 +
+ include/net/netfilter/nf_tables.h                  |    10 +-
+ include/net/netfilter/nf_tables_core.h             |    36 +-
+ include/net/netfilter/nf_tables_ipv4.h             |     4 +
+ include/net/netfilter/nf_tables_ipv6.h             |     6 +-
+ include/net/netfilter/nft_meta.h                   |     6 +
+ include/net/netlink.h                              |    32 +
+ include/net/netns/ipv4.h                           |     5 +
+ include/net/rtnetlink.h                            |     5 +-
+ include/net/sctp/ulpqueue.h                        |     3 +-
+ include/net/sock.h                                 |     2 +-
+ include/net/sock_reuseport.h                       |     2 +
+ include/net/tc_act/tc_ct.h                         |     1 +
+ include/net/tc_act/tc_skbedit.h                    |    29 +
+ include/net/tcp.h                                  |    28 +
+ include/net/transp_v6.h                            |     2 -
+ include/net/udp.h                                  |     9 +
+ include/uapi/linux/bpf.h                           |   482 +-
+ include/uapi/linux/dcbnl.h                         |     8 +
+ include/uapi/linux/ethtool.h                       |     8 +
+ include/uapi/linux/ethtool_netlink.h               |     1 +
+ include/uapi/linux/if_link.h                       |     3 +
+ include/uapi/linux/if_packet.h                     |     1 +
+ include/uapi/linux/neighbour.h                     |     8 +-
+ include/uapi/linux/netfilter/nf_tables.h           |    27 +
+ include/uapi/linux/netlink.h                       |     2 +
+ include/uapi/linux/nl80211.h                       |     3 +
+ include/uapi/linux/snmp.h                          |     1 +
+ include/uapi/linux/tc_act/tc_ct.h                  |     3 +
+ include/uapi/linux/tcp.h                           |     6 +
+ kernel/bpf/Makefile                                |     2 +-
+ kernel/bpf/bpf_cgrp_storage.c                      |   247 +
+ kernel/bpf/bpf_inode_storage.c                     |    38 +-
+ kernel/bpf/bpf_local_storage.c                     |   204 +-
+ kernel/bpf/bpf_task_storage.c                      |   157 +-
+ kernel/bpf/cgroup_iter.c                           |     2 +-
+ kernel/bpf/core.c                                  |     8 +-
+ kernel/bpf/cpumap.c                                |    20 +-
+ kernel/bpf/helpers.c                               |     6 +
+ kernel/bpf/memalloc.c                              |    15 +-
+ kernel/bpf/syscall.c                               |    12 +-
+ kernel/bpf/trampoline.c                            |    80 +-
+ kernel/bpf/verifier.c                              |    29 +-
+ kernel/cgroup/cgroup.c                             |     1 +
+ kernel/module/kallsyms.c                           |     2 -
+ kernel/rcu/tasks.h                                 |     2 +
+ kernel/trace/bpf_trace.c                           |   107 +-
+ kernel/trace/ftrace.c                              |    16 +-
+ lib/nlattr.c                                       |     2 +-
+ net/8021q/vlan_dev.c                               |     4 +-
+ net/batman-adv/netlink.c                           |     6 +-
+ net/bridge/br_fdb.c                                |    24 +
+ net/bridge/br_input.c                              |    21 +-
+ net/bridge/br_mdb.c                                |    11 +-
+ net/bridge/br_multicast.c                          |    12 +-
+ net/bridge/br_netlink.c                            |    21 +-
+ net/bridge/br_private.h                            |     3 +-
+ net/bridge/br_vlan.c                               |     4 +-
+ net/can/j1939/transport.c                          |     2 +-
+ net/core/bpf_sk_storage.c                          |    35 +-
+ net/core/dev.c                                     |    68 +-
+ net/core/dev.h                                     |     7 +
+ net/core/dev_ioctl.c                               |     2 +-
+ net/core/devlink.c                                 |   211 +-
+ net/core/drop_monitor.c                            |    12 +-
+ net/core/gen_stats.c                               |    16 +-
+ net/core/net-sysfs.c                               |     4 +-
+ net/core/net_namespace.c                           |     5 +
+ net/core/rtnetlink.c                               |    90 +-
+ net/core/skbuff.c                                  |    89 +-
+ net/core/sock.c                                    |    20 +-
+ net/core/sock_reuseport.c                          |    94 +-
+ net/core/utils.c                                   |     4 +-
+ net/dcb/dcbnl.c                                    |   134 +-
+ net/dccp/dccp.h                                    |     1 +
+ net/dccp/ipv6.c                                    |    15 +-
+ net/dccp/proto.c                                   |     8 +-
+ net/dsa/dsa2.c                                     |     9 -
+ net/dsa/slave.c                                    |    13 +-
+ net/ethtool/channels.c                             |    19 +-
+ net/ethtool/common.c                               |    80 +
+ net/ethtool/common.h                               |     1 +
+ net/ethtool/ioctl.c                                |    28 +-
+ net/ethtool/linkstate.c                            |    24 +-
+ net/ieee802154/core.c                              |     3 +
+ net/ieee802154/nl802154.c                          |     6 +-
+ net/ipv4/Makefile                                  |     2 +-
+ net/ipv4/af_inet.c                                 |     4 +-
+ net/ipv4/inet_fragment.c                           |    14 +-
+ net/ipv4/ip_fragment.c                             |    19 +-
+ net/ipv4/ip_gre.c                                  |     2 +-
+ net/ipv4/ip_sockglue.c                             |     2 +-
+ net/ipv4/metrics.c                                 |     3 -
+ net/ipv4/proc.c                                    |     1 +
+ net/ipv4/sysctl_net_ipv4.c                         |    43 +
+ net/ipv4/tcp.c                                     |     5 +
+ net/ipv4/tcp_dctcp.c                               |    23 +-
+ net/ipv4/tcp_input.c                               |    51 +-
+ net/ipv4/tcp_ipv4.c                                |     8 +
+ net/ipv4/tcp_plb.c                                 |   109 +
+ net/ipv4/udp.c                                     |    18 +-
+ net/ipv6/af_inet6.c                                |     9 +-
+ net/ipv6/datagram.c                                |     2 +-
+ net/ipv6/ip6_gre.c                                 |    20 -
+ net/ipv6/ipv6_sockglue.c                           |     6 +-
+ net/ipv6/netfilter/nf_conntrack_reasm.c            |     2 +-
+ net/ipv6/ping.c                                    |     6 -
+ net/ipv6/raw.c                                     |     2 -
+ net/ipv6/reassembly.c                              |    13 +-
+ net/ipv6/seg6_local.c                              |     4 +-
+ net/ipv6/tcp_ipv6.c                                |     8 +-
+ net/ipv6/udp.c                                     |     6 +-
+ net/l2tp/l2tp_ip6.c                                |     2 -
+ net/mac80211/agg-rx.c                              |    25 +-
+ net/mac80211/agg-tx.c                              |     2 +-
+ net/mac80211/cfg.c                                 |    43 +-
+ net/mac80211/debugfs.c                             |     4 +-
+ net/mac80211/debugfs_netdev.c                      |     3 +-
+ net/mac80211/debugfs_sta.c                         |   148 +-
+ net/mac80211/debugfs_sta.h                         |    12 +
+ net/mac80211/driver-ops.c                          |    27 +-
+ net/mac80211/driver-ops.h                          |    16 +
+ net/mac80211/ieee80211_i.h                         |    22 +-
+ net/mac80211/iface.c                               |    69 +-
+ net/mac80211/link.c                                |    17 +
+ net/mac80211/main.c                                |    23 +-
+ net/mac80211/mlme.c                                |   131 +-
+ net/mac80211/rc80211_minstrel_ht.c                 |     3 -
+ net/mac80211/rc80211_minstrel_ht.h                 |     1 -
+ net/mac80211/rx.c                                  |     3 -
+ net/mac80211/sta_info.c                            |   118 +-
+ net/mac80211/sta_info.h                            |     7 +
+ net/mac80211/tdls.c                                |     1 -
+ net/mac80211/tx.c                                  |    30 +-
+ net/mac80211/util.c                                |   246 +-
+ net/mac80211/wme.c                                 |    63 +-
+ net/mac80211/wme.h                                 |     4 +-
+ net/mac802154/cfg.c                                |     6 +-
+ net/mac802154/driver-ops.h                         |   253 +-
+ net/mac802154/ieee802154_i.h                       |    56 +-
+ net/mac802154/iface.c                              |    44 +-
+ net/mac802154/main.c                               |     2 +-
+ net/mac802154/rx.c                                 |    29 +-
+ net/mac802154/tx.c                                 |   132 +-
+ net/mac802154/util.c                               |    71 +-
+ net/mpls/af_mpls.c                                 |     4 +-
+ net/mptcp/protocol.c                               |    11 +-
+ net/mptcp/sockopt.c                                |    34 +-
+ net/mptcp/subflow.c                                |     2 +
+ net/netfilter/Kconfig                              |     6 -
+ net/netfilter/Makefile                             |     4 +-
+ net/netfilter/ipvs/ip_vs_ctl.c                     |     4 +-
+ net/netfilter/nf_conntrack_helper.c                |   100 +
+ net/netfilter/nf_tables_api.c                      |    41 +-
+ net/netfilter/nf_tables_core.c                     |     2 +
+ net/netfilter/nft_inner.c                          |   384 +
+ net/netfilter/nft_meta.c                           |    62 +
+ net/netfilter/nft_objref.c                         |    22 +-
+ net/netfilter/nft_payload.c                        |   134 +-
+ net/netlink/af_netlink.c                           |    42 +-
+ net/netlink/genetlink.c                            |   485 +-
+ net/nfc/nci/core.c                                 |     8 +-
+ net/nfc/nci/hci.c                                  |     4 +-
+ net/nfc/rawsock.c                                  |     3 +
+ net/openvswitch/conntrack.c                        |   105 +-
+ net/openvswitch/datapath.c                         |     4 +-
+ net/openvswitch/flow_netlink.c                     |     2 +-
+ net/openvswitch/flow_table.c                       |     9 +-
+ net/openvswitch/vport-geneve.c                     |     2 +-
+ net/openvswitch/vport-gre.c                        |     2 +-
+ net/openvswitch/vport-netdev.c                     |     2 +-
+ net/openvswitch/vport-vxlan.c                      |     2 +-
+ net/packet/af_packet.c                             |    11 +-
+ net/rds/message.c                                  |     2 -
+ net/rds/send.c                                     |     3 +-
+ net/rds/tcp.c                                      |     3 +
+ net/sched/act_ct.c                                 |   124 +-
+ net/sched/act_skbedit.c                            |    14 +-
+ net/sched/cls_api.c                                |     7 +
+ net/sctp/associola.c                               |     4 +-
+ net/sctp/socket.c                                  |    29 +-
+ net/sctp/stream_interleave.c                       |    12 +-
+ net/sctp/ulpqueue.c                                |    10 +-
+ net/socket.c                                       |     8 +-
+ net/wireless/core.h                                |     5 +-
+ net/wireless/mlme.c                                |     4 +
+ net/wireless/nl80211.c                             |    23 +-
+ net/wireless/nl80211.h                             |     3 +-
+ net/wireless/sme.c                                 |    26 +-
+ net/wireless/util.c                                |     4 +-
+ samples/bpf/README.rst                             |     6 +-
+ samples/bpf/hbm_edt_kern.c                         |     2 +-
+ samples/bpf/xdp1_user.c                            |     2 +-
+ samples/bpf/xdp2_kern.c                            |     4 +
+ scripts/bpf_doc.py                                 |    48 +-
+ tools/bpf/bpftool/Documentation/bpftool-map.rst    |     2 +-
+ tools/bpf/bpftool/Documentation/bpftool-prog.rst   |    15 +-
+ tools/bpf/bpftool/Documentation/common_options.rst |     8 +-
+ tools/bpf/bpftool/Makefile                         |    74 +-
+ tools/bpf/bpftool/bash-completion/bpftool          |     1 +
+ tools/bpf/bpftool/common.c                         |    12 +-
+ tools/bpf/bpftool/iter.c                           |     2 +
+ tools/bpf/bpftool/jit_disasm.c                     |   261 +-
+ tools/bpf/bpftool/main.c                           |    90 +-
+ tools/bpf/bpftool/main.h                           |    32 +-
+ tools/bpf/bpftool/map.c                            |     3 +-
+ tools/bpf/bpftool/net.c                            |     2 +
+ tools/bpf/bpftool/perf.c                           |     2 +
+ tools/bpf/bpftool/prog.c                           |    99 +-
+ tools/bpf/bpftool/xlated_dumper.c                  |     2 +
+ tools/include/uapi/linux/bpf.h                     |   482 +-
+ tools/lib/bpf/bpf.c                                |    48 +-
+ tools/lib/bpf/bpf.h                                |    16 +
+ tools/lib/bpf/btf.c                                |     8 +-
+ tools/lib/bpf/btf_dump.c                           |    35 +-
+ tools/lib/bpf/libbpf.c                             |   200 +-
+ tools/lib/bpf/libbpf.map                           |     6 +-
+ tools/lib/bpf/libbpf_probes.c                      |     1 +
+ tools/lib/bpf/usdt.c                               |    27 +-
+ tools/testing/selftests/bpf/DENYLIST               |     3 +-
+ tools/testing/selftests/bpf/DENYLIST.aarch64       |    81 +
+ tools/testing/selftests/bpf/DENYLIST.s390x         |    40 +-
+ tools/testing/selftests/bpf/Makefile               |     8 +-
+ tools/testing/selftests/bpf/README.rst             |    53 +-
+ .../selftests/bpf/bpf_testmod/bpf_testmod.c        |    24 +
+ tools/testing/selftests/bpf/config                 |     2 +
+ tools/testing/selftests/bpf/config.aarch64         |   181 +
+ tools/testing/selftests/bpf/config.s390x           |     3 -
+ tools/testing/selftests/bpf/config.x86_64          |     1 -
+ tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |    41 +-
+ tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |     6 +-
+ .../selftests/bpf/prog_tests/cgrp_local_storage.c  |   171 +
+ .../selftests/bpf/prog_tests/kprobe_multi_test.c   |    26 +-
+ .../bpf/prog_tests/kprobe_multi_testmod_test.c     |    89 +
+ .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c      |    87 +
+ .../testing/selftests/bpf/prog_tests/libbpf_str.c  |     8 +
+ tools/testing/selftests/bpf/prog_tests/map_kptr.c  |     3 +-
+ .../selftests/bpf/prog_tests/module_attach.c       |     7 +
+ tools/testing/selftests/bpf/prog_tests/ringbuf.c   |    66 +-
+ tools/testing/selftests/bpf/prog_tests/skeleton.c  |    11 +-
+ .../selftests/bpf/prog_tests/task_local_storage.c  |   164 +-
+ .../selftests/bpf/prog_tests/tracing_struct.c      |     3 +-
+ .../selftests/bpf/prog_tests/xdp_adjust_tail.c     |     7 +-
+ .../selftests/bpf/prog_tests/xdp_synproxy.c        |     6 +-
+ .../selftests/bpf/progs/bpf_iter_bpf_array_map.c   |    21 +-
+ .../bpf/progs/btf_dump_test_case_padding.c         |     9 +
+ .../selftests/bpf/progs/cgrp_ls_attach_cgroup.c    |   101 +
+ .../testing/selftests/bpf/progs/cgrp_ls_negative.c |    26 +
+ .../selftests/bpf/progs/cgrp_ls_recursion.c        |    70 +
+ tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c |    88 +
+ tools/testing/selftests/bpf/progs/kprobe_multi.c   |    50 +
+ .../bpf/progs/task_local_storage_exit_creds.c      |     3 +
+ .../selftests/bpf/progs/task_ls_recursion.c        |    43 +-
+ .../selftests/bpf/progs/task_storage_nodeadlock.c  |    47 +
+ .../bpf/progs/test_libbpf_get_fd_by_id_opts.c      |    36 +
+ .../selftests/bpf/progs/test_module_attach.c       |     6 +
+ .../selftests/bpf/progs/test_ringbuf_map_key.c     |    70 +
+ tools/testing/selftests/bpf/progs/test_skeleton.c  |    17 +
+ .../selftests/bpf/task_local_storage_helpers.h     |     4 +
+ .../testing/selftests/bpf/test_bpftool_metadata.sh |     7 +-
+ .../selftests/bpf/test_bpftool_synctypes.py        |     8 +
+ tools/testing/selftests/bpf/test_flow_dissector.sh |     6 +-
+ tools/testing/selftests/bpf/test_lwt_ip_encap.sh   |    17 +-
+ tools/testing/selftests/bpf/test_lwt_seg6local.sh  |     9 +-
+ tools/testing/selftests/bpf/test_tc_edt.sh         |     3 +-
+ tools/testing/selftests/bpf/test_tc_tunnel.sh      |     5 +-
+ tools/testing/selftests/bpf/test_tunnel.sh         |     5 +-
+ tools/testing/selftests/bpf/test_verifier.c        |    13 +-
+ tools/testing/selftests/bpf/test_xdp_meta.sh       |     9 +-
+ tools/testing/selftests/bpf/test_xdp_vlan.sh       |     8 +-
+ tools/testing/selftests/bpf/trace_helpers.c        |    20 +-
+ tools/testing/selftests/bpf/trace_helpers.h        |     2 +
+ tools/testing/selftests/bpf/verifier/jit.c         |    24 +
+ tools/testing/selftests/bpf/veristat.c             |    37 +-
+ tools/testing/selftests/bpf/vmtest.sh              |     6 +
+ tools/testing/selftests/net/.gitignore             |     1 +
+ tools/testing/selftests/net/Makefile               |     1 +
+ .../selftests/net/forwarding/bridge_igmp.sh        |     3 -
+ .../selftests/net/forwarding/bridge_locked_port.sh |   155 +-
+ .../selftests/net/forwarding/bridge_vlan_mcast.sh  |     3 +
+ tools/testing/selftests/net/forwarding/lib.sh      |     8 +
+ tools/testing/selftests/net/so_incoming_cpu.c      |   242 +
+ tools/testing/selftests/tc-testing/tdc.py          |   125 +-
+ 858 files changed, 74278 insertions(+), 14404 deletions(-)
+ create mode 100644 Documentation/bpf/map_cgrp_storage.rst
+ create mode 100644 Documentation/devicetree/bindings/net/marvell,pp2.yaml
+ delete mode 100644 Documentation/devicetree/bindings/net/marvell-pp2.txt
+ create mode 100644 Documentation/devicetree/bindings/net/pcs/fsl,lynx-pcs=
.yaml
+ create mode 100644 Documentation/devicetree/bindings/net/renesas,r8a779f0=
-ether-switch.yaml
+ create mode 100644 Documentation/networking/tc-queue-filters.rst
+ create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-2.dtsi
+ create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-3.dtsi
+ delete mode 100644 drivers/net/can/pch_can.c
+ delete mode 100644 drivers/net/ethernet/fealnx.c
+ create mode 100644 drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
+ create mode 100644 drivers/net/ethernet/intel/e1000e/e1000e_trace.h
+ create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c
+ create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower=
.c
+ create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_a=
pi.c
+ create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_a=
pi.h
+ create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl=
.c
+ create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl=
.h
+ create mode 100644 drivers/net/ethernet/microchip/vcap/Kconfig
+ create mode 100644 drivers/net/ethernet/microchip/vcap/Makefile
+ create mode 100644 drivers/net/ethernet/microchip/vcap/vcap_ag_api.h
+ create mode 100644 drivers/net/ethernet/microchip/vcap/vcap_ag_api_kunit.h
+ create mode 100644 drivers/net/ethernet/microchip/vcap/vcap_api.c
+ create mode 100644 drivers/net/ethernet/microchip/vcap/vcap_api.h
+ create mode 100644 drivers/net/ethernet/microchip/vcap/vcap_api_client.h
+ create mode 100644 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+ create mode 100644 drivers/net/ethernet/microchip/vcap/vcap_model_kunit.c
+ create mode 100644 drivers/net/ethernet/microchip/vcap/vcap_model_kunit.h
+ create mode 100644 drivers/net/ethernet/renesas/rcar_gen4_ptp.c
+ create mode 100644 drivers/net/ethernet/renesas/rcar_gen4_ptp.h
+ create mode 100644 drivers/net/ethernet/renesas/rswitch.c
+ create mode 100644 drivers/net/ethernet/renesas/rswitch.h
+ delete mode 100644 drivers/net/ethernet/smsc/smc911x.c
+ delete mode 100644 drivers/net/ethernet/smsc/smc911x.h
+ create mode 100644 drivers/net/ethernet/wangxun/libwx/Makefile
+ create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_hw.c
+ create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_hw.h
+ create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_type.h
+ create mode 100644 drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c
+ create mode 100644 drivers/net/ethernet/wangxun/ngbe/ngbe_hw.h
+ create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+ create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h
+ create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+ create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b.h
+ create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+ create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
+ create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.c
+ create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.h
+ create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
+ create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
+ create mode 100644 drivers/net/wwan/t7xx/t7xx_port_trace.c
+ delete mode 100644 include/linux/smc911x.h
+ create mode 100644 kernel/bpf/bpf_cgrp_storage.c
+ create mode 100644 net/ipv4/tcp_plb.c
+ create mode 100644 net/netfilter/nft_inner.c
+ create mode 100644 tools/testing/selftests/bpf/DENYLIST.aarch64
+ create mode 100644 tools/testing/selftests/bpf/config.aarch64
+ create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_local_stor=
age.c
+ create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_multi_te=
stmod_test.c
+ create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_b=
y_id_opts.c
+ create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgrou=
p.c
+ create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_negative.c
+ create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
+ create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
+ create mode 100644 tools/testing/selftests/bpf/progs/task_storage_nodeadl=
ock.c
+ create mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_b=
y_id_opts.c
+ create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key=
.c
+ create mode 100644 tools/testing/selftests/net/so_incoming_cpu.c
+Merging bpf-next/for-next (e5659e4e19e4 samples/bpf: Fix sockex3 error: Mi=
ssing BPF prog type)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/bpf/bpf-next.git bpf-next/for-next
+Auto-merging include/linux/bpf.h
+Auto-merging kernel/bpf/verifier.c
+Merge made by the 'ort' strategy.
+ Documentation/bpf/bpf_design_QA.rst            |  44 ++
+ include/linux/bpf.h                            | 179 +++--
+ include/linux/btf.h                            |  10 +-
+ kernel/bpf/arraymap.c                          |  30 +-
+ kernel/bpf/bpf_local_storage.c                 |   2 +-
+ kernel/bpf/btf.c                               | 420 +++++++-----
+ kernel/bpf/hashtab.c                           |  38 +-
+ kernel/bpf/helpers.c                           |   6 +-
+ kernel/bpf/local_storage.c                     |   2 +-
+ kernel/bpf/map_in_map.c                        |  19 +-
+ kernel/bpf/syscall.c                           | 373 +++++------
+ kernel/bpf/verifier.c                          | 485 +++++++++-----
+ net/core/bpf_sk_storage.c                      |   4 +-
+ net/core/filter.c                              |   4 +
+ samples/bpf/sockex3_kern.c                     |  95 +--
+ samples/bpf/sockex3_user.c                     |  23 +-
+ samples/bpf/tracex2_kern.c                     |   4 +-
+ samples/bpf/tracex2_user.c                     |   3 +-
+ tools/lib/bpf/btf.c                            |  75 +--
+ tools/testing/selftests/bpf/Makefile           |   7 +-
+ tools/testing/selftests/bpf/bpf_util.h         |  19 +
+ tools/testing/selftests/bpf/cgroup_helpers.c   |   3 +-
+ tools/testing/selftests/bpf/prog_tests/align.c |  38 +-
+ tools/testing/selftests/bpf/prog_tests/btf.c   |  88 ++-
+ tools/testing/selftests/bpf/veristat.c         | 887 ++++++++++++++++++++=
-----
+ tools/testing/selftests/bpf/xsk.c              |  26 +-
+ tools/testing/selftests/bpf/xskxceiver.c       |   3 +-
+ 27 files changed, 1909 insertions(+), 978 deletions(-)
+Merging ipsec-next/master (cc2bbbfd9a50 xfrm: Remove not-used total variab=
le)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/klassert/ipsec-next.git ipsec-next/master
+Auto-merging net/ipv6/esp6_offload.c
+Merge made by the 'ort' strategy.
+ net/ipv6/esp6_offload.c | 3 +--
+ net/xfrm/xfrm_input.c   | 1 +
+ net/xfrm/xfrm_output.c  | 3 +--
+ net/xfrm/xfrm_policy.c  | 4 ++--
+ 4 files changed, 5 insertions(+), 6 deletions(-)
+Merging mlx5-next/mlx5-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/mellanox/linux.git mlx5-next/mlx5-next
+Already up to date.
+Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub=
/scm/linux/kernel/git/netdev/net)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/pablo/nf-next.git netfilter-next/master
+Already up to date.
+Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/=
linux/kernel/git/netdev/net)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/horms/ipvs-next.git ipvs-next/master
+Already up to date.
+Merging bluetooth/master (ab80b2cec05f Bluetooth: hci_bcm4377: Add new dri=
ver for BCM4377 PCIe boards)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/bluetooth/bluetooth-next.git bluetooth/master
+Auto-merging MAINTAINERS
+Auto-merging arch/arm64/boot/dts/apple/t8103-j456.dts
+Auto-merging arch/arm64/boot/dts/apple/t8103-j457.dts
+Auto-merging arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
+Auto-merging drivers/bluetooth/virtio_bt.c
+Auto-merging net/bluetooth/hci_conn.c
+Auto-merging net/bluetooth/iso.c
+Auto-merging net/bluetooth/l2cap_core.c
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/net/bluetooth.txt          |    5 -
+ .../net/bluetooth/bluetooth-controller.yaml        |   29 +
+ .../net/bluetooth/brcm,bcm4377-bluetooth.yaml      |   81 +
+ .../net/{ =3D> bluetooth}/qualcomm-bluetooth.yaml    |    6 +-
+ .../bindings/net/broadcom-bluetooth.yaml           |    1 +
+ .../devicetree/bindings/soc/qcom/qcom,wcnss.yaml   |    8 +-
+ MAINTAINERS                                        |    2 +
+ arch/arm64/boot/dts/apple/t8103-j274.dts           |    4 +
+ arch/arm64/boot/dts/apple/t8103-j293.dts           |    4 +
+ arch/arm64/boot/dts/apple/t8103-j313.dts           |    4 +
+ arch/arm64/boot/dts/apple/t8103-j456.dts           |    4 +
+ arch/arm64/boot/dts/apple/t8103-j457.dts           |    4 +
+ arch/arm64/boot/dts/apple/t8103-jxxx.dtsi          |    8 +
+ drivers/bluetooth/Kconfig                          |   23 +
+ drivers/bluetooth/Makefile                         |    1 +
+ drivers/bluetooth/btrtl.c                          |    7 +
+ drivers/bluetooth/btrtl.h                          |   21 +
+ drivers/bluetooth/btusb.c                          |  190 +-
+ drivers/bluetooth/hci_bcm.c                        |   13 +-
+ drivers/bluetooth/hci_bcm4377.c                    | 2514 +++++++++++++++=
+++++
+ drivers/bluetooth/hci_qca.c                        |    3 +-
+ drivers/bluetooth/virtio_bt.c                      |   35 +-
+ include/net/bluetooth/hci.h                        |   21 +
+ include/net/bluetooth/hci_core.h                   |    8 +-
+ include/uapi/linux/virtio_bt.h                     |    8 +
+ net/bluetooth/Kconfig                              |   11 +
+ net/bluetooth/hci_conn.c                           |   15 +-
+ net/bluetooth/hci_core.c                           |    2 +-
+ net/bluetooth/hci_debugfs.c                        |    2 +-
+ net/bluetooth/hci_event.c                          |    2 +-
+ net/bluetooth/hci_sync.c                           |   21 +-
+ net/bluetooth/iso.c                                |    6 +-
+ net/bluetooth/l2cap_core.c                         |    2 +-
+ net/bluetooth/lib.c                                |    4 +-
+ net/bluetooth/mgmt.c                               |    2 +-
+ 35 files changed, 3012 insertions(+), 59 deletions(-)
+ delete mode 100644 Documentation/devicetree/bindings/net/bluetooth.txt
+ create mode 100644 Documentation/devicetree/bindings/net/bluetooth/blueto=
oth-controller.yaml
+ create mode 100644 Documentation/devicetree/bindings/net/bluetooth/brcm,b=
cm4377-bluetooth.yaml
+ rename Documentation/devicetree/bindings/net/{ =3D> bluetooth}/qualcomm-b=
luetooth.yaml (96%)
+ create mode 100644 drivers/bluetooth/hci_bcm4377.c
+Merging wireless-next/for-next (b8f6efccbb9d wifi: rsi: Fix handling of 80=
2.3 EAPOL frames sent via control port)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/wireless/wireless-next.git wireless-next/for-next
+Merge made by the 'ort' strategy.
+ drivers/bcma/main.c                                |    4 +-
+ drivers/net/wireless/ath/ar5523/ar5523.c           |    6 +
+ drivers/net/wireless/ath/ath10k/core.c             |   16 +
+ drivers/net/wireless/ath/ath10k/debug.c            |    5 +-
+ drivers/net/wireless/ath/ath10k/htc.c              |    9 +
+ drivers/net/wireless/ath/ath10k/htt.h              |    6 +-
+ drivers/net/wireless/ath/ath10k/hw.h               |    2 +
+ drivers/net/wireless/ath/ath10k/wmi-tlv.c          |    7 +
+ drivers/net/wireless/ath/ath11k/core.c             |    9 +-
+ drivers/net/wireless/ath/ath11k/core.h             |    3 +
+ drivers/net/wireless/ath/ath11k/mac.c              |  224 +++--
+ drivers/net/wireless/ath/ath11k/pcic.c             |   13 +-
+ drivers/net/wireless/ath/ath11k/qmi.c              |   12 +-
+ drivers/net/wireless/ath/ath11k/wmi.c              |    2 +-
+ drivers/net/wireless/ath/ath9k/Makefile            |    5 -
+ drivers/net/wireless/ath/ath9k/ath9k.h             |    1 +
+ drivers/net/wireless/ath/ath9k/hif_usb.c           |   46 +-
+ drivers/net/wireless/ath/ath9k/mci.c               |    8 +-
+ drivers/net/wireless/ath/ath9k/tx99.c              |    2 +-
+ drivers/net/wireless/ath/carl9170/Makefile         |    5 -
+ drivers/net/wireless/ath/carl9170/wlan.h           |    2 +-
+ drivers/net/wireless/ath/wil6210/debugfs.c         |   36 +-
+ drivers/net/wireless/atmel/atmel.c                 |    2 +-
+ .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   24 +-
+ .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    8 +-
+ .../broadcom/brcm80211/brcmfmac/firmware.c         |    5 +
+ .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |    8 +-
+ .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    2 +-
+ .../net/wireless/broadcom/brcm80211/brcmsmac/led.c |    3 -
+ drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   14 -
+ drivers/net/wireless/intel/iwlegacy/3945-mac.c     |    6 -
+ drivers/net/wireless/marvell/mwifiex/debugfs.c     |    2 +-
+ drivers/net/wireless/marvell/mwifiex/main.h        |    1 +
+ drivers/net/wireless/microchip/wilc1000/sdio.c     |    1 +
+ drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   24 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c |   71 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c |    1 +
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |   27 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c |   61 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c |   33 +-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  208 +++-
+ .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h  |    4 +
+ .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.c   |    8 -
+ drivers/net/wireless/realtek/rtw89/Makefile        |    2 +
+ drivers/net/wireless/realtek/rtw89/core.c          |   18 +-
+ drivers/net/wireless/realtek/rtw89/core.h          |  129 ++-
+ drivers/net/wireless/realtek/rtw89/debug.c         | 1019 +++++++++++++++=
+++--
+ drivers/net/wireless/realtek/rtw89/debug.h         |    1 +
+ drivers/net/wireless/realtek/rtw89/fw.c            |  317 +++++-
+ drivers/net/wireless/realtek/rtw89/fw.h            |  261 ++++-
+ drivers/net/wireless/realtek/rtw89/mac.c           |  509 +++++++---
+ drivers/net/wireless/realtek/rtw89/mac.h           |   77 ++
+ drivers/net/wireless/realtek/rtw89/mac80211.c      |   55 ++
+ drivers/net/wireless/realtek/rtw89/pci.c           |   23 +-
+ drivers/net/wireless/realtek/rtw89/pci.h           |   12 +
+ drivers/net/wireless/realtek/rtw89/phy.c           |   31 +-
+ drivers/net/wireless/realtek/rtw89/phy.h           |    2 +-
+ drivers/net/wireless/realtek/rtw89/ps.c            |    2 +-
+ drivers/net/wireless/realtek/rtw89/ps.h            |    1 +
+ drivers/net/wireless/realtek/rtw89/reg.h           |  255 ++++-
+ drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   18 +
+ drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |    2 +-
+ drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   18 +-
+ drivers/net/wireless/realtek/rtw89/util.h          |   11 +
+ drivers/net/wireless/realtek/rtw89/wow.c           |  859 +++++++++++++++=
++
+ drivers/net/wireless/realtek/rtw89/wow.h           |   21 +
+ drivers/net/wireless/rsi/rsi_91x_core.c            |    4 +-
+ drivers/net/wireless/rsi/rsi_91x_hal.c             |    6 +-
+ include/linux/bcma/bcma_driver_chipcommon.h        |    2 +-
+ 69 files changed, 4105 insertions(+), 486 deletions(-)
+ create mode 100644 drivers/net/wireless/realtek/rtw89/wow.c
+ create mode 100644 drivers/net/wireless/realtek/rtw89/wow.h
+Merging mtd/mtd/next (077dc37db1e1 mtd: inftlcore: fix repeated words in c=
omments)
+$ git merge -m Merge branch 'mtd/next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/mtd/linux.git mtd/mtd/next
+Merge made by the 'ort' strategy.
+ .../bindings/mtd/partitions/fixed-partitions.yaml  |   1 +
+ .../bindings/mtd/partitions/partition.yaml         |   4 +
+ .../partitions/tplink,safeloader-partitions.yaml   |  49 ++
+ drivers/mtd/devices/Kconfig                        |   8 -
+ drivers/mtd/devices/Makefile                       |   1 -
+ drivers/mtd/devices/lart.c                         | 682 ----------------=
-----
+ drivers/mtd/inftlcore.c                            |   2 +-
+ drivers/mtd/mtdcore.c                              |  51 +-
+ drivers/mtd/mtdoops.c                              | 109 ++--
+ drivers/mtd/parsers/Kconfig                        |  15 +
+ drivers/mtd/parsers/Makefile                       |   1 +
+ drivers/mtd/parsers/tplink_safeloader.c            | 150 +++++
+ 12 files changed, 312 insertions(+), 761 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/mtd/partitions/tplin=
k,safeloader-partitions.yaml
+ delete mode 100644 drivers/mtd/devices/lart.c
+ create mode 100644 drivers/mtd/parsers/tplink_safeloader.c
+Merging nand/nand/next (075e181fba72 dt-bindings: mtd: brcm,brcmnand: upda=
te interrupts description)
+$ git merge -m Merge branch 'nand/next' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/mtd/linux.git nand/nand/next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/mtd/brcm,brcmnand.yaml     | 16 +++--
+ .../bindings/mtd/rockchip,nand-controller.yaml     |  4 +-
+ MAINTAINERS                                        |  2 +-
+ drivers/mtd/nand/core.c                            |  3 +-
+ drivers/mtd/nand/raw/cadence-nand-controller.c     | 70 +++++++++++++++--=
--
+ drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         | 12 ++--
+ drivers/mtd/nand/raw/lpc32xx_mlc.c                 | 46 ++++++-------
+ drivers/mtd/nand/raw/lpc32xx_slc.c                 | 43 ++++++------
+ drivers/mtd/nand/raw/mpc5121_nfc.c                 |  2 +-
+ drivers/mtd/nand/spi/winbond.c                     | 79 +++++++++++++++++=
++++-
+ include/linux/mtd/nand.h                           |  1 -
+ 11 files changed, 197 insertions(+), 81 deletions(-)
+Merging spi-nor/spi-nor/next (bb0e9c600ce2 mtd: spi-nor: core: Add an erro=
r message when failing to exit the 4-byte address mode)
+$ git merge -m Merge branch 'spi-nor/next' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mtd/linux.git spi-nor/spi-nor/next
+Auto-merging drivers/mtd/spi-nor/core.c
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/mtd/jedec,spi-nor.yaml     |  8 +++
+ drivers/mtd/spi-nor/core.c                         | 39 +++++++++++++-
+ drivers/mtd/spi-nor/micron-st.c                    | 10 ++--
+ drivers/mtd/spi-nor/sfdp.c                         |  7 +++
+ drivers/mtd/spi-nor/spansion.c                     | 61 ++++++++++++++---=
-----
+ 5 files changed, 98 insertions(+), 27 deletions(-)
+Merging crypto/master (329cfa42e528 crypto: doc - use correct function nam=
e)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/herbert/cryptodev-2.6.git crypto/master
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ Documentation/crypto/devel-algos.rst               |    2 +-
+ Documentation/crypto/userspace-if.rst              |   15 +-
+ .../bindings/crypto/rockchip,rk3288-crypto.yaml    |  127 +++
+ .../devicetree/bindings/crypto/rockchip-crypto.txt |   28 -
+ .../devicetree/bindings/rng/nuvoton,npcm-rng.yaml  |    4 +-
+ MAINTAINERS                                        |    7 +
+ arch/arm64/crypto/Kconfig                          |   47 +-
+ arch/arm64/crypto/Makefile                         |    9 +
+ arch/arm64/crypto/sm3-ce-glue.c                    |    2 +-
+ arch/arm64/crypto/sm3-neon-core.S                  |  600 ++++++++++
+ arch/arm64/crypto/sm3-neon-glue.c                  |  103 ++
+ arch/arm64/crypto/sm4-ce-asm.h                     |  209 ++++
+ arch/arm64/crypto/sm4-ce-ccm-core.S                |  328 ++++++
+ arch/arm64/crypto/sm4-ce-ccm-glue.c                |  303 +++++
+ arch/arm64/crypto/sm4-ce-core.S                    | 1205 +++++++++++++--=
-----
+ arch/arm64/crypto/sm4-ce-gcm-core.S                |  741 ++++++++++++
+ arch/arm64/crypto/sm4-ce-gcm-glue.c                |  286 +++++
+ arch/arm64/crypto/sm4-ce-glue.c                    |  575 +++++++++-
+ arch/arm64/crypto/sm4-ce.h                         |   16 +
+ arch/arm64/crypto/sm4-neon-core.S                  |  630 ++++++----
+ arch/arm64/crypto/sm4-neon-glue.c                  |  172 +--
+ crypto/af_alg.c                                    |  135 ++-
+ crypto/ccm.c                                       |    2 +-
+ crypto/tcrypt.c                                    |  308 ++---
+ crypto/testmgr.c                                   |   19 +
+ crypto/testmgr.h                                   |  977 ++++++++++++++++
+ drivers/char/hw_random/mtk-rng.c                   |    5 +-
+ drivers/char/hw_random/npcm-rng.c                  |   14 +-
+ drivers/char/hw_random/stm32-rng.c                 |    8 +-
+ drivers/crypto/Kconfig                             |   15 +
+ .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    2 +-
+ drivers/crypto/cavium/nitrox/nitrox_mbx.c          |    1 +
+ drivers/crypto/ccp/ccp-crypto-main.c               |   11 +-
+ drivers/crypto/ccp/sp-pci.c                        |   11 +-
+ drivers/crypto/hisilicon/hpre/hpre_main.c          |   10 +-
+ drivers/crypto/hisilicon/qm.c                      |   59 +-
+ drivers/crypto/hisilicon/sec2/sec_main.c           |    2 +-
+ drivers/crypto/inside-secure/safexcel.c            |   69 +-
+ drivers/crypto/inside-secure/safexcel.h            |   10 +-
+ drivers/crypto/ixp4xx_crypto.c                     |   10 +-
+ drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h |    2 +-
+ drivers/crypto/n2_core.c                           |    6 +
+ drivers/crypto/rockchip/rk3288_crypto.c            |  506 ++++----
+ drivers/crypto/rockchip/rk3288_crypto.h            |  107 +-
+ drivers/crypto/rockchip/rk3288_crypto_ahash.c      |  267 +++--
+ drivers/crypto/rockchip/rk3288_crypto_skcipher.c   |  543 +++++----
+ drivers/crypto/stm32/stm32-cryp.c                  |    4 +-
+ drivers/crypto/talitos.c                           |    6 +-
+ drivers/crypto/talitos.h                           |    4 +-
+ include/crypto/scatterwalk.h                       |    1 -
+ include/uapi/linux/if_alg.h                        |    1 +
+ 51 files changed, 6821 insertions(+), 1703 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk32=
88-crypto.yaml
+ delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-cryp=
to.txt
+ create mode 100644 arch/arm64/crypto/sm3-neon-core.S
+ create mode 100644 arch/arm64/crypto/sm3-neon-glue.c
+ create mode 100644 arch/arm64/crypto/sm4-ce-asm.h
+ create mode 100644 arch/arm64/crypto/sm4-ce-ccm-core.S
+ create mode 100644 arch/arm64/crypto/sm4-ce-ccm-glue.c
+ create mode 100644 arch/arm64/crypto/sm4-ce-gcm-core.S
+ create mode 100644 arch/arm64/crypto/sm4-ce-gcm-glue.c
+ create mode 100644 arch/arm64/crypto/sm4-ce.h
+Merging drm/drm-next (49e8e6343df6 Merge tag 'amd-drm-next-6.2-2022-11-04'=
 of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
+$ git merge -m Merge branch 'drm-next' of git://git.freedesktop.org/git/dr=
m/drm.git drm/drm-next
+Auto-merging MAINTAINERS
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+Auto-merging drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+Auto-merging drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+Auto-merging drivers/gpu/drm/amd/display/dc/dc.h
+Auto-merging drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+Auto-merging drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+Auto-merging drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+Auto-merging drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+Auto-merging drivers/gpu/drm/bridge/parade-ps8640.c
+Auto-merging drivers/gpu/drm/drm_format_helper.c
+Auto-merging drivers/gpu/drm/i915/Makefile
+Auto-merging drivers/gpu/drm/i915/display/intel_ddi.c
+CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_d=
di.c
+Auto-merging drivers/gpu/drm/i915/display/intel_display_core.h
+Auto-merging drivers/gpu/drm/i915/display/intel_display_power_well.c
+CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_d=
isplay_power_well.c
+Auto-merging drivers/gpu/drm/i915/display/intel_dkl_phy.c
+CONFLICT (add/add): Merge conflict in drivers/gpu/drm/i915/display/intel_d=
kl_phy.c
+Auto-merging drivers/gpu/drm/i915/display/intel_dkl_phy.h
+CONFLICT (add/add): Merge conflict in drivers/gpu/drm/i915/display/intel_d=
kl_phy.h
+Auto-merging drivers/gpu/drm/i915/display/intel_dp.c
+CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_d=
p.c
+Auto-merging drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_d=
pll_mgr.c
+Auto-merging drivers/gpu/drm/i915/display/intel_lvds.c
+CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_l=
vds.c
+Auto-merging drivers/gpu/drm/i915/display/intel_panel.c
+Auto-merging drivers/gpu/drm/i915/display/intel_psr.c
+Auto-merging drivers/gpu/drm/i915/display/intel_sdvo.c
+CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_s=
dvo.c
+Auto-merging drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gem/i915_gem_dm=
abuf.c
+Auto-merging drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+Auto-merging drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+Auto-merging drivers/gpu/drm/i915/gt/intel_workarounds.c
+Auto-merging drivers/gpu/drm/i915/i915_driver.c
+Auto-merging drivers/gpu/drm/i915/i915_reg.h
+CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_reg.h
+Auto-merging drivers/gpu/drm/i915/intel_runtime_pm.c
+Auto-merging drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+Auto-merging drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+Auto-merging drivers/gpu/drm/scheduler/sched_entity.c
+Auto-merging drivers/gpu/drm/vc4/vc4_hdmi.c
+Auto-merging drivers/gpu/drm/vc4/vc4_hdmi.h
+Resolved 'drivers/gpu/drm/amd/amdkfd/kfd_crat.c' using previous resolution.
+Resolved 'drivers/gpu/drm/i915/display/intel_ddi.c' using previous resolut=
ion.
+Resolved 'drivers/gpu/drm/i915/display/intel_display_power_well.c' using p=
revious resolution.
+Resolved 'drivers/gpu/drm/i915/display/intel_dkl_phy.c' using previous res=
olution.
+Resolved 'drivers/gpu/drm/i915/display/intel_dkl_phy.h' using previous res=
olution.
+Resolved 'drivers/gpu/drm/i915/display/intel_dp.c' using previous resoluti=
on.
+Resolved 'drivers/gpu/drm/i915/display/intel_dpll_mgr.c' using previous re=
solution.
+Resolved 'drivers/gpu/drm/i915/display/intel_lvds.c' using previous resolu=
tion.
+Resolved 'drivers/gpu/drm/i915/display/intel_sdvo.c' using previous resolu=
tion.
+Recorded preimage for 'drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c'
+Resolved 'drivers/gpu/drm/i915/i915_reg.h' using previous resolution.
+Automatic merge failed; fix conflicts and then commit the result.
+$ git commit --no-edit -v -a
+Recorded resolution for 'drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c'.
+[master 78db628378d0] Merge branch 'drm-next' of git://git.freedesktop.org=
/git/drm/drm.git
+$ git diff -M --stat --summary HEAD^..
+ .../ABI/testing/sysfs-driver-intel-i915-hwmon      |   75 ++
+ .../bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   |   67 +
+ Documentation/driver-api/dma-buf.rst               |    6 +
+ Documentation/gpu/todo.rst                         |   11 -
+ MAINTAINERS                                        |    2 +
+ arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   20 +
+ arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   24 +
+ drivers/clk/bcm/clk-raspberrypi.c                  |   19 -
+ drivers/dma-buf/dma-buf.c                          |  218 ++-
+ drivers/firmware/raspberrypi.c                     |   38 +-
+ drivers/gpu/drm/Makefile                           |  107 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    4 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    6 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    3 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |    4 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   18 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    6 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    1 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |    2 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    6 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    2 -
+ drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    3 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   57 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   12 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c         |  217 ++-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h         |    5 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   31 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   30 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h     |    4 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c  |    4 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |    2 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   14 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |    1 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |   87 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |    9 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    4 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |    5 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |    2 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |    8 +-
+ drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |    7 +-
+ drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    2 -
+ drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |    2 -
+ drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    1 -
+ drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    2 -
+ drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   10 +-
+ drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   37 +-
+ drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    2 +
+ drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   34 +-
+ drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |    3 +
+ drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c         |    3 +
+ drivers/gpu/drm/amd/amdgpu/mes_v10_1.c             |    8 +-
+ drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |    8 +-
+ drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |    4 +
+ drivers/gpu/drm/amd/amdgpu/si_dma.c                |    2 -
+ drivers/gpu/drm/amd/amdgpu/soc21.c                 |   12 +-
+ drivers/gpu/drm/amd/amdgpu/umc_v6_7.c              |    7 +-
+ drivers/gpu/drm/amd/amdgpu/umc_v6_7.h              |    4 +-
+ drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |    6 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  374 ++---
+ drivers/gpu/drm/amd/amdkfd/kfd_crat.h              |   36 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   16 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |   29 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |    8 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_diq.h   |  291 ----
+ drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    4 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   12 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   19 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  270 +++-
+ drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |    6 +-
+ drivers/gpu/drm/amd/display/Kconfig                |    3 +-
+ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   91 +-
+ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    7 -
+ .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  157 ++-
+ .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |   12 +-
+ .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    3 +
+ .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   57 +-
+ .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |    2 +-
+ .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   35 -
+ .../amd/display/amdgpu_dm/amdgpu_dm_irq_params.h   |    2 +-
+ .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   11 +-
+ .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |   64 +
+ drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |    6 +
+ .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h        |    4 +-
+ .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |   71 +-
+ drivers/gpu/drm/amd/display/dc/core/dc.c           |  486 ++++---
+ .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   13 +-
+ drivers/gpu/drm/amd/display/dc/core/dc_link.c      |    6 +-
+ drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  162 +--
+ drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  256 +++-
+ drivers/gpu/drm/amd/display/dc/dc.h                |   91 +-
+ drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |  124 +-
+ drivers/gpu/drm/amd/display/dc/dc_link.h           |   22 +-
+ drivers/gpu/drm/amd/display/dc/dc_stream.h         |   23 +-
+ drivers/gpu/drm/amd/display/dc/dc_trace.h          |    2 +
+ drivers/gpu/drm/amd/display/dc/dc_types.h          |    7 +
+ drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   14 +-
+ drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |    6 +-
+ .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   72 +-
+ .../gpu/drm/amd/display/dc/dce60/dce60_resource.c  |    3 +
+ .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |    2 +
+ drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |    5 +
+ .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   44 +-
+ drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   36 +-
+ .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   16 +
+ .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |    5 +-
+ drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c  |    9 +
+ .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |   15 +-
+ .../drm/amd/display/dc/dcn302/dcn302_resource.c    |   14 +-
+ .../drm/amd/display/dc/dcn303/dcn303_resource.c    |   13 +-
+ drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c   |   13 -
+ drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h   |    4 -
+ .../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c |    9 -
+ drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |    6 +-
+ .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  |    6 +
+ .../gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c    |    2 +-
+ .../drm/amd/display/dc/dcn314/dcn314_resource.c    |    6 +
+ .../drm/amd/display/dc/dcn315/dcn315_resource.c    |    6 +
+ .../drm/amd/display/dc/dcn316/dcn316_resource.c    |    6 +
+ .../gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c    |    4 +
+ drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |    6 +-
+ .../gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c  |    2 +-
+ drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c   |    2 +-
+ .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |    7 +-
+ drivers/gpu/drm/amd/display/dc/dml/Makefile        |   20 +-
+ drivers/gpu/drm/amd/display/dc/dml/dc_features.h   |    7 +
+ .../gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c   |   36 +
+ .../gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h   |    2 +
+ .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |    2 +-
+ .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |    2 -
+ .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |    3 +-
+ .../display/dc/dml/dcn314/display_mode_vba_314.c   |    3 +-
+ .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   35 +-
+ .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h   |    3 +
+ .../drm/amd/display/dc/dml/display_mode_enums.h    |   25 +
+ .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |    9 +
+ drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h |   36 +-
+ drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   61 +-
+ drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |    2 +-
+ drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |   15 +
+ drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |   16 +-
+ drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |    7 +
+ .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |    6 +-
+ .../drm/amd/display/dc/inc/hw/timing_generator.h   |    5 +
+ drivers/gpu/drm/amd/display/dc/inc/link_hwss.h     |    5 +
+ drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |   17 +-
+ .../gpu/drm/amd/display/dc/link/link_hwss_dio.c    |   52 +
+ .../gpu/drm/amd/display/dc/link/link_hwss_dio.h    |    4 +
+ .../gpu/drm/amd/display/dc/link/link_hwss_dpia.c   |    3 +
+ .../gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c |   25 +
+ drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   43 +
+ .../drm/amd/display/modules/inc/mod_info_packet.h  |    3 +-
+ .../amd/display/modules/info_packet/info_packet.c  |    6 +-
+ drivers/gpu/drm/amd/include/atombios.h             |    2 +-
+ drivers/gpu/drm/amd/include/kgd_pp_interface.h     |    3 +-
+ drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |    3 +-
+ drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c    |    2 +
+ drivers/gpu/drm/armada/armada_gem.c                |    8 +-
+ drivers/gpu/drm/ast/Kconfig                        |    4 +-
+ drivers/gpu/drm/ast/ast_drv.c                      |    4 +-
+ drivers/gpu/drm/ast/ast_drv.h                      |   34 +-
+ drivers/gpu/drm/ast/ast_main.c                     |    5 +-
+ drivers/gpu/drm/ast/ast_mm.c                       |   14 +-
+ drivers/gpu/drm/ast/ast_mode.c                     |  499 +++----
+ drivers/gpu/drm/bridge/adv7511/adv7511.h           |    3 +-
+ drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   24 +-
+ drivers/gpu/drm/bridge/adv7511/adv7533.c           |   45 +-
+ drivers/gpu/drm/bridge/ite-it6505.c                |  164 ++-
+ drivers/gpu/drm/bridge/parade-ps8640.c             |    9 +-
+ drivers/gpu/drm/bridge/tc358775.c                  |    2 +-
+ drivers/gpu/drm/display/Makefile                   |   14 +-
+ drivers/gpu/drm/drm_atomic_helper.c                |   60 +-
+ drivers/gpu/drm/drm_atomic_state_helper.c          |    6 +-
+ drivers/gpu/drm/drm_atomic_uapi.c                  |    4 +
+ drivers/gpu/drm/drm_client.c                       |   10 +-
+ drivers/gpu/drm/drm_connector.c                    |    4 +
+ drivers/gpu/drm/drm_crtc_helper.c                  |   26 +
+ drivers/gpu/drm/drm_crtc_internal.h                |   15 +-
+ drivers/gpu/drm/drm_debugfs.c                      |    8 +-
+ drivers/gpu/drm/drm_edid.c                         |  702 ++++++----
+ drivers/gpu/drm/drm_edid_load.c                    |  109 +-
+ drivers/gpu/drm/drm_format_helper.c                |   10 +
+ drivers/gpu/drm/drm_gem.c                          |   24 +
+ drivers/gpu/drm/drm_gem_dma_helper.c               |    6 +-
+ drivers/gpu/drm/drm_gem_framebuffer_helper.c       |    6 +-
+ drivers/gpu/drm/drm_gem_ttm_helper.c               |    9 +-
+ drivers/gpu/drm/drm_mipi_dsi.c                     |    2 +-
+ drivers/gpu/drm/drm_mode_config.c                  |    3 -
+ drivers/gpu/drm/drm_modes.c                        |   18 +-
+ drivers/gpu/drm/drm_plane_helper.c                 |    4 +-
+ drivers/gpu/drm/drm_prime.c                        |    6 +-
+ drivers/gpu/drm/drm_probe_helper.c                 |    2 +-
+ drivers/gpu/drm/drm_rect.c                         |    2 +-
+ drivers/gpu/drm/drm_simple_kms_helper.c            |    6 +-
+ drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |    2 +-
+ drivers/gpu/drm/gma500/framebuffer.c               |    6 +-
+ drivers/gpu/drm/gma500/psb_drv.h                   |    1 +
+ drivers/gpu/drm/gud/gud_connector.c                |    2 +-
+ drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |   16 +-
+ drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |    3 -
+ drivers/gpu/drm/i915/Kconfig.profile               |   26 +-
+ drivers/gpu/drm/i915/Makefile                      |   14 +-
+ drivers/gpu/drm/i915/display/g4x_hdmi.c            |    4 +-
+ drivers/gpu/drm/i915/display/hsw_ips.c             |    8 +-
+ drivers/gpu/drm/i915/display/icl_dsi.c             |   21 +-
+ drivers/gpu/drm/i915/display/intel_atomic.c        |    8 +
+ drivers/gpu/drm/i915/display/intel_atomic_plane.c  |   58 +-
+ drivers/gpu/drm/i915/display/intel_audio.c         |  656 +++++----
+ drivers/gpu/drm/i915/display/intel_audio_regs.h    |   87 +-
+ drivers/gpu/drm/i915/display/intel_bios.c          |   10 +-
+ drivers/gpu/drm/i915/display/intel_cdclk.c         |   89 +-
+ drivers/gpu/drm/i915/display/intel_color.c         |  360 +++--
+ drivers/gpu/drm/i915/display/intel_color.h         |    6 +-
+ drivers/gpu/drm/i915/display/intel_combo_phy.c     |   18 +-
+ drivers/gpu/drm/i915/display/intel_connector.c     |   18 +
+ drivers/gpu/drm/i915/display/intel_connector.h     |    1 +
+ drivers/gpu/drm/i915/display/intel_crt.c           |    9 +-
+ drivers/gpu/drm/i915/display/intel_crtc.c          |    8 +-
+ .../gpu/drm/i915/display/intel_crtc_state_dump.c   |   12 +-
+ drivers/gpu/drm/i915/display/intel_cursor.c        |    6 +-
+ drivers/gpu/drm/i915/display/intel_ddi.c           |   35 +-
+ drivers/gpu/drm/i915/display/intel_display.c       |  148 +-
+ drivers/gpu/drm/i915/display/intel_display.h       |    7 +-
+ drivers/gpu/drm/i915/display/intel_display_core.h  |    5 +
+ .../gpu/drm/i915/display/intel_display_debugfs.c   |  309 +----
+ drivers/gpu/drm/i915/display/intel_display_power.c |    3 +-
+ .../drm/i915/display/intel_display_power_well.c    |    3 +-
+ drivers/gpu/drm/i915/display/intel_display_types.h |   27 +-
+ drivers/gpu/drm/i915/display/intel_dkl_phy.c       |   33 +-
+ drivers/gpu/drm/i915/display/intel_dkl_phy.h       |   10 +-
+ drivers/gpu/drm/i915/display/intel_dkl_phy_regs.h  |  204 +++
+ drivers/gpu/drm/i915/display/intel_dmc.c           |   22 +-
+ drivers/gpu/drm/i915/display/intel_dp.c            |  104 +-
+ drivers/gpu/drm/i915/display/intel_dp_hdcp.c       |   20 +-
+ drivers/gpu/drm/i915/display/intel_dp_mst.c        |   46 +-
+ drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |  114 +-
+ drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |    3 -
+ drivers/gpu/drm/i915/display/intel_dpt.c           |    1 +
+ drivers/gpu/drm/i915/display/intel_drrs.c          |  112 +-
+ drivers/gpu/drm/i915/display/intel_drrs.h          |    4 +-
+ drivers/gpu/drm/i915/display/intel_dvo.c           |    6 +-
+ drivers/gpu/drm/i915/display/intel_fb.c            |   13 +
+ drivers/gpu/drm/i915/display/intel_fb.h            |    1 +
+ drivers/gpu/drm/i915/display/intel_fb_pin.c        |    1 -
+ drivers/gpu/drm/i915/display/intel_fbc.c           |   33 +-
+ drivers/gpu/drm/i915/display/intel_fbdev.c         |    6 +-
+ drivers/gpu/drm/i915/display/intel_hdmi.c          |   25 +-
+ drivers/gpu/drm/i915/display/intel_hotplug.c       |  216 ++-
+ drivers/gpu/drm/i915/display/intel_hotplug.h       |    3 +-
+ drivers/gpu/drm/i915/display/intel_lpe_audio.c     |    9 +-
+ drivers/gpu/drm/i915/display/intel_lvds.c          |   47 +-
+ .../{intel_tc_phy_regs.h =3D> intel_mg_phy_regs.h}   |    6 +-
+ drivers/gpu/drm/i915/display/intel_modeset_setup.c |   22 +-
+ .../gpu/drm/i915/display/intel_modeset_verify.c    |    3 +-
+ drivers/gpu/drm/i915/display/intel_opregion.c      |    7 +-
+ drivers/gpu/drm/i915/display/intel_panel.c         |   30 +-
+ drivers/gpu/drm/i915/display/intel_pipe_crc.c      |    9 +-
+ drivers/gpu/drm/i915/display/intel_psr.c           |   36 +-
+ drivers/gpu/drm/i915/display/intel_sdvo.c          |  172 ++-
+ drivers/gpu/drm/i915/display/intel_tc.c            |   78 +-
+ drivers/gpu/drm/i915/display/intel_tc.h            |    3 +-
+ drivers/gpu/drm/i915/display/intel_tv.c            |   87 +-
+ drivers/gpu/drm/i915/display/skl_watermark.c       |   24 +-
+ drivers/gpu/drm/i915/display/vlv_dsi.c             |   22 +-
+ drivers/gpu/drm/i915/gem/i915_gem_clflush.c        |    2 +-
+ drivers/gpu/drm/i915/gem/i915_gem_context.c        |    3 +-
+ drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |   53 +-
+ drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |    5 -
+ drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   21 +-
+ drivers/gpu/drm/i915/gem/i915_gem_object.c         |   26 +-
+ drivers/gpu/drm/i915/gem/i915_gem_object.h         |    4 +
+ drivers/gpu/drm/i915/gem/i915_gem_pages.c          |   12 +
+ drivers/gpu/drm/i915/gem/i915_gem_pm.c             |   35 +-
+ drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |  261 ++--
+ drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |  113 +-
+ drivers/gpu/drm/i915/gem/i915_gem_ttm.h            |   18 +-
+ drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c       |    2 +-
+ drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |    3 +-
+ drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |  157 ++-
+ .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |  118 +-
+ .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c   |   95 +-
+ drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |    1 +
+ drivers/gpu/drm/i915/gt/gen8_engine_cs.c           |   55 +-
+ drivers/gpu/drm/i915/gt/gen8_engine_cs.h           |   12 +-
+ drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |   92 +-
+ drivers/gpu/drm/i915/gt/intel_context.h            |    8 +
+ drivers/gpu/drm/i915/gt/intel_context_types.h      |    9 +-
+ drivers/gpu/drm/i915/gt/intel_engine.h             |    6 +
+ drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  113 +-
+ drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |   39 +
+ drivers/gpu/drm/i915/gt/intel_engine_regs.h        |    1 +
+ .../gpu/drm/i915/gt/intel_execlists_submission.c   |    4 +-
+ drivers/gpu/drm/i915/gt/intel_ggtt.c               |   18 +-
+ drivers/gpu/drm/i915/gt/intel_gpu_commands.h       |    4 +
+ drivers/gpu/drm/i915/gt/intel_gsc.c                |   23 +-
+ drivers/gpu/drm/i915/gt/intel_gt.c                 |  141 +-
+ drivers/gpu/drm/i915/gt/intel_gt.h                 |    1 +
+ drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c     |   38 +-
+ drivers/gpu/drm/i915/gt/intel_gt_mcr.c             |  305 ++++-
+ drivers/gpu/drm/i915/gt/intel_gt_mcr.h             |   24 +-
+ drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.c      |  196 +--
+ drivers/gpu/drm/i915/gt/intel_gt_regs.h            |  184 ++-
+ drivers/gpu/drm/i915/gt/intel_gt_sysfs.c           |   15 +-
+ drivers/gpu/drm/i915/gt/intel_gt_sysfs.h           |    7 +-
+ drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c        |  469 +++----
+ drivers/gpu/drm/i915/gt/intel_gt_types.h           |   23 +-
+ drivers/gpu/drm/i915/gt/intel_gtt.c                |   43 +-
+ drivers/gpu/drm/i915/gt/intel_gtt.h                |    3 +-
+ drivers/gpu/drm/i915/gt/intel_lrc.c                |  143 +-
+ drivers/gpu/drm/i915/gt/intel_lrc.h                |    2 +
+ drivers/gpu/drm/i915/gt/intel_migrate.c            |    1 +
+ drivers/gpu/drm/i915/gt/intel_mocs.c               |   12 +-
+ drivers/gpu/drm/i915/gt/intel_reset.c              |    2 +-
+ drivers/gpu/drm/i915/gt/intel_rps.c                |  265 +++-
+ drivers/gpu/drm/i915/gt/intel_rps.h                |    3 +
+ drivers/gpu/drm/i915/gt/intel_sseu.c               |    4 +-
+ drivers/gpu/drm/i915/gt/intel_workarounds.c        |  577 +++++---
+ drivers/gpu/drm/i915/gt/intel_workarounds_types.h  |    9 +-
+ drivers/gpu/drm/i915/gt/selftest_engine_cs.c       |   22 +-
+ drivers/gpu/drm/i915/gt/selftest_execlists.c       |   50 +-
+ drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |   36 +-
+ drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |   51 +-
+ drivers/gpu/drm/i915/gt/selftest_migrate.c         |    1 +
+ drivers/gpu/drm/i915/gt/selftest_rps.c             |   12 +-
+ drivers/gpu/drm/i915/gt/selftest_slpc.c            |  190 ++-
+ drivers/gpu/drm/i915/gt/selftest_workarounds.c     |    2 +-
+ drivers/gpu/drm/i915/gt/sysfs_engines.c            |   25 +-
+ drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h   |    1 +
+ .../gpu/drm/i915/gt/uc/abi/guc_actions_slpc_abi.h  |    9 +
+ drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h      |    9 +-
+ drivers/gpu/drm/i915/gt/uc/intel_guc.c             |    1 +
+ drivers/gpu/drm/i915/gt/uc/intel_guc.h             |   16 +
+ drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c         |   71 +-
+ drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c     |  119 +-
+ drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.c     |   61 +
+ drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c          |   12 +-
+ drivers/gpu/drm/i915/gt/uc/intel_guc_fwif.h        |   43 +
+ drivers/gpu/drm/i915/gt/uc/intel_guc_log.c         |    6 +-
+ drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c        |  103 ++
+ drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.h        |    4 +
+ drivers/gpu/drm/i915/gt/uc/intel_guc_slpc_types.h  |    3 +
+ drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |  332 ++++-
+ drivers/gpu/drm/i915/gt/uc/intel_huc.c             |  262 +++-
+ drivers/gpu/drm/i915/gt/uc/intel_huc.h             |   31 +
+ drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c          |   34 +
+ drivers/gpu/drm/i915/gt/uc/intel_huc_fw.h          |    1 +
+ drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |   24 +-
+ drivers/gpu/drm/i915/gvt/cfg_space.c               |    4 +-
+ drivers/gpu/drm/i915/gvt/handlers.c                |    4 +-
+ drivers/gpu/drm/i915/gvt/mmio_context.c            |   14 +-
+ drivers/gpu/drm/i915/i915_driver.c                 |   32 +-
+ drivers/gpu/drm/i915/i915_drv.h                    |   36 +-
+ drivers/gpu/drm/i915/i915_gem.c                    |   49 +-
+ drivers/gpu/drm/i915/i915_getparam.c               |    3 +
+ drivers/gpu/drm/i915/i915_gpu_error.c              |   12 +-
+ drivers/gpu/drm/i915/i915_hwmon.c                  |  732 ++++++++++
+ drivers/gpu/drm/i915/i915_hwmon.h                  |   20 +
+ drivers/gpu/drm/i915/i915_irq.c                    |  270 ++--
+ drivers/gpu/drm/i915/i915_pci.c                    |   11 +-
+ drivers/gpu/drm/i915/i915_perf.c                   |  582 ++++++--
+ drivers/gpu/drm/i915/i915_perf.h                   |    2 +
+ drivers/gpu/drm/i915/i915_perf_oa_regs.h           |    6 +-
+ drivers/gpu/drm/i915/i915_perf_types.h             |   47 +-
+ drivers/gpu/drm/i915/i915_reg.h                    |  213 +--
+ drivers/gpu/drm/i915/i915_reg_defs.h               |   27 +-
+ drivers/gpu/drm/i915/i915_request.c                |   24 +
+ drivers/gpu/drm/i915/i915_request.h                |    5 +
+ drivers/gpu/drm/i915/i915_scatterlist.c            |    4 +-
+ drivers/gpu/drm/i915/i915_selftest.h               |    2 +
+ drivers/gpu/drm/i915/i915_sw_fence.c               |    1 -
+ drivers/gpu/drm/i915/i915_sw_fence.h               |    1 -
+ drivers/gpu/drm/i915/i915_trace.h                  |   15 -
+ drivers/gpu/drm/i915/i915_ttm_buddy_manager.c      |   12 +-
+ drivers/gpu/drm/i915/i915_vma.c                    |    9 +-
+ drivers/gpu/drm/i915/intel_device_info.c           |   80 +-
+ drivers/gpu/drm/i915/intel_device_info.h           |   20 +-
+ drivers/gpu/drm/i915/intel_gvt_mmio_table.c        |    2 +-
+ drivers/gpu/drm/i915/intel_mchbar_regs.h           |   21 +
+ drivers/gpu/drm/i915/intel_pci_config.h            |   28 +-
+ drivers/gpu/drm/i915/intel_pm.c                    |  467 +++----
+ drivers/gpu/drm/i915/intel_region_ttm.c            |    2 +-
+ drivers/gpu/drm/i915/intel_runtime_pm.c            |    5 +
+ drivers/gpu/drm/i915/intel_runtime_pm.h            |   22 +
+ drivers/gpu/drm/i915/intel_step.c                  |   25 +
+ drivers/gpu/drm/i915/intel_step.h                  |   28 +-
+ drivers/gpu/drm/i915/intel_uncore.c                |  280 +++-
+ drivers/gpu/drm/i915/intel_uncore.h                |   10 +-
+ drivers/gpu/drm/i915/pxp/intel_pxp.c               |   32 +-
+ drivers/gpu/drm/i915/pxp/intel_pxp.h               |   32 -
+ drivers/gpu/drm/i915/pxp/intel_pxp_huc.c           |   69 +
+ drivers/gpu/drm/i915/pxp/intel_pxp_huc.h           |   13 +
+ drivers/gpu/drm/i915/pxp/intel_pxp_irq.h           |    8 +
+ drivers/gpu/drm/i915/pxp/intel_pxp_session.c       |    9 +-
+ drivers/gpu/drm/i915/pxp/intel_pxp_session.h       |   11 +-
+ drivers/gpu/drm/i915/pxp/intel_pxp_tee.c           |  142 +-
+ drivers/gpu/drm/i915/pxp/intel_pxp_tee.h           |    5 +
+ drivers/gpu/drm/i915/pxp/intel_pxp_tee_interface.h |   23 +-
+ drivers/gpu/drm/i915/pxp/intel_pxp_types.h         |    6 +
+ drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   10 +-
+ drivers/gpu/drm/i915/selftests/i915_perf.c         |   16 +-
+ drivers/gpu/drm/i915/selftests/i915_request.c      |  252 ++--
+ drivers/gpu/drm/i915/selftests/intel_uncore.c      |    4 +
+ drivers/gpu/drm/i915/selftests/mock_gem_device.c   |    1 -
+ drivers/gpu/drm/i915/vlv_suspend.c                 |   28 +-
+ drivers/gpu/drm/lima/lima_sched.c                  |    4 +-
+ drivers/gpu/drm/mgag200/mgag200_g200se.c           |    3 +-
+ drivers/gpu/drm/mgag200/mgag200_mode.c             |   11 +-
+ drivers/gpu/drm/msm/msm_fbdev.c                    |    2 -
+ drivers/gpu/drm/mxsfb/lcdif_kms.c                  |  253 +++-
+ drivers/gpu/drm/mxsfb/lcdif_regs.h                 |   41 +-
+ drivers/gpu/drm/nouveau/dispnv50/disp.c            |    4 +-
+ drivers/gpu/drm/nouveau/nouveau_bo.c               |    4 +-
+ drivers/gpu/drm/nouveau/nouveau_bo0039.c           |    4 +-
+ drivers/gpu/drm/nouveau/nouveau_bo5039.c           |    2 +-
+ drivers/gpu/drm/nouveau/nouveau_bo74c1.c           |    2 +-
+ drivers/gpu/drm/nouveau/nouveau_bo85b5.c           |    4 +-
+ drivers/gpu/drm/nouveau/nouveau_bo9039.c           |    4 +-
+ drivers/gpu/drm/nouveau/nouveau_bo90b5.c           |    4 +-
+ drivers/gpu/drm/nouveau/nouveau_boa0b5.c           |    2 +-
+ drivers/gpu/drm/nouveau/nouveau_display.c          |    2 -
+ drivers/gpu/drm/nouveau/nouveau_dmem.c             |    1 -
+ drivers/gpu/drm/nouveau/nouveau_gem.c              |    5 +-
+ drivers/gpu/drm/nouveau/nouveau_mem.c              |    4 +-
+ drivers/gpu/drm/nouveau/nouveau_ttm.c              |    2 +-
+ drivers/gpu/drm/nouveau/nv04_fbcon.c               |    6 +-
+ drivers/gpu/drm/omapdrm/omap_fbdev.c               |    2 -
+ drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |    4 +-
+ drivers/gpu/drm/panel/panel-edp.c                  |    2 +
+ drivers/gpu/drm/panel/panel-samsung-db7430.c       |    7 +
+ drivers/gpu/drm/panel/panel-sitronix-st7701.c      |   70 +-
+ drivers/gpu/drm/panel/panel-tpo-tpg110.c           |    7 +
+ drivers/gpu/drm/panel/panel-widechips-ws2401.c     |    7 +
+ drivers/gpu/drm/panfrost/panfrost_dump.c           |    4 +-
+ drivers/gpu/drm/panfrost/panfrost_perfcnt.c        |    6 +-
+ drivers/gpu/drm/qxl/qxl_display.c                  |    2 -
+ drivers/gpu/drm/qxl/qxl_object.c                   |   17 +-
+ drivers/gpu/drm/qxl/qxl_prime.c                    |    4 +-
+ drivers/gpu/drm/radeon/atombios.h                  |    2 +-
+ drivers/gpu/drm/radeon/radeon_atombios.c           |    7 +-
+ drivers/gpu/drm/radeon/radeon_cs.c                 |    7 +-
+ drivers/gpu/drm/radeon/radeon_device.c             |    2 +-
+ drivers/gpu/drm/radeon/radeon_display.c            |    2 -
+ drivers/gpu/drm/radeon/radeon_fb.c                 |    2 +-
+ drivers/gpu/drm/radeon/radeon_object.c             |    4 +-
+ drivers/gpu/drm/radeon/radeon_trace.h              |    2 +-
+ drivers/gpu/drm/radeon/radeon_ttm.c                |    8 +-
+ drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |    8 +-
+ drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |   43 -
+ drivers/gpu/drm/rockchip/rockchip_drm_fb.h         |    6 -
+ drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    4 +-
+ drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |    2 +-
+ drivers/gpu/drm/rockchip/rockchip_lvds.c           |   10 +-
+ drivers/gpu/drm/rockchip/rockchip_vop2_reg.c       |    2 +-
+ drivers/gpu/drm/scheduler/sched_entity.c           |   20 +
+ drivers/gpu/drm/scheduler/sched_main.c             |   96 +-
+ drivers/gpu/drm/solomon/ssd130x.c                  |   35 +-
+ drivers/gpu/drm/tegra/fb.c                         |    1 -
+ drivers/gpu/drm/tegra/gem.c                        |   17 +-
+ drivers/gpu/drm/tests/Makefile                     |   14 +-
+ drivers/gpu/drm/tests/drm_buddy_test.c             |    6 +-
+ drivers/gpu/drm/tests/drm_dp_mst_helper_test.c     |  445 +++---
+ drivers/gpu/drm/tests/drm_mm_test.c                |    8 +-
+ drivers/gpu/drm/tests/drm_plane_helper_test.c      |  467 ++++---
+ drivers/gpu/drm/tiny/Kconfig                       |   13 +
+ drivers/gpu/drm/tiny/Makefile                      |    1 +
+ drivers/gpu/drm/tiny/bochs.c                       |    1 -
+ drivers/gpu/drm/tiny/ofdrm.c                       | 1424 +++++++++++++++=
+++++
+ drivers/gpu/drm/tiny/simpledrm.c                   |   16 +-
+ drivers/gpu/drm/ttm/ttm_bo.c                       |    3 -
+ drivers/gpu/drm/ttm/ttm_bo_util.c                  |    6 +-
+ drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    4 +-
+ drivers/gpu/drm/ttm/ttm_range_manager.c            |    3 +-
+ drivers/gpu/drm/ttm/ttm_resource.c                 |   14 +-
+ drivers/gpu/drm/udl/Makefile                       |    2 +-
+ drivers/gpu/drm/udl/udl_connector.c                |  139 --
+ drivers/gpu/drm/udl/udl_connector.h                |   15 -
+ drivers/gpu/drm/udl/udl_drv.h                      |   42 +-
+ drivers/gpu/drm/udl/udl_modeset.c                  |  566 +++++---
+ drivers/gpu/drm/udl/udl_proto.h                    |   68 +
+ drivers/gpu/drm/udl/udl_transfer.c                 |    7 +-
+ drivers/gpu/drm/vc4/vc4_bo.c                       |    4 +-
+ drivers/gpu/drm/vc4/vc4_drv.h                      |   16 +
+ drivers/gpu/drm/vc4/vc4_hdmi.c                     |   27 +-
+ drivers/gpu/drm/vc4/vc4_hdmi.h                     |    8 -
+ drivers/gpu/drm/vc4/vc4_hvs.c                      |   26 +
+ drivers/gpu/drm/vc4/vc4_kms.c                      |   13 +-
+ drivers/gpu/drm/vc4/vc4_vec.c                      |    8 +-
+ drivers/gpu/drm/vmwgfx/Kconfig                     |    7 -
+ drivers/gpu/drm/vmwgfx/Makefile                    |    4 +-
+ drivers/gpu/drm/vmwgfx/ttm_object.c                |  123 +-
+ drivers/gpu/drm/vmwgfx/ttm_object.h                |   20 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |    4 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   22 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c         |   62 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |   31 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  129 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   53 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   17 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |  831 ------------
+ drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c      |    6 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.c            |  199 ---
+ drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.h            |   83 --
+ drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  669 ++++-----
+ drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   31 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |    8 -
+ drivers/gpu/drm/vmwgfx/vmwgfx_mksstat.h            |    2 +
+ drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |   59 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c         |    6 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   31 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   26 -
+ drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |   14 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |   55 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |   26 +-
+ drivers/gpu/drm/xlnx/Makefile                      |    2 +-
+ drivers/gpu/drm/xlnx/zynqmp_disp.c                 |  646 ++-------
+ drivers/gpu/drm/xlnx/zynqmp_disp.h                 |   48 +-
+ drivers/gpu/drm/xlnx/zynqmp_dp.c                   |  476 ++++---
+ drivers/gpu/drm/xlnx/zynqmp_dp.h                   |    4 +-
+ drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |  300 +++--
+ drivers/gpu/drm/xlnx/zynqmp_dpsub.h                |   46 +-
+ drivers/gpu/drm/xlnx/zynqmp_kms.c                  |  534 ++++++++
+ drivers/gpu/drm/xlnx/zynqmp_kms.h                  |   46 +
+ drivers/infiniband/core/umem_dmabuf.c              |    7 +-
+ .../media/common/videobuf2/videobuf2-dma-contig.c  |   22 +-
+ drivers/media/common/videobuf2/videobuf2-dma-sg.c  |   19 +-
+ drivers/media/common/videobuf2/videobuf2-vmalloc.c |   17 +-
+ .../media/platform/nvidia/tegra-vde/dmabuf-cache.c |    6 +-
+ drivers/misc/fastrpc.c                             |    6 +-
+ drivers/misc/mei/bus.c                             |  146 +-
+ drivers/misc/mei/client.c                          |   55 +-
+ drivers/misc/mei/hbm.c                             |   13 +
+ drivers/misc/mei/hw-me.c                           |    7 +-
+ drivers/misc/mei/hw.h                              |   89 +-
+ drivers/misc/mei/interrupt.c                       |   47 +-
+ drivers/misc/mei/mei_dev.h                         |    8 +
+ drivers/misc/mei/pxp/mei_pxp.c                     |   38 +-
+ drivers/video/fbdev/Kconfig                        |    1 +
+ drivers/xen/gntdev-dmabuf.c                        |    8 +-
+ include/drm/drm_atomic_helper.h                    |    3 +-
+ include/drm/drm_atomic_state_helper.h              |    2 +-
+ include/drm/drm_connector.h                        |   26 +-
+ include/drm/drm_crtc_helper.h                      |    2 +
+ include/drm/drm_edid.h                             |   24 +-
+ include/drm/drm_gem.h                              |    3 +
+ include/drm/drm_mode_config.h                      |    2 -
+ include/drm/gpu_scheduler.h                        |   32 +
+ include/drm/i915_pxp_tee_interface.h               |    5 +
+ include/drm/ttm/ttm_resource.h                     |    4 +-
+ include/drm/ttm/ttm_tt.h                           |    2 +-
+ include/linux/dma-buf.h                            |   17 +-
+ include/linux/mei_cl_bus.h                         |    6 +
+ include/soc/bcm2835/raspberrypi-firmware.h         |   52 +
+ include/uapi/drm/drm_fourcc.h                      |   29 +
+ include/uapi/drm/drm_mode.h                        |   63 +-
+ include/uapi/drm/i915_drm.h                        |   62 +-
+ 554 files changed, 18225 insertions(+), 10714 deletions(-)
+ create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon
+ delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_diq.h
+ create mode 100644 drivers/gpu/drm/i915/display/intel_dkl_phy_regs.h
+ rename drivers/gpu/drm/i915/display/{intel_tc_phy_regs.h =3D> intel_mg_ph=
y_regs.h} (99%)
+ create mode 100644 drivers/gpu/drm/i915/i915_hwmon.c
+ create mode 100644 drivers/gpu/drm/i915/i915_hwmon.h
+ create mode 100644 drivers/gpu/drm/i915/pxp/intel_pxp_huc.c
+ create mode 100644 drivers/gpu/drm/i915/pxp/intel_pxp_huc.h
+ create mode 100644 drivers/gpu/drm/tiny/ofdrm.c
+ delete mode 100644 drivers/gpu/drm/udl/udl_connector.c
+ delete mode 100644 drivers/gpu/drm/udl/udl_connector.h
+ create mode 100644 drivers/gpu/drm/udl/udl_proto.h
+ delete mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+ delete mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.c
+ delete mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_hashtab.h
+ create mode 100644 drivers/gpu/drm/xlnx/zynqmp_kms.c
+ create mode 100644 drivers/gpu/drm/xlnx/zynqmp_kms.h
+Merging drm-misc/for-linux-next (1a0257c35263 MAINTAINERS: Update GPU Sche=
duler email)
+$ git merge -m Merge branch 'for-linux-next' of git://anongit.freedesktop.=
org/drm/drm-misc drm-misc/for-linux-next
+Auto-merging MAINTAINERS
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+Auto-merging drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+Auto-merging drivers/gpu/drm/imx/imx-tve.c
+Auto-merging drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+Auto-merging drivers/gpu/drm/vc4/vc4_drv.c
+Merge made by the 'ort' strategy.
+ .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |   30 +-
+ Documentation/gpu/drm-kms-helpers.rst              |    3 +
+ MAINTAINERS                                        |    2 +-
+ drivers/gpu/drm/Makefile                           |    4 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    2 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |    1 -
+ drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   42 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h             |    2 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    1 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |    3 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    1 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    2 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |   56 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |    3 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   81 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |   17 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |    7 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    1 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |    1 -
+ drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |   56 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h           |    2 +
+ drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   72 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   15 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   13 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   22 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |   71 +-
+ drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    1 +
+ drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |    1 +
+ drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    1 +
+ drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    1 +
+ drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   12 +-
+ drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |    8 +-
+ drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |   12 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   17 +-
+ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    2 -
+ drivers/gpu/drm/arm/display/komeda/komeda_drv.c    |    2 +-
+ drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |    2 -
+ drivers/gpu/drm/arm/hdlcd_crtc.c                   |   25 +-
+ drivers/gpu/drm/arm/hdlcd_drv.c                    |   43 +-
+ drivers/gpu/drm/arm/hdlcd_drv.h                    |    2 +
+ drivers/gpu/drm/arm/malidp_drv.c                   |    2 +-
+ drivers/gpu/drm/armada/armada_fbdev.c              |    6 +-
+ drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |    2 +-
+ drivers/gpu/drm/ast/ast_drv.c                      |    1 +
+ drivers/gpu/drm/ast/ast_drv.h                      |    1 -
+ drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |    2 +-
+ drivers/gpu/drm/bridge/tc358762.c                  |    2 +-
+ drivers/gpu/drm/drm_atomic_helper.c                |   34 +-
+ drivers/gpu/drm/drm_crtc_helper.c                  |    1 -
+ drivers/gpu/drm/drm_fb_helper.c                    | 1008 ++++++---------=
-----
+ drivers/gpu/drm/drm_fbdev_generic.c                |  494 ++++++++++
+ drivers/gpu/drm/drm_gem_atomic_helper.c            |   66 +-
+ drivers/gpu/drm/drm_gem_framebuffer_helper.c       |    1 -
+ drivers/gpu/drm/drm_probe_helper.c                 |    1 -
+ drivers/gpu/drm/drm_simple_kms_helper.c            |   26 +
+ drivers/gpu/drm/etnaviv/etnaviv_drv.h              |    3 +-
+ drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |    6 +-
+ drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |    2 +-
+ drivers/gpu/drm/gma500/framebuffer.c               |    6 +-
+ drivers/gpu/drm/gud/gud_drv.c                      |    2 +-
+ drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    1 +
+ drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |    1 -
+ drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    2 +
+ drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |    2 +-
+ drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |    2 +-
+ drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |    1 -
+ drivers/gpu/drm/i915/display/intel_fbdev.c         |    8 +-
+ drivers/gpu/drm/imx/dcss/dcss-kms.c                |    3 +-
+ drivers/gpu/drm/imx/imx-drm-core.c                 |    2 +-
+ drivers/gpu/drm/imx/imx-ldb.c                      |    2 +-
+ drivers/gpu/drm/imx/imx-tve.c                      |    1 -
+ drivers/gpu/drm/imx/parallel-display.c             |    2 +-
+ drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    9 +-
+ drivers/gpu/drm/kmb/kmb_drv.c                      |    2 +-
+ drivers/gpu/drm/kmb/kmb_plane.c                    |    1 -
+ drivers/gpu/drm/logicvc/logicvc_drm.c              |    2 +-
+ drivers/gpu/drm/logicvc/logicvc_mode.c             |    2 -
+ drivers/gpu/drm/mcde/mcde_drv.c                    |    3 +-
+ drivers/gpu/drm/mediatek/mtk_drm_drv.c             |    2 +-
+ drivers/gpu/drm/meson/meson_drv.c                  |    2 +-
+ drivers/gpu/drm/meson/meson_encoder_cvbs.c         |    7 +-
+ drivers/gpu/drm/mgag200/mgag200_drv.c              |    1 +
+ drivers/gpu/drm/mgag200/mgag200_drv.h              |    1 -
+ drivers/gpu/drm/msm/msm_fbdev.c                    |    4 +-
+ drivers/gpu/drm/mxsfb/lcdif_drv.c                  |    2 +-
+ drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |    2 +-
+ drivers/gpu/drm/nouveau/nouveau_fbcon.c            |   27 +-
+ drivers/gpu/drm/omapdrm/omap_fbdev.c               |    6 +-
+ drivers/gpu/drm/panel/panel-ilitek-ili9341.c       |    3 +-
+ drivers/gpu/drm/pl111/pl111_drv.c                  |    2 +-
+ drivers/gpu/drm/qxl/qxl_drv.c                      |    1 +
+ drivers/gpu/drm/qxl/qxl_drv.h                      |    1 -
+ drivers/gpu/drm/radeon/radeon_fb.c                 |    6 +-
+ drivers/gpu/drm/rcar-du/rcar_du_drv.c              |    2 +-
+ drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |    2 +-
+ drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |    2 +-
+ drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |    2 -
+ drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |    1 +
+ drivers/gpu/drm/scheduler/sched_entity.c           |  196 ++--
+ drivers/gpu/drm/scheduler/sched_main.c             |   75 +-
+ drivers/gpu/drm/solomon/ssd130x.c                  |    2 +-
+ drivers/gpu/drm/sti/sti_drv.c                      |    2 +-
+ drivers/gpu/drm/stm/drv.c                          |    2 +-
+ drivers/gpu/drm/sun4i/sun4i_drv.c                  |    2 +-
+ drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   61 +-
+ drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h             |    7 +
+ drivers/gpu/drm/tegra/fb.c                         |    8 +-
+ drivers/gpu/drm/tidss/tidss_drv.c                  |    2 +-
+ drivers/gpu/drm/tidss/tidss_kms.c                  |    1 -
+ drivers/gpu/drm/tilcdc/tilcdc_drv.c                |    2 +-
+ drivers/gpu/drm/tiny/Kconfig                       |    2 +-
+ drivers/gpu/drm/tiny/arcpgu.c                      |    2 +-
+ drivers/gpu/drm/tiny/bochs.c                       |    2 +-
+ drivers/gpu/drm/tiny/cirrus.c                      |    2 +-
+ drivers/gpu/drm/tiny/gm12u320.c                    |    2 +-
+ drivers/gpu/drm/tiny/hx8357d.c                     |    2 +-
+ drivers/gpu/drm/tiny/ili9163.c                     |    2 +-
+ drivers/gpu/drm/tiny/ili9225.c                     |    2 +-
+ drivers/gpu/drm/tiny/ili9341.c                     |    2 +-
+ drivers/gpu/drm/tiny/ili9486.c                     |    2 +-
+ drivers/gpu/drm/tiny/mi0283qt.c                    |    2 +-
+ drivers/gpu/drm/tiny/ofdrm.c                       |   29 +-
+ drivers/gpu/drm/tiny/panel-mipi-dbi.c              |    2 +-
+ drivers/gpu/drm/tiny/repaper.c                     |    2 +-
+ drivers/gpu/drm/tiny/simpledrm.c                   |    2 +-
+ drivers/gpu/drm/tiny/st7586.c                      |    2 +-
+ drivers/gpu/drm/tiny/st7735r.c                     |    2 +-
+ drivers/gpu/drm/ttm/ttm_pool.c                     |   82 +-
+ drivers/gpu/drm/tve200/tve200_drv.c                |    3 +-
+ drivers/gpu/drm/udl/udl_drv.c                      |    2 +-
+ drivers/gpu/drm/v3d/v3d_drv.c                      |    1 -
+ drivers/gpu/drm/vboxvideo/vbox_drv.c               |    4 +-
+ drivers/gpu/drm/vboxvideo/vbox_main.c              |    1 -
+ drivers/gpu/drm/vc4/vc4_drv.c                      |    2 +-
+ drivers/gpu/drm/virtio/virtgpu_drv.c               |    1 +
+ drivers/gpu/drm/virtio/virtgpu_drv.h               |    1 -
+ drivers/gpu/drm/vkms/vkms_drv.c                    |    2 +-
+ drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |    2 +-
+ drivers/gpu/drm/xen/xen_drm_front_gem.c            |    1 -
+ drivers/gpu/drm/xlnx/zynqmp_kms.c                  |    2 +-
+ include/drm/drm_fb_helper.h                        |   68 +-
+ include/drm/drm_fbdev_generic.h                    |   15 +
+ include/drm/drm_gem_atomic_helper.h                |   20 +-
+ include/drm/drm_modeset_helper_vtables.h           |   41 +-
+ include/drm/drm_simple_kms_helper.h                |   20 +
+ include/drm/gpu_scheduler.h                        |   20 +-
+ 146 files changed, 1740 insertions(+), 1396 deletions(-)
+ create mode 100644 drivers/gpu/drm/drm_fbdev_generic.c
+ create mode 100644 include/drm/drm_fbdev_generic.h
+Merging amdgpu/drm-next (d8ba9f202cd4 drm/amdgpu: force read discovery fil=
e if set discovery=3D2)
+$ git merge -m Merge branch 'drm-next' of https://gitlab.freedesktop.org/a=
gd5f/linux amdgpu/drm-next
+Auto-merging drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+Merge made by the 'ort' strategy.
+ drivers/gpu/drm/Kconfig                          |  56 -----------
+ drivers/gpu/drm/amd/amdgpu/Kconfig               |  29 ++++++
+ drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  59 ++----------
+ drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c    |   9 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |   4 +-
+ drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           |   7 ++
+ drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           |   7 ++
+ drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  79 +++++++++++++--
+ drivers/gpu/drm/radeon/Kconfig                   |  30 ++++++
+ drivers/gpu/drm/radeon/radeon.h                  |   8 ++
+ drivers/gpu/drm/radeon/radeon_audio.c            | 116 ++++++++++++++++++=
+++++
+ drivers/gpu/drm/radeon/radeon_device.c           |   4 +
+ include/uapi/drm/amdgpu_drm.h                    |  14 +++
+ 13 files changed, 304 insertions(+), 118 deletions(-)
+Merging drm-intel/for-linux-next (882ecff709b5 drm/i915: Use intel_crtc_ne=
eds_modeset() more)
+$ git merge -m Merge branch 'for-linux-next' of git://anongit.freedesktop.=
org/drm-intel drm-intel/for-linux-next
+Auto-merging drivers/gpu/drm/i915/display/intel_display.c
+Auto-merging drivers/gpu/drm/i915/display/intel_display.h
+Auto-merging drivers/gpu/drm/i915/display/intel_display_types.h
+Auto-merging drivers/gpu/drm/i915/display/intel_psr.c
+Auto-merging drivers/gpu/drm/i915/gvt/handlers.c
+Auto-merging drivers/gpu/drm/i915/i915_irq.c
+Auto-merging drivers/gpu/drm/i915/i915_reg.h
+Auto-merging drivers/gpu/drm/i915/intel_gvt_mmio_table.c
+Auto-merging drivers/gpu/drm/i915/intel_pm.c
+Merge made by the 'ort' strategy.
+ drivers/gpu/drm/i915/display/g4x_dp.h              |   2 +-
+ drivers/gpu/drm/i915/display/intel_cdclk.c         |   2 +-
+ drivers/gpu/drm/i915/display/intel_color.c         | 450 +++++++++++-----=
-----
+ drivers/gpu/drm/i915/display/intel_connector.h     |   2 +-
+ drivers/gpu/drm/i915/display/intel_display.c       |   3 +-
+ drivers/gpu/drm/i915/display/intel_display.h       |  29 --
+ drivers/gpu/drm/i915/display/intel_display_power.h |   3 +-
+ .../drm/i915/display/intel_display_power_well.h    |   2 +-
+ drivers/gpu/drm/i915/display/intel_display_types.h |  45 ---
+ drivers/gpu/drm/i915/display/intel_dpio_phy.c      |  42 ++
+ drivers/gpu/drm/i915/display/intel_dpio_phy.h      |  19 +-
+ drivers/gpu/drm/i915/display/intel_dpll.c          |   1 +
+ drivers/gpu/drm/i915/display/intel_dvo_dev.h       |   8 +-
+ drivers/gpu/drm/i915/display/intel_fbc.c           |   2 +-
+ drivers/gpu/drm/i915/display/intel_fifo_underrun.h |   3 +-
+ drivers/gpu/drm/i915/display/intel_gmbus.c         |  20 +-
+ drivers/gpu/drm/i915/display/intel_hdmi.h          |   8 +-
+ drivers/gpu/drm/i915/display/intel_pps.c           |   1 +
+ drivers/gpu/drm/i915/display/intel_psr.c           |  15 +-
+ drivers/gpu/drm/i915/display/intel_sprite.h        |   9 +-
+ drivers/gpu/drm/i915/display/skl_universal_plane.c |   5 +
+ drivers/gpu/drm/i915/display/skl_universal_plane.h |   1 +
+ drivers/gpu/drm/i915/display/skl_watermark.c       |   2 +-
+ drivers/gpu/drm/i915/gvt/display.c                 |   2 +
+ drivers/gpu/drm/i915/gvt/handlers.c                |   1 +
+ drivers/gpu/drm/i915/gvt/mmio.c                    |   1 +
+ drivers/gpu/drm/i915/i915_irq.c                    |  10 +-
+ drivers/gpu/drm/i915/i915_irq.h                    |   9 -
+ drivers/gpu/drm/i915/i915_reg.h                    |   3 +-
+ drivers/gpu/drm/i915/intel_device_info.c           |   2 +-
+ drivers/gpu/drm/i915/intel_gvt_mmio_table.c        |   1 +
+ drivers/gpu/drm/i915/intel_pm.c                    |  11 +-
+ drivers/gpu/drm/i915/vlv_sideband.c                |   2 +
+ 33 files changed, 372 insertions(+), 344 deletions(-)
+Merging drm-tegra/for-next (8748f3219e03 drm/tegra: Add Tegra234 support t=
o NVDEC driver)
+$ git merge -m Merge branch 'for-next' of https://gitlab.freedesktop.org/d=
rm/tegra.git drm-tegra/for-next
+Merge made by the 'ort' strategy.
+ drivers/gpu/drm/tegra/Makefile  |   3 +-
+ drivers/gpu/drm/tegra/dc.c      |   4 +-
+ drivers/gpu/drm/tegra/drm.c     |   1 +
+ drivers/gpu/drm/tegra/hdmi.c    |   9 +--
+ drivers/gpu/drm/tegra/nvdec.c   | 171 ++++++++++++++++++++++++++++++++++-=
-----
+ drivers/gpu/drm/tegra/riscv.c   | 106 +++++++++++++++++++++++++
+ drivers/gpu/drm/tegra/riscv.h   |  30 +++++++
+ drivers/gpu/drm/tegra/submit.c  |  11 +--
+ drivers/gpu/drm/tegra/uapi.c    |   2 +-
+ drivers/gpu/host1x/context.c    |   4 +
+ drivers/gpu/host1x/dev.c        |  12 +++
+ drivers/memory/tegra/mc.c       |  25 ++++++
+ drivers/memory/tegra/tegra234.c |   5 ++
+ include/linux/host1x.h          |   2 +
+ include/soc/tegra/mc.h          |  11 +++
+ 15 files changed, 352 insertions(+), 44 deletions(-)
+ create mode 100644 drivers/gpu/drm/tegra/riscv.c
+ create mode 100644 drivers/gpu/drm/tegra/riscv.h
+Merging drm-msm/msm-next (7f7a942c0a33 Merge tag 'drm-next-20221025' of gi=
t://linuxtv.org/pinchartl/media into drm-next)
+$ git merge -m Merge branch 'msm-next' of https://gitlab.freedesktop.org/d=
rm/msm.git drm-msm/msm-next
+Already up to date.
+Merging drm-msm-lumag/msm-next-lumag (ee417928fe0a Merge branches 'msm-nex=
t-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-d=
si', 'msm-next-lumag-hdmi' and 'msm-next-lumag-mdp5' into msm-next-lumag)
+$ git merge -m Merge branch 'msm-next-lumag' of https://gitlab.freedesktop=
.org/lumag/msm.git drm-msm-lumag/msm-next-lumag
+Auto-merging drivers/gpu/drm/msm/msm_drv.c
+Merge made by the 'ort' strategy.
+ .../bindings/display/msm/dpu-common.yaml           |  52 +++
+ .../bindings/display/msm/dpu-msm8998.yaml          | 223 -----------
+ .../bindings/display/msm/dpu-qcm2290.yaml          | 222 -----------
+ .../bindings/display/msm/dpu-sc7180.yaml           | 235 ------------
+ .../bindings/display/msm/dpu-sc7280.yaml           | 239 ------------
+ .../bindings/display/msm/dpu-sdm845.yaml           | 217 -----------
+ .../bindings/display/msm/dsi-controller-main.yaml  |   3 +
+ .../bindings/display/msm/dsi-phy-14nm.yaml         |   1 +
+ .../devicetree/bindings/display/msm/mdp5.txt       |  30 +-
+ .../bindings/display/msm/mdss-common.yaml          |  83 ++++
+ .../devicetree/bindings/display/msm/qcom,mdss.yaml | 196 ++++++++++
+ .../bindings/display/msm/qcom,msm8998-dpu.yaml     |  95 +++++
+ .../bindings/display/msm/qcom,msm8998-mdss.yaml    | 268 +++++++++++++
+ .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  84 ++++
+ .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 198 ++++++++++
+ .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  95 +++++
+ .../bindings/display/msm/qcom,sc7180-mdss.yaml     | 304 +++++++++++++++
+ .../bindings/display/msm/qcom,sc7280-dpu.yaml      |  98 +++++
+ .../bindings/display/msm/qcom,sc7280-mdss.yaml     | 422 ++++++++++++++++=
+++++
+ .../bindings/display/msm/qcom,sdm845-dpu.yaml      |  90 +++++
+ .../bindings/display/msm/qcom,sdm845-mdss.yaml     | 270 +++++++++++++
+ .../bindings/display/msm/qcom,sm8250-dpu.yaml      |  92 +++++
+ .../bindings/display/msm/qcom,sm8250-mdss.yaml     | 330 ++++++++++++++++
+ drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   2 +-
+ drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |   2 +-
+ drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   2 +-
+ drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  12 +-
+ drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  33 +-
+ drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  29 +-
+ drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   9 +-
+ drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |  24 +-
+ drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  17 +-
+ drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  11 +-
+ drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  18 +-
+ drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   2 +
+ drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |  19 +-
+ drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |  32 +-
+ drivers/gpu/drm/msm/dp/dp_display.c                |  12 +-
+ drivers/gpu/drm/msm/dp/dp_link.c                   |  21 +-
+ drivers/gpu/drm/msm/dsi/dsi.c                      |   7 +-
+ drivers/gpu/drm/msm/dsi/dsi_host.c                 | 121 ++----
+ drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +
+ drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
+ drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |  17 +
+ drivers/gpu/drm/msm/hdmi/hdmi.c                    | 349 ++++++++---------
+ drivers/gpu/drm/msm/hdmi/hdmi.h                    |   3 -
+ drivers/gpu/drm/msm/msm_drv.c                      |  28 +-
+ drivers/gpu/drm/msm/msm_iommu.c                    |  20 +-
+ drivers/gpu/drm/msm/msm_mdss.c                     |  80 +++-
+ drivers/gpu/drm/msm/msm_mmu.h                      |   3 +-
+ include/uapi/drm/msm_drm.h                         |   1 +
+ 51 files changed, 3121 insertions(+), 1603 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-comm=
on.yaml
+ delete mode 100644 Documentation/devicetree/bindings/display/msm/dpu-msm8=
998.yaml
+ delete mode 100644 Documentation/devicetree/bindings/display/msm/dpu-qcm2=
290.yaml
+ delete mode 100644 Documentation/devicetree/bindings/display/msm/dpu-sc71=
80.yaml
+ delete mode 100644 Documentation/devicetree/bindings/display/msm/dpu-sc72=
80.yaml
+ delete mode 100644 Documentation/devicetree/bindings/display/msm/dpu-sdm8=
45.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/mdss-com=
mon.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,mds=
s.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,msm=
8998-dpu.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,msm=
8998-mdss.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,qcm=
2290-dpu.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,qcm=
2290-mdss.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc7=
180-dpu.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc7=
180-mdss.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc7=
280-dpu.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc7=
280-mdss.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sdm=
845-dpu.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sdm=
845-mdss.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8=
250-dpu.yaml
+ create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8=
250-mdss.yaml
+Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove re=
dundant color encoding and range initialisation)
+$ git merge -m Merge branch 'imx-drm/next' of https://git.pengutronix.de/g=
it/pza/linux imx-drm/imx-drm/next
+Already up to date.
+Merging etnaviv/etnaviv/next (4bce24427251 drm/etnaviv: disable tx clock g=
ating for GC7000 rev6203)
+$ git merge -m Merge branch 'etnaviv/next' of https://git.pengutronix.de/g=
it/lst/linux etnaviv/etnaviv/next
+Merge made by the 'ort' strategy.
+ drivers/gpu/drm/etnaviv/etnaviv_dump.c       |  7 +++-
+ drivers/gpu/drm/etnaviv/etnaviv_gem.c        |  8 +++-
+ drivers/gpu/drm/etnaviv/etnaviv_gem.h        |  1 +
+ drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  6 +++
+ drivers/gpu/drm/etnaviv/etnaviv_gpu.c        | 58 ++++++++++++++++++++---=
-----
+ drivers/gpu/drm/etnaviv/etnaviv_gpu.h        | 23 ++++++++++-
+ drivers/gpu/drm/etnaviv/etnaviv_mmu.c        | 27 ++++++++-----
+ drivers/gpu/drm/etnaviv/etnaviv_mmu.h        |  1 +
+ drivers/gpu/drm/etnaviv/etnaviv_sched.c      |  2 +-
+ 9 files changed, 101 insertions(+), 32 deletions(-)
+Merging fbdev/for-next (d12d0c967945 fbdev: pxafb: Remove unnecessary prin=
t function dev_err())
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/deller/linux-fbdev.git fbdev/for-next
+Auto-merging drivers/video/fbdev/Kconfig
+Merge made by the 'ort' strategy.
+ drivers/video/fbdev/Kconfig                        |   1 -
+ .../omap2/omapfb/displays/connector-analog-tv.c    |  60 ++---------
+ .../fbdev/omap2/omapfb/displays/connector-hdmi.c   |  49 +++------
+ .../fbdev/omap2/omapfb/displays/encoder-opa362.c   |   4 +-
+ .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   |  67 ++++--------
+ .../video/fbdev/omap2/omapfb/displays/panel-dpi.c  |  83 ++-------------
+ .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     | 116 ++++++++--------=
-----
+ .../omapfb/displays/panel-lgphilips-lb035q02.c     |  21 +---
+ .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   |  72 ++++---------
+ .../omapfb/displays/panel-sharp-ls037v7dw01.c      |   3 +-
+ .../omap2/omapfb/displays/panel-sony-acx565akm.c   | 105 ++++++----------=
---
+ .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |   1 -
+ .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  59 +++--------
+ drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c  |   2 -
+ drivers/video/fbdev/pxafb.c                        |   1 -
+ drivers/video/fbdev/ssd1307fb.c                    |  12 +--
+ include/video/omap-panel-data.h                    |  71 -------------
+ 17 files changed, 174 insertions(+), 553 deletions(-)
+ delete mode 100644 include/video/omap-panel-data.h
+Merging regmap/for-next (7c7aa42243cb Merge branch 'regmap-linus' into reg=
map-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/broonie/regmap.git regmap/for-next
+Merge made by the 'ort' strategy.
+Merging sound/for-next (d59b6f215aa8 ALSA: cs5535audio: Remove the redunda=
nt assignment)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/tiwai/sound.git sound/for-next
+Auto-merging sound/soc/intel/skylake/skl.c
+Merge made by the 'ort' strategy.
+ include/sound/hdaudio.h                 |  26 ++++
+ include/sound/hdaudio_ext.h             |  66 +++--------
+ sound/core/rawmidi.c                    |   2 -
+ sound/hda/ext/hdac_ext_controller.c     | 116 ++++++++++--------
+ sound/hda/ext/hdac_ext_stream.c         | 203 ++++-----------------------=
-----
+ sound/hda/hdac_stream.c                 | 136 +++++++++++++++++++++
+ sound/pci/asihpi/asihpi.c               |   2 -
+ sound/pci/cs5535audio/cs5535audio_pcm.c |   4 +-
+ sound/soc/codecs/hda.c                  |   4 +-
+ sound/soc/codecs/hdac_hda.c             |   6 +-
+ sound/soc/codecs/hdac_hdmi.c            |   8 +-
+ sound/soc/intel/avs/core.c              |   2 +-
+ sound/soc/intel/avs/loader.c            |  16 +--
+ sound/soc/intel/avs/pcm.c               |  16 +--
+ sound/soc/intel/skylake/skl-messages.c  |   6 +-
+ sound/soc/intel/skylake/skl-pcm.c       |  35 +++---
+ sound/soc/intel/skylake/skl.c           |   2 +-
+ sound/soc/sof/intel/hda-dai.c           |  42 +++----
+ sound/soc/sof/intel/hda-pcm.c           |   3 +-
+ sound/soc/sof/intel/hda-stream.c        |  16 +--
+ sound/soc/sof/intel/hda.c               |   2 +-
+ 21 files changed, 344 insertions(+), 369 deletions(-)
+Merging sound-asoc/for-next (23faebde20e3 Merge remote-tracking branch 'as=
oc/for-6.2' into asoc-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/broonie/sound.git sound-asoc/for-next
+Auto-merging sound/soc/intel/skylake/skl.c
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/sound/dmic-codec.yaml      |  55 +++
+ Documentation/devicetree/bindings/sound/dmic.txt   |  22 -
+ .../devicetree/bindings/sound/fsl,micfil.yaml      |   1 +
+ .../devicetree/bindings/sound/fsl,rpmsg.yaml       |  36 +-
+ .../devicetree/bindings/sound/fsl,sai.yaml         |   1 +
+ .../devicetree/bindings/sound/ingenic,aic.yaml     |  10 +-
+ .../sound/mt8186-mt6366-rt1019-rt5682s.yaml        |  14 +-
+ .../sound/mt8192-mt6359-rt1015-rt5682.yaml         |   3 +-
+ .../devicetree/bindings/sound/mvebu-audio.txt      |  14 +-
+ .../devicetree/bindings/sound/realtek,rt5682s.yaml |   3 +
+ Documentation/devicetree/bindings/sound/rt5682.txt |   2 +-
+ .../devicetree/bindings/sound/wlf,wm8961.yaml      |  40 ++
+ arch/arm/mach-omap2/board-n8x0.c                   |   5 -
+ arch/arm/mach-omap2/common-board-devices.h         |   2 -
+ arch/arm/mach-omap2/pdata-quirks.c                 |   1 -
+ ...chip_offset_byte.h =3D> acp63_chip_offset_byte.h} | 216 ++++++++-
+ include/sound/hdaudio.h                            |   1 +
+ include/sound/hdaudio_ext.h                        |   5 +
+ include/sound/soc-dapm.h                           | 188 ++++----
+ include/sound/soc-dpcm.h                           |   2 -
+ include/sound/sof.h                                |  10 +-
+ include/sound/sof/ipc4/header.h                    |   4 +
+ include/sound/tlv320aic3x.h                        |  65 ---
+ include/uapi/sound/snd_ar_tokens.h                 |  27 ++
+ sound/hda/hdac_stream.c                            |  22 +
+ sound/soc/amd/Kconfig                              |   4 +-
+ sound/soc/amd/acp/acp-i2s.c                        |  16 +-
+ sound/soc/amd/acp/acp-mach-common.c                |  62 ++-
+ sound/soc/amd/ps/{acp62.h =3D> acp63.h}              |  10 +-
+ sound/soc/amd/ps/pci-ps.c                          | 132 +++---
+ sound/soc/amd/ps/ps-mach.c                         |  30 +-
+ sound/soc/amd/ps/ps-pdm-dma.c                      | 188 ++++----
+ sound/soc/codecs/Kconfig                           |   2 +-
+ sound/soc/codecs/ak4458.c                          |  13 +-
+ sound/soc/codecs/cs35l36.c                         |   4 +-
+ sound/soc/codecs/cs42l83-i2c.c                     |   2 +-
+ sound/soc/codecs/cs42xx8-i2c.c                     |  28 +-
+ sound/soc/codecs/cs42xx8.c                         |  22 +-
+ sound/soc/codecs/cs42xx8.h                         |   3 +-
+ sound/soc/codecs/hda.c                             |   8 +-
+ sound/soc/codecs/jz4725b.c                         |  81 +++-
+ sound/soc/codecs/rt298.c                           |   7 +
+ sound/soc/codecs/simple-mux.c                      |   9 +
+ sound/soc/codecs/tlv320aic3x.c                     | 120 ++---
+ sound/soc/codecs/tlv320aic3x.h                     |  43 ++
+ sound/soc/codecs/twl4030.c                         |   6 +-
+ sound/soc/codecs/wm8961.c                          |   7 +
+ sound/soc/codecs/wm8978.c                          |   2 +-
+ sound/soc/fsl/fsl_micfil.c                         | 447 ++++++++++++++++=
+++
+ sound/soc/fsl/fsl_micfil.h                         |   6 +-
+ sound/soc/fsl/fsl_rpmsg.c                          |   6 +-
+ sound/soc/fsl/fsl_sai.c                            |  23 +-
+ sound/soc/fsl/fsl_sai.h                            |   1 +
+ sound/soc/fsl/fsl_xcvr.c                           |  40 ++
+ sound/soc/fsl/fsl_xcvr.h                           |  21 +
+ sound/soc/fsl/imx-audio-rpmsg.c                    |   3 +-
+ sound/soc/fsl/imx-pcm-rpmsg.c                      |  10 +-
+ sound/soc/fsl/imx-rpmsg.c                          |   6 +-
+ sound/soc/intel/avs/apl.c                          |   6 +-
+ sound/soc/intel/avs/avs.h                          |  12 +-
+ sound/soc/intel/avs/board_selection.c              |  14 +
+ sound/soc/intel/avs/boards/Kconfig                 |  10 +
+ sound/soc/intel/avs/boards/Makefile                |   2 +
+ sound/soc/intel/avs/boards/da7219.c                |   6 +-
+ sound/soc/intel/avs/boards/hdaudio.c               |   1 +
+ sound/soc/intel/avs/boards/max98373.c              |   2 +-
+ sound/soc/intel/avs/boards/max98927.c              | 236 ++++++++++
+ sound/soc/intel/avs/boards/rt298.c                 |  24 +-
+ sound/soc/intel/avs/boards/ssm4567.c               |   2 +-
+ sound/soc/intel/avs/core.c                         | 114 +++--
+ sound/soc/intel/avs/ipc.c                          |   5 +-
+ sound/soc/intel/avs/loader.c                       |  12 +-
+ sound/soc/intel/avs/messages.c                     |  19 +-
+ sound/soc/intel/avs/messages.h                     |   2 +
+ sound/soc/intel/avs/pcm.c                          | 374 ++++++++++++++--
+ sound/soc/intel/avs/skl.c                          |   4 +-
+ sound/soc/intel/avs/topology.c                     |  10 +
+ sound/soc/intel/boards/bdw-rt5650.c                |   2 +-
+ sound/soc/intel/boards/bdw-rt5677.c                |   2 +-
+ sound/soc/intel/boards/bxt_rt298.c                 |   2 +-
+ sound/soc/intel/boards/bytcht_cx2072x.c            |   2 +-
+ sound/soc/intel/boards/bytcht_es8316.c             |   2 +-
+ sound/soc/intel/boards/bytcr_rt5640.c              |   2 +-
+ sound/soc/intel/boards/bytcr_rt5651.c              |   2 +-
+ sound/soc/intel/boards/bytcr_wm5102.c              |   2 +-
+ sound/soc/intel/boards/cht_bsw_max98090_ti.c       |   2 +-
+ sound/soc/intel/boards/cht_bsw_nau8824.c           |   2 +-
+ sound/soc/intel/boards/cht_bsw_rt5645.c            |   2 +-
+ sound/soc/intel/boards/cht_bsw_rt5672.c            |   2 +-
+ sound/soc/intel/boards/skl_nau88l25_max98357a.c    |   2 +-
+ sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |   2 +-
+ sound/soc/intel/boards/sof_cirrus_common.c         |   2 +-
+ sound/soc/intel/skylake/skl.c                      |   9 -
+ sound/soc/jz4740/Kconfig                           |   1 +
+ sound/soc/jz4740/jz4740-i2s.c                      | 485 ++++++++++------=
-----
+ sound/soc/jz4740/jz4740-i2s.h                      |  10 -
+ sound/soc/kirkwood/kirkwood-i2s.c                  | 135 +++++-
+ sound/soc/kirkwood/kirkwood.h                      |   2 +
+ .../mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c | 102 ++++-
+ sound/soc/meson/axg-pdm.c                          |   2 +-
+ sound/soc/qcom/qdsp6/audioreach.c                  | 310 +++++++++----
+ sound/soc/qcom/qdsp6/audioreach.h                  |  47 +-
+ sound/soc/qcom/qdsp6/q6apm.c                       |  84 +---
+ sound/soc/qcom/qdsp6/q6apm.h                       |   6 +-
+ sound/soc/qcom/qdsp6/topology.c                    | 243 +++++++++--
+ sound/soc/sh/rcar/core.c                           |   7 +-
+ sound/soc/soc-dapm.c                               | 189 ++++----
+ sound/soc/soc-pcm.c                                |  12 +-
+ sound/soc/sof/Kconfig                              |  18 +-
+ sound/soc/sof/Makefile                             |   6 +
+ sound/soc/sof/amd/acp-loader.c                     |   6 +-
+ sound/soc/sof/intel/Kconfig                        |   2 +-
+ sound/soc/sof/intel/Makefile                       |   2 +-
+ sound/soc/sof/intel/apl.c                          |   3 +
+ sound/soc/sof/intel/bdw.c                          |   6 +-
+ sound/soc/sof/intel/byt.c                          |  12 +-
+ sound/soc/sof/intel/cnl.c                          |  29 +-
+ sound/soc/sof/intel/hda-bus.c                      |  23 +-
+ sound/soc/sof/intel/hda-codec.c                    | 252 +++++++++--
+ sound/soc/sof/intel/hda-common-ops.c               |   6 +-
+ sound/soc/sof/intel/hda-ctrl.c                     | 102 +----
+ sound/soc/sof/intel/hda-dai.c                      |  41 +-
+ sound/soc/sof/intel/hda-dsp.c                      |  70 +--
+ sound/soc/sof/intel/hda-ipc.c                      |  27 +-
+ sound/soc/sof/intel/hda-loader-skl.c               |  37 +-
+ sound/soc/sof/intel/hda-loader.c                   |  87 +++-
+ sound/soc/sof/intel/hda-mlink.c                    |  89 ++++
+ sound/soc/sof/intel/hda-stream.c                   |  77 ++--
+ sound/soc/sof/intel/hda.c                          |  78 ++--
+ sound/soc/sof/intel/hda.h                          | 101 ++++-
+ sound/soc/sof/intel/icl.c                          |   3 +
+ sound/soc/sof/intel/mtl.c                          |  31 +-
+ sound/soc/sof/intel/pci-apl.c                      |   6 +
+ sound/soc/sof/intel/pci-cnl.c                      |   9 +
+ sound/soc/sof/intel/pci-icl.c                      |   6 +
+ sound/soc/sof/intel/pci-mtl.c                      |   3 +
+ sound/soc/sof/intel/pci-tgl.c                      |  24 +
+ sound/soc/sof/intel/pci-tng.c                      |   6 +-
+ sound/soc/sof/intel/tgl.c                          |   3 +
+ sound/soc/sof/ipc.c                                |  14 +
+ sound/soc/sof/ipc3-loader.c                        |  26 +-
+ sound/soc/sof/ipc3.c                               |   4 +-
+ sound/soc/sof/ipc4-loader.c                        | 233 +++++++++-
+ sound/soc/sof/ipc4-priv.h                          |  65 ++-
+ sound/soc/sof/ipc4-topology.c                      |  17 +-
+ sound/soc/sof/ipc4.c                               |  45 +-
+ sound/soc/sof/loader.c                             |  25 +-
+ sound/soc/sof/ops.h                                |  51 ++-
+ sound/soc/sof/sof-audio.c                          |   5 +
+ sound/soc/sof/sof-client-probes-ipc3.c             | 236 ++++++++++
+ sound/soc/sof/sof-client-probes-ipc4.c             | 281 ++++++++++++
+ sound/soc/sof/sof-client-probes.c                  | 268 ++----------
+ sound/soc/sof/sof-client-probes.h                  |  34 ++
+ sound/soc/sof/sof-client.c                         |  34 ++
+ sound/soc/sof/sof-client.h                         |   6 +
+ sound/soc/sof/sof-pci-dev.c                        |  26 ++
+ sound/soc/sof/sof-priv.h                           |  36 +-
+ sound/soc/sunxi/sun50i-dmic.c                      |   2 +-
+ sound/soc/ti/davinci-mcasp.c                       |   7 +-
+ 159 files changed, 5201 insertions(+), 2019 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/sound/dmic-codec.yaml
+ delete mode 100644 Documentation/devicetree/bindings/sound/dmic.txt
+ create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8961.yaml
+ rename include/sound/{acp62_chip_offset_byte.h =3D> acp63_chip_offset_byt=
e.h} (65%)
+ delete mode 100644 include/sound/tlv320aic3x.h
+ rename sound/soc/amd/ps/{acp62.h =3D> acp63.h} (90%)
+ create mode 100644 sound/soc/intel/avs/boards/max98927.c
+ delete mode 100644 sound/soc/jz4740/jz4740-i2s.h
+ create mode 100644 sound/soc/sof/intel/hda-mlink.c
+ create mode 100644 sound/soc/sof/sof-client-probes-ipc3.c
+ create mode 100644 sound/soc/sof/sof-client-probes-ipc4.c
+Merging modules/modules-next (dd0338eef0d4 kernel/params.c: defer most of =
param_sysfs_init() to late_initcall time)
+$ git merge -m Merge branch 'modules-next' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mcgrof/linux.git modules/modules-next
+Auto-merging include/linux/module.h
+Auto-merging kernel/module/main.c
+Merge made by the 'ort' strategy.
+ include/linux/module.h |  1 -
+ kernel/module/main.c   |  3 ---
+ kernel/module/sysfs.c  |  2 +-
+ kernel/params.c        | 23 +++++++++++++++++++----
+ 4 files changed, 20 insertions(+), 9 deletions(-)
+Merging input/next (60f07c29e035 Input: Use kstrtobool() instead of strtob=
ool())
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/dtor/input.git input/next
+Auto-merging Documentation/devicetree/bindings/vendor-prefixes.yaml
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ .../input/allwinner,sun4i-a10-lradc-keys.yaml      |   4 +-
+ .../devicetree/bindings/input/azoteq,iqs7222.yaml  |  25 +-
+ .../bindings/input/qcom,pm8921-pwrkey.yaml         |  75 ++
+ .../bindings/input/qcom,pm8xxx-pwrkey.txt          |  46 --
+ .../input/touchscreen/cypress,tt21000.yaml         | 106 +++
+ .../bindings/input/touchscreen/egalax-ts.txt       |   4 +-
+ .../bindings/input/touchscreen/himax,hx83112b.yaml |  63 ++
+ .../input/touchscreen/hynitron,cstxxx.yaml         |  65 ++
+ .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
+ MAINTAINERS                                        |   7 +
+ arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   4 +-
+ arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   8 +-
+ arch/arm/mach-s3c/mach-crag6410.c                  |   1 +
+ drivers/iio/adc/twl4030-madc.c                     |   1 +
+ drivers/input/input.c                              |   3 +-
+ drivers/input/joystick/Kconfig                     |   1 +
+ drivers/input/keyboard/dlink-dir685-touchkeys.c    |   4 +-
+ drivers/input/keyboard/matrix_keypad.c             |   3 +
+ drivers/input/keyboard/stmpe-keypad.c              |   1 +
+ drivers/input/misc/Kconfig                         |   2 +-
+ drivers/input/misc/atmel_captouch.c                |   4 +-
+ drivers/input/misc/iqs7222.c                       | 504 +++++++-----
+ drivers/input/touchscreen/Kconfig                  |  40 +
+ drivers/input/touchscreen/Makefile                 |   3 +
+ drivers/input/touchscreen/cyttsp5.c                | 901 ++++++++++++++++=
+++++
+ drivers/input/touchscreen/egalax_ts.c              |  49 +-
+ drivers/input/touchscreen/himax_hx83112b.c         | 365 +++++++++
+ drivers/input/touchscreen/hynitron_cstxxx.c        | 498 ++++++++++++
+ drivers/input/touchscreen/tps6507x-ts.c            |   2 -
+ 29 files changed, 2480 insertions(+), 311 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8921-pw=
rkey.yaml
+ delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-pw=
rkey.txt
+ create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cy=
press,tt21000.yaml
+ create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hi=
max,hx83112b.yaml
+ create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hy=
nitron,cstxxx.yaml
+ create mode 100644 drivers/input/touchscreen/cyttsp5.c
+ create mode 100644 drivers/input/touchscreen/himax_hx83112b.c
+ create mode 100644 drivers/input/touchscreen/hynitron_cstxxx.c
+Merging block/for-next (72cc2f803da1 Merge branch 'for-6.2/io_uring' into =
for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.dk/linux-block.=
git block/for-next
+Auto-merging block/blk-mq.c
+Auto-merging block/genhd.c
+Merge made by the 'ort' strategy.
+ block/bfq-cgroup.c            |  12 ++-
+ block/bfq-iosched.c           |  89 +++---------------
+ block/bfq-iosched.h           |  32 +++----
+ block/bfq-wf2q.c              | 157 +++++++++++++++----------------
+ block/blk-core.c              |  39 +-------
+ block/blk-iocost.c            |  41 ++++++--
+ block/blk-iolatency.c         |  37 ++++----
+ block/blk-map.c               |   2 +-
+ block/blk-merge.c             |  44 +++++----
+ block/blk-mq-sched.c          |   8 +-
+ block/blk-mq.c                | 207 +++++++++++++++++++++++++++----------=
---
+ block/blk-mq.h                |  14 +--
+ block/blk-settings.c          |   6 +-
+ block/blk-sysfs.c             |  12 +--
+ block/blk-wbt.c               |  26 +++++-
+ block/blk-wbt.h               |  17 +++-
+ block/blk.h                   |  21 ++---
+ block/bsg-lib.c               |   2 +
+ block/elevator.c              | 213 +++++++++++++++++--------------------=
-----
+ block/elevator.h              |  20 +++-
+ block/genhd.c                 |  11 ++-
+ drivers/block/xen-blkfront.c  |   1 -
+ drivers/nvme/host/apple.c     |  10 +-
+ drivers/nvme/host/core.c      |  98 ++++++-------------
+ drivers/nvme/host/nvme.h      |   5 +-
+ drivers/nvme/host/pci.c       |  52 ++++++-----
+ drivers/scsi/scsi_lib.c       |   2 +-
+ drivers/scsi/scsi_scan.c      |   1 -
+ drivers/ufs/core/ufshcd.c     |   2 +
+ include/linux/blk-mq.h        |   9 +-
+ include/linux/blkdev.h        |  20 +---
+ include/uapi/linux/io_uring.h |  18 ++++
+ io_uring/io_uring.c           |  21 +----
+ io_uring/io_uring.h           |   6 +-
+ io_uring/msg_ring.c           |   4 +-
+ io_uring/net.c                |  56 ++++++-----
+ io_uring/notif.c              |  57 ++++++-----
+ io_uring/notif.h              |  15 ++-
+ io_uring/poll.c               |  13 +--
+ io_uring/rsrc.c               |  11 ++-
+ io_uring/rw.c                 |   6 ++
+ 41 files changed, 715 insertions(+), 702 deletions(-)
+Merging device-mapper/for-next (5434ee8d2857 dm clone: Fix typo in block_d=
evice format specifier)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/device-mapper/linux-dm.git device-mapper/for-next
+Already up to date.
+Merging libata/for-next (de58fd3d80f8 ata: sata_dwc_460ex: remove variable=
 num_processed)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/dlemoal/libata.git libata/for-next
+Merge made by the 'ort' strategy.
+ drivers/ata/Kconfig           |  13 +-
+ drivers/ata/Makefile          |   1 -
+ drivers/ata/libahci.c         |  20 ++-
+ drivers/ata/libata-acpi.c     |   4 +-
+ drivers/ata/libata-core.c     |   7 +-
+ drivers/ata/libata-eh.c       |  39 +++--
+ drivers/ata/libata-sata.c     |  23 ++-
+ drivers/ata/libata-scsi.c     |  18 +-
+ drivers/ata/libata.h          |   1 +
+ drivers/ata/pata_bk3710.c     | 380 -------------------------------------=
-----
+ drivers/ata/pata_ftide010.c   |   2 +-
+ drivers/ata/pata_mpc52xx.c    |   2 +-
+ drivers/ata/sata_dwc_460ex.c  |   4 +-
+ drivers/ata/sata_gemini.c     |   2 +-
+ drivers/ata/sata_nv.c         |   2 +-
+ drivers/ata/sata_promise.c    |   2 +-
+ drivers/ata/sata_sx4.c        |   2 +-
+ drivers/scsi/libsas/sas_ata.c |   2 +-
+ include/linux/ata.h           |  31 ----
+ include/linux/libata.h        |   5 +
+ include/scsi/scsi_proto.h     |   4 +-
+ 21 files changed, 95 insertions(+), 469 deletions(-)
+ delete mode 100644 drivers/ata/pata_bk3710.c
+Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact=
 Flash driver)
+$ git merge -m Merge branch 'pcmcia-next' of git://git.kernel.org/pub/scm/=
linux/kernel/git/brodo/linux.git pcmcia/pcmcia-next
+Already up to date.
+Merging mmc/next (c615212f9e8f mmc: wmt-sdmmc: fix return value check of m=
mc_add_host())
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/ulfh/mmc.git mmc/next
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/mmc/arm,pl18x.yaml         |   4 +-
+ .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   3 +-
+ Documentation/devicetree/bindings/mmc/mtk-sd.yaml  | 171 ++++++++++++++++=
+----
+ .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   1 +
+ .../devicetree/bindings/mmc/sdhci-am654.yaml       |   6 +
+ .../devicetree/bindings/mmc/sdhci-msm.yaml         |   1 +
+ drivers/mmc/core/core.c                            |  12 +-
+ drivers/mmc/core/host.c                            |   2 +-
+ drivers/mmc/core/mmc_test.c                        |   5 -
+ drivers/mmc/host/Kconfig                           |   4 +-
+ drivers/mmc/host/alcor.c                           |   5 +-
+ drivers/mmc/host/au1xmmc.c                         |   8 +-
+ drivers/mmc/host/bcm2835.c                         |  12 +-
+ drivers/mmc/host/dw_mmc.c                          |   2 +-
+ drivers/mmc/host/moxart-mmc.c                      |   4 +-
+ drivers/mmc/host/mtk-sd.c                          |  26 ++++
+ drivers/mmc/host/mxcmmc.c                          |   4 +-
+ drivers/mmc/host/pxamci.c                          |   7 +-
+ drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   5 +-
+ drivers/mmc/host/rtsx_pci_sdmmc.c                  |   9 +-
+ drivers/mmc/host/rtsx_usb_sdmmc.c                  |  11 +-
+ drivers/mmc/host/sdhci-acpi.c                      |   4 +-
+ drivers/mmc/host/sdhci-bcm-kona.c                  |   2 +-
+ drivers/mmc/host/sdhci-esdhc-imx.c                 |  87 ++++++-----
+ drivers/mmc/host/sdhci-msm.c                       |  10 +-
+ drivers/mmc/host/sdhci-of-arasan.c                 |  69 +++++++++
+ drivers/mmc/host/sdhci-omap.c                      |   2 +-
+ drivers/mmc/host/sdhci-pci-core.c                  |  14 +-
+ drivers/mmc/host/sdhci-pci-gli.c                   |  11 +-
+ drivers/mmc/host/sdhci-pci-o2micro.c               |   7 +
+ drivers/mmc/host/sdhci.c                           |  30 +---
+ drivers/mmc/host/sdhci.h                           |   2 +-
+ drivers/mmc/host/sdhci_am654.c                     |   2 +-
+ drivers/mmc/host/tifm_sd.c                         |  28 ++--
+ drivers/mmc/host/tmio_mmc.h                        |  11 +-
+ drivers/mmc/host/tmio_mmc_core.c                   |  10 +-
+ drivers/mmc/host/toshsd.c                          |   6 +-
+ drivers/mmc/host/vub300.c                          |  11 +-
+ drivers/mmc/host/wbsd.c                            |  10 +-
+ drivers/mmc/host/wmt-sdmmc.c                       |   6 +-
+ 40 files changed, 421 insertions(+), 203 deletions(-)
+Merging mfd/for-mfd-next (2c9918463543 mfd: tc6393xb: Remove #ifdef guards=
 for PM related functions)
+$ git merge -m Merge branch 'for-mfd-next' of git://git.kernel.org/pub/scm=
/linux/kernel/git/lee/mfd.git mfd/for-mfd-next
+Auto-merging Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+Auto-merging drivers/input/misc/Kconfig
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/mfd/ampere,smpro.yaml      |  42 ++
+ .../devicetree/bindings/mfd/brcm,twd.yaml          |   8 +
+ .../devicetree/bindings/mfd/mscc,ocelot.yaml       |   4 +-
+ Documentation/devicetree/bindings/mfd/mt6397.txt   |   1 +
+ .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  14 +-
+ .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   2 +
+ .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |  33 +-
+ Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
+ .../devicetree/bindings/mfd/ti,am3359-tscadc.yaml  |   3 +
+ .../bindings/mfd/ti,j721e-system-controller.yaml   |   2 +
+ .../bindings/timer/brcm,bcmbca-timer.yaml          |  40 ++
+ drivers/input/misc/Kconfig                         |  11 -
+ drivers/input/misc/Makefile                        |   1 -
+ drivers/input/misc/dm355evm_keys.c                 | 238 --------
+ drivers/mfd/88pm800.c                              |   2 +-
+ drivers/mfd/88pm805.c                              |   2 +-
+ drivers/mfd/88pm80x.c                              |   5 +-
+ drivers/mfd/88pm860x-core.c                        |   6 +-
+ drivers/mfd/Kconfig                                |  38 +-
+ drivers/mfd/Makefile                               |   5 +-
+ drivers/mfd/aat2870-core.c                         |   8 +-
+ drivers/mfd/adp5520.c                              |   6 +-
+ drivers/mfd/arizona-core.c                         |  19 +-
+ drivers/mfd/arizona-i2c.c                          |   2 +-
+ drivers/mfd/arizona-spi.c                          |   2 +-
+ drivers/mfd/axp20x.c                               |   2 +-
+ drivers/mfd/davinci_voicecodec.c                   | 136 -----
+ drivers/mfd/dm355evm_msp.c                         | 454 ---------------
+ drivers/mfd/htc-i2cpld.c                           | 627 ----------------=
-----
+ drivers/mfd/madera-core.c                          |   3 +-
+ drivers/mfd/max14577.c                             |   6 +-
+ drivers/mfd/max77620.c                             |   9 +-
+ drivers/mfd/max77686.c                             |   6 +-
+ drivers/mfd/max8925-i2c.c                          |   7 +-
+ drivers/mfd/mc13xxx-i2c.c                          |   1 -
+ drivers/mfd/mc13xxx-spi.c                          |   3 +-
+ drivers/mfd/mcp-sa11x0.c                           |   6 +-
+ drivers/mfd/motorola-cpcap.c                       |   6 +-
+ drivers/mfd/mt6360-core.c                          |  14 +-
+ drivers/mfd/mt6397-irq.c                           |   6 +-
+ drivers/mfd/pcf50633-core.c                        |  22 +-
+ drivers/mfd/pcf50633-irq.c                         |  13 +-
+ drivers/mfd/qcom-pm8xxx.c                          |   1 -
+ drivers/mfd/rc5t583-irq.c                          |   7 +-
+ drivers/mfd/rk808.c                                |  26 +-
+ drivers/mfd/sec-core.c                             |   7 +-
+ drivers/mfd/sm501.c                                |  10 +-
+ drivers/mfd/smpro-core.c                           | 138 +++++
+ drivers/mfd/sprd-sc27xx-spi.c                      |   7 +-
+ drivers/mfd/stmfx.c                                |   6 +-
+ drivers/mfd/stmpe-i2c.c                            |   4 +-
+ drivers/mfd/stmpe-spi.c                            |   4 +-
+ drivers/mfd/stmpe.c                                |   8 +-
+ drivers/mfd/stpmic1.c                              |   6 +-
+ drivers/mfd/t7l66xb.c                              |   9 +-
+ drivers/mfd/tc3589x.c                              |   7 +-
+ drivers/mfd/tc6387xb.c                             |   9 +-
+ drivers/mfd/tc6393xb.c                             |   9 +-
+ drivers/mfd/tps6586x.c                             |   6 +-
+ drivers/mfd/twl6040.c                              |  29 +-
+ drivers/mfd/ucb1x00-core.c                         |   7 +-
+ drivers/mfd/wm8994-core.c                          |   6 +-
+ drivers/rtc/Kconfig                                |   6 -
+ drivers/rtc/Makefile                               |   1 -
+ drivers/rtc/rtc-dm355evm.c                         | 151 -----
+ include/linux/htcpld.h                             |  23 -
+ include/linux/mfd/dm355evm_msp.h                   |  79 ---
+ include/linux/mfd/palmas.h                         |   1 -
+ include/linux/mfd/pcf50633/core.h                  |   6 +-
+ include/linux/mfd/stmfx.h                          |   2 -
+ include/linux/mfd/twl6040.h                        |  32 +-
+ 71 files changed, 412 insertions(+), 2011 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
+ create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcmbca-ti=
mer.yaml
+ delete mode 100644 drivers/input/misc/dm355evm_keys.c
+ delete mode 100644 drivers/mfd/davinci_voicecodec.c
+ delete mode 100644 drivers/mfd/dm355evm_msp.c
+ delete mode 100644 drivers/mfd/htc-i2cpld.c
+ create mode 100644 drivers/mfd/smpro-core.c
+ delete mode 100644 drivers/rtc/rtc-dm355evm.c
+ delete mode 100644 include/linux/htcpld.h
+ delete mode 100644 include/linux/mfd/dm355evm_msp.h
+Merging backlight/for-backlight-next (e7647de058cb video: backlight: mt637=
0: Add MediaTek MT6370 support)
+$ git merge -m Merge branch 'for-backlight-next' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/lee/backlight.git backlight/for-backlight-next
+Already up to date.
+Merging battery/for-next (09b327c991d2 dt-bindings: power: supply: bq25890=
: use one fallback compatible)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/sre/linux-power-supply.git battery/for-next
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/mfd/ene-kb930.yaml         |   6 +-
+ .../devicetree/bindings/mfd/rockchip,rk817.yaml    |   2 +
+ .../bindings/power/reset/gpio-restart.yaml         |  13 +-
+ .../bindings/power/reset/restart-handler.yaml      |  30 +++
+ .../devicetree/bindings/power/supply/bq25890.yaml  |  16 +-
+ .../devicetree/bindings/power/supply/bq27xxx.yaml  |   2 -
+ .../bindings/power/supply/ingenic,battery.yaml     |   4 +-
+ .../bindings/power/supply/maxim,max17042.yaml      |   2 +
+ .../bindings/power/supply/power-supply.yaml        |   6 +
+ .../bindings/power/supply/rohm,bd99954.yaml        |   1 +
+ .../bindings/power/supply/sc2731-charger.yaml      |   1 -
+ drivers/power/supply/ab8500_charger.c              |   2 +-
+ drivers/power/supply/bd99954-charger.c             |  84 ++------
+ drivers/power/supply/bq25890_charger.c             | 227 ++++++++++++++++=
-----
+ drivers/power/supply/lp8788-charger.c              |   2 +-
+ drivers/power/supply/mt6360_charger.c              |  15 +-
+ drivers/power/supply/power_supply_core.c           |   1 -
+ 17 files changed, 251 insertions(+), 163 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/power/reset/restart-=
handler.yaml
+Merging regulator/for-next (3c952a2a06a2 Merge remote-tracking branch 'reg=
ulator/for-6.2' into regulator-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/broonie/regulator.git regulator/for-next
+Auto-merging Documentation/devicetree/bindings/regulator/qcom,spmi-regulat=
or.yaml
+Auto-merging Documentation/driver-api/driver-model/devres.rst
+Auto-merging MAINTAINERS
+Auto-merging drivers/regulator/core.c
+Merge made by the 'ort' strategy.
+ .../bindings/regulator/regulator-output.yaml       |  39 ++
+ .../bindings/regulator/richtek,rt6190.yaml         |  79 ++++
+ Documentation/driver-api/driver-model/devres.rst   |   1 +
+ drivers/regulator/Kconfig                          |  11 +
+ drivers/regulator/Makefile                         |   1 +
+ drivers/regulator/core.c                           |  42 +-
+ drivers/regulator/devres.c                         |  66 ++-
+ drivers/regulator/internal.h                       |   2 +
+ drivers/regulator/rt6190-regulator.c               | 495 ++++++++++++++++=
+++++
+ drivers/regulator/userspace-consumer.c             |  60 ++-
+ include/linux/regulator/consumer.h                 |   2 +
+ include/linux/regulator/userspace-consumer.h       |   1 +
+ 12 files changed, 756 insertions(+), 43 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/regulator/regulator-=
output.yaml
+ create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt=
6190.yaml
+ create mode 100644 drivers/regulator/rt6190-regulator.c
+Merging security/next (b10b9c342f75 lsm: make security_socket_getpeersec_s=
tream() sockptr_t safe)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/pcmoore/lsm.git security/next
+Auto-merging include/linux/lsm_hook_defs.h
+Auto-merging include/linux/lsm_hooks.h
+Auto-merging include/linux/security.h
+Auto-merging net/core/sock.c
+Auto-merging security/apparmor/lsm.c
+Auto-merging security/security.c
+Auto-merging security/selinux/hooks.c
+Auto-merging security/smack/smack_lsm.c
+Merge made by the 'ort' strategy.
+ include/linux/fs_context.h    |  2 +-
+ include/linux/lsm_hook_defs.h |  2 +-
+ include/linux/lsm_hooks.h     | 17 ++---------------
+ include/linux/security.h      | 11 +++++++----
+ net/core/sock.c               |  3 ++-
+ security/apparmor/lsm.c       | 29 +++++++++++++----------------
+ security/lsm_audit.c          |  1 +
+ security/security.c           |  6 +++---
+ security/selinux/hooks.c      | 13 ++++++-------
+ security/smack/smack_lsm.c    | 19 ++++++++++---------
+ 10 files changed, 46 insertions(+), 57 deletions(-)
+Merging apparmor/apparmor-next (4295c60bbe9e apparmor: Fix uninitialized s=
ymbol 'array_size' in policy_unpack_test.c)
+$ git merge -m Merge branch 'apparmor-next' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/jj/linux-apparmor apparmor/apparmor-next
+Auto-merging security/apparmor/domain.c
+Auto-merging security/apparmor/file.c
+Auto-merging security/apparmor/lsm.c
+Merge made by the 'ort' strategy.
+ security/apparmor/Kconfig                 |   4 +-
+ security/apparmor/Makefile                |   3 +-
+ security/apparmor/apparmorfs.c            | 115 +++---
+ security/apparmor/audit.c                 |  45 ++-
+ security/apparmor/capability.c            |  16 +-
+ security/apparmor/domain.c                | 149 ++++----
+ security/apparmor/file.c                  | 125 ++-----
+ security/apparmor/include/apparmor.h      |  23 +-
+ security/apparmor/include/audit.h         |   8 +-
+ security/apparmor/include/cred.h          |  13 -
+ security/apparmor/include/domain.h        |   6 -
+ security/apparmor/include/file.h          | 108 +-----
+ security/apparmor/include/label.h         |  13 +-
+ security/apparmor/include/lib.h           |  10 +-
+ security/apparmor/include/match.h         |  28 +-
+ security/apparmor/include/net.h           |   1 +
+ security/apparmor/include/perms.h         |  91 ++++-
+ security/apparmor/include/policy.h        | 141 +++++--
+ security/apparmor/include/policy_compat.h |  33 ++
+ security/apparmor/include/policy_unpack.h |   2 +
+ security/apparmor/ipc.c                   |  16 +-
+ security/apparmor/label.c                 |  75 ++--
+ security/apparmor/lib.c                   | 125 ++-----
+ security/apparmor/lsm.c                   |  25 +-
+ security/apparmor/match.c                 |  62 ++--
+ security/apparmor/mount.c                 |  93 +++--
+ security/apparmor/net.c                   |  28 +-
+ security/apparmor/policy.c                | 204 ++++++++--
+ security/apparmor/policy_compat.c         | 319 ++++++++++++++++
+ security/apparmor/policy_ns.c             |   6 +-
+ security/apparmor/policy_unpack.c         | 598 ++++++++++++++++++++-----=
-----
+ security/apparmor/policy_unpack_test.c    |  17 +-
+ security/apparmor/procattr.c              |  11 +-
+ security/apparmor/resource.c              |  29 +-
+ security/apparmor/task.c                  |  14 +-
+ 35 files changed, 1644 insertions(+), 912 deletions(-)
+ create mode 100644 security/apparmor/include/policy_compat.h
+ create mode 100644 security/apparmor/policy_compat.c
+Merging integrity/next-integrity (8c1d6a050a0f ima: Fix memory leak in __i=
ma_inode_hash())
+$ git merge -m Merge branch 'next-integrity' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/zohar/linux-integrity integrity/next-integrity
+Auto-merging security/integrity/ima/ima_policy.c
+Merge made by the 'ort' strategy.
+ Documentation/security/keys/trusted-encrypted.rst |  3 +-
+ security/integrity/ima/ima_main.c                 |  7 +++-
+ security/integrity/ima/ima_policy.c               | 51 ++++++++++++++++--=
-----
+ security/integrity/ima/ima_template.c             |  5 ++-
+ security/integrity/platform_certs/load_uefi.c     |  1 +
+ security/keys/encrypted-keys/encrypted.c          |  6 +--
+ 6 files changed, 51 insertions(+), 22 deletions(-)
+Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/viro/vfs)
+$ git merge -m Merge branch 'keys-next' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/dhowells/linux-fs.git keys/keys-next
+Already up to date.
+Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgrou=
ps() testing to selftest)
+$ git merge -m Merge branch 'safesetid-next' of https://github.com/micah-m=
orton/linux.git safesetid/safesetid-next
+Already up to date.
+Merging selinux/next (e0d8259355cb selinux: increase the deprecation sleep=
 for checkreqprot and runtime disable)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/pcmoore/selinux.git selinux/next
+Merge made by the 'ort' strategy.
+ security/selinux/selinuxfs.c | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+Merging smack/next (1a3065e92046 smack_lsm: remove unnecessary type castin=
g)
+$ git merge -m Merge branch 'next' of git://github.com/cschaufler/smack-ne=
xt smack/next
+Auto-merging security/smack/smack_lsm.c
+Merge made by the 'ort' strategy.
+ security/smack/smack_lsm.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+Merging tomoyo/master (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'master' of https://scm.osdn.net/gitroot/tomoy=
o/tomoyo-test1.git tomoyo/master
+Already up to date.
+Merging tpmdd/next (2d869f0b4585 selftest: tpm2: Add Client.__del__() to c=
lose /dev/tpm* handle)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/jarkko/linux-tpmdd.git tpmdd/next
+Already up to date.
+Merging watchdog/master (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'master' of git://www.linux-watchdog.org/linux=
-watchdog-next.git watchdog/master
+Already up to date.
+Merging iommu/next (7e8eec906b5b Merge branches 'arm/allwinner', 'arm/rock=
chip', 'ppc/pamu', 's390', 'x86/amd' and 'core' into next)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/joro/iommu.git iommu/next
+Auto-merging drivers/dma/idxd/cdev.c
+Auto-merging drivers/dma/idxd/init.c
+Merge made by the 'ort' strategy.
+ arch/s390/include/asm/pci.h                     |   1 +
+ drivers/dma/idxd/cdev.c                         |   3 +-
+ drivers/dma/idxd/init.c                         |  25 +-
+ drivers/iommu/Makefile                          |   2 +-
+ drivers/iommu/amd/iommu.c                       |  15 +-
+ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 104 ++++----
+ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     |  32 +--
+ drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  23 +-
+ drivers/iommu/arm/arm-smmu/arm-smmu.c           |   3 -
+ drivers/iommu/arm/arm-smmu/qcom_iommu.c         |   7 +-
+ drivers/iommu/fsl_pamu.c                        |   6 +-
+ drivers/iommu/fsl_pamu_domain.c                 |   4 +-
+ drivers/iommu/intel/dmar.c                      |   7 +
+ drivers/iommu/intel/iommu.c                     |  40 +++-
+ drivers/iommu/intel/iommu.h                     |  18 +-
+ drivers/iommu/intel/pasid.c                     |   6 +-
+ drivers/iommu/intel/svm.c                       | 145 +++++-------
+ drivers/iommu/io-pgfault.c                      |  77 ++----
+ drivers/iommu/iommu-sva-lib.c                   |  71 ------
+ drivers/iommu/iommu-sva.c                       | 240 +++++++++++++++++++
+ drivers/iommu/{iommu-sva-lib.h =3D> iommu-sva.h}  |  14 +-
+ drivers/iommu/iommu.c                           | 301 ++++++++++++++++---=
-----
+ drivers/iommu/ipmmu-vmsa.c                      |   2 -
+ drivers/iommu/mtk_iommu.c                       |   4 +-
+ drivers/iommu/omap-iommu.c                      |   6 +-
+ drivers/iommu/rockchip-iommu.c                  |  10 +-
+ drivers/iommu/s390-iommu.c                      | 223 +++++++++---------
+ drivers/iommu/sprd-iommu.c                      |   4 +-
+ drivers/iommu/sun50i-iommu.c                    |  88 ++++++-
+ drivers/iommu/tegra-gart.c                      |   2 +-
+ drivers/iommu/virtio-iommu.c                    |   7 +-
+ drivers/misc/uacce/uacce.c                      |   2 +-
+ drivers/pci/ats.c                               |   3 +
+ include/linux/intel-svm.h                       |  13 -
+ include/linux/iommu.h                           | 128 +++++++---
+ 35 files changed, 991 insertions(+), 645 deletions(-)
+ delete mode 100644 drivers/iommu/iommu-sva-lib.c
+ create mode 100644 drivers/iommu/iommu-sva.c
+ rename drivers/iommu/{iommu-sva-lib.h =3D> iommu-sva.h} (83%)
+Merging audit/next (50979953c0c4 audit: unify audit_filter_{uring(), inode=
_name(), syscall()})
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/pcmoore/audit.git audit/next
+Merge made by the 'ort' strategy.
+ kernel/auditsc.c | 75 +++++++++++++++++++++++++++++----------------------=
-----
+ 1 file changed, 39 insertions(+), 36 deletions(-)
+Merging devicetree/for-next (c2741cbe7f8a dt-bindings: media: st,stmipid02=
: Convert the text bindings to YAML)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/robh/linux.git devicetree/for-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ .../arm/tegra/nvidia,tegra-ccplex-cluster.yaml     |   1 -
+ .../devicetree/bindings/ata/ata-generic.yaml       |  58 +++++++
+ .../devicetree/bindings/clock/pwm-clock.txt        |  26 ---
+ .../devicetree/bindings/clock/pwm-clock.yaml       |  45 ++++++
+ .../bindings/display/panel/ilitek,ili9163.yaml     |   3 +-
+ .../bindings/display/panel/ilitek,ili9341.yaml     |   1 +
+ .../bindings/display/panel/nec,nl8048hl11.yaml     |   3 +-
+ .../bindings/display/panel/samsung,lms380kf01.yaml |   5 +-
+ .../bindings/display/panel/samsung,lms397kf04.yaml |   3 +-
+ .../bindings/display/panel/samsung,s6d27a1.yaml    |   4 +-
+ .../bindings/display/panel/tpo,tpg110.yaml         |   1 +
+ .../display/tegra/nvidia,tegra124-dpaux.yaml       |   1 -
+ .../display/tegra/nvidia,tegra186-display.yaml     |   2 -
+ .../bindings/iio/addac/adi,ad74413r.yaml           |   1 -
+ .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   6 +-
+ .../bindings/media/i2c/st,st-mipid02.txt           |  82 ----------
+ .../bindings/media/i2c/st,st-mipid02.yaml          | 176 ++++++++++++++++=
+++++
+ .../devicetree/bindings/misc/idt,89hpesx.yaml      |  72 +++++++++
+ .../devicetree/bindings/misc/idt_89hpesx.txt       |  44 ------
+ .../devicetree/bindings/net/cdns,macb.yaml         |   1 -
+ .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |   1 -
+ .../bindings/phy/intel,phy-thunderbay-emmc.yaml    |  15 +-
+ .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   2 +
+ MAINTAINERS                                        |   2 +-
+ drivers/of/platform.c                              |   5 +-
+ drivers/of/unittest-data/Makefile                  |  66 ++++----
+ .../of/unittest-data/{overlay.dts =3D> overlay.dtso} |   0
+ .../{overlay_0.dts =3D> overlay_0.dtso}              |   0
+ .../{overlay_1.dts =3D> overlay_1.dtso}              |   0
+ .../{overlay_10.dts =3D> overlay_10.dtso}            |   0
+ .../{overlay_11.dts =3D> overlay_11.dtso}            |   0
+ .../{overlay_12.dts =3D> overlay_12.dtso}            |   0
+ .../{overlay_13.dts =3D> overlay_13.dtso}            |   0
+ .../{overlay_15.dts =3D> overlay_15.dtso}            |   0
+ .../{overlay_16.dts =3D> overlay_16.dtso}            |   0
+ .../{overlay_17.dts =3D> overlay_17.dtso}            |   0
+ .../{overlay_18.dts =3D> overlay_18.dtso}            |   0
+ .../{overlay_19.dts =3D> overlay_19.dtso}            |   0
+ .../{overlay_2.dts =3D> overlay_2.dtso}              |   0
+ .../{overlay_20.dts =3D> overlay_20.dtso}            |   0
+ .../{overlay_3.dts =3D> overlay_3.dtso}              |   0
+ .../{overlay_4.dts =3D> overlay_4.dtso}              |   0
+ .../{overlay_5.dts =3D> overlay_5.dtso}              |   0
+ .../{overlay_6.dts =3D> overlay_6.dtso}              |   0
+ .../{overlay_7.dts =3D> overlay_7.dtso}              |   0
+ .../{overlay_8.dts =3D> overlay_8.dtso}              |   0
+ .../{overlay_9.dts =3D> overlay_9.dtso}              |   0
+ ..._dup_node.dts =3D> overlay_bad_add_dup_node.dtso} |   0
+ ..._dup_prop.dts =3D> overlay_bad_add_dup_prop.dtso} |   0
+ ...ay_bad_phandle.dts =3D> overlay_bad_phandle.dtso} |   0
+ ...rlay_bad_symbol.dts =3D> overlay_bad_symbol.dtso} |   0
+ .../{overlay_base.dts =3D> overlay_base.dtso}        |   0
+ .../{overlay_gpio_01.dts =3D> overlay_gpio_01.dtso}  |   0
+ ...{overlay_gpio_02a.dts =3D> overlay_gpio_02a.dtso} |   0
+ ...{overlay_gpio_02b.dts =3D> overlay_gpio_02b.dtso} |   0
+ .../{overlay_gpio_03.dts =3D> overlay_gpio_03.dtso}  |   0
+ ...{overlay_gpio_04a.dts =3D> overlay_gpio_04a.dtso} |   0
+ ...{overlay_gpio_04b.dts =3D> overlay_gpio_04b.dtso} |   0
+ .../{testcases.dts =3D> testcases.dtso}              |   0
+ drivers/of/unittest.c                              |  48 +++---
+ .../{pi433-overlay.dts =3D> pi433-overlay.dtso}      |   0
+ .../pi433/Documentation/devicetree/pi433.txt       |   6 +-
+ include/linux/of.h                                 |   4 +-
+ include/linux/of_address.h                         |  11 ++
+ scripts/Makefile.lib                               |  35 +++-
+ 65 files changed, 482 insertions(+), 248 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/ata/ata-generic.yaml
+ delete mode 100644 Documentation/devicetree/bindings/clock/pwm-clock.txt
+ create mode 100644 Documentation/devicetree/bindings/clock/pwm-clock.yaml
+ delete mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-mipi=
d02.txt
+ create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-mipi=
d02.yaml
+ create mode 100644 Documentation/devicetree/bindings/misc/idt,89hpesx.yaml
+ delete mode 100644 Documentation/devicetree/bindings/misc/idt_89hpesx.txt
+ rename drivers/of/unittest-data/{overlay.dts =3D> overlay.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_0.dts =3D> overlay_0.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_1.dts =3D> overlay_1.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_10.dts =3D> overlay_10.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_11.dts =3D> overlay_11.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_12.dts =3D> overlay_12.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_13.dts =3D> overlay_13.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_15.dts =3D> overlay_15.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_16.dts =3D> overlay_16.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_17.dts =3D> overlay_17.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_18.dts =3D> overlay_18.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_19.dts =3D> overlay_19.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_2.dts =3D> overlay_2.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_20.dts =3D> overlay_20.dtso} (10=
0%)
+ rename drivers/of/unittest-data/{overlay_3.dts =3D> overlay_3.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_4.dts =3D> overlay_4.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_5.dts =3D> overlay_5.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_6.dts =3D> overlay_6.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_7.dts =3D> overlay_7.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_8.dts =3D> overlay_8.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_9.dts =3D> overlay_9.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_bad_add_dup_node.dts =3D> overla=
y_bad_add_dup_node.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_bad_add_dup_prop.dts =3D> overla=
y_bad_add_dup_prop.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_bad_phandle.dts =3D> overlay_bad=
_phandle.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_bad_symbol.dts =3D> overlay_bad_=
symbol.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_base.dts =3D> overlay_base.dtso}=
 (100%)
+ rename drivers/of/unittest-data/{overlay_gpio_01.dts =3D> overlay_gpio_01=
.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_gpio_02a.dts =3D> overlay_gpio_0=
2a.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_gpio_02b.dts =3D> overlay_gpio_0=
2b.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_gpio_03.dts =3D> overlay_gpio_03=
.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_gpio_04a.dts =3D> overlay_gpio_0=
4a.dtso} (100%)
+ rename drivers/of/unittest-data/{overlay_gpio_04b.dts =3D> overlay_gpio_0=
4b.dtso} (100%)
+ rename drivers/of/unittest-data/{testcases.dts =3D> testcases.dtso} (100%)
+ rename drivers/staging/pi433/Documentation/devicetree/{pi433-overlay.dts =
=3D> pi433-overlay.dtso} (100%)
+Merging dt-krzk/for-next (2d27c3ae9666 Merge branch 'next/qcom-pinctrl' in=
to for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux-dt.git dt-krzk/for-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   2 +-
+ .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     | 113 +++++------
+ ...mdm9607-pinctrl.yaml =3D> qcom,mdm9607-tlmm.yaml} |  41 ++--
+ .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ----------------
+ .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 119 ++++++++++++
+ .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     | 103 ++++------
+ .../bindings/pinctrl/qcom,msm8909-tlmm.yaml        |  75 ++++----
+ .../bindings/pinctrl/qcom,msm8916-pinctrl.txt      | 195 ----------------=
---
+ .../bindings/pinctrl/qcom,msm8916-pinctrl.yaml     | 166 ++++++++++++++++
+ .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     |  97 ++++------
+ .../bindings/pinctrl/qcom,msm8974-pinctrl.txt      | 121 ------------
+ .../bindings/pinctrl/qcom,msm8974-pinctrl.yaml     | 179 ++++++++++++++++=
++
+ .../bindings/pinctrl/qcom,msm8994-pinctrl.txt      | 186 ----------------=
--
+ .../bindings/pinctrl/qcom,msm8994-pinctrl.yaml     | 162 ++++++++++++++++
+ .../bindings/pinctrl/qcom,msm8996-pinctrl.txt      | 208 ----------------=
-----
+ .../bindings/pinctrl/qcom,msm8996-pinctrl.yaml     | 182 ++++++++++++++++=
++
+ .../bindings/pinctrl/qcom,msm8998-pinctrl.txt      | 202 ----------------=
----
+ .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml     | 171 +++++++++++++++++
+ .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |  45 ++---
+ ...qcm2290-pinctrl.yaml =3D> qcom,qcm2290-tlmm.yaml} |  64 ++-----
+ .../bindings/pinctrl/qcom,qcs404-pinctrl.txt       | 199 ----------------=
----
+ .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml      | 176 +++++++++++++++++
+ .../bindings/pinctrl/qcom,sc7180-pinctrl.txt       | 187 ----------------=
--
+ .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml      | 158 ++++++++++++++++
+ .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     |  48 +++--
+ .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |  47 ++---
+ ...sc8180x-pinctrl.yaml =3D> qcom,sc8180x-tlmm.yaml} |  29 +--
+ .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   |  44 ++++-
+ ...8280xp-pinctrl.yaml =3D> qcom,sc8280xp-tlmm.yaml} |  28 +--
+ .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml      | 188 ++++++++++++++++=
+++
+ .../bindings/pinctrl/qcom,sdm660-pinctrl.txt       | 191 ----------------=
---
+ .../bindings/pinctrl/qcom,sdm845-pinctrl.txt       | 176 -----------------
+ .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml      | 158 ++++++++++++++++
+ .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       |  95 ++++------
+ ...com,sdx65-pinctrl.yaml =3D> qcom,sdx65-tlmm.yaml} |  62 ++----
+ ...m,sm6115-pinctrl.yaml =3D> qcom,sm6115-tlmm.yaml} |  67 ++-----
+ ...m,sm6125-pinctrl.yaml =3D> qcom,sm6125-tlmm.yaml} |  32 +---
+ ...m,sm6350-pinctrl.yaml =3D> qcom,sm6350-tlmm.yaml} |  25 +--
+ .../bindings/pinctrl/qcom,sm6375-tlmm.yaml         |  23 +--
+ .../bindings/pinctrl/qcom,sm8150-pinctrl.txt       | 190 ----------------=
---
+ .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml      | 173 +++++++++++++++++
+ .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     |  58 ++++--
+ .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      | 206 +++++++++-------=
----
+ ...m,sm8350-pinctrl.yaml =3D> qcom,sm8350-tlmm.yaml} |  25 +--
+ .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml     |  51 ++++-
+ ...m,sm8450-pinctrl.yaml =3D> qcom,sm8450-tlmm.yaml} |  24 +--
+ .../bindings/pinctrl/qcom,tlmm-common.yaml         |  20 +-
+ MAINTAINERS                                        |   3 +
+ arch/arm/boot/dts/am335x-evm.dts                   |   2 +-
+ arch/arm/boot/dts/am335x-evmsk.dts                 |   2 +-
+ arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi  |  10 +-
+ arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi  |  10 +-
+ arch/arm/boot/dts/am335x-pepper.dts                |   4 +-
+ arch/arm/boot/dts/am3517-evm.dts                   |  16 +-
+ arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  10 +-
+ arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  10 +-
+ arch/arm/boot/dts/armada-370-rd.dts                |  16 +-
+ arch/arm/boot/dts/armada-370-synology-ds213j.dts   |   6 +-
+ arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  10 +-
+ .../boot/dts/aspeed-bmc-facebook-cloudripper.dts   |   2 +-
+ arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts   |   2 +-
+ arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts     |   2 +-
+ arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts |   2 +-
+ .../boot/dts/ast2600-facebook-netbmc-common.dtsi   |   2 +-
+ arch/arm/boot/dts/kirkwood-b3.dts                  |   2 +-
+ arch/arm/boot/dts/kirkwood-db-88f6281.dts          |   2 +-
+ arch/arm/boot/dts/kirkwood-db-88f6282.dts          |   2 +-
+ arch/arm/boot/dts/kirkwood-dir665.dts              |  14 +-
+ arch/arm/boot/dts/kirkwood-ds112.dts               |   2 +-
+ arch/arm/boot/dts/kirkwood-ds411.dts               |   2 +-
+ arch/arm/boot/dts/kirkwood-iconnect.dts            |   2 +-
+ arch/arm/boot/dts/kirkwood-km_common.dtsi          |   2 +-
+ arch/arm/boot/dts/kirkwood-l-50.dts                |  24 +--
+ arch/arm/boot/dts/kirkwood-laplug.dts              |   2 +-
+ arch/arm/boot/dts/kirkwood-linkstation.dtsi        |   2 +-
+ arch/arm/boot/dts/kirkwood-mplcec4.dts             |  16 +-
+ arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |   2 +-
+ arch/arm/boot/dts/kirkwood-nas2big.dts             |   2 +-
+ arch/arm/boot/dts/kirkwood-net2big.dts             |  10 +-
+ arch/arm/boot/dts/kirkwood-net5big.dts             |  10 +-
+ .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |  12 +-
+ arch/arm/boot/dts/kirkwood-nsa310.dts              |   2 +-
+ arch/arm/boot/dts/kirkwood-nsa320.dts              |   2 +-
+ arch/arm/boot/dts/kirkwood-nsa325.dts              |   2 +-
+ arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi      |   2 +-
+ arch/arm/boot/dts/kirkwood-rd88f6192.dts           |  60 +++---
+ arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts        |   2 +-
+ arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          |   4 +-
+ arch/arm/boot/dts/kirkwood-rs212.dts               |   2 +-
+ arch/arm/boot/dts/kirkwood-synology.dtsi           |   2 +-
+ arch/arm/boot/dts/kirkwood-t5325.dts               |   2 +-
+ arch/arm/boot/dts/kirkwood-ts219.dtsi              |   4 +-
+ arch/arm/boot/dts/kirkwood.dtsi                    |  34 ++--
+ arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi          |   6 +-
+ arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi          |   6 +-
+ arch/arm/boot/dts/omap3-cm-t3517.dts               |  12 +-
+ arch/arm/boot/dts/omap3-gta04.dtsi                 |   6 +-
+ arch/arm/boot/dts/omap3-ldp.dts                    |   2 +-
+ arch/arm/boot/dts/omap3-n900.dts                   |  38 ++--
+ arch/arm/boot/dts/omap3-zoom3.dts                  |  44 ++---
+ arch/arm/boot/dts/omap4-cpu-thermal.dtsi           |  24 +--
+ arch/arm/boot/dts/omap5-cm-t54.dts                 |  64 +++----
+ arch/arm/boot/dts/sunplus-sp7021.dtsi              |   3 -
+ arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi      |  14 +-
+ 104 files changed, 2725 insertions(+), 3101 deletions(-)
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,mdm9607-pinctrl.ya=
ml =3D> qcom,mdm9607-tlmm.yaml} (84%)
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,mdm9615=
-pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,mdm9615=
-pinctrl.yaml
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8916=
-pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8916=
-pinctrl.yaml
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8974=
-pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8974=
-pinctrl.yaml
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8994=
-pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8994=
-pinctrl.yaml
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8996=
-pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8996=
-pinctrl.yaml
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998=
-pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998=
-pinctrl.yaml
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,qcm2290-pinctrl.ya=
ml =3D> qcom,qcm2290-tlmm.yaml} (76%)
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-=
pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-=
pinctrl.yaml
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7180-=
pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7180-=
pinctrl.yaml
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,sc8180x-pinctrl.ya=
ml =3D> qcom,sc8180x-tlmm.yaml} (88%)
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,sc8280xp-pinctrl.y=
aml =3D> qcom,sc8280xp-tlmm.yaml} (89%)
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm630-=
pinctrl.yaml
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm660-=
pinctrl.txt
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-=
pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-=
pinctrl.yaml
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,sdx65-pinctrl.yaml=
 =3D> qcom,sdx65-tlmm.yaml} (85%)
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6115-pinctrl.yam=
l =3D> qcom,sm6115-tlmm.yaml} (75%)
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6125-pinctrl.yam=
l =3D> qcom,sm6125-tlmm.yaml} (87%)
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6350-pinctrl.yam=
l =3D> qcom,sm6350-tlmm.yaml} (90%)
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8150-=
pinctrl.txt
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8150-=
pinctrl.yaml
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8350-pinctrl.yam=
l =3D> qcom,sm8350-tlmm.yaml} (89%)
+ rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8450-pinctrl.yam=
l =3D> qcom,sm8450-tlmm.yaml} (89%)
+Merging mailbox/mailbox-for-next (b8ae88e1e75e mailbox: qcom-ipcc: flag IR=
Q NO_THREAD)
+$ git merge -m Merge branch 'mailbox-for-next' of git://git.linaro.org/lan=
ding-teams/working/fujitsu/integration.git mailbox/mailbox-for-next
+Already up to date.
+Merging spi/for-next (5e2212c83ada Merge remote-tracking branch 'spi/for-6=
.2' into spi-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/broonie/spi.git spi/for-next
+Auto-merging MAINTAINERS
+Auto-merging MAINTAINERS
+Auto-merging drivers/spi/spi-cadence-quadspi.c
+Auto-merging drivers/spi/spi.c
+Auto-merging include/linux/spi/spi.h
+Merge made by the 'ort' strategy.
+ .../bindings/spi/amlogic,meson-gx-spicc.yaml       |  75 ++--
+ .../devicetree/bindings/spi/nuvoton,npcm-fiu.txt   |   2 +-
+ .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |   4 +-
+ Documentation/driver-api/spi.rst                   |   4 +-
+ drivers/firmware/xilinx/zynqmp.c                   |   7 +
+ drivers/spi/Kconfig                                |   9 +
+ drivers/spi/Makefile                               |   1 +
+ drivers/spi/spi-aspeed-smc.c                       |   6 +-
+ drivers/spi/spi-bcm-qspi.c                         |   5 +-
+ drivers/spi/spi-bcm-qspi.h                         |   2 +-
+ drivers/spi/spi-bcm63xx.c                          |   3 +-
+ drivers/spi/spi-brcmstb-qspi.c                     |   4 +-
+ drivers/spi/spi-cadence-quadspi.c                  |   7 +-
+ drivers/spi/spi-fsl-cpm.c                          |   2 +-
+ drivers/spi/spi-hisi-sfc-v3xx.c                    |   2 +-
+ drivers/spi/spi-img-spfi.c                         |   3 +-
+ drivers/spi/spi-imx.c                              |   8 -
+ drivers/spi/spi-iproc-qspi.c                       |   4 +-
+ drivers/spi/spi-meson-spicc.c                      |  39 +-
+ drivers/spi/spi-microchip-core.c                   |   9 -
+ drivers/spi/spi-mxic.c                             |   3 +-
+ drivers/spi/spi-npcm-fiu.c                         |   4 +-
+ drivers/spi/spi-nxp-fspi.c                         |   2 +-
+ drivers/spi/spi-pci1xxxx.c                         | 397 ++++++++++++++++=
+++++
+ drivers/spi/spi-pxa2xx.c                           | 195 +++-------
+ drivers/spi/spi-zynqmp-gqspi.c                     | 191 ++++++++--
+ drivers/spi/spi.c                                  |  27 +-
+ include/linux/firmware/xlnx-zynqmp.h               |  19 +
+ include/linux/pxa2xx_ssp.h                         |   1 +
+ include/linux/spi/spi.h                            |  54 ++-
+ 30 files changed, 821 insertions(+), 268 deletions(-)
+ create mode 100644 drivers/spi/spi-pci1xxxx.c
+Merging tip/master (01d2077d0e55 Merge branch into tip/master: 'x86/core')
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/tip/tip.git tip/master
+Auto-merging Makefile
+Auto-merging arch/s390/kernel/perf_pai_crypto.c
+Auto-merging arch/s390/kernel/perf_pai_ext.c
+Auto-merging arch/x86/kernel/traps.c
+Auto-merging arch/x86/kvm/cpuid.c
+Auto-merging arch/x86/net/bpf_jit_comp.c
+CONFLICT (content): Merge conflict in arch/x86/net/bpf_jit_comp.c
+Auto-merging include/linux/bpf.h
+CONFLICT (content): Merge conflict in include/linux/bpf.h
+Auto-merging kernel/bpf/core.c
+Auto-merging kernel/bpf/trampoline.c
+Auto-merging lib/Kconfig.debug
+Auto-merging mm/userfaultfd.c
+Auto-merging scripts/Makefile.lib
+Resolved 'arch/x86/net/bpf_jit_comp.c' using previous resolution.
+Resolved 'include/linux/bpf.h' using previous resolution.
+Automatic merge failed; fix conflicts and then commit the result.
+$ git commit --no-edit -v -a
+[master ea7c404585a0] Merge branch 'master' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tip/tip.git
+$ git diff -M --stat --summary HEAD^..
+ Documentation/x86/boot.rst                         |    1 +
+ Makefile                                           |    4 +-
+ arch/Kconfig                                       |   24 +
+ arch/arm/mach-omap1/sram-init.c                    |    8 +-
+ arch/arm/mach-omap2/sram.c                         |    8 +-
+ arch/arm64/kernel/perf_event.c                     |   18 +-
+ arch/ia64/Kconfig                                  |    1 +
+ arch/ia64/Makefile                                 |    2 +-
+ arch/mips/Kconfig                                  |    2 +-
+ arch/powerpc/include/asm/nohash/32/pgtable.h       |    2 +-
+ arch/powerpc/kernel/kprobes.c                      |    9 +-
+ arch/powerpc/perf/core-book3s.c                    |    8 +-
+ arch/s390/kernel/perf_pai_crypto.c                 |    2 +-
+ arch/s390/kernel/perf_pai_ext.c                    |    2 +-
+ arch/sh/Kconfig                                    |    2 +-
+ arch/sh/include/asm/pgtable-3level.h               |   10 +-
+ arch/um/include/asm/pgtable-3level.h               |    8 -
+ arch/um/kernel/um_arch.c                           |    5 +
+ arch/x86/Kconfig                                   |   77 +-
+ arch/x86/Makefile                                  |    6 +
+ arch/x86/boot/compressed/head_64.S                 |    8 +
+ arch/x86/boot/string.c                             |    2 +-
+ arch/x86/crypto/camellia-aesni-avx-asm_64.S        |    2 -
+ arch/x86/crypto/camellia-aesni-avx2-asm_64.S       |    4 -
+ arch/x86/crypto/cast5-avx-x86_64-asm_64.S          |    2 -
+ arch/x86/crypto/crct10dif-pcl-asm_64.S             |    1 -
+ arch/x86/crypto/poly1305-x86_64-cryptogams.pl      |    1 -
+ arch/x86/crypto/serpent-avx-x86_64-asm_64.S        |    2 -
+ arch/x86/crypto/serpent-avx2-asm_64.S              |    2 -
+ arch/x86/crypto/sha1_ni_asm.S                      |    1 -
+ arch/x86/crypto/sha256-avx-asm.S                   |    1 -
+ arch/x86/crypto/sha256-avx2-asm.S                  |    1 -
+ arch/x86/crypto/sha256-ssse3-asm.S                 |    1 -
+ arch/x86/crypto/sha256_ni_asm.S                    |    1 -
+ arch/x86/crypto/sm3-avx-asm_64.S                   |    1 -
+ arch/x86/crypto/sm4-aesni-avx-asm_64.S             |    7 -
+ arch/x86/crypto/sm4-aesni-avx2-asm_64.S            |    6 -
+ arch/x86/crypto/twofish-avx-x86_64-asm_64.S        |    2 -
+ arch/x86/entry/entry_32.S                          |    4 +-
+ arch/x86/entry/entry_64.S                          |   50 +-
+ arch/x86/entry/entry_64_compat.S                   |   11 +-
+ arch/x86/entry/thunk_64.S                          |    4 +-
+ arch/x86/entry/vdso/Makefile                       |   14 +-
+ arch/x86/events/amd/brs.c                          |    2 +-
+ arch/x86/events/amd/lbr.c                          |    6 +-
+ arch/x86/events/core.c                             |   44 +-
+ arch/x86/events/intel/core.c                       |   23 +-
+ arch/x86/events/intel/ds.c                         |    4 +-
+ arch/x86/events/intel/lbr.c                        |   30 +-
+ arch/x86/events/perf_event.h                       |   30 +-
+ arch/x86/ia32/Makefile                             |    2 -
+ arch/x86/include/asm/alternative.h                 |   68 +-
+ arch/x86/include/asm/cmpxchg_32.h                  |   28 -
+ arch/x86/include/asm/cmpxchg_64.h                  |    5 -
+ arch/x86/include/asm/cpu_entry_area.h              |    4 -
+ arch/x86/include/asm/cpufeatures.h                 |    2 +
+ arch/x86/include/asm/current.h                     |   32 +-
+ arch/x86/include/asm/disabled-features.h           |    9 +-
+ arch/x86/include/asm/elf.h                         |    4 -
+ arch/x86/include/asm/fpu/signal.h                  |    7 -
+ arch/x86/include/asm/hardirq.h                     |    3 +-
+ arch/x86/include/asm/irq_stack.h                   |   12 +-
+ arch/x86/include/asm/kasan.h                       |    3 +
+ arch/x86/include/asm/linkage.h                     |   63 +-
+ arch/x86/include/asm/microcode.h                   |    4 +-
+ arch/x86/include/asm/msr-index.h                   |    1 +
+ arch/x86/include/asm/nospec-branch.h               |  176 +-
+ arch/x86/include/asm/paravirt.h                    |    5 +-
+ arch/x86/include/asm/paravirt_types.h              |   89 +-
+ arch/x86/include/asm/pgtable-3level.h              |  171 +-
+ arch/x86/include/asm/pgtable-3level_types.h        |    7 +
+ arch/x86/include/asm/pgtable_64_types.h            |    1 +
+ arch/x86/include/asm/pgtable_areas.h               |    8 +-
+ arch/x86/include/asm/pgtable_types.h               |    4 +-
+ arch/x86/include/asm/preempt.h                     |   27 +-
+ arch/x86/include/asm/processor.h                   |   11 +-
+ arch/x86/include/asm/qspinlock_paravirt.h          |    2 +-
+ arch/x86/include/asm/segment.h                     |    2 +-
+ arch/x86/include/asm/set_memory.h                  |    3 +
+ arch/x86/include/asm/sgx.h                         |   33 +-
+ arch/x86/include/asm/sighandling.h                 |    9 +
+ arch/x86/include/asm/signal.h                      |    5 -
+ arch/x86/include/asm/smp.h                         |   12 +-
+ arch/x86/include/asm/text-patching.h               |    1 +
+ arch/x86/kernel/Makefile                           |    6 +-
+ arch/x86/kernel/alternative.c                      |  539 ++++-
+ arch/x86/kernel/asm-offsets.c                      |    5 +
+ arch/x86/kernel/asm-offsets_64.c                   |    2 +-
+ arch/x86/kernel/callthunks.c                       |  388 ++++
+ arch/x86/kernel/cpu/Makefile                       |    3 -
+ arch/x86/kernel/cpu/bugs.c                         |  137 +-
+ arch/x86/kernel/cpu/common.c                       |   97 +-
+ arch/x86/kernel/cpu/cpuid-deps.c                   |    1 +
+ arch/x86/kernel/cpu/intel.c                        |    1 -
+ arch/x86/kernel/cpu/intel_epb.c                    |    7 +-
+ arch/x86/kernel/cpu/mce/amd.c                      |   33 +-
+ arch/x86/kernel/cpu/mce/severity.c                 |    8 +-
+ arch/x86/kernel/cpu/microcode/amd.c                |    5 +-
+ arch/x86/kernel/cpu/microcode/core.c               |  205 +-
+ arch/x86/kernel/cpu/microcode/intel.c              |    3 +-
+ arch/x86/kernel/cpu/mtrr/cyrix.c                   |   34 -
+ arch/x86/kernel/cpu/mtrr/generic.c                 |    5 +-
+ arch/x86/kernel/cpu/resctrl/core.c                 |    2 -
+ arch/x86/kernel/cpu/resctrl/ctrlmondata.c          |    3 +-
+ arch/x86/kernel/cpu/scattered.c                    |    1 +
+ arch/x86/kernel/cpu/sgx/encl.c                     |   23 +-
+ arch/x86/kernel/cpu/sgx/ioctl.c                    |    2 +-
+ arch/x86/kernel/dumpstack_32.c                     |    4 +-
+ arch/x86/kernel/dumpstack_64.c                     |    2 +-
+ arch/x86/kernel/espfix_64.c                        |   12 +-
+ arch/x86/kernel/ftrace.c                           |   26 +-
+ arch/x86/kernel/ftrace_64.S                        |   37 +-
+ arch/x86/kernel/head_64.S                          |    1 +
+ arch/x86/kernel/hw_breakpoint.c                    |    2 +-
+ arch/x86/kernel/i8259.c                            |    2 +-
+ arch/x86/kernel/irq_32.c                           |   13 +-
+ arch/x86/kernel/irq_64.c                           |    6 +-
+ arch/x86/kernel/kprobes/core.c                     |   10 +-
+ arch/x86/kernel/kvm.c                              |    1 +
+ arch/x86/kernel/module.c                           |   47 +-
+ arch/x86/kernel/paravirt.c                         |    2 +
+ arch/x86/kernel/process_32.c                       |    6 +-
+ arch/x86/kernel/process_64.c                       |    6 +-
+ arch/x86/kernel/ptrace.c                           |  174 +-
+ arch/x86/kernel/relocate_kernel_64.S               |    5 +-
+ arch/x86/kernel/setup_percpu.c                     |    7 +-
+ arch/x86/kernel/signal.c                           |  654 +-----
+ .../x86/{ia32/ia32_signal.c =3D> kernel/signal_32.c} |  117 +-
+ arch/x86/kernel/signal_64.c                        |  383 ++++
+ arch/x86/kernel/smpboot.c                          |   10 +-
+ arch/x86/kernel/static_call.c                      |    3 +-
+ arch/x86/kernel/traps.c                            |    4 +-
+ arch/x86/kernel/tsc.c                              |    2 +-
+ arch/x86/kernel/unwind_orc.c                       |   21 +-
+ arch/x86/kernel/vmlinux.lds.S                      |   37 +-
+ arch/x86/kvm/cpuid.c                               |    6 +-
+ arch/x86/kvm/reverse_cpuid.h                       |    3 +
+ arch/x86/kvm/svm/vmenter.S                         |    1 +
+ arch/x86/lib/Makefile                              |    1 +
+ arch/x86/lib/error-inject.c                        |    1 +
+ arch/x86/lib/memcpy_32.c                           |  187 --
+ arch/x86/lib/memmove_32.S                          |  200 ++
+ arch/x86/lib/putuser.S                             |   62 +-
+ arch/x86/lib/retpoline.S                           |  107 +-
+ arch/x86/mm/cpu_entry_area.c                       |   54 +-
+ arch/x86/mm/init.c                                 |    2 +-
+ arch/x86/mm/kasan_init_64.c                        |   15 +-
+ arch/x86/mm/pat/set_memory.c                       |   14 +-
+ arch/x86/net/bpf_jit_comp.c                        |   45 +-
+ arch/x86/power/hibernate.c                         |    2 +-
+ arch/x86/xen/enlighten_pv.c                        |    2 +-
+ arch/x86/xen/xen-asm.S                             |    8 +-
+ drivers/iommu/intel/irq_remapping.c                |   13 +-
+ drivers/misc/sram-exec.c                           |    7 +-
+ drivers/perf/arm_pmu.c                             |   16 +-
+ drivers/ras/debugfs.c                              |    2 +-
+ drivers/virt/coco/sev-guest/sev-guest.c            |    4 +-
+ include/asm-generic/vmlinux.lds.h                  |    4 +-
+ include/linux/compat.h                             |    2 -
+ include/linux/filter.h                             |    3 +-
+ include/linux/linkage.h                            |    4 +-
+ include/linux/perf/arm_pmu.h                       |    2 +-
+ include/linux/perf_event.h                         |  125 +-
+ include/linux/pgtable.h                            |   73 +-
+ include/linux/psi_types.h                          |    4 +
+ include/linux/resctrl.h                            |    6 +-
+ include/linux/sched.h                              |    5 +-
+ include/linux/sched/task.h                         |    2 +-
+ include/linux/set_memory.h                         |   10 +
+ include/linux/static_call.h                        |    2 +
+ include/linux/syscalls.h                           |    2 +
+ init/main.c                                        |    4 +-
+ kernel/bpf/bpf_struct_ops.c                        |    3 +-
+ kernel/bpf/core.c                                  |    6 +-
+ kernel/bpf/trampoline.c                            |    3 +-
+ kernel/events/core.c                               | 2088 ++++++++++-----=
-----
+ kernel/fork.c                                      |   37 +-
+ kernel/jump_label.c                                |    8 +-
+ kernel/sched/core.c                                |  241 ++-
+ kernel/sched/deadline.c                            |    7 +-
+ kernel/sched/fair.c                                |  303 ++-
+ kernel/sched/psi.c                                 |  100 +-
+ kernel/sched/sched.h                               |   92 +-
+ kernel/sched/stats.h                               |   22 +-
+ kernel/static_call_inline.c                        |   23 +-
+ kernel/time/timer.c                                |    2 +-
+ kernel/trace/trace_selftest.c                      |    9 +-
+ lib/Kconfig.debug                                  |    1 +
+ lib/memcpy_kunit.c                                 |   22 +
+ mm/Kconfig                                         |    2 +-
+ mm/gup.c                                           |    2 +-
+ mm/hmm.c                                           |    3 +-
+ mm/khugepaged.c                                    |    2 +-
+ mm/mapping_dirty_helpers.c                         |    2 +-
+ mm/mprotect.c                                      |    2 +-
+ mm/userfaultfd.c                                   |    2 +-
+ mm/vmscan.c                                        |    5 +-
+ net/bpf/bpf_dummy_struct_ops.c                     |    3 +-
+ samples/ftrace/ftrace-direct-modify.c              |    3 +
+ samples/ftrace/ftrace-direct-multi-modify.c        |    3 +
+ samples/ftrace/ftrace-direct-multi.c               |    2 +
+ samples/ftrace/ftrace-direct-too.c                 |    2 +
+ samples/ftrace/ftrace-direct.c                     |    2 +
+ scripts/Makefile.lib                               |    3 +
+ tools/include/linux/interval_tree_generic.h        |  187 ++
+ tools/objtool/arch/x86/decode.c                    |   24 +
+ tools/objtool/builtin-check.c                      |    9 +-
+ tools/objtool/check.c                              |  391 +++-
+ tools/objtool/elf.c                                |  296 ++-
+ tools/objtool/include/objtool/arch.h               |    2 +
+ tools/objtool/include/objtool/builtin.h            |    3 +
+ tools/objtool/include/objtool/check.h              |   12 +-
+ tools/objtool/include/objtool/elf.h                |    9 +-
+ tools/objtool/include/objtool/objtool.h            |    1 +
+ tools/objtool/objtool.c                            |    1 +
+ 215 files changed, 5803 insertions(+), 3520 deletions(-)
+ create mode 100644 arch/x86/kernel/callthunks.c
+ rename arch/x86/{ia32/ia32_signal.c =3D> kernel/signal_32.c} (82%)
+ create mode 100644 arch/x86/kernel/signal_64.c
+ create mode 100644 arch/x86/lib/memmove_32.S
+ create mode 100644 tools/include/linux/interval_tree_generic.h
+Merging clockevents/timers/drivers/next (af246cc6d0ed clocksource/drivers/=
arm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value)
+$ git merge -m Merge branch 'timers/drivers/next' of git://git.linaro.org/=
people/daniel.lezcano/linux.git clockevents/timers/drivers/next
+Already up to date.
+Merging edac/edac-for-next (b998a2babf4e Merge edac-misc into for-next)
+$ git merge -m Merge branch 'edac-for-next' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/ras/ras.git edac/edac-for-next
+Auto-merging MAINTAINERS
+Auto-merging drivers/acpi/apei/ghes.c
+Auto-merging include/acpi/ghes.h
+Merge made by the 'ort' strategy.
+ MAINTAINERS                    |  5 +--
+ drivers/acpi/apei/ghes.c       | 66 +++++++++++++++++++++++++++++--
+ drivers/edac/Kconfig           |  5 ++-
+ drivers/edac/amd64_edac.c      |  3 ++
+ drivers/edac/armada_xp_edac.c  |  3 ++
+ drivers/edac/edac_mc_sysfs.c   | 24 +++++++++++
+ drivers/edac/edac_module.h     |  1 +
+ drivers/edac/ghes_edac.c       | 90 ++++++++++++++++++++++++++-----------=
-----
+ drivers/edac/i10nm_base.c      |  3 ++
+ drivers/edac/igen6_edac.c      |  5 ++-
+ drivers/edac/layerscape_edac.c |  3 ++
+ drivers/edac/pnd2_edac.c       |  3 ++
+ drivers/edac/sb_edac.c         |  3 ++
+ drivers/edac/skx_base.c        |  3 ++
+ drivers/edac/thunderx_edac.c   |  3 ++
+ drivers/edac/xgene_edac.c      |  3 ++
+ drivers/firmware/efi/cper.c    |  3 ++
+ include/acpi/ghes.h            | 34 +++++-----------
+ 18 files changed, 191 insertions(+), 69 deletions(-)
+Merging irqchip/irq/irqchip-next (732d69c80cb0 Merge branch irq/misc-6.1 i=
nto irq/irqchip-next)
+$ git merge -m Merge branch 'irq/irqchip-next' of git://git.kernel.org/pub=
/scm/linux/kernel/git/maz/arm-platforms.git irqchip/irq/irqchip-next
+Already up to date.
+Merging ftrace/for-next (0934ae9977c2 tracing: Fix reading strings from sy=
nthetic events)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/trace/linux-trace.git ftrace/for-next
+Already up to date.
+Merging rcu/rcu/next (75f97d8e607c rcu: Consolidate initialization and CPU=
-hotplug code)
+$ git merge -m Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/paulmck/linux-rcu.git rcu/rcu/next
+Auto-merging Documentation/admin-guide/kernel-parameters.txt
+Auto-merging arch/Kconfig
+Auto-merging arch/s390/Kconfig
+Auto-merging arch/x86/Kconfig
+Auto-merging include/linux/kvm_host.h
+Auto-merging include/linux/rcupdate.h
+Auto-merging kernel/rcu/tasks.h
+Auto-merging kernel/sched/core.c
+Auto-merging tools/objtool/check.c
+Merge made by the 'ort' strategy.
+ Documentation/RCU/NMI-RCU.rst                      |   4 +-
+ Documentation/RCU/UP.rst                           |  13 +-
+ Documentation/RCU/arrayRCU.rst                     | 165 -------
+ Documentation/RCU/checklist.rst                    | 244 ++++++----
+ Documentation/RCU/index.rst                        |   1 -
+ Documentation/RCU/listRCU.rst                      | 174 ++++---
+ Documentation/RCU/lockdep.rst                      |  17 +-
+ Documentation/RCU/rcu.rst                          |   6 +-
+ Documentation/RCU/rcu_dereference.rst              |  21 +-
+ Documentation/RCU/rcubarrier.rst                   | 178 +++----
+ Documentation/RCU/rculist_nulls.rst                | 109 +++--
+ Documentation/RCU/stallwarn.rst                    |  43 +-
+ Documentation/RCU/torture.rst                      |  89 +++-
+ Documentation/RCU/whatisRCU.rst                    | 193 +++++---
+ Documentation/admin-guide/kernel-parameters.txt    |   5 +
+ .../litmus-tests/locking/DCL-broken.litmus         |  55 +++
+ .../litmus-tests/locking/DCL-fixed.litmus          |  56 +++
+ .../litmus-tests/locking/RM-broken.litmus          |  42 ++
+ Documentation/litmus-tests/locking/RM-fixed.litmus |  42 ++
+ Documentation/memory-barriers.txt                  |  22 +-
+ .../translations/ko_KR/memory-barriers.txt         | 149 +++---
+ arch/Kconfig                                       |   3 +
+ arch/arm64/Kconfig                                 |   1 +
+ arch/loongarch/Kconfig                             |   1 +
+ arch/s390/Kconfig                                  |   1 +
+ arch/x86/Kconfig                                   |   1 +
+ drivers/scsi/scsi_error.c                          |   2 +-
+ include/linux/clocksource.h                        |   3 +
+ include/linux/kernel_stat.h                        |  14 +-
+ include/linux/kvm_host.h                           |   2 +-
+ include/linux/rculist_nulls.h                      |   2 +-
+ include/linux/rcupdate.h                           |  14 +-
+ include/linux/rcutiny.h                            |  16 +-
+ include/linux/rcutree.h                            |   6 +-
+ include/linux/slab.h                               |  11 +
+ include/linux/srcu.h                               |  63 +++
+ include/linux/srcutree.h                           |   5 +-
+ kernel/kcsan/core.c                                |  50 ++
+ kernel/rcu/Kconfig                                 |  11 +
+ kernel/rcu/Kconfig.debug                           |  10 +
+ kernel/rcu/rcu.h                                   |   9 +
+ kernel/rcu/rcuscale.c                              |  69 ++-
+ kernel/rcu/rcutorture.c                            |  72 ++-
+ kernel/rcu/srcutree.c                              | 100 +++-
+ kernel/rcu/sync.c                                  |   2 +-
+ kernel/rcu/tasks.h                                 |   2 +-
+ kernel/rcu/tiny.c                                  |  11 +-
+ kernel/rcu/tree.c                                  | 509 ++++++++++++----=
-----
+ kernel/rcu/tree.h                                  |  29 +-
+ kernel/rcu/tree_exp.h                              |   2 +-
+ kernel/rcu/tree_nocb.h                             | 259 ++++++++---
+ kernel/rcu/tree_plugin.h                           |   5 +-
+ kernel/rcu/tree_stall.h                            |  31 ++
+ kernel/rcu/update.c                                |   2 +
+ kernel/sched/core.c                                |   5 +
+ kernel/time/clocksource.c                          |  34 +-
+ kernel/workqueue.c                                 |   2 +-
+ lib/Kconfig.kcsan                                  |   6 +-
+ lib/percpu-refcount.c                              |   3 +-
+ net/rxrpc/conn_object.c                            |   2 +-
+ tools/memory-model/Documentation/explanation.txt   |   7 +-
+ tools/memory-model/Documentation/locking.txt       | 320 +++++++++++++
+ tools/memory-model/linux-kernel.bell               |  16 +-
+ tools/memory-model/litmus-tests/.gitignore         |   2 +-
+ tools/memory-model/scripts/README                  |  16 +-
+ tools/memory-model/scripts/checkalllitmus.sh       |  29 +-
+ tools/memory-model/scripts/checkghlitmus.sh        |  11 +-
+ tools/memory-model/scripts/checklitmus.sh          |  25 +-
+ tools/memory-model/scripts/checklitmushist.sh      |   2 +-
+ tools/memory-model/scripts/checktheselitmus.sh     |  43 ++
+ tools/memory-model/scripts/cmplitmushist.sh        |  49 +-
+ tools/memory-model/scripts/hwfnseg.sh              |  20 +
+ tools/memory-model/scripts/initlitmushist.sh       |   2 +-
+ tools/memory-model/scripts/judgelitmus.sh          | 120 ++++-
+ tools/memory-model/scripts/newlitmushist.sh        |   4 +-
+ tools/memory-model/scripts/parseargs.sh            |  21 +-
+ tools/memory-model/scripts/runlitmus.sh            |  80 ++++
+ tools/memory-model/scripts/runlitmushist.sh        |  29 +-
+ tools/memory-model/scripts/simpletest.sh           |  35 ++
+ tools/objtool/check.c                              |  10 +
+ tools/testing/selftests/nolibc/Makefile            |   3 +
+ tools/testing/selftests/nolibc/nolibc-test.c       |   7 +
+ .../testing/selftests/rcutorture/bin/config2csv.sh |   3 +-
+ .../selftests/rcutorture/bin/config_override.sh    |   3 +-
+ .../selftests/rcutorture/bin/configcheck.sh        |   3 +-
+ .../testing/selftests/rcutorture/bin/configinit.sh |   3 +-
+ .../testing/selftests/rcutorture/bin/kvm-again.sh  |  49 +-
+ .../selftests/rcutorture/bin/kvm-assign-cpus.sh    |   3 +-
+ .../testing/selftests/rcutorture/bin/kvm-build.sh  |   3 +-
+ .../selftests/rcutorture/bin/kvm-end-run-stats.sh  |   3 +-
+ .../selftests/rcutorture/bin/kvm-recheck.sh        |   2 +-
+ .../testing/selftests/rcutorture/bin/kvm-remote.sh |  13 +-
+ .../rcutorture/bin/kvm-test-1-run-batch.sh         |   3 +-
+ .../rcutorture/bin/kvm-test-1-run-qemu.sh          |   5 +-
+ .../selftests/rcutorture/bin/kvm-test-1-run.sh     |   3 +-
+ .../selftests/rcutorture/bin/kvm-transform.sh      |  68 ++-
+ tools/testing/selftests/rcutorture/bin/kvm.sh      |   3 +-
+ .../selftests/rcutorture/bin/parse-build.sh        |   3 +-
+ tools/testing/selftests/rcutorture/bin/torture.sh  | 145 +++++-
+ 99 files changed, 2984 insertions(+), 1180 deletions(-)
+ delete mode 100644 Documentation/RCU/arrayRCU.rst
+ create mode 100644 Documentation/litmus-tests/locking/DCL-broken.litmus
+ create mode 100644 Documentation/litmus-tests/locking/DCL-fixed.litmus
+ create mode 100644 Documentation/litmus-tests/locking/RM-broken.litmus
+ create mode 100644 Documentation/litmus-tests/locking/RM-fixed.litmus
+ create mode 100644 tools/memory-model/Documentation/locking.txt
+ create mode 100755 tools/memory-model/scripts/checktheselitmus.sh
+ create mode 100755 tools/memory-model/scripts/hwfnseg.sh
+ create mode 100755 tools/memory-model/scripts/runlitmus.sh
+ create mode 100755 tools/memory-model/scripts/simpletest.sh
+Merging kvm/next (f4298cac2bfc Merge tag 'kvmarm-fixes-6.1-3' of git://git=
.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kv=
m/kvm.git kvm/next
+Already up to date.
+Merging kvm-arm/next (b302ca52ba82 Merge branch kvm-arm64/misc-6.1 into kv=
marm-master/next)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/kvmarm/kvmarm.git kvm-arm/next
+Already up to date.
+Merging kvms390/next (58635d6615f1 s390/mm: fix virtual-physical address c=
onfusion for swiotlb)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/kvms390/linux.git kvms390/next
+Auto-merging arch/s390/kvm/kvm-s390.c
+Auto-merging arch/s390/kvm/kvm-s390.h
+Auto-merging arch/s390/mm/init.c
+CONFLICT (content): Merge conflict in arch/s390/mm/init.c
+Resolved 'arch/s390/mm/init.c' using previous resolution.
+Automatic merge failed; fix conflicts and then commit the result.
+$ git commit --no-edit -v -a
+[master aeafbd499732] Merge branch 'next' of git://git.kernel.org/pub/scm/=
linux/kernel/git/kvms390/linux.git
+$ git diff -M --stat --summary HEAD^..
+ arch/s390/include/asm/kvm_host.h    |  12 ++-
+ arch/s390/include/asm/mem_encrypt.h |   4 +-
+ arch/s390/include/asm/stacktrace.h  |   1 +
+ arch/s390/kernel/asm-offsets.c      |   1 +
+ arch/s390/kernel/entry.S            |  26 ++++---
+ arch/s390/kvm/intercept.c           |   9 +--
+ arch/s390/kvm/kvm-s390.c            |  53 +++++++------
+ arch/s390/kvm/kvm-s390.h            |   5 +-
+ arch/s390/kvm/priv.c                |   3 +-
+ arch/s390/kvm/pv.c                  |  17 +++--
+ arch/s390/kvm/vsie.c                |   4 +-
+ arch/s390/mm/gmap.c                 | 147 +++++++++++++++++++------------=
-----
+ arch/s390/mm/init.c                 |  12 +--
+ 13 files changed, 160 insertions(+), 134 deletions(-)
+Merging xen-tip/linux-next (4bff677b3015 x86/xen: simplify sysenter and sy=
scall setup)
+$ git merge -m Merge branch 'linux-next' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/xen/tip.git xen-tip/linux-next
+Already up to date.
+Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/dennis/percpu.git percpu/for-next
+Merge made by the 'ort' strategy.
+ include/linux/percpu.h |  7 +++----
+ mm/percpu.c            | 44 ++++++++++++++++++--------------------------
+ 2 files changed, 21 insertions(+), 30 deletions(-)
+Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wo=
rk dependency in cancel_work_sync())
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/tj/wq.git workqueues/for-next
+Already up to date.
+Merging drivers-x86/for-next (309e0a6ed6e3 platform/x86: dell-ddv: Warn if=
 ePPID has a suspicious length)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/pdx86/platform-drivers-x86.git drivers-x86/for-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ Documentation/ABI/testing/debugfs-dell-wmi-ddv     |  21 ++
+ .../ABI/testing/sysfs-platform-dell-wmi-ddv        |   7 +
+ MAINTAINERS                                        |  11 +-
+ drivers/acpi/battery.c                             |   8 +-
+ drivers/platform/mellanox/mlxbf-tmfifo-regs.h      |  10 +
+ drivers/platform/mellanox/mlxbf-tmfifo.c           |  86 +++--
+ drivers/platform/x86/Kconfig                       |  43 +--
+ drivers/platform/x86/Makefile                      |   4 +-
+ drivers/platform/x86/amd/pmf/cnqf.c                |  92 ++---
+ drivers/platform/x86/asus-wmi.c                    |   4 +-
+ drivers/platform/x86/dell/Kconfig                  |  13 +
+ drivers/platform/x86/dell/Makefile                 |   1 +
+ drivers/platform/x86/dell/dell-wmi-ddv.c           | 375 ++++++++++++++++=
+++++
+ drivers/platform/x86/hp/Kconfig                    |  63 ++++
+ drivers/platform/x86/hp/Makefile                   |  10 +
+ drivers/platform/x86/{ =3D> hp}/hp-wmi.c             |   0
+ drivers/platform/x86/{ =3D> hp}/hp_accel.c           |   2 +-
+ drivers/platform/x86/{ =3D> hp}/tc1100-wmi.c         |   0
+ drivers/platform/x86/huawei-wmi.c                  |  51 +--
+ drivers/platform/x86/intel/pmc/core.h              |   2 +-
+ .../x86/intel/speed_select_if/isst_if_common.c     |   2 +-
+ drivers/platform/x86/lg-laptop.c                   |   4 +-
+ drivers/platform/x86/system76_acpi.c               |   4 +-
+ drivers/platform/x86/thinkpad_acpi.c               |  63 ++--
+ drivers/platform/x86/toshiba_acpi.c                |   4 +-
+ drivers/platform/x86/wmi.c                         |   1 +
+ include/acpi/battery.h                             |   4 +-
+ 27 files changed, 698 insertions(+), 187 deletions(-)
+ create mode 100644 Documentation/ABI/testing/debugfs-dell-wmi-ddv
+ create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
+ create mode 100644 drivers/platform/x86/dell/dell-wmi-ddv.c
+ create mode 100644 drivers/platform/x86/hp/Kconfig
+ create mode 100644 drivers/platform/x86/hp/Makefile
+ rename drivers/platform/x86/{ =3D> hp}/hp-wmi.c (100%)
+ rename drivers/platform/x86/{ =3D> hp}/hp_accel.c (99%)
+ rename drivers/platform/x86/{ =3D> hp}/tc1100-wmi.c (100%)
+Merging chrome-platform/for-next (015e4b05c377 platform/chrome: cros_ec_sp=
i: Set PROBE_PREFER_ASYNCHRONOUS)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/chrome-platform/linux.git chrome-platform/for-next
+Auto-merging Documentation/devicetree/bindings/sound/google,cros-ec-codec.=
yaml
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ .../bindings/chrome/google,cros-ec-typec.yaml      |   1 +
+ .../chrome/google,cros-kbd-led-backlight.yaml      |   1 +
+ .../bindings/extcon/extcon-usbc-cros-ec.yaml       |   1 +
+ .../bindings/i2c/google,cros-ec-i2c-tunnel.yaml    |   1 +
+ .../devicetree/bindings/mfd/google,cros-ec.yaml    | 103 +++++++++++--
+ .../bindings/pwm/google,cros-ec-pwm.yaml           |   1 +
+ .../regulator/google,cros-ec-regulator.yaml        |   1 +
+ .../bindings/sound/google,cros-ec-codec.yaml       |   1 +
+ MAINTAINERS                                        |   6 +
+ drivers/platform/chrome/Kconfig                    |  10 ++
+ drivers/platform/chrome/Makefile                   |   1 +
+ drivers/platform/chrome/cros_ec_debugfs.c          |   1 +
+ drivers/platform/chrome/cros_ec_lightbar.c         |   4 +-
+ drivers/platform/chrome/cros_ec_lpc.c              |  10 +-
+ drivers/platform/chrome/cros_ec_lpc_mec.c          |   6 -
+ drivers/platform/chrome/cros_ec_lpc_mec.h          |   7 -
+ drivers/platform/chrome/cros_ec_spi.c              |   1 +
+ drivers/platform/chrome/cros_hps_i2c.c             | 160 ++++++++++++++++=
+++++
+ drivers/platform/chrome/wilco_ec/core.c            |   5 -
+ 19 files changed, 283 insertions(+), 38 deletions(-)
+ create mode 100644 drivers/platform/chrome/cros_hps_i2c.c
+Merging hsi/for-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/sre/linux-hsi.git hsi/for-next
+Already up to date.
+Merging leds/for-next (5f52a8ba7e91 dt-bindings: leds: Add 'cpuX' to 'linu=
x,default-trigger')
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/pavel/linux-leds.git leds/for-next
+Merge made by the 'ort' strategy.
+ Documentation/devicetree/bindings/leds/common.yaml |  1 +
+ drivers/leds/leds-lp55xx-common.c                  |  3 +--
+ drivers/leds/leds-max8997.c                        |  7 +------
+ drivers/leds/leds-pca955x.c                        |  6 ------
+ drivers/leds/rgb/leds-qcom-lpg.c                   | 18 +++++++++++-------
+ 5 files changed, 14 insertions(+), 21 deletions(-)
+Merging ipmi/for-next (0eb1762f3c77 ipmi/watchdog: Include <linux/kstrtox.=
h> when appropriate)
+$ git merge -m Merge branch 'for-next' of git://github.com/cminyard/linux-=
ipmi.git ipmi/for-next
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/ipmi/ssif-bmc.yaml         |  38 +
+ drivers/char/ipmi/Kconfig                          |  10 +
+ drivers/char/ipmi/Makefile                         |   1 +
+ drivers/char/ipmi/ipmi_kcs_sm.c                    |  16 +-
+ drivers/char/ipmi/ipmi_msghandler.c                |  10 +-
+ drivers/char/ipmi/ipmi_si_intf.c                   |  27 +-
+ drivers/char/ipmi/ipmi_ssif.c                      |   2 +-
+ drivers/char/ipmi/ipmi_watchdog.c                  |   1 +
+ drivers/char/ipmi/kcs_bmc_aspeed.c                 |  24 +-
+ drivers/char/ipmi/ssif_bmc.c                       | 873 ++++++++++++++++=
+++++
+ include/uapi/linux/ipmi_ssif_bmc.h                 |  18 +
+ 11 files changed, 1000 insertions(+), 20 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
+ create mode 100644 drivers/char/ipmi/ssif_bmc.c
+ create mode 100644 include/uapi/linux/ipmi_ssif_bmc.h
+Merging driver-core/driver-core-next (1662cea4623f kset: fix memory leak w=
hen kset_register() returns error)
+$ git merge -m Merge branch 'driver-core-next' of git://git.kernel.org/pub=
/scm/linux/kernel/git/gregkh/driver-core.git driver-core/driver-core-next
+Auto-merging drivers/base/property.c
+Merge made by the 'ort' strategy.
+ drivers/base/property.c         | 29 +++++++++++++--------
+ drivers/hid/usbhid/hiddev.c     |  2 +-
+ drivers/usb/class/usblp.c       |  2 +-
+ drivers/usb/misc/iowarrior.c    |  2 +-
+ drivers/usb/misc/legousbtower.c |  2 +-
+ drivers/usb/roles/class.c       |  2 +-
+ drivers/usb/typec/mux.c         |  8 +++---
+ drivers/usb/typec/retimer.c     |  2 +-
+ fs/kernfs/dir.c                 | 24 ++++++++++++-----
+ fs/kernfs/inode.c               |  4 ---
+ include/linux/container_of.h    | 17 +-----------
+ include/linux/device.h          | 18 ++++++++++++-
+ include/linux/kobject.h         |  4 +--
+ include/linux/property.h        | 34 +++++++++++++-----------
+ include/linux/usb.h             | 57 ++++++++++++++++++++++++++++++++++++=
++---
+ lib/kobject.c                   | 19 +++++++++-----
+ 16 files changed, 150 insertions(+), 76 deletions(-)
+Merging usb/usb-next (a8bc8cc193c6 usb: gadget: Use kstrtobool() instead o=
f strtobool())
+$ git merge -m Merge branch 'usb-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/gregkh/usb.git usb/usb-next
+Auto-merging drivers/usb/typec/retimer.c
+Merge made by the 'ort' strategy.
+ .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |    3 +
+ Documentation/devicetree/bindings/usb/dwc2.yaml    |    3 +
+ drivers/usb/cdns3/cdnsp-pci.c                      |    8 +-
+ drivers/usb/chipidea/ci.h                          |    4 +
+ drivers/usb/chipidea/ci_hdrc_imx.c                 |   49 +-
+ drivers/usb/chipidea/ci_hdrc_imx.h                 |    4 +-
+ drivers/usb/chipidea/core.c                        |  143 +-
+ drivers/usb/chipidea/host.c                        |   16 +
+ drivers/usb/chipidea/otg.c                         |    2 +-
+ drivers/usb/chipidea/otg.h                         |    1 +
+ drivers/usb/chipidea/udc.c                         |   32 +
+ drivers/usb/chipidea/usbmisc_imx.c                 |  160 +-
+ drivers/usb/core/config.c                          |   82 +-
+ drivers/usb/core/port.c                            |    3 +-
+ drivers/usb/core/sysfs.c                           |    7 +-
+ drivers/usb/dwc2/platform.c                        |    2 +-
+ drivers/usb/gadget/configfs.c                      |    3 +-
+ drivers/usb/gadget/function/f_mass_storage.c       |    3 +-
+ drivers/usb/gadget/function/f_uvc.c                |   15 +-
+ drivers/usb/gadget/function/storage_common.c       |    9 +-
+ drivers/usb/gadget/function/u_serial.c             |    3 +-
+ drivers/usb/gadget/legacy/serial.c                 |    3 +-
+ drivers/usb/host/Kconfig                           |    2 +-
+ drivers/usb/misc/ftdi-elan.c                       |    2 -
+ drivers/usb/musb/Kconfig                           |   12 -
+ drivers/usb/musb/Makefile                          |    2 -
+ drivers/usb/musb/cppi_dma.c                        | 1547 ---------------=
-----
+ drivers/usb/musb/davinci.c                         |  606 --------
+ drivers/usb/musb/davinci.h                         |  103 --
+ drivers/usb/phy/phy-generic.c                      |   14 +-
+ drivers/usb/typec/retimer.c                        |   16 +-
+ drivers/usb/typec/retimer.h                        |    4 +
+ drivers/usb/usbip/stub_dev.c                       |    4 +-
+ drivers/usb/usbip/vudc_sysfs.c                     |    2 +-
+ include/uapi/linux/usb/g_uvc.h                     |    3 +
+ 35 files changed, 391 insertions(+), 2481 deletions(-)
+ delete mode 100644 drivers/usb/musb/cppi_dma.c
+ delete mode 100644 drivers/usb/musb/davinci.c
+ delete mode 100644 drivers/usb/musb/davinci.h
+Merging thunderbolt/next (a5cfc9d65879 thunderbolt: Add wake on connect/di=
sconnect on USB4 ports)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/westeri/thunderbolt.git thunderbolt/next
+Merge made by the 'ort' strategy.
+ drivers/thunderbolt/acpi.c      | 12 ++++--------
+ drivers/thunderbolt/switch.c    |  5 +++--
+ drivers/thunderbolt/tb_regs.h   |  2 ++
+ drivers/thunderbolt/usb4.c      | 33 +++++++++++++++++++++++++--------
+ drivers/thunderbolt/usb4_port.c |  3 +++
+ drivers/thunderbolt/xdomain.c   |  4 ++--
+ 6 files changed, 39 insertions(+), 20 deletions(-)
+Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/balbi/usb.git usb-gadget/next
+Already up to date.
+Merging usb-serial/usb-next (247f34f7b803 Linux 6.1-rc2)
+$ git merge -m Merge branch 'usb-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/johan/usb-serial.git usb-serial/usb-next
+Already up to date.
+Merging tty/tty-next (5c30f3e4a6e6 tty: Move TIOCSTI toggle variable befor=
e kerndoc)
+$ git merge -m Merge branch 'tty-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/gregkh/tty.git tty/tty-next
+Auto-merging drivers/tty/serial/8250/8250_omap.c
+Auto-merging drivers/tty/serial/fsl_lpuart.c
+Auto-merging drivers/tty/serial/imx.c
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/serial/ingenic,uart.yaml   |  4 +
+ .../devicetree/bindings/serial/renesas,scif.yaml   |  1 +
+ Documentation/driver-api/serial/driver.rst         |  3 +
+ Documentation/driver-api/serial/serial-rs485.rst   | 56 +++++++-------
+ drivers/tty/Kconfig                                | 19 +++++
+ drivers/tty/ehv_bytechan.c                         |  4 +-
+ drivers/tty/hvc/hvc_rtas.c                         |  2 +-
+ drivers/tty/serial/21285.c                         | 32 ++------
+ drivers/tty/serial/8250/8250_bcm7271.c             |  4 +-
+ drivers/tty/serial/8250/8250_core.c                |  5 +-
+ drivers/tty/serial/8250/8250_ingenic.c             | 32 +++++++-
+ drivers/tty/serial/8250/8250_omap.c                | 85 +++++++++++++++++=
++++-
+ drivers/tty/serial/8250/8250_port.c                |  3 +-
+ drivers/tty/serial/Kconfig                         |  2 +
+ drivers/tty/serial/altera_jtaguart.c               | 36 ++-------
+ drivers/tty/serial/altera_uart.c                   | 29 ++------
+ drivers/tty/serial/amba-pl010.c                    | 32 ++------
+ drivers/tty/serial/amba-pl011.c                    |  3 +-
+ drivers/tty/serial/apbuart.c                       | 34 ++-------
+ drivers/tty/serial/ar933x_uart.c                   |  3 +-
+ drivers/tty/serial/arc_uart.c                      |  3 +-
+ drivers/tty/serial/atmel_serial.c                  | 39 ++--------
+ drivers/tty/serial/bcm63xx_uart.c                  | 47 +++---------
+ drivers/tty/serial/clps711x.c                      |  3 +-
+ drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  3 +-
+ drivers/tty/serial/digicolor-usart.c               |  3 +-
+ drivers/tty/serial/dz.c                            |  3 +-
+ drivers/tty/serial/fsl_linflexuart.c               |  3 +-
+ drivers/tty/serial/fsl_lpuart.c                    | 37 ++--------
+ drivers/tty/serial/imx.c                           | 71 +++++++++++++++---
+ drivers/tty/serial/ip22zilog.c                     |  6 +-
+ drivers/tty/serial/lantiq.c                        | 36 +--------
+ drivers/tty/serial/liteuart.c                      |  3 +-
+ drivers/tty/serial/lpc32xx_hs.c                    | 33 +--------
+ drivers/tty/serial/max3100.c                       |  4 +-
+ drivers/tty/serial/max310x.c                       |  5 +-
+ drivers/tty/serial/mcf.c                           | 34 ++-------
+ drivers/tty/serial/men_z135_uart.c                 |  5 +-
+ drivers/tty/serial/meson_uart.c                    |  3 +-
+ drivers/tty/serial/milbeaut_usio.c                 |  3 +-
+ drivers/tty/serial/mpc52xx_uart.c                  | 39 +---------
+ drivers/tty/serial/mps2-uart.c                     | 26 +------
+ drivers/tty/serial/msm_serial.c                    | 11 +--
+ drivers/tty/serial/mux.c                           | 45 ++++--------
+ drivers/tty/serial/mvebu-uart.c                    | 41 ++---------
+ drivers/tty/serial/mxs-auart.c                     | 32 ++------
+ drivers/tty/serial/omap-serial.c                   | 32 ++------
+ drivers/tty/serial/owl-uart.c                      | 32 +-------
+ drivers/tty/serial/pch_uart.c                      | 12 +--
+ drivers/tty/serial/pic32_uart.c                    |  3 +-
+ drivers/tty/serial/pmac_zilog.c                    |  6 +-
+ drivers/tty/serial/pxa.c                           | 33 ++-------
+ drivers/tty/serial/qcom_geni_serial.c              | 35 +++++++++
+ drivers/tty/serial/rda-uart.c                      |  3 +-
+ drivers/tty/serial/rp2.c                           | 31 ++------
+ drivers/tty/serial/sa1100.c                        | 34 +--------
+ drivers/tty/serial/samsung_tty.c                   | 10 +--
+ drivers/tty/serial/sb1250-duart.c                  |  3 +-
+ drivers/tty/serial/sc16is7xx.c                     |  5 +-
+ drivers/tty/serial/sccnxp.c                        |  3 +-
+ drivers/tty/serial/serial-tegra.c                  |  9 ++-
+ drivers/tty/serial/serial_txx9.c                   | 32 ++------
+ drivers/tty/serial/sh-sci.c                        |  5 +-
+ drivers/tty/serial/sifive.c                        | 31 ++------
+ drivers/tty/serial/sprd_serial.c                   | 40 ++--------
+ drivers/tty/serial/st-asc.c                        | 48 ++----------
+ drivers/tty/serial/stm32-usart.c                   |  7 +-
+ drivers/tty/serial/sunhv.c                         |  6 +-
+ drivers/tty/serial/sunplus-uart.c                  |  4 +-
+ drivers/tty/serial/sunsab.c                        |  6 +-
+ drivers/tty/serial/sunsu.c                         |  3 +-
+ drivers/tty/serial/sunzilog.c                      |  6 +-
+ drivers/tty/serial/timbuart.c                      |  3 +-
+ drivers/tty/serial/uartlite.c                      |  3 +-
+ drivers/tty/serial/ucc_uart.c                      |  3 +-
+ drivers/tty/serial/vt8500_serial.c                 | 30 +-------
+ drivers/tty/serial/xilinx_uartps.c                 |  4 +-
+ drivers/tty/serial/zs.c                            |  3 +-
+ drivers/tty/tty.h                                  |  2 +-
+ drivers/tty/tty_buffer.c                           |  4 +-
+ drivers/tty/tty_io.c                               | 45 +++++++++++-
+ drivers/tty/tty_ldisc.c                            | 38 +---------
+ include/linux/serial_core.h                        | 80 +++++++++++++++++=
+++
+ include/uapi/linux/serial.h                        | 55 +++++++++-----
+ 84 files changed, 643 insertions(+), 993 deletions(-)
+Merging char-misc/char-misc-next (30a0b95b1335 Linux 6.1-rc3)
+$ git merge -m Merge branch 'char-misc-next' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/gregkh/char-misc.git char-misc/char-misc-next
+Already up to date.
+Merging coresight/next (3c728e079d83 coresight: etm4x: add CPU hotplug sup=
port for probing)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/coresight/linux.git coresight/next
+Merge made by the 'ort' strategy.
+ drivers/hwtracing/coresight/coresight-etm4x-core.c | 153 +++++++++++++++-=
-----
+ 1 file changed, 113 insertions(+), 40 deletions(-)
+Merging fpga/for-next (ee31d5038c06 dt-bindings: fpga: document Lattice sy=
sCONFIG FPGA manager)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/fpga/linux-fpga.git fpga/for-next
+Merge made by the 'ort' strategy.
+ .../bindings/fpga/lattice,sysconfig.yaml           |  81 +++++
+ drivers/fpga/Kconfig                               |  11 +
+ drivers/fpga/Makefile                              |   2 +
+ drivers/fpga/lattice-sysconfig-spi.c               | 152 ++++++++
+ drivers/fpga/lattice-sysconfig.c                   | 397 ++++++++++++++++=
+++++
+ drivers/fpga/lattice-sysconfig.h                   |  39 ++
+ drivers/fpga/zynq-fpga.c                           |   8 +-
+ 7 files changed, 685 insertions(+), 5 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconf=
ig.yaml
+ create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
+ create mode 100644 drivers/fpga/lattice-sysconfig.c
+ create mode 100644 drivers/fpga/lattice-sysconfig.h
+Merging icc/icc-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'icc-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/djakov/icc.git icc/icc-next
+Already up to date.
+Merging iio/togreg (b8bee0f98634 MAINTAINERS: Add KX022A maintainer entry)
+$ git merge -m Merge branch 'togreg' of git://git.kernel.org/pub/scm/linux=
/kernel/git/jic23/iio.git iio/togreg
+Auto-merging Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/ii=
o/addac/adi,ad74413r.yaml
+Auto-merging MAINTAINERS
+Auto-merging drivers/iio/accel/bma400_core.c
+Auto-merging drivers/iio/trigger/iio-trig-sysfs.c
+Resolved 'Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml' u=
sing previous resolution.
+Automatic merge failed; fix conflicts and then commit the result.
+$ git commit --no-edit -v -a
+[master 35f91ea67e4c] Merge branch 'togreg' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/jic23/iio.git
+$ git diff -M --stat --summary HEAD^..
+ Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 |   36 +
+ .../ABI/testing/sysfs-bus-iio-adc-max11410         |   13 +
+ .../bindings/iio/accel/kionix,kx022a.yaml          |   65 +
+ .../devicetree/bindings/iio/adc/adi,ad4130.yaml    |  259 +++
+ .../devicetree/bindings/iio/adc/adi,max11410.yaml  |  177 ++
+ .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   68 +-
+ .../bindings/iio/addac/adi,ad74413r.yaml           |   11 +-
+ .../devicetree/bindings/iio/dac/adi,ad5766.yaml    |    2 +-
+ .../bindings/iio/frequency/adi,adf4350.yaml        |    7 +-
+ .../bindings/iio/frequency/adi,admv1013.yaml       |    5 +-
+ .../bindings/iio/frequency/adi,admv1014.yaml       |    5 +-
+ .../bindings/iio/frequency/adi,admv4420.yaml       |    8 +-
+ .../bindings/iio/frequency/adi,adrf6780.yaml       |    5 +-
+ .../bindings/iio/gyroscope/adi,adxrs290.yaml       |    5 +-
+ .../bindings/iio/gyroscope/nxp,fxas21002c.yaml     |    5 +-
+ .../devicetree/bindings/iio/imu/adi,adis16475.yaml |    3 +-
+ .../bindings/iio/pressure/meas,ms5611.yaml         |    6 +-
+ .../bindings/iio/pressure/murata,zpa2326.yaml      |    5 +-
+ .../bindings/iio/proximity/ams,as3935.yaml         |    5 +-
+ .../bindings/iio/resolver/adi,ad2s90.yaml          |    7 +-
+ MAINTAINERS                                        |   15 +
+ drivers/iio/TODO                                   |    3 -
+ drivers/iio/accel/Kconfig                          |   21 +
+ drivers/iio/accel/Makefile                         |    3 +
+ drivers/iio/accel/adxl367.c                        |   28 +-
+ drivers/iio/accel/adxl367_i2c.c                    |    5 +-
+ drivers/iio/accel/bma400_core.c                    |   10 +-
+ drivers/iio/accel/da311.c                          |    5 +-
+ drivers/iio/accel/dmard06.c                        |    5 +-
+ drivers/iio/accel/dmard09.c                        |    5 +-
+ drivers/iio/accel/dmard10.c                        |    5 +-
+ drivers/iio/accel/fxls8962af-core.c                |   40 +-
+ drivers/iio/accel/fxls8962af-i2c.c                 |    2 +-
+ drivers/iio/accel/fxls8962af-spi.c                 |    2 +-
+ drivers/iio/accel/kionix-kx022a-i2c.c              |   51 +
+ drivers/iio/accel/kionix-kx022a-spi.c              |   58 +
+ drivers/iio/accel/kionix-kx022a.c                  | 1142 +++++++++++
+ drivers/iio/accel/kionix-kx022a.h                  |   82 +
+ drivers/iio/accel/kxcjk-1013.c                     |   25 +-
+ drivers/iio/accel/kxsd9-i2c.c                      |    5 +-
+ drivers/iio/accel/mc3230.c                         |    5 +-
+ drivers/iio/accel/mma7660.c                        |    5 +-
+ drivers/iio/accel/msa311.c                         |   21 +-
+ drivers/iio/accel/mxc4005.c                        |    5 +-
+ drivers/iio/accel/mxc6255.c                        |    5 +-
+ drivers/iio/accel/sca3300.c                        |   12 +-
+ drivers/iio/accel/stk8312.c                        |    5 +-
+ drivers/iio/accel/stk8ba50.c                       |    5 +-
+ drivers/iio/adc/Kconfig                            |   39 +
+ drivers/iio/adc/Makefile                           |    3 +
+ drivers/iio/adc/ad4130.c                           | 2100 +++++++++++++++=
+++++
+ drivers/iio/adc/ad7124.c                           |   10 +
+ drivers/iio/adc/ad7192.c                           |   27 +-
+ drivers/iio/adc/ad7476.c                           |   11 +-
+ drivers/iio/adc/ad7606.c                           |   22 +-
+ drivers/iio/adc/ad7606.h                           |    2 -
+ drivers/iio/adc/ad799x.c                           |   20 +-
+ drivers/iio/adc/ad9467.c                           |   11 +
+ drivers/iio/adc/ad_sigma_delta.c                   |    8 +-
+ drivers/iio/adc/axp288_adc.c                       |    9 +-
+ drivers/iio/adc/imx7d_adc.c                        |   14 +-
+ drivers/iio/adc/lpc32xx_adc.c                      |   11 +-
+ drivers/iio/adc/ltc2497-core.c                     |    7 +-
+ drivers/iio/adc/ltc2497.h                          |    2 +
+ drivers/iio/adc/max11410.c                         | 1050 ++++++++++
+ drivers/iio/adc/max1241.c                          |   28 +-
+ drivers/iio/adc/max1363.c                          |   12 +-
+ drivers/iio/adc/mcp3911.c                          |  104 +-
+ drivers/iio/adc/meson_saradc.c                     |   11 +-
+ drivers/iio/adc/mt6370-adc.c                       |  305 +++
+ drivers/iio/adc/rockchip_saradc.c                  |   15 +-
+ drivers/iio/adc/sc27xx_adc.c                       |   14 +-
+ drivers/iio/adc/stm32-adc-core.c                   |   30 +-
+ drivers/iio/adc/stm32-adc-core.h                   |   30 +
+ drivers/iio/adc/stm32-adc.c                        |  236 ++-
+ drivers/iio/adc/ti-ads131e08.c                     |   11 +
+ drivers/iio/adc/vf610_adc.c                        |  104 +-
+ drivers/iio/amplifiers/hmc425a.c                   |   17 +-
+ drivers/iio/cdc/ad7150.c                           |   18 +-
+ drivers/iio/common/scmi_sensors/scmi_iio.c         |    9 +-
+ drivers/iio/common/st_sensors/st_sensors_core.c    |   39 +-
+ drivers/iio/dac/ltc2688.c                          |   23 +-
+ drivers/iio/filter/admv8818.c                      |    4 +-
+ drivers/iio/frequency/ad9523.c                     |   22 +-
+ drivers/iio/gyro/bmg160_core.c                     |   24 +-
+ drivers/iio/gyro/fxas21002c_core.c                 |   21 +-
+ drivers/iio/gyro/fxas21002c_i2c.c                  |    3 +-
+ drivers/iio/gyro/fxas21002c_spi.c                  |    3 +-
+ drivers/iio/gyro/itg3200_core.c                    |   10 +-
+ drivers/iio/health/max30100.c                      |   15 +-
+ drivers/iio/health/max30102.c                      |   19 +-
+ drivers/iio/humidity/hts221.h                      |    2 -
+ drivers/iio/humidity/hts221_core.c                 |   27 +-
+ drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   21 +-
+ drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    3 +-
+ drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |    3 +-
+ drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   17 +-
+ drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    3 +-
+ drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    3 +-
+ drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   13 +-
+ drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   14 +-
+ drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   44 +-
+ drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |   65 +-
+ drivers/iio/industrialio-buffer.c                  |   29 +-
+ drivers/iio/industrialio-core.c                    |   58 +-
+ drivers/iio/industrialio-event.c                   |    4 +-
+ drivers/iio/industrialio-trigger.c                 |   12 +-
+ drivers/iio/light/ltr501.c                         |   27 +-
+ drivers/iio/light/noa1305.c                        |   26 +-
+ drivers/iio/light/vcnl4000.c                       |  185 +-
+ drivers/iio/light/vl6180.c                         |    5 +-
+ drivers/iio/magnetometer/st_magn_i2c.c             |    5 +-
+ drivers/iio/multiplexer/iio-mux.c                  |    8 +-
+ drivers/iio/pressure/mpl115.c                      |   62 +-
+ drivers/iio/pressure/mpl115.h                      |    5 +
+ drivers/iio/pressure/mpl115_i2c.c                  |    1 +
+ drivers/iio/pressure/mpl115_spi.c                  |    1 +
+ drivers/iio/proximity/sx_common.c                  |   23 +-
+ drivers/iio/proximity/sx_common.h                  |    2 -
+ drivers/iio/temperature/mlx90632.c                 |  473 ++++-
+ drivers/iio/trigger/iio-trig-sysfs.c               |   14 +-
+ drivers/staging/iio/frequency/ad9834.c             |    6 +-
+ include/linux/iio/common/st_sensors.h              |    4 -
+ include/linux/iio/gyro/itg3200.h                   |    2 +
+ include/linux/iio/iio-opaque.h                     |    2 +
+ include/linux/iio/iio.h                            |    5 +-
+ 126 files changed, 7006 insertions(+), 913 deletions(-)
+ create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
+ create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
+ create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx0=
22a.yaml
+ create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.y=
aml
+ create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410=
.yaml
+ create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
+ create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
+ create mode 100644 drivers/iio/accel/kionix-kx022a.c
+ create mode 100644 drivers/iio/accel/kionix-kx022a.h
+ create mode 100644 drivers/iio/adc/ad4130.c
+ create mode 100644 drivers/iio/adc/max11410.c
+ create mode 100644 drivers/iio/adc/mt6370-adc.c
+Merging phy-next/next (846d47922453 doc: phy: Document typical order of AP=
I calls)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/phy/linux-phy.git phy-next/next
+Merge made by the 'ort' strategy.
+ .../bindings/phy/allwinner,sun8i-h3-usb-phy.yaml   |  26 +
+ .../devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  16 +-
+ ...-ufs-phy.yaml =3D> qcom,msm8996-qmp-ufs-phy.yaml} |  17 +-
+ ...usb-phy.yaml =3D> qcom,msm8996-qmp-usb3-phy.yaml} |  20 +-
+ .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |  83 +++
+ .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 105 +++
+ .../devicetree/bindings/phy/ti,phy-gmii-sel.yaml   |  48 +-
+ .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |   1 +
+ Documentation/driver-api/phy/phy.rst               |  25 +-
+ drivers/pci/controller/dwc/pcie-qcom-ep.c          |   5 +
+ drivers/pci/controller/dwc/pcie-qcom.c             |   5 +
+ drivers/phy/allwinner/phy-sun4i-usb.c              |  71 +++
+ drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c  |  95 +--
+ drivers/phy/broadcom/phy-brcm-usb-init.c           |  90 +--
+ drivers/phy/broadcom/phy-brcm-usb-init.h           |  11 +-
+ drivers/phy/broadcom/phy-brcm-usb.c                |  32 +-
+ drivers/phy/freescale/phy-fsl-imx8m-pcie.c         | 142 +++--
+ drivers/phy/marvell/phy-mvebu-a3700-comphy.c       |   3 +
+ drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 148 +----
+ drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   | 101 +--
+ drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 683 ++++++++++------=
----
+ drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |   1 +
+ drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 480 ++++++--------
+ drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 707 ++++++++--------=
-----
+ drivers/phy/tegra/phy-tegra194-p2u.c               |  14 +
+ drivers/phy/tegra/xusb-tegra124.c                  |   1 -
+ drivers/phy/tegra/xusb-tegra186.c                  |   1 -
+ drivers/phy/tegra/xusb-tegra210.c                  |   1 -
+ drivers/phy/tegra/xusb.c                           |  10 +-
+ drivers/phy/tegra/xusb.h                           |   2 -
+ drivers/phy/ti/phy-gmii-sel.c                      |  42 +-
+ drivers/phy/ti/phy-j721e-wiz.c                     |  22 +
+ 32 files changed, 1559 insertions(+), 1449 deletions(-)
+ rename Documentation/devicetree/bindings/phy/{qcom,qmp-ufs-phy.yaml =3D> =
qcom,msm8996-qmp-ufs-phy.yaml} (93%)
+ rename Documentation/devicetree/bindings/phy/{qcom,qmp-usb-phy.yaml =3D> =
qcom,msm8996-qmp-usb3-phy.yaml} (95%)
+ create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qm=
p-ufs-phy.yaml
+ create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qm=
p-usb3-uni-phy.yaml
+Merging soundwire/next (cf43cd33b67a soundwire: qcom: add support for v1.7=
 Soundwire Controller)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/vkoul/soundwire.git soundwire/next
+Auto-merging drivers/soundwire/qcom.c
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/soundwire/qcom,sdw.txt     |  1 +
+ drivers/soundwire/dmi-quirks.c                     |  8 +++++++
+ drivers/soundwire/qcom.c                           | 25 +++++++++++++++++=
-----
+ 3 files changed, 29 insertions(+), 5 deletions(-)
+Merging extcon/extcon-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'extcon-next' of git://git.kernel.org/pub/scm/=
linux/kernel/git/chanwoo/extcon.git extcon/extcon-next
+Already up to date.
+Merging gnss/gnss-next (247f34f7b803 Linux 6.1-rc2)
+$ git merge -m Merge branch 'gnss-next' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/johan/gnss.git gnss/gnss-next
+Already up to date.
+Merging vfio/next (b1b8132a651c vfio: More vfio_file_is_group() use cases)
+$ git merge -m Merge branch 'next' of git://github.com/awilliam/linux-vfio=
.git vfio/next
+Already up to date.
+Merging staging/staging-next (a37068715956 staging: r8188eu: convert rtw_s=
etdatarate_cmd to correct error semantics)
+$ git merge -m Merge branch 'staging-next' of git://git.kernel.org/pub/scm=
/linux/kernel/git/gregkh/staging.git staging/staging-next
+Auto-merging drivers/staging/rtl8192e/rtllib_softmac_wx.c
+Merge made by the 'ort' strategy.
+ arch/mips/include/asm/octeon/cvmx.h                |   4 +-
+ drivers/staging/ks7010/TODO                        |   3 +
+ drivers/staging/most/dim2/dim2.c                   |   4 +-
+ drivers/staging/most/dim2/hal.c                    |   4 +-
+ drivers/staging/most/dim2/hal.h                    |   6 +-
+ drivers/staging/octeon/ethernet-tx.c               |   2 -
+ drivers/staging/octeon/octeon-stubs.h              |   2 +-
+ drivers/staging/r8188eu/core/rtw_ap.c              |   7 +-
+ drivers/staging/r8188eu/core/rtw_br_ext.c          | 119 +++---
+ drivers/staging/r8188eu/core/rtw_cmd.c             |  34 +-
+ drivers/staging/r8188eu/core/rtw_ioctl_set.c       |   2 +-
+ drivers/staging/r8188eu/core/rtw_led.c             |  76 +---
+ drivers/staging/r8188eu/core/rtw_mlme.c            |  28 +-
+ drivers/staging/r8188eu/core/rtw_mlme_ext.c        | 442 ++++++++--------=
-----
+ drivers/staging/r8188eu/core/rtw_recv.c            |  11 +-
+ drivers/staging/r8188eu/core/rtw_sta_mgt.c         |  16 +-
+ drivers/staging/r8188eu/core/rtw_xmit.c            |  17 +-
+ drivers/staging/r8188eu/hal/HalPhyRf_8188e.c       |   4 +-
+ drivers/staging/r8188eu/hal/odm_RTL8188E.c         |   6 +-
+ drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    |   2 +-
+ drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      |  16 +-
+ drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c      |  13 +-
+ drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |   3 +-
+ drivers/staging/r8188eu/include/Hal8188EPhyReg.h   |   4 +-
+ drivers/staging/r8188eu/include/drv_types.h        |   1 -
+ drivers/staging/r8188eu/include/odm.h              |   3 +-
+ drivers/staging/r8188eu/include/odm_RTL8188E.h     |   7 +
+ drivers/staging/r8188eu/include/odm_types.h        |  16 -
+ drivers/staging/r8188eu/include/osdep_intf.h       |   4 +-
+ drivers/staging/r8188eu/include/osdep_service.h    |   6 +-
+ drivers/staging/r8188eu/include/rtl8188e_hal.h     |   7 +-
+ drivers/staging/r8188eu/include/rtl8188e_spec.h    |  18 +-
+ drivers/staging/r8188eu/include/rtw_ap.h           |   2 +-
+ drivers/staging/r8188eu/include/rtw_cmd.h          |  71 ++--
+ drivers/staging/r8188eu/include/rtw_io.h           |  16 +-
+ drivers/staging/r8188eu/include/rtw_ioctl_set.h    |   4 +-
+ drivers/staging/r8188eu/include/rtw_led.h          |   3 -
+ drivers/staging/r8188eu/include/rtw_mlme.h         |  22 +-
+ drivers/staging/r8188eu/include/rtw_mlme_ext.h     |  44 +-
+ drivers/staging/r8188eu/include/rtw_recv.h         |   4 +-
+ drivers/staging/r8188eu/include/rtw_xmit.h         |   2 +-
+ drivers/staging/r8188eu/include/sta_info.h         |  18 +-
+ drivers/staging/r8188eu/include/wifi.h             |  66 +--
+ drivers/staging/r8188eu/include/wlan_bssdef.h      |   9 -
+ drivers/staging/r8188eu/os_dep/ioctl_linux.c       |  19 +-
+ drivers/staging/r8188eu/os_dep/os_intfs.c          |  20 +-
+ drivers/staging/rtl8192e/TODO                      |  18 +-
+ drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  11 +-
+ drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |  10 +-
+ drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |  41 +-
+ drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |  20 +-
+ drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |   9 -
+ drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |  53 ++-
+ drivers/staging/rtl8192e/rtl8192e/rtl_dm.h         |  10 +-
+ drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c     |   2 +-
+ drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |  61 +--
+ drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |  48 +--
+ drivers/staging/rtl8192e/rtl819x_BAProc.c          |  20 +-
+ drivers/staging/rtl8192e/rtl819x_HTProc.c          |  38 +-
+ drivers/staging/rtl8192e/rtllib.h                  |   6 -
+ drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |  52 +--
+ drivers/staging/rtl8192e/rtllib_crypt_wep.c        |   8 -
+ drivers/staging/rtl8192e/rtllib_module.c           |   2 +-
+ drivers/staging/rtl8192e/rtllib_softmac.c          |   3 +-
+ drivers/staging/rtl8192e/rtllib_softmac_wx.c       |   3 +-
+ drivers/staging/rtl8192e/rtllib_tx.c               |  42 +-
+ drivers/staging/rtl8192u/TODO                      |  16 +
+ drivers/staging/rtl8192u/ieee80211/ieee80211.h     |   3 -
+ .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c      |   6 -
+ .../staging/rtl8192u/ieee80211/ieee80211_module.c  |   3 -
+ drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  |   2 +-
+ drivers/staging/rtl8712/os_intfs.c                 |  27 +-
+ drivers/staging/rtl8712/recv_osdep.h               |   8 +-
+ drivers/staging/rtl8712/rtl8712_recv.c             |   7 +-
+ drivers/staging/rtl8712/rtl8712_xmit.c             |   3 +-
+ drivers/staging/rtl8712/rtl871x_recv.c             |  16 +-
+ drivers/staging/rtl8723bs/core/rtw_efuse.c         |   2 +-
+ drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |  12 +-
+ drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |  17 +-
+ drivers/staging/rtl8723bs/core/rtw_mlme.c          |  30 +-
+ drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   2 +-
+ drivers/staging/rtl8723bs/core/rtw_recv.c          |   6 +-
+ drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |   2 +-
+ drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   2 +-
+ drivers/staging/rts5208/sd.c                       |   3 +-
+ drivers/staging/sm750fb/Kconfig                    |   2 +-
+ drivers/staging/vt6655/rxtx.c                      |   4 +-
+ drivers/staging/wlan-ng/TODO                       |  16 +
+ drivers/staging/wlan-ng/p80211mgmt.h               | 301 --------------
+ drivers/staging/wlan-ng/p80211netdev.c             |  22 -
+ drivers/staging/wlan-ng/p80211types.h              |   6 -
+ 91 files changed, 732 insertions(+), 1430 deletions(-)
+ delete mode 100644 drivers/staging/r8188eu/include/odm_types.h
+ create mode 100644 drivers/staging/rtl8192u/TODO
+ create mode 100644 drivers/staging/wlan-ng/TODO
+Merging counter-next/counter-next (30a0b95b1335 Linux 6.1-rc3)
+$ git merge -m Merge branch 'counter-next' of git://git.kernel.org/pub/scm=
/linux/kernel/git/wbg/counter.git counter-next/counter-next
+Already up to date.
+Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
+$ git merge -m Merge branch 'for-next' of https://gitlab.com/peda-linux/mu=
x.git mux/for-next
+Already up to date.
+Merging dmaengine/next (4476ca4ca8dc dmaengine: at_hdmac: Convert driver t=
o use virt-dma)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/vkoul/dmaengine.git dmaengine/next
+Auto-merging Documentation/driver-api/driver-model/devres.rst
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ Documentation/ABI/stable/sysfs-driver-dma-idxd     |   12 +
+ .../devicetree/bindings/dma/ingenic,dma.yaml       |    1 +
+ .../devicetree/bindings/dma/qcom,gpi.yaml          |   25 +-
+ Documentation/driver-api/driver-model/devres.rst   |    1 +
+ MAINTAINERS                                        |    6 -
+ drivers/dma/Kconfig                                |   21 +-
+ drivers/dma/Makefile                               |    2 -
+ drivers/dma/apple-admac.c                          |  102 +-
+ drivers/dma/at_hdmac.c                             | 1854 +++++++++++----=
-----
+ drivers/dma/at_hdmac_regs.h                        |  478 -----
+ drivers/dma/dma-jz4780.c                           |    8 +
+ drivers/dma/idma64.c                               |    8 +-
+ drivers/dma/idxd/sysfs.c                           |   68 +
+ drivers/dma/ioat/dma.c                             |    2 +-
+ drivers/dma/iop-adma.c                             | 1554 ----------------
+ drivers/dma/iop-adma.h                             |  914 ----------
+ drivers/dma/qcom/gpi.c                             |    7 +-
+ drivers/dma/s3c24xx-dma.c                          | 1428 ---------------
+ drivers/dma/sh/shdma-arm.h                         |   48 -
+ drivers/dma/ti/Kconfig                             |    7 +-
+ drivers/dma/ti/Makefile                            |   15 +-
+ drivers/dma/ti/k3-psil.c                           |    2 +
+ drivers/dma/ti/k3-udma-glue.c                      |    5 +-
+ drivers/dma/ti/k3-udma.c                           |   40 +-
+ drivers/dma/xilinx/xilinx_dma.c                    |    4 +-
+ drivers/of/irq.c                                   |    1 +
+ include/linux/platform_data/dma-s3c24xx.h          |   48 -
+ 27 files changed, 1230 insertions(+), 5431 deletions(-)
+ delete mode 100644 drivers/dma/at_hdmac_regs.h
+ delete mode 100644 drivers/dma/iop-adma.c
+ delete mode 100644 drivers/dma/iop-adma.h
+ delete mode 100644 drivers/dma/s3c24xx-dma.c
+ delete mode 100644 drivers/dma/sh/shdma-arm.h
+ delete mode 100644 include/linux/platform_data/dma-s3c24xx.h
+Merging cgroup/for-next (79a7f41f7f5a cgroup: cgroup refcnt functions shou=
ld be exported when CONFIG_DEBUG_CGROUP_REF)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/tj/cgroup.git cgroup/for-next
+Auto-merging include/linux/cgroup.h
+Auto-merging kernel/cgroup/cgroup.c
+Auto-merging lib/Kconfig.debug
+Merge made by the 'ort' strategy.
+ include/linux/cgroup.h        | 98 ++++++--------------------------------=
-----
+ include/linux/cgroup_refcnt.h | 96 ++++++++++++++++++++++++++++++++++++++=
++++
+ kernel/cgroup/cgroup.c        |  6 +++
+ lib/Kconfig.debug             | 10 +++++
+ 4 files changed, 125 insertions(+), 85 deletions(-)
+ create mode 100644 include/linux/cgroup_refcnt.h
+Merging scsi/for-next (46c80503f387 Merge branch 'fixes' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/jejb/scsi.git scsi/for-next
+Auto-merging MAINTAINERS
+Auto-merging drivers/scsi/libsas/sas_ata.c
+Auto-merging drivers/scsi/scsi_error.c
+Auto-merging drivers/scsi/scsi_lib.c
+Auto-merging drivers/ufs/core/ufshcd.c
+Auto-merging include/scsi/scsi_proto.h
+Merge made by the 'ort' strategy.
+ Documentation/scsi/scsi_eh.rst            |   7 +-
+ MAINTAINERS                               |   2 +-
+ drivers/message/fusion/mptsas.c           |   8 +-
+ drivers/scsi/esas2r/esas2r_main.c         |  19 +-
+ drivers/scsi/hisi_sas/hisi_sas.h          |   1 +
+ drivers/scsi/hisi_sas/hisi_sas_main.c     |  78 ++-
+ drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  53 +-
+ drivers/scsi/hosts.c                      |   3 +-
+ drivers/scsi/libiscsi.c                   |  26 +-
+ drivers/scsi/libsas/sas_ata.c             |  19 +-
+ drivers/scsi/libsas/sas_expander.c        |  40 +-
+ drivers/scsi/libsas/sas_init.c            |   3 -
+ drivers/scsi/libsas/sas_internal.h        |  21 +
+ drivers/scsi/lpfc/lpfc_attr.c             | 118 ++++
+ drivers/scsi/lpfc/lpfc_crtn.h             |   3 +
+ drivers/scsi/lpfc/lpfc_els.c              | 128 +++++
+ drivers/scsi/lpfc/lpfc_hw4.h              |   5 +-
+ drivers/scsi/lpfc/lpfc_sli.c              |  19 +-
+ drivers/scsi/lpfc/lpfc_version.h          |   2 +-
+ drivers/scsi/megaraid/megaraid_sas_base.c |   7 +-
+ drivers/scsi/mvsas/mv_defs.h              |   1 +
+ drivers/scsi/mvsas/mv_init.c              |  11 +-
+ drivers/scsi/mvsas/mv_sas.c               |  59 +-
+ drivers/scsi/mvsas/mv_sas.h               |   8 +-
+ drivers/scsi/mvumi.c                      |   4 +-
+ drivers/scsi/pcmcia/nsp_cs.c              |   4 +-
+ drivers/scsi/pm8001/pm8001_hwi.c          | 186 +-----
+ drivers/scsi/pm8001/pm8001_init.c         |  14 +-
+ drivers/scsi/pm8001/pm8001_sas.c          |  54 +-
+ drivers/scsi/pm8001/pm8001_sas.h          |  18 +-
+ drivers/scsi/pm8001/pm80xx_hwi.c          | 200 +------
+ drivers/scsi/qedf/qedf_main.c             |   3 -
+ drivers/scsi/qla4xxx/ql4_os.c             |   8 +-
+ drivers/scsi/scsi.c                       |  12 +-
+ drivers/scsi/scsi_error.c                 |  41 +-
+ drivers/scsi/scsi_lib.c                   |  40 +-
+ drivers/scsi/scsi_priv.h                  |   6 +-
+ drivers/scsi/scsi_proc.c                  | 137 ++++-
+ drivers/scsi/scsi_sysfs.c                 |  22 +-
+ drivers/scsi/scsi_transport_fc.c          |   7 +-
+ drivers/scsi/scsi_transport_srp.c         |   8 +-
+ drivers/scsi/storvsc_drv.c                |   4 +-
+ drivers/scsi/virtio_scsi.c                |   4 +-
+ drivers/target/target_core_configfs.c     |  20 +
+ drivers/target/target_core_device.c       |   1 +
+ drivers/target/target_core_sbc.c          |   8 -
+ drivers/target/target_core_spc.c          | 920 +++++++++++++++++++++++++=
+++++
+ drivers/target/target_core_xcopy.c        |   6 +
+ drivers/ufs/core/ufs-sysfs.c              |  21 +-
+ drivers/ufs/core/ufshcd-priv.h            |   6 +-
+ drivers/ufs/core/ufshcd.c                 | 250 ++++----
+ include/scsi/libiscsi.h                   |   2 +-
+ include/scsi/libsas.h                     |  24 +-
+ include/scsi/sas_ata.h                    |   6 +
+ include/scsi/scsi_cmnd.h                  |   3 +-
+ include/scsi/scsi_device.h                |   1 -
+ include/scsi/scsi_host.h                  |  32 +-
+ include/scsi/scsi_proto.h                 |  10 +
+ include/scsi/scsi_transport_fc.h          |   2 +-
+ include/scsi/scsi_transport_srp.h         |   2 +-
+ include/target/target_core_base.h         |  18 +
+ include/ufs/ufshcd.h                      |   5 +-
+ 62 files changed, 1933 insertions(+), 817 deletions(-)
+Merging scsi-mkp/for-next (e56ca6bcd213 scsi: target: Use kstrtobool() ins=
tead of strtobool())
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/mkp/scsi.git scsi-mkp/for-next
+Auto-merging drivers/ufs/core/ufshcd.c
+Merge made by the 'ort' strategy.
+ drivers/message/fusion/mptctl.c              |  2 -
+ drivers/scsi/BusLogic.c                      |  6 +--
+ drivers/scsi/NCR5380.c                       |  2 +-
+ drivers/scsi/bfa/bfad_bsg.c                  | 29 ++++++++++
+ drivers/scsi/bfa/bfad_im.h                   | 26 ---------
+ drivers/scsi/csiostor/csio_wr.c              |  3 +-
+ drivers/scsi/device_handler/scsi_dh_alua.c   | 61 +++++++++++++--------
+ drivers/scsi/elx/libefc/efclib.h             |  6 ++-
+ drivers/scsi/qla2xxx/qla_def.h               | 22 ++++----
+ drivers/scsi/qla2xxx/qla_init.c              | 10 +---
+ drivers/scsi/qla2xxx/qla_inline.h            |  4 +-
+ drivers/scsi/qla2xxx/qla_os.c                |  4 +-
+ drivers/target/target_core_configfs.c        | 29 +++++-----
+ drivers/target/target_core_fabric_configfs.c |  3 +-
+ drivers/target/target_core_spc.c             |  8 +--
+ drivers/ufs/core/ufshcd.c                    | 80 ++++++++++++++++-------=
-----
+ include/ufs/ufshcd.h                         |  6 ---
+ 17 files changed, 155 insertions(+), 146 deletions(-)
+Merging vhost/linux-next (be8ddea9e75e vdpa/ifcvf: add reviewer)
+$ git merge -m Merge branch 'linux-next' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/mst/vhost.git vhost/linux-next
+Already up to date.
+Merging rpmsg/for-next (1b09681fdc30 Merge branches 'rproc-next' and 'hwsp=
inlock-next' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/remoteproc/linux.git rpmsg/for-next
+Merge made by the 'ort' strategy.
+ .../bindings/hwlock/qcom-hwspinlock.yaml           |  29 +-
+ .../bindings/remoteproc/fsl,imx-rproc.yaml         |  16 ++
+ drivers/hwspinlock/qcom_hwspinlock.c               |  42 ++-
+ drivers/remoteproc/imx_dsp_rproc.c                 |  12 +-
+ drivers/remoteproc/imx_rproc.c                     | 294 ++++++++++++++++=
++++-
+ drivers/remoteproc/remoteproc_core.c               |   8 +-
+ 6 files changed, 373 insertions(+), 28 deletions(-)
+Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/linusw/linux-gpio.git gpio/for-next
+Already up to date.
+Merging gpio-brgl/gpio/for-next (80280df758c1 gpio: hisi: Add initial devi=
ce tree support)
+$ git merge -m Merge branch 'gpio/for-next' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/brgl/linux.git gpio-brgl/gpio/for-next
+Auto-merging MAINTAINERS
+Auto-merging arch/arm/Kconfig
+Auto-merging arch/arm64/Kconfig
+Auto-merging arch/x86/Kconfig
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/gpio/gpio-latch.yaml       |  94 +++++
+ .../devicetree/bindings/gpio/gpio-pca9570.yaml     |   1 +
+ .../bindings/gpio/hisilicon,ascend910-gpio.yaml    |  56 +++
+ Documentation/driver-api/gpio/legacy.rst           |   5 -
+ MAINTAINERS                                        |   8 +
+ arch/arm/Kconfig                                   |  21 --
+ arch/arm/include/asm/gpio.h                        |   1 -
+ arch/arm64/Kconfig                                 |  12 -
+ arch/x86/Kconfig                                   |   5 -
+ drivers/gpio/Kconfig                               |  27 +-
+ drivers/gpio/Makefile                              |   3 +-
+ drivers/gpio/TODO                                  |   7 +
+ drivers/gpio/gpio-104-idio-16.c                    |  88 +----
+ drivers/gpio/gpio-aggregator.c                     |   7 +-
+ drivers/gpio/gpio-davinci.c                        |   3 -
+ drivers/gpio/gpio-exar.c                           |   1 +
+ drivers/gpio/gpio-ftgpio010.c                      |   2 +-
+ drivers/gpio/gpio-gw-pld.c                         |   5 +-
+ drivers/gpio/gpio-hisi.c                           |   7 +
+ drivers/gpio/gpio-idio-16.c                        | 146 ++++++++
+ drivers/gpio/gpio-idio-16.h                        |  71 ++++
+ drivers/gpio/gpio-latch.c                          | 219 +++++++++++
+ drivers/gpio/gpio-max7300.c                        |   5 +-
+ drivers/gpio/gpio-pca9570.c                        |  49 ++-
+ drivers/gpio/gpio-pci-idio-16.c                    | 119 +-----
+ drivers/gpio/gpio-sta2x11.c                        | 411 ----------------=
-----
+ drivers/gpio/gpio-tpic2810.c                       |   5 +-
+ drivers/gpio/gpio-ts4900.c                         |   5 +-
+ drivers/gpio/gpiolib-of.c                          | 396 +++++++++++++---=
----
+ drivers/gpio/gpiolib.c                             |  13 +-
+ include/asm-generic/gpio.h                         |  55 ++-
+ 31 files changed, 1003 insertions(+), 844 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/gpio/gpio-latch.yaml
+ create mode 100644 Documentation/devicetree/bindings/gpio/hisilicon,ascen=
d910-gpio.yaml
+ create mode 100644 drivers/gpio/gpio-idio-16.c
+ create mode 100644 drivers/gpio/gpio-idio-16.h
+ create mode 100644 drivers/gpio/gpio-latch.c
+ delete mode 100644 drivers/gpio/gpio-sta2x11.c
+Merging gpio-intel/for-next (8d259847243d gpiolib: cdev: Fix typo in kerne=
l doc for struct line)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/andy/linux-gpio-intel.git gpio-intel/for-next
+Merge made by the 'ort' strategy.
+ drivers/gpio/gpio-merrifield.c | 3 ++-
+ drivers/gpio/gpiolib-acpi.c    | 2 +-
+ drivers/gpio/gpiolib-cdev.c    | 2 +-
+ 3 files changed, 4 insertions(+), 3 deletions(-)
+Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
+$ git merge -m Merge branch 'gpio/gpio-sim' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/brgl/linux.git gpio-sim/gpio/gpio-sim
+Already up to date.
+Merging pinctrl/for-next (ff58d67fd2a9 Merge branch 'devel' into for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/linusw/linux-pinctrl.git pinctrl/for-next
+Auto-merging MAINTAINERS
+Auto-merging drivers/gpio/gpiolib-cdev.c
+Merge made by the 'ort' strategy.
+ .../bindings/pinctrl/loongson,ls2k-pinctrl.yaml    |  125 ++
+ .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |   95 +-
+ .../bindings/pinctrl/mediatek,mt6797-pinctrl.yaml  |  176 ---
+ .../bindings/pinctrl/mediatek,pinctrl-mt6795.yaml  |    7 +-
+ .../bindings/pinctrl/qcom,sdm670-tlmm.yaml         |  127 ++
+ Documentation/driver-api/pin-control.rst           |   10 +-
+ MAINTAINERS                                        |   10 +-
+ drivers/gpio/gpio-arizona.c                        |    5 +-
+ drivers/gpio/gpio-aspeed.c                         |    5 +-
+ drivers/gpio/gpio-da9052.c                         |    9 +-
+ drivers/gpio/gpio-mockup.c                         |    1 +
+ drivers/gpio/gpio-mxc.c                            |   92 +-
+ drivers/gpio/gpio-pca953x.c                        |    3 +-
+ drivers/gpio/gpio-pl061.c                          |   15 +-
+ drivers/gpio/gpio-tegra186.c                       |    3 +-
+ drivers/gpio/gpio-wm8350.c                         |    7 +-
+ drivers/gpio/gpiolib-acpi.h                        |   12 +
+ drivers/gpio/gpiolib-cdev.c                        |    4 +-
+ drivers/gpio/gpiolib-of.h                          |   11 +-
+ drivers/gpio/gpiolib-sysfs.h                       |    2 +
+ .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     |    8 +-
+ drivers/pinctrl/Kconfig                            |   11 +
+ drivers/pinctrl/Makefile                           |    1 +
+ drivers/pinctrl/actions/pinctrl-owl.c              |   49 +-
+ drivers/pinctrl/aspeed/pinctrl-aspeed.c            |    1 +
+ drivers/pinctrl/bcm/pinctrl-bcm281xx.c             |   13 +-
+ drivers/pinctrl/bcm/pinctrl-cygnus-mux.c           |    9 +-
+ drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |   12 +-
+ drivers/pinctrl/bcm/pinctrl-ns2-mux.c              |    8 +-
+ drivers/pinctrl/bcm/pinctrl-nsp-mux.c              |    8 +-
+ drivers/pinctrl/cirrus/pinctrl-lochnagar.c         |    6 +-
+ drivers/pinctrl/cirrus/pinctrl-madera-core.c       |    5 +-
+ drivers/pinctrl/core.c                             |   19 +-
+ drivers/pinctrl/core.h                             |   12 +-
+ drivers/pinctrl/devicetree.h                       |    6 +
+ drivers/pinctrl/freescale/pinctrl-imx.c            |    8 +-
+ drivers/pinctrl/freescale/pinctrl-imx1-core.c      |    4 +-
+ drivers/pinctrl/freescale/pinctrl-mxs.c            |    7 +-
+ drivers/pinctrl/freescale/pinctrl-scu.c            |   30 +
+ drivers/pinctrl/intel/pinctrl-cherryview.c         |    6 +-
+ drivers/pinctrl/intel/pinctrl-intel.c              |    6 +-
+ drivers/pinctrl/intel/pinctrl-lynxpoint.c          |    6 +-
+ drivers/pinctrl/intel/pinctrl-merrifield.c         |    4 +-
+ drivers/pinctrl/mediatek/pinctrl-moore.c           |    3 +
+ drivers/pinctrl/mediatek/pinctrl-mt7986.c          |   32 +-
+ drivers/pinctrl/mediatek/pinctrl-mt8365.c          |   18 +
+ drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |   15 +
+ drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |    8 +-
+ drivers/pinctrl/mediatek/pinctrl-paris.c           |    5 +
+ drivers/pinctrl/mvebu/pinctrl-mvebu.c              |   14 +-
+ drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   11 +-
+ drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          |   16 +-
+ drivers/pinctrl/pinconf.h                          |   10 +
+ drivers/pinctrl/pinctrl-amd.c                      |   10 +-
+ drivers/pinctrl/pinctrl-apple-gpio.c               |    7 +-
+ drivers/pinctrl/pinctrl-at91-pio4.c                |   36 +-
+ drivers/pinctrl/pinctrl-at91.c                     |   16 +-
+ drivers/pinctrl/pinctrl-axp209.c                   |    8 +-
+ drivers/pinctrl/pinctrl-bm1880.c                   |    6 +-
+ drivers/pinctrl/pinctrl-cy8c95x0.c                 |  134 +-
+ drivers/pinctrl/pinctrl-falcon.c                   |    9 +-
+ drivers/pinctrl/pinctrl-gemini.c                   |   12 +-
+ drivers/pinctrl/pinctrl-ingenic.c                  |   10 +-
+ drivers/pinctrl/pinctrl-k210.c                     |   12 +-
+ drivers/pinctrl/pinctrl-lantiq.c                   |    5 +-
+ drivers/pinctrl/pinctrl-lantiq.h                   |    7 +-
+ drivers/pinctrl/pinctrl-loongson2.c                |  329 +++++
+ drivers/pinctrl/pinctrl-lpc18xx.c                  |    6 +-
+ drivers/pinctrl/pinctrl-microchip-sgpio.c          |    4 +-
+ drivers/pinctrl/pinctrl-ocelot.c                   |   30 +-
+ drivers/pinctrl/pinctrl-rockchip.c                 |   40 +
+ drivers/pinctrl/pinctrl-single.c                   |    6 +-
+ drivers/pinctrl/pinctrl-st.c                       |   25 +-
+ drivers/pinctrl/pinctrl-stmfx.c                    |    2 +
+ drivers/pinctrl/pinctrl-utils.h                    |    5 +
+ drivers/pinctrl/pinctrl-zynqmp.c                   |    5 +-
+ drivers/pinctrl/pinmux.c                           |   17 +-
+ drivers/pinctrl/pinmux.h                           |   11 +
+ drivers/pinctrl/qcom/Kconfig                       |   10 +
+ drivers/pinctrl/qcom/Makefile                      |    1 +
+ drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |    4 +
+ drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           |    9 +-
+ drivers/pinctrl/qcom/pinctrl-msm.c                 |   28 +-
+ drivers/pinctrl/qcom/pinctrl-msm.h                 |    5 +
+ drivers/pinctrl/qcom/pinctrl-sc8280xp.c            |    4 +-
+ drivers/pinctrl/qcom/pinctrl-sdm670.c              | 1345 +++++++++++++++=
+++++
+ drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    8 +-
+ drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |    8 +-
+ drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |   18 +-
+ drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c            |   18 +-
+ drivers/pinctrl/renesas/pinctrl-rzg2l.c            |    7 +-
+ drivers/pinctrl/renesas/pinctrl-rzn1.c             |    8 +-
+ drivers/pinctrl/renesas/pinctrl-rzv2m.c            |    4 +-
+ drivers/pinctrl/renesas/pinctrl.c                  |    8 +-
+ drivers/pinctrl/samsung/pinctrl-samsung.c          |   11 +-
+ drivers/pinctrl/spear/pinctrl-spear.c              |    6 +-
+ drivers/pinctrl/sprd/pinctrl-sprd.c                |    7 +-
+ drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c |    3 +
+ drivers/pinctrl/stm32/pinctrl-stm32.c              |   16 +-
+ drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   18 +-
+ drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |    7 +-
+ drivers/pinctrl/tegra/pinctrl-tegra.c              |    6 +-
+ drivers/pinctrl/ti/pinctrl-ti-iodelay.c            |    8 +-
+ drivers/pinctrl/uniphier/pinctrl-uniphier-core.c   |    8 +-
+ include/linux/gpio.h                               |    2 +-
+ include/linux/gpio/aspeed.h                        |    4 +
+ include/linux/gpio/driver.h                        |    2 +-
+ include/linux/gpio/gpio-reg.h                      |    4 +
+ include/linux/gpio/machine.h                       |    1 -
+ include/linux/pinctrl/consumer.h                   |   31 +-
+ include/linux/pinctrl/devinfo.h                    |    6 +-
+ include/linux/pinctrl/machine.h                    |    8 +-
+ include/linux/pinctrl/pinconf-generic.h            |   23 +-
+ include/linux/pinctrl/pinctrl.h                    |   18 +-
+ include/linux/pinctrl/pinmux.h                     |    5 +-
+ 115 files changed, 2935 insertions(+), 586 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2=
k-pinctrl.yaml
+ delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6=
797-pinctrl.yaml
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-=
tlmm.yaml
+ create mode 100644 drivers/pinctrl/pinctrl-loongson2.c
+ create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c
+$ git reset --hard HEAD^
+HEAD is now at 1ccb85e67664 Merge branch 'for-next' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
+Merging next-20221108 version of pinctrl
+$ git merge -m next-20221108/pinctrl bfe66c8bb35c9307bada60f9563c37fff5ca5=
d16
+Auto-merging drivers/gpio/gpiolib-cdev.c
+Merge made by the 'ort' strategy.
+ .../bindings/pinctrl/qcom,sdm670-tlmm.yaml         |  127 ++
+ drivers/gpio/gpio-arizona.c                        |    5 +-
+ drivers/gpio/gpio-aspeed.c                         |    5 +-
+ drivers/gpio/gpio-da9052.c                         |    9 +-
+ drivers/gpio/gpio-mockup.c                         |    1 +
+ drivers/gpio/gpio-pca953x.c                        |    3 +-
+ drivers/gpio/gpio-pl061.c                          |   15 +-
+ drivers/gpio/gpio-tegra186.c                       |    3 +-
+ drivers/gpio/gpio-wm8350.c                         |    7 +-
+ drivers/gpio/gpiolib-acpi.h                        |   12 +
+ drivers/gpio/gpiolib-cdev.c                        |    4 +-
+ drivers/gpio/gpiolib-of.h                          |   11 +-
+ drivers/gpio/gpiolib-sysfs.h                       |    2 +
+ .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     |    8 +-
+ drivers/pinctrl/actions/pinctrl-owl.c              |   49 +-
+ drivers/pinctrl/aspeed/pinctrl-aspeed.c            |    1 +
+ drivers/pinctrl/bcm/pinctrl-bcm281xx.c             |   13 +-
+ drivers/pinctrl/bcm/pinctrl-cygnus-mux.c           |    9 +-
+ drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |   12 +-
+ drivers/pinctrl/bcm/pinctrl-ns2-mux.c              |    8 +-
+ drivers/pinctrl/bcm/pinctrl-nsp-mux.c              |    8 +-
+ drivers/pinctrl/cirrus/pinctrl-lochnagar.c         |    6 +-
+ drivers/pinctrl/cirrus/pinctrl-madera-core.c       |    5 +-
+ drivers/pinctrl/core.c                             |   19 +-
+ drivers/pinctrl/core.h                             |   12 +-
+ drivers/pinctrl/devicetree.h                       |    6 +
+ drivers/pinctrl/freescale/pinctrl-imx.c            |    8 +-
+ drivers/pinctrl/freescale/pinctrl-imx1-core.c      |    4 +-
+ drivers/pinctrl/freescale/pinctrl-mxs.c            |    7 +-
+ drivers/pinctrl/intel/pinctrl-cherryview.c         |    6 +-
+ drivers/pinctrl/intel/pinctrl-intel.c              |    6 +-
+ drivers/pinctrl/intel/pinctrl-lynxpoint.c          |    6 +-
+ drivers/pinctrl/intel/pinctrl-merrifield.c         |    4 +-
+ drivers/pinctrl/mediatek/pinctrl-moore.c           |    3 +
+ drivers/pinctrl/mediatek/pinctrl-mt7986.c          |   32 +-
+ drivers/pinctrl/mediatek/pinctrl-paris.c           |    5 +
+ drivers/pinctrl/mvebu/pinctrl-mvebu.c              |   14 +-
+ drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   11 +-
+ drivers/pinctrl/pinconf.h                          |   10 +
+ drivers/pinctrl/pinctrl-amd.c                      |   10 +-
+ drivers/pinctrl/pinctrl-apple-gpio.c               |    7 +-
+ drivers/pinctrl/pinctrl-at91-pio4.c                |   36 +-
+ drivers/pinctrl/pinctrl-at91.c                     |   16 +-
+ drivers/pinctrl/pinctrl-axp209.c                   |    8 +-
+ drivers/pinctrl/pinctrl-bm1880.c                   |    6 +-
+ drivers/pinctrl/pinctrl-cy8c95x0.c                 |  134 +-
+ drivers/pinctrl/pinctrl-falcon.c                   |    9 +-
+ drivers/pinctrl/pinctrl-gemini.c                   |   12 +-
+ drivers/pinctrl/pinctrl-ingenic.c                  |   10 +-
+ drivers/pinctrl/pinctrl-k210.c                     |   12 +-
+ drivers/pinctrl/pinctrl-lantiq.c                   |    5 +-
+ drivers/pinctrl/pinctrl-lantiq.h                   |    7 +-
+ drivers/pinctrl/pinctrl-lpc18xx.c                  |    6 +-
+ drivers/pinctrl/pinctrl-microchip-sgpio.c          |    4 +-
+ drivers/pinctrl/pinctrl-ocelot.c                   |   30 +-
+ drivers/pinctrl/pinctrl-single.c                   |    6 +-
+ drivers/pinctrl/pinctrl-st.c                       |   25 +-
+ drivers/pinctrl/pinctrl-stmfx.c                    |    2 +
+ drivers/pinctrl/pinctrl-utils.h                    |    5 +
+ drivers/pinctrl/pinctrl-zynqmp.c                   |    5 +-
+ drivers/pinctrl/pinmux.c                           |   17 +-
+ drivers/pinctrl/pinmux.h                           |   11 +
+ drivers/pinctrl/qcom/Kconfig                       |   10 +
+ drivers/pinctrl/qcom/Makefile                      |    1 +
+ drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |    4 +
+ drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           |    9 +-
+ drivers/pinctrl/qcom/pinctrl-msm.c                 |   28 +-
+ drivers/pinctrl/qcom/pinctrl-msm.h                 |    5 +
+ drivers/pinctrl/qcom/pinctrl-sdm670.c              | 1345 +++++++++++++++=
+++++
+ drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    8 +-
+ drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |    8 +-
+ drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |   18 +-
+ drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c            |   18 +-
+ drivers/pinctrl/renesas/pinctrl-rzg2l.c            |    7 +-
+ drivers/pinctrl/renesas/pinctrl-rzn1.c             |    8 +-
+ drivers/pinctrl/renesas/pinctrl-rzv2m.c            |    4 +-
+ drivers/pinctrl/renesas/pinctrl.c                  |    8 +-
+ drivers/pinctrl/samsung/pinctrl-samsung.c          |   11 +-
+ drivers/pinctrl/spear/pinctrl-spear.c              |    6 +-
+ drivers/pinctrl/sprd/pinctrl-sprd.c                |    7 +-
+ drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c |    3 +
+ drivers/pinctrl/stm32/pinctrl-stm32.c              |   16 +-
+ drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   18 +-
+ drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |    7 +-
+ drivers/pinctrl/tegra/pinctrl-tegra.c              |    6 +-
+ drivers/pinctrl/ti/pinctrl-ti-iodelay.c            |    8 +-
+ drivers/pinctrl/uniphier/pinctrl-uniphier-core.c   |    8 +-
+ include/linux/gpio.h                               |    2 +-
+ include/linux/gpio/aspeed.h                        |    4 +
+ include/linux/gpio/driver.h                        |    2 +-
+ include/linux/gpio/gpio-reg.h                      |    4 +
+ include/linux/gpio/machine.h                       |    1 -
+ include/linux/pinctrl/consumer.h                   |   31 +-
+ include/linux/pinctrl/devinfo.h                    |    6 +-
+ include/linux/pinctrl/machine.h                    |    8 +-
+ include/linux/pinctrl/pinconf-generic.h            |   23 +-
+ include/linux/pinctrl/pinctrl.h                    |   18 +-
+ include/linux/pinctrl/pinmux.h                     |    5 +-
+ 98 files changed, 2167 insertions(+), 367 deletions(-)
+ create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-=
tlmm.yaml
+ create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c
+Merging pinctrl-intel/for-next (b14ef61314b3 pinctrl: intel: Add Intel Moo=
refield pin controller support)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/pinctrl/intel.git pinctrl-intel/for-next
+Auto-merging drivers/soc/fsl/qe/gpio.c
+Auto-merging include/linux/property.h
+Merge made by the 'ort' strategy.
+ drivers/pinctrl/intel/Kconfig                |  11 +
+ drivers/pinctrl/intel/Makefile               |   1 +
+ drivers/pinctrl/intel/pinctrl-alderlake.c    |  40 +-
+ drivers/pinctrl/intel/pinctrl-cannonlake.c   |   8 +-
+ drivers/pinctrl/intel/pinctrl-icelake.c      |   8 +-
+ drivers/pinctrl/intel/pinctrl-intel.c        |  26 +-
+ drivers/pinctrl/intel/pinctrl-merrifield.c   |  15 +-
+ drivers/pinctrl/intel/pinctrl-moorefield.c   | 916 ++++++++++++++++++++++=
+++++
+ drivers/pinctrl/intel/pinctrl-sunrisepoint.c |  32 +-
+ drivers/pinctrl/intel/pinctrl-tigerlake.c    |  28 +-
+ drivers/pinctrl/qcom/pinctrl-lpass-lpi.c     |   1 +
+ drivers/soc/fsl/qe/gpio.c                    |   4 +-
+ include/linux/property.h                     |  10 +-
+ 13 files changed, 1016 insertions(+), 84 deletions(-)
+ create mode 100644 drivers/pinctrl/intel/pinctrl-moorefield.c
+Merging pinctrl-renesas/renesas-pinctrl (96355be8f0a2 dt-bindings: pinctrl=
: renesas: Document RZ/Five SoC)
+$ git merge -m Merge branch 'renesas-pinctrl' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-drivers.git pinctrl-renesas/renesas-pinc=
trl
+Already up to date.
+Merging pinctrl-samsung/for-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/pinctrl/samsung.git pinctrl-samsung/for-next
+Already up to date.
+Merging pwm/for-next (bf22908680cc pwm: tegra: Ensure the clock rate is no=
t less than needed)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/thierry.reding/linux-pwm.git pwm/for-next
+Merge made by the 'ort' strategy.
+ drivers/pwm/pwm-tegra.c | 15 +++++++++++++--
+ 1 file changed, 13 insertions(+), 2 deletions(-)
+Merging userns/for-next (b5df013cd194 Merge of ucount-rlimits-cleanups-for=
-v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, retire_mq_sy=
sctls-for-v5.19, and unpriv-ipc-sysctls-for-v6.2 for testing in linux-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/ebiederm/user-namespace.git userns/for-next
+Auto-merging Documentation/admin-guide/sysctl/kernel.rst
+Auto-merging fs/coredump.c
+Auto-merging fs/exec.c
+Auto-merging fs/exec.c
+Auto-merging fs/exec.c
+Auto-merging fs/proc/array.c
+Auto-merging ipc/mqueue.c
+Auto-merging kernel/exit.c
+Auto-merging kernel/fork.c
+Auto-merging kernel/fork.c
+Auto-merging kernel/fork.c
+Auto-merging kernel/kthread.c
+Auto-merging kernel/sys.c
+Merge made by the 'ort' strategy.
+ Documentation/admin-guide/sysctl/kernel.rst | 14 ++++++++---
+ ipc/ipc_sysctl.c                            | 37 ++++++++++++++++++++++++=
+++--
+ ipc/mq_sysctl.c                             | 36 ++++++++++++++++++++++++=
++++
+ 3 files changed, 82 insertions(+), 5 deletions(-)
+Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncatin=
g the size of the log file for email)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/rostedt/linux-ktest.git ktest/for-next
+Already up to date.
+Merging kselftest/next (d942f231afc0 selftests/vDSO: Add riscv getcpu & ge=
ttimeofday test)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/shuah/linux-kselftest.git kselftest/next
+Auto-merging tools/testing/selftests/lib.mk
+Merge made by the 'ort' strategy.
+ Documentation/admin-guide/pm/amd-pstate.rst        | 194 +++++++++--
+ tools/testing/selftests/amd-pstate/Makefile        |  11 +-
+ .../testing/selftests/amd-pstate/amd-pstate-ut.sh  |  56 ---
+ tools/testing/selftests/amd-pstate/basic.sh        |  38 ++
+ tools/testing/selftests/amd-pstate/gitsource.sh    | 354 ++++++++++++++++=
+++
+ tools/testing/selftests/amd-pstate/run.sh          | 387 ++++++++++++++++=
+++++
+ tools/testing/selftests/amd-pstate/tbench.sh       | 339 ++++++++++++++++=
++
+ tools/testing/selftests/ftrace/test.d/functions    |   8 +-
+ .../selftests/ftrace/test.d/tracer/wakeup.tc       |   7 +-
+ .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |   7 +-
+ .../inter-event/trigger-field-variable-support.tc  |   2 +-
+ .../trigger-inter-event-combined-hist.tc           |   2 +-
+ .../inter-event/trigger-onchange-action-hist.tc    |   2 +-
+ .../inter-event/trigger-onmatch-action-hist.tc     |   2 +-
+ .../trigger-onmatch-onmax-action-hist.tc           |   2 +-
+ .../inter-event/trigger-onmax-action-hist.tc       |   2 +-
+ .../inter-event/trigger-snapshot-action-hist.tc    |   2 +-
+ .../trigger-synthetic-event-dynstring.tc           |   2 +-
+ .../inter-event/trigger-trace-action-hist.tc       |   2 +-
+ tools/testing/selftests/lib.mk                     |   5 +
+ tools/testing/selftests/vDSO/vdso_test_getcpu.c    |   4 +
+ .../selftests/vDSO/vdso_test_gettimeofday.c        |   3 +
+ tools/testing/selftests/watchdog/watchdog-test.c   | 106 +++++-
+ 23 files changed, 1433 insertions(+), 104 deletions(-)
+ delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
+ create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
+ create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
+ create mode 100755 tools/testing/selftests/amd-pstate/run.sh
+ create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh
+Merging livepatching/for-next (cad81ab73997 Merge branch 'for-6.2/core' in=
to for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/livepatching/livepatching livepatching/for-next
+Merge made by the 'ort' strategy.
+ kernel/livepatch/transition.c | 54 +++++++++++++++++++++-----------------=
-----
+ 1 file changed, 27 insertions(+), 27 deletions(-)
+Merging rtc/rtc-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'rtc-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/abelloni/linux.git rtc/rtc-next
+Already up to date.
+Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdi=
mm' into libnvdimm-for-next)
+$ git merge -m Merge branch 'libnvdimm-for-next' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/nvdimm/nvdimm.git nvdimm/libnvdimm-for-next
+Already up to date.
+Merging at24/at24/for-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'at24/for-next' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/brgl/linux.git at24/at24/for-next
+Already up to date.
+Merging ntb/ntb-next (4fe89d07dcc2 Linux 6.0)
+$ git merge -m Merge branch 'ntb-next' of https://github.com/jonmason/ntb.=
git ntb/ntb-next
+Already up to date.
+Merging seccomp/for-next/seccomp (4e92863862d1 Merge branch 'for-linus/sec=
comp' into for-next/seccomp)
+$ git merge -m Merge branch 'for-next/seccomp' of git://git.kernel.org/pub=
/scm/linux/kernel/git/kees/linux.git seccomp/for-next/seccomp
+Auto-merging kernel/fork.c
+Merge made by the 'ort' strategy.
+ kernel/fork.c                                 | 17 +++++++++++------
+ tools/testing/selftests/seccomp/seccomp_bpf.c |  6 ++++--
+ 2 files changed, 15 insertions(+), 8 deletions(-)
+Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
+$ git merge -m Merge branch 'for-next' of https://github.com/daniel-walker=
/cisco-linux.git cisco/for-next
+Already up to date.
+Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling=
 ida_simple_get)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/joel/fsi.git fsi/next
+Already up to date.
+Merging slimbus/for-next (c3174a51dc36 slimbus: qcom-ngd-ctrl: reinit the =
reconf completion flag)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/srini/slimbus.git slimbus/for-next
+Merge made by the 'ort' strategy.
+ drivers/slimbus/Kconfig         |  2 +-
+ drivers/slimbus/qcom-ctrl.c     |  5 +--
+ drivers/slimbus/qcom-ngd-ctrl.c | 97 ++++++++++++++++++++++++++++++++++++=
-----
+ drivers/slimbus/stream.c        | 25 ++++++++---
+ 4 files changed, 106 insertions(+), 23 deletions(-)
+Merging nvmem/for-next (8425f5159761 nvmem: stm32: fix spelling typo in co=
mment)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/srini/nvmem.git nvmem/for-next
+Merge made by the 'ort' strategy.
+ .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |  1 +
+ drivers/nvmem/lan9662-otpc.c                       |  2 +-
+ drivers/nvmem/stm32-romem.c                        | 27 +++++++++++++++++=
-----
+ 3 files changed, 23 insertions(+), 7 deletions(-)
+Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was al=
located)
+$ git merge -m Merge branch 'main' of git://git.infradead.org/users/willy/=
xarray.git xarray/main
+Merge made by the 'ort' strategy.
+ lib/idr.c | 14 ++++----------
+ 1 file changed, 4 insertions(+), 10 deletions(-)
+Merging hyperv/hyperv-next (c69840106483 hv_balloon: Add support for confi=
gurable order free page reporting)
+$ git merge -m Merge branch 'hyperv-next' of git://git.kernel.org/pub/scm/=
linux/kernel/git/hyperv/linux.git hyperv/hyperv-next
+Auto-merging drivers/hv/hv_balloon.c
+Merge made by the 'ort' strategy.
+ drivers/hv/hv_balloon.c | 94 ++++++++++++++++++++++++++++++++++++++------=
-----
+ mm/page_reporting.c     | 50 +++++++++++++++++++++++---
+ 2 files changed, 118 insertions(+), 26 deletions(-)
+Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array s=
ize explicitly in lcd2s_gotoxy())
+$ git merge -m Merge branch 'auxdisplay' of https://github.com/ojeda/linux=
.git auxdisplay/auxdisplay
+Already up to date.
+Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper funct=
ion)
+$ git merge -m Merge branch 'kgdb/for-next' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/danielt/linux.git kgdb/kgdb/for-next
+Already up to date.
+Merging hmm/hmm (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'hmm' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/rdma/rdma.git hmm/hmm
+Already up to date.
+Merging kunit/test (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'test' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/shuah/linux-kselftest.git kunit/test
+Already up to date.
+Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
+$ git merge -m Merge branch 'cfi/next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/mtd/linux.git cfi/cfi/next
+Already up to date.
+Merging kunit-next/kunit (6fe1ad4a1560 kunit: tool: remove redundant file.=
close() call in unit test)
+$ git merge -m Merge branch 'kunit' of git://git.kernel.org/pub/scm/linux/=
kernel/git/shuah/linux-kselftest.git kunit-next/kunit
+Auto-merging lib/kunit/string-stream.c
+CONFLICT (content): Merge conflict in lib/kunit/string-stream.c
+Resolved 'lib/kunit/string-stream.c' using previous resolution.
+Automatic merge failed; fix conflicts and then commit the result.
+$ git commit --no-edit -v -a
+[master 0ba41d9c722e] Merge branch 'kunit' of git://git.kernel.org/pub/scm=
/linux/kernel/git/shuah/linux-kselftest.git
+$ git diff -M --stat --summary HEAD^..
+ Documentation/dev-tools/kunit/architecture.rst | 115 +++++++++++---------=
--
+ drivers/gpu/drm/tests/drm_format_helper_test.c |  12 +--
+ include/kunit/assert.h                         |  33 +++++++
+ include/kunit/test.h                           |  87 +++++++++++++++++
+ lib/kunit/assert.c                             |  62 +++++++++++-
+ lib/kunit/kunit-example-test.c                 |   7 ++
+ lib/kunit/string-stream.c                      |   9 +-
+ net/core/dev_addr_lists_test.c                 |   4 +-
+ tools/testing/kunit/kunit_parser.py            |  72 ++++++++++----
+ tools/testing/kunit/kunit_tool_test.py         | 127 +++++++++++++-------=
-----
+ 10 files changed, 378 insertions(+), 150 deletions(-)
+Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/jikos/trivial.git trivial/for-next
+Already up to date.
+Merging mhi/mhi-next (c970e67d64a5 bus: mhi: host: make mhi_controller_con=
fig::event_cfg const)
+$ git merge -m Merge branch 'mhi-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/mani/mhi.git mhi/mhi-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS                        |  1 -
+ drivers/bus/mhi/host/boot.c        |  4 +---
+ drivers/bus/mhi/host/pci_generic.c | 21 ++++++++++++++-------
+ drivers/bus/mhi/host/pm.c          |  3 ++-
+ include/linux/mhi.h                |  2 +-
+ 5 files changed, 18 insertions(+), 13 deletions(-)
+$ git reset --hard HEAD^
+HEAD is now at 0ba41d9c722e Merge branch 'kunit' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/shuah/linux-kselftest.git
+Merging next-20221108 version of mhi
+$ git merge -m next-20221108/mhi d8425a8c3a8419dd505016951dd6393f21fb394e
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS                        | 1 -
+ drivers/bus/mhi/host/boot.c        | 4 +---
+ drivers/bus/mhi/host/pci_generic.c | 7 +++++++
+ drivers/bus/mhi/host/pm.c          | 3 ++-
+ 4 files changed, 10 insertions(+), 5 deletions(-)
+Merging memblock/for-next (80c2fe022ef5 memblock tests: remove completed T=
ODO item)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/rppt/memblock.git memblock/for-next
+Merge made by the 'ort' strategy.
+ tools/testing/memblock/Makefile                    |    2 +-
+ tools/testing/memblock/TODO                        |   14 +-
+ tools/testing/memblock/main.c                      |    2 +
+ tools/testing/memblock/tests/alloc_exact_nid_api.c | 1113 +++++++++++++++=
+++++
+ tools/testing/memblock/tests/alloc_exact_nid_api.h |   25 +
+ tools/testing/memblock/tests/alloc_nid_api.c       |  546 +++++-----
+ tools/testing/memblock/tests/alloc_nid_api.h       |    1 +
+ tools/testing/memblock/tests/basic_api.c           |  184 ++++
+ tools/testing/memblock/tests/common.c              |    7 +-
+ tools/testing/memblock/tests/common.h              |    8 +-
+ 10 files changed, 1622 insertions(+), 280 deletions(-)
+ create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
+ create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h
+Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in=
 do_copy)
+$ git merge -m Merge branch 'init-user-pointers' of git://git.infradead.or=
g/users/hch/misc.git init/init-user-pointers
+Already up to date.
+Merging cxl/next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/cxl/cxl.git cxl/next
+Already up to date.
+Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_i=
ter into its caller)
+$ git merge -m Merge branch 'folio-iomap' of git://git.infradead.org/users=
/willy/linux.git folio-iomap/folio-iomap
+Already up to date.
+Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
+$ git merge -m Merge branch 'zstd-next' of https://github.com/terrelln/lin=
ux.git zstd/zstd-next
+Auto-merging MAINTAINERS
+Merge made by the 'ort' strategy.
+ MAINTAINERS                                    |    2 +-
+ include/linux/zstd_lib.h                       |  475 +++---
+ lib/zstd/Makefile                              |    1 +
+ lib/zstd/common/bitstream.h                    |    9 +
+ lib/zstd/common/compiler.h                     |   67 +-
+ lib/zstd/common/entropy_common.c               |   11 +-
+ lib/zstd/common/error_private.h                |   81 +-
+ lib/zstd/common/fse.h                          |    3 +-
+ lib/zstd/common/fse_decompress.c               |    2 +-
+ lib/zstd/common/huf.h                          |   46 +-
+ lib/zstd/common/mem.h                          |    2 +
+ lib/zstd/common/portability_macros.h           |   93 ++
+ lib/zstd/common/zstd_common.c                  |   10 -
+ lib/zstd/common/zstd_internal.h                |  175 +--
+ lib/zstd/compress/clevels.h                    |  132 ++
+ lib/zstd/compress/fse_compress.c               |   83 +-
+ lib/zstd/compress/huf_compress.c               |  644 ++++++--
+ lib/zstd/compress/zstd_compress.c              | 2000 ++++++++++++++++++-=
-----
+ lib/zstd/compress/zstd_compress_internal.h     |  375 ++++-
+ lib/zstd/compress/zstd_compress_literals.c     |    9 +-
+ lib/zstd/compress/zstd_compress_literals.h     |    4 +-
+ lib/zstd/compress/zstd_compress_sequences.c    |   31 +-
+ lib/zstd/compress/zstd_compress_superblock.c   |  295 +---
+ lib/zstd/compress/zstd_cwksp.h                 |  225 ++-
+ lib/zstd/compress/zstd_double_fast.c           |  413 +++--
+ lib/zstd/compress/zstd_fast.c                  |  441 ++++--
+ lib/zstd/compress/zstd_lazy.c                  | 1352 ++++++++++++----
+ lib/zstd/compress/zstd_lazy.h                  |   38 +
+ lib/zstd/compress/zstd_ldm.c                   |   76 +-
+ lib/zstd/compress/zstd_ldm.h                   |    1 +
+ lib/zstd/compress/zstd_ldm_geartab.h           |    5 +-
+ lib/zstd/compress/zstd_opt.c                   |  402 +++--
+ lib/zstd/decompress/huf_decompress.c           |  912 ++++++++---
+ lib/zstd/decompress/zstd_decompress.c          |   80 +-
+ lib/zstd/decompress/zstd_decompress_block.c    | 1022 +++++++++---
+ lib/zstd/decompress/zstd_decompress_block.h    |   10 +-
+ lib/zstd/decompress/zstd_decompress_internal.h |   38 +-
+ lib/zstd/decompress_sources.h                  |    6 +
+ lib/zstd/zstd_common_module.c                  |   32 +
+ lib/zstd/zstd_compress_module.c                |    6 +-
+ 40 files changed, 6987 insertions(+), 2622 deletions(-)
+ create mode 100644 lib/zstd/common/portability_macros.h
+ create mode 100644 lib/zstd/compress/clevels.h
+ create mode 100644 lib/zstd/zstd_common_module.c
+Merging efi/next (27e80a1f89b1 efi: libstub: Merge zboot decompressor with=
 the ordinary stub)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/efi/efi.git efi/next
+Auto-merging MAINTAINERS
+Auto-merging arch/arm64/include/asm/efi.h
+Auto-merging arch/x86/Kconfig
+Auto-merging drivers/firmware/efi/efi-pstore.c
+Auto-merging drivers/firmware/efi/efi.c
+Auto-merging include/linux/efi.h
+Merge made by the 'ort' strategy.
+ MAINTAINERS                                        |   1 -
+ arch/arm/include/asm/efi.h                         |   3 -
+ arch/arm/kernel/efi.c                              |  31 +--
+ arch/arm64/include/asm/efi.h                       |  15 +-
+ arch/arm64/kernel/Makefile                         |   9 +-
+ arch/arm64/kernel/efi-entry.S                      |  69 -----
+ arch/arm64/kernel/image-vars.h                     |   8 -
+ arch/loongarch/include/asm/efi.h                   |  14 +-
+ arch/loongarch/kernel/efi.c                        |  24 +-
+ arch/loongarch/kernel/image-vars.h                 |   8 -
+ arch/riscv/include/asm/efi.h                       |  13 +-
+ arch/riscv/kernel/image-vars.h                     |   6 -
+ arch/x86/Kconfig                                   |  20 ++
+ arch/x86/boot/compressed/efi_thunk_64.S            |   6 -
+ arch/x86/include/asm/efi.h                         |  86 +++---
+ arch/x86/kernel/setup.c                            |   1 +
+ arch/x86/platform/efi/Makefile                     |   4 +-
+ arch/x86/platform/efi/efi.c                        |   8 +-
+ .../firmware =3D> arch/x86/platform}/efi/fake_mem.c  |  79 +++++-
+ arch/x86/platform/efi/memmap.c                     | 239 ++++++++++++++++
+ drivers/firmware/efi/Kconfig                       |  35 +--
+ drivers/firmware/efi/Makefile                      |   4 -
+ drivers/firmware/efi/efi-init.c                    |  21 +-
+ drivers/firmware/efi/efi-pstore.c                  |  23 +-
+ drivers/firmware/efi/efi.c                         |   5 +
+ drivers/firmware/efi/fake_mem.h                    |  10 -
+ drivers/firmware/efi/fdtparams.c                   |   4 +
+ drivers/firmware/efi/libstub/Makefile              |  34 ++-
+ drivers/firmware/efi/libstub/Makefile.zboot        |  22 +-
+ drivers/firmware/efi/libstub/alignedmem.c          |   5 +-
+ drivers/firmware/efi/libstub/arm32-stub.c          |  37 ---
+ drivers/firmware/efi/libstub/arm64-entry.S         |  67 +++++
+ drivers/firmware/efi/libstub/arm64-stub.c          |  55 +---
+ drivers/firmware/efi/libstub/arm64.c               |  61 ++++
+ drivers/firmware/efi/libstub/efi-stub-entry.c      |  65 +++++
+ drivers/firmware/efi/libstub/efi-stub-helper.c     | 145 +---------
+ drivers/firmware/efi/libstub/efi-stub.c            | 140 +++-------
+ drivers/firmware/efi/libstub/efistub.h             | 137 ++++++---
+ drivers/firmware/efi/libstub/file.c                | 122 +++++---
+ drivers/firmware/efi/libstub/intrinsics.c          |  18 ++
+ drivers/firmware/efi/libstub/loongarch-stub.c      |  89 ++----
+ drivers/firmware/efi/libstub/loongarch.c           |  80 ++++++
+ drivers/firmware/efi/libstub/mem.c                 |   3 +-
+ drivers/firmware/efi/libstub/printk.c              | 154 +++++++++++
+ drivers/firmware/efi/libstub/randomalloc.c         |   5 +-
+ drivers/firmware/efi/libstub/riscv-stub.c          |  96 +------
+ drivers/firmware/efi/libstub/riscv.c               |  98 +++++++
+ drivers/firmware/efi/libstub/screen_info.c         |  56 ++++
+ drivers/firmware/efi/libstub/string.c              |  95 ++++++-
+ drivers/firmware/efi/libstub/zboot-header.S        |   2 +-
+ drivers/firmware/efi/libstub/zboot.c               | 307 +++++-----------=
-----
+ drivers/firmware/efi/memmap.c                      | 238 +---------------
+ drivers/firmware/efi/x86_fake_mem.c                |  75 -----
+ include/linux/efi.h                                |  25 +-
+ 54 files changed, 1589 insertions(+), 1388 deletions(-)
+ delete mode 100644 arch/arm64/kernel/efi-entry.S
+ rename {drivers/firmware =3D> arch/x86/platform}/efi/fake_mem.c (58%)
+ create mode 100644 arch/x86/platform/efi/memmap.c
+ delete mode 100644 drivers/firmware/efi/fake_mem.h
+ create mode 100644 drivers/firmware/efi/libstub/arm64-entry.S
+ create mode 100644 drivers/firmware/efi/libstub/arm64.c
+ create mode 100644 drivers/firmware/efi/libstub/efi-stub-entry.c
+ create mode 100644 drivers/firmware/efi/libstub/loongarch.c
+ create mode 100644 drivers/firmware/efi/libstub/printk.c
+ create mode 100644 drivers/firmware/efi/libstub/riscv.c
+ create mode 100644 drivers/firmware/efi/libstub/screen_info.c
+ delete mode 100644 drivers/firmware/efi/x86_fake_mem.c
+Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation f=
ailures in mkutf8data)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/krisman/unicode.git unicode/for-next
+Merge made by the 'ort' strategy.
+ fs/unicode/mkutf8data.c | 38 ++++++++++++++++++++++++--------------
+ 1 file changed, 24 insertions(+), 14 deletions(-)
+Merging slab/for-next (74db113e8571 Merge branch 'slab/for-6.1-rc4/fixes' =
into slab/for-next)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/vbabka/slab.git slab/for-next
+Auto-merging include/linux/slab.h
+Auto-merging mm/migrate.c
+Merge made by the 'ort' strategy.
+ Documentation/mm/slub.rst |  2 +
+ include/linux/slab.h      | 23 ------------
+ mm/migrate.c              | 15 ++++++--
+ mm/slab.c                 | 96 ++++++++++++++++++++++++------------------=
-----
+ mm/slab.h                 | 58 ++++++++++++++++------------
+ mm/slab_common.c          | 24 ++----------
+ mm/slub.c                 | 69 +++++++++++++++++-----------------
+ 7 files changed, 137 insertions(+), 150 deletions(-)
+Merging random/master (6cd0a8ecc0f4 hw_random: use add_hwgenerator_randomn=
ess() for early entropy)
+$ git merge -m Merge branch 'master' of git://git.kernel.org/pub/scm/linux=
/kernel/git/crng/random.git random/master
+Auto-merging Documentation/admin-guide/kernel-parameters.txt
+Auto-merging arch/s390/configs/debug_defconfig
+Auto-merging arch/s390/configs/defconfig
+Auto-merging arch/s390/configs/zfcpdump_defconfig
+Auto-merging arch/x86/kernel/cpu/common.c
+Auto-merging arch/x86/kernel/module.c
+Auto-merging arch/x86/kernel/setup_percpu.c
+Auto-merging arch/x86/kernel/smpboot.c
+Auto-merging arch/x86/xen/enlighten_pv.c
+Auto-merging crypto/testmgr.c
+Auto-merging drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+Auto-merging drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+Auto-merging drivers/mmc/core/core.c
+Auto-merging drivers/mmc/host/dw_mmc.c
+Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+Auto-merging drivers/scsi/scsi_debug.c
+Auto-merging fs/ceph/inode.c
+Auto-merging fs/ext4/ialloc.c
+Auto-merging fs/f2fs/gc.c
+Auto-merging fs/f2fs/segment.c
+Auto-merging kernel/bpf/core.c
+Auto-merging kernel/fork.c
+Auto-merging kernel/time/clocksource.c
+Auto-merging lib/kobject.c
+Auto-merging lib/test_printf.c
+Auto-merging mm/slub.c
+Auto-merging net/bluetooth/mgmt.c
+Auto-merging net/can/j1939/transport.c
+Auto-merging net/ipv4/tcp_input.c
+Auto-merging net/netlink/af_netlink.c
+Auto-merging net/packet/af_packet.c
+Auto-merging net/sctp/socket.c
+Merge made by the 'ort' strategy.
+ Documentation/admin-guide/kernel-parameters.txt    | 20 +++--
+ arch/arm/include/asm/stackprotector.h              |  9 +--
+ arch/arm/kernel/process.c                          |  2 +-
+ arch/arm64/include/asm/archrandom.h                | 48 +++--------
+ arch/arm64/include/asm/stackprotector.h            |  9 +--
+ arch/arm64/kernel/process.c                        |  2 +-
+ arch/csky/include/asm/stackprotector.h             | 10 +--
+ arch/loongarch/kernel/process.c                    |  2 +-
+ arch/loongarch/kernel/vdso.c                       |  2 +-
+ arch/mips/include/asm/stackprotector.h             |  9 +--
+ arch/mips/kernel/process.c                         |  2 +-
+ arch/mips/kernel/vdso.c                            |  2 +-
+ arch/parisc/kernel/vdso.c                          |  2 +-
+ arch/powerpc/configs/microwatt_defconfig           |  1 -
+ arch/powerpc/crypto/crc-vpmsum_test.c              |  4 +-
+ arch/powerpc/include/asm/stackprotector.h          | 10 +--
+ arch/powerpc/kernel/process.c                      |  2 +-
+ arch/riscv/include/asm/stackprotector.h            | 10 +--
+ arch/s390/configs/debug_defconfig                  |  2 -
+ arch/s390/configs/defconfig                        |  2 -
+ arch/s390/configs/zfcpdump_defconfig               |  1 -
+ arch/s390/kernel/process.c                         |  2 +-
+ arch/s390/kernel/vdso.c                            |  2 +-
+ arch/sh/include/asm/stackprotector.h               | 10 +--
+ arch/sparc/vdso/vma.c                              |  2 +-
+ arch/um/kernel/process.c                           |  2 +-
+ arch/x86/entry/vdso/vma.c                          |  2 +-
+ arch/x86/include/asm/stackprotector.h              | 14 +---
+ arch/x86/kernel/cpu/common.c                       |  2 +-
+ arch/x86/kernel/module.c                           |  2 +-
+ arch/x86/kernel/process.c                          |  2 +-
+ arch/x86/kernel/setup_percpu.c                     |  2 +-
+ arch/x86/kernel/smpboot.c                          |  1 +
+ arch/x86/mm/pat/cpa-test.c                         |  4 +-
+ arch/x86/xen/enlighten_pv.c                        |  2 +-
+ arch/xtensa/include/asm/stackprotector.h           |  9 +--
+ crypto/rsa-pkcs1pad.c                              |  2 +-
+ crypto/testmgr.c                                   | 86 ++++++++++-------=
---
+ drivers/block/drbd/drbd_receiver.c                 |  4 +-
+ drivers/bus/mhi/host/internal.h                    |  2 +-
+ drivers/char/Kconfig                               | 36 ---------
+ drivers/char/hw_random/core.c                      |  8 +-
+ drivers/char/random.c                              | 60 +++++++++-----
+ drivers/dma-buf/st-dma-fence-chain.c               |  6 +-
+ drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |  2 +-
+ .../gpu/drm/i915/gt/intel_execlists_submission.c   |  2 +-
+ drivers/gpu/drm/i915/intel_memory_region.c         |  4 +-
+ drivers/infiniband/core/cma.c                      |  2 +-
+ drivers/infiniband/hw/cxgb4/id_table.c             |  4 +-
+ drivers/infiniband/hw/hns/hns_roce_ah.c            |  5 +-
+ drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  2 +-
+ drivers/md/bcache/request.c                        |  2 +-
+ drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |  8 +-
+ drivers/media/test-drivers/vidtv/vidtv_demod.c     |  8 +-
+ .../media/test-drivers/vivid/vivid-kthread-cap.c   |  2 +-
+ .../media/test-drivers/vivid/vivid-kthread-out.c   |  2 +-
+ drivers/media/test-drivers/vivid/vivid-radio-rx.c  |  4 +-
+ drivers/media/test-drivers/vivid/vivid-sdr-cap.c   |  2 +-
+ drivers/media/test-drivers/vivid/vivid-touch-cap.c |  2 +-
+ drivers/mmc/core/core.c                            |  4 +-
+ drivers/mmc/host/dw_mmc.c                          |  2 +-
+ drivers/mtd/nand/raw/nandsim.c                     |  4 +-
+ drivers/mtd/tests/mtd_nandecctest.c                | 10 +--
+ drivers/mtd/tests/stresstest.c                     |  8 +-
+ drivers/mtd/ubi/debug.c                            |  2 +-
+ drivers/mtd/ubi/debug.h                            |  6 +-
+ drivers/net/ethernet/broadcom/cnic.c               |  2 +-
+ .../chelsio/inline_crypto/chtls/chtls_io.c         |  4 +-
+ drivers/net/phy/at803x.c                           |  2 +-
+ drivers/net/team/team_mode_random.c                |  2 +-
+ drivers/net/wireguard/selftest/allowedips.c        | 20 ++---
+ drivers/net/wireguard/timers.c                     |  4 +-
+ .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |  2 +-
+ drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  2 +-
+ drivers/pci/p2pdma.c                               |  2 +-
+ drivers/s390/scsi/zfcp_fc.c                        |  2 +-
+ drivers/scsi/fcoe/fcoe_ctlr.c                      |  4 +-
+ drivers/scsi/qedi/qedi_main.c                      |  2 +-
+ drivers/scsi/scsi_debug.c                          |  6 +-
+ fs/ceph/inode.c                                    |  2 +-
+ fs/ceph/mdsmap.c                                   |  2 +-
+ fs/ext2/ialloc.c                                   |  2 +-
+ fs/ext4/ialloc.c                                   |  2 +-
+ fs/ext4/mmp.c                                      |  8 +-
+ fs/ext4/super.c                                    |  5 +-
+ fs/f2fs/gc.c                                       |  2 +-
+ fs/f2fs/segment.c                                  |  8 +-
+ fs/ubifs/debug.c                                   |  8 +-
+ fs/ubifs/lpt_commit.c                              | 14 ++--
+ fs/ubifs/tnc_commit.c                              |  2 +-
+ fs/xfs/libxfs/xfs_alloc.c                          |  2 +-
+ fs/xfs/libxfs/xfs_ialloc.c                         |  2 +-
+ fs/xfs/xfs_error.c                                 |  2 +-
+ include/linux/damon.h                              |  2 +-
+ include/linux/nodemask.h                           |  2 +-
+ include/linux/prandom.h                            | 18 +----
+ include/linux/random.h                             | 93 ++++++++++++++---=
-----
+ include/linux/stackprotector.h                     | 19 +++++
+ kernel/bpf/core.c                                  |  4 +-
+ kernel/fork.c                                      |  2 +-
+ kernel/kcsan/selftest.c                            | 12 +--
+ kernel/locking/test-ww_mutex.c                     |  4 +-
+ kernel/time/clocksource.c                          |  2 +-
+ lib/fault-inject.c                                 |  2 +-
+ lib/find_bit_benchmark.c                           |  4 +-
+ lib/kobject.c                                      |  2 +-
+ lib/reed_solomon/test_rslib.c                      |  6 +-
+ lib/sbitmap.c                                      |  4 +-
+ lib/test-string_helpers.c                          |  2 +-
+ lib/test_fprobe.c                                  |  5 +-
+ lib/test_hexdump.c                                 | 10 +--
+ lib/test_kprobes.c                                 |  5 +-
+ lib/test_list_sort.c                               |  2 +-
+ lib/test_printf.c                                  |  2 +-
+ lib/test_rhashtable.c                              |  6 +-
+ lib/test_vmalloc.c                                 |  8 +-
+ mm/kasan/kasan_test.c                              |  6 +-
+ mm/kfence/core.c                                   |  4 +-
+ mm/kfence/kfence_test.c                            |  4 +-
+ mm/slub.c                                          |  2 +-
+ mm/swapfile.c                                      |  5 +-
+ net/802/garp.c                                     |  2 +-
+ net/802/mrp.c                                      |  2 +-
+ net/batman-adv/bat_iv_ogm.c                        |  4 +-
+ net/batman-adv/bat_v_elp.c                         |  2 +-
+ net/batman-adv/bat_v_ogm.c                         |  4 +-
+ net/batman-adv/network-coding.c                    |  2 +-
+ net/bluetooth/mgmt.c                               |  5 +-
+ net/can/j1939/socket.c                             |  2 +-
+ net/can/j1939/transport.c                          |  2 +-
+ net/ceph/mon_client.c                              |  2 +-
+ net/ceph/osd_client.c                              |  2 +-
+ net/core/neighbour.c                               |  4 +-
+ net/core/pktgen.c                                  | 37 ++++-----
+ net/core/stream.c                                  |  2 +-
+ net/ipv4/icmp.c                                    |  2 +-
+ net/ipv4/igmp.c                                    |  6 +-
+ net/ipv4/inet_connection_sock.c                    |  2 +-
+ net/ipv4/inet_hashtables.c                         |  2 +-
+ net/ipv4/route.c                                   |  4 +-
+ net/ipv4/tcp_bbr.c                                 |  2 +-
+ net/ipv4/tcp_input.c                               |  3 +-
+ net/ipv6/addrconf.c                                |  8 +-
+ net/ipv6/mcast.c                                   | 10 +--
+ net/ipv6/output_core.c                             |  8 +-
+ net/ipv6/route.c                                   |  2 +-
+ net/netfilter/ipvs/ip_vs_twos.c                    |  4 +-
+ net/netfilter/nf_conntrack_core.c                  |  4 +-
+ net/netfilter/nf_nat_helper.c                      |  2 +-
+ net/netlink/af_netlink.c                           |  2 +-
+ net/packet/af_packet.c                             |  4 +-
+ net/sched/act_gact.c                               |  2 +-
+ net/sched/act_sample.c                             |  2 +-
+ net/sched/sch_choke.c                              |  2 +-
+ net/sched/sch_netem.c                              |  4 +-
+ net/sctp/socket.c                                  |  2 +-
+ net/sctp/transport.c                               |  2 +-
+ net/sunrpc/cache.c                                 |  2 +-
+ net/sunrpc/xprtsock.c                              |  2 +-
+ net/tipc/socket.c                                  |  2 +-
+ net/vmw_vsock/af_vsock.c                           |  3 +-
+ net/xfrm/xfrm_state.c                              |  2 +-
+ .../testing/selftests/wireguard/qemu/kernel.config |  2 -
+ 163 files changed, 445 insertions(+), 571 deletions(-)
+Merging landlock/next (0b4ab8cd635e Merge tag 'landlock-6.1-rc4' into land=
lock-next)
+$ git merge -m Merge branch 'next' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/mic/linux.git landlock/next
+Auto-merging fs/namei.c
+Auto-merging fs/open.c
+Auto-merging include/linux/lsm_hook_defs.h
+Auto-merging include/linux/lsm_hooks.h
+Auto-merging include/linux/security.h
+Auto-merging security/apparmor/lsm.c
+Auto-merging security/security.c
+Merge made by the 'ort' strategy.
+ Documentation/userspace-api/landlock.rst     |  67 +++-
+ fs/namei.c                                   |   2 +-
+ fs/open.c                                    |   2 +-
+ include/linux/lsm_hook_defs.h                |   1 +
+ include/linux/lsm_hooks.h                    |  10 +-
+ include/linux/security.h                     |   6 +
+ include/uapi/linux/landlock.h                |  21 +-
+ samples/landlock/sandboxer.c                 |  29 +-
+ security/apparmor/lsm.c                      |   6 +
+ security/landlock/fs.c                       | 206 +++++++++---
+ security/landlock/fs.h                       |  24 ++
+ security/landlock/limits.h                   |   2 +-
+ security/landlock/setup.c                    |   1 +
+ security/landlock/syscalls.c                 |   2 +-
+ security/security.c                          |  16 +-
+ security/tomoyo/tomoyo.c                     |  13 +
+ tools/testing/selftests/landlock/base_test.c |  38 +--
+ tools/testing/selftests/landlock/common.h    |  85 ++++-
+ tools/testing/selftests/landlock/fs_test.c   | 468 ++++++++++++++++++++++=
++++-
+ 19 files changed, 878 insertions(+), 121 deletions(-)
+Merging rust/rust-next (fd9517a1603f init/Kconfig: Specify the interpreter=
 for rust_is_available.sh)
+$ git merge -m Merge branch 'rust-next' of https://github.com/Rust-for-Lin=
ux/linux.git rust/rust-next
+Auto-merging init/Kconfig
+Merge made by the 'ort' strategy.
+ init/Kconfig | 8 +++++++-
+ 1 file changed, 7 insertions(+), 1 deletion(-)
+Merging sysctl/sysctl-next (c06a17fe056b kernel/sysctl-test: use SYSCTL_{Z=
ERO/ONE_HUNDRED} instead of i_{zero/one_hundred})
+$ git merge -m Merge branch 'sysctl-next' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mcgrof/linux.git sysctl/sysctl-next
+Already up to date.
+Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in=
 mpage_writepages)
+$ git merge -m Merge branch 'for-next' of git://git.infradead.org/users/wi=
lly/pagecache.git folio/for-next
+Auto-merging Documentation/filesystems/locking.rst
+Auto-merging Documentation/filesystems/vfs.rst
+Auto-merging block/fops.c
+Auto-merging block/partitions/core.c
+Auto-merging drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+Auto-merging drivers/misc/vmw_balloon.c
+Auto-merging drivers/virtio/virtio_balloon.c
+Auto-merging fs/aio.c
+Auto-merging fs/btrfs/disk-io.c
+Auto-merging fs/btrfs/inode.c
+Auto-merging fs/buffer.c
+Auto-merging fs/ext2/inode.c
+Auto-merging fs/ext2/namei.c
+Auto-merging fs/ext2/super.c
+Auto-merging fs/ext4/inode.c
+Auto-merging fs/f2fs/checkpoint.c
+Auto-merging fs/f2fs/data.c
+Auto-merging fs/f2fs/f2fs.h
+Auto-merging fs/f2fs/node.c
+Auto-merging fs/gfs2/aops.c
+Auto-merging fs/gfs2/lops.c
+Auto-merging fs/hostfs/hostfs_kern.c
+Auto-merging fs/hugetlbfs/inode.c
+Auto-merging fs/iomap/buffered-io.c
+Auto-merging fs/mpage.c
+Auto-merging fs/nfs/file.c
+Auto-merging fs/nfs/internal.h
+Auto-merging fs/nfs/write.c
+Auto-merging fs/ntfs/aops.c
+Auto-merging fs/ntfs3/inode.c
+Auto-merging fs/ocfs2/aops.c
+Auto-merging fs/ocfs2/refcounttree.c
+Auto-merging fs/squashfs/file.c
+Auto-merging fs/zonefs/super.c
+Auto-merging include/linux/buffer_head.h
+Auto-merging include/linux/fs.h
+Auto-merging include/linux/iomap.h
+Auto-merging include/linux/migrate.h
+CONFLICT (content): Merge conflict in include/linux/migrate.h
+Auto-merging include/linux/page-flags.h
+Auto-merging include/linux/pagemap.h
+Auto-merging mm/compaction.c
+Auto-merging mm/folio-compat.c
+Auto-merging mm/ksm.c
+Auto-merging mm/migrate.c
+CONFLICT (content): Merge conflict in mm/migrate.c
+Auto-merging mm/migrate_device.c
+CONFLICT (content): Merge conflict in mm/migrate_device.c
+Auto-merging mm/secretmem.c
+Auto-merging mm/shmem.c
+Auto-merging mm/swap_state.c
+Auto-merging mm/util.c
+Auto-merging mm/zsmalloc.c
+Resolved 'include/linux/migrate.h' using previous resolution.
+Resolved 'mm/migrate.c' using previous resolution.
+Resolved 'mm/migrate_device.c' using previous resolution.
+Automatic merge failed; fix conflicts and then commit the result.
+$ git commit --no-edit -v -a
+[master f2b37934865a] Merge branch 'for-next' of git://git.infradead.org/u=
sers/willy/pagecache.git
+$ git diff -M --stat --summary HEAD^..
+ fs/btrfs/disk-io.c | 19 ++++++++-----------
+ 1 file changed, 8 insertions(+), 11 deletions(-)
+Merging execve/for-next/execve (ef20c5139c31 binfmt_elf: simplify error ha=
ndling in load_elf_phdrs())
+$ git merge -m Merge branch 'for-next/execve' of git://git.kernel.org/pub/=
scm/linux/kernel/git/kees/linux.git execve/for-next/execve
+Auto-merging fs/exec.c
+Auto-merging kernel/fork.c
+Merge made by the 'ort' strategy.
+ fs/binfmt_elf.c                             |  26 ++----
+ fs/binfmt_elf_fdpic.c                       |   2 +-
+ fs/exec.c                                   |  32 +++++--
+ include/linux/nsproxy.h                     |   1 +
+ include/uapi/linux/elf.h                    |  14 +--
+ kernel/fork.c                               |   9 --
+ kernel/nsproxy.c                            |  23 ++++-
+ tools/testing/selftests/timens/.gitignore   |   1 +
+ tools/testing/selftests/timens/Makefile     |   2 +-
+ tools/testing/selftests/timens/vfork_exec.c | 139 +++++++++++++++++++++++=
+++++
+ 10 files changed, 204 insertions(+), 45 deletions(-)
+ create mode 100644 tools/testing/selftests/timens/vfork_exec.c
+Merging bitmap/bitmap-for-next (27bc50fc9064 Merge tag 'mm-stable-2022-10-=
08' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)
+$ git merge -m Merge branch 'bitmap-for-next' of https://github.com/norov/=
linux.git bitmap/bitmap-for-next
+Already up to date.
+Merging hte/for-next (9abf2313adc1 Linux 6.1-rc1)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/pateldipen1984/linux.git hte/for-next
+Already up to date.
+Merging kspp/for-next/kspp (0eaf29a03298 Merge branch 'for-linus/hardening=
' into for-next/kspp)
+$ git merge -m Merge branch 'for-next/kspp' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/kees/linux.git kspp/for-next/kspp
+Auto-merging MAINTAINERS
+Auto-merging Makefile
+Auto-merging arch/arm/boot/compressed/Makefile
+Auto-merging fs/btrfs/send.c
+Auto-merging fs/cifs/cifsacl.c
+Auto-merging fs/coredump.c
+Auto-merging include/asm-generic/vmlinux.lds.h
+Auto-merging include/linux/fortify-string.h
+Auto-merging init/Kconfig
+Auto-merging lib/Kconfig.debug
+Auto-merging lib/Makefile
+Auto-merging lib/memcpy_kunit.c
+Auto-merging scripts/kernel-doc
+Merge made by the 'ort' strategy.
+ Documentation/core-api/kernel-api.rst       |   3 +
+ MAINTAINERS                                 |   4 +-
+ Makefile                                    |   2 +-
+ arch/arm/boot/compressed/Makefile           |   2 +-
+ arch/arm64/kernel/vdso/Makefile             |   2 +-
+ arch/arm64/kernel/vdso32/Makefile           |   2 +-
+ arch/x86/boot/compressed/Makefile           |   2 +-
+ drivers/base/firmware_loader/main.c         |   2 +-
+ drivers/dma-buf/dma-resv.c                  |   9 +-
+ drivers/gpu/drm/i915/i915_user_extensions.c |   2 +-
+ drivers/gpu/drm/i915/i915_utils.h           |   4 -
+ fs/btrfs/send.c                             |  11 +-
+ fs/cifs/cifs_spnego.c                       |   2 +-
+ fs/cifs/cifsacl.c                           |   2 +-
+ fs/coredump.c                               |   7 +-
+ fs/ksmbd/smb_common.c                       |   2 +-
+ fs/nfs/flexfilelayout/flexfilelayout.c      |   4 +-
+ fs/nfs/nfs4idmap.c                          |   2 +-
+ fs/nfsd/nfs4callback.c                      |   2 +-
+ include/asm-generic/vmlinux.lds.h           |   2 +-
+ include/linux/compiler.h                    |   1 +
+ include/linux/fortify-string.h              | 148 ++++++++++-
+ include/linux/overflow.h                    |  47 ++++
+ include/linux/string.h                      |   2 +-
+ init/Kconfig                                |  15 +-
+ kernel/cred.c                               |  15 +-
+ lib/Kconfig.debug                           |  28 +-
+ lib/Makefile                                |   5 +-
+ lib/memcpy_kunit.c                          | 205 +++++++++++++++
+ lib/overflow_kunit.c                        | 381 +++++++++++++++++++++++=
+++++
+ lib/{test_siphash.c =3D> siphash_kunit.c}     | 165 +++++-------
+ lib/string.c                                |  82 ------
+ lib/strscpy_kunit.c                         | 142 +++++++++++
+ lib/test_strscpy.c                          | 150 -----------
+ net/dns_resolver/dns_key.c                  |   2 +-
+ scripts/kernel-doc                          |   6 +-
+ 36 files changed, 1066 insertions(+), 396 deletions(-)
+ rename lib/{test_siphash.c =3D> siphash_kunit.c} (60%)
+ create mode 100644 lib/strscpy_kunit.c
+ delete mode 100644 lib/test_strscpy.c
+Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-le=
ngth array with DECLARE_FLEX_ARRAY() helper)
+$ git merge -m Merge branch 'for-next/kspp' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/gustavoars/linux.git kspp-gustavo/for-next/kspp
+Auto-merging include/linux/exportfs.h
+Auto-merging include/linux/memremap.h
+Merge made by the 'ort' strategy.
+ include/linux/exportfs.h | 2 +-
+ include/linux/memremap.h | 2 +-
+ 2 files changed, 2 insertions(+), 2 deletions(-)
+Merging unsigned-char/unsigned-char (97f7ffb41169 lib: assume char is unsi=
gned)
+$ git merge -m Merge branch 'unsigned-char' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/zx2c4/linux.git unsigned-char/unsigned-char
+Auto-merging Makefile
+Auto-merging drivers/staging/rtl8192e/rtllib_softmac_wx.c
+Auto-merging lib/test_printf.c
+Merge made by the 'ort' strategy.
+ Makefile                                       |  2 +-
+ arch/mips/include/asm/fw/fw.h                  |  2 +-
+ arch/mips/pic32/pic32mzda/early_console.c      | 13 ++++++-------
+ arch/mips/pic32/pic32mzda/init.c               |  2 +-
+ arch/x86/events/intel/p4.c                     |  2 +-
+ drivers/media/dvb-frontends/stv0288.c          |  5 ++---
+ drivers/sbus/char/envctrl.c                    |  4 ++--
+ drivers/staging/media/atomisp/pci/hive_types.h |  2 +-
+ lib/is_signed_type_kunit.c                     |  4 ----
+ lib/test_printf.c                              | 12 ------------
+ 10 files changed, 15 insertions(+), 33 deletions(-)
+Merging iommufd/for-next (65016290f146 iommufd: Allow iommufd to supply /d=
ev/vfio/vfio)
+$ git merge -m Merge branch 'for-next' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/jgg/iommufd.git iommufd/for-next
+Auto-merging MAINTAINERS
+Auto-merging drivers/iommu/amd/iommu.c
+Merge made by the 'ort' strategy.
+ .clang-format                                      |    3 +
+ Documentation/userspace-api/index.rst              |    1 +
+ Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
+ Documentation/userspace-api/iommufd.rst            |  222 +++
+ MAINTAINERS                                        |   12 +
+ drivers/gpu/drm/i915/gvt/kvmgt.c                   |    3 +
+ drivers/iommu/Kconfig                              |    1 +
+ drivers/iommu/Makefile                             |    2 +-
+ drivers/iommu/amd/iommu.c                          |    2 +
+ drivers/iommu/intel/iommu.c                        |   16 +-
+ drivers/iommu/iommu.c                              |  124 +-
+ drivers/iommu/iommufd/Kconfig                      |   35 +
+ drivers/iommu/iommufd/Makefile                     |   13 +
+ drivers/iommu/iommufd/device.c                     |  748 ++++++++
+ drivers/iommu/iommufd/double_span.h                |   98 +
+ drivers/iommu/iommufd/hw_pagetable.c               |   57 +
+ drivers/iommu/iommufd/io_pagetable.c               | 1214 +++++++++++++
+ drivers/iommu/iommufd/io_pagetable.h               |  241 +++
+ drivers/iommu/iommufd/ioas.c                       |  390 ++++
+ drivers/iommu/iommufd/iommufd_private.h            |  307 ++++
+ drivers/iommu/iommufd/iommufd_test.h               |   93 +
+ drivers/iommu/iommufd/main.c                       |  455 +++++
+ drivers/iommu/iommufd/pages.c                      | 1884 +++++++++++++++=
+++++
+ drivers/iommu/iommufd/selftest.c                   |  853 +++++++++
+ drivers/iommu/iommufd/vfio_compat.c                |  452 +++++
+ drivers/s390/cio/vfio_ccw_ops.c                    |    3 +
+ drivers/s390/crypto/vfio_ap_ops.c                  |    3 +
+ drivers/vfio/Kconfig                               |   36 +-
+ drivers/vfio/Makefile                              |    5 +-
+ drivers/vfio/container.c                           |  141 +-
+ drivers/vfio/fsl-mc/vfio_fsl_mc.c                  |    3 +
+ drivers/vfio/iommufd.c                             |  157 ++
+ drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c     |    6 +
+ drivers/vfio/pci/mlx5/main.c                       |    3 +
+ drivers/vfio/pci/vfio_pci.c                        |    3 +
+ drivers/vfio/platform/vfio_amba.c                  |    3 +
+ drivers/vfio/platform/vfio_platform.c              |    3 +
+ drivers/vfio/vfio.h                                |  100 +-
+ drivers/vfio/vfio_iommu_type1.c                    |    5 +-
+ drivers/vfio/vfio_main.c                           |  338 +++-
+ include/linux/interval_tree.h                      |   58 +
+ include/linux/iommu.h                              |   17 +
+ include/linux/iommufd.h                            |  102 ++
+ include/linux/sched/user.h                         |    2 +-
+ include/linux/vfio.h                               |   39 +
+ include/uapi/linux/iommufd.h                       |  332 ++++
+ kernel/user.c                                      |    1 +
+ lib/Kconfig                                        |    4 +
+ lib/interval_tree.c                                |  132 ++
+ tools/testing/selftests/Makefile                   |    1 +
+ tools/testing/selftests/iommu/.gitignore           |    3 +
+ tools/testing/selftests/iommu/Makefile             |   12 +
+ tools/testing/selftests/iommu/config               |    2 +
+ tools/testing/selftests/iommu/iommufd.c            | 1627 +++++++++++++++=
++
+ tools/testing/selftests/iommu/iommufd_fail_nth.c   |  580 ++++++
+ tools/testing/selftests/iommu/iommufd_utils.h      |  278 +++
+ 56 files changed, 10994 insertions(+), 232 deletions(-)
+ create mode 100644 Documentation/userspace-api/iommufd.rst
+ create mode 100644 drivers/iommu/iommufd/Kconfig
+ create mode 100644 drivers/iommu/iommufd/Makefile
+ create mode 100644 drivers/iommu/iommufd/device.c
+ create mode 100644 drivers/iommu/iommufd/double_span.h
+ create mode 100644 drivers/iommu/iommufd/hw_pagetable.c
+ create mode 100644 drivers/iommu/iommufd/io_pagetable.c
+ create mode 100644 drivers/iommu/iommufd/io_pagetable.h
+ create mode 100644 drivers/iommu/iommufd/ioas.c
+ create mode 100644 drivers/iommu/iommufd/iommufd_private.h
+ create mode 100644 drivers/iommu/iommufd/iommufd_test.h
+ create mode 100644 drivers/iommu/iommufd/main.c
+ create mode 100644 drivers/iommu/iommufd/pages.c
+ create mode 100644 drivers/iommu/iommufd/selftest.c
+ create mode 100644 drivers/iommu/iommufd/vfio_compat.c
+ create mode 100644 drivers/vfio/iommufd.c
+ create mode 100644 include/linux/iommufd.h
+ create mode 100644 include/uapi/linux/iommufd.h
+ create mode 100644 tools/testing/selftests/iommu/.gitignore
+ create mode 100644 tools/testing/selftests/iommu/Makefile
+ create mode 100644 tools/testing/selftests/iommu/config
+ create mode 100644 tools/testing/selftests/iommu/iommufd.c
+ create mode 100644 tools/testing/selftests/iommu/iommufd_fail_nth.c
+ create mode 100644 tools/testing/selftests/iommu/iommufd_utils.h
+Merging mm-stable/mm-stable (b742122b4e36 selftests/damon: add tests for D=
AMON_LRU_SORT's enabled parameter)
+$ git merge -m Merge branch 'mm-stable' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/akpm/mm mm-stable/mm-stable
+Auto-merging MAINTAINERS
+Auto-merging arch/arm/include/asm/pgtable-nommu.h
+Auto-merging arch/arm/include/asm/pgtable.h
+Auto-merging arch/arm64/mm/pageattr.c
+Auto-merging arch/riscv/include/asm/pgtable.h
+Auto-merging arch/x86/kernel/cpu/sgx/encl.c
+Auto-merging fs/hugetlbfs/inode.c
+Auto-merging include/linux/mm.h
+Auto-merging mm/gup.c
+Auto-merging mm/huge_memory.c
+Auto-merging mm/hugetlb.c
+Auto-merging mm/kasan/kasan_test.c
+Auto-merging mm/memory-failure.c
+Auto-merging mm/memory.c
+Auto-merging mm/migrate.c
+Auto-merging mm/mmap.c
+Auto-merging mm/mprotect.c
+Auto-merging mm/shmem.c
+Auto-merging mm/slub.c
+Auto-merging mm/vmscan.c
+Merge made by the 'ort' strategy.
+ MAINTAINERS                                  |   12 +-
+ arch/alpha/include/asm/pgtable.h             |    2 -
+ arch/arc/include/asm/pgtable-bits-arcv2.h    |    2 -
+ arch/arm/include/asm/pgtable-nommu.h         |    2 -
+ arch/arm/include/asm/pgtable.h               |    4 -
+ arch/arm64/include/asm/pgtable.h             |    2 -
+ arch/arm64/mm/mmu.c                          |   47 --
+ arch/arm64/mm/pageattr.c                     |    3 +-
+ arch/csky/include/asm/pgtable.h              |    3 -
+ arch/hexagon/include/asm/page.h              |    7 -
+ arch/ia64/include/asm/pgtable.h              |   16 -
+ arch/ia64/mm/hugetlbpage.c                   |   15 -
+ arch/loongarch/include/asm/pgtable.h         |    2 -
+ arch/m68k/include/asm/pgtable_mm.h           |    2 -
+ arch/m68k/include/asm/pgtable_no.h           |    1 -
+ arch/microblaze/include/asm/pgtable.h        |    3 -
+ arch/mips/include/asm/pgtable.h              |    2 -
+ arch/nios2/include/asm/pgtable.h             |    2 -
+ arch/nios2/include/asm/processor.h           |    3 -
+ arch/openrisc/include/asm/pgtable.h          |    2 -
+ arch/parisc/include/asm/pgtable.h            |   15 -
+ arch/parisc/kernel/pdt.c                     |    5 +-
+ arch/powerpc/include/asm/pgtable.h           |    7 -
+ arch/powerpc/mm/hugetlbpage.c                |   37 -
+ arch/riscv/include/asm/pgtable.h             |    2 -
+ arch/s390/include/asm/pgtable.h              |    2 -
+ arch/sh/include/asm/pgtable.h                |    2 -
+ arch/sparc/include/asm/pgtable_32.h          |    6 -
+ arch/sparc/mm/init_32.c                      |    3 +-
+ arch/sparc/mm/init_64.c                      |    1 -
+ arch/um/include/asm/pgtable.h                |    2 -
+ arch/x86/include/asm/pgtable_32.h            |    9 -
+ arch/x86/include/asm/pgtable_64.h            |    1 -
+ arch/x86/kernel/cpu/sgx/encl.c               |    4 +-
+ arch/x86/mm/init_64.c                        |   41 -
+ arch/xtensa/include/asm/pgtable.h            |    2 -
+ drivers/acpi/numa/hmat.c                     |    7 +-
+ drivers/base/memory.c                        |   38 +
+ drivers/block/zram/zram_drv.c                |   13 +-
+ drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c      |    2 +-
+ fs/hugetlbfs/inode.c                         |   26 +-
+ fs/proc/kcore.c                              |   33 +-
+ include/linux/compiler-gcc.h                 |   21 +-
+ include/linux/hugetlb.h                      |  113 +--
+ include/linux/memory-tiers.h                 |    1 -
+ include/linux/memory.h                       |   18 +-
+ include/linux/mm.h                           |   32 +-
+ include/linux/mm_types.h                     |   14 +
+ include/linux/pagemap.h                      |    6 +-
+ include/linux/swap.h                         |    5 +-
+ include/linux/swapops.h                      |   24 +-
+ include/trace/events/vmalloc.h               |  123 +++
+ kernel/cgroup/cpuset.c                       |    7 +-
+ kernel/sysctl.c                              |    1 +
+ lib/Kconfig.kasan                            |    2 +-
+ mm/damon/Makefile                            |    6 +-
+ mm/damon/core.c                              |  262 +++---
+ mm/damon/lru_sort.c                          |   70 +-
+ mm/damon/modules-common.c                    |   42 +
+ mm/damon/modules-common.h                    |    3 +
+ mm/damon/reclaim.c                           |   72 +-
+ mm/damon/sysfs-common.c                      |  107 +++
+ mm/damon/sysfs-common.h                      |   46 +
+ mm/damon/sysfs-schemes.c                     | 1022 +++++++++++++++++++++=
++
+ mm/damon/sysfs.c                             | 1152 +--------------------=
-----
+ mm/debug_vm_pgtable.c                        |    8 +-
+ mm/filemap.c                                 |   28 +-
+ mm/folio-compat.c                            |    7 +-
+ mm/gup.c                                     |   80 +-
+ mm/gup_test.c                                |  141 ++++
+ mm/gup_test.h                                |   12 +
+ mm/huge_memory.c                             |   22 +-
+ mm/hugetlb.c                                 |  199 ++---
+ mm/internal.h                                |   12 +-
+ mm/kasan/kasan.h                             |    8 -
+ mm/kasan/kasan_test.c                        |  148 +++-
+ mm/kasan/kasan_test_module.c                 |   60 --
+ mm/kasan/report.c                            |   31 -
+ mm/kasan/shadow.c                            |    2 +-
+ mm/ksm.c                                     |    2 +-
+ mm/memcontrol.c                              |   32 +-
+ mm/memory-failure.c                          |  156 ++--
+ mm/memory-tiers.c                            |    2 +-
+ mm/memory.c                                  |    2 -
+ mm/migrate.c                                 |   21 +-
+ mm/mincore.c                                 |   14 +-
+ mm/mm_init.c                                 |    8 +-
+ mm/mmap.c                                    |    6 +-
+ mm/mprotect.c                                |    5 +-
+ mm/page_ext.c                                |    2 +-
+ mm/rmap.c                                    |   14 +-
+ mm/shmem.c                                   |   23 +-
+ mm/slub.c                                    |    7 +-
+ mm/sparse.c                                  |    2 -
+ mm/swap.c                                    |   25 +-
+ mm/swap.h                                    |    8 +-
+ mm/swap_state.c                              |   28 +-
+ mm/truncate.c                                |   30 +-
+ mm/vmalloc.c                                 |   20 +-
+ mm/vmscan.c                                  |    4 +-
+ mm/workingset.c                              |    2 +-
+ tools/testing/selftests/damon/Makefile       |    1 +
+ tools/testing/selftests/damon/lru_sort.sh    |   41 +
+ tools/testing/selftests/damon/reclaim.sh     |   42 +
+ tools/testing/selftests/vm/.gitignore        |    1 +
+ tools/testing/selftests/vm/Makefile          |   25 +-
+ tools/testing/selftests/vm/anon_cow.c        | 1126 +++++++++++++++++++++=
++++
+ tools/testing/selftests/vm/check_config.sh   |   31 +
+ tools/testing/selftests/vm/hugepage-mremap.c |   21 +-
+ tools/testing/selftests/vm/hugetlb-madvise.c |   12 +-
+ tools/testing/selftests/vm/madv_populate.c   |    8 -
+ tools/testing/selftests/vm/run_vmtests.sh    |   21 +-
+ tools/testing/selftests/vm/userfaultfd.c     |   62 +-
+ tools/testing/selftests/vm/vm_util.c         |   15 +
+ tools/testing/selftests/vm/vm_util.h         |    2 +
+ 115 files changed, 3712 insertions(+), 2406 deletions(-)
+ create mode 100644 include/trace/events/vmalloc.h
+ create mode 100644 mm/damon/modules-common.c
+ create mode 100644 mm/damon/sysfs-common.c
+ create mode 100644 mm/damon/sysfs-common.h
+ create mode 100644 mm/damon/sysfs-schemes.c
+ create mode 100644 tools/testing/selftests/damon/lru_sort.sh
+ create mode 100644 tools/testing/selftests/damon/reclaim.sh
+ create mode 100644 tools/testing/selftests/vm/anon_cow.c
+ create mode 100644 tools/testing/selftests/vm/check_config.sh
+Merging mm-nonmm-stable/mm-nonmm-stable (f0c4d9fc9cc9 Linux 6.1-rc4)
+$ git merge -m Merge branch 'mm-nonmm-stable' of git://git.kernel.org/pub/=
scm/linux/kernel/git/akpm/mm mm-nonmm-stable/mm-nonmm-stable
+Already up to date.
+Merging mm/mm-everything (fa2a6c31f1c0 Merge branch 'mm-nonmm-unstable' in=
to mm-everything)
+$ git merge -m Merge branch 'mm-everything' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/akpm/mm mm/mm-everything
+Auto-merging .clang-format
+Auto-merging Documentation/admin-guide/sysctl/kernel.rst
+Auto-merging MAINTAINERS
+Auto-merging arch/arm/kernel/machine_kexec.c
+Auto-merging arch/x86/kernel/traps.c
+Auto-merging drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+Auto-merging drivers/gpu/drm/nouveau/nouveau_dmem.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt2500usb.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt61pci.c
+Auto-merging drivers/net/wireless/ralink/rt2x00/rt73usb.c
+Auto-merging fs/btrfs/compression.c
+Auto-merging fs/coredump.c
+Auto-merging fs/erofs/zdata.c
+Auto-merging fs/ext4/inode.c
+Auto-merging fs/libfs.c
+Auto-merging fs/nilfs2/the_nilfs.c
+Auto-merging fs/squashfs/super.c
+Auto-merging include/linux/damon.h
+Auto-merging include/linux/fs.h
+Auto-merging include/linux/gfp.h
+CONFLICT (content): Merge conflict in include/linux/gfp.h
+Auto-merging include/linux/memremap.h
+Auto-merging include/linux/mm.h
+Auto-merging include/linux/pgtable.h
+Auto-merging include/linux/sched.h
+Auto-merging init/main.c
+Auto-merging kernel/fork.c
+Auto-merging kernel/sched/fair.c
+Auto-merging lib/Kconfig
+Auto-merging lib/Kconfig.debug
+Auto-merging lib/Makefile
+Auto-merging lib/fault-inject.c
+Auto-merging lib/maple_tree.c
+Auto-merging lib/test_printf.c
+Auto-merging mm/Kconfig
+Auto-merging mm/gup.c
+Auto-merging mm/huge_memory.c
+Auto-merging mm/hugetlb.c
+Auto-merging mm/hugetlb_vmemmap.c
+Auto-merging mm/khugepaged.c
+Auto-merging mm/memory-failure.c
+Auto-merging mm/memory.c
+Auto-merging mm/memremap.c
+Auto-merging mm/migrate.c
+Auto-merging mm/mprotect.c
+Auto-merging mm/shmem.c
+Auto-merging mm/swapfile.c
+Auto-merging mm/userfaultfd.c
+Auto-merging mm/vmscan.c
+Auto-merging tools/testing/radix-tree/maple.c
+CONFLICT (content): Merge conflict in tools/testing/radix-tree/maple.c
+Recorded preimage for 'include/linux/gfp.h'
+Resolved 'tools/testing/radix-tree/maple.c' using previous resolution.
+Automatic merge failed; fix conflicts and then commit the result.
+$ git commit --no-edit -v -a
+Recorded resolution for 'include/linux/gfp.h'.
+[master d581a02076a5] Merge branch 'mm-everything' of git://git.kernel.org=
/pub/scm/linux/kernel/git/akpm/mm
+$ git diff -M --stat --summary HEAD^..
+ .clang-format                                      |    1 +
+ Documentation/ABI/testing/sysfs-kernel-mm-damon    |   32 +
+ Documentation/admin-guide/blockdev/zram.rst        |  102 +-
+ Documentation/admin-guide/cgroup-v2.rst            |    6 +
+ Documentation/admin-guide/mm/damon/usage.rst       |   59 +-
+ Documentation/admin-guide/sysctl/kernel.rst        |    1 +
+ Documentation/dev-tools/kasan.rst                  |    4 +
+ Documentation/fault-injection/fault-injection.rst  |   10 +-
+ Documentation/filesystems/proc.rst                 |   25 +-
+ Documentation/mm/balance.rst                       |    2 +-
+ Documentation/mm/transhuge.rst                     |   34 +-
+ MAINTAINERS                                        |    2 +-
+ arch/arc/kernel/ptrace.c                           |    2 +-
+ arch/arm/kernel/machine_kexec.c                    |    2 +-
+ arch/arm/kernel/ptrace.c                           |    8 +-
+ arch/arm64/kernel/ptrace.c                         |   16 +-
+ arch/hexagon/kernel/ptrace.c                       |    7 +-
+ arch/ia64/include/asm/io.h                         |    4 -
+ arch/ia64/include/asm/kprobes.h                    |    2 -
+ arch/ia64/kernel/ptrace.c                          |   20 +-
+ arch/ia64/kernel/sys_ia64.c                        |    6 +-
+ arch/mips/kernel/ptrace.c                          |    9 +-
+ arch/nios2/kernel/ptrace.c                         |    6 +-
+ arch/openrisc/kernel/ptrace.c                      |    8 +-
+ arch/parisc/kernel/ptrace.c                        |   15 +-
+ arch/powerpc/include/asm/book3s/64/pgtable.h       |   80 +-
+ arch/powerpc/kernel/ptrace/ptrace-tm.c             |   10 +-
+ arch/powerpc/kernel/ptrace/ptrace-view.c           |   15 +-
+ arch/powerpc/kexec/file_load_64.c                  |    2 +-
+ arch/powerpc/kexec/ranges.c                        |    8 +-
+ arch/powerpc/kvm/book3s_hv_rm_mmu.c                |    2 +-
+ arch/powerpc/kvm/book3s_hv_uvmem.c                 |   12 +-
+ arch/sh/kernel/ptrace_32.c                         |    8 +-
+ arch/sparc/kernel/ptrace_32.c                      |    9 +-
+ arch/sparc/kernel/ptrace_64.c                      |   23 +-
+ drivers/Makefile                                   |    2 +-
+ drivers/block/zram/Kconfig                         |   55 +
+ drivers/block/zram/zcomp.c                         |    6 +-
+ drivers/block/zram/zcomp.h                         |    2 +-
+ drivers/block/zram/zram_drv.c                      |  519 ++++++++--
+ drivers/block/zram/zram_drv.h                      |   23 +-
+ drivers/dax/Kconfig                                |    5 +-
+ drivers/dax/Makefile                               |    1 +
+ drivers/dax/bus.c                                  |    9 +-
+ drivers/dax/dax-private.h                          |    2 +
+ drivers/dax/device.c                               |   73 +-
+ drivers/dax/mapping.c                              | 1089 +++++++++++++++=
+++++
+ drivers/dax/super.c                                |   10 +-
+ drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   15 +-
+ drivers/gpu/drm/nouveau/nouveau_dmem.c             |   12 +-
+ drivers/iommu/tegra-smmu.c                         |    4 +-
+ drivers/nvdimm/Kconfig                             |    3 +-
+ drivers/nvdimm/pmem.c                              |   47 +-
+ drivers/rapidio/devices/tsi721.c                   |    3 +-
+ fs/coredump.c                                      |    5 +
+ fs/dax.c                                           | 1069 ++-------------=
----
+ fs/debugfs/file.c                                  |   28 +-
+ fs/ext4/inode.c                                    |    9 +-
+ fs/fuse/dax.c                                      |    9 +-
+ fs/libfs.c                                         |   22 +-
+ fs/nilfs2/the_nilfs.c                              |   73 +-
+ fs/ocfs2/cluster/heartbeat.c                       |   38 +-
+ fs/ocfs2/cluster/heartbeat.h                       |    2 +-
+ fs/ocfs2/cluster/netdebug.c                        |    2 +-
+ fs/ocfs2/cluster/nodemanager.c                     |    2 +-
+ fs/ocfs2/cluster/tcp.c                             |    6 +-
+ fs/ocfs2/dlm/dlmcommon.h                           |    2 +-
+ fs/ocfs2/dlm/dlmdomain.c                           |   19 +-
+ fs/ocfs2/dlm/dlmmaster.c                           |   30 +-
+ fs/ocfs2/dlm/dlmrecovery.c                         |    2 +-
+ fs/ocfs2/stack_o2cb.c                              |    6 +-
+ fs/ocfs2/stackglue.c                               |    8 +-
+ fs/proc/cmdline.c                                  |    6 +-
+ fs/proc/fd.c                                       |   45 +
+ fs/proc/task_mmu.c                                 |   14 +-
+ fs/proc/vmcore.c                                   |    1 +
+ fs/squashfs/Kconfig                                |   51 +-
+ fs/squashfs/block.c                                |    2 +-
+ fs/squashfs/decompressor.c                         |    2 +-
+ fs/squashfs/decompressor_multi.c                   |   20 +-
+ fs/squashfs/decompressor_multi_percpu.c            |   23 +-
+ fs/squashfs/decompressor_single.c                  |   15 +-
+ fs/squashfs/squashfs.h                             |   23 +-
+ fs/squashfs/squashfs_fs_sb.h                       |    4 +-
+ fs/squashfs/super.c                                |  100 +-
+ fs/xfs/xfs_file.c                                  |    7 +-
+ fs/xfs/xfs_inode.c                                 |    4 +-
+ include/linux/coredump.h                           |    1 +
+ include/linux/damon.h                              |    5 +
+ include/linux/dax.h                                |  149 ++-
+ include/linux/debugfs.h                            |   19 +-
+ include/linux/freelist.h                           |  129 ---
+ include/linux/fs.h                                 |   12 +-
+ include/linux/gfp.h                                |   12 +
+ include/linux/gfp_types.h                          |   12 +-
+ include/linux/highmem.h                            |   45 +
+ include/linux/huge_mm.h                            |   26 +-
+ include/linux/hugetlb.h                            |   34 +-
+ include/linux/hugetlb_cgroup.h                     |   86 +-
+ include/linux/init.h                               |    1 +
+ include/linux/kasan.h                              |   11 +-
+ include/linux/kexec.h                              |    7 +-
+ include/linux/khugepaged.h                         |    6 +
+ include/linux/kprobes.h                            |    9 +-
+ include/linux/memremap.h                           |   39 +-
+ include/linux/minmax.h                             |   26 +-
+ include/linux/mm.h                                 |  168 +--
+ include/linux/mm_types.h                           |  152 +--
+ include/linux/mm_types_task.h                      |   13 -
+ include/linux/objpool.h                            |  153 +++
+ include/linux/page-flags.h                         |   21 -
+ include/linux/pagewalk.h                           |    5 +
+ include/linux/percpu_counter.h                     |   12 +-
+ include/linux/pgtable.h                            |   24 -
+ include/linux/regset.h                             |   15 +-
+ include/linux/rethook.h                            |   15 +-
+ include/linux/rmap.h                               |   12 +-
+ include/linux/sched.h                              |    3 -
+ include/linux/swap.h                               |   16 +-
+ include/linux/swapops.h                            |   49 +-
+ include/linux/vm_event_item.h                      |    3 +
+ include/linux/zsmalloc.h                           |   14 +-
+ include/trace/events/fs_dax.h                      |   16 +-
+ include/trace/events/huge_memory.h                 |   49 +-
+ include/trace/events/kmem.h                        |    8 +-
+ include/trace/events/mmflags.h                     |    1 -
+ init/initramfs.c                                   |    2 +-
+ init/main.c                                        |    7 +-
+ kernel/crash_core.c                                |    3 +
+ kernel/fork.c                                      |   16 +-
+ kernel/kexec_core.c                                |   10 +-
+ kernel/kexec_file.c                                |    2 +-
+ kernel/kprobes.c                                   |   95 +-
+ kernel/panic.c                                     |    5 +-
+ kernel/sched/fair.c                                |    2 +-
+ kernel/trace/fprobe.c                              |   17 +-
+ kernel/trace/rethook.c                             |   80 +-
+ lib/Kconfig                                        |   31 +-
+ lib/Kconfig.debug                                  |   13 +-
+ lib/Makefile                                       |    4 +-
+ lib/debugobjects.c                                 |   10 +
+ lib/fault-inject.c                                 |   22 +-
+ lib/fonts/fonts.c                                  |    4 +-
+ lib/llist.c                                        |    4 +-
+ lib/maple_tree.c                                   |   15 +-
+ lib/notifier-error-inject.c                        |    2 +-
+ lib/objpool.c                                      |  487 +++++++++
+ lib/oid_registry.c                                 |    1 -
+ lib/percpu_counter.c                               |   24 +-
+ lib/test_hmm.c                                     |   10 +-
+ lib/test_objpool.c                                 | 1052 +++++++++++++++=
++++
+ lib/test_printf.c                                  |    8 +-
+ mm/Kconfig                                         |    9 +-
+ mm/damon/core.c                                    |    6 +-
+ mm/damon/lru_sort.c                                |    3 +-
+ mm/damon/reclaim.c                                 |    3 +-
+ mm/damon/sysfs-common.h                            |   10 +
+ mm/damon/sysfs-schemes.c                           |  261 +++++
+ mm/damon/sysfs.c                                   |   77 +-
+ mm/debug.c                                         |    5 +-
+ mm/debug_vm_pgtable.c                              |   32 -
+ mm/folio-compat.c                                  |    6 -
+ mm/gup.c                                           |  144 +--
+ mm/huge_memory.c                                   |  151 ++-
+ mm/hugetlb.c                                       |  117 ++-
+ mm/hugetlb_cgroup.c                                |   63 +-
+ mm/hugetlb_vmemmap.c                               |   63 +-
+ mm/internal.h                                      |    2 +-
+ mm/kasan/common.c                                  |    9 +-
+ mm/kasan/hw_tags.c                                 |   26 +
+ mm/kasan/kasan.h                                   |   15 +
+ mm/khugepaged.c                                    |  291 ++++--
+ mm/kmemleak.c                                      |   48 +-
+ mm/ksm.c                                           |   87 +-
+ mm/madvise.c                                       |    7 +-
+ mm/memcontrol.c                                    |    8 +-
+ mm/memory-failure.c                                |    5 +-
+ mm/memory.c                                        |  143 +--
+ mm/mempool.c                                       |   18 +-
+ mm/memremap.c                                      |  114 +-
+ mm/migrate.c                                       |    4 +-
+ mm/mprotect.c                                      |   50 +-
+ mm/page_alloc.c                                    |   95 +-
+ mm/page_ext.c                                      |    2 +-
+ mm/page_table_check.c                              |    3 +-
+ mm/pagewalk.c                                      |   27 +-
+ mm/rmap.c                                          |  359 ++++---
+ mm/shmem.c                                         |   22 +-
+ mm/swap.c                                          |    2 -
+ mm/swapfile.c                                      |    2 +-
+ mm/usercopy.c                                      |    3 +-
+ mm/util.c                                          |   79 --
+ mm/vmscan.c                                        |   42 +-
+ mm/vmstat.c                                        |   17 +-
+ mm/zsmalloc.c                                      |  459 +++++++--
+ mm/zswap.c                                         |   37 +-
+ scripts/checkpatch.pl                              |   20 +-
+ scripts/spelling.txt                               |   33 +-
+ tools/accounting/procacct.c                        |    7 +-
+ tools/perf/builtin-kmem.c                          |    1 -
+ tools/testing/radix-tree/maple.c                   |    5 +-
+ tools/testing/selftests/cgroup/cgroup_util.c       |    5 +-
+ tools/testing/selftests/damon/Makefile             |    1 +
+ .../selftests/damon/debugfs_rm_non_contexts.sh     |   19 +
+ tools/testing/selftests/damon/sysfs.sh             |    7 +
+ tools/testing/selftests/proc/proc-uptime-002.c     |    3 +-
+ tools/testing/selftests/vm/.gitignore              |    2 +
+ tools/testing/selftests/vm/Makefile                |    2 +
+ tools/testing/selftests/vm/anon_cow.c              |   49 +-
+ tools/testing/selftests/vm/hugetlb-madvise.c       |    7 +-
+ tools/testing/selftests/vm/ksm_functional_tests.c  |  279 +++++
+ tools/testing/selftests/vm/ksm_tests.c             |   76 +-
+ tools/testing/selftests/vm/run_vmtests.sh          |  206 ++--
+ tools/testing/selftests/vm/vm_util.c               |   10 +
+ tools/testing/selftests/vm/vm_util.h               |    1 +
+ tools/vm/.gitignore                                |    1 +
+ 216 files changed, 7601 insertions(+), 3444 deletions(-)
+ create mode 100644 drivers/dax/mapping.c
+ delete mode 100644 include/linux/freelist.h
+ create mode 100644 include/linux/objpool.h
+ create mode 100644 lib/objpool.c
+ create mode 100644 lib/test_objpool.c
+ create mode 100644 tools/testing/selftests/damon/debugfs_rm_non_contexts.=
sh
+ create mode 100644 tools/testing/selftests/vm/ksm_functional_tests.c
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 37257a52287d..ec96872e3e5b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -253,6 +253,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_BG96			0x0296
 #define QUECTEL_PRODUCT_EP06			0x0306
 #define QUECTEL_PRODUCT_EM05G			0x030a
+#define QUECTEL_PRODUCT_EM05G_SG		0x0311
 #define QUECTEL_PRODUCT_EM060K			0x030b
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
@@ -1151,6 +1152,8 @@ static const struct usb_device_id option_ids[] =3D {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, =
0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G, 0x=
ff),
 	  .driver_info =3D RSVD(6) | ZLP },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_SG,=
 0xff),/* Quectel EM05G 4G LTE,Smart Gateway*/
+	  .driver_info =3D RSVD(6) | ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K=
, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K=
, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K=
, 0xff, 0xff, 0x40) },
diff --git a/localversion-next b/localversion-next
new file mode 100644
index 000000000000..c5980de3e986
--- /dev/null
+++ b/localversion-next
@@ -0,0 +1 @@
+-next-20221109
--=20
2.34.1

