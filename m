Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0069BFF4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 11:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjBSKbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 05:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSKbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 05:31:36 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC9FB10243;
        Sun, 19 Feb 2023 02:31:34 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pTgyj-0001a5-00; Sun, 19 Feb 2023 11:31:33 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E29AAC28CF; Sun, 19 Feb 2023 11:31:12 +0100 (CET)
Date:   Sun, 19 Feb 2023 11:31:12 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Sander Vanheule <sander@svanheule.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
Message-ID: <20230219103112.GA4095@alpha.franken.de>
References: <20230115121922.6359-1-sander@svanheule.net>
 <20230127162755.GB6090@alpha.franken.de>
 <46724036-fabf-7bae-41f8-1e95c5f1db5c@schinagl.nl>
 <20230205161929.GD4459@alpha.franken.de>
 <f9c1be9c-478e-55e8-ad34-370641181015@schinagl.nl>
 <20230217173708.GA14134@alpha.franken.de>
 <af2cdad5-ee32-7956-cd77-2a18777a3857@schinagl.nl>
 <20230219090248.GE2924@alpha.franken.de>
 <54238ab7-b7c0-a3a3-38e9-f7879866fb3c@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54238ab7-b7c0-a3a3-38e9-f7879866fb3c@schinagl.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 10:27:17AM +0100, Olliver Schinagl wrote:
> It's still odd though; as we do not have _anything_ PCI, but it
> SWAP_IO_SPACE causes the crash.

but something uses readX/write() calls. If you aren't using any driver
existing driver but only newly written dedicated for that SOC
you could use raw_read/raw_writeX() instead. These type of functions
are always using native endianess.

> What makes SWAP_IO_SPACE generic then? :)

als long as hardware presents memory used with readX/writeX is
seen as little endian independant from CPU endianess it's generic.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
