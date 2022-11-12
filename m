Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09469626647
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 02:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiKLBzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 20:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLBzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 20:55:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7302BD0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:55:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8D3AB82878
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D73C433D6;
        Sat, 12 Nov 2022 01:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668218120;
        bh=fgmYqNrujDVO3mYJp1YcFQWlrmMolvGD2bz9AIt6/r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2OALwu9R3vpVGygcSTecpj34reTKkU+wR4SQPGT1SezuSGLiCgi4eHo2m/AsYgr9
         z4XWlkTDsZaFbkYUefFz5H2Lt4ipKkJUTsanv1KwRconQuL0AIq5zrQjks24iiCFoU
         wo6rZpbsLv/yYT5BNi9sy02gvlTO38/Do88+u2UtqKXksyu69hUNwtAO0FALHBp7c2
         co+mv9SQXwHcbi7ggTro1VL+RPlgPh81DCOdibtrRthhSMGpS+l4EYNv1RQl7XJ3HR
         3F7q8Y0z9B5VGR9aphbvZNK9bg93/3MZobX34Ix2AVVPz5ki4t+OZAcNHkmQTnOEKx
         p0dZ+qxTq8sXw==
Date:   Fri, 11 Nov 2022 17:55:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nick Terrell <terrelln@meta.com>
Cc:     syzbot <syzbot+40642be9b7e0bb28e0df@syzkaller.appspotmail.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in
 f2fs_handle_error
Message-ID: <Y279BqPNYAr+5OxC@sol.localdomain>
References: <0000000000006a83e705ecea7171@google.com>
 <E31B0CBC-F169-4C7D-9FE6-F928C0F802AF@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E31B0CBC-F169-4C7D-9FE6-F928C0F802AF@fb.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 12:15:08AM +0000, 'Nick Terrell' via syzkaller-bugs wrote:
> 
> Not quite sure why I am CC'd here, I don't see anything related to zstd or compression in this stack.
> Just want to check that it is likely unrelated, and that I'm not missing something.
> 
> Best,
> Nick Terrell

It's because:

$ ./scripts/get_maintainer.pl fs/f2fs/super.c
Jaegeuk Kim <jaegeuk@kernel.org> (maintainer:F2FS FILE SYSTEM)
Chao Yu <chao@kernel.org> (maintainer:F2FS FILE SYSTEM)
Nick Terrell <terrelln@fb.com> (maintainer:ZSTD)
linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM)
linux-kernel@vger.kernel.org (open list)

Do *not* use content regexes (K: zstd) in MAINTAINERS unless you are absolutely
sure you want to be notified about every file that contains your regex.

If you do want to use a content regex anyway, you might want to look into
changing get_maintainer.pl to make them only apply to patches that contain the
regex, as I think that might be what people are expecting it does.

- Eric

