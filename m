Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADB3742F30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjF2VAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjF2VAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:00:22 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492BF30EC;
        Thu, 29 Jun 2023 14:00:19 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-443571eda4dso438474137.2;
        Thu, 29 Jun 2023 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688072418; x=1690664418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9x1of66GoGKJm83rKdv97QNqPEVlHrMB6O9/Tgb+NM=;
        b=GYTpaq60KEDWN6z1053O6y8XSFefrQXenGe97YGLdIoXhHgdURgm5egDpcM56m5JFA
         7ech1HkjRtvdUi7gunBGfLwyuA6/RS9eoehjr3HrwhBffSClxv+9ZpB59x/A81Jfmvp2
         p0+072eGs9rtSnJJbuhKqPJ2R+d1qakwACqnGPTskGeLhoGxC1zVb4WBksnxq6kjDxhc
         bgWQ1ubL1g4qkUap3/18wyr21txyLiCuaU0mCzWRSx11FJoVEGSYST8twBqhl7t1Q1fZ
         KRGLNA2XX9UVh9mRUt7To96O44WvtTCIm7OGUt7kTrVid0FsliKsSrjEgGpDJFERdavA
         akuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688072418; x=1690664418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9x1of66GoGKJm83rKdv97QNqPEVlHrMB6O9/Tgb+NM=;
        b=JTmNDHkycTzqkA7ged47PXLUBKfaqrCthTzaMxdTje9Bnlj+fb0Hpf5WnsQqiIWgve
         D8V4gQRBQAx9eEUTDFrYhoL/TzWjLUP9/29SSFxOSWv/17/LZM1WcSExLCnInWKmoGBa
         nZK5T8YuHmc9J64v4RipUAd84Zw+ECsYzJtUCk+j1yqbTRzqbTFDdFsXWhfN8B8nhBCT
         DDxk6Hew9dhVD3HVsJNH8yRto+YBWStMCsPGzQbaTLZu5sw9uOOSDnpLgguar8mHojsK
         znNma5X9r1hSxY2dspuexQWqMVUbBr2RiqCo8YygZpu20Z/vwE4TE6NpyUygHt+qj9f7
         ZkNQ==
X-Gm-Message-State: ABy/qLaPs9aNnQRbWELgDd0mgETPUoE4+no08Fcpc5JxsGB6CCmvbNtm
        Pb1Rh5X1yG3hzdaZY6gAeAC4ba5cC4BiTk56gSM=
X-Google-Smtp-Source: APBJJlG1N/KHMb/vyg94EDQLyXO1lnI5H5InODdM5CV/PybKrxM3R1rFVlzG1PVvJpF222PnWIa9R9ibMC1m5WXXWZA=
X-Received: by 2002:a05:6102:50d:b0:443:848b:b6c4 with SMTP id
 l13-20020a056102050d00b00443848bb6c4mr928297vsa.18.1688072417943; Thu, 29 Jun
 2023 14:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-4-paweldembicki@gmail.com> <20230625124719.6yn7z2r2kfds5kbv@skbuf>
In-Reply-To: <20230625124719.6yn7z2r2kfds5kbv@skbuf>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Thu, 29 Jun 2023 23:00:06 +0200
Message-ID: <CAJN1Kkxg4Q-EmDVTrgP4doYj-wwRxzujV_jT4NsMMhAK3P0cvw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/7] net: dsa: vsc73xx: Add dsa tagging based
 on 8021q
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 25 cze 2023 o 14:47 Vladimir Oltean <olteanv@gmail.com> napisa=C5=
=82(a):
>
> On Sun, Jun 25, 2023 at 01:53:39PM +0200, Pawel Dembicki wrote:
> > This patch is simple implementation of 8021q tagging in vsc73xx driver.
> > At this moment devices with DSA_TAG_PROTO_NONE are useless. VSC73XX
> > family doesn't provide any tag support for external ethernet ports.
> >
> > The only way is vlan-based tagging. It require constant hardware vlan
> > filtering. VSC73XX family support provider bridging but QinQ only witho=
ut
> > fully implemented 802.1AD. It allow only doubled 0x8100 TPID.
> >
> > In simple port mode QinQ is enabled to preserve forwarding vlan tagged
> > frames.
> >
> > Tag driver introduce most simple funcionality required for proper tagin=
g
> > support.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
> > v2:
> >   - change poll loop into dedicated macro
> >   - fix style issues
> >
> >  drivers/net/dsa/Kconfig                |   2 +-
> >  drivers/net/dsa/vitesse-vsc73xx-core.c | 532 +++++++++++++++++++++----
> >  include/net/dsa.h                      |   2 +
> >  net/dsa/Kconfig                        |   6 +
> >  net/dsa/Makefile                       |   1 +
> >  net/dsa/tag_vsc73xx_8021q.c            |  87 ++++
> >  6 files changed, 544 insertions(+), 86 deletions(-)
> >  create mode 100644 net/dsa/tag_vsc73xx_8021q.c
> >
> > diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> > index 3ed5391bb18d..4cf0166fef7b 100644
> > --- a/drivers/net/dsa/Kconfig
> > +++ b/drivers/net/dsa/Kconfig
> > @@ -125,7 +125,7 @@ config NET_DSA_SMSC_LAN9303_MDIO
> >
> >  config NET_DSA_VITESSE_VSC73XX
> >       tristate
> > -     select NET_DSA_TAG_NONE
> > +     select NET_DSA_TAG_VSC73XX
> >       select FIXED_PHY
> >       select VITESSE_PHY
> >       select GPIOLIB
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/v=
itesse-vsc73xx-core.c
> > index f123ce2ed244..f7c38f9a81a8 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> > +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/device.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_mdio.h>
> > @@ -25,6 +26,7 @@
> >  #include <linux/etherdevice.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/gpio/driver.h>
> > +#include <linux/dsa/8021q.h>
> >  #include <linux/random.h>
> >  #include <net/dsa.h>
> >
> > @@ -62,6 +64,8 @@
> >  #define VSC73XX_CAT_DROP     0x6e
> >  #define VSC73XX_CAT_PR_MISC_L2       0x6f
> >  #define VSC73XX_CAT_PR_USR_PRIO      0x75
> > +#define VSC73XX_CAT_VLAN_MISC        0x79
> > +#define VSC73XX_CAT_PORT_VLAN        0x7a
> >  #define VSC73XX_Q_MISC_CONF  0xdf
> >
> >  /* MAC_CFG register bits */
> > @@ -122,6 +126,17 @@
> >  #define VSC73XX_ADVPORTM_IO_LOOPBACK BIT(1)
> >  #define VSC73XX_ADVPORTM_HOST_LOOPBACK       BIT(0)
> >
> > +/*  TXUPDCFG transmit modify setup bits */
> > +#define VSC73XX_TXUPDCFG_DSCP_REWR_MODE      GENMASK(20, 19)
> > +#define VSC73XX_TXUPDCFG_DSCP_REWR_ENA       BIT(18)
> > +#define VSC73XX_TXUPDCFG_TX_INT_TO_USRPRIO_ENA       BIT(17)
> > +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID     GENMASK(15, 4)
> > +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA BIT(3)
> > +#define VSC73XX_TXUPDCFG_TX_UPDATE_CRC_CPU_ENA       BIT(1)
> > +#define VSC73XX_TXUPDCFG_TX_INSERT_TAG       BIT(0)
> > +
> > +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT 4
> > +
> >  /* CAT_DROP categorizer frame dropping register bits */
> >  #define VSC73XX_CAT_DROP_DROP_MC_SMAC_ENA    BIT(6)
> >  #define VSC73XX_CAT_DROP_FWD_CTRL_ENA                BIT(4)
> > @@ -135,6 +150,15 @@
> >  #define VSC73XX_Q_MISC_CONF_EARLY_TX_512     (1 << 1)
> >  #define VSC73XX_Q_MISC_CONF_MAC_PAUSE_MODE   BIT(0)
> >
> > +/* CAT_VLAN_MISC categorizer VLAN miscellaneous bits*/
> > +#define VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA BIT(8)
> > +#define VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA BIT(7)
> > +
> > +/* CAT_PORT_VLAN categorizer port VLAN*/
> > +#define VSC73XX_CAT_PORT_VLAN_VLAN_CFI BIT(15)
> > +#define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
> > +#define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
> > +
> >  /* Frame analyzer block 2 registers */
> >  #define VSC73XX_STORMLIMIT   0x02
> >  #define VSC73XX_ADVLEARN     0x03
> > @@ -189,7 +213,8 @@
> >  #define VSC73XX_VLANACCESS_VLAN_MIRROR               BIT(29)
> >  #define VSC73XX_VLANACCESS_VLAN_SRC_CHECK    BIT(28)
> >  #define VSC73XX_VLANACCESS_VLAN_PORT_MASK    GENMASK(9, 2)
> > -#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK GENMASK(2, 0)
> > +#define VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT      2
> > +#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK GENMASK(1, 0)
> >  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE 0
> >  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY   1
> >  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY  2
> > @@ -344,6 +369,13 @@ static const struct vsc73xx_counter vsc73xx_tx_cou=
nters[] =3D {
> >       { 29, "TxQoSClass3" }, /* non-standard counter */
> >  };
> >
> > +enum vsc73xx_port_vlan_conf {
> > +     VSC73XX_VLAN_UNAWARE,
> > +     VSC73XX_VLAN_AWARE,
> > +     VSC73XX_DOUBLE_VLAN_AWARE,
> > +     VSC73XX_DOUBLE_VLAN_CPU_AWARE,
> > +};
> > +
> >  int vsc73xx_is_addr_valid(u8 block, u8 subblock)
> >  {
> >       switch (block) {
> > @@ -558,90 +590,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_proto=
col(struct dsa_switch *ds,
> >        * cannot access the tag. (See "Internal frame header" section
> >        * 3.9.1 in the manual.)
> >        */
> > -     return DSA_TAG_PROTO_NONE;
> > -}
> > -
> > -static int vsc73xx_setup(struct dsa_switch *ds)
> > -{
> > -     struct vsc73xx *vsc =3D ds->priv;
> > -     int i;
> > -
> > -     dev_info(vsc->dev, "set up the switch\n");
> > -
> > -     /* Issue RESET */
> > -     vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
> > -                   VSC73XX_GLORESET_MASTER_RESET);
> > -     usleep_range(125, 200);
> > -
> > -     /* Initialize memory, initialize RAM bank 0..15 except 6 and 7
> > -      * This sequence appears in the
> > -      * VSC7385 SparX-G5 datasheet section 6.6.1
> > -      * VSC7395 SparX-G5e datasheet section 6.6.1
> > -      * "initialization sequence".
> > -      * No explanation is given to the 0x1010400 magic number.
> > -      */
> > -     for (i =3D 0; i <=3D 15; i++) {
> > -             if (i !=3D 6 && i !=3D 7) {
> > -                     vsc73xx_write(vsc, VSC73XX_BLOCK_MEMINIT,
> > -                                   2,
> > -                                   0, 0x1010400 + i);
> > -                     mdelay(1);
> > -             }
> > -     }
> > -     mdelay(30);
> > -
> > -     /* Clear MAC table */
> > -     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > -                   VSC73XX_MACACCESS,
> > -                   VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
> > -
> > -     /* Clear VLAN table */
> > -     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > -                   VSC73XX_VLANACCESS,
> > -                   VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
> > -
> > -     msleep(40);
> > -
> > -     /* Use 20KiB buffers on all ports on VSC7395
> > -      * The VSC7385 has 16KiB buffers and that is the
> > -      * default if we don't set this up explicitly.
> > -      * Port "31" is "all ports".
> > -      */
> > -     if (IS_739X(vsc))
> > -             vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, 0x1f,
> > -                           VSC73XX_Q_MISC_CONF,
> > -                           VSC73XX_Q_MISC_CONF_EXTENT_MEM);
> > -
> > -     /* Put all ports into reset until enabled */
> > -     for (i =3D 0; i < 7; i++) {
> > -             if (i =3D=3D 5)
> > -                     continue;
> > -             vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, 4,
> > -                           VSC73XX_MAC_CFG, VSC73XX_MAC_CFG_RESET);
> > -     }
> > -
> > -     /* MII delay, set both GTX and RX delay to 2 ns */
> > -     vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
> > -                   VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
> > -                   VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
> > -     /* IP multicast flood mask (table 144) */
> > -     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
> > -                   0xff);
> > -
> > -     mdelay(50);
> > -
> > -     /*configure forward map to CPU <-> port only*/
> > -     for (i =3D 0; i < vsc->ds->num_ports; i++)
> > -             vsc->forward_map[i] =3D VSC73XX_SRCMASKS_PORTS_MASK & BIT=
(CPU_PORT);
> > -     vsc->forward_map[CPU_PORT] =3D VSC73XX_SRCMASKS_PORTS_MASK & ~BIT=
(CPU_PORT);
> > -
> > -     /* Release reset from the internal PHYs */
> > -     vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
> > -                   VSC73XX_GLORESET_PHY_RESET);
> > -
> > -     udelay(4);
> > -
> > -     return 0;
>
> Try to make this code movement part of a separate patch. It's
> distracting and makes it hard to see what really changed.
>
> > +     return DSA_TAG_PROTO_VSC73XX_8021Q;
> >  }
> >
> >  static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
> > @@ -1078,6 +1027,417 @@ static void vsc73xx_port_stp_state_set(struct d=
sa_switch *ds, int port,
> >                                   VSC73XX_SRCMASKS_PORTS_MASK, 0);
> >  }
> >
> > +static int
> > +vsc73xx_port_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
> > +{
> > +     u32 val;
> > +     int ret, err;
> > +
> > +     ret =3D read_poll_timeout(vsc73xx_read, err,
> > +                             err < 0 || ((val & VSC73XX_VLANACCESS_VLA=
N_TBL_CMD_MASK) =3D=3D
> > +                                         VSC73XX_VLANACCESS_VLAN_TBL_C=
MD_IDLE),
> > +                             1000, 10000, false, vsc, VSC73XX_BLOCK_AN=
ALYZER,
> > +                             0, VSC73XX_VLANACCESS, &val);
> > +     if (ret)
> > +             return ret;
> > +     return err;
> > +}
> > +
> > +static int
> > +vsc73xx_port_read_vlan_table_entry(struct dsa_switch *ds, u16 vid, u8 =
*portmap)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u32 val;
> > +     int ret;
> > +
> > +     if (vid > 4095)
> > +             return -EPERM;
>
> Unnecessary defensive programming.
>
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, v=
id);
> > +     ret =3D vsc73xx_port_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANA=
CCESS,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY);
> > +     ret =3D vsc73xx_port_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS, =
&val);
> > +     *portmap =3D (val & VSC73XX_VLANACCESS_VLAN_PORT_MASK) >>
> > +                VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT;
> > +     return 0;
> > +}
> > +
> > +static int
> > +vsc73xx_port_write_vlan_table_entry(struct dsa_switch *ds, u16 vid, u8=
 portmap)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     int ret;
> > +
> > +     if (vid > 4095)
> > +             return -EPERM;
>
> Unnecessary defensive programming.
>
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, v=
id);
> > +     ret =3D vsc73xx_port_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANA=
CCESS,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK |
> > +                         VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> > +                         VSC73XX_VLANACCESS_VLAN_PORT_MASK,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY |
> > +                         VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> > +                         (portmap <<
> > +                          VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT));
> > +     ret =3D vsc73xx_port_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
> > +     return 0;
> > +}
> > +
> > +static int
> > +vsc73xx_port_update_vlan_table(struct dsa_switch *ds, int port, u16 vi=
d,
> > +                            bool set)
> > +{
> > +     u8 portmap;
> > +     int ret;
> > +
> > +     if (vid > 4095)
> > +             return -EPERM;
>
> Unnecessary defensive programming.
>
> > +
> > +     ret =3D vsc73xx_port_read_vlan_table_entry(ds, vid, &portmap);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (set)
> > +             portmap |=3D BIT(port) | BIT(CPU_PORT);
> > +     else
> > +             portmap &=3D ~BIT(port);
> > +
> > +     if (portmap =3D=3D BIT(CPU_PORT))
> > +             portmap =3D 0;
> > +
> > +     ret =3D vsc73xx_port_write_vlan_table_entry(ds, vid, portmap);
> > +
> > +     return ret;
>
> return vsc73xx_port_write_vlan_table_entry(...)
>
> > +}
> > +
> > +static void
> > +vsc73xx_port_set_vlan_conf(struct dsa_switch *ds, int port,
> > +                        enum vsc73xx_port_vlan_conf port_vlan_conf)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +
> > +     if (port_vlan_conf =3D=3D VSC73XX_VLAN_UNAWARE) {
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_MAC_CFG,
> > +                                 VSC73XX_MAC_CFG_VLAN_AWR, 0);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_MAC_CFG,
> > +                                 VSC73XX_MAC_CFG_VLAN_DBLAWR, 0);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_VLAN_MISC,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE=
_ENA,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE=
_ENA);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_VLAN_MISC,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_E=
NA,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_E=
NA);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_DROP,
> > +                                 VSC73XX_CAT_DROP_TAGGED_ENA, 0);
> > +     } else {
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_MAC_CFG,
> > +                                 VSC73XX_MAC_CFG_VLAN_AWR,
> > +                                 VSC73XX_MAC_CFG_VLAN_AWR);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_DROP,
> > +                                 VSC73XX_CAT_DROP_TAGGED_ENA, 0);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_DROP,
> > +                                 VSC73XX_CAT_DROP_UNTAGGED_ENA,
> > +                                 VSC73XX_CAT_DROP_UNTAGGED_ENA);
> > +
> > +             if (port_vlan_conf =3D=3D VSC73XX_DOUBLE_VLAN_CPU_AWARE)
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_MAC_CFG,
> > +                                         VSC73XX_MAC_CFG_VLAN_DBLAWR,
> > +                                         VSC73XX_MAC_CFG_VLAN_DBLAWR);
> > +             else
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_MAC_CFG,
> > +                                         VSC73XX_MAC_CFG_VLAN_DBLAWR, =
0);
> > +
> > +             if (port_vlan_conf =3D=3D VSC73XX_DOUBLE_VLAN_AWARE) {
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_CAT_VLAN_MISC,
> > +                                         VSC73XX_CAT_VLAN_MISC_VLAN_TC=
I_IGNORE_ENA,
> > +                                         VSC73XX_CAT_VLAN_MISC_VLAN_TC=
I_IGNORE_ENA);
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_CAT_VLAN_MISC,
> > +                                         VSC73XX_CAT_VLAN_MISC_VLAN_KE=
EP_TAG_ENA,
> > +                                         VSC73XX_CAT_VLAN_MISC_VLAN_KE=
EP_TAG_ENA);
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_TXUPDCFG,
> > +                                         VSC73XX_TXUPDCFG_TX_INSERT_TA=
G, 0);
> > +             } else {
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_CAT_VLAN_MISC,
> > +                                         VSC73XX_CAT_VLAN_MISC_VLAN_TC=
I_IGNORE_ENA,
> > +                                         0);
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_CAT_VLAN_MISC,
> > +                                         VSC73XX_CAT_VLAN_MISC_VLAN_KE=
EP_TAG_ENA,
> > +                                         0);
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_TXUPDCFG,
> > +                                         VSC73XX_TXUPDCFG_TX_INSERT_TA=
G,
> > +                                         VSC73XX_TXUPDCFG_TX_INSERT_TA=
G);
> > +             }
> > +
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_TXUPDCFG,
> > +                                 VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA,=
 0);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_TXUPDCFG,
> > +                                 VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_PORT_VLAN,
> > +                                 VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
> > +     }
> > +}
> > +
>
> I need some time to understand what is being done here.
>
> > +static int vsc73xx_port_set_double_vlan_aware(struct dsa_switch *ds, i=
nt port)
> > +{
> > +     int i, ret;
> > +
> > +     if (port =3D=3D CPU_PORT)
> > +             vsc73xx_port_set_vlan_conf(ds, port,
> > +                                        VSC73XX_DOUBLE_VLAN_CPU_AWARE)=
;
> > +     else
> > +             vsc73xx_port_set_vlan_conf(ds, port,
> > +                                        VSC73XX_DOUBLE_VLAN_AWARE);
> > +
> > +     for (i =3D 0; i <=3D 4095; i++) {
>
> i < VLAN_N_VID
>
> > +             ret =3D vsc73xx_port_update_vlan_table(ds, port, i, 0);
> > +             if (ret)
> > +                     return ret;
>
> Clearing the VLAN table absolutely does not belong in a function that
> makes a port aware of double VLANs. And neither does it belong in a
> function that changes VLAN awareness, but that's not part of this patch,
> but 6/7. The bridge expects the VLAN table to be able to be populated
> asynchronously relative to enabling/disabling it. The same for the
> VLAN-aware FDB and MDB entries.
>
> > +     }
> > +     return ret;
> > +}
> > +
> > +static int vsc73xx_vlan_set_untagged(struct dsa_switch *ds, int port, =
u16 vid,
> > +                                  bool port_vlan)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u16 vlan_no;
> > +     u32 val;
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val=
);
> > +
> > +     if (port_vlan && (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA)) {
> > +             vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDC=
FG,
> > +                          &val);
> > +             vlan_no =3D (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
> > +                             VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
> > +             if (!vid_is_dsa_8021q(vlan_no) && !vid_is_dsa_8021q(vid) =
&&
> > +                 vlan_no !=3D vid) {
> > +                     dev_warn(vsc->dev,
> > +                              "Port %d can have only one untagged vid!=
 Now is: %d.\n",
> > +                              port, vlan_no);
> > +                             return -EPERM;
>
> drop indentation by 1 level
>
> don't return -EPERM, as that indicates a permissions-related issue to
> the user process. Perhaps -EOPNOTSUPP.
>
> use the extack for the message.. we now also have NL_SET_ERR_MSG_FMT()
>
> > +             }
> > +     }
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DRO=
P,
> > +                         VSC73XX_CAT_DROP_UNTAGGED_ENA, 0);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID,
> > +                         (vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIF=
T) &
> > +                          VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);
> > +     return 0;
> > +}
> > +
> > +static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 =
vid,
> > +                              bool port_vlan)
> > +{
> > +     struct dsa_port *dsa_port =3D dsa_to_port(ds, port);
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u16 vlan_no;
> > +     u32 val;
> > +
> > +     if (!dsa_port)
> > +             return -EINVAL;
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,=
 &val);
> > +     vlan_no =3D val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
> > +
> > +     if (port_vlan && vlan_no && !vid_is_dsa_8021q(vlan_no) &&
> > +         !vid_is_dsa_8021q(vid) && vlan_no !=3D vid) {
> > +             dev_warn(vsc->dev,
> > +                      "Port %d can have only one pvid! Now is: %d.\n",
> > +                      port, vlan_no);
> > +             return -EPERM;
> > +     }
> > +
> > +     if (dsa_port_is_vlan_filtering(dsa_port))
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_VLAN_MISC,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE=
_ENA,
> > +                                 0);
> > +     else
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_VLAN_MISC,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE=
_ENA,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE=
_ENA);
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLA=
N_MISC,
> > +                         VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA,
> > +                         VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA);
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_POR=
T_VLAN,
> > +                         VSC73XX_CAT_PORT_VLAN_VLAN_VID,
> > +                         vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
>
> Why would changing the PVID (what this function does) alter VLAN_TCI_IGNO=
RE_ENA
> and VLAN_KEEP_TAG_ENA?
>
> > +     return 0;
> > +}
> > +
> > +static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port,=
 u16 vid,
> > +                                   u16 flags)
> > +{
> > +     bool untagged =3D flags & BRIDGE_VLAN_INFO_UNTAGGED;
> > +     bool pvid =3D flags & BRIDGE_VLAN_INFO_PVID;
> > +     int ret;
> > +
> > +     if (untagged) {
> > +             ret =3D vsc73xx_vlan_set_untagged(ds, port, vid, false);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     if (pvid) {
> > +             ret =3D vsc73xx_vlan_set_pvid(ds, port, vid, false);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     ret =3D vsc73xx_port_update_vlan_table(ds, port, vid, 1);
>
> return vsc73xx_port_update_vlan_table(...)
>
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port,=
 u16 vid)
> > +{
> > +     return vsc73xx_port_update_vlan_table(ds, port, vid, 0);
> > +}
> > +
> > +static int vsc73xx_setup(struct dsa_switch *ds)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     int i, ret;
> > +
> > +     dev_info(vsc->dev, "set up the switch\n");
> > +
> > +     ds->vlan_filtering_is_global =3D false;
>
> No reason to set this, it's false by default.
>
> > +     ds->configure_vlan_while_not_filtering =3D false;
>
> This is a legacy flag that should be set to true (default value) for all
> drivers and then eliminated.
>
> To check whether your implementation is doing the right thing, you must
> remove this line, and make sure that after this configuration:
>
> ip link add br0 type bridge vlan_filtering 0
> ip link set swp0 master br0
> bridge vlan add dev swp0 vid 100 pvid untagged
>
> the VLAN-unaware forwarding of the switch is not affected. This means
> that the PVID of the port that is committed to hardware (and thus, the
> allowed destination port mask) must remain what the driver set it to,
> while the bridge vlan_filtering option is not enabled. The hardware PVID
> must only follow the bridge port PVID while in vlan_filtering=3Dtrue mode=
.
>
> > +
> > +     /* Issue RESET */
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
> > +                   VSC73XX_GLORESET_MASTER_RESET);
> > +     usleep_range(125, 200);
> > +
> > +     /* Initialize memory, initialize RAM bank 0..15 except 6 and 7
> > +      * This sequence appears in the
> > +      * VSC7385 SparX-G5 datasheet section 6.6.1
> > +      * VSC7395 SparX-G5e datasheet section 6.6.1
> > +      * "initialization sequence".
> > +      * No explanation is given to the 0x1010400 magic number.
> > +      */
> > +     for (i =3D 0; i <=3D 15; i++) {
> > +             if (i !=3D 6 && i !=3D 7) {
> > +                     vsc73xx_write(vsc, VSC73XX_BLOCK_MEMINIT,
> > +                                   2,
> > +                                   0, 0x1010400 + i);
> > +                     mdelay(1);
> > +             }
> > +     }
> > +     mdelay(30);
> > +
> > +     /* Clear MAC table */
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                   VSC73XX_MACACCESS,
> > +                   VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
> > +
> > +     /* Clear VLAN table */
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                   VSC73XX_VLANACCESS,
> > +                   VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
> > +
> > +     msleep(40);
> > +
> > +     /* Use 20KiB buffers on all ports on VSC7395
> > +      * The VSC7385 has 16KiB buffers and that is the
> > +      * default if we don't set this up explicitly.
> > +      * Port "31" is "all ports".
> > +      */
> > +     if (IS_739X(vsc))
> > +             vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, 0x1f,
> > +                           VSC73XX_Q_MISC_CONF,
> > +                           VSC73XX_Q_MISC_CONF_EXTENT_MEM);
> > +
> > +     /* Put all ports into reset until enabled */
> > +     for (i =3D 0; i < 7; i++) {
> > +             if (i =3D=3D 5)
> > +                     continue;
> > +             vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, 4,
> > +                           VSC73XX_MAC_CFG, VSC73XX_MAC_CFG_RESET);
> > +     }
> > +
> > +     /* MII delay, set both GTX and RX delay to 2 ns */
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
> > +                   VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
> > +                   VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
> > +     /* Ingess VLAN reception mask (table 145) */
>
> s/ingess/ingress/
>
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
> > +                   0x5f);
> > +     /* IP multicast flood mask (table 144) */
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
> > +                   0xff);
> > +
> > +     mdelay(50);
> > +
> > +     for (i =3D 0; i < vsc->ds->num_ports; i++) {
> > +             if (i =3D=3D 5)
> > +                     continue;
>
> dsa_switch_for_each_available_port()
>
> > +             ret =3D vsc73xx_port_set_double_vlan_aware(ds, i);
> > +             if (ret)
> > +                     return ret;
>
> If ports are made VLAN-aware by default (including in standalone mode),
> shouldn't this be reflected in ds->needs_standalone_vlan_filtering?
>

Not for QinQ. Hardware filtering without vlan_filtering=3D1 is used only
for separation of outer vlans.

> > +     }
> > +
> > +     rtnl_lock();
> > +     ret =3D dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
> > +     rtnl_unlock();
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*configure forward map to CPU <-> port only*/
>
> style: space after /* and before */ (also present in a few other places)
>
> > +     for (i =3D 0; i < vsc->ds->num_ports; i++)
> > +             vsc->forward_map[i] =3D VSC73XX_SRCMASKS_PORTS_MASK &
> > +                                   BIT(CPU_PORT);
> > +     vsc->forward_map[CPU_PORT] =3D VSC73XX_SRCMASKS_PORTS_MASK &
> > +                                  ~BIT(CPU_PORT);
> > +
> > +     /* Release reset from the internal PHYs */
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
> > +                   VSC73XX_GLORESET_PHY_RESET);
> > +
> > +     udelay(4);
> > +
> > +     return 0;
> > +}
> > +
> >  static const struct dsa_switch_ops vsc73xx_ds_ops =3D {
> >       .get_tag_protocol =3D vsc73xx_get_tag_protocol,
> >       .setup =3D vsc73xx_setup,
> > @@ -1095,6 +1455,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops=
 =3D {
> >       .port_change_mtu =3D vsc73xx_change_mtu,
> >       .port_max_mtu =3D vsc73xx_get_max_mtu,
> >       .port_stp_state_set =3D vsc73xx_port_stp_state_set,
> > +     .tag_8021q_vlan_add =3D vsc73xx_tag_8021q_vlan_add,
> > +     .tag_8021q_vlan_del =3D vsc73xx_tag_8021q_vlan_del,
> >  };
> >
> >  static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offse=
t)
> > diff --git a/include/net/dsa.h b/include/net/dsa.h
> > index 75022cf771cf..2440df7ea6c9 100644
> > --- a/include/net/dsa.h
> > +++ b/include/net/dsa.h
> > @@ -56,6 +56,7 @@ struct phylink_link_state;
> >  #define DSA_TAG_PROTO_RTL8_4T_VALUE          25
> >  #define DSA_TAG_PROTO_RZN1_A5PSW_VALUE               26
> >  #define DSA_TAG_PROTO_LAN937X_VALUE          27
> > +#define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE    28
> >
> >  enum dsa_tag_protocol {
> >       DSA_TAG_PROTO_NONE              =3D DSA_TAG_PROTO_NONE_VALUE,
> > @@ -86,6 +87,7 @@ enum dsa_tag_protocol {
> >       DSA_TAG_PROTO_RTL8_4T           =3D DSA_TAG_PROTO_RTL8_4T_VALUE,
> >       DSA_TAG_PROTO_RZN1_A5PSW        =3D DSA_TAG_PROTO_RZN1_A5PSW_VALU=
E,
> >       DSA_TAG_PROTO_LAN937X           =3D DSA_TAG_PROTO_LAN937X_VALUE,
> > +     DSA_TAG_PROTO_VSC73XX_8021Q     =3D DSA_TAG_PROTO_VSC73XX_8021Q_V=
ALUE,
> >  };
> >
> >  struct dsa_switch;
> > diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> > index 8e698bea99a3..e59360071c67 100644
> > --- a/net/dsa/Kconfig
> > +++ b/net/dsa/Kconfig
> > @@ -166,6 +166,12 @@ config NET_DSA_TAG_TRAILER
> >         Say Y or M if you want to enable support for tagging frames at
> >         with a trailed. e.g. Marvell 88E6060.
> >
> > +config NET_DSA_TAG_VSC73XX_8021Q
> > +     tristate "Tag driver for Microchip/Vitesse VSC73xx family of swit=
ches, using VLAN"
> > +     help
> > +       Say Y or M if you want to enable support for tagging frames wit=
h a
> > +       custom VLAN-based header.
> > +
>
> Separate patches for the tagger and for the driver infrastructure please.
> It's hard to review.
>
> Also, there's some very strange splitting between this patch and 6/7
> ("net: dsa: vsc73xx: Add vlan filtering"). I would have expected that to
> contain the basic infrastructure (thus appearing first), then the
> driver-side tag_8021q infra, then the tagger. It's impossible for me to
> comment on things that have to do with VLAN infrastructure when it's
> split between 2 patches.

I will rework it: move vsc73xx_setup movement to a different commit,
the same with tagger code and squash all vlan stuff. In this version,
I decided to make tag 8021q first, because it's impossible/very hard
to use and test the driver with TAG_NONE at this moment.

--
Pawel Dembicki
