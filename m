Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432286772F0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 23:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAVWKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 17:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVWKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 17:10:18 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89611CF53;
        Sun, 22 Jan 2023 14:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=yGzV0ybIavkqjq2iz0wfqkM5j6KRU5EMxWvZE/7pV3E=; b=F70jQDBiQR617ZLdGDP7uant4e
        AONziQ3DDGroR8XsJy8zUhlmMr/D0Ekr7C+tG7MtdXkPxEYHlHEGv9ItpyL56ckRXnHe4siKuYczh
        Zm5A7bfehDfb7Vf1swfNtLyhWpqC7B9DuSAGUzlQuhfe1yw4JbzYAN9pmqINrJk/zsxpEucSgT9wY
        skPxeV09tDzFiaRrHy7RlUYJ4JOfwVNNJj1OpBVev0P4ia+onxOJTH0arDbF1xiCFXxHEY8xjRUuQ
        jaaO4Wv8tRugrqS3bc1l+xq7DZGn9R6xxwYTN+vbjzB/OYNOF5gLI2c6yqQLKD6u8dbjltaSUURno
        VcZjtUNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pJiXM-003UPe-2o;
        Sun, 22 Jan 2023 22:10:04 +0000
Date:   Sun, 22 Jan 2023 22:10:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tom Rix <trix@redhat.com>, tim@cyberelk.net, nathan@kernel.org,
        ndesaulniers@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] paride/pcd: return earlier when an error happens in
 pcd_atapi()
Message-ID: <Y820PCtcJv12fJpI@ZenIV>
References: <20230122154901.505142-1-trix@redhat.com>
 <1a501bc9-7058-6c47-0ebf-44459bc0e730@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a501bc9-7058-6c47-0ebf-44459bc0e730@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 01:49:00PM -0700, Jens Axboe wrote:
> On 1/22/23 8:49 AM, Tom Rix wrote:
> > clang static analysis reports
> > drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
> >   is a garbage value [core.UndefinedBinaryOperatorResult]
> >   tocentry->cdte_ctrl = buffer[5] & 0xf;
> >                         ~~~~~~~~~ ^
> 
> Has this one been compiled? I'm guessing not tested...
> 
> In any case, this code is going away hopefully shortly, so let's not
> bother with changes like this.

	Look at the callers - the value left in entry is discarded if
->audio_ioctl(..., CDROMREADTOCENTRY, &entry) returns non-zero.  Sure,
it's a nasal daemon territory, but realistically it's not going to be
caught by testing.
