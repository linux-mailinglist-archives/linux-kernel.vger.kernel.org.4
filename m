Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707B374AEDA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjGGKmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGKmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15209172B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688726484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2/vCgILvmVJSsmBnlxcM6iJxhHNGN00w3k9umPrbhE=;
        b=RvDJB2h00TGMEj9nNkUXzyOFXqAWqdjup68Po8PubF8Vs9jwDrtbRTTBhIFrDH7EKMQ8/0
        uD8p6z+gdI1igmHSeL7MJFYNEX8t9r2A6TQAuX6Hvt2mMIvbfrhc+dE2DNVwJWmeYhwrOu
        6X3V3j0IHr4wjO0MGpQzVAq/HfmJf6U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-_-BNR3qjO8ycyI6cBa31ZQ-1; Fri, 07 Jul 2023 06:41:20 -0400
X-MC-Unique: _-BNR3qjO8ycyI6cBa31ZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 395B63C0F68E;
        Fri,  7 Jul 2023 10:41:19 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F4B6F640B;
        Fri,  7 Jul 2023 10:41:19 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 0A67530C0457; Fri,  7 Jul 2023 10:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 06C5A3FB76;
        Fri,  7 Jul 2023 12:41:19 +0200 (CEST)
Date:   Fri, 7 Jul 2023 12:41:19 +0200 (CEST)
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
Subject: Re: [dm-devel] [PATCH 2/3] crypto: api - adjust meaning of
 CRYPTO_ALG_ALLOCATES_MEMORY
In-Reply-To: <20230705201812.GB866@sol.localdomain>
Message-ID: <daf1c4c8-292f-4954-9bde-b6d891a832dc@redhat.com>
References: <20230705164009.58351-1-giovanni.cabiddu@intel.com> <20230705164009.58351-3-giovanni.cabiddu@intel.com> <20230705201812.GB866@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2023, Eric Biggers wrote:

> On Wed, Jul 05, 2023 at 05:40:08PM +0100, Giovanni Cabiddu wrote:
> 
> > Algorithms that do not set this flag will guarantee
> 
> "will guarantee" => "guarantee"
>  
> > that memory is not allocated during request processing, except in
> > the avoidable exception cases described below.
> 
> "avoidable exception cases" => "exception cases"
> 
> Whether they are avoidable depends on the user.
> 
> > * Users can request an algorithm with this flag unset if they can't handle
> > * memory allocation failures or sleeping during request processing.
> 
> Why add the "sleeping during request processing" part?  Isn't that controlled on
> a per-request basis by CRYPTO_TFM_REQ_MAY_SLEEP which is a separate thing?
> 
> > * They should also follow the constraints below.
> 
> "should" => "must"
> 
> > + *	- The input and output scatterlists must have no more than 4 entries.
> > + *	  If the scatterlists contain more than 4 entries, the algorithm may
> > + *	  allocate memory.
> 
> "If the scatterlists contains" => "If either scatterlist contains"
> 
> Otherwise it is unclear whether this is talking about the length of each
> scatterlist individually, or the sum of their lengths.
> 
> - Eric

Hi

I wouldn't change the meaning of CRYPTO_ALG_ALLOCATES_MEMORY (because 
people will forget about this subtle change anyway).

Also note that dm-integrity allocates arbitrarily large sg-lists when 
encrypting the journal, so if you change the meaning of 
CRYPTO_ALG_ALLOCATES_MEMORY, there would be no flag left for dm-integrity 
to test.

I would introduce a new flag, something like 
CRYPTO_ALG_ALLOCATES_MEMORY_FOR_5_OR_MORE_SG_ENTRIES. dm-crypt can then 
filter the algorithms based on this flag - and the rest of the kernel code 
may stay unchanged.

Mikulas

