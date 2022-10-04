Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8135F3ED8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJDIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJDIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730B13CFD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664873561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aEuH3SIPmaaGgJpqhFBpdv6WFVgwU4WLYDd6qjhG9EM=;
        b=OutrVWmZbR+oTKZMTn4lPXY1HjyZT77J6hU79Sn8vG7AxGxm6P2uIXET4QthE/h7fSwTpu
        RT/4JdAlnXIYFQ/U8sx6R6tVh7AAIh20ktPgGyscr5qDmqye/yZbXAzrY8z8OLRZSC5z6V
        fvEBMstMT3c3rF+fCFOWjo3sfMlY2/0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-Dw37ilThMCmtV4yUs692pw-1; Tue, 04 Oct 2022 04:52:39 -0400
X-MC-Unique: Dw37ilThMCmtV4yUs692pw-1
Received: by mail-wm1-f72.google.com with SMTP id c2-20020a1c3502000000b003b535aacc0bso10559677wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=aEuH3SIPmaaGgJpqhFBpdv6WFVgwU4WLYDd6qjhG9EM=;
        b=W3nXgJ0zd0yuvsafSRiigeQqu49tC0PG+U2pEjWWqoogLOFJkATKnPQBSDEImPUF91
         K07aF2S9ognnjxSxXcp/JbVnPWPnh2C9CX3ivej9EDuUJUHT3b5ODo8s+6oSfnx58C9n
         gwg3DWmut2OXGXuv2Ixiwq93R4hAZgYruByv6zivba/E9+N2ev6Ts1Ffso7ZDcx3nCZC
         ldz0JqMcZtki18pWwTXVtnBsFOhkR3G/EfJAIzj37Pjec5DgBqa7T8hNNJOKoohK3/3t
         +GvWCNjRCs3UqPBN/rWZ5lE1hyILvLwt7E76q5NsfMSs8A/yXudpIsg8CEbjNVJ9GmxU
         jCRQ==
X-Gm-Message-State: ACrzQf3gbJj+wCQTLj4AcqVFfOd4MudBTswVJMTINyIhv/41/sud5a5A
        EIUb5KnkiTBSBImlBcAX9XyfZ/GbkTpbh3QkuKK/NkG8VVS6ETDlgry7bRx7wkJgXs2ZJhKZK/S
        43W0pvC9sJXUlSUkKrtlBj56r
X-Received: by 2002:adf:e112:0:b0:21d:7195:3a8d with SMTP id t18-20020adfe112000000b0021d71953a8dmr16070525wrz.371.1664873558524;
        Tue, 04 Oct 2022 01:52:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ydQge434vccoSf1EMgdm4qjUZ6q+ksKYC2TC9xtXJvEbSDgvcBXQFjnPccAmiL0w1ROhmIw==
X-Received: by 2002:adf:e112:0:b0:21d:7195:3a8d with SMTP id t18-20020adfe112000000b0021d71953a8dmr16070508wrz.371.1664873558206;
        Tue, 04 Oct 2022 01:52:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-71.dyn.eolo.it. [146.241.97.71])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b0022ae59d472esm11595471wrw.112.2022.10.04.01.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:52:37 -0700 (PDT)
Message-ID: <207fa5f52b00836df6dd03af470d85926747079b.camel@redhat.com>
Subject: Re: [PATCH v2] net: mv643xx_eth: support MII/GMII/RGMII modes
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Yang <mmyangfl@gmail.com>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Oct 2022 10:52:36 +0200
In-Reply-To: <20220930203926.958776-1-mmyangfl@gmail.com>
References: <YzdRdC1qgZY+8gQk@lunn.ch>
         <20220930203926.958776-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 2022-10-01 at 04:39 +0800, David Yang wrote:
> Support mode switch properly, which is not available before.
> 
> If SoC has two Ethernet controllers, by setting both of them into MII
> mode, the first controller enters GMII mode, while the second
> controller is effectively disabled. This requires configuring (and
> maybe enabling) the second controller in the device tree, even though
> it cannot be used.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

It looks like that despite the subj change, this is superseded by:

https://patchwork.kernel.org/project/netdevbpf/patch/20221001174524.2007912-1-mmyangfl@gmail.com/

I'm updating the PW accordingly. Please let me know if you intended
otherwise.

Thanks,

Paolo

