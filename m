Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F26D68B161
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 20:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBETdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 14:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBETdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:33:14 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC5EF81
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:33:13 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1BDF57E18FE;
        Sun,  5 Feb 2023 19:33:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9C8707E18AF;
        Sun,  5 Feb 2023 19:33:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675625592; a=rsa-sha256;
        cv=none;
        b=nlUu6ynhe91ehL/cOxpWSub79kYg/oF3J5VCR4jntspMENKdor2bvhRCYOpjULCwwQGY0G
        Og/7B8OfmxOLxkBOBGlulmk8emOI2cUfrs7K6ncbKjW15EE/d7lrzdiOiC/Sg1e9Fb0r8z
        yy3xaq7/eRyZ5GxlxoffHhYUjS59nqd49lLh82w6KgDLOhT+AfIr7Yhhs5xNXGzgSGQjx+
        wntVe+Mzij6W/Qiiwb0IB4giiyamYmqbx/wFyoS8T3Tb88/XBt8RsZEnr3DG81W4xxyQFn
        AO3NFeyt0euhgFPT2eVGcegw9HBsWmmWoec20td/lrF1NsQhudUXdpbCIexvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675625592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=RNorp+3T1yIYM583sLRz4mivEsmGDPaATGTag4eGU3o=;
        b=gD33u6YvnoqpEQMIwtfFZyv/ScwZnJN8YKNwS/sauCLRbmaW3nXngVUlHxEXRinV8OAs8b
        /FXmyh6LIYkEkz8Dd4Q4g7wLLeaTtnP2O8q3Tk4uYvvhjfQ6lqxN1UpjkKCpidIU2llXit
        GJEMK+wYurVd4gFqmUUFEAKiwqXz/H4pOkRv7W33UHfeziX6eYRtTg4kYiWmq9GsKF1Btz
        7BllJET9myjwzJRMMieCQw7y9VEuE7mwFs3uD3Q+mrTgLybeSSMI/3+Y+kPTZuKt9QvFwd
        vhA6o+sZw46T6Qv+PyBgApYeW1saNSI3pJnDJmoVlmTVdvtys5eB2DkVqQdlYA==
ARC-Authentication-Results: i=1;
        rspamd-5fb8f68d88-444rr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Whimsical: 2b34a4514f6f5647_1675625592917_3802659581
X-MC-Loop-Signature: 1675625592917:2520973031
X-MC-Ingress-Time: 1675625592917
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.40 (trex/6.7.1);
        Sun, 05 Feb 2023 19:33:12 +0000
Received: from offworld (unknown [104.36.25.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4P90136f33z8p;
        Sun,  5 Feb 2023 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675625592;
        bh=RNorp+3T1yIYM583sLRz4mivEsmGDPaATGTag4eGU3o=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ZWBZrUXgDgNovYdIzNkKp0VVMVv+q4TeTSP7NHUF1DWv2YVriY3dfBf+/T3Y5+5ms
         74gJ141JKzXh31sgFH5feuuulKebCuu5QzKYbY40iJraiEU3zv0Ec3W4jJF7jvnB6S
         9EvKhX+0aeWhzKOxygT4oVj0Cc2IpMeayYayizI7QU2oozLopGB7ai2PoJluai3w68
         eqc/8B0eoltyqKknnKz0HEQDguAdvMrhyuGM8nc5hh33G7YPH0GM4lZzesRiGTlfzS
         0peB41P2AfpnvjsAC4+F+8wUflbrJHM1JqqtSBsTnyhZWcPsURu1dxqkoK1ALTMyaG
         vdqmm6R8YD8cg==
Date:   Sun, 5 Feb 2023 11:05:48 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 4/4] locktorture: With nested locks, occasionally skip
 main lock
Message-ID: <20230205190548.7auywdoagy6txpla@offworld>
References: <20230203200138.3872873-1-jstultz@google.com>
 <20230203200138.3872873-4-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230203200138.3872873-4-jstultz@google.com>
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

On Fri, 03 Feb 2023, John Stultz wrote:

>@@ -754,21 +755,28 @@ static int lock_torture_writer(void *arg)
>			schedule_timeout_uninterruptible(1);
>
>		lockset_mask = torture_random(&rand);
>+		skip_main_lock = nlocks && !(torture_random(&rand) % 100);

For the sake of future readers of locktorture.c, this deserves a comment
as to why we wanna skip the main lock (copy/paste from the changelog).

Thanks,
Davidlohr
