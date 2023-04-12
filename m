Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6256C6DEB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDLGPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDLGO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:14:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B940F2;
        Tue, 11 Apr 2023 23:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5366362E5E;
        Wed, 12 Apr 2023 06:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DEBC433EF;
        Wed, 12 Apr 2023 06:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681280089;
        bh=Nxag8wK1torwvwcelmJg4s5Xft+8uu3sHSeDBkA6DIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0C6JC868/IbrDNImk0zmIaQYLikuOeSr4okyyqgL6WyPuWoITU2J28J+4gTwO+SY
         jFrJtF+QfNU/XlnmM4Nhdsz4nmpnkBZ/+pLXtdK70Z+gdKrDmYTCVTx0pkbmgg884h
         k5jrVjHTZLUx8nxkSGxiaQnavKN3Whh5Zk7hTVZ8=
Date:   Wed, 12 Apr 2023 08:14:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Message-ID: <2023041209-armed-overlaid-3d3d@gregkh>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <2023041015-lunar-dandelion-1b4e@gregkh>
 <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
 <2023041136-donator-faceplate-5f91@gregkh>
 <bcdcee9b-f213-bc3c-d300-92a1e0138187@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcdcee9b-f213-bc3c-d300-92a1e0138187@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 11:36:48AM -0700, John Moon wrote:
> > > 
> > > Others do not seem to be intentional:
> > > 
> > >   Addition/use of flex arrays:
> > >     - include/uapi/linux/rseq.h (f7b01bb0b57f)
> > >     - include/uapi/scsi/scsi_bsg_mpi3mr.h (c6f2e6b6eaaf)
> > 
> > That is not a breakage, that's a tool problem.
> > 
> > >   Type change:
> > >     - include/uapi/scsi/scsi_bsg_ufs.h (3f5145a615238)
> > 
> > Again, not a real breakage, size is still the same.
> > 
> 
> Would you find the tool more useful if it simply filtered out all instances
> where the size of the type did not change? This would filter out the
> following which the tool currently flags:
> 
> - enum expansions
> - reserved field expansions
> - expansions of a struct with a flex array at the end
> - type changes
> - re-ordering of existing members
> - ...others?

Obviously not, as some of those are real breakages, and some are not at
all.

Please understand what is an abi breakage.  Adding new enums is not.
Using a reserved field is not.  Reording existing members IS.

> These changes aren't _always_ safe, but if you assume the kernel developer
> is doing something reasonable, then maybe it's okay. Maybe we could hide
> these checks behind something like a "--pedantic" flag?

Again, no, that list above has totally different things in it, some are
completly safe, others totally break the abi.  Do NOT lump them all
together as that is wrong.

thanks,

greg k-h
