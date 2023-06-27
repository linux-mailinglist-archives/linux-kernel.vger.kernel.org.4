Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5273FC27
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjF0MsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0MsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD6C26BA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687870049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scmLl+GUv3/9o3cooxWYS8MrJgKbkUBRuFLg/a2t5TQ=;
        b=YiQ0mFfohF3QAMyvgtECVDW7xQa9QK7uwG6TkNu9iutzEnb2Oh0HLP0c3Bw1Pl0X4nZv0m
        bRvwRte0C/+XrcNO7TpM7IT+E4tKOMN5etCL8WikoXpIV1znPGMhXKZ93+hblkD40Wli2I
        pmWT6p3GbBP7PAsAmX3jAxhudKV+4kY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-lFBZFN2xOhqdEXnOulnA1Q-1; Tue, 27 Jun 2023 08:47:27 -0400
X-MC-Unique: lFBZFN2xOhqdEXnOulnA1Q-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-401df9d2dc4so3987121cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870047; x=1690462047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scmLl+GUv3/9o3cooxWYS8MrJgKbkUBRuFLg/a2t5TQ=;
        b=XhhFaTMG+wCz+5H3/R2uygXh99k6d4mj0QWsKd7hT0vcOZYg9qF1qgi61IlkdqyXd/
         gf2gZUck9aEN9vtouVpjZZS35U4fehoKV53x55h9pYR/bQ3mQpjB+vRQj1SldfzW1WQI
         RRdfH/AOexrHWsikMuzpipZmI5jh3LFVxYNDhtCCcC8m5+rD7GzymShXZ8Rgo3rvhG2u
         YqNNFAVBA9QaI1EF/uKIW7ZY85nNsxH70+rcvZqZhYWLmrJhUdvzMx3gOJquQaV2l8/r
         V36pTYt+wS7txSySjK4wN0B4r3X3jhc00WBGer1ZYsArEgoYaSMcOV/x1T3pehBqtR8V
         TH9w==
X-Gm-Message-State: AC+VfDxVypTGsPrfWhYT39foUYHrnnNkAcrJd2sba6BnYt1PUVg3gZZO
        j2eIep/wwZsdaMon/aEif+CuxLiEarb4VcV6BI1Kj6PF3Hst/02jkvh/wncV0nfZO7dPMSFlXQ9
        hDstXLUnSEQO9fWSCgX6NITJD
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr38130141qvb.2.1687870047353;
        Tue, 27 Jun 2023 05:47:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nTkp5S5WlZpeXkTUPXXG6QpUi3yQvI4wyuMQU2wA+VUqsfuTw8Knys7hPmVjsiVxOEkWpBQ==
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr38130116qvb.2.1687870047012;
        Tue, 27 Jun 2023 05:47:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-6.dyn.eolo.it. [146.241.239.6])
        by smtp.gmail.com with ESMTPSA id ep8-20020a05621418e800b00630182f0191sm4505888qvb.1.2023.06.27.05.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:47:26 -0700 (PDT)
Message-ID: <8a832e3d2eb2e3fc14ade43c4feb1cbafc37c5d7.camel@redhat.com>
Subject: Re: [PATCH net] net: phy: mscc: fix packet loss due to RGMII delays
From:   Paolo Abeni <pabeni@redhat.com>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Harini Katakam <harini.katakam@amd.com>
Date:   Tue, 27 Jun 2023 14:47:22 +0200
In-Reply-To: <20230627121352.tsqycdvzyqqpdejb@skbuf>
References: <20230627091109.3374701-1-vladimir.oltean@nxp.com>
         <20230627121352.tsqycdvzyqqpdejb@skbuf>
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

On Tue, 2023-06-27 at 15:13 +0300, Vladimir Oltean wrote:
> On Tue, Jun 27, 2023 at 12:11:09PM +0300, Vladimir Oltean wrote:
> > Two deadly typos break RX and TX traffic on the VSC8502 PHY using RGMII
> > if phy-mode =3D "rgmii-id" or "rgmii-txid", and no "tx-internal-delay-p=
s"
> > override exists. The negative error code from phy_get_internal_delay()
> > does not get overridden with the delay deduced from the phy-mode, and
> > later gets committed to hardware. Also, the rx_delay gets overridden by
> > what should have been the tx_delay.
> >=20
> > Fixes: dbb050d2bfc8 ("phy: mscc: Add support for RGMII delay configurat=
ion")
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
>=20
> I may have mis-targeted this patch towards "net" while the "net-next"
> pull request has not been yet sent out. Can patchwork be instructed to
> re-run the tests on net-next?

I'm not 110% sure, but I think you have to re-send the patch with a
different prefix to achieve the above.

Cheers,

Paolo
>=20

