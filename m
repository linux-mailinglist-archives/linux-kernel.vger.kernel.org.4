Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D36CC99B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjC1Rsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjC1Rsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:48:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E2EE19B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VFaciPaePZVej+tCKBMHtsjAZ53gqGo22KKn0gPVud8=; b=H3330iUfMaCaTnfPtCIJO1d4Bh
        Tvl63zioGJhmKL0ble0lR2ejt0TQDCg6P907xTVAeqKkjMOPHBvmLhTskSPFx8xqgK4h3pZjRAxBe
        QPDm9SBO6jKH7613NSMQXzSS6FiqRTD68/ZcrndKu2bPrq4i/+MuFVQM6WwcQXVtShK6Ydv4a0BFO
        MQLL0/ne5sap6m66nqM0QwwlD/W3SU0AXx5eT+qs09tgc+5BQkNBZzRoWOELsuAU2lhsZ+fRl58px
        eLTZu0ZHc+30TOMrA+jMNWRIHkqvBDG02fQiPsktiuSZylexafMifbIwY4EpiQROkw8vcYshkdQZS
        rQCZS7Hw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phDQi-00FMn5-1B;
        Tue, 28 Mar 2023 17:48:20 +0000
Date:   Tue, 28 Mar 2023 10:48:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jan Kara <jack@suse.com>, Yangtao Li <frank.li@vivo.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Dave Chinner <dchinner@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Baokun Li <libaokun1@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: quota: avoid unused function warning for
 !CONFIG_SYSCTL
Message-ID: <ZCMoZMftUgg7Mrv2@bombadil.infradead.org>
References: <20230328122244.2521387-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328122244.2521387-1-arnd@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:22:31PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Note: it may be better to just revert the 63d00e08515b patch, as the
> -#ifdef CONFIG_SYSCTL
> -	if (!register_sysctl("fs/quota", fs_dqstats_table))
> -		pr_notice("quota sysctl registration failed!\n");
> -#endif
> +	if (IS_ENABLED(CONFIG_SYSCTL)) {
> +		if (!register_sysctl("fs/quota", fs_dqstats_table))
> +			pr_notice("quota sysctl registration failed!\n");
> +	}

I'd agree to drop that patch and instead just use register_sysctl_init()
iwht Arnd's strategy.

  Luis
