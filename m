Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A74D6ED78E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjDXWJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjDXWI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:08:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D763783CF;
        Mon, 24 Apr 2023 15:08:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q4zkn6JTQz4wgv;
        Tue, 25 Apr 2023 08:07:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1682374034;
        bh=GddNnol6YaHH8rm7F5s2DGk04beKSm23ST/yGyZyL6U=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=TqvT2wbacCDaYEYDw8Cw/06md42z0Ft42g8d2loJiP6oKtJKR9B+BO1tQxknL7O0+
         xHMtwZupuQ1w7gUsv6IisIF//qd4Y4hZI3kxUd9KfgQF6w/5OjIsXwq8drwcUuMjRe
         66BZuzYAZ4SM6llfYKshjKJIh5rj20HbevDL5xX/TMB2Y/p8E55gHi+8asUYMixzmc
         prF8+buWbfVI03axdZdlUUXRvcLURz0GNFS+gWqMFkU98HoirT44IbzLB1J8mKuAv2
         sdSfKjqJBV24hDiOmhzC7R7Rdo6k+zl1XFqJqEgVRK6uzp4kMSHTKyoAFNG2ukHahK
         c0ermrBykUYsA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
In-Reply-To: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
Date:   Tue, 25 Apr 2023 08:07:10 +1000
Message-ID: <87cz3tylwx.fsf@mail.concordia>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
> Dear PowerPC and RCU developers:
> During the RCU torture test on mainline (on the VM of Opensource Lab
> of Oregon State University), SRCU-P failed with __stack_chk_fail:
...
> by debugging, I see the r10 is assigned with r13 on c000000000226eb4,
> but if there is a context-switch before c000000000226edc, a false
> positive will be reported.
>
> [1] http://154.220.3.115/logs/0422/configformainline.txt

Says:

CONFIG_CC_VERSION_TEXT="powerpc64le-linux-gnu-gcc-10 (Ubuntu 10.4.0-4ubuntu1~22.04) 10.4.0"

Do you see the same issue with a newer GCC?

There's 12.2.0 here:
  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/12.2.0/
  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ppc64le/12.2.0/

Or if you can build in a Fedora 38 system or container, it has GCC 13.

cheers
