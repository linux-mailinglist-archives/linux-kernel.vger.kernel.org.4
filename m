Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C581644DED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLFV0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:26:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFAA4841A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 13:26:28 -0800 (PST)
Received: from zn.tnic (p200300ea9733e711329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e711:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE0841EC0523;
        Tue,  6 Dec 2022 22:26:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670361987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YVDn0S8JQnZN5dcrnKjo8zsfbWVS/GOKauD82aiLVQQ=;
        b=k3p47DcFVuXJM8onhOBSue39zUDf2NtSZ560L/Q/UkcBnwDQn9r4LgyKfNSc04LKx6gCx1
        MFY19yVzPP1FJBIamZWTWFxC+M6AzNa362IYaE6hcPq3XJ/xKyV8JgzriDHbJ91ExbsxWb
        ubjtbDRqGbxoLWi5CBOb2DfMqqURapQ=
Date:   Tue, 6 Dec 2022 22:26:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v8 1/4] crypto: ccp - Name -1 return value as
 SEV_RET_NO_FW_CALL
Message-ID: <Y4+zfgU639095B6K@zn.tnic>
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-2-dionnaglaze@google.com>
 <Y4tAX580jEGHOU9d@zn.tnic>
 <CAAH4kHYz-46syE4wKPzo1N9P34wLHcs85obOCjqb6eQ=iv=n3w@mail.gmail.com>
 <Y4ulj38eMr1NiRdX@zn.tnic>
 <CAAH4kHbZM9YW0BvwxrQNFysHwB8JkPJzFRN9RdwhmixhbtsCyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAH4kHbZM9YW0BvwxrQNFysHwB8JkPJzFRN9RdwhmixhbtsCyw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:05:19AM -0800, Dionna Amalie Glaze wrote:
> Arguably it shouldn't ever get this value. We're just not very
> selective when we copy back the kernel copy of the ioctl argument.
> In all cases user space should treat the value as undefined, but still
> we don't want to leak uninitialized kernel stack values.

Absolutely.

> I've changed it to -1 to name the same kind of error across host and
> guest: the communication with the PSP didn't complete successfully, so
> the "error" value is not from the PSP.
> This value can also get returned to user space during a -ENOTTY result.
> We can call this NO_FW_CALL or UNDEFINED. I have no real preference.

Me neither as long as this is written down and agreed upon as a possible
value and not leaking kernel stack.

> Whatever value we set initially, the VMM can overwrite exitinfo2
> during the ghcb_hv_call.
> I'd rather that the "undefined" values were the same across both,
> because the guest is merely receiving a value from the host's PSP
> driver (or should be).
> It keeps the enum for return values a bit tidier and not concerned
> with whether the value is viewed from the host or guest.

Ack.

...

> I hope the above discussion is clear that it's purely a defined
> "undefined" because being pickier about what to copy_to_user during
> exceptional circumstances in order to not overwrite the user's fw_err
> value seems an unnecessary amount of code.

Ok, I think we're on the same page. So pls document that NO_FW_CALL or
so value and what it means and that thing should be taken care of.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
