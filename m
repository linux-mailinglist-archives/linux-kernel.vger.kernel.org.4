Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B956544F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiLVQNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLVQNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:13:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE34C34
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671725536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBEp6O2/jOt5ENq0WkUw1TPazybtHKFIgxfdd4vI5bE=;
        b=UndO7CcZOYFbk/cTBWzb3AJ0m9PFwVFv9YeWSetM/5KrzlVWGjJEoGh4llYsgo1ujV9V4y
        62Ml4A3iNeX8PfCJOckJTXpDAKVOKLBwDA5lxhoZt5XEw+yWTV18NOG1AGoNa9BX8HkISq
        BTCA3OVZvKAgN5NIY/hafoeB1UCP3jw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-513-rvGai7aCPbSXC0_gDNJhMQ-1; Thu, 22 Dec 2022 11:12:15 -0500
X-MC-Unique: rvGai7aCPbSXC0_gDNJhMQ-1
Received: by mail-wm1-f69.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so2507394wme.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBEp6O2/jOt5ENq0WkUw1TPazybtHKFIgxfdd4vI5bE=;
        b=r0vwj0Eczn+GgMTuxvgj1XLd1eRzEKV3WhMcqD6vaYuIGk66OzbNFrsL7kgR77tUUH
         7piH8p9ZI/3lhQo2WywXP8NKpnrvw0RmdxPjQJtFhFYMj2Xe4+AZ3sMKi7E5aWqkDj82
         qln5opG9goKe2nK+r1guErSold8kHw+AXLZJ0AxFS2aeHK1R8g4Lv1PzHBVhdEvo5qP7
         +ObfARF55XsgydB7byO+j1WfjfnPRGYSwmOTyFpNljfJgCAyJ84Vm6AA4zdKnioBZbgd
         THF2C6qyc35a6ACpjH1nzydqxwbSFHfVYrPIqvnhubUop9LN4/DCB4fNnS1eqBHixv0B
         kbrg==
X-Gm-Message-State: AFqh2kr17LomHVb/TZStY3dT+VC3LN1Sl1nV9b2xNAe6ggaIQsJDov7O
        wA5amOh9WZSGP2zgYRibHlOsCnvbFa3f+ird9MG7L0A42BlrMWFOU6WSEmbCI+z8uu0Va/JrjdM
        8SJG69io6nW3yRKLLfUe30QFm
X-Received: by 2002:a05:600c:1e10:b0:3d1:f496:e25f with SMTP id ay16-20020a05600c1e1000b003d1f496e25fmr5085966wmb.16.1671725533952;
        Thu, 22 Dec 2022 08:12:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXslzwMNluVox2+651CRytf+LjdZRrVoHW4jcmdQz59I9rt2BiIEP9IWKIjZ3C6PjnfTgw8X9A==
X-Received: by 2002:a05:600c:1e10:b0:3d1:f496:e25f with SMTP id ay16-20020a05600c1e1000b003d1f496e25fmr5085949wmb.16.1671725533751;
        Thu, 22 Dec 2022 08:12:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003d1d5a83b2esm6734980wmq.35.2022.12.22.08.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 08:12:12 -0800 (PST)
Message-ID: <08d4d56b4b2ef422e2724e99a0a4d21baed7c9b5.camel@redhat.com>
Subject: Re: [PATCH net 0/8] Add support for two classes of VCAP rules
From:   Paolo Abeni <pabeni@redhat.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     UNGLinuxDriver@microchip.com, Randy Dunlap <rdunlap@infradead.org>,
        Casper Andersson <casper.casan@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Machon <daniel.machon@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Dan Carpenter <error27@gmail.com>
Date:   Thu, 22 Dec 2022 17:12:10 +0100
In-Reply-To: <cc41ccf443b1f2c7a4cb5e247dabfa53a6674226.camel@microchip.com>
References: <20221221132517.2699698-1-steen.hegelund@microchip.com>
         <0efd4a7072fb90cc9bc9992b00d9ade233a38de1.camel@redhat.com>
         <cc41ccf443b1f2c7a4cb5e247dabfa53a6674226.camel@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-22 at 16:02 +0100, Steen Hegelund wrote:
> On Thu, 2022-12-22 at 15:22 +0100, Paolo Abeni wrote:
> > Despite the 'net' target, this looks really like net-next material as
> > most patches look like large refactor. I see there are a bunch of fixes
> > in patches 3-8, but quite frankly it's not obvious at all what the
> > refactors/new features described into the commit messages themself
> > really fix.
> 
> Yes the patches 3-8 is the response to Michael Walles observations on LAN966x
> and Jakubs Kicinski comment (see link), but the description in the commits may
> not be that clear, in the sense that they do not state one-to-one what the
> mitigation is.
> 
> See https://lore.kernel.org/netdev/20221209150332.79a921fd@kernel.org/
> 
> So essentially this makes it possible to have rules that are always in the VCAP
> HW (to make the PTP feature work), even before the TC chains have been
> established (which was the problem that Michael encountered).
> 
> I still think this a net submission, since it fixes the problem that was
> observed in the previous netnext window.
> 
> But I will rephrase the reasoning in a V2 to hopefully make that more
> understandable.
> 
> If you still think it is better to post this in the upcoming net-next window, I
> am also OK with that.

IMHO this series is quite too invasive for net, especially considering
it will possibly land into the Linus tree with a timeframe promising a
large latency in response to any problem.

If there is any kind of available workaround to address the issue
(comprising disabling h/w offload) I *think* net-next would be a better
option.

Cheers,

Paolo

