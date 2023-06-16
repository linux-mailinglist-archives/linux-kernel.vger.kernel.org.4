Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24C8733644
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjFPQjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFPQjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:39:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE752D48;
        Fri, 16 Jun 2023 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686933580; x=1718469580;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ksvNxfLF9nc4Gxz9YoJmx4LwenYmKnMcgqFDHXrwp0=;
  b=V43zJ2tJoUJ/kYYN1LPzy0JhGMOBUB3YP1vRGqiYSidBDeW7b945xTf5
   rNucFYRbOO27MkCpvGKFdVCAiOEQaBx6NxAw0Yti8XRhxKh/s+wMrtmtn
   8zY6WEIsTxPUgQvuzDetmBW8UaKzJ/N7LflIO7p3hKow98PW1x4eLZ0O8
   83Ds5o1Uww72FxYqH01lV/vB5v2TE7WTN4flp4rUCci985VTKzpn8ST+W
   tU/6KN/7w7si0HHkCdwacM7cOkV3bfgZ6ncMBfkvIqhadpiEFnTqL+FrJ
   pHrmRO4UlW2/k6AN28x2rPvv1Yogg/KYlHm5+fsbQcqnp9TRafJrwGt/j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="339589389"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="339589389"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="716083284"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="716083284"
Received: from jbonds-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.56.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:39:40 -0700
Message-ID: <af450786e98c8517da341d1334431c4f67911f9a.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86/intel/tpmi: Read feature control status
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri, 16 Jun 2023 09:39:39 -0700
In-Reply-To: <f7a0db17-dfe6-f8e0-4aed-6a198fde6dea@linux.intel.com>
References: <20230615193302.2507338-1-srinivas.pandruvada@linux.intel.com>
         <20230615193302.2507338-2-srinivas.pandruvada@linux.intel.com>
         <f7a0db17-dfe6-f8e0-4aed-6a198fde6dea@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-16 at 10:13 +0300, Ilpo Järvinen wrote:
> On Thu, 15 Jun 2023, Srinivas Pandruvada wrote:
> 
> > 

[...]

> > +       /* set command id to 0x10 for TPMI_GET_STATE */
> > +       data = TPMI_GET_STATE_CMD;
> > +       /* 32 bits for DATA offset and +8 for feature_id field */
> > +       data |= ((u64)feature_id << (TPMI_CMD_DATA_OFFSET +
> > TPMI_GET_STATE_CMD_DATA_OFFSET));
> 
> This looks like you should add the GENMASK_ULL() for the fields and
> use 
> FIELD_PREP() instead of adding all those OFFSET defines + custom
> shifting.

You mean, I should change one shift instruction, to FIELD_PREP()
which will use three instructions to shift, sub and AND?
((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);

> 
> > +
> > +       /* Write at command offset for qword access */
> > +       writeq(data, tpmi_info->tpmi_control_mem +
> > TPMI_COMMAND_OFFSET);
> > +
> > +       ret = tpmi_wait_for_owner(tpmi_info, TPMI_OWNER_IN_BAND);
> > +       if (ret)
> > +               goto err_unlock;
> > +
> > +       /* Set Run Busy and packet length of 2 dwords */
> > +       writeq(BIT_ULL(TPMI_CONTROL_RB_BIT) | (TPMI_CMD_PKT_LEN <<
> > TPMI_CMD_PKT_LEN_OFFSET),
> 
> Define using BIT_ULL(0) instead. Use FIELD_PREP().


This code will run only on X86 64 bit, not a common device driver which
will run in any architecture.
Please let me know why FIELD_PREP() is better.


> 
> I'd drop _BIT from the define name but I leave it up to you, it just 
> makes your lines longer w/o much added value.
> 
> > +              tpmi_info->tpmi_control_mem +
> > TPMI_CONTROL_STATUS_OFFSET);
> > +
> > +       ret = read_poll_timeout(readq, control, !(control &
> > BIT_ULL(TPMI_CONTROL_RB_BIT)),
> > +                               TPMI_RB_TIMEOUT_US,
> > TPMI_RB_TIMEOUT_MAX_US, false,
> > +                               tpmi_info->tpmi_control_mem +
> > TPMI_CONTROL_STATUS_OFFSET);
> > +       if (ret)
> > +               goto done_proc;
> > +
> > +       control = FIELD_GET(TPMI_GENMASK_STATUS, control);
> > +       if (control != TPMI_CMD_STATUS_SUCCESS) {
> > +               ret = -EBUSY;
> > +               goto done_proc;
> > +       }
> > +
> > +       data = readq(tpmi_info->tpmi_control_mem +
> > TPMI_COMMAND_OFFSET);
> > +       data >>= TPMI_CMD_DATA_OFFSET; /* Upper 32 bits are for
> > TPMI_DATA */
> 
> Define the field with GENMASK() and use FIELD_GET().
> 
Again 3 instructions instead of 1.

> > +
> > +       *disabled = 0;
> > +       *locked = 0;
> > +
> > +       if (!(data & BIT_ULL(TPMI_GET_STATUS_BIT_ENABLE)))
> 
> Put BIT_ULL() into the define.
Good idea.

> 
> Perhaps drop _BIT_ from the name.
I can do that.

> 
> > +               *disabled = 1;
> > +
> > +       if (data & BIT_ULL(TPMI_GET_STATUS_BIT_LOCKED))
> 
> Ditto.
> 
> > +               *locked = 1;
> > +
> > +       ret = 0;
> > +
> > +done_proc:
> > +       /* SET CPL "completion"bit */
> 
> Missing space.
> 
OK

> > +       writeq(BIT_ULL(TPMI_CONTROL_CPL_BIT),
> 
> BIT_ULL() to define.
> 
> > +              tpmi_info->tpmi_control_mem +
> > TPMI_CONTROL_STATUS_OFFSET);
> > +
> > +err_unlock:
> > +       mutex_unlock(&tpmi_dev_lock);
> > +
> > +       return ret;
> > +}
> > +
> > +int tpmi_get_feature_status(struct auxiliary_device *auxdev, int
> > feature_id,
> > +                           int *locked, int *disabled)
> > +{
> > +       struct intel_vsec_device *intel_vsec_dev =
> > dev_to_ivdev(auxdev->dev.parent);
> > +       struct intel_tpmi_info *tpmi_info =
> > auxiliary_get_drvdata(&intel_vsec_dev->auxdev);
> > +
> > +       return tpmi_read_feature_status(tpmi_info, feature_id,
> > locked, disabled);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(tpmi_get_feature_status, INTEL_TPMI);
> > +
> > +static void tpmi_set_control_base(struct auxiliary_device *auxdev,
> > +                                 struct intel_tpmi_info
> > *tpmi_info,
> > +                                 struct intel_tpmi_pm_feature
> > *pfs)
> > +{
> > +       void __iomem *mem;
> > +       u16 size;
> > +
> > +       size = pfs->pfs_header.num_entries * pfs-
> > >pfs_header.entry_size * 4;
> 
> Can this overflow u16? Where does pfs_header content originate from?
We can add a check, but this is coming from a trusted and validated x86
core (Not an add on IP), which not only driver uses but all PM IP in
the hardware.

Thanks,
Srinivas

> If 
> from HW, how is it the input validated?
> 

