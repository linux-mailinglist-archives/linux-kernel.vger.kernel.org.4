Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915773D38F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjFYUO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:14:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E8F12A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 13:14:54 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id DW8Hql8IdYSjeDW8Hq54KJ; Sun, 25 Jun 2023 22:14:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687724092;
        bh=99Zy3Wa/tHoUx/okcXBe0djEuGdAxqRHAp5/pcQcgbo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ahA6Jg46mNlm/+eOaIE9unvhul6T3L5VFkMdRe5rS4cSJcS9ViXR0/zBB6icUDT8Z
         bnEIAEGfz3VM6yCSNk5++YjQkVSikNbppFRqdIPaTKJMnOQJEXmwe+/u8YOf9q77oX
         DQFcysCT9RrzsMdyLElAL7FBifDdFyNUW6qtGTJkjZfdkzb3nmSlGZRA/W6+ANl8Tk
         JI2zCHBJexBlikkTwL3aMdu/z1DnkFosVv7yw56UtUDttQ7DAgusUVLET8PHqBinEn
         7jzdgAqRysNCCIUJhUlvOim9Biv2RoLk4bq/lsbpNHPSZyh1J97aBriOQq00ONPf0x
         HSbwl7ZDPb3KQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Jun 2023 22:14:52 +0200
X-ME-IP: 86.243.2.178
Message-ID: <beb409e3-0c13-b817-dfa3-15792a341130@wanadoo.fr>
Date:   Sun, 25 Jun 2023 22:14:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/26] octeon_ep: use array_size
To:     Jakub Kicinski <kuba@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Veerasenareddy Burru <vburru@marvell.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-3-Julia.Lawall@inria.fr>
 <20230624152826.10e3789b@kernel.org>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230624152826.10e3789b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/06/2023 à 00:28, Jakub Kicinski a écrit :
> On Fri, 23 Jun 2023 23:14:33 +0200 Julia Lawall wrote:
>> -	oq->buff_info = vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
>> +	oq->buff_info = vzalloc(array_size(oq->max_count, OCTEP_OQ_RECVBUF_SIZE));
> 
> vcalloc seems to exist, is there a reason array_size() is preferred?

Hi,

just for your information, I've just sent [1].

CJ

[1]: 
https://lore.kernel.org/all/3484e46180dd2cf05d993ff1a78b481bc2ad1f71.1687723931.git.christophe.jaillet@wanadoo.fr/

