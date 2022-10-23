Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C07060915E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 07:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJWFpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 01:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJWFpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 01:45:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44032EE2;
        Sat, 22 Oct 2022 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666503896; x=1698039896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LrcyLnNJc5d6TqhYX2DARi29/uv/JKL8UZZljLfeBSk=;
  b=g0OdGNYmDGonRgKdS3addNBnh1YCphWSJUNaf7k+LagtDGe5DMxUsbmE
   PGIpMrXyqre+KznnzBi/qG+W9oQ7m5yAtDChK/EyIKOAV4u6w8SoVW0Qy
   ZAK7qa8Quj76TPz+1C7C1SLbECbbW2G+pm4spKlAJ9KDnSH8RjlawWe1W
   b2VcDA8dq1m75NaUSISpwrI8Arhf1pguusPYyFZfblROch77uVa0YyCD7
   qCkwb+gkvM04dZtRhDTSyJ9pyX0jNq4k54KpBqvtlmMMisYV7hDUIhV6F
   e0Bms4ODBVVWcgqvdek4vN+dy/xAdsrUp0IxEx1qH6DTUMXtKPDORvEJ3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="308328641"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="308328641"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 22:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="773479987"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="773479987"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Oct 2022 22:44:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E0589107; Sun, 23 Oct 2022 08:45:13 +0300 (EEST)
Date:   Sun, 23 Oct 2022 08:45:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: intel-spi: Move software sequencing logic
 outside the core
Message-ID: <Y1TU6TNVrgffQgub@black.fi.intel.com>
References: <20221020164508.29182-1-mauro.lima@eclypsium.com>
 <20221020164508.29182-2-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020164508.29182-2-mauro.lima@eclypsium.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 20, 2022 at 01:45:07PM -0300, Mauro Lima wrote:
> +#include "spi-intel.h"
> +#include "spi-intel-common.h"
> +#include "spi-intel-swseq.h"

Do we really need all these headers? Why not just "spi-intel.h"?

> +
> +bool mem_op_supported_on_spi_locked(const struct intel_spi *ispi,
> +				    const struct spi_mem_op *op)
> +{
> +	int i;
> +
> +	/* Check if it is in the locked opcodes list */
> +	for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
> +		if (ispi->opcodes[i] == op->cmd.opcode)
> +			return true;
> +	}
> +
> +	dev_dbg(ispi->dev, "%#x not supported\n", op->cmd.opcode);
> +	return false;
> +}
> +EXPORT_SYMBOL(mem_op_supported_on_spi_locked);

You need to namespace all these symbols with intel_spi_ or so (and use
_GPL version of EXPORT_SYMBOL()).

However, I don't think we even need all these to be exported in the
first place. It has been quite a while we discussed about this so I
might be forgetting something but IIRC I did not suggest the split this
way? ;-)
