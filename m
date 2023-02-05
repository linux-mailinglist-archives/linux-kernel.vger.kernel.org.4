Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C491368B15F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 20:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBET2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 14:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBET2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:28:05 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE5418B08
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:28:03 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 523AC3C0C94;
        Sun,  5 Feb 2023 19:27:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CC5E93C0D7E;
        Sun,  5 Feb 2023 19:27:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675625278; a=rsa-sha256;
        cv=none;
        b=3KeIOdxTWMy/hdxmXSmYA8BBkBZ/jvTXB0bo7bTd3LLfgdowyHovtXqvasIqWQ17HdOmXi
        /0rBHb4XkZRHqCKVXBqe/GARM0NdrgkMh34S5CKXY+VQLlJU2e9wWayErElqTxuWSVvscP
        7EVtwDqEZ2zrENjXQhp3nzKZMs00hzSkq3eQcmJjRW+FbxPHBw25mQlN52xdbGjwkWztfc
        HOYr7fZe2YsQX4N5j3/03r/cil3kQL9ex6TQJZ0MD4s+dCibseA7Drzn8uqN7Zekkbvpmc
        e4VbmOLnlqWZjXtVeivKaTSmMmSICjdRFFi2/oC5LgYGz7zbOzjBc7m/td/MwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675625278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=zflL9vieIM7JtRZeiGsuJxg4qzxYiB31/wbf3kMtly8=;
        b=nWJnsByWC014EZ71udeGSv9zC/3GfxX1ONFEEyqYeCH5QT/8wmmVpjN7OIhaz7xf0txca7
        sA+N7eF29o2FPoe6+5ixFDgZA76+OnlwcGDj2NMHJs0YA1x5R0FJSZOQLJ3u4bsb1kFxvX
        52PXpDJqR7oj4s7t5wdRdAkCGjqvF+yP7G6SQYuKsesUdZvguOJaaMgk5mlK2VEOXXsryw
        zd+CPleGcd5XUFJImZciiAksiw6Y9C4JydT5B/Yb+ZQ6WYCCpvaM+FdHDex+kP/7B+Rcwo
        ZtnqHtIRjEchjh26iPTKnNqCLhrzAyAcVCZ5VRWy78E07g42PkG0pAQxmBmDZA==
ARC-Authentication-Results: i=1;
        rspamd-5fb8f68d88-krh58;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Cold: 4b7be9506cd5ee21_1675625279118_3906779514
X-MC-Loop-Signature: 1675625279118:2887568665
X-MC-Ingress-Time: 1675625279117
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.99 (trex/6.7.1);
        Sun, 05 Feb 2023 19:27:59 +0000
Received: from offworld (unknown [104.36.25.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4P8zv21GRgz8p;
        Sun,  5 Feb 2023 11:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675625278;
        bh=zflL9vieIM7JtRZeiGsuJxg4qzxYiB31/wbf3kMtly8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=LRegCZh3D4tUllSNVw3QAvgQe6MKpIfVnPuzskJh8WGT/JyLK5TKCuTtm8J6Iig8y
         nSqKwSEgG+i72A9YxpL5nW3VHiCg33bQ1QeLDaTp4Zaz8rSSt+E/ZecFkV8NYT7epV
         25vz3tkt5/EttuZe7+wCFbmozI9ABMrBrl6pgjmMXEnJA+QRL30PQq/QE481sqWKYO
         DLRgr6IxaTmGlizsVIbTVGVyyEKP/S2n4QtLWKhAk27WePH7pQmWC+EZtnsyUukIgU
         3osxJsbtLCJb8mtEZwHjXggv8IPAnqBWMsF4Bd7ffxAFnJKuwca3dcRkpR+4xMOu8q
         VyLCG2TkwFwyg==
Date:   Sun, 5 Feb 2023 11:00:34 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 3/4] locktorture: Add nested locking to rtmutex
 torture tests
Message-ID: <20230205190034.hlvisuduu7sdrrv4@offworld>
References: <20230203200138.3872873-1-jstultz@google.com>
 <20230203200138.3872873-3-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230203200138.3872873-3-jstultz@google.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023, John Stultz wrote:

>This patch adds randomized nested locking to the rtmutex torture
>tests. Additionally it adds LOCK09 config files for testing
>rtmutexes with nested locking.
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

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
