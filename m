Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11296A8EA6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCCBY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCBY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:24:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2B11557C;
        Thu,  2 Mar 2023 17:24:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 971E7616CA;
        Fri,  3 Mar 2023 01:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A644C433D2;
        Fri,  3 Mar 2023 01:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677806665;
        bh=Lcl+ON/n2tfB00oe/DNX6nE8UIFnf+CyFVbbzShggPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4SSwe/VEOuHUs08IN2lCHh6lAGJekITYyAVHZBN3waqQPxT37eoGELMc5MCfKCVx
         okRRbO73SjuW/xnBRIIuFWiud8kDRPP9KWFEjGZbuug4Mt8bMRANkhHmOkCf/eA9hF
         tRiyfrlQlAHpJD6wWVlXjUUB1aMV33XiXFNqqVHY9Zs9nZ2FUB3fpWSyaf8fECu70q
         XJ2H74i/GOa/j20L7PA5nP/uckoiwXRRTDKMzCcYukDmBdPIJMhwbwiZvXSKL7mIqK
         bLmdVgbRtlTok8WSyyq9IZMZ1j3oIJDkKMfPSXIYTrPJ7/iNvWwKILky5s9teEMTXg
         KGuNTGZoN0agw==
Date:   Thu, 2 Mar 2023 18:24:21 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-mq: quiesce queue while reallocating hctxs
Message-ID: <ZAFMRUo9fdcJh/JD@kbusch-mbp.dhcp.thefacebook.com>
References: <20230221092436.3570192-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221092436.3570192-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 05:24:36PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 8237c01f1696 ("blk-mq: use quiesced elevator switch when
> reinitializing queues") add quiesce queue while switching elevator,
> however, if old elevator is none, queue is still not quiesced. Hence
> reallocating hctxs can concurrent with run queue. Fix it by also
> quiesce queue in the beginning of __blk_mq_update_nr_hw_queues().

Is this actually fixing anything? The quiesced elevator switch was to prevent
use-after-free from an elevator being torn down, but if you are not switching
elevators, then what resource does quiescing protect?
