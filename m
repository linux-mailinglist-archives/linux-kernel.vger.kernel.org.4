Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73CF68B15C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 20:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBET0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 14:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBET0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:26:10 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9DD18AB4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:26:05 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 54E3592196E;
        Sun,  5 Feb 2023 19:26:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C648C921831;
        Sun,  5 Feb 2023 19:26:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675625164; a=rsa-sha256;
        cv=none;
        b=6xMKZqYGAV/liOC/zy9ZI2RXETTs/lscRcTvyigeaarlwoDeLzHb+v6oMmxCw7xWaN6zUO
        1wCuvLAMzdJmwVfJHfB4i9tUwnaZUvvAuoyGobI4GL5AxCMI8emg0C4k10cxL8quEnO0Zs
        U5DbIVvBatv+Exz/1gPoKa+O4cjm4+1CkEPoy1tf0cR56EzXbHUpoqvHeSJh/K4cXeo2Qn
        xzvoUjwiNGfrkmVpJcdRZw7xmdqtxC80NW2lfBEH/SPxcFhisBsgtjNkkh2uIcQcuhhhkt
        dZ69GRhGHfbph2FlIIVgODZnTiwwckRCGEQ1qOnO6Un27v5poCZMuBzMrwpIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675625164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=dt4qLnZ5x+MQwdb8A7tE77a+9Wo8DsXWDSS1uDwjWw0=;
        b=chQgAcen02MdTuZQnf2JcLCIBKXIDlScCpBicVx69G0pfm9BWv2QMCFSHmZlhraUYmK11N
        KksUYRLVRjeYt8KMHuD5GTDmlF5I/W97Wj6RnTdg4bjpxLYwtbozTUyxu66OioA6kFuufH
        XriO/mKxZksmZBypnkj21pzf7Deq2ZL3RE7FO6hEzUW3Hxh7Mi2jgwvn61YO+a/pFLP9LI
        gT1mWgG0QS5tnvGIYbVukj/icAc3KLGeXWJgJSoTFhiNxT0CIjfcatv6A4o3yeBZiZ7Z6e
        q/CgfmTaEzpraeVz6CUo5tXRzuEpF6c9kRwq5aY+yUaXbvc6KHfUYBhV4+bPBw==
ARC-Authentication-Results: i=1;
        rspamd-5fb8f68d88-vqvfk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Suffer-Name: 3588f48715c365eb_1675625165117_431330380
X-MC-Loop-Signature: 1675625165117:2441208404
X-MC-Ingress-Time: 1675625165117
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.117 (trex/6.7.1);
        Sun, 05 Feb 2023 19:26:05 +0000
Received: from offworld (unknown [104.36.25.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4P8zrq6tGNz8p;
        Sun,  5 Feb 2023 11:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675625164;
        bh=dt4qLnZ5x+MQwdb8A7tE77a+9Wo8DsXWDSS1uDwjWw0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=a6RKL6O39rFl+RrW3M3VXFUiD75nTbUoQY0UzFOv8ZuZ4MgCF9e23w2nN3TKiUhRQ
         HqP7iWmyicMZNO1rqXa3036fdnHyU8Y0DGScNJUn2A6ZhUPtBM6/LNNAi6TlrrJ4Ah
         x7V3rpxeUY9PPxUGBMT2UUcWLsoBUrWoPbVB3KmURDukjXcta5rO85JFrPF5fmgnXR
         s06wWO1WIehiqRB75gxgOtiKou7DU40oCAU7fkgMXdHnSlnraKO2Qi1OGbN2SIgW0d
         Lb39u/Y4GcPu5ULEtahH8TvSwqw/gK1r/pwU+48B1jVKbPIEy7E+g/5BD1gQLGlhuB
         iV1CuDhsRC+vQ==
Date:   Sun, 5 Feb 2023 10:58:40 -0800
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
Message-ID: <20230205185840.uwk4vgvwfuakooso@offworld>
References: <20230203200138.3872873-1-jstultz@google.com>
 <20230203200138.3872873-3-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230203200138.3872873-3-jstultz@google.com>
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

>This patch adds randomized nested locking to the rtmutex torture
>tests. Additionally it adds LOCK09 config files for testing
>rtmutexes with nested locking.
>
>This was inspired by locktorture extensions originally implemented
>by Connor O'Brien, for stress testing the proxy-execution series:
>  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
>
>Comments or feedback would be greatly appreciated!

Same comments for all the patches in the series.

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
