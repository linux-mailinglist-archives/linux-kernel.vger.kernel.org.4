Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BFD7374CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjFTTAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjFTTAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:00:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F13C2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 884BF6144C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8BBC433C0;
        Tue, 20 Jun 2023 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287639;
        bh=aeob/U1QWvlw2SLSBaYJ+uRLt9KuAyJq7oSNJ2cwddk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ElH8Oxja4qtbyt7Y5e4T8sKg6wiw4UyeydMRK2pcxDXdFAe7VZNpTGkhOCTlop5bP
         D6+/BKVpcaqMmwaUrAxR/NhYyTezgnBQXUY/eqODABRCiS/APmqh7799iKRQYu9MIq
         Ok9/RUzzp+UTjdKzYBmp5T8zjWhp9Izet01Wj6wI5DwKDPGUZOBV6t4+cXnzpcqqK1
         PAKj/sKkU/VryPEmFM49rhmvLxhzn5LaQ6uOMuu+46LIyVeAiK9OH+YyMncCxeIB8m
         ThGQdlSyB+Wg4+NtxrxBXqXF1qm5I+FEt38jCYK/BU1Lhtr0Aun4tpA+tOMXiJMeIM
         rwzi1NCSAaE8Q==
Date:   Tue, 20 Jun 2023 12:00:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Simon Horman <simon.horman@corigine.com>,
        Igor Russkikh <irusskikh@marvell.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] net: atlantic: fix ring buffer alignment
Message-ID: <20230620120038.0d9a261c@kernel.org>
In-Reply-To: <ZIxfK1MVRL+1wDvq@corigine.com>
References: <20230616092645.3384103-1-arnd@kernel.org>
        <ZIxfK1MVRL+1wDvq@corigine.com>
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

On Fri, 16 Jun 2023 15:10:03 +0200 Simon Horman wrote:
> Perhaps it just me.  But I do have trouble reconciling the description
> above with the structure below. As such, my suggest would be to simply
> delete it.

Agreed that the comment is confusing seems to be incorrect post-change.
Flags for instance are overlapped with len, is_gso etc. so they can't be
a separate 8B at the end.

Igor, please advise how you want to proceed.
