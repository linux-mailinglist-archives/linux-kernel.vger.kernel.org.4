Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A987D6C7640
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCXDcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCXDco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21642941F;
        Thu, 23 Mar 2023 20:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CDA462900;
        Fri, 24 Mar 2023 03:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B290EC433D2;
        Fri, 24 Mar 2023 03:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679628760;
        bh=OWNJZwWiFmA/faeysy2IdxPG176Z+OxV6VgwG074rvg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q33hzY5m+3GuSibvZmQMaCIZwwYtDzluvrxoeOOmhNXKJwqqhOLD/DuvR+81TgpET
         /8iCipv7zn0/Nj9nB1sMQzynaEcjqTQ1ape/F+gSFEQRSEANqqQB/cnvybBs1Kp/AR
         Ynkfo5VzHw9O0bWcIzoK0Y7C3CJJLWqe71V0p00JV1xo8g8MR/lDQ6DQs5SpWWJmmG
         Vtw13t61n2W60NJHyKHagXDSeRWJTqOwfSNv4VlsLEsYeo/srrBBP+jWXdhctgob81
         X2XUw2lxo6v710sRKom16BQQGt0ykawwI83iyZ2Yf2BOZX7w4847hYZ/AY9l5Lf9qg
         3AUIbRng0LLpw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 673B81540379; Thu, 23 Mar 2023 20:32:40 -0700 (PDT)
Date:   Thu, 23 Mar 2023 20:32:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sachin Sant <sachinp@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [next-20230322] Kernel WARN at kernel/workqueue.c:3182
 (rcutorture)
Message-ID: <bed6b499-76cc-4412-8a4d-c71f03276726@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <139BEB3F-BC1C-4ABA-8928-9A8EF3FB5EDD@linux.ibm.com>
 <fbb628c1-08bd-44ff-a613-794b134f6d46@paulmck-laptop>
 <233B28DA-70DD-4AD8-9C72-1FFCA6EFE56D@linux.ibm.com>
 <ae015179-03b5-4e4b-86dd-cbab75230c7f@paulmck-laptop>
 <23F7ADE0-0B96-4257-8910-6B678E0F0C7A@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23F7ADE0-0B96-4257-8910-6B678E0F0C7A@linux.ibm.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:47:38AM +0530, Sachin Sant wrote:
> 
> >>> Hello, Sachin, and it looks like you hit something that Zqiang and I
> >>> have been tracking down.  I am guessing that you were using modprobe
> >>> and rmmod to make this happen, and that this happened at rmmod time.
> >>> 
> >> Yes, the LTP test script rcu_torture.sh relies on modprobe to load/unload
> >> the rcutorture module.
> >> 
> >>> Whatever the reproducer, does the following patch help?
> >> 
> >> Thank you for the patch. Yes, with this patch applied, the test completes
> >> successfully without the reported warning.
> > 
> > Very good, thank you!  May we have your Tested-by?
> 
> Tested-by: Sachin Sant <sachinp@linux.ibm.com>


Thank you, and I will apply on the next rebase.

							Thanx, Paul
