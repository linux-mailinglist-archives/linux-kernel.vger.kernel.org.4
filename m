Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86190742357
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjF2Jhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjF2Jhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F268CE6C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688031406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYG1165Me8KXJ6bBjdSoZbHbdY4Mqr1aH4o7+E05ySg=;
        b=Zinf1KLgaLMvrWYH8bsVzRM9jXQ+R7a7EP9R8Ch2TOxWby6iHwLn7VpGdaiC7miO+/qS3J
        wq8KQ+x9nwI4CaMFhiEoJTU9RxvtT5txi+rf5nZWjOTQCCtDR62C/ekiEAZlt+PaJwrqT+
        X/EmG0H+lQ5DoAbvj5yiON75saTP+IE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-oZJ_V7o1O0q3fHnK0wIUZg-1; Thu, 29 Jun 2023 05:36:44 -0400
X-MC-Unique: oZJ_V7o1O0q3fHnK0wIUZg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635eb5b04e1so1257206d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688031403; x=1690623403;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYG1165Me8KXJ6bBjdSoZbHbdY4Mqr1aH4o7+E05ySg=;
        b=citGqu63UP/IDIFi9qCG1W/F+Qy9Vyt3BnYec+uhIeOTj5NgzfeQrlk1osMci/Nwir
         Yghhzmq/XXpHt9bYkZZgEj19tsUxyvJXLShAqEQ51PtNkqBaWeTFDZmZdeVU3crqZZ5q
         QJP5NFjOzikJ70C30jsaHLydVOE2AVio8bedr1P17G9XvulUCcaV/ViY29SqEf2+KF6Z
         mmQ8YQQ8uLZUPWC9mGpNwxSNpsnltVHxsH2Km+9V4cpMhPuDa/RyKJsqXvc6kNkMMnRC
         OKdRJ/Kw8mbalsV/r6+ztY7Dh9K4TtZOU2EMYkMtDbLXx61UZQtiMdwZMRDWSItQjR+7
         anJQ==
X-Gm-Message-State: AC+VfDwVc4EtGZtDAeesEin4mctxI/8IbtKs1ih/+RDjYXvAroL6K/Zp
        zrxGqdwoOqxJ65R4Z3VanaCDD12KZebH6TkeKebSrM8KOqTgTVqOKbuwp1sX8EshZw5V1Ggwyz1
        KZt+jFo5GoU+x0dExdeHN/VVu
X-Received: by 2002:a05:6214:2685:b0:635:d9d0:cccf with SMTP id gm5-20020a056214268500b00635d9d0cccfmr15599000qvb.4.1688031403300;
        Thu, 29 Jun 2023 02:36:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BmkCKu61s65/tlTA6LaHGRA7CUgp6qEKNNQ7/tTCVQYIODra+A0gDSS6lCTkjsGr5mKXp1Q==
X-Received: by 2002:a05:6214:2685:b0:635:d9d0:cccf with SMTP id gm5-20020a056214268500b00635d9d0cccfmr15598986qvb.4.1688031403003;
        Thu, 29 Jun 2023 02:36:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id j5-20020a056214032500b00636056961c6sm1532031qvu.75.2023.06.29.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:36:42 -0700 (PDT)
Message-ID: <f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com>
Subject: Re: [PATCH v2 net 1/2] net: dsa: sja1105: always enable the
 INCL_SRCPT option
From:   Paolo Abeni <pabeni@redhat.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 29 Jun 2023 11:36:38 +0200
In-Reply-To: <20230627094207.3385231-2-vladimir.oltean@nxp.com>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
         <20230627094207.3385231-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-27 at 12:42 +0300, Vladimir Oltean wrote:
> Link-local traffic on bridged SJA1105 ports is sometimes tagged by the
> hardware with source port information (when the port is under a VLAN
> aware bridge).
>=20
> The tag_8021q source port identification has become more loose
> ("imprecise") and will report a plausible rather than exact bridge port,
> when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
> traffic always needs to know the precise source port.
>=20
> Modify the driver logic (and therefore: the tagging protocol itself) to
> always include the source port information with link-local packets,
> regardless of whether the port is standalone, under a VLAN-aware or
> VLAN-unaware bridge. This makes it possible for the tagging driver to
> give priority to that information over the tag_8021q VLAN header.
>=20
> The big drawback with INCL_SRCPT is that it makes it impossible to
> distinguish between an original MAC DA of 01:80:C2:XX:YY:ZZ and
> 01:80:C2:AA:BB:ZZ, because the tagger just patches MAC DA bytes 3 and 4
> with zeroes. Only if PTP RX timestamping is enabled, the switch will
> generate a META follow-up frame containing the RX timestamp and the
> original bytes 3 and 4 of the MAC DA. Those will be used to patch up the
> original packet. Nonetheless, in the absence of PTP RX timestamping, we
> have to live with this limitation, since it is more important to have
> the more precise source port information for link-local traffic.

What if 2 different DSA are under the same linux bridge, so that the
host has to forward in S/W the received frames? (and DA is incomplete)

It looks like that such frames will never reach the relevant
destination?

Is such setup possible/relevant?

Thanks,

Paolo

