Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE4473A24D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjFVN4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFVN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:56:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA4199B;
        Thu, 22 Jun 2023 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687442178; x=1718978178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iwvWjTXOATc+/cgzxfPqHvCL/9Mmo5XEzzxlVw4W7tY=;
  b=eU8ALiWHbzzojEw+on4Ad/Lr4y8ajV/2sC1uEFU7T2oVMRhVps303hho
   fyu34K+3FR6Le7rWLCnS5v9wItVFZb+WrofOl1RxZQKJhEPeG9sezM5cu
   ACcvCPlMYQjTuLi9sEEuCjSwXnCg5r+tEya32nlmcPbiJK/CIx82SKe/a
   StLBxVc/U6zHftiW2Z7c6PQxn16Gr//PN/4EeTQrjlo1S454JwMVHJvca
   T3iAzRK54hMHAiaI/kj8OEtx4JfUiTUKk7QwCueMHhEDm5DGQ1aKsw8rv
   OaBOrPN0qdolbOdwp3j+IQzcsrXY2cpo/d/z3bEOCt8EfxUEOaMoiysds
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="390236806"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="390236806"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804794065"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="804794065"
Received: from akivisil-mobl.ger.corp.intel.com (HELO intel.com) ([10.251.215.96])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:56:09 -0700
Date:   Thu, 22 Jun 2023 15:56:06 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     intel-xe@lists.freedesktop.org,
        Christian =?iso-8859-15?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-15?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [Intel-gfx] [PATCH 4/4] drm/ttm: Don't leak a resource on
 swapout move error
Message-ID: <ZJRS9uWyMiq2uB8/@ashyti-mobl2.lan>
References: <20230622101412.78426-1-thomas.hellstrom@linux.intel.com>
 <20230622101412.78426-5-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230622101412.78426-5-thomas.hellstrom@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Jun 22, 2023 at 12:14:12PM +0200, Thomas Hellström wrote:
> If moving the bo to system for swapout failed, we were leaking
> a resource. Fix.
> 
> Fixes: bfa3357ef9ab ("drm/ttm: allocate resource object instead of embedding it v2")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.14+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
