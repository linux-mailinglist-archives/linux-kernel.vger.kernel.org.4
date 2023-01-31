Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D834E6830FF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjAaPMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjAaPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:12:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A400B564A7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40E59B81D1B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90123C433D2;
        Tue, 31 Jan 2023 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675177754;
        bh=T51uegKuzukl3ZkjeIiLZP9VBhsaBt4W7GSHPwVxG9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyOknRSiZm0+nA3YMUt66CXZx9HirEFqUcaWgzflzztTO+EMI9+EuH6i0SONTpZyo
         yA7nsHpLa5raKX2AxJmlT92m4ZtKraxwTuTMvLjoyJNm6PJYCw0Kkp5BnpLz7IuhEl
         GGE0NPK1VQRF8/AIz7KEDt3a59Ou5dz+xtRn8EwM=
Date:   Tue, 31 Jan 2023 16:09:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix NULL check for rcu pointer
Message-ID: <Y9kvF0C1kiDctEUw@kroah.com>
References: <20230131090057.241779-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131090057.241779-1-martin@kaiser.cx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:00:57AM +0100, Martin Kaiser wrote:
> Fix the NULL check for padapter->pnetdev->rx_handler_data.
> 
> The current code calls rcu_dereference while it holds the rcu read lock
> and checks the pointer after releasing the lock. An rcu pointer may only be
> used between calls to rcu_read_lock and rcu_read_unlock.
> 
> Replace the check with rcu_access_pointer. My understanding is that this
> function returns the value of the pointer and needs no locking. We can
> then check the pointer but we must not dereference it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

What commit id does this fix?

thanks,

greg k-h
