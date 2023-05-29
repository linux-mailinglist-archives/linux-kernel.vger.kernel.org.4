Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAFF714D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjE2PhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjE2PhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:37:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB292EA;
        Mon, 29 May 2023 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685374609; x=1716910609;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VQv0RWKaL/bDuM/gG1UETZpVFJ8xhXtm31909sHt8wA=;
  b=A93tXsq+tqZ9jwzt2ntfIsAPwLq32Rf4R0q1yVM95c2R8Uij48qyCTnM
   gf9gQVq6TPXaLa50mhkghCJ2wDnIaMyRn3eW6wab909gnpufRqzxbZbGV
   IAVNZMkYA5toS7A4yLCln8Vtx6eqBswOWTOgHcPukAEEnAv5VmknMkfiQ
   d+dmz1UCFUjZmUBqj/crIvDF/K3CtzG37jRJzJy4XhTx2yfYyz1L7TbZ1
   NZRS57+4jIKsmx4Qlk5tV3NTM2JW1BfpLDadVQpmds/JM5FOvJe2x+NTW
   8KcFtc8Tjsiq2iReS6TLMj44ionIGRtL2DigKod3jjUCr+SGjmRDQKSkQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="354744235"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="354744235"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 08:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="775984272"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="775984272"
Received: from btaubert-mobl1.ger.corp.intel.com ([10.252.55.237])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 08:36:46 -0700
Date:   Mon, 29 May 2023 18:36:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] platform/x86: think-lmi: Enable opcode support
 on BIOS settings
In-Reply-To: <90de5786-085c-4cff-8125-215c9ae20ad1@app.fastmail.com>
Message-ID: <93f28f8b-67d4-496b-577d-12c106fe435@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20230526171658.3886-1-mpearson-lenovo@squebb.ca> <0e11913-ba27-e3a-fafe-bd5e48db8b6b@linux.intel.com> <90de5786-085c-4cff-8125-215c9ae20ad1@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-711971292-1685374608=:2737"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-711971292-1685374608=:2737
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 29 May 2023, Mark Pearson wrote:
> On Mon, May 29, 2023, at 7:51 AM, Ilpo Järvinen wrote:
> > On Fri, 26 May 2023, Mark Pearson wrote:
> >
> >> Whilst reviewing some documentation from the FW team on using WMI on
> >> Lenovo system I noticed that we weren't using Opcode support when
> >> changing BIOS settings in the thinkLMI driver.
> >> 
> >> We should be doing this to ensure we're future proof as the old
> >> non-opcode mechanism has been deprecated.
> >> 
> >> Tested on X1 Carbon G10 and G11.
> >> 
> >> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> ---
> >> Changes in v2: Update comment for clearer explanation of what the driver
> >> is doing
> >> Changes in v3: None. Version bump with rest of series
> >> 
> >>  drivers/platform/x86/think-lmi.c | 28 +++++++++++++++++++++++++++-
> >>  1 file changed, 27 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> >> index 1138f770149d..2745224f62ab 100644
> >> --- a/drivers/platform/x86/think-lmi.c
> >> +++ b/drivers/platform/x86/think-lmi.c
> >> @@ -1001,7 +1001,33 @@ static ssize_t current_value_store(struct kobject *kobj,
> >>  				tlmi_priv.pwd_admin->save_signature);
> >>  		if (ret)
> >>  			goto out;
> >> -	} else { /* Non certiifcate based authentication */
> >> +	} else if (tlmi_priv.opcode_support) {
> >> +		/*
> >> +		 * If opcode support is present use that interface.
> >> +		 * Note - this sets the variable and then the password as separate
> >> +		 * WMI calls. Function tlmi_save_bios_settings will error if the
> >> +		 * password is incorrect.
> >> +		 */
> >> +		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
> >> +					new_setting);
> >
> > Alignment.
> 
> OK - I assume you want the new_setting lined up under the bracket.
> I've not seen that called out as a requirement (https://www.kernel.org/doc/html/v4.10/process/coding-style.html) but I don't mind fixing....but if you can point me at the specifics it's appreciated

Yes, I meant aligning to the column following the opening parenthesis.

I guess it's not a hard requirement, however, there's a benefit from 
certain things aligning because it helps in the brains in the process of 
converting text into structure with less effort (when not specifically not 
focusing on that particular line).

> >> +		if (!set_str) {
> >> +			ret = -ENOMEM;
> >> +			goto out;
> >> +		}
> >> +
> >> +		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
> >> +		if (ret)
> >> +			goto out;
> >> +
> >> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> >> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> >> +					tlmi_priv.pwd_admin->password);
> >
> > Align.
> 
> Ack.
> 
> >
> >> +			if (ret)
> >> +				goto out;
> >> +		}
> >> +
> >> +		ret = tlmi_save_bios_settings("");
> >> +	} else { /* old non opcode based authentication method (deprecated)*/
> >
> > non missing hyphen.
> 
> non-opcode I assume?

I think the most proper English would be non-opcode-based since "opcode 
based" belong together (but I'm not a native speaker here).

-- 
 i.

--8323329-711971292-1685374608=:2737--
