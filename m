Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE23648AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLIW4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIW4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:56:47 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE43C6FE;
        Fri,  9 Dec 2022 14:56:45 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 03B1C100642;
        Fri,  9 Dec 2022 22:56:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a222.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7FD1C101657;
        Fri,  9 Dec 2022 22:56:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670626604; a=rsa-sha256;
        cv=none;
        b=YTykb+ktCOvBCHZc4LG6Kxm5l4Ny+GCE2yZ4FxpKFBtvSQjJDirpyyc/+pi6nzwBPpEawz
        sLW9ltGhCsE0vzHkMwVD4EMYqakUgCqrkWnvWRhvubPxZ9kwE56+s4RMu67Na464jBxg8j
        u/ppae+4hM0BH7sigl7AW/p8uO8P7qKApEkHZYmTqCX+YG+MaVN8cqd9oTrSMfQtkCBPaf
        Edp9EQp1j65mrG7iDilvTxrXuRHUSTZkdedvTUczeYEjU045/M5aT796cI2HcexxS4gGOt
        T4gfswNbWHm3tOyHE1aSkj5mi2M3eehDhCujZG15NFB04iOBkYDZRD0EsA4AWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670626604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=hdbmdkdgIbxg50AgFukqlrG8bTqOYxZE7g+io9l9k94=;
        b=sJjeK4kPYpoPqRTm0h56Htmq3epzTgBA7Ea3u4Ptypm2hxKc2IGYXSFYvqXEfTxQXku0cu
        tJZnPxpucBCCrTSsXtaiFvdH94HeGPa9BFv2O1Aw2vMzSPuS/qOTLIetbPPf/D69tXe/4w
        6DNyOs+d/Omm4qggRaoo8kEIktGMjHC/6iEdSrIK6hrsBYEETf6PIJ8nZ2yJjQaM18ABQ3
        6/u5RstEmHTVTtt2+Ph5Vm+ixTqOr8dlmY043JU3DPrZW59lOXvOjiaZUZgZC5GMY8iIZ5
        ND2fIXTkSo+06NDI45ufaF5+wvfnKOSb+OWOqdYwbExnm8n3SBhznpTi6SqV1w==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-s7kkk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Towering: 13a93545364f75c7_1670626604791_1506781861
X-MC-Loop-Signature: 1670626604791:4147840309
X-MC-Ingress-Time: 1670626604791
Received: from pdx1-sub0-mail-a222.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.15 (trex/6.7.1);
        Fri, 09 Dec 2022 22:56:44 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a222.dreamhost.com (Postfix) with ESMTPSA id 4NTRGg5kjdz4F;
        Fri,  9 Dec 2022 14:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670626604;
        bh=hdbmdkdgIbxg50AgFukqlrG8bTqOYxZE7g+io9l9k94=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=OeyUYmeI9YoxIHnNOn2y5QOA2OcjGStm5v2ZnlfheCWgEusHV+Te1uyiPmW1h4zcS
         WhQkhAQvL2ooC0B4fh1V2xfjqYXKuC6/GzV6F38tPH/xemq72PR4JxwXlA60xqO0VQ
         f5FT2T8ZHPgqEqlCQJWSVyRroyWbKhs7Nk5TIOdIBrAbcXxUjHB+hBagrM0VgGctPW
         ZLYih9/GRtItWA/BfD9x3fpbwCxO2c5KIIHVVh7crEwUXecalFX5NVnTqvpJ/Jv4hP
         3SSShC2Nv2XC9CAt1E+9Gby88eGycL+gcQc5lXk0+k3QQB36JD/gr93847DBIRwDys
         r0G43Ws+HUfsQ==
Date:   Fri, 9 Dec 2022 14:32:32 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: Re: [PATCH v2 2/2] locktorture: Make the rt_boost factor a tunable
Message-ID: <20221209223232.2dqjeamad6nhlcmp@offworld>
References: <20221209022305.321149-1-joel@joelfernandes.org>
 <20221209022305.321149-2-joel@joelfernandes.org>
 <20221209163759.6s7pqf5wdvy32ywn@offworld>
 <CAEXW_YRyhXvvyiw=TrPLk4UwBThqeUh+aP_pvCiBSr6Mko2zxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEXW_YRyhXvvyiw=TrPLk4UwBThqeUh+aP_pvCiBSr6Mko2zxg@mail.gmail.com>
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

On Fri, 09 Dec 2022, Joel Fernandes wrote:

>> >-               * Boost priority once every ~50k operations. When the
>> >-               * task tries to take the lock, the rtmutex it will account
>> >+               * Boost priority once every rt_boost_factor operations. When
>> >+               * the task tries to take the lock, the rtmutex it will account
>>
>> Nit: maybe refer to it as 'rt_boost_factor'?
>
>Sorry, I did not follow. Refer to what?

Just use single quotes to refer to the parameter.

Thanks,
Davidlohr
