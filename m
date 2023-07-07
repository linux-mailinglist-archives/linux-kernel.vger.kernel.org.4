Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D266C74AEB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjGGK0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGK0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC3F12A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688725548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W30LF+UUNQf/l3DDH3XM8S2gxHzsMwoz+QRpsFhgavc=;
        b=gbFPdi0Oh9OxJyPsz+uNwnpUW7et8Qw/Dfux/VZ9aQwmN7BKFtbIC4L7J/dDQaL7Zn+9iy
        zRipR0zP5/4q5K83/kQ1I+/aV999AC7locRwXiPww0OhNe/Rh2jSZuZJfYL74RmAW4B4VE
        5DuyWL4BWQ2qIACvzaF01fIRSEMebTA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-i2fdoA9LMW-JqUOpFFu_ZA-1; Fri, 07 Jul 2023 06:25:43 -0400
X-MC-Unique: i2fdoA9LMW-JqUOpFFu_ZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7597D3C025AD;
        Fri,  7 Jul 2023 10:25:42 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A3F52166B25;
        Fri,  7 Jul 2023 10:25:42 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 3D2B830C0457; Fri,  7 Jul 2023 10:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 378983FB76;
        Fri,  7 Jul 2023 12:25:42 +0200 (CEST)
Date:   Fri, 7 Jul 2023 12:25:42 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        herbert@gondor.apana.org.au, horia.geanta@nxp.com,
        pankaj.gupta@nxp.com, gaurav.jain@nxp.com, heinzm@redhat.com,
        snitzer@kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, iuliana.prodan@nxp.com, dm-devel@redhat.com,
        meenakshi.aggarwal@nxp.com, linux-crypto@vger.kernel.org,
        davem@davemloft.net, agk@redhat.com, V.Sethi@nxp.com
Subject: Re: [dm-devel] [PATCH 1/3] dm integrity: do not filter algos with
 CRYPTO_ALG_ALLOCATES_MEMORY
In-Reply-To: <20230705201205.GA866@sol.localdomain>
Message-ID: <6388bd2-8342-d08-5b4b-7a37e8f8b323@redhat.com>
References: <20230705164009.58351-1-giovanni.cabiddu@intel.com> <20230705164009.58351-2-giovanni.cabiddu@intel.com> <20230705201205.GA866@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

If you allocate memory in crypto processing in dm-integrity, you risk the 
low-memory deadlock when swapping to dm-integrity.

I.e. the machine runs out of memory, it needs to swap out pages to free 
some memory, the swap-out bio goes to dm-integrity and dm-integrity calls 
the crypto API and tries to allocate more memory => deadlock.



On Wed, 5 Jul 2023, Eric Biggers wrote:

> On Wed, Jul 05, 2023 at 05:40:07PM +0100, Giovanni Cabiddu wrote:
> > The flag CRYPTO_ALG_ALLOCATES_MEMORY indicates that an algorithm might
> > allocate memory in the datapath and therefore sleep.
> > Dm-integrity is filtering out implementations of skcipher algorithms
> > that have this flag set. However, in the same function it does
> > allocations with GFP_KERNEL.

It's OK to use GFP_KERNEL in the device mapper target constructor (because 
at this point there is no I/O going to the device). But it's not OK to use 
it for individual bio processing.

> Which function is the above referring to?  The actual encryption/decryption
> happens in crypt_journal(), and I don't see any memory allocations there.
> 
> > As dm-integrity is re-entrant and capable of handling sleeps that could
> > occur during allocations with GFP_KERNEL, then it is also capable of
> > using skcipher algorithm implementations that have
> > CRYPTO_ALG_ALLOCATES_MEMORY set.
> > 
> > Remove the filtering of skcipher implementations with the flag
> > CRYPTO_ALG_ALLOCATES_MEMORY set.
> 
> What about the use of CRYPTO_ALG_ALLOCATES_MEMORY in get_mac()?
> 
> > 
> > Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Link: https://lore.kernel.org/linux-crypto/ZILvtASXQKLG43y9@gondor.apana.org.au/
> > Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
> 
> This needs:
> 
>     Fixes: a7a10bce8a04 ("dm integrity: don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY")
>     Cc: stable@vger.kernel.org
> 
> But, are you 100% sure the explanation in commit a7a10bce8a04 was incorrect?
> 
> - Eric

Mikulas

