Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E938A5E5604
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIUWEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiIUWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:04:12 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F1BA74C8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:04:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DF8B72A2499;
        Wed, 21 Sep 2022 22:04:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a276 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 56E6B2A22F2;
        Wed, 21 Sep 2022 22:04:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663797849; a=rsa-sha256;
        cv=none;
        b=2jgIfVPVCBj5a/sdFdoFW7xuXrliDoUU5Aw2Ymysbpl76479qAc2IJmigQ5KMqUiWP8amP
        l9HwYM+8VaSmCFr5aVl402c+9nqwmS5jN87UE/FMxyQuhxayNh9SO1lyXamoUtZZFsjgJw
        gL4qYOJ4JGtIEq9pzTYWGjF/iwgDXSrfWX0JwUgORshD1b4JDLD1gBQlt+pJybBdVaEgo/
        LFkvXmOh9nDmmdOkxGApkmC5PWQt1jIDgkR28FvXWuPgZFReoBNWYq4oEQqnYyUj3r2zaE
        7OIpON8PSpCEiwFuDXwPWm1+YQpMabF4RFuhgq1eN85lV+tsZM8/wZlhtkI0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663797849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=qIgmkH/hafogNa8VEAsIG4BjELtg2zFPmFsDzfbLs1M=;
        b=z1C5IbNipPbsWOhjSOViKFwev3eztww65S7PhonNzwXjX9YdKALkIF1qdrAB89IOBqitX3
        Jlgni3OqxvCmUv7WOhQH3juB1uvDIhUoETLPJZnRGsjKV44Sb/AQzz8vsU+iaicWEEhjKg
        APPZDraD3JleJv00HATQQCsp9y7DquZUbSgTie5VYqidLmlLx1bDrRPO2ZG0yYu1MzCccf
        dJiDADjvIM0BP4nTcGWldI5uXX0zDLG4fbp8WbcELhfOygNIrdf7+GUUitUP+XjMckhHvI
        V9wdllkBp1ApRZXIynbooUJj8UOH6i6gsLKwl7taoW+JnKpKy+h2ixP5UArXfw==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-4btmb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Macabre: 54ee6fc511cfd69e_1663797849739_3622110757
X-MC-Loop-Signature: 1663797849739:1239163529
X-MC-Ingress-Time: 1663797849739
Received: from pdx1-sub0-mail-a276 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.125.73 (trex/6.7.1);
        Wed, 21 Sep 2022 22:04:09 +0000
Received: from offworld (ip-213-127-200-122.ip.prioritytelecom.net [213.127.200.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a276 (Postfix) with ESMTPSA id 4MXsrS0JjNzZP;
        Wed, 21 Sep 2022 15:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1663797849;
        bh=qIgmkH/hafogNa8VEAsIG4BjELtg2zFPmFsDzfbLs1M=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=L6pn/Wg4kV7hmaVnpIrDD9rpKmI8vErQi4STtUdUnMLldNCjhK/ASh0xp7eslslJF
         l9h04P3FDsjbcUbxIP2dRFwZA+PXpniZFyRd2gv/Am1Q/7kvTbh2mTaeVkBPHTmn8C
         A+RQWERxC4s3Dz9OpqfmFkCkgjJW1UnnNWfblyPnfOhKWdTNr0HDav+/cPmmAN5cs1
         NIUymoSngN9R4xYDvxakfwace8ORC3QQ2pslenjypZoUuCofC2bO34IY/p6/YEe754
         9x3hyBsJFVzgGYjeftUsjvqIer5gkg34gzn3L0Dhb6WpiMUs0RYHhA+oXONrNzoXnc
         umxWagXWpq4ag==
Date:   Wed, 21 Sep 2022 14:44:25 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [djiang:cxl-security 1/19] include/linux/memregion.h:54:9:
 error: implicit declaration of function 'WARN_ON_ONCE'
Message-ID: <20220921214425.hmw6zmgwwbs7fklo@offworld>
References: <202209220119.QSB1o664-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202209220119.QSB1o664-lkp@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022, kernel test robot wrote:
>
>    51
>    52	int cpu_cache_invalidate_memregion(int res_desc)
>    53	{
>  > 54		WARN_ON_ONCE("CPU cache invalidation required");
>

Looks like memregion.h needs to include kernel.h. I'll send a new version
along with EOPNOTSUPP return.
