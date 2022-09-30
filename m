Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D935F1398
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiI3UXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiI3UWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:22:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F05184EEE;
        Fri, 30 Sep 2022 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zDeOwzAgGUEV4fbTcK+NNYEOtGCIzjWX2lndZv1lKJo=; b=JCwYNZoxvp22WUb9TdFcMtPB9Y
        FcuNESTdpYcK2R8n1SgGp/Oh6v9mo4sBWCsJWPWw5sYK49c4vWLPgvPsofSBuGyNXx3ZfsItRbaHJ
        u8WJbMskpxpy8zApLj6l6Q0nw5as0G/DPuTXa4QJ/tUPQ8/4MFdW1PQRlQ5R+TcF1KlJXR98zYQ/t
        BeFSKGlPVH/KEumr9nW9AqXs694i0TRx6dUlLWNWTE6X930l+HrsMtc0UVJJ2YTdsmkFqGSoACzPb
        cE2rOC/WWAh9voq4gTy2TQr9IMlB/oPTNUreV2qXK9oEUPENWpMGb6Of5ivPRcHYovIiela1IUatB
        uRazOdpQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oeMWf-00BOc0-IT; Fri, 30 Sep 2022 20:22:25 +0000
Date:   Fri, 30 Sep 2022 13:22:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] module: Correct wake up of module_wq
Message-ID: <YzdQAWa5eRtfOwHl@bombadil.infradead.org>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-2-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919123233.8538-2-petr.pavlu@suse.com>
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

On Mon, Sep 19, 2022 at 02:32:32PM +0200, Petr Pavlu wrote:
> The module_wq wait queue has only non-exclusive waiters and all waits
> are interruptible, therefore for consistency use wake_up_interruptible()
> to wake its waiters.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Does this fix a bug? It seems like it does. Please think of this should
go to stable, for instance, does it fix a bug not yet reported?

  Luis
