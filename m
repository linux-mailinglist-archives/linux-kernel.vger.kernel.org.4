Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16C36C72D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCWWPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCWWPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC4B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2C86628E6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE53AC433EF;
        Thu, 23 Mar 2023 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679609701;
        bh=M6e/PTV4/QD41rNo3Hf88nH85pNImdOy2sC2f6czaF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdHQIosAxULsZ71ZQ4M3a/+6nA4JelE9m3heqzN1jm33f09xdvn5BM51j2+5ZgtGh
         ozKAK44ifABBqfHW6A11+OPzBa5Hdro61rFw/XqZTTed/Vv3Q/HfAzLZI3kCEAYyth
         Cq5yxS4T2CCakoiydzTReEchAQWFlbxpUYdKDXvvU1DtEayvqCHCECdn2XC0AVaEat
         DSQvgZ1qYGZWPkf/De7ZlnVYnQVChVNH1lSeGeUNbndJdhpH0bzmFvqHLSjOCitxdZ
         zA+t5V7dU6H91Khi7uFbevcWmfWNttqpEbg1r/8ix20xNIO+CKuW9yWHqDLj0sZShN
         WLSTM/iexVZ4w==
Date:   Thu, 23 Mar 2023 15:14:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hans Holmberg <hans.holmberg@wdc.com>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, damien.lemoal@wdc.com,
        aravind.ramesh@wdc.com, hans@owltronix.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Message-ID: <ZBzPYwcoLXkFngz8@google.com>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
 <ZBhisCo7gTitmKeO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBhisCo7gTitmKeO@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20, Christoph Hellwig wrote:
> On Mon, Feb 20, 2023 at 01:20:04PM +0100, Hans Holmberg wrote:
> > A) Supporting proper direct writes for zoned block devices would
> > be the best, but it is currently not supported (probably for
> > a good but non-obvious reason). Would it be feasible to
> > implement proper direct IO?
> 
> I don't think why not.  In many ways direct writes to zoned devices
> should be easier than non-direct writes.
> 
> Any comments from the maintainers why the direct I/O writes to zoned
> devices are disabled?  I could not find anything helpful in the comments
> or commit logs.

The direct IO wants to overwrite the data on the same block address, while
zoned device does not support it?
