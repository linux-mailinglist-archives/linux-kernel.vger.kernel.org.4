Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4B6829BD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjAaJ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjAaJ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:56:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17429485A7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:56:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0BF0B818F2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4DFC433D2;
        Tue, 31 Jan 2023 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675158993;
        bh=CNpHBV8fARL4DxufglIZZd8suRzDMrdyrj+VoyDBHtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzFgUkp1sgTYubRnhxECR7ULA8m942SMYgYEOrEoHc39tXSYHMLALrRHAaaexVu0n
         1oxJFTW7RqOiQ82dj5mzo9SJ7vpgrO6oDo62V6NVRxd9NTSB0CPniLH280ukpEO9yF
         LrAX6HoN89ZThOQrEPA+m/P9PtgW0lpmeWW5iYR0=
Date:   Tue, 31 Jan 2023 10:56:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yan Cangang <nalanzeyu@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty:pty: move wake_up*() after tty_vhangup() in
 pty_close()
Message-ID: <Y9jlzjbEGMe/KM55@kroah.com>
References: <20230127072017.2146403-1-nalanzeyu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127072017.2146403-1-nalanzeyu@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 03:20:17PM +0800, Yan Cangang wrote:
> wake_up_interruptible() may wake up the session leader blocked on pts, at
> this time the tty_signal_session_leader() in __tty_hangup() has not been
> executed.
> 
> The session leader's subsequent IO on pts will fail, but the session
> leader did not received SIGHUP as expected at this time.
> 
> A observed phenomenon is that when the ssh connection is disconnected, the
> background jobs managed by bash did not terminate as expected. This
> problem is more easily observed on low-end single-processor systems.

This feels odd, why is this only showing up now?  What changed to cause
this issue?

What commit id does this fix?

thanks,

greg k-h
