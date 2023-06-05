Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775FD722AD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjFEPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjFEPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCD010A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8E861B16
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE02C433D2;
        Mon,  5 Jun 2023 15:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685978439;
        bh=SeVFm3lQkxUzBSnv04TYGgIO5c4M8Ej5DLASHxK5mbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqKdIPdK3RQtBgGKSt4LkvxD+JgF92WhPAoymsmUgURG7VECkOkrNvhtkC4Wdi9WV
         buFNXlRWMm+OtWuoLnT+DnOYw2zIz1bkZJSINqs0WMm/fR+Z5UdmBF4t764bEe5iiq
         NFzJkNajDnIA+lycme04gOi+KOjOre46gTWbM7Nc=
Date:   Mon, 5 Jun 2023 17:20:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v4 1/4] devres: Provide krealloc_array
Message-ID: <2023060546-deputy-geriatric-2706@gregkh>
References: <20230509094942.396150-1-james.clark@arm.com>
 <20230509094942.396150-2-james.clark@arm.com>
 <2023051340-sinuous-darkroom-2497@gregkh>
 <89ad5070-db72-7bf1-5d86-a89fea54e789@arm.com>
 <2023051530-immunize-pony-49ef@gregkh>
 <46bb773c-31a8-c57a-0cde-39c27d0a6e36@arm.com>
 <2023060104-removal-map-b194@gregkh>
 <f52a1dee-70f2-e3b4-4aa2-f591d7d8063e@arm.com>
 <6cbdce5c-d470-9717-774d-2d25c9fc24c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cbdce5c-d470-9717-774d-2d25c9fc24c1@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 02:39:44PM +0100, Suzuki K Poulose wrote:
> Hi Greg
> 
> On 01/06/2023 10:52, Suzuki K Poulose wrote:
> > On 01/06/2023 10:33, Greg KH wrote:
> > > On Wed, May 31, 2023 at 11:44:55PM +0100, Suzuki K Poulose wrote:
> > > > (Removed irrelevant recipients), +Cc: coresight ml
> 
> ...
> 
> > > > Apologies for hijacking the thread. We have a series for CoreSight[1]
> > > > that depends on this series, which I see that, is queued in your
> > > > driver-core-next.
> > > > 
> > > > I would like to queue [1] for the next version (as there are other
> > > > work that depend on this, e.g., [2]). Do you have any
> > > > recommendations/comments on the proposal ? Are you able to share a
> > > > stable branch which can be merged to coresight/next and queue the
> > > > series ontop ? (PS: I haven't queued anything for coresight/next yet).
> > > 
> > > You can pull from my driver-core-next branch just fine and assume it
> > > will be stable.  So just pull in that one commit and all should be good
> > > in the future.
> > 
> > Thanks Greg, I will give it a go
> 
> Does this look fine with you ?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=tmp/devm_krealloc_array

Looks good to me!
