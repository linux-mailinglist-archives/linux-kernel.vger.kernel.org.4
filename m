Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E568B162
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 20:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBETfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 14:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBETfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:35:19 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC41421B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:35:18 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D36365C1104;
        Sun,  5 Feb 2023 19:35:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5E6B75C0F47;
        Sun,  5 Feb 2023 19:35:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675625717; a=rsa-sha256;
        cv=none;
        b=pF4cmlBhZWE/LUwg+8ZEDS+z/IwMUOi+yjCmPy1NHXfFb0LVvNwjMNot6gQdXze9vR7SvI
        Oav6xo7KL/m39sBdFprbv30wpGCWKpgMfmmhisYT2fRiAAXrNuLQgTujVk+6CuUSekB/SF
        KQ77cqtNK0hXcK7Lzgyq0za4XAcMJjUW4A+bgFJzSwEaMvBFkUW/TIp+VrrQt+Md9iWoPO
        VsfoLdC54RWbazQw9asfm0v0I39I/bb5cQJ1Y4/zeHEVqDfgBHOuimpgXwsXI5HyVfYPuX
        GejXM3Y44gCO4fz3enq5vLBjklnaJIWL+r4BeehLGephhCxEJ8CWzw4gawvMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675625717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=X4a2uwJz5XDxwNGEnWjhMhs56zjD3arHOQRZXJcWO2Y=;
        b=k8dYVQpjvKTnBj0PrmGliq34rvLp0/QNp3LbE0h+jS5aXmy9Ab73tG1fHkKQE7t802ogRN
        K8Naofl+sLBcoqNJHYpTzUMl1xdejBKN6DCLzWf2jaIYOaHo1Y1iePqhpbQdXiWDolmLYe
        lL7qpT1bfFOq8CKt67xGBvjdmM1K3Wa9F2yjsHOSL2GqQMaY2rGIZlxzLY8M9DOv+P5zTp
        HcIcQa8Qm0jIxN44bss/otPBmpWzHVNllvtG9u8x/mzWoCIu9s6fhX9I3wntt1qtZhRkCW
        ZZgYTib6l9V5pqQnciC2jkvqHODXatcjlffIW7rCY0V83nQs3n3La+BUhPuA3g==
ARC-Authentication-Results: i=1;
        rspamd-544f66f495-fbkxv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Ski: 12da7ee27b67e44b_1675625717671_3618273070
X-MC-Loop-Signature: 1675625717671:1946960051
X-MC-Ingress-Time: 1675625717671
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.121 (trex/6.7.1);
        Sun, 05 Feb 2023 19:35:17 +0000
Received: from offworld (unknown [104.36.25.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4P903S5FMFz8p;
        Sun,  5 Feb 2023 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675625717;
        bh=X4a2uwJz5XDxwNGEnWjhMhs56zjD3arHOQRZXJcWO2Y=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ni9lnQIEK3IJo430aSAyVKMwUIhMFEMfQYZhiUQ892iHPKGJxWvrNlqYspj1TqOwv
         AqXHizq5CEEvUAu0duf42f1mgUWxuYSo/18y8C+S/xRJ3h54A11I0RCR+LsJiW4vPZ
         zUrlOMNyfmCAgrltBwoBeqIYMp8c29bAVupHN5sPBC2mWz+ZIY5b2wRAkfHVdTfLIz
         kyAChOqFasoVjUO56gG7C/VJPleE4rdQoC9BXux7zYJsxNEyp9ehmSHGCItijwMcbQ
         F7tKBZBFAXyMw2yVng3I7bVuyUTQ+b2km7xzUq8MuhBoeLCfmgBt4SQ21OOH9Qmxaq
         scjDEytxSZkZg==
Date:   Sun, 5 Feb 2023 11:07:53 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 2/4] locktorture: Add nested locking to mutex torture
 tests
Message-ID: <20230205190753.4sgvtxxaqcvr45ei@offworld>
References: <20230203200138.3872873-1-jstultz@google.com>
 <20230203200138.3872873-2-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230203200138.3872873-2-jstultz@google.com>
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

>This patch adds randomized nested locking to the mutex torture
>tests, as well as new LOCK08 config files for testing mutexes
>with nested locking
>
>This was inspired by locktorture extensions originally implemented
>by Connor O'Brien, for stress testing the proxy-execution series:
>  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
>
>Comments or feedback would be greatly appreciated!
>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: "Paul E. McKenney" <paulmck@kernel.org>
>Cc: Josh Triplett <josh@joshtriplett.org>
>Cc: Joel Fernandes <joel@joelfernandes.org>
>Cc: Juri Lelli <juri.lelli@redhat.com>
>Cc: Valentin Schneider <vschneid@redhat.com>
>Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>Signed-off-by: John Stultz <jstultz@google.com>

Just realized I sent two review tags for rtmutex, one was supposed
to be this patch.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
