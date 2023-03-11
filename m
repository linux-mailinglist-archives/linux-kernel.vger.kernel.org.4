Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A66B6191
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 23:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCKWr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 17:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCKWrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 17:47:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BE464219
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=I8q2BnsEIW5BWUm1sDukVLw/zzl+nCal74X73LZ+BVs=; b=vtKmVizfKdXA6bY4bqBuFHEL/j
        acdmVdoXHOJ/0bYt5Ip7CbwQWIY3T3hD+HpKj9MqyZxMJ1mDkrP/fU5+Ic75TPZg+s61B7L/AVQ19
        ggzs1nrzEwpfRuaLdtcUTh6reWwzAHL3wifjtci8x1m1ZQDzgsg2o14tw9yVar3BCEmdT0YmbaXzH
        BHzhDiwMgD0SOeeAT6ZX12VtgixFTFhHQFuqUtHgLWdRVECUe330vhDuEgN00Gw3LSxSmT9zlT8nf
        lsLfiFYum4P/qS/EQv2AFCuxy/cX/iiJXjRLTZ/3J+Yje5DYUGNyn/O/gi0avH2alDzup5XcUu13g
        5Ztvp9Ig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pb80B-001Qj4-Q7; Sat, 11 Mar 2023 22:47:47 +0000
Date:   Sat, 11 Mar 2023 14:47:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 9p caching with cache=loose and cache=fscache
Message-ID: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've embraced 9p on kdevops [0] for support to let a guest use a host's
path to install Linux. This works well except I notice that if the host
makes new changes the guest does not see it. This just means the guest
has to reboot every time before running 'make modules_install install -j 8'
and it is unexpected and not user friendly.

I wanted to see if someone was working on fixing this yet. I've tested
with both cache=loose and cache=fscache. We use msize 131072, no
security and virtio-9p-pci.

[0] https://github.com/linux-kdevops/kdevops

  Luis
