Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E6A71314D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjE0BIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjE0BIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:08:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D265189
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23C71654A8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 01:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECFFC433D2;
        Sat, 27 May 2023 01:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149726;
        bh=5zHdJvK0bRkHVe/BmCiGndweGuWhBH6cjRIMmLkfBi8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yn5ttwEb4eOBNsxFRNaaKLoRAE0oaarcy3jczitqa0fQZz9JIWsPlV+QDEjoOazUV
         JeoDyIHBJEW1zs0+LkrRU3D4B0eb3PvBLeuri5uSFyD5UMg3QdX2JV9y3IYQv1BIlW
         puUR5KhLkbtSPGR9HUhR6ZxrtxZFOot1yo8YBVmOye1fNsuPh4kzZgl00bOSU+vZfh
         ayjW+kLDNYEYmSznXcLjQdTM/yIdiJUuil/DoaFN58Sb1dn8KIrXrU8jSNZSlfdLQB
         RjyQ+iwmAxl/x94z8JS5lAZ5YBOa8lBvYztVJQOGK15c70HVS62KyyB566CnEW0lHQ
         sm6Xh/p7tt7xw==
Date:   Fri, 26 May 2023 18:08:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next 09/12] tls/sw: Support MSG_SPLICE_PAGES
Message-ID: <20230526180844.73745d78@kernel.org>
In-Reply-To: <20230524153311.3625329-10-dhowells@redhat.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
        <20230524153311.3625329-10-dhowells@redhat.com>
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

On Wed, 24 May 2023 16:33:08 +0100 David Howells wrote:
> +static int rls_sw_sendmsg_splice(struct sock *sk, struct msghdr *msg,

s/rls/tls/ ?

Will the TLS selftests under tools/.../net/tls.c exercise this?
