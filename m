Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDF6193CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiKDJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKDJqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:46:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034B65D8;
        Fri,  4 Nov 2022 02:46:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB05C218A8;
        Fri,  4 Nov 2022 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667555162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9T3oPWTPozZGfEXCs6Cda1f91UWaPZeHRXFFaFekaP0=;
        b=I6wmwQbaDjeTv3pqNt8Z+6j3dBXdvw7GRjOqQebI5BBcTnn6wV4PQz+8W89nZGR70pCEmW
        eNft6JauQdLR2NiJ51yDopp0nmVDzM+OhA2/GOaZ6g5jt22P6A6eq8vxCSRMPdYnOAtRD5
        dFqIwmlWDh+SjPj215x6HX07TT26K/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667555162;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9T3oPWTPozZGfEXCs6Cda1f91UWaPZeHRXFFaFekaP0=;
        b=siJHrYovP5jbdGgd8LD5TTfLg9ZGb9vAo2GPaU+85u1S5yyVUerIuBGZKmN4r3H46P06Mc
        aEmbdjUS9LiJdkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4847D1346F;
        Fri,  4 Nov 2022 09:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CMOlDlrfZGN1DQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 04 Nov 2022 09:46:02 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 81a255f3;
        Fri, 4 Nov 2022 09:47:03 +0000 (UTC)
Date:   Fri, 4 Nov 2022 09:47:03 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
Message-ID: <Y2TflzMdeiXRMoek@suse.de>
References: <20221103153619.11068-1-lhenriques@suse.de>
 <202211042241.mPJd6rKy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202211042241.mPJd6rKy-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 02:40:25PM +0800, kernel test robot wrote:
> Hi Luís,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on ceph-client/for-linus]
> [also build test ERROR on linus/master v6.1-rc3 next-20221104]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Lu-s-Henriques/ceph-fix-memory-leak-in-mount-error-path-when-using-test_dummy_encryption/20221103-233629
> base:   https://github.com/ceph/ceph-client.git for-linus

Well, thank you very much!  Now, how do I tell this bot that this patch
isn't targeting this branch?

Cheers,
--
Luís
