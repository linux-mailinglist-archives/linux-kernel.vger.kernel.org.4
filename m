Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1273DC58
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFZKhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFZKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:37:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D41E6E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:37:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31114b46d62so3760033f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687775868; x=1690367868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mazsyDBwrMqG5cEUSpRqrjh566EgZQcI5mBml02mWjc=;
        b=ps9ioohUWbRYRydhRdQsMTVaFXqwiDVVAZ+fYu6xJb/RLr2MssXofL2L3LoaICvJMG
         vk3dCHNEDu2tq+mimqfw1D/JbHTx3D3zzEOQ8QIaBY4jnPYv6pA7u4NO2YRz8PwFUkyh
         tTeRFtvspqeTZuXjeWfcYhrUmDUMe2mNFysW7D2yq+HNxttvnbRwsgDSYSrl6msiB6ZO
         OJ3jSnWIL/DHddZKQcysyj1hC3lj0ZAtSDPA6N0iPAjYI2CtRETylN2cImVRvdrp75IZ
         YgMdRX55SILdGKz4DzPbf0v07cLmTUywzVKqsFccd7Ntl1UNrD0QsNpnXSqFOCEfvZgH
         dApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687775868; x=1690367868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mazsyDBwrMqG5cEUSpRqrjh566EgZQcI5mBml02mWjc=;
        b=JUF/gqNShsvMr32XQEGWD2mL+ef8cAgoyt8pzo7hrEagh7sHpnVDI26FYqAc3J8W2E
         Kd0mR78H6h3gzKxkirKaTlacGwvF1M+dxUGEbKQXEC3OgbsRVPauvXsp9LuB1GLajONr
         GTq/j153gcK3XQ7QxpGstYYQbG9fbE4wgKQ2Vah2pcQgBh+44p52+VoU0avGhFtmwyjr
         BfA4E3QpB3GSk0ChqYe3o9foqTxu/xv8r5C7zdGQxpdLEiepsCqMAPvAiUcQanKXFk/5
         Esy+4uV+Cir2vwvOHf1UBcwdTIIczUh1DSZy1/9ENEMeqXcYKlde7ZqfKs63c1jCjVzW
         jt6A==
X-Gm-Message-State: AC+VfDwOuOu3oivdGWbWkqin7I2d2aWeDrQ5rch9OcIVj/r4JaXCAd6p
        d/d49TyBiS15rkVkNVAZa5Kd6g==
X-Google-Smtp-Source: ACHHUZ724E7vxj2fO8DWKaLgeoKm3k+N9Fq+/lIIwMmp3b2A+v7VFnjyYF5tesfwTBBxp4KnRokOKA==
X-Received: by 2002:adf:fa06:0:b0:30f:bdc5:c150 with SMTP id m6-20020adffa06000000b0030fbdc5c150mr25240310wrr.33.1687775867720;
        Mon, 26 Jun 2023 03:37:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j14-20020adfff8e000000b003112dbc3257sm6840973wrr.90.2023.06.26.03.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 03:37:46 -0700 (PDT)
Date:   Mon, 26 Jun 2023 13:37:41 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: dsa: vsc73xx: Add dsa tagging based
 on 8021q
Message-ID: <8b34df96-daed-4b71-9281-3a7b8a315c90@kadam.mountain>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-4-paweldembicki@gmail.com>
 <ZJg2M+Qvg3Fv73CH@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJg2M+Qvg3Fv73CH@corigine.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 02:42:27PM +0200, Simon Horman wrote:
> + Dan Carpenter
> 
> On Sun, Jun 25, 2023 at 01:53:39PM +0200, Pawel Dembicki wrote:
> > This patch is simple implementation of 8021q tagging in vsc73xx driver.
> > At this moment devices with DSA_TAG_PROTO_NONE are useless. VSC73XX
> > family doesn't provide any tag support for external ethernet ports.
> > 
> > The only way is vlan-based tagging. It require constant hardware vlan
> > filtering. VSC73XX family support provider bridging but QinQ only without
> > fully implemented 802.1AD. It allow only doubled 0x8100 TPID.
> > 
> > In simple port mode QinQ is enabled to preserve forwarding vlan tagged
> > frames.
> > 
> > Tag driver introduce most simple funcionality required for proper taging
> > support.
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> ...
> 
> > +static void vsc73xx_vlan_rcv(struct sk_buff *skb, int *source_port,
> > +			     int *switch_id, int *vbid, u16 *vid)
> > +{
> > +	if (vid_is_dsa_8021q(skb_vlan_tag_get(skb) & VLAN_VID_MASK))
> > +		return dsa_8021q_rcv(skb, source_port, switch_id, vbid);
> > +
> > +	/* Try our best with imprecise RX */
> > +	*vid = skb_vlan_tag_get(skb) & VLAN_VID_MASK;
> > +}
> > +
> > +static struct sk_buff *vsc73xx_rcv(struct sk_buff *skb,
> > +				   struct net_device *netdev)
> > +{
> > +	int src_port = -1, switch_id = -1, vbid = -1;
> > +	u16 vid;
> > +
> > +	if (skb_vlan_tag_present(skb))
> > +		/* Normal traffic path. */
> > +		vsc73xx_vlan_rcv(skb, &src_port, &switch_id, &vbid, &vid);
> > +
> > +	if (vbid >= 1)
> > +		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
> > +	else if (src_port == -1 || switch_id == -1)
> > +		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
> 
> Hi Pawel,
> 
> Smatch warns that vid may be used uninitialised here.
> And it's not clear to me why that cannot be the case.
> 

The problem is only when skb_vlan_tag_present() is false.

If vsc73xx_vlan_rcv() is called then actually it's fine.  Either vbid,
src_port and switch_id will be set or vid will be initialized.  Smatch
thinks the vbid is set to 0-7, src_port is set to 0-15 and
switch_id is set to 0-7.  Smatch kind of ignores the switch_id == -1
condition because it's known to be false given that we already checked
src_port == -1.

But the concern again is the skb_vlan_tag_present() is false and then
vbid, src_port and switch_id would all be set to -1.

regards,
dan carpenter

