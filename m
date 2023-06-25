Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB2F73D060
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjFYLVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFYLVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:21:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5725A18E;
        Sun, 25 Jun 2023 04:21:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-986d8332f50so277160566b.0;
        Sun, 25 Jun 2023 04:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687692091; x=1690284091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RShrmp5d5YjbnMCRTIoskOVV/4dcQN9QlhOXYh59kII=;
        b=jOypruXWz0mk/akL08lCy4oC5TYSV9uVNfx0p557JHXdD/qM0HTf8tbDH5D/yyoSA6
         tu6vi5kFIVHP58H1xaZZLIwveCGm3wwRlTOumSGObwtCXZzc+3ub55YGn/EhzavS+8A8
         RrJjLAa8m4ut0m6ftR5YqFUh9QEhZEALtozurgVP/5SI78futbLJcqSMzXrLaccjtaas
         9L+EXSEcGiYrg14wrHPLQHF/seAVd3TvbpTmzgEmZGmj4rfYFPKezRJk4Po6JFfPERom
         OvL2bZ8tRqXSZtxoRH4adxfITRxsq48dgebi9ZHTbBd8PLrFPZmzgLY4dvlRFjb83yhp
         IJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687692091; x=1690284091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RShrmp5d5YjbnMCRTIoskOVV/4dcQN9QlhOXYh59kII=;
        b=gmKi0nyvjtcmSNBIwKLYno4LSYhaWuYaLTSxLMHk3Gv4VQcfST6qdaKEmXSCNc+aNC
         t3APh+nZHyW+/5f4xMmJzoDX8cwinVZaA83oI4QNAAvnMhxSFgHc3u87oI/8tZd4WycK
         LSNkdKfkSvZ36pRJ+7T+QQyt0W/XRy8tYiqZO+lhKP1EBqmYuXhEznjakD4hbELAumDn
         mjcsWza0kvhIBZiW2XozmVAIIKbzH0pELPTOEZVz2ctJcLguvZ+uDRAX937zcvK8+O61
         zz5ZtdMJRamPtV3j54l2sSu9I3snLgDNrOPhP7OFccrFyKsgisb47xi3koKPJ+0w8pkn
         uEeA==
X-Gm-Message-State: AC+VfDznN5QxStoGYlVPpt3aLXEVMtnaEZ7uALxJv4hR1AfjNqf4dbF+
        jKvBilWX+XT/WJW4YIqHfPu7XwQLjnQ=
X-Google-Smtp-Source: ACHHUZ7/so+IU0ZbTtSAVgalKgZjhXZp4K2pZ7pCF8kqFz3aUn59spSUfFgjIsTyajE6S7Nqee6+fA==
X-Received: by 2002:a17:906:8a56:b0:98e:4b2:2e83 with SMTP id gx22-20020a1709068a5600b0098e04b22e83mr2176154ejc.50.1687692090488;
        Sun, 25 Jun 2023 04:21:30 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id lc6-20020a170906f90600b0096fbc516a93sm1950857ejb.211.2023.06.25.04.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 04:21:30 -0700 (PDT)
Date:   Sun, 25 Jun 2023 14:21:28 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set
 function
Message-ID: <20230625112128.3vyvcuvypbkxuz3q@skbuf>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
 <20230621191302.1405623-2-paweldembicki@gmail.com>
 <27e0f7c9-71a8-4882-ab65-6c42d969ea4f@lunn.ch>
 <CACRpkdZ514z3Y0LP0iqN0zyc5Tgo7n8O3XHTNVWC0BrnPPjM2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ514z3Y0LP0iqN0zyc5Tgo7n8O3XHTNVWC0BrnPPjM2w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:27:14PM +0200, Linus Walleij wrote:
> On Wed, Jun 21, 2023 at 9:33 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +     struct vsc73xx *vsc = ds->priv;
> > > +     /* FIXME: STP frames isn't forwarded at this moment. BPDU frames are
> > > +      * forwarded only from to PI/SI interface. For more info see chapter
> > > +      * 2.7.1 (CPU Forwarding) in datasheet.
> >
> > Do you mean the CPU never gets to see the BPDU frames?
> >
> > Does the hardware have any sort of packet matching to trap frames to
> > the CPU? Can you match on the destination MAC address
> > 01:80:C2:00:00:00 ?
> 
> The hardware contains an embedded Intel 8054 CPU that can
> execute programs to do pretty much anything.
> 
> The bad news: it requires a custom SDK thingy that we do not
> have access to.
> 
> So far we used the chips in a bit of vanilla mode, which is all I
> have ever seen in the systems we have and it can't do much,
> not even add a helpful frame tag, but as can be seen from the
> patches it can do VLAN...
> 
> Yours,
> Linus Walleij

But even without involving the iCPU, it should be possible to inject/extract
control packets over the SI interface, using the CPU_CAPT and CPUTXDAT block
registers, correct?

IIUC, ocelot with tag_8021q does just that for STP and PTP, see
ocelot_port_inject_frame() and ocelot_xtr_poll_frame().
