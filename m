Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC256105DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiJ0WiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbiJ0WiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:38:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EC1B1DCD;
        Thu, 27 Oct 2022 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666910289; x=1698446289;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CYTQAz5x8yB45/Cr8omKePud0pBEogtrS5KnQNykMKM=;
  b=NjLSQP5Rd/+tdxw91w9iBLD7F4DkejPFkb0HLYrFgH2Ewma5Oy0ElAjp
   0rcgUBgksVSzedsyLgA7Eu9rLDwXG6ejfUKtXdIb57nvRoRmqVv4En1Lw
   W++uOs2pz47gKvuTP7rAkwD6jKwJK4RAwJZ5oCfKvxkHfEzYgY7vkSaaI
   3Ios9W8BZS2bzLL4lJ7flBb3HMNPH/uGTi282la2QSSs/fYvM4yio8sGH
   qbhskYgz9IXUyw1/rNgKVNfHPH7vC5qdDmtMd7H89jqhN/mEsE0QNyg20
   ECXBCCW275z+uC3EDoxxHFCiCCi366Luv8KDGs3yLOjOj47XV0XYav4cx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="334991686"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="334991686"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 15:38:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="583721220"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="583721220"
Received: from lsiddan-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.190.203])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 15:38:08 -0700
Message-ID: <b79748ff2f07f95eb637ec7b6de74446c28f72b3.camel@linux.intel.com>
Subject: Re: [PATCH] x86: intel_epb: Set Alder Lake N and Raptor Lake P
 normal EPB
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, rafael@kernel.org, len.brown@intel.com
Cc:     peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Thu, 27 Oct 2022 15:38:07 -0700
In-Reply-To: <235f4f04-b2ae-4a7f-043b-1cd6a85bd8ea@intel.com>
References: <20221027220056.1534264-1-srinivas.pandruvada@linux.intel.com>
         <235f4f04-b2ae-4a7f-043b-1cd6a85bd8ea@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-27 at 15:30 -0700, Dave Hansen wrote:
> So, the tl;dr on this is:
> 
>         The EPB setting is fundamentally a classic power vs.
> performance
>         knob.  This change helps power a bunch (200+mw) while having
> a
>         negligible performance impact (<1% if that), so it's a great
>         trade-off.
> 
> Right?
Yes.
We already using EPB 7 on other AlderLake Mobiles.

Thanks,
Srinivas

