Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAC55BD2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiISQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiISQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:56:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C031EE0;
        Mon, 19 Sep 2022 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663606579; x=1695142579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PD0OEq48XmwGRGo7+KydN6K0YxBdtfJGSm7xD4mIbZs=;
  b=h54gujbRMIreZsT1CjWEVRZMiumtfTF0DOvpLTyogR/L0KuG8XkmNzsJ
   ykTOjw0mOxwVIJmPKjEOCE/fihjbXusuWXTa2sgCEsPFeHeHtuoPgvVlK
   G+04sJFhIB7TKJZUUmQZ0v4A4ilQ6vs5IWphpwM1A9qFYA2ULzfDV7zoG
   RbRqHBvxgQccic/DeOGT0ZNTUvoIkYYEzmb7WFeaqWEjlzJUVANzlPV0w
   oSYx4WllE+aQo3YHZ+OW+WAQyrh6p7g73yWrDKR74dcYP0zgbHf2vfteK
   t/CXF/w2Kd+wUbH3pgv8sYiZ4lk4Cu4EErRNSF6ErrDOi6FCccrkfhO2K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279185255"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="279185255"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:56:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="569724188"
Received: from smitavil-mobl.amr.corp.intel.com (HELO desk) ([10.209.120.248])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:56:18 -0700
Date:   Mon, 19 Sep 2022 09:56:17 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 0/3] Check enumeration before MSR save/restore
Message-ID: <20220919165617.mpt2llkeglc2254e@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <20220913005053.vk7qmhr6tqqynags@desk>
 <5097a283-6111-bedc-13c6-61a581f8b72c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5097a283-6111-bedc-13c6-61a581f8b72c@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 01:42:13PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/13/22 02:50, Pawan Gupta wrote:
> > On Mon, Sep 12, 2022 at 04:38:44PM -0700, Pawan Gupta wrote:
> >> Hi,
> >>
> >> This patchset is to fix the "unchecked MSR access error" [1] during S3
> >> resume. Patch 1/3 adds a feature bit for MSR_IA32_TSX_CTRL.
> >>
> >> Patch 2/3 adds a feature bit for MSR_AMD64_LS_CFG.
> >>
> >> Patch 3/3 adds check for feature bit before adding any speculation
> >> control MSR to the list of MSRs to save/restore.
> >>
> >> [1] https://lore.kernel.org/lkml/20220906201743.436091-1-hdegoede@redhat.com/
> > 
> > Added the correct email-id of Hans de Goede <hdegoede@redhat.com>.
> 
> I have tested this series and I can confirm that it fixes the exception
> which I was seeing on a Packard Bell Dot SC with an Atom N2600 CPU:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Thanks.
