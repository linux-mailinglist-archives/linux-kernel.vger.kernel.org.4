Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6200173F83D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjF0JHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjF0JHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:07:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B703D269E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687856807; x=1719392807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JaKhdwJtfC7Oib/27piMBfnO+XxQp6i2NYK9CWnNEJA=;
  b=cLAChd0d7CKexpUe20T4O4iVTp4Z6fbybvNasZgN/tIdE6u3Y3J65O3z
   OP06YbQXO67cG4VTM3mJRAnvKGabpKq9/bFFpvTUXXSKOT9WPJmgdYLro
   wwiIvHOurD6pcZ8bke9kNAIX+o6ag+0BFt7lBvSfkvbMOaligNJpXgZiy
   gUlf/RbZ+t/3HsGvFQ1IaTvpHlTij028qOwkt8yb0Pn3TJZPTWaDTBesm
   NKxk/DOD7j9og2o/8tHzcyh/y8EkFeK0W3nJw8SbJSu79CNZTFr/7zs4Y
   qCUp1JTWP8POGrYW/9pC/hPDN1uUUN6yYfVheOKkhFOMP1KuSKDb9uSCK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="359017718"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="359017718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 02:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="781769236"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="781769236"
Received: from skallurr-mobl1.ger.corp.intel.com (HELO [10.249.254.202]) ([10.249.254.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 02:06:28 -0700
Message-ID: <f821b9e3-b4b1-d182-040f-27df81cf8aa6@linux.intel.com>
Date:   Tue, 27 Jun 2023 11:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v2 0/4] drm/ttm: Fixes around resources and bulk moves
Content-Language: en-US
To:     intel-xe@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Andi Shyti <andi.shyti@linux.intel.com>
References: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/26/23 11:14, Thomas Hellström wrote:
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> A couple of ttm fixes for issues that either were hit while developing the
> xe driver or, for the resource leak patches, discovered during code
> inspection.
>
> v2:
> - Avoid a goto in patch 3 (Andi Shyti)
> - Add some RB's
>
> Thomas Hellström (4):
>    drm/ttm: Fix ttm_lru_bulk_move_pos_tail()
>    drm/ttm: Don't shadow the operation context
>    drm/ttm: Don't leak a resource on eviction error
>    drm/ttm: Don't leak a resource on swapout move error
>
>   drivers/gpu/drm/ttm/ttm_bo.c       | 26 +++++++++++++-------------
>   drivers/gpu/drm/ttm/ttm_resource.c |  2 ++
>   2 files changed, 15 insertions(+), 13 deletions(-)
>
Pushed 2/4 to drm-misc-next, 3/4 & 4/4 to drm-misc-fixes.

/Thomas


