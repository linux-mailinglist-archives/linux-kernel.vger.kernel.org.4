Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3F6C2312
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCTUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCTUoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:44:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22338EC68
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679345027; x=1710881027;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Z0cSL+M1qbeo4dWHqt9xR8/EfLh7XeU49eCBlMRw1+A=;
  b=RNkLegqSz3SjUZQxlTn8jRGoxUDUX5cxCOA+IIoRDfPLiyhaiwqLIYmN
   eLsRc8m+YItzJo2sAgls/jhD36JVxXFIj/sfptnB9z1PuoK721ZYvGW+/
   VsHgFHLtYwVIDKigkiso9Cwrb30DF2e9oYlZV7H3qkmwgd70yV/tu5fCV
   SrWTJPsOraqgrKEHvO9IBVhZQ6qXHeexMAsnNiXDKlXDQULkox5Z3SDuC
   O6fwHXqGvJt6gcQk/uERkD+nx11rRwP/TtmbOUecmNPEFu5SxZ4h08RBm
   Ap0ByoT4mqX2xipFSc9LTp6FL4FRytCOI43ycTRF7yichD0Xst8brBoLb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="403646053"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="403646053"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="927101749"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="927101749"
Received: from tblanzy-mobl.amr.corp.intel.com (HELO [10.209.0.34]) ([10.209.0.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:43:10 -0700
Message-ID: <93b293341866a4366b2f2a614f8742ca94ff4e3c.camel@linux.intel.com>
Subject: Re: [PATCH v7 13/13] vmstat: add pcp remote node draining via
 cpu_vm_stats_fold
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Date:   Mon, 20 Mar 2023 13:43:09 -0700
In-Reply-To: <20230320180745.858515310@redhat.com>
References: <20230320180332.102837832@redhat.com>
         <20230320180745.858515310@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-20 at 15:03 -0300, Marcelo Tosatti wrote:
>=20
> +
> +		if (do_pagesets) {
> +			cond_resched();
> +			/*
> +			 * Deal with draining the remote pageset of a
> +			 * processor
> +			 *
> +			 * Check if there are pages remaining in this pageset
> +			 * if not then there is nothing to expire.
> +			 */
> +			if (!pcp->expire || !pcp->count)
> +				continue;refresh_cpu_vm_stats
> +
> +			/*
> +			 * We never drain zones local to this processor.
> +			 */
> +			if (zone_to_nid(zone) =3D=3D cpu_to_node(cpu)) {
> +				pcp->expire =3D 0;
> +				continue;
> +			}
> +
> +			WARN_ON(pcp->expire < 0);
> +			/*
> +			 * pcp->expire is only accessed from vmstat_shepherd context,
> +			 * therefore no locking is required.
> +			 */
> +			if (--pcp->expire)
> +				continue;
> +
> +			if (pcp->count)
> +				drain_zone_pages(zone, pcp);
> +		}

This logic is the same to that for the do_pagesets portion of code in refre=
sh_cpu_vm_stats().
Is it possible to consolidate to avoid replicating the logic across two fun=
ctions?

Tim=20
