Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC88560FC91
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiJ0QAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiJ0QAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:00:08 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F1A2E9EA;
        Thu, 27 Oct 2022 09:00:06 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 770391D6F;
        Thu, 27 Oct 2022 18:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1666886404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1fbTeUCdVF5k9p7cfgnvKNNm9kX0ZZQpQa98iYmoySw=;
        b=ASwyZPg4NG76tA1A5lRrdPUzk+P5LGD4byi2hzXR3+0G4qYt0SuD5w+RibMcsGazn0/YBl
        iCCucqwJr4q7ly0+7cMj22NwakDn5eaWkBIQdGgdQUArGCtCONuJusanDxsyQcnshXlp5/
        MtpqCF402aG2B14hBDwL/TJyTrD8QHaUFmgn+qTCWEuBpXP1651nv8zNz4oI5xk0Mbfcxx
        ySur2vfKpgAHcpQymZFyKPxb9VLvyXrXUewi5qHcSDuOJSnYWDbxypypAsDm2U3WRPPZGv
        O9mHGNpGvBju3Y1qs4uAGY2+0++E/2eT++kquXkrGlzLnYckq6i86+TNJbtsCQ==
MIME-Version: 1.0
Date:   Thu, 27 Oct 2022 18:00:04 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
In-Reply-To: <20221027122727.fhs35eqtzmeen6x4@skbuf>
References: <20221027113248.420216-1-michael@walle.cc>
 <20221027120519.7f3xun66l4lamcq6@skbuf>
 <20221027122727.fhs35eqtzmeen6x4@skbuf>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <84c5e0a041909615a1ba8a4508131206@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-10-27 14:27, schrieb Vladimir Oltean:

>> Pretty nasty. Of all the switch drivers that support tagging protocol
>> change, Ocelot/Felix is the only one with this bug, because in all 
>> other
>> cases, the default and the alternative tagging protocol are part of 
>> the
>> same .ko. Only here we have tag_ocelot.ko and tag_ocelot_8021q.ko.
>> 
>> The problem preventing us from calling request_module() is that 
>> currently,
>> the string identifying the tagging protocol (to which we match device
>> tree information) is part of the tag_*.ko. I think we'd need the
>> translation table between string and enum dsa_tag_protocol to be part 
>> of
>> dsa_core.ko.
> 
> I think we should treat what we committed to in terms of dt-bindings
> with utmost respect, so I would consider your proposed revert as the
> absolute last option. Reverting a device tree change doesn't mean that
> the device trees without the revert will disappear from circulation.
> 
> So far we have 3 options for fixing this within the kernel
> 
> - make tag_ocelot.o and tag_ocelot_8021q.o link into the same
>   tag_ocelot.ko
> 
> - change the MODULE_ALIAS() of all tagging protocol driver modules from
>   "dsa_tag-<number" to something containing their string name - what 
> you
>   proposed. I don't know why the current MODULE_ALIAS() is formatted 
> the
>   way it is. Maybe Andrew can comment on whether this is feasible.
>   I think there isn't any backwards compatibility concern, since only
>   modules compiled for a certain kernel version are expected to be
>   loaded.

FWIW, you can have multiple aliases if we somehow need to keep the IDs,
too.

> - put a translation table between string and MODULE_ALIAS() inside
>   dsa_core.ko, which potentially duplicates code. Maybe if we
>   auto-generate it somehow?

Yeah, I also thought of a table with of name to module alias mapping.
But then you'd have two places to keep in sync (of not autogenerated).

-michael
