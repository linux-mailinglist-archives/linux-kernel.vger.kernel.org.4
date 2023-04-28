Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B76F1D39
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbjD1RL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD1RL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:11:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C561BF8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dupw+FcCulTehfGlM7sQlmsEP4QRXDSlIQS3J7feOkg=; b=QBDumUIaE0Cn175yZiZtKSmeZv
        A94LmveRkgMWUi3P4zb5SpNGzRwehGik8xDxRkUu9aiOzlaaWiu4SjfugehyNzHWm+RLT6MgJ4SW5
        f1ho1rfmZVLpWptjyGuX/nOBZ2GpIb/5/0hPdMy0BKVuDoe2ZdgNoRwN+tbOrYh0kzJBFe4SmfTlT
        vdBwwWZ31yW+JppaRJaUCc3CfsAQtS/RVJPxTYWIRMSJyITZPW7vUYpRwsTSEMkMuu6SCxSm6r1qw
        VWQe9hKU2j7K5ia7Th+0v9m3Ihqw2uXndEHxDSIBr9dp6GMUo/SLm/whsLkK4fEWyXfTbKLlKfNFk
        MbtnVfKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1psRdJ-00DZoY-0n;
        Fri, 28 Apr 2023 17:11:45 +0000
Date:   Fri, 28 Apr 2023 18:11:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: tty_io: remove hung_up_tty_fops
Message-ID: <20230428171145.GD3390869@ZenIV>
References: <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <20230428162718.GA1099174@dev-arch.thelio-3990X>
 <6dca757e-74ac-773d-2a50-4e48b2f56880@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dca757e-74ac-773d-2a50-4e48b2f56880@I-love.SAKURA.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 01:41:02AM +0900, Tetsuo Handa wrote:
> On 2023/04/29 1:27, Nathan Chancellor wrote:
> > I see this change has shown up in -next as commit 4c87e9e5479b ("tty:
> > tty_io: remove hung_up_tty_fops"), where it causes the following warning
> > for configurations without CONFIG_COMPAT (I used ARCH=arm defconfig):
> > 
> >   drivers/tty/tty_io.c:446:13: warning: 'hung_up_tty_compat_ioctl' defined but not used [-Wunused-function]
> >     446 | static long hung_up_tty_compat_ioctl(struct file *file,
> >         |             ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > I am not sure if you just added that patch for additional test coverage
> > or for final acceptance but the following diff resolves this warning for
> > me, perhaps it can be folded in for a v2?
> 
> Thank you for reporting. Yes, moving the definition will solve the warning.

	IDGI...  Why do you need to keep that function at all?  Compare it
with hung_up_tty_ioctl() - they are token-for-token identical; the only
difference is the function name...
