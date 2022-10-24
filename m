Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A3C60BDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJXWvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiJXWuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:50:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0731FBFE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ZSbC1IVWiIAbIJCUCGttQ9weksvxLPKZ/m64zctsts=; b=ju4fAjHQPvtRj0VSkVMoxApNoB
        1wijSIHHMCXnuPu+LDpyBemfdp+fekCYc4yQ9VtUZMkhpP7uvfzl9UBXIByKtz71RAqUC2rZhGeGh
        4c0dX+ZxvbLL1wOW3rySXt7YfjkNKXoh4VngVdC4bnF7dvSCViFzuV8/1CQsWdn5xTT9aaikWgryQ
        d3quMb82+Oa6f6iMum8dmR7E5sC6lUYK6Iq4rOlrdaOzfi7VaQoqW71NlW2jy/TeMu6B3VrDCKqv5
        Zk3d4YUE7pHyw8C+5W5w2KHAvYBZbM45jsxy3c2zLf8HQRcLR6GrT8Zv0kMDBva2txm89spfFQ8EU
        /Vh9PocA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1on4jQ-00DaDF-0m;
        Mon, 24 Oct 2022 21:11:36 +0000
Date:   Mon, 24 Oct 2022 22:11:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: au88x0: use explicitly signed char
Message-ID: <Y1b/iNMncyKI/W5c@ZenIV>
References: <20221024162929.536004-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024162929.536004-1-Jason@zx2c4.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 06:29:29PM +0200, Jason A. Donenfeld wrote:
> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, signed chars need to be marked
> explicitly as such. This fixes warnings like:

It might make sparse to STFU, but it does *not* resolve the underlying
issue:

vortex_adb_checkinout() returns a number in range of 0..31 on success
and -ENOMEM on failure.  Quite a few callers don't bother to check...
