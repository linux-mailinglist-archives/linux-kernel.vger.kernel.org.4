Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22156F6958
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjEDK4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjEDK43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7DD4C01
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC51363339
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E69C433EF;
        Thu,  4 May 2023 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683197788;
        bh=3yKhho676EF8oPdjbHSNewOD8TBg0hH41OZIEZB8Y30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqjCk3mGr5UGAHp2nNIXU3WAW2pErQwVqOC6xuQ7TuDBmq4mBlAINChZc7o//Ox4n
         eXO0FzGZFhmKX/f5li2U+3qwWXFBo1uZa2wDRa1s4DpiqxW1pk2yQoj3fK5oWiepZ1
         E7UJ/EDJId7PCckF2Duo6x7tGROtzwvDUkv+BlQc3H2va62o+VG073lXajXrtPVuCC
         id/Rg03eaYQ3v9TewiOPEPM0woxKajQCR7KI07ifS4LapoWkuqUeGTaAooaR7NEUcG
         GmSt4OcM9pMd6WmGW9iHGnQsZBeubdnBmiQkFABXbu5NiDXK8tlGllgwq4OfNROCDd
         1UdegeW9Ifl2Q==
Date:   Thu, 4 May 2023 12:56:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Danila Chernetsov <listdansp@mail.ru>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Linux Memory Management <linux-mm@kvack.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: ntfs orphan? (was Re: [PATCH] ntfs: do not dereference a null
 ctx on error)
Message-ID: <20230504-inszenieren-aufarbeiten-d6de02242119@brauner>
References: <20230407194433.25659-1-listdansp@mail.ru>
 <ZFHgAhisxjKQxhLx@debian.me>
 <20230503140609.e65bdc2b0e55ba6f49bbb620@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503140609.e65bdc2b0e55ba6f49bbb620@linux-foundation.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 02:06:09PM -0700, Andrew Morton wrote:
> On Wed, 3 May 2023 11:16:02 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
> > On Fri, Apr 07, 2023 at 07:44:33PM +0000, Danila Chernetsov wrote:
> > > In ntfs_mft_data_extend_allocation_nolock(), if an error condition occurs
> > > prior to 'ctx' being set to a non-NULL value, avoid dereferencing the NULL
> > > 'ctx' pointer in error handling.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Duplicate of 10-years-old outstanding patch at [1].
> 
> Well, the patches are actually quite different.  Is Danila's longer one
> better?
> 
> > I'm not speaking of the patch itself but rather on unfortunate state
> > of ntfs subsystem. It seems like the maintainer is MIA (has not
> > responding to patch submissions for a long time). Some trivial
> > patches, however, are merged through mm tree.
> > 
> > Konstantin (from newer ntfs3 subsystem), Andrew, would you like to take a
> > look on this orphaned subsystem (and help reviewing)? I'd like to send
> > MAINTAINERS update if it turns out to be the case.
> > 
> 
> Sure, I can join linux-ntfs-dev@lists.sourceforge.net and hendle things
> which come along.
> 
> Or Christian may want to do that?

Thanks for asking. I would be able to pick up those patches into
fs.misc. I got an off-list ping about someone also wanting to help
with review apparently.
