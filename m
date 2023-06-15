Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285EF730EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbjFOGDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243264AbjFOGDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BC32716
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:02:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84BDE62964
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7429BC433C0;
        Thu, 15 Jun 2023 06:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686808961;
        bh=fE+EH/4fj3DJZDVn9ec0SNsTOWyotHaRxtT2lAgs+ZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CGNr6G/zzyvYn6sOEvvyJP4hyUtej5y42IbPSwRd9kxmtdFmfIMJ3+BHXVmObmh0t
         7Aqu5niW+4rpKNtdD33jsOr4sOn5gU5XLDKRiWmOqFH0A0ATXQTHGs1AxSxPWiOch8
         6AUEVQIeAtlczmaQk5aVwbyCBE5Q6qCoEFA/o++WkLpuz5gUIC/Uls2QhRCOc6pILk
         MZaC6Uqcrg14qsWfEY31VHkKbu1EX66LSpUwQjbG1JnwJml61For+8D4tcSqzZOaJi
         Tx1a6js1sSJV2C8dLAlpBdKnHAc7Yvfp06zjcWcaPR83fsa+5tKTuNB6OXAMJ/ZVyg
         L84i96kBx8Sqw==
Date:   Wed, 14 Jun 2023 23:02:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Lior Nahmanson <liorna@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: macsec: fix double free of percpu stats
Message-ID: <20230614230239.02c388a8@kernel.org>
In-Reply-To: <ZIot16xcgb7l8wer@hog>
References: <20230613192220.159407-1-pchelkin@ispras.ru>
        <20230613200150.361bc462@kernel.org>
        <ZImx5pp98OSNnv4I@hog>
        <20230614090126.149049b1@kernel.org>
        <20230614201714.lgwpk4wyojribbyj@fpc>
        <ZIot16xcgb7l8wer@hog>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 23:15:03 +0200 Sabrina Dubroca wrote:
> It's been 7 years... your guess is about as good as mine :/
> 
> I wouldn't bother reshuffling the device creation code just to make
> the handling of rare failures a bit nicer.

Would you be willing to venture a review tag?
