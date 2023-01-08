Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78853661451
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjAHJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 04:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 04:34:41 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5293EFD28
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 01:34:40 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3089YaL6017919;
        Sun, 8 Jan 2023 10:34:36 +0100
Date:   Sun, 8 Jan 2023 10:34:36 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Warner Losh <imp@bsdimp.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: Fix S_ISxxx macros
Message-ID: <20230108093436.GC17754@1wt.eu>
References: <20230106171834.41532-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106171834.41532-1-imp@bsdimp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Warner,

On Fri, Jan 06, 2023 at 10:18:34AM -0700, Warner Losh wrote:
> The mode field has the type encoded as an value in a field, not as a bit
> mask. Mask the mode with S_IFMT instead of each type to test. Otherwise,
> false positives are possible: eg S_ISDIR will return true for block
> devices because S_IFDIR = 0040000 and S_IFBLK = 0060000 since mode is
> masked with S_IFDIR instead of S_IFMT. These macros now match the
> similar definitions in tools/include/uapi/linux/stat.h.

I'm impressed to see how I managed to make that gross a mistake!
Thanks for catching it and for the fix, its now queued.

Willy
