Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF62B7413C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjF1OVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjF1OTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC1530EA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57D1612B7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BCFC433C8;
        Wed, 28 Jun 2023 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687961972;
        bh=yrVlAWiwxFJi/PSUnLEvi1oEGkS0sNHufr0RPMimCWE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YM1IppAygzGHN4bX7d7k6Q2VpMqf5//MszBZC+ih6wU75AtTQ74afbl1qmk+6t1Rv
         MMVMDEyz45sK6IV5iE2ddrwcMiNbbnK7+EMYQXQtuAeNXwDLzyFUlvbpdQoIXLklzp
         HEfAtDBLEossqE8WvxDajNU1kRioww6Cf1sRB441Kweah2/4Unnb/TzGEwADLZnUPA
         X8aiQIQXw0eizjV037noLjdItbiQFa0LaTE2BrptArYy0HBQph5tfeq4qPcNqaE8Lp
         P5md2kIb6rlvkoc0SzH2s1BEPc2kB0Bc7ubHbUnDB2iPlK99S6iZ+/5jSsvdsDmSkg
         SrPLI/4D9xOPg==
Message-ID: <b45cedc6-3dbe-5cbb-1938-5c33cf9fc70d@kernel.org>
Date:   Wed, 28 Jun 2023 08:19:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
To:     Gal Pressman <gal@nvidia.com>,
        Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        aleksander.lobakin@intel.com, lixiaoyan@google.com,
        lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <fe5c86d1-1fd5-c717-e40c-c9cc102624ed@kernel.org>
 <b3908ce2-43e1-b56d-5d1d-48a932a2a016@nvidia.com>
Content-Language: en-US
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <b3908ce2-43e1-b56d-5d1d-48a932a2a016@nvidia.com>
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

On 6/28/23 6:42 AM, Gal Pressman wrote:
> On 27/06/2023 17:21, David Ahern wrote:
>> On 6/26/23 2:55 AM, Gal Pressman wrote:
>>> I believe this commit broke gro over udp tunnels.
>>> I'm running iperf tcp traffic over geneve interfaces and the bandwidth
>>> is pretty much zero.
>>>
>>
>> Could you add a test script to tools/testing/selftests/net? It will help
>> catch future regressions.
>>
> 
> I'm checking internally, someone from the team might be able to work on
> this, though I'm not sure that a test that verifies bandwidth makes much
> sense as a selftest.
> 

With veth and namespaces I expect up to 25-30G performance levels,
depending on the test. When something fundamental breaks like this patch
a drop to < 1G would be a red flag, so there is value to the test.
