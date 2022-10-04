Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D295F4BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiJDWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiJDWMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9E65D10A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC396152E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 22:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1D6C433D6;
        Tue,  4 Oct 2022 22:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664921549;
        bh=zh+aJF7Mze9nAzC2hFiXb657t0HuludcQqubAGJzx1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePgr+8PlYXm1YhS0pZYsmNTS30xPSrNVlb4d/Kyf96URa9aJo1OOw7U35FVyACJlr
         jlyzReOfsV1VOLAhTdRaGXUf3GqogQvxaNyHC6AkJwsP6fidjMOjt/9xEriPX+SBUR
         1QH1AAfrN9mBFUywfeOW8ceT2OMNkj8dxeu49LehumVT+1yDqkMDoLDhFsVo1Uukgc
         SbIkQ2ys/Ysn8kat2aOfs8SjB92jwRyV8q/3Lvqk2OblPMiRI2b7RcvLJV0XIueGYd
         /mjq7/ljyxYmPMEtfGcrGUTbv29fWDXJ5S9thLOi6F7+guUn9++67MtgTIfgcseXRk
         kX9wN4e0eS6GQ==
Date:   Wed, 5 Oct 2022 01:12:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "reinette.chatre@intel.co" <reinette.chatre@intel.co>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Message-ID: <Yzyvya4wdfovw2eh@kernel.org>
References: <20220928153832.1032566-1-thomas.tai@oracle.com>
 <20220928153832.1032566-2-thomas.tai@oracle.com>
 <YzdkwIsNVI7P34ej@kernel.org>
 <SJ0PR10MB462307B1EA3097E1E725309DFD589@SJ0PR10MB4623.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR10MB462307B1EA3097E1E725309DFD589@SJ0PR10MB4623.namprd10.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 02:51:22PM +0000, Thomas Tai wrote:
> 
> > -----Original Message-----
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > Sent: September 30, 2022 5:51 PM
> > To: Thomas Tai <thomas.tai@oracle.com>
> > Cc: tony.luck@intel.com; dave.hansen@linux.intel.com;
> > reinette.chatre@intel.co; naoya.horiguchi@nec.com; linmiaohe@huawei.com;
> > akpm@linux-foundation.org; linux-mm@kvack.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
> > memory
> > 
> > On Wed, Sep 28, 2022 at 11:38:32AM -0400, Thomas Tai wrote:
> > > Inspired by commit c6acb1e7bf46 (x86/sgx: Add hook to error injection
> > > address validation), add a similar code in hwpoison_inject function to
> > > check if the address is located in SGX Memory. The error will then be
> > > handled by the arch_memory_failure function in the SGX driver.
> > >
> > > Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> > > ---
> > >  Documentation/mm/hwpoison.rst | 44
> > +++++++++++++++++++++++++++++++++++
> > >  mm/hwpoison-inject.c          |  4 ++++
> > >  2 files changed, 48 insertions(+)
> > 
> > Hmm.. no change log.
> > 
> > What was the change in-between v1 and v2?
> 
> Hi Jarkko,
> I put the change log in [PATCH V2 0/1]. Following is the details, hope you find it useful.
> 
> Changes since v1:
> - Add a comment in hwpoison_inject as suggested by Miaohe
> - v1: Reviewed-by: Tony Luck <tony.luck@intel.com>
> - v1: Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks,
> Thomas

Also,


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
