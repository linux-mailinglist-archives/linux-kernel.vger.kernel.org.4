Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CBE686D46
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBARoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjBARn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:43:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8532D5F;
        Wed,  1 Feb 2023 09:43:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 533B36189B;
        Wed,  1 Feb 2023 17:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F41C433D2;
        Wed,  1 Feb 2023 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675273434;
        bh=uOEskdrISS5/pIK69CpcNRJ8NaEqZuxjbsHQ5zzg0VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yd1V+gVIJ9aeOv31mlNJkYtLOQl5xCcGiYHmKmZdbnfBAwYJxU1zpmwRx7sQlcKAm
         e7aOfdBESZL8NfwsZ38NTgglekycbbYGbcBJ9etbGUtczeRztR2B6cuMb4lujKgESa
         DBPp0g0nsB/WWviTWaa1CUoEMqHiY+qnNVujGl2tzZc/VSEvlydfteuGlQyFp3UW3J
         Cjalp2yAjQHWhi15zNpDurKrBDErD9b0c+RdUVymiovVvt7KQ/KanbTwxvhsBcGq/L
         VRu0C7GWQEusvIvpZH8Vj00dPTbpqE1iQF95yBNgwBg9edGH1Npd6jN3cbm/zDIJww
         /4akZHaByrjow==
Date:   Wed, 1 Feb 2023 10:43:51 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hch@lst.de,
        tonyb@cybernetics.com, akpm@linux-foundation.org,
        kernel-team@meta.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv4 11/12] dmapool: link blocks across pages
Message-ID: <Y9qk13UwzpzN+Y2q@kbusch-mbp.dhcp.thefacebook.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
 <20230126215125.4069751-12-kbusch@meta.com>
 <CAJB8c05HgmDqMn9KwOi2P6+s-c8zt6-oiW6gOo==CDv6=HNahQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJB8c05HgmDqMn9KwOi2P6+s-c8zt6-oiW6gOo==CDv6=HNahQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 05:42:04PM +0000, Bryan O'Donoghue wrote:
> On Thu, Jan 26, 2023 at 9:55 PM Keith Busch <kbusch@meta.com> wrote:
> So.
> 
> Somehow this commit has broken USB device mode for me with the
> Chipidea IP on msm8916 and msm8939.
> 
> Bisecting down I find this is the inflection point
> 
> commit ced6d06a81fb69e2f625b0c4b272b687a3789faa (HEAD -> usb-test-delete)

Thanks for the report. I'll look into this immediately.
