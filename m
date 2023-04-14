Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D7F6E2418
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDNNPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:15:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890B03A9C;
        Fri, 14 Apr 2023 06:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ofFJ6l7XD4IqRDGCL9beOWbSCPsAkRU9DGOhi/GfkCg=; b=ikwMpoNueyqq2iAvVyICAgAoKc
        9BfJX8YFZUfz+dtLuZsFUyl5HfbLy2UogFBvsV9qSyZ7UQN/TFmAj1g8aXwB1yOapWbIHxLDXrXIq
        iIa3+HCF4JZwnVcPx69v3ubWxaMsKn6ks4wByLgVo9OEz1HdGl6a0SgT2DAT/pG3+cPAqA4lgu376
        IZLJalOlDYIiACy387SrEZpodz0M3OB/J8Uc8BBP+BU8XdINNDaRCFlu5NLkKFPV2KmC1Ichgz+YH
        DoqJMnf1H1Z5914IexmhqEnmVy9JJVd9fERQX9+Wmcq8yC7fbwesJQIBOV/U/m2qptXeMNBiEdN8X
        RlwqkItQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnJH3-009edI-2Y;
        Fri, 14 Apr 2023 13:15:33 +0000
Date:   Fri, 14 Apr 2023 06:15:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Bhaskar Valaboju (QUIC)" <quic_bhaskarv@quicinc.com>,
        "Sachin Gupta (QUIC)" <quic_sachgupt@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        Brian Norris <briannorris@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
 internal features
Message-ID: <ZDlR9VB7jRxMsEZH@infradead.org>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
 <20230401165723.19762-2-quic_sartgarg@quicinc.com>
 <ZCux+gsR8Nz4Epxw@infradead.org>
 <e492e234b3ec4624ae2f905bdae78785@quicinc.com>
 <ZDjmTi1+WA2BtLct@infradead.org>
 <53eda50111e2402e889bd690a0112ee1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53eda50111e2402e889bd690a0112ee1@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 06:52:18AM +0000, Sarthak Garg (QUIC) wrote:
> Sorry for the confusion by vendor file I meant driver file for Qualcomm SDCC controller (sdhci-msm.c).

This is still not how we do development.  The two series you've been
pointed out got valuable feedback that;s been ignored for between one
and four years, that needs to be followed up with.

You're not going to get magic hooks for your driver that you're not
sharing with us just because you're too lazy to follow up on the review
comments.
