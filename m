Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD161954A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiKDLUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKDLUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:20:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A8B63BD;
        Fri,  4 Nov 2022 04:20:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99D091F8C1;
        Fri,  4 Nov 2022 11:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667560805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ojXglajVUjAmF9vqdAfPpKnKySR+K9SEhcsPHN+wRk=;
        b=0pTouqEa6+fljMqVW6yC6LIoz90RgZrTRD89+sLZMF2ehO5763QK5tG6pcgz3Dr9CpzbSU
        LIEiBQVZPOSNfjAz68lQe1xs+mX6bFBtaU3ILuXwoKoeJ7a9bHJPxddUbBP7lKQuG5em89
        JPXd4ya1PBMOqtoE/4RlgM+XOeQYe30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667560805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ojXglajVUjAmF9vqdAfPpKnKySR+K9SEhcsPHN+wRk=;
        b=i0tl0oI5EySNE5VpisLt+v/UNy/TQJ3tnP43vYMeVF7TSAEMci8vdeqYdWZQ5D2jMi7I6D
        J7lTenphJks8zOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 167F613216;
        Fri,  4 Nov 2022 11:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fCV7AmX1ZGOZQQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 04 Nov 2022 11:20:05 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 2d89dcc5;
        Fri, 4 Nov 2022 11:21:05 +0000 (UTC)
Date:   Fri, 4 Nov 2022 11:21:05 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
Message-ID: <Y2T1ocj1xirSc2Lf@suse.de>
References: <20221103153619.11068-1-lhenriques@suse.de>
 <202211042241.mPJd6rKy-lkp@intel.com>
 <Y2TflzMdeiXRMoek@suse.de>
 <fc1fee1f-c6f0-9366-8759-f80b9ba532e7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc1fee1f-c6f0-9366-8759-f80b9ba532e7@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 06:02:55PM +0800, Chen, Rong A wrote:
> 
> 
> On 11/4/2022 5:47 PM, Luís Henriques wrote:
> > On Fri, Nov 04, 2022 at 02:40:25PM +0800, kernel test robot wrote:
> > > Hi Luís,
> > > 
> > > Thank you for the patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on ceph-client/for-linus]
> > > [also build test ERROR on linus/master v6.1-rc3 next-20221104]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Lu-s-Henriques/ceph-fix-memory-leak-in-mount-error-path-when-using-test_dummy_encryption/20221103-233629
> > > base:   https://github.com/ceph/ceph-client.git for-linus
> > 
> > Well, thank you very much!  Now, how do I tell this bot that this patch
> > isn't targeting this branch?
> 
> Hi Luis,
> 
> The below message may help:
> 
> >> [If your patch is applied to the wrong git tree, kindly drop us a note.
> >> And when submitting patch, we suggest to use '--base' as documented in
> >> https://git-scm.com/docs/git-format-patch#_base_tree_information]

Ah! Awesome, thank you very much for pointing me at this.  I'll try to
remember next time to use '--base' when sending patches for a specific
branch.

> we also appreciate that if developers can tell us the right branch
> to improve the bot when applied to wrong place.

Yeah, I guess that in general the bot is picking the right branch for
ceph.  In this case, the patch was for the fscrypt development branch, so
my mistake for not using '--base'.

Cheers,
--
Luís
