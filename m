Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7C748EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjGEUSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGEUSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C21985;
        Wed,  5 Jul 2023 13:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB15A61712;
        Wed,  5 Jul 2023 20:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4630C433C7;
        Wed,  5 Jul 2023 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688588294;
        bh=Hk4tiWZ1zcoFlQt6mk0hEPk2/GJbldA+/74Zn17a/lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDBK+FfBQjWPIa7U+f/t9in5mlec5MkIQVWUHC6FCzoXXcQ7tbgOvt0hX+otqlGhE
         MZ7WlymKSt9x1A8f0pB2dfZ0XJDWNszJ6wcVoqUB4yJo7zGTz9pvp8/zL7I3WtQwSJ
         yR5OpFUONzPQAh3KFiAwSrPYDLirY8BVUFVERotL3wg6ZmqBHbXsBgVh+TOfz3DbgQ
         CntL8V6SbHWVTsi0pyB0/yVW8h38gmvqxr6/kHVPdvydlxlLmJIqdCqKTX+qqH/JUq
         d2Cd7LgnZ5Jgo2iQcf5orctzjRUsmay294IbvCyX0k/CYgr/KWCYrv5d2hJS4wGLNE
         X+MAcPxYM64AA==
Date:   Wed, 5 Jul 2023 13:18:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     herbert@gondor.apana.org.au, agk@redhat.com, snitzer@kernel.org,
        linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, qat-linux@intel.com,
        heinzm@redhat.com, meenakshi.aggarwal@nxp.com,
        horia.geanta@nxp.com, V.Sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net, iuliana.prodan@nxp.com,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: Re: [PATCH 2/3] crypto: api - adjust meaning of
 CRYPTO_ALG_ALLOCATES_MEMORY
Message-ID: <20230705201812.GB866@sol.localdomain>
References: <20230705164009.58351-1-giovanni.cabiddu@intel.com>
 <20230705164009.58351-3-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705164009.58351-3-giovanni.cabiddu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 05:40:08PM +0100, Giovanni Cabiddu wrote:

> Algorithms that do not set this flag will guarantee

"will guarantee" => "guarantee"
 
> that memory is not allocated during request processing, except in
> the avoidable exception cases described below.

"avoidable exception cases" => "exception cases"

Whether they are avoidable depends on the user.

> * Users can request an algorithm with this flag unset if they can't handle
> * memory allocation failures or sleeping during request processing.

Why add the "sleeping during request processing" part?  Isn't that controlled on
a per-request basis by CRYPTO_TFM_REQ_MAY_SLEEP which is a separate thing?

> * They should also follow the constraints below.

"should" => "must"

> + *	- The input and output scatterlists must have no more than 4 entries.
> + *	  If the scatterlists contain more than 4 entries, the algorithm may
> + *	  allocate memory.

"If the scatterlists contains" => "If either scatterlist contains"

Otherwise it is unclear whether this is talking about the length of each
scatterlist individually, or the sum of their lengths.

- Eric
