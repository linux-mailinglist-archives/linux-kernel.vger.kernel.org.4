Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8F73D19C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjFYPGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFYPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:05:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B91B3;
        Sun, 25 Jun 2023 08:05:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so6260115a12.1;
        Sun, 25 Jun 2023 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687705555; x=1690297555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSpyPajMPQCL7QO936iVJJJbVVW1InEfqHEd1jhNJMQ=;
        b=XAdFwY0ZjPfdhgmPx1vrnC59Dys1lQIYWPTEsfU8A9FuUoJUYYSl0tv0hPvhycS5JE
         RZhdQ7R0+PQrARhSwklPNieiMicLqbzIsH9KWgEt4sga1LXAFBb3+/dfLY8xwDGS3FpG
         W40P/329TMGKI0VrjXrj1zTSd77gdWbisrBaFuugUrRnRo/GQcOY9KzKUDtLyK2QTJtw
         nzIyB3zLi8NOfbb4OPjTk6o6CB6StAWTnWx8HM1pW96Hxqrdi0Z0otpnDkSVDl1VZhls
         qiTV98Y93Dy8T7IFJiDOfU6ilk3FMoqt0c1DPty+Qp7iuQuR5m21Jpk2mFV99tKjh7x5
         KwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687705555; x=1690297555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSpyPajMPQCL7QO936iVJJJbVVW1InEfqHEd1jhNJMQ=;
        b=SRXg2hgr2PzOXCXOC69+RzF7E8DQfda8AF8VcJZFO/FsXXtzW6xrWozjAM7DiIT02x
         RC6QP9VhCxJVWsOwY/Nwz3fRPAQJuxwumyx4FsMfum3mwpEiEPdGBPYz7Fa5BgDtju0H
         WTfBJGFbtOZ70qb3S19+z7w98kiJy6b4S8Wqh9CM1VB3Pv7JW6xCkp6pD9J6HhEU0961
         TQGdgK53fx+3TcDE9stOkFr05sdEPnnDCHSdhBqpJEr+bQ8QI9S6bBe4aXFmy08snMm9
         /uofN+T8lP6l3XnPerOhq6yVqaGbDK7SKLQe9jEIb8l2v3eCOEPQ+iYq8I26irJBDAU4
         nt0w==
X-Gm-Message-State: AC+VfDwTlOhweUvnna426wvN8jtxqW0GCRAazzX4m+uO29e0YhW1ce1C
        yJggnLjNbe+ooXgFYQCsxVE=
X-Google-Smtp-Source: ACHHUZ5WiUMWJ3qICIgmerm0LBAfWnk+/IDPFNXeTJrQtXE/gD48y1zXO1CdV991kkWvlwC/NNcHOA==
X-Received: by 2002:a17:907:96a7:b0:98e:4f1:f987 with SMTP id hd39-20020a17090796a700b0098e04f1f987mr3303992ejc.3.1687705555038;
        Sun, 25 Jun 2023 08:05:55 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id k12-20020a1709063e0c00b0098e2eaec394sm1086510eji.101.2023.06.25.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 08:05:54 -0700 (PDT)
Date:   Sun, 25 Jun 2023 18:05:52 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/7] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20230625150552.sljrgm6rqodmefq5@skbuf>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-6-paweldembicki@gmail.com>
 <20230625115343.1603330-6-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625115343.1603330-6-paweldembicki@gmail.com>
 <20230625115343.1603330-6-paweldembicki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 01:53:41PM +0200, Pawel Dembicki wrote:
> This patch implement vlan filtering for vsc73xx driver.
> 
> After vlan filtering start, switch is reconfigured from QinQ to simple
> vlan aware mode. It's required, because VSC73XX chips haven't support
> for inner vlan tag filter.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v2:
>   - no changes done
> 
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 101 +++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index 457eb7fddf4c..c946464489ab 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -1226,6 +1226,30 @@ static int vsc73xx_port_set_double_vlan_aware(struct dsa_switch *ds, int port)
>  	return ret;
>  }
>  
> +static int
> +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> +			    bool vlan_filtering, struct netlink_ext_ack *extack)
> +{
> +	int ret, i;
> +
> +	if (vlan_filtering) {
> +		vsc73xx_port_set_vlan_conf(ds, port, VSC73XX_VLAN_AWARE);
> +	} else {
> +		if (port == CPU_PORT)
> +			vsc73xx_port_set_vlan_conf(ds, port, VSC73XX_DOUBLE_VLAN_CPU_AWARE);
> +		else
> +			vsc73xx_port_set_vlan_conf(ds, port, VSC73XX_DOUBLE_VLAN_AWARE);
> +	}

Why do you need ports to be double VLAN aware when vlan_filtering=0?
Isn't VLAN_TCI_IGNORE_ENA sufficient to ignore the 802.1Q header from
incoming packets, and set up the PVIDs of user ports as egress-tagged on
the CPU port?

> +
> +	for (i = 0; i <= 3072; i++) {
> +		ret = vsc73xx_port_update_vlan_table(ds, port, i, 0);
> +		if (ret)
> +			return ret;
> +	}

What is the purpose of this?

> +
> +	return ret;
> +}
> +
>  static int vsc73xx_vlan_set_untagged(struct dsa_switch *ds, int port, u16 vid,
>  				     bool port_vlan)
>  {
> @@ -1304,6 +1328,80 @@ static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 vid,
>  	return 0;
>  }
>  
> +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan,
> +				 struct netlink_ext_ack *extack)
> +{
> +	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	int ret;
> +
> +	/* Be sure to deny alterations to the configuration done by tag_8021q.
> +	 */
> +	if (vid_is_dsa_8021q(vlan->vid)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Range 3072-4095 reserved for dsa_8021q operation");
> +		return -EBUSY;
> +	}
> +
> +	if (untagged && port != CPU_PORT) {
> +		ret = vsc73xx_vlan_set_untagged(ds, port, vlan->vid, true);
> +		if (ret)
> +			return ret;
> +	}
> +	if (pvid && port != CPU_PORT) {

Missing logic to change hardware PVID only while VLAN-aware, and to
restore the tag_8021q PVID when the bridge VLAN awareness gets disabled.
DSA does not resolve the conflicts on resources between .port_vlan_add()
and .tag_8021q_vlan_add(), the driver must do that.

> +		ret = vsc73xx_vlan_set_pvid(ds, port, vlan->vid, true);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = vsc73xx_port_update_vlan_table(ds, port, vlan->vid, 1);
> +
> +	return ret;

Style: return vsc73xx_port_update_vlan_table(...)

> +}
> +
> +static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	u16 vlan_no;
> +	int ret;
> +	u32 val;
> +
> +	ret =
> +	    vsc73xx_port_update_vlan_table(ds, port, vlan->vid, 0);

Style: single line

> +	if (ret)
> +		return ret;
> +
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val);
> +
> +	if (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA) {
> +		vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port,
> +			     VSC73XX_TXUPDCFG, &val);
> +		vlan_no = (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
> +			  VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
> +		if (vlan_no == vlan->vid) {
> +			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +					    VSC73XX_TXUPDCFG,
> +					    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA,
> +					    0);
> +			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +					    VSC73XX_TXUPDCFG,
> +					    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);
> +		}
> +	}
> +
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN, &val);
> +	vlan_no = val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
> +	if (vlan_no && vlan_no == vlan->vid) {
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				    VSC73XX_CAT_PORT_VLAN,
> +				    VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);

As documented in Documentation/networking/switchdev.rst:

When the bridge has VLAN filtering enabled and a PVID is not configured on the
ingress port, untagged and 802.1p tagged packets must be dropped. When the bridge
has VLAN filtering enabled and a PVID exists on the ingress port, untagged and
priority-tagged packets must be accepted and forwarded according to the
bridge's port membership of the PVID VLAN. When the bridge has VLAN filtering
disabled, the presence/lack of a PVID should not influence the packet
forwarding decision.

Setting the hardware PVID to 0 when the bridge PVID is deleted sounds
like it accomplishes none of those.

> +	}
> +
> +	return 0;
> +}
> +
>  static void vsc73xx_update_forwarding_map(struct vsc73xx *vsc)
>  {
>  	int i;
> @@ -1524,6 +1622,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.port_change_mtu = vsc73xx_change_mtu,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
>  	.port_stp_state_set = vsc73xx_port_stp_state_set,
> +	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
> +	.port_vlan_add = vsc73xx_port_vlan_add,
> +	.port_vlan_del = vsc73xx_port_vlan_del,
>  	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
>  	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
>  };
> -- 
> 2.34.1
> 

