Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65BB715AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjE3JuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjE3JuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1FEF9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685440163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2gmQ/a+oAFA19ljaGNIngxILT41zCscP4KKC+5R6wc=;
        b=acjlA1erYI6bLQ4RjrKRHJtFBz494YsMlVBwI8Uf2+QDKAoCr9CiyDbvc8we9s+4hG1VDs
        vg1FY71uGWH0gVN3lrQG9FQSh6LAECucoJVF4sSbKKtFpXNQWyYedgCsytXcJUFAiZXOwC
        qPeLMLPKMjDW1W/AB3vIV5VMsucseA8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-WyZUjyTsMtq3Wz6P_g5Vcw-1; Tue, 30 May 2023 05:49:21 -0400
X-MC-Unique: WyZUjyTsMtq3Wz6P_g5Vcw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b147a2548so37371485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440161; x=1688032161;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2gmQ/a+oAFA19ljaGNIngxILT41zCscP4KKC+5R6wc=;
        b=DsOZzfV4DizTzLhzlz0+cKIWvtWBYfmWg4fDHUG+ycsurB9tYWP+dWgwqRbOVA+oLc
         DdYu//hdjFRMuBiSAm3Z9CufbNPA8I8qQHQKzhwzUV98ddNYMq1EE82M5fVzyomNEAyk
         yaz7TEFNkGRjjDy/rYALm/X5XedPWQhpXEfPf16+mtqTQ5m/zNUp3x7N+jQFzexarGUl
         V+IF3fUYc55HDKbZdBVigw/lUV96l9r9nwNSzfWfKe7ieGeI27/BduRXfpmanOXgZ+/l
         Xm3r5gFJ7VYl0MUR3pbccWjfcIg6kLFpXc89H/ELfhaG1a9fs1TTiZVNTthiuAn8tuvW
         8joQ==
X-Gm-Message-State: AC+VfDy/gN4tFGaCvBAAjpN99EXec4ZgM8/pn6bN8cfbsXflbOaRlQi+
        g27SGsPCy0aPiU53qlLn8x1DxqbgXqZ1UcGI1wVQ1wEhF9i3DUV7DjSnUSzN4TjrakAFca46XbX
        oMbq9zanaijEKlqMviDBDnzWs
X-Received: by 2002:a05:622a:1883:b0:3f7:fab0:6308 with SMTP id v3-20020a05622a188300b003f7fab06308mr1340937qtc.6.1685440160945;
        Tue, 30 May 2023 02:49:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7w88awc4basn85TiY7eWn8aDcCDQdVwwZSYAOezEQ1vOtXU0iBSdWaMjHX4FEB7CRfaaqqig==
X-Received: by 2002:a05:622a:1883:b0:3f7:fab0:6308 with SMTP id v3-20020a05622a188300b003f7fab06308mr1340932qtc.6.1685440160704;
        Tue, 30 May 2023 02:49:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-248-97.dyn.eolo.it. [146.241.248.97])
        by smtp.gmail.com with ESMTPSA id gd22-20020a05622a5c1600b003f0af201a2dsm4572151qtb.81.2023.05.30.02.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 02:49:20 -0700 (PDT)
Message-ID: <0939d69afbf1173f4b62758d1d448c85217abcf1.camel@redhat.com>
Subject: Re: [PATCH net-next v4 6/6] net: phy: microchip_t1s: add support
 for Microchip LAN865x Rev.B0 PHYs
From:   Paolo Abeni <pabeni@redhat.com>
To:     =?ISO-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, Thorsten.Kummermehr@microchip.com
Date:   Tue, 30 May 2023 11:49:16 +0200
In-Reply-To: <ZHRPRBwJ5jHs6vLz@debian>
References: <20230526152348.70781-1-Parthiban.Veerasooran@microchip.com>
         <20230526152348.70781-7-Parthiban.Veerasooran@microchip.com>
         <ZHRPRBwJ5jHs6vLz@debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-29 at 09:07 +0200, Ram=C3=B3n Nordin Rodriguez wrote:
> On Fri, May 26, 2023 at 08:53:48PM +0530, Parthiban Veerasooran wrote:
> > Add support for the Microchip LAN865x Rev.B0 10BASE-T1S Internal PHYs
> > (LAN8650/1). The LAN865x combines a Media Access Controller (MAC) and a=
n
> > internal 10BASE-T1S Ethernet PHY to access 10BASE=E2=80=91T1S networks.=
 As
> > LAN867X and LAN865X are using the same function for the read_status,
> > rename the function as lan86xx_read_status.
> >=20
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.c=
om>
> > ---
>=20
> I accidentally sent both reviewed-by and tested by, should only have
> been reviewed-by.

N.P. I'll strip your tested-by tag from this patch when I'll apply it.

Cheers,

Paolo

