Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63DC7199DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjFAKdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjFAKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E1112F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685615544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6q+KX/k75E+rVt3X94R2L8nrTARAGFfCqIAPs9yXJ4=;
        b=d5TWbnAahJuGyTlXW45bl+QedvlG0I5oWETKrE6BAPUxP9pGQyUk8iPvljqWXOjCwchPnW
        L8ze3hVEwv0CXRmNzSvOMsoOI5nWHDt+fg/eqLYQgFzLXrdi6fDa6umhKT7jiMRIpERYq9
        mgZtUPqQ3kT9GMJ7/td++8228aAxYyE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-4QhbAvjpNhKzqtAq0xxX3Q-1; Thu, 01 Jun 2023 06:32:23 -0400
X-MC-Unique: 4QhbAvjpNhKzqtAq0xxX3Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-626380298d3so1811546d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685615543; x=1688207543;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6q+KX/k75E+rVt3X94R2L8nrTARAGFfCqIAPs9yXJ4=;
        b=AX1xgwLOl7inmP6nzS5PdXxT715l9H6qA1YKQM/+k5hodCA0teB9EkEKzgOIRZ0/6Q
         KbkUozL3IyRGcDGU0HwFN/wdSfg8gAf6pVOk15/AwEc2SLR7VND6V4jvzb1eB8w60fqy
         UZrzINpIo157qGj+m+Gxz9BpLwQ0WKKDKa+iOVuw+wkvTn9zeIp5GjWMWjGbLKxi9svj
         QfKQK6XqwUAUhkn6YGfDWf6BcEYJEKGk8bdNZ5G631JkgLJmrvjStcTAbXTmXMOMPcuM
         K3lB00DpKekojVIX7gskSxaj+x/cXHrII29YWCzP1c3L92B868Xt8egLhBPG5b19eGFR
         tyqQ==
X-Gm-Message-State: AC+VfDyImfJ0ltT7J1RGCFSLXl4z79hmUvsOo/6/DYrkfb5ywt9sRHoi
        ZZsoCwASDcw6rH+3c4924PeHQoQ3hLEanlyVHt3JuNFhavYfMNWX6Ooesiy/dT0R+tmvOllb5p/
        LXglbI+8n+PLFKX43Kb3wzzjx
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id f5-20020a056214076500b005edc96eca4amr5389571qvz.1.1685615543129;
        Thu, 01 Jun 2023 03:32:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ckZ4+GL4Jleu8XE76qHE243+7UyCyLw+kBF8DtpalXlVScxWqzj59eNGhXZSEb6jBTj5UIQ==
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id f5-20020a056214076500b005edc96eca4amr5389550qvz.1.1685615542837;
        Thu, 01 Jun 2023 03:32:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-89.dyn.eolo.it. [146.241.242.89])
        by smtp.gmail.com with ESMTPSA id d10-20020ac8534a000000b003e69d6792f6sm7459431qto.45.2023.06.01.03.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:32:22 -0700 (PDT)
Message-ID: <d36ba731c063b3ddace873926cc773426c55ca4a.camel@redhat.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Increase wait after reset
 deactivation
From:   Paolo Abeni <pabeni@redhat.com>
To:     Andreas Svensson <andreas.svensson@axis.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, kernel@axis.com,
        Baruch Siach <baruch@tkos.co.il>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Jun 2023 12:32:19 +0200
In-Reply-To: <f89e203a-af77-9661-1003-0e9370ff6fab@axis.com>
References: <20230530145223.1223993-1-andreas.svensson@axis.com>
         <be44dfe3-b4cb-4fd5-b4bd-23eec4bd401c@lunn.ch>
         <f89e203a-af77-9661-1003-0e9370ff6fab@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-01 at 11:10 +0200, Andreas Svensson wrote:
> On 5/30/23 19:28, Andrew Lunn wrote:
> > On Tue, May 30, 2023 at 04:52:23PM +0200, Andreas Svensson wrote:
> > > A switch held in reset by default needs to wait longer until we can
> > > reliably detect it.
> > >=20
> > > An issue was observed when testing on the Marvell 88E6393X (Link Stre=
et).
> > > The driver failed to detect the switch on some upstarts. Increasing t=
he
> > > wait time after reset deactivation solves this issue.
> > >=20
> > > The updated wait time is now also the same as the wait time in the
> > > mv88e6xxx_hardware_reset function.
> >=20
> > Do you have an EEPROM attached and content in it?
>=20
> There's no EEPROM attached to the switch in our design.
>=20
> >=20
> > It is not necessarily the reset itself which is the problem, but how
> > long it takes after the reset to read the contents of the
> > EEPROM. While it is doing that, is does not respond on the MDIO
> > bus. Which is why mv88e6xxx_hardware_reset() polls for that to
> > complete.
>=20
> Ok, yes that makes sense. I could add the mv88e6xxx_g1_wait_eeprom_done
> function after the reset deactivation.
>=20
> >=20
> > I know there are some users who want the switch to boot as fast as
> > possible, and don't really want the additional 9ms delay. But this is
> > also a legitimate change. I'm just wondering if we need to consider a
> > DT property here for those with EEPROM content. Or, if there is an
> > interrupt line, wait for the EEPROM complete interrupt. We just have
> > tricky chicken and egg problems. At this point in time, we don't
> > actually know if the devices exists or not.
> >=20
> > 	  Andrew
>=20
> It just seems like we need to wait longer for the switch 88E6393X
> until it responds reliably on the MDIO bus. But I'm open to adding
> a new DT property if that's needed.
>=20
> The datasheet for 88E6393X also states that it needs at least 10ms
> before it's ready. But I suppose this varies from switch to switch.

I read the above as a new version of this fix is coming, thus not
applying this patch.

Thanks,

Paolo

