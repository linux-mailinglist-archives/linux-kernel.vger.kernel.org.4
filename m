Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095946C704E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCWSea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCWSeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6A25286;
        Thu, 23 Mar 2023 11:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 542F46285C;
        Thu, 23 Mar 2023 18:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AF6C433EF;
        Thu, 23 Mar 2023 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679596463;
        bh=cbM4eh9+G5u44urX8yb80DsKZlsjHhpGtzb4F/RXZbE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Dsesqpn+JLClFeqe0E866tT+jCL1VcXlGmYUpmMMflVF/ozl14+UP2rthdfxylFA7
         vHEbM3uSE+kVFVUR7oKf+/7gvb2Itn9BLFbeRLezNnQ1vRlhPr+K2IlpW2PWWjQToB
         17URw7s+voHD8pMOKgOkdmyWzjfjY5tYRyTqcOvXNMMdIwL40FCi7Wf99j877NeeOg
         5JJrHxHDHyPGr/6fbjQGpQsciSFsfbVH/aclta5RwwhTHaAKO+OFYwaiAHBwhcBb97
         XGSDxrgDZC8oPnZruijpapexEN6KkEJZ3CCkuy92/6+odUC97gd9+tkhCtv+8dJH1S
         buvShBL1GOoQA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 50BA01540398; Thu, 23 Mar 2023 11:34:23 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:34:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sachin Sant <sachinp@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [next-20230322] Kernel WARN at kernel/workqueue.c:3182
 (rcutorture)
Message-ID: <ae015179-03b5-4e4b-86dd-cbab75230c7f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <139BEB3F-BC1C-4ABA-8928-9A8EF3FB5EDD@linux.ibm.com>
 <fbb628c1-08bd-44ff-a613-794b134f6d46@paulmck-laptop>
 <233B28DA-70DD-4AD8-9C72-1FFCA6EFE56D@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <233B28DA-70DD-4AD8-9C72-1FFCA6EFE56D@linux.ibm.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:00:59PM +0530, Sachin Sant wrote:
> 
> >> [ 3629.243407] NIP [00007fff8cd39558] 0x7fff8cd39558
> >> [ 3629.243410] LR [000000010d800398] 0x10d800398
> >> [ 3629.243413] --- interrupt: c00
> >> [ 3629.243415] Code: 419dffa4 e93a0078 39400001 552907be 2f890000 7d20579e 0b090000 e95a0078 e91a0080 39200001 7fa85000 7d204f9e <0b090000> 7f23cb78 4bfffd65 0b030000 
> >> [ 3629.243430] ---[ end trace 0000000000000000 ]—
> >> 
> >> These warnings are repeated few times. The LTP test is marked as PASS.
> >> 
> >> Git bisect point to the following patch
> >> commit f46a5170e6e7d5f836f2199fe82cdb0b4363427f
> >>    srcu: Use static init for statically allocated in-module srcu_struct
> > 
> > Hello, Sachin, and it looks like you hit something that Zqiang and I
> > have been tracking down.  I am guessing that you were using modprobe
> > and rmmod to make this happen, and that this happened at rmmod time.
> > 
> Yes, the LTP test script rcu_torture.sh relies on modprobe to load/unload
> the rcutorture module.
> 
> > Whatever the reproducer, does the following patch help?
> 
> Thank you for the patch. Yes, with this patch applied, the test completes
> successfully without the reported warning.

Very good, thank you!  May we have your Tested-by?

							Thanx, Paul
