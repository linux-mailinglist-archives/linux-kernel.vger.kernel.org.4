Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702D37397DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFVHLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFVHLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:11:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685661BE4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E479E61777
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E00C433C8;
        Thu, 22 Jun 2023 07:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687417859;
        bh=8jQouzNvFfI0w53rF3Myv7DfKU8b+aG1x+36kHMU0rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3NtvxXoUn5ieC5W6teQ8K3mZtFQ6EYq3bjrLZ1r2QzcKWTvbCxt2h+laL5oQtVpu
         tbKQFW6MJMaDG6D3A9xHUbcJKdCbyg+cnY/yvhyvAgy4it2o4t+43FeJEfVJqqHbHL
         cfCh72A5HGieTFCmUMzpAp4tC62b++Kmt6t8iW8Y0L/fx+ofLRsGYZuHBh2Znazu/I
         yGPwlYrgcwhlMmfPZiWcaJd7d/dnWQ9xguJ8RoDwGkgBzYGDDVTSbc4GzMF5VlJSHZ
         LcmV9V52uAaQINTDoFWqCvVPyE+TmNRZdfux0BZX39QCMgaYc1Yt3T95zqJSknlUzo
         NhRZONsim0+7g==
Date:   Thu, 22 Jun 2023 00:10:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress tmp files given extension
Message-ID: <ZJP0AaU/0ixqWPvv@google.com>
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
 <ZIjqKHDUmN6u9pXa@google.com>
 <a1a84df4-aa7a-d684-8694-fa8489baa9c2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a84df4-aa7a-d684-8694-fa8489baa9c2@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20, Chao Yu wrote:
> On 2023/6/14 6:14, Jaegeuk Kim wrote:
> > Let's compress tmp files for the given extension list.
> > 
> > This patch does not change the previous behavior, but allow the cases as below.
> > 
> > Extention example: "ext"
> > 
> > - abc.ext : allow
> > - abc.ext.abc : allow
> > - abc.extm : not allow
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > 
> >   Change log from v1:
> >    - refactor to allow abc.ext.dontcare only
> > 
> >   fs/f2fs/namei.c | 18 +++++++++++-------
> >   1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index 3e35eb7dbb8f..49573ef4115d 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -23,7 +23,7 @@
> >   #include <trace/events/f2fs.h>
> >   static inline bool is_extension_exist(const unsigned char *s, const char *sub,
> > -						bool tmp_ext)
> > +						bool tmp_ext, bool tmp_dot)
> >   {
> >   	size_t slen = strlen(s);
> >   	size_t sublen = strlen(sub);
> > @@ -49,8 +49,12 @@ static inline bool is_extension_exist(const unsigned char *s, const char *sub,
> >   	for (i = 1; i < slen - sublen; i++) {
> >   		if (s[i] != '.')
> >   			continue;
> > -		if (!strncasecmp(s + i + 1, sub, sublen))
> > -			return true;
> > +		if (!strncasecmp(s + i + 1, sub, sublen)) {
> > +			if (!tmp_dot)
> > +				return true;
> > +			if (i == slen - sublen - 1 || s[i + 1 + sublen] == '.')
> 
> Do you mean?
> 
> if (i == slen - sublen - 1 && s[i + 1 + sublen] == '.')

I don't think so.

> 
> > +				return true;
> > +		}
> >   	}
> >   	return false;
> > @@ -148,7 +152,7 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
> >   	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> >   	hot_count = sbi->raw_super->hot_ext_count;
> >   	for (i = cold_count; i < cold_count + hot_count; i++)
> > -		if (is_extension_exist(name, extlist[i], false))
> > +		if (is_extension_exist(name, extlist[i], false, false))
> 
> Parameters should be consistent w/ the one in set_file_temperature()?
> 
> if (is_extension_exist(name, extlist[i], true, false))
> 
> >   			break;
> >   	f2fs_up_read(&sbi->sb_lock);
> >   	if (i < (cold_count + hot_count))
> > @@ -156,12 +160,12 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
> >   	/* Don't compress unallowed extension. */
> >   	for (i = 0; i < noext_cnt; i++)
> > -		if (is_extension_exist(name, noext[i], false))
> > +		if (is_extension_exist(name, noext[i], false, false))
> 
> is_extension_exist(name, noext[i], true, true) ?
> 
> Thanks,
> 
> >   			return;
> >   	/* Compress wanting extension. */
> >   	for (i = 0; i < ext_cnt; i++) {
> > -		if (is_extension_exist(name, ext[i], false)) {
> > +		if (is_extension_exist(name, ext[i], true, true)) {
> >   			set_compress_context(inode);
> >   			return;
> >   		}
> > @@ -189,7 +193,7 @@ static void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
> >   	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
> >   	hot_count = sbi->raw_super->hot_ext_count;
> >   	for (i = 0; i < cold_count + hot_count; i++)
> > -		if (is_extension_exist(name, extlist[i], true))
> > +		if (is_extension_exist(name, extlist[i], true, false))
> >   			break;
> >   	f2fs_up_read(&sbi->sb_lock);
