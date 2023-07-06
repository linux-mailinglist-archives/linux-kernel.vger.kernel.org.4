Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51A8749755
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjGFITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGFITp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBFE199F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688631540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lx+lBJ29CFsk81sGY8QIW/lXN8O5LUUJoAktsDtK8dk=;
        b=FzitJ6+8f7c1o4hQR1zoWkg0sZqF12jPsIxtq8uNLlgVjz9K3wmPLqoxFl8IrY5gZZzFx5
        4nyc2t6qBB1jDC0ncLCU5+LaFkB3tNFxP/ZHfHzq78f5MfzwrKiSkBAhLsdVlvyW0DJQgN
        hUghHf3F7vmQhlXxL31/VjVEwPtAH3U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-8f1DXIDkMu-kz0_IXEFzBA-1; Thu, 06 Jul 2023 04:18:59 -0400
X-MC-Unique: 8f1DXIDkMu-kz0_IXEFzBA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-767a1ad2175so8780785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631539; x=1691223539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx+lBJ29CFsk81sGY8QIW/lXN8O5LUUJoAktsDtK8dk=;
        b=UHL5U7Uh3nLVfapFINgpXl6nqDSKFqv7yb2ES3G8MJbfmePWDR1BpcOvoHg8OgxH8X
         fxfOfOuAEIKM/2APLvVCF1wKQdY9fsw6nBK33yDsqCTxkAWbh6fF0eTaUnDlg7Zs2FQ1
         7fpn/lbp8BxuxfsjIamwUyCoHBq7FP5OtgUAsSaD5jb2dS9zcGKdNQuiLg3yUavHAPzl
         VhpRDn9wkKdX2rURf6ZAH0P31PD9COrK5M8w9WeKmM34RTgu3+C4sGfQq9v27oJ0i4cs
         Z58bY4vFAdr8HOLtmHuW1RqO1cQ+ruNXyqgfagpwxjEcGcpgbFl9IJiinx9DIhS8kRLB
         0o6Q==
X-Gm-Message-State: ABy/qLbuYp+etX3U7mDzz0erFjGU4q36CvwdkZCSskF28U8vfgPPhZ68
        grnZdpjTCBuAd9AzQsii/Z5oyj9ylzdHp2Lcef5gX2PQmQOzvJt8HPlucbYMROsIlZ5RFwrp6wv
        8FkeJHvLN2E+f4o5BjhXQBimu
X-Received: by 2002:a05:6214:411c:b0:62b:5410:322d with SMTP id kc28-20020a056214411c00b0062b5410322dmr1222409qvb.6.1688631539316;
        Thu, 06 Jul 2023 01:18:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlIzKkGbc7Mhe75o6I7OvXujWZEcDlXrKdSN6nbMjmBM78UrxpGipZsStzvrEN62Vz4TceNw==
X-Received: by 2002:a05:6214:411c:b0:62b:5410:322d with SMTP id kc28-20020a056214411c00b0062b5410322dmr1222386qvb.6.1688631538999;
        Thu, 06 Jul 2023 01:18:58 -0700 (PDT)
Received: from gerbillo.redhat.com (host-95-248-55-118.retail.telecomitalia.it. [95.248.55.118])
        by smtp.gmail.com with ESMTPSA id e4-20020a0caa44000000b006300e92ea02sm591634qvb.121.2023.07.06.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:18:58 -0700 (PDT)
Message-ID: <062d9a4a0ec07e0c498fb7c6b8aab9d27177b21a.camel@redhat.com>
Subject: Re: [PATCH V5 net] net: mana: Fix MANA VF unload when hardware is
 unresponsive
From:   Paolo Abeni <pabeni@redhat.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, longli@microsoft.com, sharmaajay@microsoft.com,
        leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     stable@vger.kernel.org, schakrabarti@microsoft.com
Date:   Thu, 06 Jul 2023 10:18:51 +0200
In-Reply-To: <1688544973-2507-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1688544973-2507-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-05 at 01:16 -0700, Souradeep Chakrabarti wrote:
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
>=20
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.
>=20
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network=
 Adapter (MANA)")
> ---
> V4 -> V5:
> * Added fixes tag
> * Changed the usleep_range from static to incremental value.
> * Initialized timeout in the begining.
> ---
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

the changelog should come after the SoB tag, and there should be no '--
- ' separator before the SoB.

Please double-check your patch with the checkpatch script before the
next submission, it should catch trivial issues as the above one.

> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 30 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index a499e460594b..56b7074db1a2 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2345,9 +2345,13 @@ int mana_attach(struct net_device *ndev)
>  static int mana_dealloc_queues(struct net_device *ndev)
>  {
>  	struct mana_port_context *apc =3D netdev_priv(ndev);
> +	unsigned long timeout =3D jiffies + 120 * HZ;
>  	struct gdma_dev *gd =3D apc->ac->gdma_dev;
>  	struct mana_txq *txq;
> +	struct sk_buff *skb;
> +	struct mana_cq *cq;
>  	int i, err;
> +	u32 tsleep;
> =20
>  	if (apc->port_is_up)
>  		return -EINVAL;
> @@ -2363,15 +2367,33 @@ static int mana_dealloc_queues(struct net_device =
*ndev)
>  	 * to false, but it doesn't matter since mana_start_xmit() drops any
>  	 * new packets due to apc->port_is_up being false.
>  	 *
> -	 * Drain all the in-flight TX packets
> +	 * Drain all the in-flight TX packets.
> +	 * A timeout of 120 seconds for all the queues is used.
> +	 * This will break the while loop when h/w is not responding.
> +	 * This value of 120 has been decided here considering max
> +	 * number of queues.
>  	 */
> +
>  	for (i =3D 0; i < apc->num_queues; i++) {
>  		txq =3D &apc->tx_qp[i].txq;
> -
> -		while (atomic_read(&txq->pending_sends) > 0)
> -			usleep_range(1000, 2000);
> +		tsleep =3D 1000;
> +		while (atomic_read(&txq->pending_sends) > 0 &&
> +		       time_before(jiffies, timeout)) {
> +			usleep_range(tsleep, tsleep << 1);
> +			tsleep <<=3D 1;
> +		}
>  	}
> =20
> +	for (i =3D 0; i < apc->num_queues; i++) {
> +		txq =3D &apc->tx_qp[i].txq;
> +		cq =3D &apc->tx_qp[i].tx_cq;

The above variable is unused, and causes a build warning. Please remove
the assignment and the variable declaration.

Thanks,

Paolo

