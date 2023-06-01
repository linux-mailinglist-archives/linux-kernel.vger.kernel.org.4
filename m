Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A54719E72
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjFANm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjFANmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F2138
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685626931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPN2zqjRcvTx5BAbVRSKyrNwIPYaR9V6mursf4H+kkE=;
        b=UBxwOJdaRm2luaDY7t8k9446iy8VUnJuINRWGyS4m9RgSZFNolHiufuYbVqb/ImBpcadF6
        yH/Zt8NwO4JyJTHa7PcvExjNIz0rOaWDrJaUeh83DF1UCFAGdp2Vxdg+4IYUO0KrkeuMli
        VkmtxDd1jqQawifUBtAmC35N39D2dP4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-TPKvwvzBNGCuj4QVxjKI9g-1; Thu, 01 Jun 2023 09:42:10 -0400
X-MC-Unique: TPKvwvzBNGCuj4QVxjKI9g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30a8887f419so47294f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685626928; x=1688218928;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPN2zqjRcvTx5BAbVRSKyrNwIPYaR9V6mursf4H+kkE=;
        b=KyhVq6on1HpLxc/VA8A7QQhBZb74JtitrUdMrszLfClcpg6oRQPX10bFTx+WwB7d0Q
         Bwi/muzvoxlFI/mIci0yY+6Ye1yQ9cspjbEHQh9b/Tz6GK98P0BOt/aKDcE7nr+PlXTF
         8Kxkxee2wfoJV0SNhzB1tHNPZTo18G3MN2NJ03NVsCOV9Tm0QwD+5tVBi+rAbVn8zIXi
         NAOLc3fWT5XpXeFKhDFYxHfNYphqACWgmRfEtzuPiKQtmCXlY4HmsPX9IuY49mjUy6UC
         2a/CRzm38wnE9aSHQSAwTzoqV7Zg/6cznaEsjZLxW9qLtytzwqaxOfWDTKHpD8kCSSl+
         gWwA==
X-Gm-Message-State: AC+VfDwDjgtXJN6IEmmVGBbBcriR06qs+qziPGt4itfa+SqLgTXxG04J
        HFwO/fCgpzrbLhN5SNFdB93cd0kKDKBCofGMiXeX4fdHGaPxMz9qCJ9eVncavYQ1V3QJw/g/4Qq
        dikELMMhKtUos97Wqefn8cEjw
X-Received: by 2002:a5d:5490:0:b0:2e4:c9ac:c492 with SMTP id h16-20020a5d5490000000b002e4c9acc492mr5994558wrv.1.1685626928450;
        Thu, 01 Jun 2023 06:42:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52njr8Il+cOTczR39DnsK5Iu/OapPG+wYgoaSYubVjP1CrjzkBWo6brNrPUA6MLAqHiTSnPA==
X-Received: by 2002:a5d:5490:0:b0:2e4:c9ac:c492 with SMTP id h16-20020a5d5490000000b002e4c9acc492mr5994541wrv.1.1685626928087;
        Thu, 01 Jun 2023 06:42:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-89.dyn.eolo.it. [146.241.242.89])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6542000000b0030c2e3c7fb3sm2963398wrv.101.2023.06.01.06.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 06:42:07 -0700 (PDT)
Message-ID: <1a14013cc3e205265e4564094d4faf971b651810.camel@redhat.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Increase wait after reset
 deactivation
From:   Paolo Abeni <pabeni@redhat.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Andreas Svensson <andreas.svensson@axis.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, kernel@axis.com,
        Baruch Siach <baruch@tkos.co.il>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Jun 2023 15:42:06 +0200
In-Reply-To: <133860f9-e745-44ce-9b74-c5d990cf92db@lunn.ch>
References: <20230530145223.1223993-1-andreas.svensson@axis.com>
         <be44dfe3-b4cb-4fd5-b4bd-23eec4bd401c@lunn.ch>
         <f89e203a-af77-9661-1003-0e9370ff6fab@axis.com>
         <133860f9-e745-44ce-9b74-c5d990cf92db@lunn.ch>
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

On Thu, 2023-06-01 at 14:01 +0200, Andrew Lunn wrote:
>  On Thu, Jun 01, 2023 at 11:10:58AM +0200, Andreas Svensson wrote:
> > On 5/30/23 19:28, Andrew Lunn wrote:
> > > On Tue, May 30, 2023 at 04:52:23PM +0200, Andreas Svensson wrote:
> > > > A switch held in reset by default needs to wait longer until we can
> > > > reliably detect it.
> > > >=20
> > > > An issue was observed when testing on the Marvell 88E6393X (Link St=
reet).
> > > > The driver failed to detect the switch on some upstarts. Increasing=
 the
> > > > wait time after reset deactivation solves this issue.
> > > >=20
> > > > The updated wait time is now also the same as the wait time in the
> > > > mv88e6xxx_hardware_reset function.
> > >=20
> > > Do you have an EEPROM attached and content in it?
> >=20
> > There's no EEPROM attached to the switch in our design.
> >=20
> > >=20
> > > It is not necessarily the reset itself which is the problem, but how
> > > long it takes after the reset to read the contents of the
> > > EEPROM. While it is doing that, is does not respond on the MDIO
> > > bus. Which is why mv88e6xxx_hardware_reset() polls for that to
> > > complete.
> >=20
> > Ok, yes that makes sense. I could add the mv88e6xxx_g1_wait_eeprom_done
> > function after the reset deactivation.
>=20
> I don't think that works, because how to talk to the switch is not
> determined until after the switch has been detected.
>=20
> > The datasheet for 88E6393X also states that it needs at least 10ms
> > before it's ready. But I suppose this varies from switch to switch.
>=20
> O.K, let go with this change and see if anybody really complains. We
> can always add a DT property later.
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>=20
> You probably need to repost with my Reviewed-by added, now that Paolo
> has changed the status of the patch.

Not needed. I can restore the patch in PW.

Thanks,

Paolo

