Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0331C73B8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFWNlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFWNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:41:17 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88B862688;
        Fri, 23 Jun 2023 06:41:16 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E9A1392009C; Fri, 23 Jun 2023 15:41:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E507992009B;
        Fri, 23 Jun 2023 14:41:14 +0100 (BST)
Date:   Fri, 23 Jun 2023 14:41:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] MIPS: dec: prom: Address -Warray-bounds warning
In-Reply-To: <20230623131019.GD11636@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2306231432120.14084@angie.orcam.me.uk>
References: <ZJTcvfpvhvF+OLjc@work> <20230623131019.GD11636@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023, Thomas Bogendoerfer wrote:

> > Zero-length arrays are deprecated, and we are replacing them with flexible
> > array members instead. So, replace zero-length array with flexible-array
> > member in struct memmap.

 Technically it is a semantics bug fix actually, as the TURBOchannel 
firmware specification (from Jan 1993) says it's:

typedef struct{ int pagesize; unsigned char bitmap[];}memmap;
int getbitmap(memmap *map);

(formatting preserved as in the document) so it should have always been a 
flexible array member.  Maybe old (2.x) GCC versions had an issue with it 
or something, as otherwise I can't imagine why whoever added our typedef 
did it differently from the spec.

> applied to mips-next.

 Not sure if you can retrofit it, but:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
