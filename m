Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561EB6A5EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjB1S2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1S2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:28:36 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A963D13521;
        Tue, 28 Feb 2023 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cB76pDp0L9mcBCeH4RiYfMUhvVaaA8YDQDxOHX56BVk=; b=lYWJatWtQcxNNhvIQ9pivEuRZx
        XVr5JDPdI1CFtaTX6Ti93x80HGjOZ4HDh0XcfL5sB/DEhtLAsTierRMvZjSA7orhFXGqp5TzI2kUt
        wI9p7aIh0kxKRNRXA5i02jXzt6sMUEtQ5emwAMfRTJNDJKgyeQgVL4j85whLxjtPblhUUZye1ojfu
        Emozq2UoHDkL7mSTAaB9KK4ulb9cCQdHjXFaBQbtsCIvl6P7HFnN3k9z0bXEKbrbhidr4KgRlFrcX
        gyc5C6kradb3fm60xGnaL5t/thIfEKGC6gKjlf6LyDQVP6tNWiKA5T7uYLidpZURPtecrMmZ9GnQA
        zmzcafCQ==;
Received: from [2001:4d48:ad59:1403::17ca] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pX4iB-008oRc-Gi; Tue, 28 Feb 2023 18:28:27 +0000
Date:   Tue, 28 Feb 2023 18:28:23 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Antoine Tenart <atenart@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] crypto: inside-secure: Handle load errors better
Message-ID: <cover.1677608527.git.noodles@earth.li>
References: <Y/fkOF31BTQVocSe@sevai.o362.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/fkOF31BTQVocSe@sevai.o362.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 minor patches to improve the error handling of the safexcel driver
when it fails to load.

Firstly, make it clear when the reason for a load failure is because the
firmware is not available.

Secondly, ensure we clean up the ring workqueues / IRQ affinity settings
to avoid a kernel warning when the driver fails to load.

v2:
 - Expand error clean up to cover ring initialisation failures

Jonathan McDowell (2):
  crypto: inside-secure: Raise firmware load failure message to error
  crypto: inside-secure - Cleanup ring IRQ workqueues on load failure

 drivers/crypto/inside-secure/safexcel.c | 39 ++++++++++++++++++-------
 1 file changed, 28 insertions(+), 11 deletions(-)

-- 
2.39.2
