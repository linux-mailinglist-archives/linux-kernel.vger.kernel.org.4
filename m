Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A416EF2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbjDZLAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDZLAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:00:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA4BF;
        Wed, 26 Apr 2023 04:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682506836; x=1714042836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G95PT19yFXrzWRVnbAntY6KRml0hHubfjUN5KoCVDjk=;
  b=E5VQMjTh//rCxghwZqe7qD9BEbE84dtQDEXtgtcPCxoPNVuv03KYNBzY
   grftcIqwWqlUdmGN90Pua+M0taPQvtgU9HKjMdJXctsuMVDUdSmiNDoQh
   Zgd496VWoJ1TbynHQy08fWh9azQeFEgCHDw7JauxDvncS8REpMT4v9mcx
   /ocC+l1Wna/paaA3hwaCKrx2qr5vHv+ANCWWjAonVYeR4EVU5QV4fk2wn
   4qg364RKPDlqUEy53G2T777OSPr+HxoaBAJKPW1gVURRR/9aIgP35+lzj
   2M4h9SsAArMW9lMuT05Sd4XVE/wQoKIpfqzwKKwuterx6BaQeI/8yTF79
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="345826522"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="345826522"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 04:00:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="837879261"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="837879261"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2023 04:00:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5C2D24B9; Wed, 26 Apr 2023 14:00:40 +0300 (EEST)
Date:   Wed, 26 Apr 2023 14:00:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        S Sanath <Sanath.S@amd.com>, richard.gong@amd.com,
        Sanju.Mehta@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] thunderbolt: Move Intel quirks into quirks.c
Message-ID: <20230426110040.GA66750@black.fi.intel.com>
References: <20230424195556.2233-1-mario.limonciello@amd.com>
 <20230424195556.2233-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230424195556.2233-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 24, 2023 at 02:55:55PM -0500, Mario Limonciello wrote:
> There are two Intel specific quirks for auto clear and end to end
> that are not specified in the quirks file.  Move them to this location
> instead.

quirks.c is for USB4 domain quirks (router, retimer, anything actually
connected to the USB4 domain).

nhi.c is the correct place for host interface quirks for now.
