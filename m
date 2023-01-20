Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7368675C05
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjATRuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjATRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:50:43 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D158B33D;
        Fri, 20 Jan 2023 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674237040; x=1705773040;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LOH0u7YIBdv5UHw/+ps52IM6e+ipAkGrkX92/m8q52o=;
  b=b05qKqT/u1XlOvp0czOb4Cnf14JDBTNqXtDKxji6Bw/T3u1iuTDW5OkJ
   2C5ffSn0/L0LyRpz7ICufNO9HtJdSynXDS8ZC9XyLkUErJ0+mPhmIKjwX
   7H1XjwXcJQ97gy3TDgDw1++9/38JthkoI3Hz1zgK2DmH/YjCUuATtQZa5
   BwThauwniyA0paxl6RH6inwJCaqwsOh77kB7kA7A7LNrVYbM1DA33+wxH
   lnJ3UuPTC1RySIV5In2VEExI77nt62/5HzrPWmzP5Kse+nb6shYvMRu8c
   NoP2cf2eEE50risTQzAmTFTFfn8FAzSEy3wP921Mwlfm5lxLIEUoQnnQy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="313526847"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="313526847"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 09:50:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="784598741"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="784598741"
Received: from yiyangli-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.251.19.72])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 09:50:39 -0800
Message-ID: <5b145975c781b9a8165acea037192f38f9a6d87b.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel: pch: Add support for Wellsburg PCH
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tim Zimmermann <tim@linux4.de>, Zhang Rui <rui.zhang@intel.com>
Cc:     Tushar Dave <tushar.n.dave@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 20 Jan 2023 09:50:39 -0800
In-Reply-To: <CAJZ5v0jYUmDHn6ati=zOU6JyYYAuc6CUtV2eomPWWa2aBoKdSA@mail.gmail.com>
References: <20230107192513.118172-1-tim@linux4.de>
         <CAJZ5v0jYUmDHn6ati=zOU6JyYYAuc6CUtV2eomPWWa2aBoKdSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-20 at 17:40 +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 7, 2023 at 8:42 PM Tim Zimmermann <tim@linux4.de> wrote:
> > 
> > This adds the PCI ID for the Wellsburg C610 series chipset PCH. The
> > driver can read the temperature from the Wellsburg PCH with only
> > the PCI
> > ID added and no other modifications.
> > 
> > Signed-off-by: Tim Zimmermann <tim@linux4.de>
> 
> Rui, Srinivas, any objections to this one?
No objection.

Thanks,
Srinivas

> 
> > ---
> >  drivers/thermal/intel/intel_pch_thermal.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/thermal/intel/intel_pch_thermal.c
> > b/drivers/thermal/intel/intel_pch_thermal.c
> > index dabf11a687a1..9e27f430e034 100644
> > --- a/drivers/thermal/intel/intel_pch_thermal.c
> > +++ b/drivers/thermal/intel/intel_pch_thermal.c
> > @@ -29,6 +29,7 @@
> >  #define PCH_THERMAL_DID_CNL_LP 0x02F9 /* CNL-LP PCH */
> >  #define PCH_THERMAL_DID_CML_H  0X06F9 /* CML-H PCH */
> >  #define PCH_THERMAL_DID_LWB    0xA1B1 /* Lewisburg PCH */
> > +#define PCH_THERMAL_DID_WBG    0x8D24 /* Wellsburg PCH */
> > 
> >  /* Wildcat Point-LP  PCH Thermal registers */
> >  #define WPT_TEMP       0x0000  /* Temperature */
> > @@ -350,6 +351,7 @@ enum board_ids {
> >         board_cnl,
> >         board_cml,
> >         board_lwb,
> > +       board_wbg,
> >  };
> > 
> >  static const struct board_info {
> > @@ -380,6 +382,10 @@ static const struct board_info {
> >                 .name = "pch_lewisburg",
> >                 .ops = &pch_dev_ops_wpt,
> >         },
> > +       [board_wbg] = {
> > +               .name = "pch_wellsburg",
> > +               .ops = &pch_dev_ops_wpt,
> > +       },
> >  };
> > 
> >  static int intel_pch_thermal_probe(struct pci_dev *pdev,
> > @@ -495,6 +501,8 @@ static const struct pci_device_id
> > intel_pch_thermal_id[] = {
> >                 .driver_data = board_cml, },
> >         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_LWB),
> >                 .driver_data = board_lwb, },
> > +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WBG),
> > +               .driver_data = board_wbg, },
> >         { 0, },
> >  };
> >  MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
> > --
> > 2.39.0
> > 

