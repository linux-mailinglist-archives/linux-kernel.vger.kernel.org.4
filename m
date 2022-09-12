Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E4C5B5D62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiILPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiILPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:39:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D0A6397
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27C29B80DB9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3513C433C1;
        Mon, 12 Sep 2022 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662997179;
        bh=MOdzIQtvwZrIZeYWgAorj/0pcEr85t2z2V/ng6h3GaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzQ4GL23rZMxIiI2gcwNbRbd8TvZRoW1fHAwN/x4hHh127TrVyb5+RssRnmHnwBpG
         MmpeAOpBWaBK0YhOmVELUzWgEztt13h6zaBzvEGquyKEUHO7PTk7dRI1/J2nQi+1dP
         sHANhxec5hrC9+XYAQPdEnwUtQoVHLPkC2kEGsJSXna3i3TxMlD8Z4/jEncU8BLyHn
         2i2CX+okl7DKNkR7HqiXphjPsAUDTjPTzc8m2D0xwnPODkZhm/I0Soui+xqgHy888f
         q6yrjozRZ9Fj9KKnewiYADQGgaJboafdNDDq5kw5+2aAkt2k+Rs+rl1IWK9/vBiF2e
         5S8vMTZRCGT3g==
Date:   Mon, 12 Sep 2022 08:39:38 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: Re: [PATCH v2] f2fs: fix to disallow getting inner inode via
 f2fs_iget()
Message-ID: <Yx9SulcDlMfO/hiW@google.com>
References: <20220830225358.300027-1-chao@kernel.org>
 <YxlNGeh6Sr4isEFf@google.com>
 <0af788ed-8797-22a2-ae0c-433fdd6a2188@kernel.org>
 <YxlRMRA7AVIusfav@google.com>
 <e5abac5f-433b-62d4-b2fa-974b5f978d61@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5abac5f-433b-62d4-b2fa-974b5f978d61@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08, Chao Yu wrote:
> On 2022/9/8 10:19, Jaegeuk Kim wrote:
> > On 09/08, Chao Yu wrote:
> > > On 2022/9/8 10:02, Jaegeuk Kim wrote:
> > > > On 08/31, Chao Yu wrote:
> > > > > From: Chao Yu <chao.yu@oppo.com>
> > > > > 
> > > > > Introduce f2fs_iget_inner() for f2fs_fill_super() to get inner inode:
> > > > > meta inode, node inode or compressed inode, and add f2fs_check_nid_range()
> > > > > in f2fs_iget() to avoid getting inner inode from external interfaces.
> > > > 
> > > > So, we don't want to check the range of inner inode numbers? What'd be the
> > > > way to check it's okay?
> > > 
> > > For node_ino, meta_ino, root_ino, we have checked them in sanity_check_raw_super()
> > > as below:
> > > 
> > > 	/* check reserved ino info */
> > > 	if (le32_to_cpu(raw_super->node_ino) != 1 ||
> > > 		le32_to_cpu(raw_super->meta_ino) != 2 ||
> > > 		le32_to_cpu(raw_super->root_ino) != 3) {
> > > 		f2fs_info(sbi, "Invalid Fs Meta Ino: node(%u) meta(%u) root(%u)",
> > > 			  le32_to_cpu(raw_super->node_ino),
> > > 			  le32_to_cpu(raw_super->meta_ino),
> > > 			  le32_to_cpu(raw_super->root_ino));
> > > 		return -EFSCORRUPTED;
> > > 	}
> > > 
> > > compressed_ino should always be NM_I(sbi)->max_nid, it can be checked in
> > > f2fs_init_compress_inode()?
> > 
> > Hmm, I'm not sure whether we really need this patch, since it'd look better
> > to handle all the iget with single f2fs_iget?
> 
> Well, the main concern is previously f2fs_iget() won't check validation for inner
> inode due to it will skip do_read_inode() - f2fs_check_nid_range(), so that in a
> fuzzed image, caller may pass inner ino into f2fs_iget(), result in incorrect use
> of inner inode. So I add f2fs_check_nid_range() in prior to f2fs_iget_inner() in
> f2fs_iget() as below to detect and avoid this case.

FWIW, sanity_check_raw_super() checked the inode numbers.

> 
> > > > > +struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = f2fs_check_nid_range(F2FS_SB(sb), ino);
> > > > > +	if (ret)
> > > > > +		return ERR_PTR(ret);
> > > > > +
> > > > > +	return f2fs_iget_inner(sb, ino);
