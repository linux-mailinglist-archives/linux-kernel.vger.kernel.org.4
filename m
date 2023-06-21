Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2979B73847F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjFUNKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjFUNKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:10:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CCCE57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:10:08 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7EC41EC03C0;
        Wed, 21 Jun 2023 15:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687353006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dShN/AtqsESo0zmQWkLwx8/tPFGQXcWK2Qh/w4XV2Hk=;
        b=TWLu2AYwh5/N2Bm9Xaa6h7SThIoekd8cfEtDE8AOtwAXTjcDUBUdH+WC+Ln1RzFr4WxYvo
        1iTPSOYHvnymLPX1DcM5UrUu5AC1TvR+g5UMbemT+Cj/Qw3VxZsvEytCmcNvLUHVizUkkw
        hX5OsTB9ThGtApZ4BBtpx7WYq0Y0tiE=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nSGXzeZ7wJH4; Wed, 21 Jun 2023 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687353004; bh=dShN/AtqsESo0zmQWkLwx8/tPFGQXcWK2Qh/w4XV2Hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0SzsK0QiMQd6TUvTd0Xu95T2QL111iE3+T4ycofW8zyahk8VIdo6wfelfUd2dwYi
         DuovVcLRVlwP9gYTmS7mMpGBm148o3/xIiA284EmwXf07QrryHL2H70OdFZ1Y8RzyO
         5r4sdONN2eGCZ8Lhhml8/yJp7jPBX6pKOdbGbiGmP7Foaf64+oNhXAGKn1ZX9OTw6p
         3kOr6EQGWQ+DSA16ekO5MxANth4O7bINFfucrClJ2CkayFq8zdZx96yiLvi1yI59TR
         861B9vUX5ARmv5BUalsjfLSOwznl9zTsVQmoqAihlglBzU3Q0Ydit0HnpSi2hD79QK
         qOjl/tnVSl8Fu300DIrG/EJ+AW/NugNbI3qG6HfimGshf2GhyUnAYm9DK4B2vjdPs8
         gqp47kU4MspN41CVpT1bD/o92Ci5SPhlgAvYmpS9YGvLOD7Qn7ISuhWTmQFEDDrTCQ
         XWWMAUBtSHIx6wFsGwLbCRMrDQhOY7mm30R7rSrK7EdJDQoLpv7JJK6lnFwXFSHwjh
         SMx3BFe6KAsfeONI11n8X6hpZEuWnIbLnBFVuQ1uhnzQ1hISE4IHQZOumh6e2+ST2y
         hut5ySOI8vooSoWtvybRiPYiJRMHumIooMtvWPsfnFPu7NBmT1gjuI6cblYubW7Ucq
         o1r0n3ifGvNH+s4QKriUYCZw=
Received: from zn.tnic (p200300ea971dc565329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c565:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5044940E019B;
        Wed, 21 Jun 2023 13:10:00 +0000 (UTC)
Date:   Wed, 21 Jun 2023 15:09:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: A question about prefetchw detection in "x86/asm: Cleanup
 prefetch primitives"
Message-ID: <20230621130955.GHZJL2o771lIEPURUl@fat_crate.local>
References: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
 <20230621111346.GFZJLbavDw1JiLi34n@fat_crate.local>
 <a155ebb791d3aefce5db32658e3c519a1cfac1f6.camel@xry111.site>
 <e76180a1b82d1c29715587e94e2d6923b64bb893.camel@xry111.site>
 <20230621125749.GGZJLzzUw0rA3goV1X@fat_crate.local>
 <b50735128c5a985634468d63fef092f093f0aebc.camel@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b50735128c5a985634468d63fef092f093f0aebc.camel@xry111.site>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:06:51PM +0800, Xi Ruoyao wrote:
> I think it's not an issue in the kernel itself, but announcing
> 3dnowprefetch in /proc/cpuinfo for an old Intel CPU w/o real prefetchw
> implementation seems problematic (to me).

And this is a problem because?

Think practically.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
