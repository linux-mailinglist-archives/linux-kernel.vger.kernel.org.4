Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37052743165
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjF3ACA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjF3AB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074992974
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 908726165E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B16C433C8;
        Fri, 30 Jun 2023 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688083317;
        bh=Bej09wYFcT6D4FI/gm1ZGuRayoSdiiH2baukOvRvHEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LWmFFlvh/aXLzdmV/dcJn2GkigvCiQc4jA7nQOHqgG2p9NVoIcuBPwtlHgVSDIK/+
         P6tfAOINFIzPaS1CaW8XWgs/r6B6QCZJV0uCr1+EwSz450QpPBHiYM8ZYeinUqLrjP
         TiQQSKO7TvNHS4zAQCm0eMEsYBGHFik9pPojQBGLctgE0iSVu68gKlwsSqUEZvqwBy
         R+DNMVdyT3OyWCZQX9nkVqe15fOYjfFX9PiwIhu3tbUwqFoqmjEAzN5TxOIX9EjOL5
         WQP6ONBI2NMuVu1siTtZGqMAnS2FpBpqCzpPPwqtoad0MWatYvMk+VYlhYrVIcHtr0
         ZePiyxj0S2FAQ==
Date:   Thu, 29 Jun 2023 17:01:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
Message-ID: <20230629170155.175d71aa@kernel.org>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
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

On Thu, 29 Jun 2023 16:54:29 +0100 David Howells wrote:
> I'm more inclined to adjust the documentation since the behaviour we
> have has been that way since 2005, I think.

+1 FWIW I think that networking always operated under the assumption
that the pages may change. In TLS we require explicit opt-in from users
that the pages they send will not get changed, if it could cause crypto
errors (TLS_TX_ZEROCOPY_RO).
