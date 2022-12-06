Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7269564474F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiLFO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiLFO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:58:51 -0500
Received: from smtp-out-03.comm2000.it (smtp-out-03.comm2000.it [212.97.32.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35352E695
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:52:03 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-03.comm2000.it (Postfix) with ESMTPSA id 88521B43547;
        Tue,  6 Dec 2022 15:52:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1670338322;
        bh=AH0lJQg4LZFijVvXwpG3wKnwdJDssHQBputnWnmGOqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SnF/eRgWSZYZjwwv5dPDLyC03bYXf+Y/uBVUgjVb6eGjSU2Z4doe73h488olnQt/R
         89M4+8vo0qYkiWkVlsgJRucC51ZVb7kX5W/UgYCXaQzBR2FiIdOa0HVDQa/CqLx99L
         kh5jVy1BegNdl/BcbIWdrEQzxL4/54VU/wnIKmlHjI0L0Xr8kqOnFbK0hVT0IVmDF1
         s/oWJ4HTw0TvsoYpOU2b1j3lUWMQaP8xKF6Hm87d7zbX3pLhNK/UMDzVOia99ooNTw
         I3ZXoV8+4qPf02cwZK3HWdw9X75W86gClvnXXqIngnXySXb5vNyGlGU+DiNc8WLTkR
         zg2wciUTFv/Lw==
Date:   Tue, 6 Dec 2022 15:51:16 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        max.krummenacher@toradex.com
Subject: Re: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Message-ID: <Y49W5DuvGcqh0PFw@francesco-nb.int.toradex.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929085318.5268-1-sherry.sun@nxp.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Thu, Sep 29, 2022 at 04:53:18PM +0800, Sherry Sun wrote:
> This reverts commit 60f361722ad2ae5ee667d0b0545d40c42f754daf.
> 
> commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to registration")
> causes the lpuart console cannot work any more. Since the console is
> registered in the uart_add_one_port(), the driver cannot identify the
> console port before call uart_add_one_port(), which causes all the uart
> ports including the console port will be global reset.
> So need to revert this patch to avoid breaking the lpuart console.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

What's the status/plan on this?

From what I can tell the commit this patch is reverting introduced a
regression (that was backported to stable kernel), it should have a
Fixes tag and probably a cc:stable.

See also https://github.com/Freescale/linux-fslc/commit/a682d463667a418d3f7277dbbe06cd6347e76761

Francesco

