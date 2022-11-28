Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD563A05B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiK1EHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiK1EHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:07:23 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC450B7DC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:07:20 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 23DD87E127D;
        Mon, 28 Nov 2022 04:07:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A7BAB7E1166;
        Mon, 28 Nov 2022 04:07:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669608439; a=rsa-sha256;
        cv=none;
        b=tFfK4ixp93bDmAShb2iCHGG+wo1pi8kLs7vMWCP/iK1lgXlMuhcXTuGy2HwopnhyQSvs6r
        O4jDW/eUoNTStIUlYI0OjpEDrFeuqkBwb7PyELO3dS6SyHBYAr4BlPo2vHg+6P4/BeAyRy
        HuuSrInFxLpEg9HUKEoqAMwk/m03sC2MvBn2z7sfTaB8SFNRHE+FVgh8KzQKEJ5tLJ+vol
        9YpW1noKgoCGYIhEgOFIUafIKg6/cr1hZjtTlFUVTHnnkMR11fykPUYV1muloDy6kZ8zUp
        8ICL2bn5gq68TB3yKgYfchIBhmeBjD3vC0HZPTYaKAkLGcvFb0jA+suQCowPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669608439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=Vmw3reQPrur1xJKRLRqYBcEKBf5q3vUoCqozNv9an40=;
        b=It1qrLA1DyKaC3uD9gO45XNzofQLE3tCNiw64anxtV5s5Ne7eglfZBdqE3zahcpv0EWqt2
        EMgcSwXd91Wz7KwT/phryPzcbj9/iWl2EnPDOeeeG2XkbjQ8A9M4Br4K8kP5eBiNXxVAYi
        XnRlHIqo8XPPhed2lbad5lC4Qdgga21JC9XI3pjw38w9LfGqOT/ozx7AOKAnn+/IN2im09
        1jaD4IjrPcuSa3SFU/pciZLwawmAsvl2KyMV62qPNoztlpPRDY8d9Ixbr/J/lhonxX77V0
        48BzJK8BDCIzB7mM3hU9tOX/ewepPDc0R9mSxH4ZgdVMGzXR3dgX4fk8x7HtsA==
ARC-Authentication-Results: i=1;
        rspamd-84789cff4b-64tzg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Trade: 6469a99d2185b3ca_1669608439927_3751063851
X-MC-Loop-Signature: 1669608439927:2333882591
X-MC-Ingress-Time: 1669608439926
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.61 (trex/6.7.1);
        Mon, 28 Nov 2022 04:07:19 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4NLBkb1BL4z3Q;
        Sun, 27 Nov 2022 20:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1669608439;
        bh=Vmw3reQPrur1xJKRLRqYBcEKBf5q3vUoCqozNv9an40=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Ho15znAF2TEBhRs5jeuIkT2EARsjnYzUYYYBr0IHD9hXLQ7ctqn9XFjJcM4m4AmSV
         FEQYPFAbC1OLavHfUEmMpJqdCV8tvdH1eYWaQwHWLQzGHNRABKmF6TCJIs53+yrCXD
         3f9oLBnASuroV+kL/hnEU7tAI+l6TOL3yUxilo/XscsRCIYIf3+oH3dkv+kP5Yi93U
         yXcc2woonp0I4vUrFJPp8xz2+rM/coOvbQ9nJwazpw5dSnYAimFW6b2ZFjHskvrjPr
         1W4XKgLffjpTthdMpOxPRJgzOWmY2sANBqKusMz0AUy18EAWQKw2iANA+Wzc1iKj31
         fPhEOcLzI8mww==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 0/2] tools/virtio: remove smp_read_barrier_depends()
Date:   Sun, 27 Nov 2022 19:43:45 -0800
Message-Id: <20221128034347.990-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To my surprise, this call is still git-greppable in the
tree, the kernel having gotten rid of it a while back.

Thanks!

Davidlohr Bueso (2):
  tools/virtio: remove stray characters
  tools/virtio: remove smp_read_barrier_depends()

 tools/virtio/ringtest/main.h | 37 +++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.38.1

