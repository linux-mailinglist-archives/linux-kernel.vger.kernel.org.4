Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66F76FBF6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjEIGlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjEIGl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:41:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3115DAD35;
        Mon,  8 May 2023 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683614471; x=1715150471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9PGhDpF0Ehm92gwScDb0cpgrpvmpX0MTZeTBVtGjmEI=;
  b=G/dD+U3iatmwcqSIvgNJsyrdH3S0SmZDRJMPfy1J7b2qT0jWotFwztXK
   PQuJaWzUgu6InMrsaOjlGWY0+Wui/oWDl3DRQM1JWlIUpPsO5yoG7HSSI
   bR7g+8GUhKu6Mvmuz5gnv2LV5A6BUgQWhAlH6ujxxsZZ9y5GjNtdYB5OX
   6ZmZVTAId8K8hKRcC1CzfTvFCiVnZR44zMGmHF5yXeVo1WfNmeR8hAN4m
   4hempkVw14XWXIhbNVgDMbKmpt4pvNya7MzxVB7m6vCPMKCzyj155fGWv
   JGfGoFWDVNU/bJ+QMserEVxOuaGKW4RK1eJlqV1Aw4LSPrgIS2mmzW0Rc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="329443412"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="329443412"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 23:41:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="873049819"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="873049819"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2023 23:41:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7EE9923E; Tue,  9 May 2023 09:41:16 +0300 (EEST)
Date:   Tue, 9 May 2023 09:41:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        S Sanath <Sanath.S@amd.com>, richard.gong@amd.com,
        Sanju.Mehta@amd.com, Takashi Iwai <tiwai@suse.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] thunderbolt: Clear registers properly when auto
 clear isn't in use
Message-ID: <20230509064116.GM66750@black.fi.intel.com>
References: <20230424195556.2233-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230424195556.2233-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Mon, Apr 24, 2023 at 02:55:54PM -0500, Mario Limonciello wrote:
> When `QUIRK_AUTO_CLEAR_INT` isn't set, interrupt masking should be
> cleared by writing to Interrupt Mask Clear (IMR) and interrupt
> status should be cleared properly at shutdown/init.
> 
> This fixes an error where interrupts are left enabled during resume
> from hibernation with `CONFIG_USB4=y`.
> 
> Fixes: 468c49f44759 ("thunderbolt: Disable interrupt auto clear for rings")
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217343
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to fixes, thanks!
