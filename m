Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95B05B2EBF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIIGW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIIGWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:22:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F889123EEA;
        Thu,  8 Sep 2022 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662704570; x=1694240570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ge6oNL64EH6DJvUJEasK+o1/wuEDfP9x78sReGaAu/A=;
  b=NKzqofGhXXDVRROd2KbgYqde+6VgvXydsb+7JgkLCcLat2v3nDnnnezc
   wilJYgLn4FGwgeOyx73FHVAwMamum4VCsk21x1QWsIjlz2IkPUdTPc/U5
   5HEEQQMSWYMfYYjlYjiRdTHjQr1xJFW8gonBfyYw1ILPI4LJGenSA31OO
   sttxh6gO5U99lk9l8A0N3EOugXA0oaI3+UXDgpcKYcECs5B0Ey/SgIEkx
   qqeLRJt/my+wxsj2O5pgpWZpXpTpblhoklV/88ZiqlsUbq+qdvAFsPC0X
   c64HXLcU1TIFePBNYhia4y2pAjZElMpyptw6tNZIEZR9F+EV23ML6yKSp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="294989121"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="294989121"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 23:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="757494786"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Sep 2022 23:22:46 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 09 Sep 2022 09:22:45 +0300
Date:   Fri, 9 Sep 2022 09:22:45 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bastian Rieck <bastian@rieck.me>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        grzegorz.alibozek@gmail.com, andrew.co@free.fr, meven29@gmail.com,
        pchernik@gmail.com, jorge.cep.mart@gmail.com,
        danielmorgan@disroot.org, bernie@codewiz.org,
        saipavanchitta1998@gmail.com, rubin@starset.net,
        maniette@gmail.com, nate@kde.org
Subject: Re: [RFC PATCH 0/2] usb: typec: ucsi: Check connection on resume
Message-ID: <YxrbtWDR7XI4s+Q+@kuha.fi.intel.com>
References: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
 <27257661.hdJqBvvX10@nimue>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27257661.hdJqBvvX10@nimue>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 07:01:34AM +0200, Bastian Rieck wrote:
> Dear Heikki,
> 
> > I'm sending these as an RFC first because I'm not done testing.
> > 
> > I made a small modification to my original proposal (in the bug
> > report). Now also connection during suspend should be covered.
> > 
> > I would appreciate if you guys could test these again. If
> > everything works, and the bug is fixed, let me know, and I'll add
> > your Tested-by tags to the patches.
> >
> 
> Thanks so much for these changes—that's awesome! I have just finished 
> testing this against 5.19.7 (Arch Linux) with a Lenovo X1 (Gen 9).
> 
> I am very happy to see that, as far as I can tell, the issue 
> disappeared completely!
> 
> However, I am receiving additional warnings via `journalctl` that I 
> did not receive before; I have attached this trace as an additional 
> log file. Nothing in there seems critical and I can confirm that the 
> system continues to operate normally. I merely wanted to provide you 
> with this additional information in case it is of relevance.
> 
> Please let me know if there's anything else I can do here; I really 
> appreciate the time you spent on this!

Thank you for the report. That warning certainly needs to be sorted
out before I send the final versions. I'll try to reproduce that.

thanks,

-- 
heikki
