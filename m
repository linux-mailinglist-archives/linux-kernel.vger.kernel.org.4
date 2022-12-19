Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6350D6511B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiLSSV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiLSSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:21:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D08614D;
        Mon, 19 Dec 2022 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6grkKqNpHqDjE2CxjSJFUJOEcpN2/JFfLlyRMhX3IhM=; b=1MiHKDKZ8dHEcqlhotvk+nQL5F
        87OakpCd5BXDbVlsTmf945Oaq7TCDfTmYqW0GbWpz9mfCrOpkII52rykQWP8QNfRfvsnNVSaznBB/
        +KgoF8d199MbGOtt+Eu4qoWoy9bPt4ESdhcgKbw2Vl52c8wpVUeb2tlZ/S4rpHtUN3EOLnr/dhh/u
        7tIIisJhOBPcoDBPTvlIJoWeRaJLiuvBSNnpb+N0Qo8NMkDyOi+LkloSIGtg2rX2BuRkJPjUAthFl
        aSPCTPfT0iLE39K/4auxFrBdK+0JlngkeOiO04v/flUBnVbuDPuIZm6q0HmfFfZnvq5WFdw4HhLyi
        KbJh6y/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7Kkx-00HMLW-9b; Mon, 19 Dec 2022 18:20:55 +0000
Date:   Mon, 19 Dec 2022 10:20:55 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] cxl_test: upgrade as a first class citizen selftests
 capable driver
Message-ID: <Y6Crh5DiGPPzKoYp@bombadil.infradead.org>
References: <20221217034947.1174795-1-mcgrof@kernel.org>
 <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
 <20221218160824.0000583d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218160824.0000583d@Huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 04:08:24PM +0000, Jonathan Cameron wrote:
> QEMU based CI should go two ways:
> 1) QEMU CI would typically pin particular kernel version and verify that
>    QEMU changed don't break that. If we need new features for a new test,
>    we move that kernel version used.  Existing tests should never break
>    against a fixed kernel version as that's a regression in QEMU (or
>    maybe a bug elsewhere) Ultimately we should have this running in the
>    normal QEMU gitlab CI.

Sounds sensible.

> 2) Kernel CI against QEMU would typically pin particular QEMU version
>    and check that kernel changes don't break.  This will have rough edges
>    for a while yet as we are still adding mandatory features to the QEMU
>    emulation (e.g. events support).  Again, as we add new features / tests
>    may need to move the QEMU version forwards to support them.

Sure - but for this today other than ensuring a kernel does not crash upon
bootup we also have cxl_test, but not much else.

We'll want to exand a set of target tests on CXL enabled nodes, without
cxl_test. Other than verifying the topology matches, we'll want to start
mimicking actual use cases / performance stuff.

> I don't think we much care about backwards compatibility so once we've
> moved the pinned element forwards in the above, we won't care about the
> old version. 

Making tests simply skip if the feature is not available doens't take
much effort but forward thinking.

> The aim here isn't really to ensure no regressions when
> running on QEMU (though that CI is nice to have), but more that we have
> no problems in kernel side of things.

Sure.

> This is a way off yet.  Not seeing this as being part of linux.git.
> The QEMU CI stuff will be in the qemu.git and Kernel CI stuff probably
> sit out of tree - there shouldn't be a tight coupling beyond new tests
> wanting to check available features etc. I might ask a friendly
> CI project to add this to their normal runs.

OK in case it helps, cxl-enabled qemu building bringup / ndctl building
and install is all now automated and integratead as part of kdevops so
patches welcomed to expand that coverage.

> I don't have strong feelings on cxl_test. Tend not to use it myself
> and haven't yet contributed to it.

Thanks, this is useful information.

  Luis
