Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4873873FF59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjF0PMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjF0PM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:12:29 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5703626AE;
        Tue, 27 Jun 2023 08:12:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b69a48368fso44750401fa.0;
        Tue, 27 Jun 2023 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687878746; x=1690470746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZIgd4fYB3ByX3RTUvZ0WYtgm0ZduaW6wVx4c6DcS14=;
        b=VgKsMi5C9k9JCKxrscWXA3mexVMQsNCH+inlV15GbcfLm8bG5s8ml1IMGIOa30cWNP
         WJBSsoMcCCs7sbN1fD4EMgyUy8XczB3sK2YnqVxp7+CHceFk+YgIWOccO+pHd+wbNtgt
         IPbJ5W06O4zcRwVxD4l7o7tTZsSWA/5grkMHuxAkW7tTwOd81jjQQWlLt0wjqtLf8CRa
         8MOnAEWm0bHXH5wD+OmEIzZElNzU/oMcHSRhor3JW5BMDG+b6vy/NmiX8pALqfPO4URU
         MhdL74MpzUF37HPxKdqsW7yKVEH3WewO5oNTR8QK4GEIi+KSVbg9k6JxoFvud//Wb60j
         BlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878746; x=1690470746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZIgd4fYB3ByX3RTUvZ0WYtgm0ZduaW6wVx4c6DcS14=;
        b=Hd1pHLnkNRZH4/W6TUDj08zz1aKyo27OhAWFm4qpAa8x3WM10y1TKimM+Eytvn4lls
         NNDHL49B4Whv8hdR0cbuzkszfTQrEHQ1HulRPkdW7yYXdrJ9TXoKdbeDpuKUqL0sFhMH
         uZBOWyw+KWIcIxQleAvqRO3GauNhHAcHNNHKyB2E6dEi949gmLHzD7BX7qCQ/iFwvx+p
         VYTfUyQ166LCPb7RtubIBlke5dfXh2MGesY8fDn0sj6k7RIKipf7hyh9CQRO7dGG/UCm
         eIDYiFCnf8PBs+3aEjreSSDoMlDsaweQs/xrTjxTOv5+rQFqN5YlKyHLjeh1+wJXJNrz
         TxDA==
X-Gm-Message-State: AC+VfDy8/cIiXJ7DYby4kO0iApdaSSq04tU7dd2TwtjRq0YqEbyCwqm2
        utkYJFqrqw/JmVthfkUYw5o=
X-Google-Smtp-Source: ACHHUZ7mRHIZs2QvUdX//EueZe/Ou9/OGafY8K3OZ0KvRoLjTb7jllH2Ph86dszLqocVNl0GaEJ+Ng==
X-Received: by 2002:a2e:3502:0:b0:2b6:98c3:7a70 with SMTP id z2-20020a2e3502000000b002b698c37a70mr5719398ljz.41.1687878745573;
        Tue, 27 Jun 2023 08:12:25 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id pg9-20020a170907204900b00977e0bcff1esm4726178ejb.10.2023.06.27.08.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:12:25 -0700 (PDT)
Date:   Tue, 27 Jun 2023 18:12:22 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: dsa: felix: don't drop PTP frames with
 tag_8021q when RX timestamping is disabled
Message-ID: <20230627151222.bn3vboqjutkqzxjs@skbuf>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
 <20230626154003.3153076-4-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626154003.3153076-4-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:40:03PM +0300, Vladimir Oltean wrote:
>  drivers/net/dsa/ocelot/felix.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> index 80861ac090ae..7b494d975073 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -1725,6 +1725,9 @@ static bool felix_rxtstamp(struct dsa_switch *ds, int port,
>  	u32 tstamp_hi;
>  	u64 tstamp;
>  
> +	if (ocelot->ports[port]->ptp_rx_filter == HWTSTAMP_FILTER_NONE)
> +		return false;
> +
>  	/* If the "no XTR IRQ" workaround is in use, tell DSA to defer this skb
>  	 * for RX timestamping. Then free it, and poll for its copy through
>  	 * MMIO in the CPU port module, and inject that into the stack from
> -- 
> 2.34.1
> 
> 

This is still not as good as I had wanted it, because simply checking
for HWTSTAMP_FILTER_NONE does not distinguish between L2 and L4
timestamping filters, and a port configured just with L2 traps will
still drop L4 PTP packets.

Preparing a v2.
