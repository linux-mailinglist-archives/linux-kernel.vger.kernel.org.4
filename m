Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1946974DA6F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjGJPwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjGJPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326CE6A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF4E661063
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB981C433C9;
        Mon, 10 Jul 2023 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689004230;
        bh=ujUND67ysedfOJcnpq0izCtjDzDV1Go55+afJoHmEzg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PDuthxJZis4IrtB0OZr1lgi9c6fhan+1dxoIiOFPXVmmoNmJzRgzzpqpwOi7Wuyis
         ZmOWtDRBdLONBahbvZ/nc7q1ZiMTt71yHzj5EONkd03wlG1+TCRdFecU41tHCOG8yI
         JJo9Bdx0Tgg3qWm3SQFYssbUo6zDZJyXOIluEcu9rjNoezuPvLRIa9MHV9iRJqxJP5
         9+CJuE1stgv2zItirDHPfHvHYAaIevutuwL2QJQCzcv5F6WGpJ/L8r6lIEupifKHJY
         kuLN3dpEztjy3QrLobCkDr8b97dH2T4XxyL2pRJ48lAMO+ve6qRV5eS/IFdrqYHj1K
         bbQcxMSREpirw==
Message-ID: <2291aa12-3081-5e65-dc64-bf3d4349dfea@kernel.org>
Date:   Mon, 10 Jul 2023 09:50:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
Content-Language: en-US
To:     Richard Gobert <richardbgobert@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
References: <20230707121650.GA17677@debian> <20230707122627.GA17845@debian>
 <1340947f-2f66-e93d-9dab-055e40e1f9f9@kernel.org>
 <20230710145817.GB22009@debian>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230710145817.GB22009@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 8:58 AM, Richard Gobert wrote:
>> put your cover letter details in here; no need for a cover letter for a
>> single patch.
> 
> I believe some details are irrelevant to the bugfix itself,
> I prefer to avoid overloading the commit message...
> Do you think there is a specific part of the cover letter that
> should be added to the commit message?
> 
>> there are existing iif and sdif lookup functions. I believe this gro
>> path needs a different version, but it should have a comment of when it
>> can be used vs the existing ones. Also, it is small enough to be an
>> inline like the existing ones. e.g., see inet_sdif
> 
> I was under the impression the coding style of Linux does not
> encourage placing the inline keyword.
> In which cases do you think I should add it?

See the existing *_sdif helpers in include/net/ip.h,
include/linux/ipv6.h and include/net/tcp.h.
