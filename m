Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4B720E2C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 08:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjFCGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjFCGiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 02:38:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF1C6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 23:38:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3553160A4C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 06:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C172C433EF;
        Sat,  3 Jun 2023 06:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685774328;
        bh=Ww3/vKUJQBHff7cB+X/RbuQRVkrsQ3I889K7iIKiGtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L15nmu+93564FFy5+uxruKubBk9dQaOHm/98Rgy8ruUPaZ+0OOOuxL+uXmbevFJGS
         Lipb6mlFr+Zs4L0bgLsfYv8iBYDf9HK8ugxT1doVDzdaJHWJQt2g3Ub2oBwWuCIzpn
         yEUw9JcaIbXRuwVPtFYlY2G/lXEI5GYgfleyY+ypQYKJoGrrn9sGm+0VgkeuCXiJfg
         u8Ew+w4azeFMPb9OCU0Kbgj4rOSHya050OJt133/6+/tn3ZFKRZdsyohc/yHYMsE9W
         8OjNnkGBnMFRxa9V3Tx+knQXAZ5v6mTPjKqIlaE8Tk50AGCh5OKvbDlDLffb+itTfP
         o3+3vS6BlL5Kw==
Date:   Fri, 2 Jun 2023 23:38:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next v3 11/11] net: Add samples for network I/O and
 splicing
Message-ID: <20230602233847.06c01102@kernel.org>
In-Reply-To: <20230602150752.1306532-12-dhowells@redhat.com>
References: <20230602150752.1306532-1-dhowells@redhat.com>
        <20230602150752.1306532-12-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Jun 2023 16:07:52 +0100 David Howells wrote:
> Examples include:
> 
> 	./splice-out -w0x400 /foo/16K 4K | ./alg-encrypt -s -
> 	./splice-out -w0x400 /foo/1M | ./unix-send -s - /tmp/foo
> 	./splice-out -w0x400 /foo/16K 16K -w1 | ./tls-send -s6 -n16K - servbox
> 	./tcp-send /bin/ls 192.168.6.1
> 	./udp-send -4 -p5555 /foo/4K localhost

Can it be made into a selftests? Move the code and wrap the above in a
bash script?
