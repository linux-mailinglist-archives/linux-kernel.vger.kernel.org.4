Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C62A602EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJROg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJROg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:36:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AF75005E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666103815; x=1697639815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Bqav2BDnAtf8+Q98IkmhOo2U/v1rrxodN0obeyfe0U=;
  b=SuT+kama9eDohCyXLRg4IJ7h2ZJB9d85BN1gti0PExK/t4v+0dv4LFJw
   up7icqA9C0m0DQj7yxyXVSwjqqsCIYczzeZGb7o0qiS6zLJlv+8OZMeFJ
   XBdFZeImUsJBFo0kUsGC3XlqYsKqVu+5TOQlCMM49gEJ6IuNrFgaJLQgT
   mgPfWdg2M23fIJpP2yqNPQ8kyzwXR5ojCoX27Uqm4n2S1UgZDCrl9pynn
   DAYSdrNLSYahn3qTVjhzfQJqmEH1pdW1S+gIwtcTpn9UZ2Zbe990WvUQd
   xWprfmTZ2WMlEw8MB7EALfEcrVDmkFjZmNP2iWq9kYWUQGM6tyyPGwMLF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="304858208"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="304858208"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 07:36:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="659816477"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="659816477"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 07:36:54 -0700
Date:   Tue, 18 Oct 2022 07:36:53 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RAS: Fix the trace_show() function to output
 trace_count
Message-ID: <Y066BV4jiRMxgjYV@agluck-desk3.sc.intel.com>
References: <Yz3KI5qY70rvJV63@zn.tnic>
 <20221005194644.311204-1-tony.luck@intel.com>
 <Y00wIFEN9h9YPGe1@zn.tnic>
 <SJ1PR11MB60835DDCB1F3EBC8B6DFA2F7FC299@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y02vmRn1Uz6/NMFF@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02vmRn1Uz6/NMFF@zn.tnic>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 09:40:09PM +0200, Borislav Petkov wrote:
> Question is, what is your goal with this?

I ran into it while fixing:

  https://lore.kernel.org/all/20221006163258.318916-1-tony.luck@intel.com/

when I just used "cat daemon_active" to check status and was confused
by the lack of any output. Looked at the code and saw the silly

	return atomic_read(&trace_count);

which does nothing useful.

Maybe if there isn't a reasonable thing to output, that could be
changed to:

static int trace_show(struct seq_file *m, void *v)
{
	/*
	 * User should use "lsof daemon_active" if they want to 
	 * know if there is a process consuming trace error records
	 */
	return 0;
}

Sadly, we need to have a trace_show() function. If trace_open() just
does:

	return single_open(file, NULL, NULL);

then we get a deref NULL OOPs if somebody does "cat daemon_active" :-(

-Tony
