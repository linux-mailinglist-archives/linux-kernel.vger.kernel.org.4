Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C204604067
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJSJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiJSJyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:54:15 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171DD50BB7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tuja8sxdSJc2s7Rbhaz+suXxEoyZ2/4Lneuoa4MQOho=; b=MRvaOEJlGziNZuKp2TUVbGcQeV
        Gc4jU0lBHSjp7RQy5tES7IZkXtDiaW9nacHkwRfS5SzdyapUCKclUIRarpQUMKU/GavcqILZ0EuX5
        jml7cFn/YHcmowgk5QZ2+7zZy1sfeyTZaYqjZveqMPI43jxbESiPg5MXK0rt8TH3rxK8q3z8PbRNy
        mBYl1Z+vtv+pWOAzWGjzKMjn9sgyhzXbQYiouZtpGSNxSbptQ6ocM+1c4m4Ql1Eo5r07ir8DUABpd
        2a/J6pVhXJrDbRDXjnHhuPf99St/XybvHx5oB8PZS9DCLjoEJReWeRHLqJzWhme7EnKegXl3qDX92
        GrnEzhEA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34788)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ol55N-0005PB-Br; Wed, 19 Oct 2022 10:10:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ol55L-0001yT-Le; Wed, 19 Oct 2022 10:09:59 +0100
Date:   Wed, 19 Oct 2022 10:09:59 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] ARM: mm: fix no-MMU ZERO_PAGE() implementation
Message-ID: <Y0++52o7QSaDvqpM@shell.armlinux.org.uk>
References: <20221017233700.84918-1-giulio.benetti@benettiengineering.com>
 <3fb4afd1-2eea-4a71-a914-f8208b11f9f4@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fb4afd1-2eea-4a71-a914-f8208b11f9f4@app.fastmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:03:01AM +0200, Arnd Bergmann wrote:
> In addition to your fix, I see that arm is the only architecture
> that defines 'empty_zero_page' as a pointer to the page, when
> everything else just makes it a pointer to the data itself,
> or an 'extern char empty_zero_page[]' array, which we may want
> to change for consistency.

ARM's implementation is the utterly sensible implementation IMHO.

When the only users in the kernel _were_ ZERO_PAGE() for this, which
is defined to return a struct page pointer, there was no need to make
"empty_zero_page" anything but a struct page pointer, rather than a
runtime translation from an address to a struct page.

IMHO, we should _not_ be exposing empty_zero_page to devices - we
certainly do not want the DMA API performing cache maintenance on
this page since the primary purpose of this page is to fill in
userspace BSS pages that have not been written.

ACPI's use is just to have a cookie for invalid handles, and using
the struct page pointer is good enough.

The only problem one is the RAID6 code, but that is disabled:

/* Set to 1 to use kernel-wide empty_zero_page */
#define RAID6_USE_EMPTY_ZERO_PAGE 0

#if RAID6_USE_EMPTY_ZERO_PAGE
# define raid6_empty_zero_page empty_zero_page
#else
extern const char raid6_empty_zero_page[PAGE_SIZE];
#endif

So, the only one that needs fixing is the SPI usage, which IMHO
is wrong. ARM being different finds what I consider a driver bug.
Good for 32-bit ARM. :)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
